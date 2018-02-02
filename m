Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBBVOL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:14:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:52447 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeBBVOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:14:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="27643317"
Subject: [PATCH] x86/kvm: clear RSB before VMENTER to obscure host addresses
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        luto@amacapital.net, ak@linux.intel.com, jun.nakajima@intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com, dwmw2@infradead.org,
        pbonzini@redhat.com, keescook@google.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 02 Feb 2018 13:10:28 -0800
Message-Id: <20180202211028.0A49AAAD@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm posting this because I went to the trouble of hacking it together
and writing up a pretty lengthy description of what it does and where
it _might_ have benefit.  But, I'm rather unconvinced that mitigation
of attacks on ASLR has a lot of value because of how many other
attacks on ASLR there are.

Thus, the RFC.

---

Mitigation: clear the RSB before entering a guest
Mitigates against: guest discovering host addresses (user or
		   kernel), defeating ASLR (kernel or user).
Useful on: all processors with an RSB not cleared at VMENTER
Does not mitigate: poisoned RSB or BTB (Spectre / Variant 2)

The Return Stack Buffer is conceptually a microarchitectural stack in
the CPU that remembers a limited of return addresses.  It is pushed at
'call' time and 'popped' at 'ret'.  It ensures precise prediction of
the targets of 'ret' instructions.  There is also a description of it
here:

	https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

A guest may be able to determine the contents of the RSB by doing a
series of unbalanced 'ret' instructions and observing the effects from
the speculative jumps that may be executed based on its contents.
This gives the guest a mechanism by which it can locate host text
addresses (kernel or userspace) and defeat ASLR.

Even when using the existing kernel RSB-clearing primitives, the
address of the clearing code could be leaked, helping defeat KASLR.

To avoid this, use RSB-clearing code that is separate from the rest of
kernel text.  This removes information which could be valuable to an
exploit.  It is important that it be __always_inline because a normal
call/ret of any kind could theoretically leave valuable information
in the RSB.

We place the new code in the entry trampoline.  This already has an
alias and it is also something that may be randomized in the future.
Also, the page where this code is has plenty of space which means
that the new code _there_ consumes no extra memory.

Notes:
 * I started on this because I was told that the Google Project Zero
   exploits for Variant 2 actually used this mechanism.  However, I
   have not found an _actual_ exploit against which this approach
   provides mitigation.  Google Project Zero attempted to exploit
   this, but it had not "yielded conclusive results".  I've looked
   through the actual exploits and not found an instance of this
   mechanism being in used.
 * The call in the KVM code could be in assembly to be entirely
   compiler-proof.  But, I tried not to grow the existing inline
   asm monstrosity.  The compiler is surely _permitted_ to stick a
   call in here, but it would be insane to do that.
 * We need to use a retpoline to jump to the clearing code.  The
   vaddr is a constant, but x86 has no instruction to do an
   absolute jump/call to a constant, only register contents, which
   is an indirect call and uses the BTB.

Mitigation value:
 * The RSB contains host-userspace and host-kernel addresses, which
   makes it your one-stop-shopping when trying to break out of a
   guest.
 * Are there plenty of ways to defeat KASLR?  Yes.  But, they are
   hard to pull off from a guest itself.  To use the host-userspace
   to host-kernel exploits you need to break out of the guest
   first.
 * Existing RSB manipulation mitigation is focused on protecting
   higher-privilege 'ret' instructions from being manipulated by
   entries in the RSB placed by lower-privilege code.  However, these
   mitigations still leave higher-privilege RSB contents in place when
   calling lower-privilege code.

Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kees Cook <keescook@google.com>

---

 b/arch/x86/entry/entry_64.S             |   10 ++++++
 b/arch/x86/include/asm/cpu_entry_area.h |    4 ++
 b/arch/x86/include/asm/nospec-branch.h  |   46 ++++++++++++++++++++++++++++++++
 b/arch/x86/kvm/vmx.c                    |    7 ++++
 b/arch/x86/mm/cpu_entry_area.c          |   11 +++++++
 5 files changed, 78 insertions(+)

diff -puN arch/x86/entry/entry_64.S~rsb-stuff-on-vmenter arch/x86/entry/entry_64.S
--- a/arch/x86/entry/entry_64.S~rsb-stuff-on-vmenter	2018-01-24 11:05:38.668557406 -0800
+++ b/arch/x86/entry/entry_64.S	2018-01-29 08:29:52.142503318 -0800
@@ -191,6 +191,16 @@ ENTRY(entry_SYSCALL_64_trampoline)
 	JMP_NOSPEC %rdi
 END(entry_SYSCALL_64_trampoline)
 
+/*
+ * This is not used for kernel entry/exit.  But, we do need a virtual
+ * alias for it, and putting it next to the entry trampoline gives
+ * us that.
+ */
+ENTRY(reloc_clear_return_buffer)
+	__FILL_RETURN_BUFFER(%eax, RSB_CLEAR_LOOPS, %rsp)
+	ret
+END(reloc_clear_return_buffer)
+
 	.popsection
 
 ENTRY(entry_SYSCALL_64_stage2)
diff -puN arch/x86/include/asm/nospec-branch.h~rsb-stuff-on-vmenter arch/x86/include/asm/nospec-branch.h
--- a/arch/x86/include/asm/nospec-branch.h~rsb-stuff-on-vmenter	2018-01-24 11:05:38.670557406 -0800
+++ b/arch/x86/include/asm/nospec-branch.h	2018-01-24 11:30:45.955553647 -0800
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/cpu_entry_area.h>
 
 /*
  * Fill the CPU return stack buffer.
@@ -218,5 +219,50 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
+/*
+ * A guest may be able to dump the contents of the RSB by doing a series
+ * of unbalanced 'ret' instructions and observing the effects from the
+ * speculative jumps.  This gives the guest a mechanism by which it can
+ * locate host kernel text and defeat KASLR.
+ *
+ * To avoid this, use RSB-stuffing code that is separate from the rest of
+ * kernel text.  This removes information which could be valuable to an
+ * exploit.
+ */
+extern void reloc_clear_return_buffer(void);
+static __always_inline void vmenter_clear_RSB(void)
+{
+	/* Find the vaddr for the alias mapping of "_entry_trampoline": */
+	unsigned long entry_trampoline_base =
+		(unsigned long)&get_cpu_entry_area(0)->entry_trampoline;
+	/*
+	 * Get the normal kernel text vaddr of "_entry_trampoline".
+	 * Then get the vaddr of the RSB stuffing target which is in
+	 * the same section.
+	 */
+	unsigned long ktext_base = (unsigned long)&_entry_trampoline;
+	unsigned long ktext_tgt  = (unsigned long)&reloc_clear_return_buffer;
+	/*
+	 * Now figure out how far from the beginning of the section
+	 * our RSB-stuffing code is:
+	 */
+	unsigned long offset_from_base = ktext_tgt - ktext_base;
+	/*
+	 * Finally, calculat the full virtual address of the alias to
+	 * which we want to jump:
+	 */
+	unsigned long rsb_fill_fixed_vaddr = entry_trampoline_base
+					     + offset_from_base;
+	/*
+	 * Call to reloc_clear_return_buffer() via its alias in the
+	 * cpu_entry_area.  This indirect call needs a retpoline.
+	 *
+	 * reloc_clear_return_buffer uses %rax as a scratch register.
+	 */
+	asm volatile(CALL_NOSPEC
+		     : : [thunk_target]"D"(rsb_fill_fixed_vaddr)
+		     : "memory", "ax");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __NOSPEC_BRANCH_H__ */
diff -puN arch/x86/kvm/vmx.c~rsb-stuff-on-vmenter arch/x86/kvm/vmx.c
--- a/arch/x86/kvm/vmx.c~rsb-stuff-on-vmenter	2018-01-24 11:05:38.673557406 -0800
+++ b/arch/x86/kvm/vmx.c	2018-02-02 12:33:54.150604882 -0800
@@ -9299,6 +9299,13 @@ static void __noclone vmx_vcpu_run(struc
 	vmx_arm_hv_timer(vcpu);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
+
+	/*
+	 * Avoid leaking RSB contents to the guest.  Careful:
+	 * any 'ret' between this and VMENTER will potentially
+	 * create a new leak.
+	 */
+	vmenter_clear_RSB();
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
diff -puN arch/x86/include/asm/cpu_entry_area.h~rsb-stuff-on-vmenter arch/x86/include/asm/cpu_entry_area.h
--- a/arch/x86/include/asm/cpu_entry_area.h~rsb-stuff-on-vmenter	2018-01-24 11:10:05.808556740 -0800
+++ b/arch/x86/include/asm/cpu_entry_area.h	2018-01-24 11:12:39.688556356 -0800
@@ -2,6 +2,7 @@
 
 #ifndef _ASM_X86_CPU_ENTRY_AREA_H
 #define _ASM_X86_CPU_ENTRY_AREA_H
+#ifndef __ASSEMBLY__
 
 #include <linux/percpu-defs.h>
 #include <asm/processor.h>
@@ -78,4 +79,7 @@ static inline struct entry_stack *cpu_en
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
 
+extern char _entry_trampoline[];
+
+#endif /* __ASSEMBLY__ */
 #endif
diff -puN arch/x86/mm/cpu_entry_area.c~rsb-stuff-on-vmenter arch/x86/mm/cpu_entry_area.c
--- a/arch/x86/mm/cpu_entry_area.c~rsb-stuff-on-vmenter	2018-02-02 13:00:13.603600943 -0800
+++ b/arch/x86/mm/cpu_entry_area.c	2018-02-02 13:02:43.046600571 -0800
@@ -64,6 +64,17 @@ static void percpu_setup_debug_store(int
 #endif
 }
 
+#ifdef CONFIG_X86_64
+extern char _entry_trampoline[];
+extern char reloc_clear_return_buffer[];
+/*
+ * These are both used in a call that must be inlined and must be
+ * used in a module (KVM code).  We need exports for them.
+ */
+EXPORT_SYMBOL_GPL(reloc_clear_return_buffer);
+EXPORT_SYMBOL_GPL(_entry_trampoline);
+#endif
+
 /* Setup the fixmap mappings only once per-processor */
 static void __init setup_cpu_entry_area(int cpu)
 {
_
