Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELuv8TpLQ3Bx6ZsRE2Ozgbrly+LZvN/ox2Q3LmIKk2KtJkbPaBfNUv/uwwOvGbBmh+qXESvw
ARC-Seal: i=1; a=rsa-sha256; t=1521371076; cv=none;
        d=google.com; s=arc-20160816;
        b=X8FAKg5xa+iuM0hBP3XQ94TiHiMG2FT4M94aV4R7AUBIYKa9eAibs0dPN1tg5ImYlj
         8aFKOYMXFhEIikIm3dhykRh+NJLQERFwE+oShxGfxNs7zIzL3bNZJt/a+ZQ/6WX4PZ3Q
         KxdqLt2qWGbUyzoKUtHigF2top3/ML5CsgNmeOJz68wLliTKPHeKz8S6GfYzOFojqW70
         NpJ8PIY5amVrF917ZxtYRMcQIj6mSlYkrz9xfHgQWpjv1AI21H2YyU7JtHXdhKOqOSsn
         NXXF9slPqG5Q8kouZ1n8OwwWkqp9ImhP/NVFSrKwJToE1ZrKh0/cVtsZwmcDpb64U36g
         c7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=/Pl62ppU0x926ZKKi/DJmFP7SXz7XXvVb9RREmai/6M=;
        b=F6okHw51wf/1mQcNUFsDiIqVQMASBEurBeUiNDN7Y1afC23uWKV8+BqVzbho2LiUso
         FcWZVGvvQPB7Xj8JdxR4oJn8MmPuVLv532aeiEXSTTiNkC10uss3e6fqxRT4x5ypmjN3
         gJ1so1DJy/QQ66kToJNXjiQP23oi99Ux2iwwyFApUS2x+KpyacfsixktRr6RrpstmKrl
         WRqz0+jNMfFeWGNYR6xOSfAfJmFUMiBXrJO4O1atkwb+3LgynB06HG2gqINXnkI8g82t
         QAEj6d2s7yBbogsFc+3DjKwMputxdVLvFU71azcTFxAEPwIJUsXPO6CYtMvu41tXqlLg
         PwfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 18 Mar 2018 12:04:35 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
    Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT pull] x86/pti updates for 4.16
Message-ID: <alpine.DEB.2.21.1803181152270.1509@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595273198443467054?=
X-GMAIL-MSGID: =?utf-8?q?1595273198443467054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Another set of melted spectrum updates:

  - Iron out the last late microcode loading issues by actually checking
    whether new microcode is present and preventing the CPU synchronization
    to run into a timeout induced hang.

  - Remove Skylake C2 from the microcode blacklist according to the latest
    Intel documentation

  - Fix the VM86 POPF emulation which traps if VIP is set, but VIF is
    not. Enhance the selftests to catch that kind of issue

  - Annotate indirect calls/jumps for objtool on 32bit. This is not a
    functional issue, but for consistency sake its the right thing to do.

  - Fix a jump label build warning observed on SPARC64 which uses 32bit
    storage for the code location which is casted to 64 bit pointer w/o
    extending it to 64bit first.

  - Add two new cpufeature bits. Not really an urgent issue, but provides
    them for both x86 and x86/kvm work. No impact on the current kernel.

Thanks,

	tglx

------------------>
Alexander Sergeyev (1):
      x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist

Andy Lutomirski (3):
      selftests/x86/entry_from_vm86: Exit with 1 if we fail
      selftests/x86/entry_from_vm86: Add test cases for POPF
      x86/vm86/32: Fix POPF emulation

Andy Whitcroft (1):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels

Borislav Petkov (2):
      x86/microcode: Attempt late loading only when new microcode is present
      x86/microcode: Fix CPU synchronization routine

Josh Poimboeuf (1):
      jump_label: Fix sparc64 warning

Kirill A. Shutemov (2):
      x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
      x86/cpufeatures: Add Intel PCONFIG cpufeature


 arch/x86/include/asm/cpufeatures.h            |  2 +
 arch/x86/include/asm/microcode.h              |  1 +
 arch/x86/include/asm/nospec-branch.h          |  5 +-
 arch/x86/kernel/cpu/intel.c                   |  3 +-
 arch/x86/kernel/cpu/microcode/amd.c           | 34 +++++++-----
 arch/x86/kernel/cpu/microcode/core.c          | 76 ++++++++++++++++-----------
 arch/x86/kernel/cpu/microcode/intel.c         |  4 +-
 arch/x86/kernel/vm86_32.c                     |  3 +-
 kernel/jump_label.c                           |  3 +-
 tools/testing/selftests/x86/entry_from_vm86.c | 32 +++++++++--
 10 files changed, 108 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f41079da38c5..d554c11e01ff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -316,6 +316,7 @@
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
 #define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network Instructions */
 #define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
+#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption */
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
@@ -328,6 +329,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7fb1047d61c7..6cf0e4cb7b97 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -39,6 +39,7 @@ struct device;
 
 enum ucode_state {
 	UCODE_OK	= 0,
+	UCODE_NEW,
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index b7063cfa19f9..b3996d60f981 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,7 +183,10 @@
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
-# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+# define CALL_NOSPEC						\
+	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
 	"       .align 16\n"					\
 	"901:	call   903f;\n"					\
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4aa9fd379390..c3af167d0a70 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -105,7 +105,7 @@ static void probe_xeon_phi_r3mwait(struct cpuinfo_x86 *c)
 /*
  * Early microcode releases for the Spectre v2 mitigation were broken.
  * Information taken from;
- * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/03/microcode-update-guidance.pdf
  * - https://kb.vmware.com/s/article/52345
  * - Microcode revisions observed in the wild
  * - Release note from 20180108 microcode release
@@ -123,7 +123,6 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a998e1a7d46f..48179928ff38 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -339,7 +339,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 		return -EINVAL;
 
 	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
-	if (ret != UCODE_OK)
+	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
 	return 0;
@@ -683,27 +683,35 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 static enum ucode_state
 load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
+	struct ucode_patch *p;
 	enum ucode_state ret;
 
 	/* free old equiv table */
 	free_equiv_cpu_table();
 
 	ret = __load_microcode_amd(family, data, size);
-
-	if (ret != UCODE_OK)
+	if (ret != UCODE_OK) {
 		cleanup();
+		return ret;
+	}
 
-#ifdef CONFIG_X86_32
-	/* save BSP's matching patch for early load */
-	if (save) {
-		struct ucode_patch *p = find_patch(0);
-		if (p) {
-			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
-			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
-							       PATCH_MAX_SIZE));
-		}
+	p = find_patch(0);
+	if (!p) {
+		return ret;
+	} else {
+		if (boot_cpu_data.microcode == p->patch_id)
+			return ret;
+
+		ret = UCODE_NEW;
 	}
-#endif
+
+	/* save BSP's matching patch for early load */
+	if (!save)
+		return ret;
+
+	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
+	memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data), PATCH_MAX_SIZE));
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 70ecbc8099c9..10c4fc2c91f8 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -517,7 +517,29 @@ static int check_online_cpus(void)
 	return -EINVAL;
 }
 
-static atomic_t late_cpus;
+static atomic_t late_cpus_in;
+static atomic_t late_cpus_out;
+
+static int __wait_for_cpus(atomic_t *t, long long timeout)
+{
+	int all_cpus = num_online_cpus();
+
+	atomic_inc(t);
+
+	while (atomic_read(t) < all_cpus) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				all_cpus - atomic_read(t));
+			return 1;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+	return 0;
+}
 
 /*
  * Returns:
@@ -527,30 +549,16 @@ static atomic_t late_cpus;
  */
 static int __reload_late(void *info)
 {
-	unsigned int timeout = NSEC_PER_SEC;
-	int all_cpus = num_online_cpus();
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
 
-	atomic_dec(&late_cpus);
-
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	while (atomic_read(&late_cpus)) {
-		if (timeout < SPINUNIT) {
-			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
-				atomic_read(&late_cpus));
-			return -1;
-		}
-
-		ndelay(SPINUNIT);
-		timeout -= SPINUNIT;
-
-		touch_nmi_watchdog();
-	}
+	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
+		return -1;
 
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
@@ -558,15 +566,22 @@ static int __reload_late(void *info)
 
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		ret = -1;
-	} else if (err == UCODE_UPDATED) {
+		return -1;
+	/* siblings return UCODE_OK because their engine got updated already */
+	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
+	} else {
+		return ret;
 	}
 
-	atomic_inc(&late_cpus);
-
-	while (atomic_read(&late_cpus) != all_cpus)
-		cpu_relax();
+	/*
+	 * Increase the wait timeout to a safe value here since we're
+	 * serializing the microcode update and that could take a while on a
+	 * large number of CPUs. And that is fine as the *actual* timeout will
+	 * be determined by the last CPU finished updating and thus cut short.
+	 */
+	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC * num_online_cpus()))
+		panic("Timeout during microcode update!\n");
 
 	return ret;
 }
@@ -579,12 +594,11 @@ static int microcode_reload_late(void)
 {
 	int ret;
 
-	atomic_set(&late_cpus, num_online_cpus());
+	atomic_set(&late_cpus_in,  0);
+	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret < 0)
-		return ret;
-	else if (ret > 0)
+	if (ret > 0)
 		microcode_check();
 
 	return ret;
@@ -607,7 +621,7 @@ static ssize_t reload_store(struct device *dev,
 		return size;
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
-	if (tmp_ret != UCODE_OK)
+	if (tmp_ret != UCODE_NEW)
 		return size;
 
 	get_online_cpus();
@@ -691,10 +705,8 @@ static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 	if (system_state != SYSTEM_RUNNING)
 		return UCODE_NFOUND;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev,
-						     refresh_fw);
-
-	if (ustate == UCODE_OK) {
+	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);
+	if (ustate == UCODE_NEW) {
 		pr_debug("CPU%d updated upon init\n", cpu);
 		apply_microcode_on_target(cpu);
 	}
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 2aded9db1d42..32b8e5724f96 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -862,6 +862,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	unsigned int leftover = size;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
 	unsigned int csig, cpf;
+	enum ucode_state ret = UCODE_OK;
 
 	while (leftover) {
 		struct microcode_header_intel mc_header;
@@ -903,6 +904,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 			new_mc  = mc;
 			new_mc_size = mc_size;
 			mc = NULL;	/* trigger new vmalloc */
+			ret = UCODE_NEW;
 		}
 
 		ucode_ptr += mc_size;
@@ -932,7 +934,7 @@ static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
 		 cpu, new_rev, uci->cpu_sig.rev);
 
-	return UCODE_OK;
+	return ret;
 }
 
 static int get_ucode_fw(void *to, const void *from, size_t n)
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 5edb27f1a2c4..9d0b5af7db91 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -727,7 +727,8 @@ void handle_vm86_fault(struct kernel_vm86_regs *regs, long error_code)
 	return;
 
 check_vip:
-	if (VEFLAGS & X86_EFLAGS_VIP) {
+	if ((VEFLAGS & (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) ==
+	    (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) {
 		save_v86_state(regs, VM86_STI);
 		return;
 	}
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 52a0a7af8640..e7214093dcd1 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -373,7 +373,8 @@ static void __jump_label_update(struct static_key *key,
 			if (kernel_text_address(entry->code))
 				arch_jump_label_transform(entry, jump_label_type(entry));
 			else
-				WARN_ONCE(1, "can't patch jump_label at %pS", (void *)entry->code);
+				WARN_ONCE(1, "can't patch jump_label at %pS",
+					  (void *)(unsigned long)entry->code);
 		}
 	}
 }
diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index 361466a2eaef..ade443a88421 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -95,6 +95,10 @@ asm (
 	"int3\n\t"
 	"vmcode_int80:\n\t"
 	"int $0x80\n\t"
+	"vmcode_popf_hlt:\n\t"
+	"push %ax\n\t"
+	"popf\n\t"
+	"hlt\n\t"
 	"vmcode_umip:\n\t"
 	/* addressing via displacements */
 	"smsw (2052)\n\t"
@@ -124,8 +128,8 @@ asm (
 
 extern unsigned char vmcode[], end_vmcode[];
 extern unsigned char vmcode_bound[], vmcode_sysenter[], vmcode_syscall[],
-	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[],
-	vmcode_umip_str[], vmcode_umip_sldt[];
+	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_popf_hlt[],
+	vmcode_umip[], vmcode_umip_str[], vmcode_umip_sldt[];
 
 /* Returns false if the test was skipped. */
 static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
@@ -175,7 +179,7 @@ static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
 	    (VM86_TYPE(ret) == rettype && VM86_ARG(ret) == retarg)) {
 		printf("[OK]\tReturned correctly\n");
 	} else {
-		printf("[FAIL]\tIncorrect return reason\n");
+		printf("[FAIL]\tIncorrect return reason (started at eip = 0x%lx, ended at eip = 0x%lx)\n", eip, v86->regs.eip);
 		nerrs++;
 	}
 
@@ -264,6 +268,9 @@ int main(void)
 	v86.regs.ds = load_addr / 16;
 	v86.regs.es = load_addr / 16;
 
+	/* Use the end of the page as our stack. */
+	v86.regs.esp = 4096;
+
 	assert((v86.regs.cs & 3) == 0);	/* Looks like RPL = 0 */
 
 	/* #BR -- should deliver SIG??? */
@@ -295,6 +302,23 @@ int main(void)
 	v86.regs.eflags &= ~X86_EFLAGS_IF;
 	do_test(&v86, vmcode_sti - vmcode, VM86_STI, 0, "STI with VIP set");
 
+	/* POPF with VIP set but IF clear: should not trap */
+	v86.regs.eflags = X86_EFLAGS_VIP;
+	v86.regs.eax = 0;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_UNKNOWN, 0, "POPF with VIP set and IF clear");
+
+	/* POPF with VIP set and IF set: should trap */
+	v86.regs.eflags = X86_EFLAGS_VIP;
+	v86.regs.eax = X86_EFLAGS_IF;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_STI, 0, "POPF with VIP and IF set");
+
+	/* POPF with VIP clear and IF set: should not trap */
+	v86.regs.eflags = 0;
+	v86.regs.eax = X86_EFLAGS_IF;
+	do_test(&v86, vmcode_popf_hlt - vmcode, VM86_UNKNOWN, 0, "POPF with VIP clear and IF set");
+
+	v86.regs.eflags = 0;
+
 	/* INT3 -- should cause #BP */
 	do_test(&v86, vmcode_int3 - vmcode, VM86_TRAP, 3, "INT3");
 
@@ -318,7 +342,7 @@ int main(void)
 	clearhandler(SIGSEGV);
 
 	/* Make sure nothing explodes if we fork. */
-	if (fork() > 0)
+	if (fork() == 0)
 		return 0;
 
 	return (nerrs == 0 ? 0 : 1);
