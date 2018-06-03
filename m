Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeFCM21 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeFCM2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 20/29] objtool: sync up with the 4.14.47 version of objtool
Date: Sun,  3 Jun 2018 14:26:43 +0200
Message-Id: <20180603122652.17453-21-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are pros and cons of dealing with tools in the kernel directory.
The pros are the fact that development happens fast, and new features
can be added to the kernel and the tools at the same times.  The cons
are when dealing with backported kernel patches, it can be necessary to
backport parts of the tool changes as well.

For 4.9.y so far, we have backported individual patches.  That quickly
breaks down when there are minor differences between how backports were
handled, so grabbing 40+ patch long series can be difficult, not
impossible, but really frustrating to attempt.

To help mitigate this mess, here's a single big patch to sync up the
objtool logic to the 4.14.47 version of the tool.  From this point
forward (after some other minor header file patches are applied), the
tool should be in sync and much easier to maintain over time.

This has survivied my limited testing, and as the codebase is identical
to 4.14.47, I'm pretty comfortable dropping this big change in here in
4.9.y.  Hopefully all goes well...

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/orc_types.h              |  107 ++
 arch/x86/include/asm/unwind_hints.h           |  103 ++
 tools/objtool/Build                           |    3 +
 .../Documentation/stack-validation.txt        |  195 +--
 tools/objtool/Makefile                        |   35 +-
 tools/objtool/arch.h                          |   65 +-
 tools/objtool/arch/x86/Build                  |   10 +-
 tools/objtool/arch/x86/decode.c               |  408 ++++-
 .../arch/x86/{insn => include/asm}/inat.h     |   12 +-
 .../x86/{insn => include/asm}/inat_types.h    |    0
 .../arch/x86/{insn => include/asm}/insn.h     |    2 +-
 .../objtool/arch/x86/include/asm/orc_types.h  |  107 ++
 tools/objtool/arch/x86/{insn => lib}/inat.c   |    2 +-
 tools/objtool/arch/x86/{insn => lib}/insn.c   |    4 +-
 .../arch/x86/{insn => lib}/x86-opcode-map.txt |   15 +-
 .../x86/{insn => tools}/gen-insn-attr-x86.awk |    1 +
 tools/objtool/builtin-check.c                 |    9 +-
 tools/objtool/builtin-orc.c                   |   68 +
 tools/objtool/builtin.h                       |    6 +
 tools/objtool/cfi.h                           |   55 +
 tools/objtool/check.c                         | 1329 ++++++++++++++---
 tools/objtool/check.h                         |   39 +-
 tools/objtool/elf.c                           |  284 +++-
 tools/objtool/elf.h                           |   21 +-
 tools/objtool/objtool.c                       |   12 +-
 tools/objtool/orc.h                           |   30 +
 tools/objtool/orc_dump.c                      |  213 +++
 tools/objtool/orc_gen.c                       |  221 +++
 tools/objtool/special.c                       |    6 +-
 tools/objtool/sync-check.sh                   |   29 +
 tools/objtool/warn.h                          |   10 +
 31 files changed, 2887 insertions(+), 514 deletions(-)
 create mode 100644 arch/x86/include/asm/orc_types.h
 create mode 100644 arch/x86/include/asm/unwind_hints.h
 rename tools/objtool/arch/x86/{insn => include/asm}/inat.h (95%)
 rename tools/objtool/arch/x86/{insn => include/asm}/inat_types.h (100%)
 rename tools/objtool/arch/x86/{insn => include/asm}/insn.h (99%)
 create mode 100644 tools/objtool/arch/x86/include/asm/orc_types.h
 rename tools/objtool/arch/x86/{insn => lib}/inat.c (99%)
 rename tools/objtool/arch/x86/{insn => lib}/insn.c (99%)
 rename tools/objtool/arch/x86/{insn => lib}/x86-opcode-map.txt (99%)
 rename tools/objtool/arch/x86/{insn => tools}/gen-insn-attr-x86.awk (99%)
 create mode 100644 tools/objtool/builtin-orc.c
 create mode 100644 tools/objtool/cfi.h
 create mode 100644 tools/objtool/orc.h
 create mode 100644 tools/objtool/orc_dump.c
 create mode 100644 tools/objtool/orc_gen.c
 create mode 100644 tools/objtool/sync-check.sh

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
new file mode 100644
index 000000000000..7dc777a6cb40
--- /dev/null
+++ b/arch/x86/include/asm/orc_types.h
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and BP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_DX			2
+#define ORC_REG_DI			3
+#define ORC_REG_BP			4
+#define ORC_REG_SP			5
+#define ORC_REG_R10			6
+#define ORC_REG_R13			7
+#define ORC_REG_BP_INDIRECT		8
+#define ORC_REG_SP_INDIRECT		9
+#define ORC_REG_MAX			15
+
+/*
+ * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
+ * caller's SP right before it made the call).  Used for all callable
+ * functions, i.e. all C code and all callable asm functions.
+ *
+ * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
+ * to a fully populated pt_regs from a syscall, interrupt, or exception.
+ *
+ * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
+ * points to the iret return frame.
+ *
+ * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
+ * aren't used in struct orc_entry due to size and complexity constraints.
+ * Objtool converts them to real types when it converts the hints to orc
+ * entries.
+ */
+#define ORC_TYPE_CALL			0
+#define ORC_TYPE_REGS			1
+#define ORC_TYPE_REGS_IRET		2
+#define UNWIND_HINT_TYPE_SAVE		3
+#define UNWIND_HINT_TYPE_RESTORE	4
+
+#ifndef __ASSEMBLY__
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+	unsigned	sp_reg:4;
+	unsigned	bp_reg:4;
+	unsigned	type:2;
+};
+
+/*
+ * This struct is used by asm and inline asm code to manually annotate the
+ * location of registers on the stack for the ORC unwinder.
+ *
+ * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
+ */
+struct unwind_hint {
+	u32		ip;
+	s16		sp_offset;
+	u8		sp_reg;
+	u8		type;
+};
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
new file mode 100644
index 000000000000..5e02b11c9b86
--- /dev/null
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -0,0 +1,103 @@
+#ifndef _ASM_X86_UNWIND_HINTS_H
+#define _ASM_X86_UNWIND_HINTS_H
+
+#include "orc_types.h"
+
+#ifdef __ASSEMBLY__
+
+/*
+ * In asm, there are two kinds of code: normal C-type callable functions and
+ * the rest.  The normal callable functions can be called by other code, and
+ * don't do anything unusual with the stack.  Such normal callable functions
+ * are annotated with the ENTRY/ENDPROC macros.  Most asm code falls in this
+ * category.  In this case, no special debugging annotations are needed because
+ * objtool can automatically generate the ORC data for the ORC unwinder to read
+ * at runtime.
+ *
+ * Anything which doesn't fall into the above category, such as syscall and
+ * interrupt handlers, tends to not be called directly by other functions, and
+ * often does unusual non-C-function-type things with the stack pointer.  Such
+ * code needs to be annotated such that objtool can understand it.  The
+ * following CFI hint macros are for this type of code.
+ *
+ * These macros provide hints to objtool about the state of the stack at each
+ * instruction.  Objtool starts from the hints and follows the code flow,
+ * making automatic CFI adjustments when it sees pushes and pops, filling out
+ * the debuginfo as necessary.  It will also warn if it sees any
+ * inconsistencies.
+ */
+.macro UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=0 type=ORC_TYPE_CALL
+#ifdef CONFIG_STACK_VALIDATION
+.Lunwind_hint_ip_\@:
+	.pushsection .discard.unwind_hints
+		/* struct unwind_hint */
+		.long .Lunwind_hint_ip_\@ - .
+		.short \sp_offset
+		.byte \sp_reg
+		.byte \type
+	.popsection
+#endif
+.endm
+
+.macro UNWIND_HINT_EMPTY
+	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED
+.endm
+
+.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 iret=0
+	.if \base == %rsp && \indirect
+		.set sp_reg, ORC_REG_SP_INDIRECT
+	.elseif \base == %rsp
+		.set sp_reg, ORC_REG_SP
+	.elseif \base == %rbp
+		.set sp_reg, ORC_REG_BP
+	.elseif \base == %rdi
+		.set sp_reg, ORC_REG_DI
+	.elseif \base == %rdx
+		.set sp_reg, ORC_REG_DX
+	.elseif \base == %r10
+		.set sp_reg, ORC_REG_R10
+	.else
+		.error "UNWIND_HINT_REGS: bad base register"
+	.endif
+
+	.set sp_offset, \offset
+
+	.if \iret
+		.set type, ORC_TYPE_REGS_IRET
+	.elseif \extra == 0
+		.set type, ORC_TYPE_REGS_IRET
+		.set sp_offset, \offset + (16*8)
+	.else
+		.set type, ORC_TYPE_REGS
+	.endif
+
+	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type
+.endm
+
+.macro UNWIND_HINT_IRET_REGS base=%rsp offset=0
+	UNWIND_HINT_REGS base=\base offset=\offset iret=1
+.endm
+
+.macro UNWIND_HINT_FUNC sp_offset=8
+	UNWIND_HINT sp_offset=\sp_offset
+.endm
+
+#else /* !__ASSEMBLY__ */
+
+#define UNWIND_HINT(sp_reg, sp_offset, type)			\
+	"987: \n\t"						\
+	".pushsection .discard.unwind_hints\n\t"		\
+	/* struct unwind_hint */				\
+	".long 987b - .\n\t"					\
+	".short " __stringify(sp_offset) "\n\t"		\
+	".byte " __stringify(sp_reg) "\n\t"			\
+	".byte " __stringify(type) "\n\t"			\
+	".popsection\n\t"
+
+#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE)
+
+#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 6f2e1987c4d9..749becdf5b90 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,6 +1,9 @@
 objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
+objtool-y += builtin-orc.o
 objtool-y += check.o
+objtool-y += orc_gen.o
+objtool-y += orc_dump.o
 objtool-y += elf.o
 objtool-y += special.o
 objtool-y += objtool.o
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 55a60d331f47..3995735a878f 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -11,9 +11,6 @@ analyzes every .o file and ensures the validity of its stack metadata.
 It enforces a set of rules on asm code and C inline assembly code so
 that stack traces can be reliable.
 
-Currently it only checks frame pointer usage, but there are plans to add
-CFI validation for C files and CFI generation for asm files.
-
 For each function, it recursively follows all possible code paths and
 validates the correct frame pointer state at each instruction.
 
@@ -23,6 +20,10 @@ alternative execution paths to a given instruction (or set of
 instructions).  Similarly, it knows how to follow switch statements, for
 which gcc sometimes uses jump tables.
 
+(Objtool also has an 'orc generate' subcommand which generates debuginfo
+for the ORC unwinder.  See Documentation/x86/orc-unwinder.txt in the
+kernel tree for more details.)
+
 
 Why do we need stack metadata validation?
 -----------------------------------------
@@ -93,62 +94,24 @@ a) More reliable stack traces for frame pointer enabled kernels
        or at the very end of the function after the stack frame has been
        destroyed.  This is an inherent limitation of frame pointers.
 
-b) 100% reliable stack traces for DWARF enabled kernels
-
-   (NOTE: This is not yet implemented)
-
-   As an alternative to frame pointers, DWARF Call Frame Information
-   (CFI) metadata can be used to walk the stack.  Unlike frame pointers,
-   CFI metadata is out of band.  So it doesn't affect runtime
-   performance and it can be reliable even when interrupts or exceptions
-   are involved.
-
-   For C code, gcc automatically generates DWARF CFI metadata.  But for
-   asm code, generating CFI is a tedious manual approach which requires
-   manually placed .cfi assembler macros to be scattered throughout the
-   code.  It's clumsy and very easy to get wrong, and it makes the real
-   code harder to read.
-
-   Stacktool will improve this situation in several ways.  For code
-   which already has CFI annotations, it will validate them.  For code
-   which doesn't have CFI annotations, it will generate them.  So an
-   architecture can opt to strip out all the manual .cfi annotations
-   from their asm code and have objtool generate them instead.
+b) ORC (Oops Rewind Capability) unwind table generation
 
-   We might also add a runtime stack validation debug option where we
-   periodically walk the stack from schedule() and/or an NMI to ensure
-   that the stack metadata is sane and that we reach the bottom of the
-   stack.
+   An alternative to frame pointers and DWARF, ORC unwind data can be
+   used to walk the stack.  Unlike frame pointers, ORC data is out of
+   band.  So it doesn't affect runtime performance and it can be
+   reliable even when interrupts or exceptions are involved.
 
-   So the benefit of objtool here will be that external tooling should
-   always show perfect stack traces.  And the same will be true for
-   kernel warning/oops traces if the architecture has a runtime DWARF
-   unwinder.
+   For more details, see Documentation/x86/orc-unwinder.txt.
 
 c) Higher live patching compatibility rate
 
-   (NOTE: This is not yet implemented)
-
-   Currently with CONFIG_LIVEPATCH there's a basic live patching
-   framework which is safe for roughly 85-90% of "security" fixes.  But
-   patches can't have complex features like function dependency or
-   prototype changes, or data structure changes.
-
-   There's a strong need to support patches which have the more complex
-   features so that the patch compatibility rate for security fixes can
-   eventually approach something resembling 100%.  To achieve that, a
-   "consistency model" is needed, which allows tasks to be safely
-   transitioned from an unpatched state to a patched state.
-
-   One of the key requirements of the currently proposed livepatch
-   consistency model [*] is that it needs to walk the stack of each
-   sleeping task to determine if it can be transitioned to the patched
-   state.  If objtool can ensure that stack traces are reliable, this
-   consistency model can be used and the live patching compatibility
-   rate can be improved significantly.
-
-   [*] https://lkml.kernel.org/r/cover.1423499826.git.jpoimboe@redhat.com
+   Livepatch has an optional "consistency model", which is needed for
+   more complex patches.  In order for the consistency model to work,
+   stack traces need to be reliable (or an unreliable condition needs to
+   be detectable).  Objtool makes that possible.
 
+   For more details, see the livepatch documentation in the Linux kernel
+   source tree at Documentation/livepatch/livepatch.txt.
 
 Rules
 -----
@@ -201,80 +164,84 @@ To achieve the validation, objtool enforces the following rules:
    return normally.
 
 
-Errors in .S files
-------------------
+Objtool warnings
+----------------
+
+For asm files, if you're getting an error which doesn't make sense,
+first make sure that the affected code follows the above rules.
 
-If you're getting an error in a compiled .S file which you don't
-understand, first make sure that the affected code follows the above
-rules.
+For C files, the common culprits are inline asm statements and calls to
+"noreturn" functions.  See below for more details.
+
+Another possible cause for errors in C code is if the Makefile removes
+-fno-omit-frame-pointer or adds -fomit-frame-pointer to the gcc options.
 
 Here are some examples of common warnings reported by objtool, what
 they mean, and suggestions for how to fix them.
 
 
-1. asm_file.o: warning: objtool: func()+0x128: call without frame pointer save/setup
+1. file.o: warning: objtool: func()+0x128: call without frame pointer save/setup
 
    The func() function made a function call without first saving and/or
-   updating the frame pointer.
-
-   If func() is indeed a callable function, add proper frame pointer
-   logic using the FRAME_BEGIN and FRAME_END macros.  Otherwise, remove
-   its ELF function annotation by changing ENDPROC to END.
-
-   If you're getting this error in a .c file, see the "Errors in .c
-   files" section.
+   updating the frame pointer, and CONFIG_FRAME_POINTER is enabled.
 
+   If the error is for an asm file, and func() is indeed a callable
+   function, add proper frame pointer logic using the FRAME_BEGIN and
+   FRAME_END macros.  Otherwise, if it's not a callable function, remove
+   its ELF function annotation by changing ENDPROC to END, and instead
+   use the manual unwind hint macros in asm/unwind_hints.h.
 
-2. asm_file.o: warning: objtool: .text+0x53: return instruction outside of a callable function
+   If it's a GCC-compiled .c file, the error may be because the function
+   uses an inline asm() statement which has a "call" instruction.  An
+   asm() statement with a call instruction must declare the use of the
+   stack pointer in its output operand.  On x86_64, this means adding
+   the ASM_CALL_CONSTRAINT as an output constraint:
 
-   A return instruction was detected, but objtool couldn't find a way
-   for a callable function to reach the instruction.
+     asm volatile("call func" : ASM_CALL_CONSTRAINT);
 
-   If the return instruction is inside (or reachable from) a callable
-   function, the function needs to be annotated with the ENTRY/ENDPROC
-   macros.
+   Otherwise the stack frame may not get created before the call.
 
-   If you _really_ need a return instruction outside of a function, and
-   are 100% sure that it won't affect stack traces, you can tell
-   objtool to ignore it.  See the "Adding exceptions" section below.
 
+2. file.o: warning: objtool: .text+0x53: unreachable instruction
 
-3. asm_file.o: warning: objtool: func()+0x9: function has unreachable instruction
+   Objtool couldn't find a code path to reach the instruction.
 
-   The instruction lives inside of a callable function, but there's no
-   possible control flow path from the beginning of the function to the
-   instruction.
+   If the error is for an asm file, and the instruction is inside (or
+   reachable from) a callable function, the function should be annotated
+   with the ENTRY/ENDPROC macros (ENDPROC is the important one).
+   Otherwise, the code should probably be annotated with the unwind hint
+   macros in asm/unwind_hints.h so objtool and the unwinder can know the
+   stack state associated with the code.
 
-   If the instruction is actually needed, and it's actually in a
-   callable function, ensure that its function is properly annotated
-   with ENTRY/ENDPROC.
+   If you're 100% sure the code won't affect stack traces, or if you're
+   a just a bad person, you can tell objtool to ignore it.  See the
+   "Adding exceptions" section below.
 
    If it's not actually in a callable function (e.g. kernel entry code),
    change ENDPROC to END.
 
 
-4. asm_file.o: warning: objtool: func(): can't find starting instruction
+4. file.o: warning: objtool: func(): can't find starting instruction
    or
-   asm_file.o: warning: objtool: func()+0x11dd: can't decode instruction
+   file.o: warning: objtool: func()+0x11dd: can't decode instruction
 
-   Did you put data in a text section?  If so, that can confuse
+   Does the file have data in a text section?  If so, that can confuse
    objtool's instruction decoder.  Move the data to a more appropriate
    section like .data or .rodata.
 
 
-5. asm_file.o: warning: objtool: func()+0x6: kernel entry/exit from callable instruction
-
-   This is a kernel entry/exit instruction like sysenter or sysret.
-   Such instructions aren't allowed in a callable function, and are most
-   likely part of the kernel entry code.
+5. file.o: warning: objtool: func()+0x6: unsupported instruction in callable function
 
-   If the instruction isn't actually in a callable function, change
-   ENDPROC to END.
+   This is a kernel entry/exit instruction like sysenter or iret.  Such
+   instructions aren't allowed in a callable function, and are most
+   likely part of the kernel entry code.  They should usually not have
+   the callable function annotation (ENDPROC) and should always be
+   annotated with the unwind hint macros in asm/unwind_hints.h.
 
 
-6. asm_file.o: warning: objtool: func()+0x26: sibling call from callable instruction with changed frame pointer
+6. file.o: warning: objtool: func()+0x26: sibling call from callable instruction with modified stack frame
 
-   This is a dynamic jump or a jump to an undefined symbol.  Stacktool
+   This is a dynamic jump or a jump to an undefined symbol.  Objtool
    assumed it's a sibling call and detected that the frame pointer
    wasn't first restored to its original state.
 
@@ -282,24 +249,28 @@ they mean, and suggestions for how to fix them.
    destination code to the local file.
 
    If the instruction is not actually in a callable function (e.g.
-   kernel entry code), change ENDPROC to END.
+   kernel entry code), change ENDPROC to END and annotate manually with
+   the unwind hint macros in asm/unwind_hints.h.
 
 
-7. asm_file: warning: objtool: func()+0x5c: frame pointer state mismatch
+7. file: warning: objtool: func()+0x5c: stack state mismatch
 
    The instruction's frame pointer state is inconsistent, depending on
    which execution path was taken to reach the instruction.
 
-   Make sure the function pushes and sets up the frame pointer (for
-   x86_64, this means rbp) at the beginning of the function and pops it
-   at the end of the function.  Also make sure that no other code in the
-   function touches the frame pointer.
+   Make sure that, when CONFIG_FRAME_POINTER is enabled, the function
+   pushes and sets up the frame pointer (for x86_64, this means rbp) at
+   the beginning of the function and pops it at the end of the function.
+   Also make sure that no other code in the function touches the frame
+   pointer.
 
+   Another possibility is that the code has some asm or inline asm which
+   does some unusual things to the stack or the frame pointer.  In such
+   cases it's probably appropriate to use the unwind hint macros in
+   asm/unwind_hints.h.
 
-Errors in .c files
-------------------
 
-1. c_file.o: warning: objtool: funcA() falls through to next function funcB()
+8. file.o: warning: objtool: funcA() falls through to next function funcB()
 
    This means that funcA() doesn't end with a return instruction or an
    unconditional jump, and that objtool has determined that the function
@@ -318,22 +289,6 @@ Errors in .c files
       might be corrupt due to a gcc bug.  For more details, see:
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
-2. If you're getting any other objtool error in a compiled .c file, it
-   may be because the file uses an asm() statement which has a "call"
-   instruction.  An asm() statement with a call instruction must declare
-   the use of the stack pointer in its output operand.  For example, on
-   x86_64:
-
-     register void *__sp asm("rsp");
-     asm volatile("call func" : "+r" (__sp));
-
-   Otherwise the stack frame may not get created before the call.
-
-3. Another possible cause for errors in C code is if the Makefile removes
-   -fno-omit-frame-pointer or adds -fomit-frame-pointer to the gcc options.
-
-Also see the above section for .S file errors for more information what
-the individual error messages mean.
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 041b493ad3ab..e6acc281dd37 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
 
@@ -6,17 +7,19 @@ ARCH := x86
 endif
 
 # always use the host compiler
-CC = gcc
-LD = ld
-AR = ar
+HOSTCC	?= gcc
+HOSTLD	?= ld
+CC	 = $(HOSTCC)
+LD	 = $(HOSTLD)
+AR	 = ar
 
 ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
 SUBCMD_SRCDIR		= $(srctree)/tools/lib/subcmd/
-LIBSUBCMD_OUTPUT	= $(if $(OUTPUT),$(OUTPUT),$(PWD)/)
+LIBSUBCMD_OUTPUT	= $(if $(OUTPUT),$(OUTPUT),$(CURDIR)/)
 LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
 
 OBJTOOL    := $(OUTPUT)objtool
@@ -24,8 +27,11 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
 
 all: $(OBJTOOL)
 
-INCLUDES := -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi
-CFLAGS   += -Wall -Werror $(EXTRA_WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
+INCLUDES := -I$(srctree)/tools/include \
+	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
+	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
+WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
+CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
 LDFLAGS  += -lelf $(LIBSUBCMD)
 
 # Allow old libelf to be used:
@@ -39,19 +45,8 @@ include $(srctree)/tools/build/Makefile.include
 $(OBJTOOL_IN): fixdep FORCE
 	@$(MAKE) $(build)=objtool
 
-# Busybox's diff doesn't have -I, avoid warning in that case
-#
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	@(diff -I 2>&1 | grep -q 'option requires an argument' && \
-	test -d ../../kernel -a -d ../../tools -a -d ../objtool && (( \
-	diff -I'^#include' arch/x86/insn/insn.c ../../arch/x86/lib/insn.c >/dev/null && \
-	diff -I'^#include' arch/x86/insn/inat.c ../../arch/x86/lib/inat.c >/dev/null && \
-	diff arch/x86/insn/x86-opcode-map.txt ../../arch/x86/lib/x86-opcode-map.txt >/dev/null && \
-	diff arch/x86/insn/gen-insn-attr-x86.awk ../../arch/x86/tools/gen-insn-attr-x86.awk >/dev/null && \
-	diff -I'^#include' arch/x86/insn/insn.h ../../arch/x86/include/asm/insn.h >/dev/null && \
-	diff -I'^#include' arch/x86/insn/inat.h ../../arch/x86/include/asm/inat.h >/dev/null && \
-	diff -I'^#include' arch/x86/insn/inat_types.h ../../arch/x86/include/asm/inat_types.h >/dev/null) \
-	|| echo "warning: objtool: x86 instruction decoder differs from kernel" >&2 )) || true
+	@$(CONFIG_SHELL) ./sync-check.sh
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
@@ -61,7 +56,7 @@ $(LIBSUBCMD): fixdep FORCE
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/insn/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 
 FORCE:
 
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index a59e061c0b4a..b0d7dc3d71b5 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -19,25 +19,64 @@
 #define _ARCH_H
 
 #include <stdbool.h>
+#include <linux/list.h>
 #include "elf.h"
+#include "cfi.h"
 
-#define INSN_FP_SAVE		1
-#define INSN_FP_SETUP		2
-#define INSN_FP_RESTORE		3
-#define INSN_JUMP_CONDITIONAL	4
-#define INSN_JUMP_UNCONDITIONAL	5
-#define INSN_JUMP_DYNAMIC	6
-#define INSN_CALL		7
-#define INSN_CALL_DYNAMIC	8
-#define INSN_RETURN		9
-#define INSN_CONTEXT_SWITCH	10
-#define INSN_NOP		11
-#define INSN_OTHER		12
+#define INSN_JUMP_CONDITIONAL	1
+#define INSN_JUMP_UNCONDITIONAL	2
+#define INSN_JUMP_DYNAMIC	3
+#define INSN_CALL		4
+#define INSN_CALL_DYNAMIC	5
+#define INSN_RETURN		6
+#define INSN_CONTEXT_SWITCH	7
+#define INSN_STACK		8
+#define INSN_BUG		9
+#define INSN_NOP		10
+#define INSN_OTHER		11
 #define INSN_LAST		INSN_OTHER
 
+enum op_dest_type {
+	OP_DEST_REG,
+	OP_DEST_REG_INDIRECT,
+	OP_DEST_MEM,
+	OP_DEST_PUSH,
+	OP_DEST_LEAVE,
+};
+
+struct op_dest {
+	enum op_dest_type type;
+	unsigned char reg;
+	int offset;
+};
+
+enum op_src_type {
+	OP_SRC_REG,
+	OP_SRC_REG_INDIRECT,
+	OP_SRC_CONST,
+	OP_SRC_POP,
+	OP_SRC_ADD,
+	OP_SRC_AND,
+};
+
+struct op_src {
+	enum op_src_type type;
+	unsigned char reg;
+	int offset;
+};
+
+struct stack_op {
+	struct op_dest dest;
+	struct op_src src;
+};
+
+void arch_initial_func_cfi_state(struct cfi_state *state);
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, unsigned char *type,
-			    unsigned long *displacement);
+			    unsigned long *immediate, struct stack_op *op);
+
+bool arch_callee_saved_reg(unsigned char reg);
 
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index debbdb0b5c43..b998412c017d 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,12 +1,12 @@
 objtool-y += decode.o
 
-inat_tables_script = arch/x86/insn/gen-insn-attr-x86.awk
-inat_tables_maps = arch/x86/insn/x86-opcode-map.txt
+inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
 
-$(OUTPUT)arch/x86/insn/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
+$(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@
 
-$(OUTPUT)arch/x86/decode.o: $(OUTPUT)arch/x86/insn/inat-tables.c
+$(OUTPUT)arch/x86/decode.o: $(OUTPUT)arch/x86/lib/inat-tables.c
 
-CFLAGS_decode.o += -I$(OUTPUT)arch/x86/insn
+CFLAGS_decode.o += -I$(OUTPUT)arch/x86/lib
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 6ac99e3266eb..540a209b78ab 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -19,14 +19,25 @@
 #include <stdlib.h>
 
 #define unlikely(cond) (cond)
-#include "insn/insn.h"
-#include "insn/inat.c"
-#include "insn/insn.c"
+#include <asm/insn.h>
+#include "lib/inat.c"
+#include "lib/insn.c"
 
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
 
+static unsigned char op_to_cfi_reg[][2] = {
+	{CFI_AX, CFI_R8},
+	{CFI_CX, CFI_R9},
+	{CFI_DX, CFI_R10},
+	{CFI_BX, CFI_R11},
+	{CFI_SP, CFI_R12},
+	{CFI_BP, CFI_R13},
+	{CFI_SI, CFI_R14},
+	{CFI_DI, CFI_R15},
+};
+
 static int is_x86_64(struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
@@ -40,24 +51,50 @@ static int is_x86_64(struct elf *elf)
 	}
 }
 
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case CFI_BP:
+	case CFI_BX:
+	case CFI_R12:
+	case CFI_R13:
+	case CFI_R14:
+	case CFI_R15:
+		return true;
+
+	case CFI_AX:
+	case CFI_CX:
+	case CFI_DX:
+	case CFI_SI:
+	case CFI_DI:
+	case CFI_SP:
+	case CFI_R8:
+	case CFI_R9:
+	case CFI_R10:
+	case CFI_R11:
+	case CFI_RA:
+	default:
+		return false;
+	}
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, unsigned char *type,
-			    unsigned long *immediate)
+			    unsigned long *immediate, struct stack_op *op)
 {
 	struct insn insn;
-	int x86_64;
-	unsigned char op1, op2, ext;
+	int x86_64, sign;
+	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
+		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
+		      modrm_reg = 0, sib = 0;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
 		return -1;
 
-	insn_init(&insn, (void *)(sec->data + offset), maxlen, x86_64);
+	insn_init(&insn, sec->data->d_buf + offset, maxlen, x86_64);
 	insn_get_length(&insn);
-	insn_get_opcode(&insn);
-	insn_get_modrm(&insn);
-	insn_get_immediate(&insn);
 
 	if (!insn_complete(&insn)) {
 		WARN_FUNC("can't decode instruction", sec, offset);
@@ -73,67 +110,317 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
 
+	if (insn.rex_prefix.nbytes) {
+		rex = insn.rex_prefix.bytes[0];
+		rex_w = X86_REX_W(rex) >> 3;
+		rex_r = X86_REX_R(rex) >> 2;
+		rex_x = X86_REX_X(rex) >> 1;
+		rex_b = X86_REX_B(rex);
+	}
+
+	if (insn.modrm.nbytes) {
+		modrm = insn.modrm.bytes[0];
+		modrm_mod = X86_MODRM_MOD(modrm);
+		modrm_reg = X86_MODRM_REG(modrm);
+		modrm_rm = X86_MODRM_RM(modrm);
+	}
+
+	if (insn.sib.nbytes)
+		sib = insn.sib.bytes[0];
+
 	switch (op1) {
-	case 0x55:
-		if (!insn.rex_prefix.nbytes)
-			/* push rbp */
-			*type = INSN_FP_SAVE;
+
+	case 0x1:
+	case 0x29:
+		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
+
+			/* add/sub reg, %rsp */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_ADD;
+			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+		}
+		break;
+
+	case 0x50 ... 0x57:
+
+		/* push reg */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_REG;
+		op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+		op->dest.type = OP_DEST_PUSH;
+
+		break;
+
+	case 0x58 ... 0x5f:
+
+		/* pop reg */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_POP;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+
 		break;
 
-	case 0x5d:
-		if (!insn.rex_prefix.nbytes)
-			/* pop rbp */
-			*type = INSN_FP_RESTORE;
+	case 0x68:
+	case 0x6a:
+		/* push immediate */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_CONST;
+		op->dest.type = OP_DEST_PUSH;
 		break;
 
 	case 0x70 ... 0x7f:
 		*type = INSN_JUMP_CONDITIONAL;
 		break;
 
+	case 0x81:
+	case 0x83:
+		if (rex != 0x48)
+			break;
+
+		if (modrm == 0xe4) {
+			/* and imm, %rsp */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_AND;
+			op->src.reg = CFI_SP;
+			op->src.offset = insn.immediate.value;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+			break;
+		}
+
+		if (modrm == 0xc4)
+			sign = 1;
+		else if (modrm == 0xec)
+			sign = -1;
+		else
+			break;
+
+		/* add/sub imm, %rsp */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_ADD;
+		op->src.reg = CFI_SP;
+		op->src.offset = insn.immediate.value * sign;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = CFI_SP;
+		break;
+
 	case 0x89:
-		if (insn.rex_prefix.nbytes == 1 &&
-		    insn.rex_prefix.bytes[0] == 0x48 &&
-		    insn.modrm.nbytes && insn.modrm.bytes[0] == 0xe5)
-			/* mov rsp, rbp */
-			*type = INSN_FP_SETUP;
+		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
+
+			/* mov %rsp, reg */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_REG;
+			op->src.reg = CFI_SP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			break;
+		}
+
+		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
+
+			/* mov reg, %rsp */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_REG;
+			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+			break;
+		}
+
+		/* fallthrough */
+	case 0x88:
+		if (!rex_b &&
+		    (modrm_mod == 1 || modrm_mod == 2) && modrm_rm == 5) {
+
+			/* mov reg, disp(%rbp) */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_REG;
+			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			op->dest.type = OP_DEST_REG_INDIRECT;
+			op->dest.reg = CFI_BP;
+			op->dest.offset = insn.displacement.value;
+
+		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+
+			/* mov reg, disp(%rsp) */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_REG;
+			op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			op->dest.type = OP_DEST_REG_INDIRECT;
+			op->dest.reg = CFI_SP;
+			op->dest.offset = insn.displacement.value;
+		}
+
+		break;
+
+	case 0x8b:
+		if (rex_w && !rex_b && modrm_mod == 1 && modrm_rm == 5) {
+
+			/* mov disp(%rbp), reg */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_REG_INDIRECT;
+			op->src.reg = CFI_BP;
+			op->src.offset = insn.displacement.value;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+
+		} else if (rex_w && !rex_b && sib == 0x24 &&
+			   modrm_mod != 3 && modrm_rm == 4) {
+
+			/* mov disp(%rsp), reg */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_REG_INDIRECT;
+			op->src.reg = CFI_SP;
+			op->src.offset = insn.displacement.value;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+		}
+
 		break;
 
 	case 0x8d:
-		if (insn.rex_prefix.nbytes &&
-		    insn.rex_prefix.bytes[0] == 0x48 &&
-		    insn.modrm.nbytes && insn.modrm.bytes[0] == 0x2c &&
-		    insn.sib.nbytes && insn.sib.bytes[0] == 0x24)
-			/* lea %(rsp), %rbp */
-			*type = INSN_FP_SETUP;
+		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
+
+			*type = INSN_STACK;
+			if (!insn.displacement.value) {
+				/* lea (%rsp), reg */
+				op->src.type = OP_SRC_REG;
+			} else {
+				/* lea disp(%rsp), reg */
+				op->src.type = OP_SRC_ADD;
+				op->src.offset = insn.displacement.value;
+			}
+			op->src.reg = CFI_SP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+
+		} else if (rex == 0x48 && modrm == 0x65) {
+
+			/* lea disp(%rbp), %rsp */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_ADD;
+			op->src.reg = CFI_BP;
+			op->src.offset = insn.displacement.value;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+
+		} else if (rex == 0x49 && modrm == 0x62 &&
+			   insn.displacement.value == -8) {
+
+			/*
+			 * lea -0x8(%r10), %rsp
+			 *
+			 * Restoring rsp back to its original value after a
+			 * stack realignment.
+			 */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_ADD;
+			op->src.reg = CFI_R10;
+			op->src.offset = -8;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+
+		} else if (rex == 0x49 && modrm == 0x65 &&
+			   insn.displacement.value == -16) {
+
+			/*
+			 * lea -0x10(%r13), %rsp
+			 *
+			 * Restoring rsp back to its original value after a
+			 * stack realignment.
+			 */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_ADD;
+			op->src.reg = CFI_R13;
+			op->src.offset = -16;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+		}
+
+		break;
+
+	case 0x8f:
+		/* pop to mem */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_POP;
+		op->dest.type = OP_DEST_MEM;
 		break;
 
 	case 0x90:
 		*type = INSN_NOP;
 		break;
 
+	case 0x9c:
+		/* pushf */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_CONST;
+		op->dest.type = OP_DEST_PUSH;
+		break;
+
+	case 0x9d:
+		/* popf */
+		*type = INSN_STACK;
+		op->src.type = OP_SRC_POP;
+		op->dest.type = OP_DEST_MEM;
+		break;
+
 	case 0x0f:
-		if (op2 >= 0x80 && op2 <= 0x8f)
+
+		if (op2 >= 0x80 && op2 <= 0x8f) {
+
 			*type = INSN_JUMP_CONDITIONAL;
-		else if (op2 == 0x05 || op2 == 0x07 || op2 == 0x34 ||
-			 op2 == 0x35)
+
+		} else if (op2 == 0x05 || op2 == 0x07 || op2 == 0x34 ||
+			   op2 == 0x35) {
+
 			/* sysenter, sysret */
 			*type = INSN_CONTEXT_SWITCH;
-		else if (op2 == 0x0d || op2 == 0x1f)
+
+		} else if (op2 == 0x0b || op2 == 0xb9) {
+
+			/* ud2 */
+			*type = INSN_BUG;
+
+		} else if (op2 == 0x0d || op2 == 0x1f) {
+
 			/* nopl/nopw */
 			*type = INSN_NOP;
-		else if (op2 == 0x01 && insn.modrm.nbytes &&
-			 (insn.modrm.bytes[0] == 0xc2 ||
-			  insn.modrm.bytes[0] == 0xd8))
-			/* vmlaunch, vmrun */
-			*type = INSN_CONTEXT_SWITCH;
+
+		} else if (op2 == 0xa0 || op2 == 0xa8) {
+
+			/* push fs/gs */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSH;
+
+		} else if (op2 == 0xa1 || op2 == 0xa9) {
+
+			/* pop fs/gs */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_POP;
+			op->dest.type = OP_DEST_MEM;
+		}
 
 		break;
 
-	case 0xc9: /* leave */
-		*type = INSN_FP_RESTORE;
+	case 0xc9:
+		/*
+		 * leave
+		 *
+		 * equivalent to:
+		 * mov bp, sp
+		 * pop bp
+		 */
+		*type = INSN_STACK;
+		op->dest.type = OP_DEST_LEAVE;
+
 		break;
 
-	case 0xe3: /* jecxz/jrcxz */
+	case 0xe3:
+		/* jecxz/jrcxz */
 		*type = INSN_JUMP_CONDITIONAL;
 		break;
 
@@ -158,14 +445,27 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 		break;
 
 	case 0xff:
-		ext = X86_MODRM_REG(insn.modrm.bytes[0]);
-		if (ext == 2 || ext == 3)
+		if (modrm_reg == 2 || modrm_reg == 3)
+
 			*type = INSN_CALL_DYNAMIC;
-		else if (ext == 4)
+
+		else if (modrm_reg == 4)
+
 			*type = INSN_JUMP_DYNAMIC;
-		else if (ext == 5) /*jmpf */
+
+		else if (modrm_reg == 5)
+
+			/* jmpf */
 			*type = INSN_CONTEXT_SWITCH;
 
+		else if (modrm_reg == 6) {
+
+			/* push from mem */
+			*type = INSN_STACK;
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSH;
+		}
+
 		break;
 
 	default:
@@ -176,3 +476,21 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	return 0;
 }
+
+void arch_initial_func_cfi_state(struct cfi_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 8;
+
+	/* initial RA (return address) */
+	state->regs[16].base = CFI_CFA;
+	state->regs[16].offset = -8;
+}
diff --git a/tools/objtool/arch/x86/insn/inat.h b/tools/objtool/arch/x86/include/asm/inat.h
similarity index 95%
rename from tools/objtool/arch/x86/insn/inat.h
rename to tools/objtool/arch/x86/include/asm/inat.h
index 125ecd2a300d..1c78580e58be 100644
--- a/tools/objtool/arch/x86/insn/inat.h
+++ b/tools/objtool/arch/x86/include/asm/inat.h
@@ -20,7 +20,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
  */
-#include "inat_types.h"
+#include <asm/inat_types.h>
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
@@ -97,6 +97,16 @@
 #define INAT_MAKE_GROUP(grp)	((grp << INAT_GRP_OFFS) | INAT_MODRM)
 #define INAT_MAKE_IMM(imm)	(imm << INAT_IMM_OFFS)
 
+/* Identifiers for segment registers */
+#define INAT_SEG_REG_IGNORE	0
+#define INAT_SEG_REG_DEFAULT	1
+#define INAT_SEG_REG_CS		2
+#define INAT_SEG_REG_SS		3
+#define INAT_SEG_REG_DS		4
+#define INAT_SEG_REG_ES		5
+#define INAT_SEG_REG_FS		6
+#define INAT_SEG_REG_GS		7
+
 /* Attribute search APIs */
 extern insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode);
 extern int inat_get_last_prefix_id(insn_byte_t last_pfx);
diff --git a/tools/objtool/arch/x86/insn/inat_types.h b/tools/objtool/arch/x86/include/asm/inat_types.h
similarity index 100%
rename from tools/objtool/arch/x86/insn/inat_types.h
rename to tools/objtool/arch/x86/include/asm/inat_types.h
diff --git a/tools/objtool/arch/x86/insn/insn.h b/tools/objtool/arch/x86/include/asm/insn.h
similarity index 99%
rename from tools/objtool/arch/x86/insn/insn.h
rename to tools/objtool/arch/x86/include/asm/insn.h
index e23578c7b1be..b3e32b010ab1 100644
--- a/tools/objtool/arch/x86/insn/insn.h
+++ b/tools/objtool/arch/x86/include/asm/insn.h
@@ -21,7 +21,7 @@
  */
 
 /* insn_attr_t is defined in inat.h */
-#include "inat.h"
+#include <asm/inat.h>
 
 struct insn_field {
 	union {
diff --git a/tools/objtool/arch/x86/include/asm/orc_types.h b/tools/objtool/arch/x86/include/asm/orc_types.h
new file mode 100644
index 000000000000..9c9dc579bd7d
--- /dev/null
+++ b/tools/objtool/arch/x86/include/asm/orc_types.h
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and BP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_DX			2
+#define ORC_REG_DI			3
+#define ORC_REG_BP			4
+#define ORC_REG_SP			5
+#define ORC_REG_R10			6
+#define ORC_REG_R13			7
+#define ORC_REG_BP_INDIRECT		8
+#define ORC_REG_SP_INDIRECT		9
+#define ORC_REG_MAX			15
+
+/*
+ * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
+ * caller's SP right before it made the call).  Used for all callable
+ * functions, i.e. all C code and all callable asm functions.
+ *
+ * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
+ * to a fully populated pt_regs from a syscall, interrupt, or exception.
+ *
+ * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
+ * points to the iret return frame.
+ *
+ * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
+ * aren't used in struct orc_entry due to size and complexity constraints.
+ * Objtool converts them to real types when it converts the hints to orc
+ * entries.
+ */
+#define ORC_TYPE_CALL			0
+#define ORC_TYPE_REGS			1
+#define ORC_TYPE_REGS_IRET		2
+#define UNWIND_HINT_TYPE_SAVE		3
+#define UNWIND_HINT_TYPE_RESTORE	4
+
+#ifndef __ASSEMBLY__
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+	unsigned	sp_reg:4;
+	unsigned	bp_reg:4;
+	unsigned	type:2;
+} __packed;
+
+/*
+ * This struct is used by asm and inline asm code to manually annotate the
+ * location of registers on the stack for the ORC unwinder.
+ *
+ * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
+ */
+struct unwind_hint {
+	u32		ip;
+	s16		sp_offset;
+	u8		sp_reg;
+	u8		type;
+};
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/tools/objtool/arch/x86/insn/inat.c b/tools/objtool/arch/x86/lib/inat.c
similarity index 99%
rename from tools/objtool/arch/x86/insn/inat.c
rename to tools/objtool/arch/x86/lib/inat.c
index e4bf28e6f4c7..c1f01a8e9f65 100644
--- a/tools/objtool/arch/x86/insn/inat.c
+++ b/tools/objtool/arch/x86/lib/inat.c
@@ -18,7 +18,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
  */
-#include "insn.h"
+#include <asm/insn.h>
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/tools/objtool/arch/x86/insn/insn.c b/tools/objtool/arch/x86/lib/insn.c
similarity index 99%
rename from tools/objtool/arch/x86/insn/insn.c
rename to tools/objtool/arch/x86/lib/insn.c
index ca983e2bea8b..1088eb8f3a5f 100644
--- a/tools/objtool/arch/x86/insn/insn.c
+++ b/tools/objtool/arch/x86/lib/insn.c
@@ -23,8 +23,8 @@
 #else
 #include <string.h>
 #endif
-#include "inat.h"
-#include "insn.h"
+#include <asm/inat.h>
+#include <asm/insn.h>
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
diff --git a/tools/objtool/arch/x86/insn/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
similarity index 99%
rename from tools/objtool/arch/x86/insn/x86-opcode-map.txt
rename to tools/objtool/arch/x86/lib/x86-opcode-map.txt
index 1754e094bc28..e0b85930dd77 100644
--- a/tools/objtool/arch/x86/insn/x86-opcode-map.txt
+++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
@@ -607,7 +607,7 @@ fb: psubq Pq,Qq | vpsubq Vx,Hx,Wx (66),(v1)
 fc: paddb Pq,Qq | vpaddb Vx,Hx,Wx (66),(v1)
 fd: paddw Pq,Qq | vpaddw Vx,Hx,Wx (66),(v1)
 fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
-ff:
+ff: UD0
 EndTable
 
 Table: 3-byte opcode 1 (0x0f 0x38)
@@ -717,7 +717,7 @@ AVXcode: 2
 7e: vpermt2d/q Vx,Hx,Wx (66),(ev)
 7f: vpermt2ps/d Vx,Hx,Wx (66),(ev)
 80: INVEPT Gy,Mdq (66)
-81: INVPID Gy,Mdq (66)
+81: INVVPID Gy,Mdq (66)
 82: INVPCID Gy,Mdq (66)
 83: vpmultishiftqb Vx,Hx,Wx (66),(ev)
 88: vexpandps/d Vpd,Wpd (66),(ev)
@@ -970,6 +970,15 @@ GrpTable: Grp9
 EndTable
 
 GrpTable: Grp10
+# all are UD1
+0: UD1
+1: UD1
+2: UD1
+3: UD1
+4: UD1
+5: UD1
+6: UD1
+7: UD1
 EndTable
 
 # Grp11A and Grp11B are expressed as Grp11 in Intel SDM
@@ -1009,7 +1018,7 @@ GrpTable: Grp15
 1: fxstor | RDGSBASE Ry (F3),(11B)
 2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
 3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
-4: XSAVE
+4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B)
 6: XSAVEOPT | clwb (66) | mfence (11B)
 7: clflush | clflushopt (66) | sfence (11B)
diff --git a/tools/objtool/arch/x86/insn/gen-insn-attr-x86.awk b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
similarity index 99%
rename from tools/objtool/arch/x86/insn/gen-insn-attr-x86.awk
rename to tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
index a3d2c62fd805..b02a36b2c14f 100644
--- a/tools/objtool/arch/x86/insn/gen-insn-attr-x86.awk
+++ b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
@@ -1,4 +1,5 @@
 #!/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
 # gen-insn-attr-x86.awk: Instruction attribute table generator
 # Written by Masami Hiramatsu <mhiramat@redhat.com>
 #
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 365c34ecab26..694abc628e9b 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool nofp;
+bool no_fp, no_unreachable, retpoline, module;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -37,7 +37,10 @@ static const char * const check_usage[] = {
 };
 
 const struct option check_options[] = {
-	OPT_BOOLEAN('f', "no-fp", &nofp, "Skip frame pointer validation"),
+	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
+	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
+	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_END(),
 };
 
@@ -52,5 +55,5 @@ int cmd_check(int argc, const char **argv)
 
 	objname = argv[0];
 
-	return check(objname, nofp);
+	return check(objname, false);
 }
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
new file mode 100644
index 000000000000..77ea2b97117d
--- /dev/null
+++ b/tools/objtool/builtin-orc.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * objtool orc:
+ *
+ * This command analyzes a .o file and adds .orc_unwind and .orc_unwind_ip
+ * sections to it, which is used by the in-kernel ORC unwinder.
+ *
+ * This command is a superset of "objtool check".
+ */
+
+#include <string.h>
+#include "builtin.h"
+#include "check.h"
+
+
+static const char *orc_usage[] = {
+	"objtool orc generate [<options>] file.o",
+	"objtool orc dump file.o",
+	NULL,
+};
+
+int cmd_orc(int argc, const char **argv)
+{
+	const char *objname;
+
+	argc--; argv++;
+	if (argc <= 0)
+		usage_with_options(orc_usage, check_options);
+
+	if (!strncmp(argv[0], "gen", 3)) {
+		argc = parse_options(argc, argv, check_options, orc_usage, 0);
+		if (argc != 1)
+			usage_with_options(orc_usage, check_options);
+
+		objname = argv[0];
+
+		return check(objname, true);
+	}
+
+	if (!strcmp(argv[0], "dump")) {
+		if (argc != 2)
+			usage_with_options(orc_usage, check_options);
+
+		objname = argv[1];
+
+		return orc_dump(objname);
+	}
+
+	usage_with_options(orc_usage, check_options);
+
+	return 0;
+}
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 34d2ba78a616..28ff40e19a14 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -17,6 +17,12 @@
 #ifndef _BUILTIN_H
 #define _BUILTIN_H
 
+#include <subcmd/parse-options.h>
+
+extern const struct option check_options[];
+extern bool no_fp, no_unreachable, retpoline, module;
+
 extern int cmd_check(int argc, const char **argv);
+extern int cmd_orc(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
new file mode 100644
index 000000000000..2fe883c665c7
--- /dev/null
+++ b/tools/objtool/cfi.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _OBJTOOL_CFI_H
+#define _OBJTOOL_CFI_H
+
+#define CFI_UNDEFINED		-1
+#define CFI_CFA			-2
+#define CFI_SP_INDIRECT		-3
+#define CFI_BP_INDIRECT		-4
+
+#define CFI_AX			0
+#define CFI_DX			1
+#define CFI_CX			2
+#define CFI_BX			3
+#define CFI_SI			4
+#define CFI_DI			5
+#define CFI_BP			6
+#define CFI_SP			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_RA			16
+#define CFI_NUM_REGS		17
+
+struct cfi_reg {
+	int base;
+	int offset;
+};
+
+struct cfi_state {
+	struct cfi_reg cfa;
+	struct cfi_reg regs[CFI_NUM_REGS];
+};
+
+#endif /* _OBJTOOL_CFI_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b7a0af57a43d..c8b8b7101c6f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "builtin.h"
 #include "check.h"
 #include "elf.h"
 #include "special.h"
@@ -25,12 +26,7 @@
 #include "warn.h"
 
 #include <linux/hashtable.h>
-
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
-#define STATE_FP_SAVED		0x1
-#define STATE_FP_SETUP		0x2
-#define STATE_FENTRY		0x4
+#include <linux/kernel.h>
 
 struct alternative {
 	struct list_head list;
@@ -38,10 +34,10 @@ struct alternative {
 };
 
 const char *objname;
-static bool nofp;
+struct cfi_state initial_func_cfi;
 
-static struct instruction *find_insn(struct objtool_file *file,
-				     struct section *sec, unsigned long offset)
+struct instruction *find_insn(struct objtool_file *file,
+			      struct section *sec, unsigned long offset)
 {
 	struct instruction *insn;
 
@@ -57,28 +53,12 @@ static struct instruction *next_insn_same_sec(struct objtool_file *file,
 {
 	struct instruction *next = list_next_entry(insn, list);
 
-	if (&next->list == &file->insn_list || next->sec != insn->sec)
+	if (!next || &next->list == &file->insn_list || next->sec != insn->sec)
 		return NULL;
 
 	return next;
 }
 
-static bool gcov_enabled(struct objtool_file *file)
-{
-	struct section *sec;
-	struct symbol *sym;
-
-	list_for_each_entry(sec, &file->elf->sections, list)
-		list_for_each_entry(sym, &sec->symbol_list, list)
-			if (!strncmp(sym->name, "__gcov_.", 8))
-				return true;
-
-	return false;
-}
-
-#define for_each_insn(file, insn)					\
-	list_for_each_entry(insn, &file->insn_list, list)
-
 #define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn && &insn->list != &file->insn_list &&			\
@@ -95,6 +75,9 @@ static bool gcov_enabled(struct objtool_file *file)
 #define sec_for_each_insn_from(file, insn)				\
 	for (; insn; insn = next_insn_same_sec(file, insn))
 
+#define sec_for_each_insn_continue(file, insn)				\
+	for (insn = next_insn_same_sec(file, insn); insn;		\
+	     insn = next_insn_same_sec(file, insn))
 
 /*
  * Check if the function has been manually whitelisted with the
@@ -104,7 +87,6 @@ static bool gcov_enabled(struct objtool_file *file)
 static bool ignore_func(struct objtool_file *file, struct symbol *func)
 {
 	struct rela *rela;
-	struct instruction *insn;
 
 	/* check for STACK_FRAME_NON_STANDARD */
 	if (file->whitelist && file->whitelist->rela)
@@ -117,11 +99,6 @@ static bool ignore_func(struct objtool_file *file, struct symbol *func)
 				return true;
 		}
 
-	/* check if it has a context switching instruction */
-	func_for_each_insn(file, func, insn)
-		if (insn->type == INSN_CONTEXT_SWITCH)
-			return true;
-
 	return false;
 }
 
@@ -159,7 +136,8 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"complete_and_exit",
 		"kvm_spurious_fault",
 		"__reiserfs_panic",
-		"lbug_with_loc"
+		"lbug_with_loc",
+		"fortify_panic",
 	};
 
 	if (func->bind == STB_WEAK)
@@ -234,6 +212,20 @@ static int dead_end_function(struct objtool_file *file, struct symbol *func)
 	return __dead_end_function(file, func, 0);
 }
 
+static void clear_insn_state(struct insn_state *state)
+{
+	int i;
+
+	memset(state, 0, sizeof(*state));
+	state->cfa.base = CFI_UNDEFINED;
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->vals[i].base = CFI_UNDEFINED;
+	}
+	state->drap_reg = CFI_UNDEFINED;
+	state->drap_offset = -1;
+}
+
 /*
  * Call the arch-specific instruction decoder for all the instructions and add
  * them to the global instruction list.
@@ -246,30 +238,42 @@ static int decode_instructions(struct objtool_file *file)
 	struct instruction *insn;
 	int ret;
 
-	list_for_each_entry(sec, &file->elf->sections, list) {
+	for_each_sec(file, sec) {
 
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
 			continue;
 
+		if (strcmp(sec->name, ".altinstr_replacement") &&
+		    strcmp(sec->name, ".altinstr_aux") &&
+		    strncmp(sec->name, ".discard.", 9))
+			sec->text = true;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
+			if (!insn) {
+				WARN("malloc failed");
+				return -1;
+			}
 			memset(insn, 0, sizeof(*insn));
-
 			INIT_LIST_HEAD(&insn->alts);
+			clear_insn_state(&insn->state);
+
 			insn->sec = sec;
 			insn->offset = offset;
 
 			ret = arch_decode_instruction(file->elf, sec, offset,
 						      sec->len - offset,
 						      &insn->len, &insn->type,
-						      &insn->immediate);
+						      &insn->immediate,
+						      &insn->stack_op);
 			if (ret)
-				return ret;
+				goto err;
 
 			if (!insn->type || insn->type > INSN_LAST) {
 				WARN_FUNC("invalid instruction type %d",
 					  insn->sec, insn->offset, insn->type);
-				return -1;
+				ret = -1;
+				goto err;
 			}
 
 			hash_add(file->insn_hash, &insn->hash, insn->offset);
@@ -293,10 +297,14 @@ static int decode_instructions(struct objtool_file *file)
 	}
 
 	return 0;
+
+err:
+	free(insn);
+	return ret;
 }
 
 /*
- * Find all uses of the unreachable() macro, which are code path dead ends.
+ * Mark "ud2" instructions and manually annotated dead ends.
  */
 static int add_dead_ends(struct objtool_file *file)
 {
@@ -305,13 +313,24 @@ static int add_dead_ends(struct objtool_file *file)
 	struct instruction *insn;
 	bool found;
 
-	sec = find_section_by_name(file->elf, ".rela__unreachable");
+	/*
+	 * By default, "ud2" is a dead end unless otherwise annotated, because
+	 * GCC 7 inserts it for certain divide-by-zero cases.
+	 */
+	for_each_insn(file, insn)
+		if (insn->type == INSN_BUG)
+			insn->dead_end = true;
+
+	/*
+	 * Check for manually annotated dead ends.
+	 */
+	sec = find_section_by_name(file->elf, ".rela.discard.unreachable");
 	if (!sec)
-		return 0;
+		goto reachable;
 
 	list_for_each_entry(rela, &sec->rela_list, list) {
 		if (rela->sym->type != STT_SECTION) {
-			WARN("unexpected relocation symbol type in .rela__unreachable");
+			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 		insn = find_insn(file, rela->sym->sec, rela->addend);
@@ -340,6 +359,48 @@ static int add_dead_ends(struct objtool_file *file)
 		insn->dead_end = true;
 	}
 
+reachable:
+	/*
+	 * These manually annotated reachable checks are needed for GCC 4.4,
+	 * where the Linux unreachable() macro isn't supported.  In that case
+	 * GCC doesn't know the "ud2" is fatal, so it generates code as if it's
+	 * not a dead end.
+	 */
+	sec = find_section_by_name(file->elf, ".rela.discard.reachable");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return -1;
+		}
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (insn)
+			insn = list_prev_entry(insn, list);
+		else if (rela->addend == rela->sym->sec->len) {
+			found = false;
+			list_for_each_entry_reverse(insn, &file->insn_list, list) {
+				if (insn->sec == rela->sym->sec) {
+					found = true;
+					break;
+				}
+			}
+
+			if (!found) {
+				WARN("can't find reachable insn at %s+0x%x",
+				     rela->sym->sec->name, rela->addend);
+				return -1;
+			}
+		} else {
+			WARN("can't find reachable insn at %s+0x%x",
+			     rela->sym->sec->name, rela->addend);
+			return -1;
+		}
+
+		insn->dead_end = false;
+	}
+
 	return 0;
 }
 
@@ -352,7 +413,7 @@ static void add_ignores(struct objtool_file *file)
 	struct section *sec;
 	struct symbol *func;
 
-	list_for_each_entry(sec, &file->elf->sections, list) {
+	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_FUNC)
 				continue;
@@ -361,7 +422,7 @@ static void add_ignores(struct objtool_file *file)
 				continue;
 
 			func_for_each_insn(file, func, insn)
-				insn->visited = true;
+				insn->ignore = true;
 		}
 	}
 }
@@ -415,8 +476,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
 
-		/* skip ignores */
-		if (insn->visited)
+		if (insn->ignore)
 			continue;
 
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
@@ -436,6 +496,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * disguise, so convert them accordingly.
 			 */
 			insn->type = INSN_JUMP_DYNAMIC;
+			insn->retpoline_safe = true;
 			continue;
 		} else {
 			/* sibling call */
@@ -483,18 +544,15 @@ static int add_call_destinations(struct objtool_file *file)
 			dest_off = insn->offset + insn->len + insn->immediate;
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
-			/*
-			 * FIXME: Thanks to retpolines, it's now considered
-			 * normal for a function to call within itself.  So
-			 * disable this warning for now.
-			 */
-#if 0
-			if (!insn->call_dest) {
-				WARN_FUNC("can't find call dest symbol at offset 0x%lx",
-					  insn->sec, insn->offset, dest_off);
+
+			if (!insn->call_dest && !insn->ignore) {
+				WARN_FUNC("unsupported intra-function call",
+					  insn->sec, insn->offset);
+				if (retpoline)
+					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
-#endif
+
 		} else if (rela->sym->type == STT_SECTION) {
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
 								rela->addend+4);
@@ -538,7 +596,7 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump;
+	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -554,25 +612,30 @@ static int handle_group_alt(struct objtool_file *file,
 		last_orig_insn = insn;
 	}
 
-	if (!next_insn_same_sec(file, last_orig_insn)) {
-		WARN("%s: don't know how to handle alternatives at end of section",
-		     special_alt->orig_sec->name);
-		return -1;
-	}
-
-	fake_jump = malloc(sizeof(*fake_jump));
-	if (!fake_jump) {
-		WARN("malloc failed");
-		return -1;
+	if (next_insn_same_sec(file, last_orig_insn)) {
+		fake_jump = malloc(sizeof(*fake_jump));
+		if (!fake_jump) {
+			WARN("malloc failed");
+			return -1;
+		}
+		memset(fake_jump, 0, sizeof(*fake_jump));
+		INIT_LIST_HEAD(&fake_jump->alts);
+		clear_insn_state(&fake_jump->state);
+
+		fake_jump->sec = special_alt->new_sec;
+		fake_jump->offset = -1;
+		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
+		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
+		fake_jump->ignore = true;
 	}
-	memset(fake_jump, 0, sizeof(*fake_jump));
-	INIT_LIST_HEAD(&fake_jump->alts);
-	fake_jump->sec = special_alt->new_sec;
-	fake_jump->offset = -1;
-	fake_jump->type = INSN_JUMP_UNCONDITIONAL;
-	fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
 
 	if (!special_alt->new_len) {
+		if (!fake_jump) {
+			WARN("%s: empty alternative at end of section",
+			     special_alt->orig_sec->name);
+			return -1;
+		}
+
 		*new_insn = fake_jump;
 		return 0;
 	}
@@ -585,6 +648,8 @@ static int handle_group_alt(struct objtool_file *file,
 
 		last_new_insn = insn;
 
+		insn->ignore = orig_insn->ignore_alts;
+
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
@@ -593,8 +658,14 @@ static int handle_group_alt(struct objtool_file *file,
 			continue;
 
 		dest_off = insn->offset + insn->len + insn->immediate;
-		if (dest_off == special_alt->new_off + special_alt->new_len)
+		if (dest_off == special_alt->new_off + special_alt->new_len) {
+			if (!fake_jump) {
+				WARN("%s: alternative jump to end of section",
+				     special_alt->orig_sec->name);
+				return -1;
+			}
 			insn->jump_dest = fake_jump;
+		}
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -609,7 +680,8 @@ static int handle_group_alt(struct objtool_file *file,
 		return -1;
 	}
 
-	list_add(&fake_jump->list, &last_new_insn->list);
+	if (fake_jump)
+		list_add(&fake_jump->list, &last_new_insn->list);
 
 	return 0;
 }
@@ -656,6 +728,7 @@ static int add_special_section_alts(struct objtool_file *file)
 		return ret;
 
 	list_for_each_entry_safe(special_alt, tmp, &special_alts, list) {
+
 		orig_insn = find_insn(file, special_alt->orig_sec,
 				      special_alt->orig_off);
 		if (!orig_insn) {
@@ -665,10 +738,6 @@ static int add_special_section_alts(struct objtool_file *file)
 			goto out;
 		}
 
-		/* Ignore retpoline alternatives. */
-		if (orig_insn->ignore_alts)
-			continue;
-
 		new_insn = NULL;
 		if (!special_alt->group || special_alt->new_len) {
 			new_insn = find_insn(file, special_alt->new_sec,
@@ -784,8 +853,14 @@ static int add_switch_table(struct objtool_file *file, struct symbol *func,
  *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
  *    writing, there are 11 occurrences of it in the allmodconfig kernel.
  *
+ *    As of GCC 7 there are quite a few more of these and the 'in between' code
+ *    is significant. Esp. with KASAN enabled some of the code between the mov
+ *    and jmpq uses .rodata itself, which can confuse things.
+ *
  *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
  *    ensure the same register is used in the mov and jump instructions.
+ *
+ *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
 static struct rela *find_switch_table(struct objtool_file *file,
 				      struct symbol *func,
@@ -807,12 +882,25 @@ static struct rela *find_switch_table(struct objtool_file *file,
 						text_rela->addend + 4);
 		if (!rodata_rela)
 			return NULL;
+
 		file->ignore_unreachables = true;
 		return rodata_rela;
 	}
 
 	/* case 3 */
-	func_for_each_insn_continue_reverse(file, func, insn) {
+	/*
+	 * Backward search using the @first_jump_src links, these help avoid
+	 * much of the 'in between' code. Which avoids us getting confused by
+	 * it.
+	 */
+	for (insn = list_prev_entry(insn, list);
+
+	     &insn->list != &file->insn_list &&
+	     insn->sec == func->sec &&
+	     insn->offset >= func->offset;
+
+	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+
 		if (insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
@@ -836,20 +924,42 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(file->rodata, text_rela->addend))
 			continue;
 
-		return find_rela_by_dest(file->rodata, text_rela->addend);
+		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
+		if (!rodata_rela)
+			continue;
+
+		return rodata_rela;
 	}
 
 	return NULL;
 }
 
+
 static int add_func_switch_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *prev_jump = NULL;
+	struct instruction *insn, *last = NULL, *prev_jump = NULL;
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
 	func_for_each_insn(file, func, insn) {
+		if (!last)
+			last = insn;
+
+		/*
+		 * Store back-pointers for unconditional forward jumps such
+		 * that find_switch_table() can back-track using those and
+		 * avoid some potentially confusing code.
+		 */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
+		    insn->offset > last->offset &&
+		    insn->jump_dest->offset > insn->offset &&
+		    !insn->jump_dest->first_jump_src) {
+
+			insn->jump_dest->first_jump_src = insn;
+			last = insn->jump_dest;
+		}
+
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
@@ -896,7 +1006,7 @@ static int add_switch_table_alts(struct objtool_file *file)
 	if (!file->rodata || !file->rodata->rela)
 		return 0;
 
-	list_for_each_entry(sec, &file->elf->sections, list) {
+	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_FUNC)
 				continue;
@@ -910,6 +1020,134 @@ static int add_switch_table_alts(struct objtool_file *file)
 	return 0;
 }
 
+static int read_unwind_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct rela *rela;
+	struct unwind_hint *hint;
+	struct instruction *insn;
+	struct cfi_reg *cfa;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.unwind_hints section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(struct unwind_hint)) {
+		WARN("struct unwind_hint size mismatch");
+		return -1;
+	}
+
+	file->hints = true;
+
+	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
+		hint = (struct unwind_hint *)sec->data->d_buf + i;
+
+		rela = find_rela_by_dest(sec, i * sizeof(*hint));
+		if (!rela) {
+			WARN("can't find rela for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		cfa = &insn->state.cfa;
+
+		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
+			insn->save = true;
+			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
+			insn->restore = true;
+			insn->hint = true;
+			continue;
+		}
+
+		insn->hint = true;
+
+		switch (hint->sp_reg) {
+		case ORC_REG_UNDEFINED:
+			cfa->base = CFI_UNDEFINED;
+			break;
+		case ORC_REG_SP:
+			cfa->base = CFI_SP;
+			break;
+		case ORC_REG_BP:
+			cfa->base = CFI_BP;
+			break;
+		case ORC_REG_SP_INDIRECT:
+			cfa->base = CFI_SP_INDIRECT;
+			break;
+		case ORC_REG_R10:
+			cfa->base = CFI_R10;
+			break;
+		case ORC_REG_R13:
+			cfa->base = CFI_R13;
+			break;
+		case ORC_REG_DI:
+			cfa->base = CFI_DI;
+			break;
+		case ORC_REG_DX:
+			cfa->base = CFI_DX;
+			break;
+		default:
+			WARN_FUNC("unsupported unwind_hint sp base reg %d",
+				  insn->sec, insn->offset, hint->sp_reg);
+			return -1;
+		}
+
+		cfa->offset = hint->sp_offset;
+		insn->state.type = hint->type;
+	}
+
+	return 0;
+}
+
+static int read_retpoline_hints(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.retpoline_safe entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC) {
+			WARN_FUNC("retpoline_safe hint not an indirect jump/call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		insn->retpoline_safe = true;
+	}
+
+	return 0;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	int ret;
@@ -932,11 +1170,11 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_call_destinations(file);
+	ret = add_special_section_alts(file);
 	if (ret)
 		return ret;
 
-	ret = add_special_section_alts(file);
+	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
 
@@ -944,6 +1182,14 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_unwind_hints(file);
+	if (ret)
+		return ret;
+
+	ret = read_retpoline_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -957,125 +1203,647 @@ static bool is_fentry_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct instruction *insn)
+static bool has_modified_stack_frame(struct insn_state *state)
+{
+	int i;
+
+	if (state->cfa.base != initial_func_cfi.cfa.base ||
+	    state->cfa.offset != initial_func_cfi.cfa.offset ||
+	    state->stack_size != initial_func_cfi.cfa.offset ||
+	    state->drap)
+		return true;
+
+	for (i = 0; i < CFI_NUM_REGS; i++)
+		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
+		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
+			return true;
+
+	return false;
+}
+
+static bool has_valid_stack_frame(struct insn_state *state)
+{
+	if (state->cfa.base == CFI_BP && state->regs[CFI_BP].base == CFI_CFA &&
+	    state->regs[CFI_BP].offset == -16)
+		return true;
+
+	if (state->drap && state->regs[CFI_BP].base == CFI_BP)
+		return true;
+
+	return false;
+}
+
+static int update_insn_state_regs(struct instruction *insn, struct insn_state *state)
 {
-	return (insn->state & STATE_FP_SAVED) ||
-	       (insn->state & STATE_FP_SETUP);
+	struct cfi_reg *cfa = &state->cfa;
+	struct stack_op *op = &insn->stack_op;
+
+	if (cfa->base != CFI_SP)
+		return 0;
+
+	/* push */
+	if (op->dest.type == OP_DEST_PUSH)
+		cfa->offset += 8;
+
+	/* pop */
+	if (op->src.type == OP_SRC_POP)
+		cfa->offset -= 8;
+
+	/* add immediate to sp */
+	if (op->dest.type == OP_DEST_REG && op->src.type == OP_SRC_ADD &&
+	    op->dest.reg == CFI_SP && op->src.reg == CFI_SP)
+		cfa->offset -= op->src.offset;
+
+	return 0;
 }
 
-static bool has_valid_stack_frame(struct instruction *insn)
+static void save_reg(struct insn_state *state, unsigned char reg, int base,
+		     int offset)
 {
-	return (insn->state & STATE_FP_SAVED) &&
-	       (insn->state & STATE_FP_SETUP);
+	if (arch_callee_saved_reg(reg) &&
+	    state->regs[reg].base == CFI_UNDEFINED) {
+		state->regs[reg].base = base;
+		state->regs[reg].offset = offset;
+	}
 }
 
-static unsigned int frame_state(unsigned long state)
+static void restore_reg(struct insn_state *state, unsigned char reg)
 {
-	return (state & (STATE_FP_SAVED | STATE_FP_SETUP));
+	state->regs[reg].base = CFI_UNDEFINED;
+	state->regs[reg].offset = 0;
 }
 
 /*
- * Follow the branch starting at the given instruction, and recursively follow
- * any other branches (jumps).  Meanwhile, track the frame pointer state at
- * each instruction and validate all the rules described in
- * tools/objtool/Documentation/stack-validation.txt.
+ * A note about DRAP stack alignment:
+ *
+ * GCC has the concept of a DRAP register, which is used to help keep track of
+ * the stack pointer when aligning the stack.  r10 or r13 is used as the DRAP
+ * register.  The typical DRAP pattern is:
+ *
+ *   4c 8d 54 24 08		lea    0x8(%rsp),%r10
+ *   48 83 e4 c0		and    $0xffffffffffffffc0,%rsp
+ *   41 ff 72 f8		pushq  -0x8(%r10)
+ *   55				push   %rbp
+ *   48 89 e5			mov    %rsp,%rbp
+ *				(more pushes)
+ *   41 52			push   %r10
+ *				...
+ *   41 5a			pop    %r10
+ *				(more pops)
+ *   5d				pop    %rbp
+ *   49 8d 62 f8		lea    -0x8(%r10),%rsp
+ *   c3				retq
+ *
+ * There are some variations in the epilogues, like:
+ *
+ *   5b				pop    %rbx
+ *   41 5a			pop    %r10
+ *   41 5c			pop    %r12
+ *   41 5d			pop    %r13
+ *   41 5e			pop    %r14
+ *   c9				leaveq
+ *   49 8d 62 f8		lea    -0x8(%r10),%rsp
+ *   c3				retq
+ *
+ * and:
+ *
+ *   4c 8b 55 e8		mov    -0x18(%rbp),%r10
+ *   48 8b 5d e0		mov    -0x20(%rbp),%rbx
+ *   4c 8b 65 f0		mov    -0x10(%rbp),%r12
+ *   4c 8b 6d f8		mov    -0x8(%rbp),%r13
+ *   c9				leaveq
+ *   49 8d 62 f8		lea    -0x8(%r10),%rsp
+ *   c3				retq
+ *
+ * Sometimes r13 is used as the DRAP register, in which case it's saved and
+ * restored beforehand:
+ *
+ *   41 55			push   %r13
+ *   4c 8d 6c 24 10		lea    0x10(%rsp),%r13
+ *   48 83 e4 f0		and    $0xfffffffffffffff0,%rsp
+ *				...
+ *   49 8d 65 f0		lea    -0x10(%r13),%rsp
+ *   41 5d			pop    %r13
+ *   c3				retq
  */
-static int validate_branch(struct objtool_file *file,
-			   struct instruction *first, unsigned char first_state)
+static int update_insn_state(struct instruction *insn, struct insn_state *state)
 {
-	struct alternative *alt;
-	struct instruction *insn;
-	struct section *sec;
-	struct symbol *func = NULL;
-	unsigned char state;
-	int ret;
+	struct stack_op *op = &insn->stack_op;
+	struct cfi_reg *cfa = &state->cfa;
+	struct cfi_reg *regs = state->regs;
+
+	/* stack operations don't make sense with an undefined CFA */
+	if (cfa->base == CFI_UNDEFINED) {
+		if (insn->func) {
+			WARN_FUNC("undefined stack state", insn->sec, insn->offset);
+			return -1;
+		}
+		return 0;
+	}
 
-	insn = first;
-	sec = insn->sec;
-	state = first_state;
+	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
+		return update_insn_state_regs(insn, state);
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
-		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
-			  sec, insn->offset);
-		return 1;
-	}
+	switch (op->dest.type) {
 
-	while (1) {
-		if (file->c_file && insn->func) {
-			if (func && func != insn->func) {
-				WARN("%s() falls through to next function %s()",
-				     func->name, insn->func->name);
-				return 1;
-			}
+	case OP_DEST_REG:
+		switch (op->src.type) {
 
-			func = insn->func;
-		}
+		case OP_SRC_REG:
+			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
+			    cfa->base == CFI_SP &&
+			    regs[CFI_BP].base == CFI_CFA &&
+			    regs[CFI_BP].offset == -cfa->offset) {
 
-		if (insn->visited) {
-			if (frame_state(insn->state) != frame_state(state)) {
-				WARN_FUNC("frame pointer state mismatch",
-					  sec, insn->offset);
-				return 1;
+				/* mov %rsp, %rbp */
+				cfa->base = op->dest.reg;
+				state->bp_scratch = false;
 			}
 
-			return 0;
+			else if (op->src.reg == CFI_SP &&
+				 op->dest.reg == CFI_BP && state->drap) {
+
+				/* drap: mov %rsp, %rbp */
+				regs[CFI_BP].base = CFI_BP;
+				regs[CFI_BP].offset = -state->stack_size;
+				state->bp_scratch = false;
+			}
+
+			else if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
+
+				/*
+				 * mov %rsp, %reg
+				 *
+				 * This is needed for the rare case where GCC
+				 * does:
+				 *
+				 *   mov    %rsp, %rax
+				 *   ...
+				 *   mov    %rax, %rsp
+				 */
+				state->vals[op->dest.reg].base = CFI_CFA;
+				state->vals[op->dest.reg].offset = -state->stack_size;
+			}
+
+			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
+				 cfa->base == CFI_BP) {
+
+				/*
+				 * mov %rbp, %rsp
+				 *
+				 * Restore the original stack pointer (Clang).
+				 */
+				state->stack_size = -state->regs[CFI_BP].offset;
+			}
+
+			else if (op->dest.reg == cfa->base) {
+
+				/* mov %reg, %rsp */
+				if (cfa->base == CFI_SP &&
+				    state->vals[op->src.reg].base == CFI_CFA) {
+
+					/*
+					 * This is needed for the rare case
+					 * where GCC does something dumb like:
+					 *
+					 *   lea    0x8(%rsp), %rcx
+					 *   ...
+					 *   mov    %rcx, %rsp
+					 */
+					cfa->offset = -state->vals[op->src.reg].offset;
+					state->stack_size = cfa->offset;
+
+				} else {
+					cfa->base = CFI_UNDEFINED;
+					cfa->offset = 0;
+				}
+			}
+
+			break;
+
+		case OP_SRC_ADD:
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_SP) {
+
+				/* add imm, %rsp */
+				state->stack_size -= op->src.offset;
+				if (cfa->base == CFI_SP)
+					cfa->offset -= op->src.offset;
+				break;
+			}
+
+			if (op->dest.reg == CFI_SP && op->src.reg == CFI_BP) {
+
+				/* lea disp(%rbp), %rsp */
+				state->stack_size = -(op->src.offset + regs[CFI_BP].offset);
+				break;
+			}
+
+			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
+
+				/* drap: lea disp(%rsp), %drap */
+				state->drap_reg = op->dest.reg;
+
+				/*
+				 * lea disp(%rsp), %reg
+				 *
+				 * This is needed for the rare case where GCC
+				 * does something dumb like:
+				 *
+				 *   lea    0x8(%rsp), %rcx
+				 *   ...
+				 *   mov    %rcx, %rsp
+				 */
+				state->vals[op->dest.reg].base = CFI_CFA;
+				state->vals[op->dest.reg].offset = \
+					-state->stack_size + op->src.offset;
+
+				break;
+			}
+
+			if (state->drap && op->dest.reg == CFI_SP &&
+			    op->src.reg == state->drap_reg) {
+
+				 /* drap: lea disp(%drap), %rsp */
+				cfa->base = CFI_SP;
+				cfa->offset = state->stack_size = -op->src.offset;
+				state->drap_reg = CFI_UNDEFINED;
+				state->drap = false;
+				break;
+			}
+
+			if (op->dest.reg == state->cfa.base) {
+				WARN_FUNC("unsupported stack register modification",
+					  insn->sec, insn->offset);
+				return -1;
+			}
+
+			break;
+
+		case OP_SRC_AND:
+			if (op->dest.reg != CFI_SP ||
+			    (state->drap_reg != CFI_UNDEFINED && cfa->base != CFI_SP) ||
+			    (state->drap_reg == CFI_UNDEFINED && cfa->base != CFI_BP)) {
+				WARN_FUNC("unsupported stack pointer realignment",
+					  insn->sec, insn->offset);
+				return -1;
+			}
+
+			if (state->drap_reg != CFI_UNDEFINED) {
+				/* drap: and imm, %rsp */
+				cfa->base = state->drap_reg;
+				cfa->offset = state->stack_size = 0;
+				state->drap = true;
+			}
+
+			/*
+			 * Older versions of GCC (4.8ish) realign the stack
+			 * without DRAP, with a frame pointer.
+			 */
+
+			break;
+
+		case OP_SRC_POP:
+			if (!state->drap && op->dest.type == OP_DEST_REG &&
+			    op->dest.reg == cfa->base) {
+
+				/* pop %rbp */
+				cfa->base = CFI_SP;
+			}
+
+			if (state->drap && cfa->base == CFI_BP_INDIRECT &&
+			    op->dest.type == OP_DEST_REG &&
+			    op->dest.reg == state->drap_reg &&
+			    state->drap_offset == -state->stack_size) {
+
+				/* drap: pop %drap */
+				cfa->base = state->drap_reg;
+				cfa->offset = 0;
+				state->drap_offset = -1;
+
+			} else if (regs[op->dest.reg].offset == -state->stack_size) {
+
+				/* pop %reg */
+				restore_reg(state, op->dest.reg);
+			}
+
+			state->stack_size -= 8;
+			if (cfa->base == CFI_SP)
+				cfa->offset -= 8;
+
+			break;
+
+		case OP_SRC_REG_INDIRECT:
+			if (state->drap && op->src.reg == CFI_BP &&
+			    op->src.offset == state->drap_offset) {
+
+				/* drap: mov disp(%rbp), %drap */
+				cfa->base = state->drap_reg;
+				cfa->offset = 0;
+				state->drap_offset = -1;
+			}
+
+			if (state->drap && op->src.reg == CFI_BP &&
+			    op->src.offset == regs[op->dest.reg].offset) {
+
+				/* drap: mov disp(%rbp), %reg */
+				restore_reg(state, op->dest.reg);
+
+			} else if (op->src.reg == cfa->base &&
+			    op->src.offset == regs[op->dest.reg].offset + cfa->offset) {
+
+				/* mov disp(%rbp), %reg */
+				/* mov disp(%rsp), %reg */
+				restore_reg(state, op->dest.reg);
+			}
+
+			break;
+
+		default:
+			WARN_FUNC("unknown stack-related instruction",
+				  insn->sec, insn->offset);
+			return -1;
 		}
 
-		insn->visited = true;
-		insn->state = state;
+		break;
 
-		list_for_each_entry(alt, &insn->alts, list) {
-			ret = validate_branch(file, alt->insn, state);
-			if (ret)
+	case OP_DEST_PUSH:
+		state->stack_size += 8;
+		if (cfa->base == CFI_SP)
+			cfa->offset += 8;
+
+		if (op->src.type != OP_SRC_REG)
+			break;
+
+		if (state->drap) {
+			if (op->src.reg == cfa->base && op->src.reg == state->drap_reg) {
+
+				/* drap: push %drap */
+				cfa->base = CFI_BP_INDIRECT;
+				cfa->offset = -state->stack_size;
+
+				/* save drap so we know when to restore it */
+				state->drap_offset = -state->stack_size;
+
+			} else if (op->src.reg == CFI_BP && cfa->base == state->drap_reg) {
+
+				/* drap: push %rbp */
+				state->stack_size = 0;
+
+			} else if (regs[op->src.reg].base == CFI_UNDEFINED) {
+
+				/* drap: push %reg */
+				save_reg(state, op->src.reg, CFI_BP, -state->stack_size);
+			}
+
+		} else {
+
+			/* push %reg */
+			save_reg(state, op->src.reg, CFI_CFA, -state->stack_size);
+		}
+
+		/* detect when asm code uses rbp as a scratch register */
+		if (!no_fp && insn->func && op->src.reg == CFI_BP &&
+		    cfa->base != CFI_BP)
+			state->bp_scratch = true;
+		break;
+
+	case OP_DEST_REG_INDIRECT:
+
+		if (state->drap) {
+			if (op->src.reg == cfa->base && op->src.reg == state->drap_reg) {
+
+				/* drap: mov %drap, disp(%rbp) */
+				cfa->base = CFI_BP_INDIRECT;
+				cfa->offset = op->dest.offset;
+
+				/* save drap offset so we know when to restore it */
+				state->drap_offset = op->dest.offset;
+			}
+
+			else if (regs[op->src.reg].base == CFI_UNDEFINED) {
+
+				/* drap: mov reg, disp(%rbp) */
+				save_reg(state, op->src.reg, CFI_BP, op->dest.offset);
+			}
+
+		} else if (op->dest.reg == cfa->base) {
+
+			/* mov reg, disp(%rbp) */
+			/* mov reg, disp(%rsp) */
+			save_reg(state, op->src.reg, CFI_CFA,
+				 op->dest.offset - state->cfa.offset);
+		}
+
+		break;
+
+	case OP_DEST_LEAVE:
+		if ((!state->drap && cfa->base != CFI_BP) ||
+		    (state->drap && cfa->base != state->drap_reg)) {
+			WARN_FUNC("leave instruction with modified stack frame",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		/* leave (mov %rbp, %rsp; pop %rbp) */
+
+		state->stack_size = -state->regs[CFI_BP].offset - 8;
+		restore_reg(state, CFI_BP);
+
+		if (!state->drap) {
+			cfa->base = CFI_SP;
+			cfa->offset -= 8;
+		}
+
+		break;
+
+	case OP_DEST_MEM:
+		if (op->src.type != OP_SRC_POP) {
+			WARN_FUNC("unknown stack-related memory operation",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		/* pop mem */
+		state->stack_size -= 8;
+		if (cfa->base == CFI_SP)
+			cfa->offset -= 8;
+
+		break;
+
+	default:
+		WARN_FUNC("unknown stack-related instruction",
+			  insn->sec, insn->offset);
+		return -1;
+	}
+
+	return 0;
+}
+
+static bool insn_state_match(struct instruction *insn, struct insn_state *state)
+{
+	struct insn_state *state1 = &insn->state, *state2 = state;
+	int i;
+
+	if (memcmp(&state1->cfa, &state2->cfa, sizeof(state1->cfa))) {
+		WARN_FUNC("stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
+			  insn->sec, insn->offset,
+			  state1->cfa.base, state1->cfa.offset,
+			  state2->cfa.base, state2->cfa.offset);
+
+	} else if (memcmp(&state1->regs, &state2->regs, sizeof(state1->regs))) {
+		for (i = 0; i < CFI_NUM_REGS; i++) {
+			if (!memcmp(&state1->regs[i], &state2->regs[i],
+				    sizeof(struct cfi_reg)))
+				continue;
+
+			WARN_FUNC("stack state mismatch: reg1[%d]=%d%+d reg2[%d]=%d%+d",
+				  insn->sec, insn->offset,
+				  i, state1->regs[i].base, state1->regs[i].offset,
+				  i, state2->regs[i].base, state2->regs[i].offset);
+			break;
+		}
+
+	} else if (state1->type != state2->type) {
+		WARN_FUNC("stack state mismatch: type1=%d type2=%d",
+			  insn->sec, insn->offset, state1->type, state2->type);
+
+	} else if (state1->drap != state2->drap ||
+		 (state1->drap && state1->drap_reg != state2->drap_reg) ||
+		 (state1->drap && state1->drap_offset != state2->drap_offset)) {
+		WARN_FUNC("stack state mismatch: drap1=%d(%d,%d) drap2=%d(%d,%d)",
+			  insn->sec, insn->offset,
+			  state1->drap, state1->drap_reg, state1->drap_offset,
+			  state2->drap, state2->drap_reg, state2->drap_offset);
+
+	} else
+		return true;
+
+	return false;
+}
+
+/*
+ * Follow the branch starting at the given instruction, and recursively follow
+ * any other branches (jumps).  Meanwhile, track the frame pointer state at
+ * each instruction and validate all the rules described in
+ * tools/objtool/Documentation/stack-validation.txt.
+ */
+static int validate_branch(struct objtool_file *file, struct instruction *first,
+			   struct insn_state state)
+{
+	struct alternative *alt;
+	struct instruction *insn, *next_insn;
+	struct section *sec;
+	struct symbol *func = NULL;
+	int ret;
+
+	insn = first;
+	sec = insn->sec;
+
+	if (insn->alt_group && list_empty(&insn->alts)) {
+		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
+			  sec, insn->offset);
+		return 1;
+	}
+
+	while (1) {
+		next_insn = next_insn_same_sec(file, insn);
+
+
+		if (file->c_file && func && insn->func && func != insn->func) {
+			WARN("%s() falls through to next function %s()",
+			     func->name, insn->func->name);
+			return 1;
+		}
+
+		if (insn->func)
+			func = insn->func;
+
+		if (func && insn->ignore) {
+			WARN_FUNC("BUG: why am I validating an ignored function?",
+				  sec, insn->offset);
+			return 1;
+		}
+
+		if (insn->visited) {
+			if (!insn->hint && !insn_state_match(insn, &state))
 				return 1;
+
+			return 0;
 		}
 
-		switch (insn->type) {
+		if (insn->hint) {
+			if (insn->restore) {
+				struct instruction *save_insn, *i;
+
+				i = insn;
+				save_insn = NULL;
+				func_for_each_insn_continue_reverse(file, func, i) {
+					if (i->save) {
+						save_insn = i;
+						break;
+					}
+				}
 
-		case INSN_FP_SAVE:
-			if (!nofp) {
-				if (state & STATE_FP_SAVED) {
-					WARN_FUNC("duplicate frame pointer save",
+				if (!save_insn) {
+					WARN_FUNC("no corresponding CFI save for CFI restore",
 						  sec, insn->offset);
 					return 1;
 				}
-				state |= STATE_FP_SAVED;
-			}
-			break;
 
-		case INSN_FP_SETUP:
-			if (!nofp) {
-				if (state & STATE_FP_SETUP) {
-					WARN_FUNC("duplicate frame pointer setup",
+				if (!save_insn->visited) {
+					/*
+					 * Oops, no state to copy yet.
+					 * Hopefully we can reach this
+					 * instruction from another branch
+					 * after the save insn has been
+					 * visited.
+					 */
+					if (insn == first)
+						return 0;
+
+					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
 						  sec, insn->offset);
 					return 1;
 				}
-				state |= STATE_FP_SETUP;
+
+				insn->state = save_insn->state;
 			}
-			break;
 
-		case INSN_FP_RESTORE:
-			if (!nofp) {
-				if (has_valid_stack_frame(insn))
-					state &= ~STATE_FP_SETUP;
+			state = insn->state;
+
+		} else
+			insn->state = state;
+
+		insn->visited = true;
 
-				state &= ~STATE_FP_SAVED;
+		if (!insn->ignore_alts) {
+			list_for_each_entry(alt, &insn->alts, list) {
+				ret = validate_branch(file, alt->insn, state);
+				if (ret)
+					return 1;
 			}
-			break;
+		}
+
+		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (!nofp && has_modified_stack_frame(insn)) {
-				WARN_FUNC("return without frame pointer restore",
+			if (func && has_modified_stack_frame(&state)) {
+				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
 				return 1;
 			}
+
+			if (state.bp_scratch) {
+				WARN("%s uses BP as a scratch register",
+				     insn->func->name);
+				return 1;
+			}
+
 			return 0;
 
 		case INSN_CALL:
-			if (is_fentry_call(insn)) {
-				state |= STATE_FENTRY;
+			if (is_fentry_call(insn))
 				break;
-			}
 
 			ret = dead_end_function(file, insn->call_dest);
 			if (ret == 1)
@@ -1085,7 +1853,7 @@ static int validate_branch(struct objtool_file *file,
 
 			/* fallthrough */
 		case INSN_CALL_DYNAMIC:
-			if (!nofp && !has_valid_stack_frame(insn)) {
+			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
@@ -1094,16 +1862,19 @@ static int validate_branch(struct objtool_file *file,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (insn->jump_dest) {
+			if (insn->jump_dest &&
+			    (!func || !insn->jump_dest->func ||
+			     func == insn->jump_dest->func)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
 				if (ret)
 					return 1;
-			} else if (has_modified_stack_frame(insn)) {
-				WARN_FUNC("sibling call from callable instruction with changed frame pointer",
+
+			} else if (func && has_modified_stack_frame(&state)) {
+				WARN_FUNC("sibling call from callable instruction with modified stack frame",
 					  sec, insn->offset);
 				return 1;
-			} /* else it's a sibling call */
+			}
 
 			if (insn->type == INSN_JUMP_UNCONDITIONAL)
 				return 0;
@@ -1111,15 +1882,29 @@ static int validate_branch(struct objtool_file *file,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (list_empty(&insn->alts) &&
-			    has_modified_stack_frame(insn)) {
-				WARN_FUNC("sibling call from callable instruction with changed frame pointer",
+			if (func && list_empty(&insn->alts) &&
+			    has_modified_stack_frame(&state)) {
+				WARN_FUNC("sibling call from callable instruction with modified stack frame",
 					  sec, insn->offset);
 				return 1;
 			}
 
 			return 0;
 
+		case INSN_CONTEXT_SWITCH:
+			if (func && (!next_insn || !next_insn->hint)) {
+				WARN_FUNC("unsupported instruction in callable function",
+					  sec, insn->offset);
+				return 1;
+			}
+			return 0;
+
+		case INSN_STACK:
+			if (update_insn_state(insn, &state))
+				return 1;
+
+			break;
+
 		default:
 			break;
 		}
@@ -1127,16 +1912,72 @@ static int validate_branch(struct objtool_file *file,
 		if (insn->dead_end)
 			return 0;
 
-		insn = next_insn_same_sec(file, insn);
-		if (!insn) {
+		if (!next_insn) {
+			if (state.cfa.base == CFI_UNDEFINED)
+				return 0;
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
 		}
+
+		insn = next_insn;
 	}
 
 	return 0;
 }
 
+static int validate_unwind_hints(struct objtool_file *file)
+{
+	struct instruction *insn;
+	int ret, warnings = 0;
+	struct insn_state state;
+
+	if (!file->hints)
+		return 0;
+
+	clear_insn_state(&state);
+
+	for_each_insn(file, insn) {
+		if (insn->hint && !insn->visited) {
+			ret = validate_branch(file, insn, state);
+			warnings += ret;
+		}
+	}
+
+	return warnings;
+}
+
+static int validate_retpoline(struct objtool_file *file)
+{
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn) {
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
+		if (insn->retpoline_safe)
+			continue;
+
+		/*
+		 * .init.text code is ran before userspace and thus doesn't
+		 * strictly need retpolines, except for modules which are
+		 * loaded late, they very much do need retpoline in their
+		 * .init.text
+		 */
+		if (!strcmp(insn->sec->name, ".init.text") && !module)
+			continue;
+
+		WARN_FUNC("indirect %s found in RETPOLINE build",
+			  insn->sec, insn->offset,
+			  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
+
+		warnings++;
+	}
+
+	return warnings;
+}
+
 static bool is_kasan_insn(struct instruction *insn)
 {
 	return (insn->type == INSN_CALL &&
@@ -1150,12 +1991,23 @@ static bool is_ubsan_insn(struct instruction *insn)
 			"__ubsan_handle_builtin_unreachable"));
 }
 
-static bool ignore_unreachable_insn(struct symbol *func,
-				    struct instruction *insn)
+static bool ignore_unreachable_insn(struct instruction *insn)
 {
 	int i;
 
-	if (insn->type == INSN_NOP)
+	if (insn->ignore || insn->type == INSN_NOP)
+		return true;
+
+	/*
+	 * Ignore any unused exceptions.  This can happen when a whitelisted
+	 * function has an exception table entry.
+	 *
+	 * Also ignore alternative replacement instructions.  This can happen
+	 * when a whitelisted function uses one of the ALTERNATIVE macros.
+	 */
+	if (!strcmp(insn->sec->name, ".fixup") ||
+	    !strcmp(insn->sec->name, ".altinstr_replacement") ||
+	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
 	/*
@@ -1164,18 +2016,26 @@ static bool ignore_unreachable_insn(struct symbol *func,
 	 *
 	 * End the search at 5 instructions to avoid going into the weeds.
 	 */
+	if (!insn->func)
+		return false;
 	for (i = 0; i < 5; i++) {
 
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
 			return true;
 
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest) {
-			insn = insn->jump_dest;
-			continue;
+		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+			if (insn->jump_dest &&
+			    insn->jump_dest->func == insn->func) {
+				insn = insn->jump_dest;
+				continue;
+			}
+
+			break;
 		}
 
-		if (insn->offset + insn->len >= func->offset + func->len)
+		if (insn->offset + insn->len >= insn->func->offset + insn->func->len)
 			break;
+
 		insn = list_next_entry(insn, list);
 	}
 
@@ -1187,81 +2047,49 @@ static int validate_functions(struct objtool_file *file)
 	struct section *sec;
 	struct symbol *func;
 	struct instruction *insn;
+	struct insn_state state;
 	int ret, warnings = 0;
 
-	list_for_each_entry(sec, &file->elf->sections, list) {
+	clear_insn_state(&state);
+
+	state.cfa = initial_func_cfi.cfa;
+	memcpy(&state.regs, &initial_func_cfi.regs,
+	       CFI_NUM_REGS * sizeof(struct cfi_reg));
+	state.stack_size = initial_func_cfi.cfa.offset;
+
+	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_FUNC)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
-			if (!insn)
+			if (!insn || insn->ignore)
 				continue;
 
-			ret = validate_branch(file, insn, 0);
+			ret = validate_branch(file, insn, state);
 			warnings += ret;
 		}
 	}
 
-	list_for_each_entry(sec, &file->elf->sections, list) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
-
-			func_for_each_insn(file, func, insn) {
-				if (insn->visited)
-					continue;
-
-				insn->visited = true;
-
-				if (file->ignore_unreachables || warnings ||
-				    ignore_unreachable_insn(func, insn))
-					continue;
-
-				/*
-				 * gcov produces a lot of unreachable
-				 * instructions.  If we get an unreachable
-				 * warning and the file has gcov enabled, just
-				 * ignore it, and all other such warnings for
-				 * the file.
-				 */
-				if (!file->ignore_unreachables &&
-				    gcov_enabled(file)) {
-					file->ignore_unreachables = true;
-					continue;
-				}
-
-				WARN_FUNC("function has unreachable instruction", insn->sec, insn->offset);
-				warnings++;
-			}
-		}
-	}
-
 	return warnings;
 }
 
-static int validate_uncallable_instructions(struct objtool_file *file)
+static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
-	int warnings = 0;
 
-	for_each_insn(file, insn) {
-		if (!insn->visited && insn->type == INSN_RETURN) {
+	if (file->ignore_unreachables)
+		return 0;
 
-			/*
-			 * Don't warn about call instructions in unvisited
-			 * retpoline alternatives.
-			 */
-			if (!strcmp(insn->sec->name, ".altinstr_replacement"))
-				continue;
+	for_each_insn(file, insn) {
+		if (insn->visited || ignore_unreachable_insn(insn))
+			continue;
 
-			WARN_FUNC("return instruction outside of a callable function",
-				  insn->sec, insn->offset);
-			warnings++;
-		}
+		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
+		return 1;
 	}
 
-	return warnings;
+	return 0;
 }
 
 static void cleanup(struct objtool_file *file)
@@ -1281,42 +2109,73 @@ static void cleanup(struct objtool_file *file)
 	elf_close(file->elf);
 }
 
-int check(const char *_objname, bool _nofp)
+int check(const char *_objname, bool orc)
 {
 	struct objtool_file file;
 	int ret, warnings = 0;
 
 	objname = _objname;
-	nofp = _nofp;
 
-	file.elf = elf_open(objname);
-	if (!file.elf) {
-		fprintf(stderr, "error reading elf file %s\n", objname);
+	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
+	if (!file.elf)
 		return 1;
-	}
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
 	file.rodata = find_section_by_name(file.elf, ".rodata");
-	file.ignore_unreachables = false;
 	file.c_file = find_section_by_name(file.elf, ".comment");
+	file.ignore_unreachables = no_unreachable;
+	file.hints = false;
+
+	arch_initial_func_cfi_state(&initial_func_cfi);
 
 	ret = decode_sections(&file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
+	if (list_empty(&file.insn_list))
+		goto out;
+
+	if (retpoline) {
+		ret = validate_retpoline(&file);
+		if (ret < 0)
+			return ret;
+		warnings += ret;
+	}
+
 	ret = validate_functions(&file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
-	ret = validate_uncallable_instructions(&file);
+	ret = validate_unwind_hints(&file);
 	if (ret < 0)
 		goto out;
 	warnings += ret;
 
+	if (!warnings) {
+		ret = validate_reachable_instructions(&file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
+	if (orc) {
+		ret = create_orc(&file);
+		if (ret < 0)
+			goto out;
+
+		ret = create_orc_sections(&file);
+		if (ret < 0)
+			goto out;
+
+		ret = elf_write(file.elf);
+		if (ret < 0)
+			goto out;
+	}
+
 out:
 	cleanup(&file);
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index aca248a049e0..c6b68fcb926f 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -20,22 +20,40 @@
 
 #include <stdbool.h>
 #include "elf.h"
+#include "cfi.h"
 #include "arch.h"
+#include "orc.h"
 #include <linux/hashtable.h>
 
+struct insn_state {
+	struct cfi_reg cfa;
+	struct cfi_reg regs[CFI_NUM_REGS];
+	int stack_size;
+	unsigned char type;
+	bool bp_scratch;
+	bool drap;
+	int drap_reg, drap_offset;
+	struct cfi_reg vals[CFI_NUM_REGS];
+};
+
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct section *sec;
 	unsigned long offset;
-	unsigned int len, state;
+	unsigned int len;
 	unsigned char type;
 	unsigned long immediate;
-	bool alt_group, visited, dead_end, ignore_alts;
+	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool retpoline_safe;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
 	struct list_head alts;
 	struct symbol *func;
+	struct stack_op stack_op;
+	struct insn_state state;
+	struct orc_entry orc;
 };
 
 struct objtool_file {
@@ -43,9 +61,22 @@ struct objtool_file {
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
 	struct section *rodata, *whitelist;
-	bool ignore_unreachables, c_file;
+	bool ignore_unreachables, c_file, hints;
 };
 
-int check(const char *objname, bool nofp);
+int check(const char *objname, bool orc);
+
+struct instruction *find_insn(struct objtool_file *file,
+			      struct section *sec, unsigned long offset);
+
+#define for_each_insn(file, insn)					\
+	list_for_each_entry(insn, &file->insn_list, list)
+
+#define sec_for_each_insn(file, sec, insn)				\
+	for (insn = find_insn(file, sec, 0);				\
+	     insn && &insn->list != &file->insn_list &&			\
+			insn->sec == sec;				\
+	     insn = list_next_entry(insn, list))
+
 
 #endif /* _CHECK_H */
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index faacf0c89976..c1c338661699 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -31,13 +31,6 @@
 #include "elf.h"
 #include "warn.h"
 
-/*
- * Fallback for systems without this "read, mmaping if possible" cmd.
- */
-#ifndef ELF_C_READ_MMAP
-#define ELF_C_READ_MMAP ELF_C_READ
-#endif
-
 struct section *find_section_by_name(struct elf *elf, const char *name)
 {
 	struct section *sec;
@@ -140,12 +133,12 @@ static int read_sections(struct elf *elf)
 	int i;
 
 	if (elf_getshdrnum(elf->elf, &sections_nr)) {
-		perror("elf_getshdrnum");
+		WARN_ELF("elf_getshdrnum");
 		return -1;
 	}
 
 	if (elf_getshdrstrndx(elf->elf, &shstrndx)) {
-		perror("elf_getshdrstrndx");
+		WARN_ELF("elf_getshdrstrndx");
 		return -1;
 	}
 
@@ -166,37 +159,37 @@ static int read_sections(struct elf *elf)
 
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
-			perror("elf_getscn");
+			WARN_ELF("elf_getscn");
 			return -1;
 		}
 
 		sec->idx = elf_ndxscn(s);
 
 		if (!gelf_getshdr(s, &sec->sh)) {
-			perror("gelf_getshdr");
+			WARN_ELF("gelf_getshdr");
 			return -1;
 		}
 
 		sec->name = elf_strptr(elf->elf, shstrndx, sec->sh.sh_name);
 		if (!sec->name) {
-			perror("elf_strptr");
-			return -1;
-		}
-
-		sec->elf_data = elf_getdata(s, NULL);
-		if (!sec->elf_data) {
-			perror("elf_getdata");
+			WARN_ELF("elf_strptr");
 			return -1;
 		}
 
-		if (sec->elf_data->d_off != 0 ||
-		    sec->elf_data->d_size != sec->sh.sh_size) {
-			WARN("unexpected data attributes for %s", sec->name);
-			return -1;
+		if (sec->sh.sh_size != 0) {
+			sec->data = elf_getdata(s, NULL);
+			if (!sec->data) {
+				WARN_ELF("elf_getdata");
+				return -1;
+			}
+			if (sec->data->d_off != 0 ||
+			    sec->data->d_size != sec->sh.sh_size) {
+				WARN("unexpected data attributes for %s",
+				     sec->name);
+				return -1;
+			}
 		}
-
-		sec->data = (unsigned long)sec->elf_data->d_buf;
-		sec->len = sec->elf_data->d_size;
+		sec->len = sec->sh.sh_size;
 	}
 
 	/* sanity check, one more call to elf_nextscn() should return NULL */
@@ -233,15 +226,15 @@ static int read_symbols(struct elf *elf)
 
 		sym->idx = i;
 
-		if (!gelf_getsym(symtab->elf_data, i, &sym->sym)) {
-			perror("gelf_getsym");
+		if (!gelf_getsym(symtab->data, i, &sym->sym)) {
+			WARN_ELF("gelf_getsym");
 			goto err;
 		}
 
 		sym->name = elf_strptr(elf->elf, symtab->sh.sh_link,
 				       sym->sym.st_name);
 		if (!sym->name) {
-			perror("elf_strptr");
+			WARN_ELF("elf_strptr");
 			goto err;
 		}
 
@@ -323,8 +316,8 @@ static int read_relas(struct elf *elf)
 			}
 			memset(rela, 0, sizeof(*rela));
 
-			if (!gelf_getrela(sec->elf_data, i, &rela->rela)) {
-				perror("gelf_getrela");
+			if (!gelf_getrela(sec->data, i, &rela->rela)) {
+				WARN_ELF("gelf_getrela");
 				return -1;
 			}
 
@@ -348,9 +341,10 @@ static int read_relas(struct elf *elf)
 	return 0;
 }
 
-struct elf *elf_open(const char *name)
+struct elf *elf_open(const char *name, int flags)
 {
 	struct elf *elf;
+	Elf_Cmd cmd;
 
 	elf_version(EV_CURRENT);
 
@@ -363,27 +357,28 @@ struct elf *elf_open(const char *name)
 
 	INIT_LIST_HEAD(&elf->sections);
 
-	elf->name = strdup(name);
-	if (!elf->name) {
-		perror("strdup");
-		goto err;
-	}
-
-	elf->fd = open(name, O_RDONLY);
+	elf->fd = open(name, flags);
 	if (elf->fd == -1) {
 		fprintf(stderr, "objtool: Can't open '%s': %s\n",
 			name, strerror(errno));
 		goto err;
 	}
 
-	elf->elf = elf_begin(elf->fd, ELF_C_READ_MMAP, NULL);
+	if ((flags & O_ACCMODE) == O_RDONLY)
+		cmd = ELF_C_READ_MMAP;
+	else if ((flags & O_ACCMODE) == O_RDWR)
+		cmd = ELF_C_RDWR;
+	else /* O_WRONLY */
+		cmd = ELF_C_WRITE;
+
+	elf->elf = elf_begin(elf->fd, cmd, NULL);
 	if (!elf->elf) {
-		perror("elf_begin");
+		WARN_ELF("elf_begin");
 		goto err;
 	}
 
 	if (!gelf_getehdr(elf->elf, &elf->ehdr)) {
-		perror("gelf_getehdr");
+		WARN_ELF("gelf_getehdr");
 		goto err;
 	}
 
@@ -403,12 +398,212 @@ struct elf *elf_open(const char *name)
 	return NULL;
 }
 
+struct section *elf_create_section(struct elf *elf, const char *name,
+				   size_t entsize, int nr)
+{
+	struct section *sec, *shstrtab;
+	size_t size = entsize * nr;
+	struct Elf_Scn *s;
+	Elf_Data *data;
+
+	sec = malloc(sizeof(*sec));
+	if (!sec) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(sec, 0, sizeof(*sec));
+
+	INIT_LIST_HEAD(&sec->symbol_list);
+	INIT_LIST_HEAD(&sec->rela_list);
+	hash_init(sec->rela_hash);
+	hash_init(sec->symbol_hash);
+
+	list_add_tail(&sec->list, &elf->sections);
+
+	s = elf_newscn(elf->elf);
+	if (!s) {
+		WARN_ELF("elf_newscn");
+		return NULL;
+	}
+
+	sec->name = strdup(name);
+	if (!sec->name) {
+		perror("strdup");
+		return NULL;
+	}
+
+	sec->idx = elf_ndxscn(s);
+	sec->len = size;
+	sec->changed = true;
+
+	sec->data = elf_newdata(s);
+	if (!sec->data) {
+		WARN_ELF("elf_newdata");
+		return NULL;
+	}
+
+	sec->data->d_size = size;
+	sec->data->d_align = 1;
+
+	if (size) {
+		sec->data->d_buf = malloc(size);
+		if (!sec->data->d_buf) {
+			perror("malloc");
+			return NULL;
+		}
+		memset(sec->data->d_buf, 0, size);
+	}
+
+	if (!gelf_getshdr(s, &sec->sh)) {
+		WARN_ELF("gelf_getshdr");
+		return NULL;
+	}
+
+	sec->sh.sh_size = size;
+	sec->sh.sh_entsize = entsize;
+	sec->sh.sh_type = SHT_PROGBITS;
+	sec->sh.sh_addralign = 1;
+	sec->sh.sh_flags = SHF_ALLOC;
+
+
+	/* Add section name to .shstrtab */
+	shstrtab = find_section_by_name(elf, ".shstrtab");
+	if (!shstrtab) {
+		WARN("can't find .shstrtab section");
+		return NULL;
+	}
+
+	s = elf_getscn(elf->elf, shstrtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return NULL;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return NULL;
+	}
+
+	data->d_buf = sec->name;
+	data->d_size = strlen(name) + 1;
+	data->d_align = 1;
+
+	sec->sh.sh_name = shstrtab->len;
+
+	shstrtab->len += strlen(name) + 1;
+	shstrtab->changed = true;
+
+	return sec;
+}
+
+struct section *elf_create_rela_section(struct elf *elf, struct section *base)
+{
+	char *relaname;
+	struct section *sec;
+
+	relaname = malloc(strlen(base->name) + strlen(".rela") + 1);
+	if (!relaname) {
+		perror("malloc");
+		return NULL;
+	}
+	strcpy(relaname, ".rela");
+	strcat(relaname, base->name);
+
+	sec = elf_create_section(elf, relaname, sizeof(GElf_Rela), 0);
+	free(relaname);
+	if (!sec)
+		return NULL;
+
+	base->rela = sec;
+	sec->base = base;
+
+	sec->sh.sh_type = SHT_RELA;
+	sec->sh.sh_addralign = 8;
+	sec->sh.sh_link = find_section_by_name(elf, ".symtab")->idx;
+	sec->sh.sh_info = base->idx;
+	sec->sh.sh_flags = SHF_INFO_LINK;
+
+	return sec;
+}
+
+int elf_rebuild_rela_section(struct section *sec)
+{
+	struct rela *rela;
+	int nr, idx = 0, size;
+	GElf_Rela *relas;
+
+	nr = 0;
+	list_for_each_entry(rela, &sec->rela_list, list)
+		nr++;
+
+	size = nr * sizeof(*relas);
+	relas = malloc(size);
+	if (!relas) {
+		perror("malloc");
+		return -1;
+	}
+
+	sec->data->d_buf = relas;
+	sec->data->d_size = size;
+
+	sec->sh.sh_size = size;
+
+	idx = 0;
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		relas[idx].r_offset = rela->offset;
+		relas[idx].r_addend = rela->addend;
+		relas[idx].r_info = GELF_R_INFO(rela->sym->idx, rela->type);
+		idx++;
+	}
+
+	return 0;
+}
+
+int elf_write(struct elf *elf)
+{
+	struct section *sec;
+	Elf_Scn *s;
+
+	/* Update section headers for changed sections: */
+	list_for_each_entry(sec, &elf->sections, list) {
+		if (sec->changed) {
+			s = elf_getscn(elf->elf, sec->idx);
+			if (!s) {
+				WARN_ELF("elf_getscn");
+				return -1;
+			}
+			if (!gelf_update_shdr(s, &sec->sh)) {
+				WARN_ELF("gelf_update_shdr");
+				return -1;
+			}
+		}
+	}
+
+	/* Make sure the new section header entries get updated properly. */
+	elf_flagelf(elf->elf, ELF_C_SET, ELF_F_DIRTY);
+
+	/* Write all changes to the file. */
+	if (elf_update(elf->elf, ELF_C_WRITE) < 0) {
+		WARN_ELF("elf_update");
+		return -1;
+	}
+
+	return 0;
+}
+
 void elf_close(struct elf *elf)
 {
 	struct section *sec, *tmpsec;
 	struct symbol *sym, *tmpsym;
 	struct rela *rela, *tmprela;
 
+	if (elf->elf)
+		elf_end(elf->elf);
+
+	if (elf->fd > 0)
+		close(elf->fd);
+
 	list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
 		list_for_each_entry_safe(sym, tmpsym, &sec->symbol_list, list) {
 			list_del(&sym->list);
@@ -423,11 +618,6 @@ void elf_close(struct elf *elf)
 		list_del(&sec->list);
 		free(sec);
 	}
-	if (elf->name)
-		free(elf->name);
-	if (elf->fd > 0)
-		close(elf->fd);
-	if (elf->elf)
-		elf_end(elf->elf);
+
 	free(elf);
 }
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 731973e1a3f5..d86e2ff14466 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -28,6 +28,13 @@
 # define elf_getshdrstrndx elf_getshstrndx
 #endif
 
+/*
+ * Fallback for systems without this "read, mmaping if possible" cmd.
+ */
+#ifndef ELF_C_READ_MMAP
+#define ELF_C_READ_MMAP ELF_C_READ
+#endif
+
 struct section {
 	struct list_head list;
 	GElf_Shdr sh;
@@ -37,11 +44,11 @@ struct section {
 	DECLARE_HASHTABLE(rela_hash, 16);
 	struct section *base, *rela;
 	struct symbol *sym;
-	Elf_Data *elf_data;
+	Elf_Data *data;
 	char *name;
 	int idx;
-	unsigned long data;
 	unsigned int len;
+	bool changed, text;
 };
 
 struct symbol {
@@ -76,7 +83,7 @@ struct elf {
 };
 
 
-struct elf *elf_open(const char *name);
+struct elf *elf_open(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
@@ -84,8 +91,14 @@ struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
 				     unsigned int len);
 struct symbol *find_containing_func(struct section *sec, unsigned long offset);
+struct section *elf_create_section(struct elf *elf, const char *name, size_t
+				   entsize, int nr);
+struct section *elf_create_rela_section(struct elf *elf, struct section *base);
+int elf_rebuild_rela_section(struct section *sec);
+int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
 
-
+#define for_each_sec(file, sec)						\
+	list_for_each_entry(sec, &file->elf->sections, list)
 
 #endif /* _OBJTOOL_ELF_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 46c326db4f46..07f329919828 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -31,11 +31,10 @@
 #include <stdlib.h>
 #include <subcmd/exec-cmd.h>
 #include <subcmd/pager.h>
+#include <linux/kernel.h>
 
 #include "builtin.h"
 
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
-
 struct cmd_struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -43,10 +42,11 @@ struct cmd_struct {
 };
 
 static const char objtool_usage_string[] =
-	"objtool [OPTIONS] COMMAND [ARGS]";
+	"objtool COMMAND [ARGS]";
 
 static struct cmd_struct objtool_cmds[] = {
 	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
+	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
 };
 
 bool help;
@@ -70,7 +70,7 @@ static void cmd_usage(void)
 
 	printf("\n");
 
-	exit(1);
+	exit(129);
 }
 
 static void handle_options(int *argc, const char ***argv)
@@ -86,9 +86,7 @@ static void handle_options(int *argc, const char ***argv)
 			break;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
-			fprintf(stderr, "\n Usage: %s\n",
-				objtool_usage_string);
-			exit(1);
+			cmd_usage();
 		}
 
 		(*argv)++;
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
new file mode 100644
index 000000000000..b0e92a6d0903
--- /dev/null
+++ b/tools/objtool/orc.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ORC_H
+#define _ORC_H
+
+#include <asm/orc_types.h>
+
+struct objtool_file;
+
+int create_orc(struct objtool_file *file);
+int create_orc_sections(struct objtool_file *file);
+
+int orc_dump(const char *objname);
+
+#endif /* _ORC_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
new file mode 100644
index 000000000000..c3343820916a
--- /dev/null
+++ b/tools/objtool/orc_dump.c
@@ -0,0 +1,213 @@
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <unistd.h>
+#include "orc.h"
+#include "warn.h"
+
+static const char *reg_name(unsigned int reg)
+{
+	switch (reg) {
+	case ORC_REG_PREV_SP:
+		return "prevsp";
+	case ORC_REG_DX:
+		return "dx";
+	case ORC_REG_DI:
+		return "di";
+	case ORC_REG_BP:
+		return "bp";
+	case ORC_REG_SP:
+		return "sp";
+	case ORC_REG_R10:
+		return "r10";
+	case ORC_REG_R13:
+		return "r13";
+	case ORC_REG_BP_INDIRECT:
+		return "bp(ind)";
+	case ORC_REG_SP_INDIRECT:
+		return "sp(ind)";
+	default:
+		return "?";
+	}
+}
+
+static const char *orc_type_name(unsigned int type)
+{
+	switch (type) {
+	case ORC_TYPE_CALL:
+		return "call";
+	case ORC_TYPE_REGS:
+		return "regs";
+	case ORC_TYPE_REGS_IRET:
+		return "iret";
+	default:
+		return "?";
+	}
+}
+
+static void print_reg(unsigned int reg, int offset)
+{
+	if (reg == ORC_REG_BP_INDIRECT)
+		printf("(bp%+d)", offset);
+	else if (reg == ORC_REG_SP_INDIRECT)
+		printf("(sp%+d)", offset);
+	else if (reg == ORC_REG_UNDEFINED)
+		printf("(und)");
+	else
+		printf("%s%+d", reg_name(reg), offset);
+}
+
+int orc_dump(const char *_objname)
+{
+	int fd, nr_entries, i, *orc_ip = NULL, orc_size = 0;
+	struct orc_entry *orc = NULL;
+	char *name;
+	size_t nr_sections;
+	Elf64_Addr orc_ip_addr = 0;
+	size_t shstrtab_idx;
+	Elf *elf;
+	Elf_Scn *scn;
+	GElf_Shdr sh;
+	GElf_Rela rela;
+	GElf_Sym sym;
+	Elf_Data *data, *symtab = NULL, *rela_orc_ip = NULL;
+
+
+	objname = _objname;
+
+	elf_version(EV_CURRENT);
+
+	fd = open(objname, O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return -1;
+	}
+
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf) {
+		WARN_ELF("elf_begin");
+		return -1;
+	}
+
+	if (elf_getshdrnum(elf, &nr_sections)) {
+		WARN_ELF("elf_getshdrnum");
+		return -1;
+	}
+
+	if (elf_getshdrstrndx(elf, &shstrtab_idx)) {
+		WARN_ELF("elf_getshdrstrndx");
+		return -1;
+	}
+
+	for (i = 0; i < nr_sections; i++) {
+		scn = elf_getscn(elf, i);
+		if (!scn) {
+			WARN_ELF("elf_getscn");
+			return -1;
+		}
+
+		if (!gelf_getshdr(scn, &sh)) {
+			WARN_ELF("gelf_getshdr");
+			return -1;
+		}
+
+		name = elf_strptr(elf, shstrtab_idx, sh.sh_name);
+		if (!name) {
+			WARN_ELF("elf_strptr");
+			return -1;
+		}
+
+		data = elf_getdata(scn, NULL);
+		if (!data) {
+			WARN_ELF("elf_getdata");
+			return -1;
+		}
+
+		if (!strcmp(name, ".symtab")) {
+			symtab = data;
+		} else if (!strcmp(name, ".orc_unwind")) {
+			orc = data->d_buf;
+			orc_size = sh.sh_size;
+		} else if (!strcmp(name, ".orc_unwind_ip")) {
+			orc_ip = data->d_buf;
+			orc_ip_addr = sh.sh_addr;
+		} else if (!strcmp(name, ".rela.orc_unwind_ip")) {
+			rela_orc_ip = data;
+		}
+	}
+
+	if (!symtab || !orc || !orc_ip)
+		return 0;
+
+	if (orc_size % sizeof(*orc) != 0) {
+		WARN("bad .orc_unwind section size");
+		return -1;
+	}
+
+	nr_entries = orc_size / sizeof(*orc);
+	for (i = 0; i < nr_entries; i++) {
+		if (rela_orc_ip) {
+			if (!gelf_getrela(rela_orc_ip, i, &rela)) {
+				WARN_ELF("gelf_getrela");
+				return -1;
+			}
+
+			if (!gelf_getsym(symtab, GELF_R_SYM(rela.r_info), &sym)) {
+				WARN_ELF("gelf_getsym");
+				return -1;
+			}
+
+			scn = elf_getscn(elf, sym.st_shndx);
+			if (!scn) {
+				WARN_ELF("elf_getscn");
+				return -1;
+			}
+
+			if (!gelf_getshdr(scn, &sh)) {
+				WARN_ELF("gelf_getshdr");
+				return -1;
+			}
+
+			name = elf_strptr(elf, shstrtab_idx, sh.sh_name);
+			if (!name || !*name) {
+				WARN_ELF("elf_strptr");
+				return -1;
+			}
+
+			printf("%s+%llx:", name, (unsigned long long)rela.r_addend);
+
+		} else {
+			printf("%llx:", (unsigned long long)(orc_ip_addr + (i * sizeof(int)) + orc_ip[i]));
+		}
+
+
+		printf(" sp:");
+
+		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+
+		printf(" bp:");
+
+		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+
+		printf(" type:%s\n", orc_type_name(orc[i].type));
+	}
+
+	elf_end(elf);
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
new file mode 100644
index 000000000000..18384d9be4e1
--- /dev/null
+++ b/tools/objtool/orc_gen.c
@@ -0,0 +1,221 @@
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+
+#include "orc.h"
+#include "check.h"
+#include "warn.h"
+
+int create_orc(struct objtool_file *file)
+{
+	struct instruction *insn;
+
+	for_each_insn(file, insn) {
+		struct orc_entry *orc = &insn->orc;
+		struct cfi_reg *cfa = &insn->state.cfa;
+		struct cfi_reg *bp = &insn->state.regs[CFI_BP];
+
+		if (cfa->base == CFI_UNDEFINED) {
+			orc->sp_reg = ORC_REG_UNDEFINED;
+			continue;
+		}
+
+		switch (cfa->base) {
+		case CFI_SP:
+			orc->sp_reg = ORC_REG_SP;
+			break;
+		case CFI_SP_INDIRECT:
+			orc->sp_reg = ORC_REG_SP_INDIRECT;
+			break;
+		case CFI_BP:
+			orc->sp_reg = ORC_REG_BP;
+			break;
+		case CFI_BP_INDIRECT:
+			orc->sp_reg = ORC_REG_BP_INDIRECT;
+			break;
+		case CFI_R10:
+			orc->sp_reg = ORC_REG_R10;
+			break;
+		case CFI_R13:
+			orc->sp_reg = ORC_REG_R13;
+			break;
+		case CFI_DI:
+			orc->sp_reg = ORC_REG_DI;
+			break;
+		case CFI_DX:
+			orc->sp_reg = ORC_REG_DX;
+			break;
+		default:
+			WARN_FUNC("unknown CFA base reg %d",
+				  insn->sec, insn->offset, cfa->base);
+			return -1;
+		}
+
+		switch(bp->base) {
+		case CFI_UNDEFINED:
+			orc->bp_reg = ORC_REG_UNDEFINED;
+			break;
+		case CFI_CFA:
+			orc->bp_reg = ORC_REG_PREV_SP;
+			break;
+		case CFI_BP:
+			orc->bp_reg = ORC_REG_BP;
+			break;
+		default:
+			WARN_FUNC("unknown BP base reg %d",
+				  insn->sec, insn->offset, bp->base);
+			return -1;
+		}
+
+		orc->sp_offset = cfa->offset;
+		orc->bp_offset = bp->offset;
+		orc->type = insn->state.type;
+	}
+
+	return 0;
+}
+
+static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
+				unsigned int idx, struct section *insn_sec,
+				unsigned long insn_off, struct orc_entry *o)
+{
+	struct orc_entry *orc;
+	struct rela *rela;
+
+	if (!insn_sec->sym) {
+		WARN("missing symbol for section %s", insn_sec->name);
+		return -1;
+	}
+
+	/* populate ORC data */
+	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
+	memcpy(orc, o, sizeof(*orc));
+
+	/* populate rela for ip */
+	rela = malloc(sizeof(*rela));
+	if (!rela) {
+		perror("malloc");
+		return -1;
+	}
+	memset(rela, 0, sizeof(*rela));
+
+	rela->sym = insn_sec->sym;
+	rela->addend = insn_off;
+	rela->type = R_X86_64_PC32;
+	rela->offset = idx * sizeof(int);
+
+	list_add_tail(&rela->list, &ip_relasec->rela_list);
+	hash_add(ip_relasec->rela_hash, &rela->hash, rela->offset);
+
+	return 0;
+}
+
+int create_orc_sections(struct objtool_file *file)
+{
+	struct instruction *insn, *prev_insn;
+	struct section *sec, *u_sec, *ip_relasec;
+	unsigned int idx;
+
+	struct orc_entry empty = {
+		.sp_reg = ORC_REG_UNDEFINED,
+		.bp_reg  = ORC_REG_UNDEFINED,
+		.type    = ORC_TYPE_CALL,
+	};
+
+	sec = find_section_by_name(file->elf, ".orc_unwind");
+	if (sec) {
+		WARN("file already has .orc_unwind section, skipping");
+		return -1;
+	}
+
+	/* count the number of needed orcs */
+	idx = 0;
+	for_each_sec(file, sec) {
+		if (!sec->text)
+			continue;
+
+		prev_insn = NULL;
+		sec_for_each_insn(file, sec, insn) {
+			if (!prev_insn ||
+			    memcmp(&insn->orc, &prev_insn->orc,
+				   sizeof(struct orc_entry))) {
+				idx++;
+			}
+			prev_insn = insn;
+		}
+
+		/* section terminator */
+		if (prev_insn)
+			idx++;
+	}
+	if (!idx)
+		return -1;
+
+
+	/* create .orc_unwind_ip and .rela.orc_unwind_ip sections */
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", sizeof(int), idx);
+	if (!sec)
+		return -1;
+
+	ip_relasec = elf_create_rela_section(file->elf, sec);
+	if (!ip_relasec)
+		return -1;
+
+	/* create .orc_unwind section */
+	u_sec = elf_create_section(file->elf, ".orc_unwind",
+				   sizeof(struct orc_entry), idx);
+
+	/* populate sections */
+	idx = 0;
+	for_each_sec(file, sec) {
+		if (!sec->text)
+			continue;
+
+		prev_insn = NULL;
+		sec_for_each_insn(file, sec, insn) {
+			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
+						 sizeof(struct orc_entry))) {
+
+				if (create_orc_entry(u_sec, ip_relasec, idx,
+						     insn->sec, insn->offset,
+						     &insn->orc))
+					return -1;
+
+				idx++;
+			}
+			prev_insn = insn;
+		}
+
+		/* section terminator */
+		if (prev_insn) {
+			if (create_orc_entry(u_sec, ip_relasec, idx,
+					     prev_insn->sec,
+					     prev_insn->offset + prev_insn->len,
+					     &empty))
+				return -1;
+
+			idx++;
+		}
+	}
+
+	if (elf_rebuild_rela_section(ip_relasec))
+		return -1;
+
+	return 0;
+}
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index bff8abb3a4aa..84f001d52322 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -91,16 +91,16 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 	alt->jump_or_nop = entry->jump_or_nop;
 
 	if (alt->group) {
-		alt->orig_len = *(unsigned char *)(sec->data + offset +
+		alt->orig_len = *(unsigned char *)(sec->data->d_buf + offset +
 						   entry->orig_len);
-		alt->new_len = *(unsigned char *)(sec->data + offset +
+		alt->new_len = *(unsigned char *)(sec->data->d_buf + offset +
 						  entry->new_len);
 	}
 
 	if (entry->feature) {
 		unsigned short feature;
 
-		feature = *(unsigned short *)(sec->data + offset +
+		feature = *(unsigned short *)(sec->data->d_buf + offset +
 					      entry->feature);
 
 		/*
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
new file mode 100644
index 000000000000..1470e74e9d66
--- /dev/null
+++ b/tools/objtool/sync-check.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+FILES='
+arch/x86/lib/insn.c
+arch/x86/lib/inat.c
+arch/x86/lib/x86-opcode-map.txt
+arch/x86/tools/gen-insn-attr-x86.awk
+arch/x86/include/asm/insn.h
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/inat_types.h
+arch/x86/include/asm/orc_types.h
+'
+
+check()
+{
+	local file=$1
+
+	diff $file ../../$file > /dev/null ||
+		echo "Warning: synced file at 'tools/objtool/$file' differs from latest kernel version at '$file'"
+}
+
+if [ ! -d ../../kernel ] || [ ! -d ../../tools ] || [ ! -d ../objtool ]; then
+	exit 0
+fi
+
+for i in $FILES; do
+  check $i
+done
diff --git a/tools/objtool/warn.h b/tools/objtool/warn.h
index ac7e07523e84..afd9f7a05f6d 100644
--- a/tools/objtool/warn.h
+++ b/tools/objtool/warn.h
@@ -18,6 +18,13 @@
 #ifndef _WARN_H
 #define _WARN_H
 
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "elf.h"
+
 extern const char *objname;
 
 static inline char *offstr(struct section *sec, unsigned long offset)
@@ -57,4 +64,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	free(_str);					\
 })
 
+#define WARN_ELF(format, ...)				\
+	WARN(format ": %s", ##__VA_ARGS__, elf_errmsg(-1))
+
 #endif /* _WARN_H */
-- 
2.17.1
