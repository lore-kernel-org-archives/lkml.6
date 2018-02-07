Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeBGO7a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:59:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:3908 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754108AbeBGO72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:59:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="17976783"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 1/3] x86: Introduce patchable constants
Date: Wed,  7 Feb 2018 17:59:11 +0300
Message-Id: <20180207145913.2703-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces concept of patchable constants: constant values
that can be adjusted at boot-time in response to system configuration or
user input (kernel command-line).

Patchable constants can replace variables that never changes at runtime
(only at boot-time), but used in very hot path.

Patchable constants implemented by replacing a constant with call to
inline function that returns the constant value using inline assembler.
In inline assembler we also write down into separate section location of
the instruction that loads the constant. This way we can find the
location later and adjust the value.

The implementation only supports unsigned 64-bit values on 64-bit
systems. We can add support for other data types later.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                       |   4 ++
 arch/x86/include/asm/patchable_const.h |  28 ++++++++
 arch/x86/kernel/Makefile               |   3 +
 arch/x86/kernel/module.c               |  14 ++++
 arch/x86/kernel/patchable_const.c      | 114 +++++++++++++++++++++++++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 arch/x86/include/asm/patchable_const.h
 create mode 100644 arch/x86/kernel/patchable_const.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0771ceabb4b..78fc28e4f643 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -337,6 +337,10 @@ config PGTABLE_LEVELS
 	default 3 if X86_PAE
 	default 2
 
+config PATCHABLE_CONST
+	bool
+	depends on X86_64
+
 source "init/Kconfig"
 source "kernel/Kconfig.freezer"
 
diff --git a/arch/x86/include/asm/patchable_const.h b/arch/x86/include/asm/patchable_const.h
new file mode 100644
index 000000000000..a432da46a46e
--- /dev/null
+++ b/arch/x86/include/asm/patchable_const.h
@@ -0,0 +1,28 @@
+#ifndef __X86_PATCHABLE_CONST
+#define __X86_PATCHABLE_CONST
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <linux/stringify.h>
+#include <asm/asm.h>
+
+void module_patch_const_u64(const char *name,
+	       unsigned long **start, unsigned long **stop);
+
+#define DECLARE_PATCHABLE_CONST_U64(id_str)					\
+extern int id_str ## _SET(u64 value);						\
+static __always_inline __attribute_const__ u64 id_str ## _READ(void)		\
+{										\
+       u64 ret;									\
+       asm (									\
+	       "1: movabsq $(" __stringify(id_str ## _DEFAULT) "), %0\n"	\
+	       ".pushsection \"const_u64_" __stringify(id_str) "\",\"a\"\n"	\
+	       _ASM_PTR "1b\n"							\
+	       ".popsection\n" : "=r" (ret));					\
+       return ret;								\
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 29786c87e864..e6a2e400f236 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -20,6 +20,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_patchable_const.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -27,6 +28,7 @@ KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
+KASAN_SANITIZE_patchable_const.o			:= n
 
 OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o	:= y
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
@@ -110,6 +112,7 @@ obj-$(CONFIG_AMD_NB)		+= amd_nb.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
+obj-$(CONFIG_PATCHABLE_CONST)	+= patchable_const.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_$(BITS).o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index da0c160e5589..eeb80b39fa89 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -36,6 +36,7 @@
 #include <asm/pgtable.h>
 #include <asm/setup.h>
 #include <asm/unwind.h>
+#include <asm/patchable_const.h>
 
 #if 0
 #define DEBUGP(fmt, ...)				\
@@ -243,6 +244,19 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
 			orc_ip = s;
+
+		if (IS_ENABLED(CONFIG_PATCHABLE_CONST) &&
+				!strncmp(secstrings + s->sh_name,
+					"const_u64_", strlen("const_u64_"))) {
+			const char *name;
+			unsigned long **start, **stop;
+
+			name = secstrings + s->sh_name + strlen("const_u64_");
+			start = (void *)s->sh_addr;
+			stop = (void *)s->sh_addr + s->sh_size;
+
+			module_patch_const_u64(name, start, stop);
+		}
 	}
 
 	if (alt) {
diff --git a/arch/x86/kernel/patchable_const.c b/arch/x86/kernel/patchable_const.c
new file mode 100644
index 000000000000..d44d91cafee2
--- /dev/null
+++ b/arch/x86/kernel/patchable_const.c
@@ -0,0 +1,114 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/memory.h>
+#include <linux/module.h>
+#include <asm/insn.h>
+#include <asm/text-patching.h>
+
+struct const_u64_table {
+	const char *name;
+	u64 orig;
+	u64 *new;
+};
+
+#define PATCHABLE_CONST_U64(id_str)						\
+extern unsigned long *__start_const_u64_ ## id_str[];				\
+extern unsigned long *__stop_const_u64_ ## id_str[];				\
+static __init_or_module u64 id_str ## _CURRENT = id_str ## _DEFAULT;		\
+__init __nostackprotector int id_str ## _SET(u64 new)				\
+{										\
+	int ret;								\
+	ret = patch_const_u64(__start_const_u64_ ## id_str,			\
+			__stop_const_u64_ ## id_str, id_str ## _CURRENT, new);	\
+	if (!ret)								\
+		id_str ## _CURRENT = new;					\
+	return ret;								\
+}
+
+static __init_or_module __nostackprotector
+int patch_const_u64(unsigned long **start, unsigned long **stop,
+		u64 orig, u64 new)
+{
+	char buf[MAX_INSN_SIZE];
+	struct insn insn;
+	unsigned long **iter;
+
+	pr_debug("Patch const: %#llx -> %#llx\n", orig, new);
+
+	mutex_lock(&text_mutex);
+	for (iter = start; iter < stop; iter++) {
+		memcpy(buf, *iter, MAX_INSN_SIZE);
+
+		kernel_insn_init(&insn, buf, MAX_INSN_SIZE);
+		insn_get_length(&insn);
+
+		/*
+		 * We expect to see 10-byte MOV instruction here:
+		 *  - 1 byte REX prefix;
+		 *  - 1 byte opcode;
+		 *  - 8 byte immediate value;
+		 *
+		 * Back off, if something else is found.
+		 */
+		if (insn.length != 10)
+			break;
+
+		insn_get_opcode(&insn);
+
+		/* MOV r64, imm64: REX.W + B8 + rd io */
+		if (!X86_REX_W(insn.rex_prefix.bytes[0]))
+			break;
+		if ((insn.opcode.bytes[0] & ~7) != 0xb8)
+			break;
+
+		/* Check that the original value is correct */
+		if (memcmp(buf + 2, &orig, sizeof(orig)))
+			break;
+
+		memcpy(buf + 2, &new, 8);
+		text_poke(*iter, buf, 10);
+	}
+
+	if (iter == stop) {
+		/* Everything if fine: DONE */
+		mutex_unlock(&text_mutex);
+		return 0;
+	}
+
+	/* Something went wrong. */
+	pr_err("Unexpected instruction found at %px: %10ph\n", iter, buf);
+
+	/* Undo */
+	while (--iter != start) {
+		memcpy(&buf, *iter, MAX_INSN_SIZE);
+		memcpy(buf + 2, &orig, 8);
+		text_poke(*iter, buf, 10);
+	}
+
+	mutex_unlock(&text_mutex);
+	return -EFAULT;
+}
+
+#ifdef CONFIG_MODULES
+/* Add an entry for a constant here if it expected to be seen in the modules */
+static const struct const_u64_table const_u64_table[] = {
+};
+
+__init_or_module __nostackprotector
+void module_patch_const_u64(const char *name,
+		unsigned long **start, unsigned long **stop)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(const_u64_table); i++) {
+		if (strcmp(name, const_u64_table[i].name))
+			continue;
+
+		patch_const_u64(start, stop, const_u64_table[i].orig,
+				*const_u64_table[i].new);
+		return;
+	}
+
+	pr_err("Unknown patchable constant: '%s'\n", name);
+}
+#endif
-- 
2.15.1
