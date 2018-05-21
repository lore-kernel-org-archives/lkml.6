Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr6uE9GJeU9t+EbcLw+ZUm1nPIDjPl5yO52A5VelG17sziqxiDVCnpn4XBtIUMIIOeSmiUF
ARC-Seal: i=1; a=rsa-sha256; t=1526937686; cv=none;
        d=google.com; s=arc-20160816;
        b=N0ioGEqyBitqB2za+OJwu1S/cjrIH55gxdeBdVbNeC4RF0gHUJmgjGMnVmbgMPt6MP
         JGWa9DdojNNg/YPkwk1rC+sQrb2+JBQm7WbCvRliucpsAToUGCIvZYEPMbH3fPkZQ8Yc
         /L0dS4slY8QMl1wmPkIjdPBTy7GtDX6/2tvSY5hdxbrJlHWbnvtQUu4vlfElaT1LdnzA
         t/xrRtdi+W1+h0RPJLj1F+GyLDRkAph8uRH+B4nJwYPXA7GKZCLmbcrg1mkN7a7hplLb
         G+FaYBMJ2b6Co9YPUVYzKLRxLMp2h+072T9/hmhBHS0tULklTMYQB3cdwGCKR8z2jPdY
         B+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=B+W+agKgJDC+shvvzYPR3ygyTTglbrsGoFvW4IKluZM=;
        b=lILEHv7V3b3xsOJPu33V3SvNB7W8epaWdlqLPV9fnStYW7iEljqAKuLDkGgu9fi1kM
         3tRDLcqIOAHk+rnCfPA3+tZKkpoD9O/U19Pmg36Flwg81A33dhOUrGzznY/wuH78yOBQ
         JdcL862r6zZGQkmrW3HomgJWRitt4gBAu5o+C6afGnTkZTqBBDZr8lk6tpA0qCKVyTap
         OCnkCE+BZk1iNukidAAmZnhfRahyAXjjAIF/wck/HhpRWPniLA8kFxitM3atHFj0Shk5
         wzjSOojcqDynhSlOHvrAVfkCGzz3SOXJhvUj+Pvg50rhi83bbJD7U2sJuH1nMFkxkFcO
         EEfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fXbwzTOe;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fXbwzTOe;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 85/95] x86/speculation: Handle HT correctly on AMD
Date: Mon, 21 May 2018 23:12:15 +0200
Message-Id: <20180521210502.621289723@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109938794662368?=
X-GMAIL-MSGID: =?utf-8?q?1601110211955200535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 1f50ddb4f4189243c05926b842dc1a0332195f31 upstream

The AMD64_LS_CFG MSR is a per core MSR on Family 17H CPUs. That means when
hyperthreading is enabled the SSBD bit toggle needs to take both cores into
account. Otherwise the following situation can happen:

CPU0		CPU1

disable SSB
		disable SSB
		enable  SSB <- Enables it for the Core, i.e. for CPU0 as well

So after the SSB enable on CPU1 the task on CPU0 runs with SSB enabled
again.

On Intel the SSBD control is per core as well, but the synchronization
logic is implemented behind the per thread SPEC_CTRL MSR. It works like
this:

  CORE_SPEC_CTRL = THREAD0_SPEC_CTRL | THREAD1_SPEC_CTRL

i.e. if one of the threads enables a mitigation then this affects both and
the mitigation is only disabled in the core when both threads disabled it.

Add the necessary synchronization logic for AMD family 17H. Unfortunately
that requires a spinlock to serialize the access to the MSR, but the locks
are only shared between siblings.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |    6 +
 arch/x86/kernel/process.c        |  125 +++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/smpboot.c        |    5 +
 3 files changed, 130 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -33,6 +33,12 @@ static inline u64 ssbd_tif_to_amd_ls_cfg
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
+#ifdef CONFIG_SMP
+extern void speculative_store_bypass_ht_init(void);
+#else
+static inline void speculative_store_bypass_ht_init(void) { }
+#endif
+
 extern void speculative_store_bypass_update(void);
 
 #endif
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -280,22 +280,135 @@ static inline void switch_to_bitmap(stru
 	}
 }
 
-static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+#ifdef CONFIG_SMP
+
+struct ssb_state {
+	struct ssb_state	*shared_state;
+	raw_spinlock_t		lock;
+	unsigned int		disable_state;
+	unsigned long		local_state;
+};
+
+#define LSTATE_SSB	0
+
+static DEFINE_PER_CPU(struct ssb_state, ssb_state);
+
+void speculative_store_bypass_ht_init(void)
+{
+	struct ssb_state *st = this_cpu_ptr(&ssb_state);
+	unsigned int this_cpu = smp_processor_id();
+	unsigned int cpu;
+
+	st->local_state = 0;
+
+	/*
+	 * Shared state setup happens once on the first bringup
+	 * of the CPU. It's not destroyed on CPU hotunplug.
+	 */
+	if (st->shared_state)
+		return;
+
+	raw_spin_lock_init(&st->lock);
+
+	/*
+	 * Go over HT siblings and check whether one of them has set up the
+	 * shared state pointer already.
+	 */
+	for_each_cpu(cpu, topology_sibling_cpumask(this_cpu)) {
+		if (cpu == this_cpu)
+			continue;
+
+		if (!per_cpu(ssb_state, cpu).shared_state)
+			continue;
+
+		/* Link it to the state of the sibling: */
+		st->shared_state = per_cpu(ssb_state, cpu).shared_state;
+		return;
+	}
+
+	/*
+	 * First HT sibling to come up on the core.  Link shared state of
+	 * the first HT sibling to itself. The siblings on the same core
+	 * which come up later will see the shared state pointer and link
+	 * themself to the state of this CPU.
+	 */
+	st->shared_state = st;
+}
+
+/*
+ * Logic is: First HT sibling enables SSBD for both siblings in the core
+ * and last sibling to disable it, disables it for the whole core. This how
+ * MSR_SPEC_CTRL works in "hardware":
+ *
+ *  CORE_SPEC_CTRL = THREAD0_SPEC_CTRL | THREAD1_SPEC_CTRL
+ */
+static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
 {
-	u64 msr;
+	struct ssb_state *st = this_cpu_ptr(&ssb_state);
+	u64 msr = x86_amd_ls_cfg_base;
 
-	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
-		msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
+	if (!static_cpu_has(X86_FEATURE_ZEN)) {
+		msr |= ssbd_tif_to_amd_ls_cfg(tifn);
 		wrmsrl(MSR_AMD64_LS_CFG, msr);
+		return;
+	}
+
+	if (tifn & _TIF_SSBD) {
+		/*
+		 * Since this can race with prctl(), block reentry on the
+		 * same CPU.
+		 */
+		if (__test_and_set_bit(LSTATE_SSB, &st->local_state))
+			return;
+
+		msr |= x86_amd_ls_cfg_ssbd_mask;
+
+		raw_spin_lock(&st->shared_state->lock);
+		/* First sibling enables SSBD: */
+		if (!st->shared_state->disable_state)
+			wrmsrl(MSR_AMD64_LS_CFG, msr);
+		st->shared_state->disable_state++;
+		raw_spin_unlock(&st->shared_state->lock);
 	} else {
-		msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
-		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		if (!__test_and_clear_bit(LSTATE_SSB, &st->local_state))
+			return;
+
+		raw_spin_lock(&st->shared_state->lock);
+		st->shared_state->disable_state--;
+		if (!st->shared_state->disable_state)
+			wrmsrl(MSR_AMD64_LS_CFG, msr);
+		raw_spin_unlock(&st->shared_state->lock);
 	}
 }
+#else
+static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
+{
+	u64 msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
+
+	wrmsrl(MSR_AMD64_LS_CFG, msr);
+}
+#endif
+
+static __always_inline void intel_set_ssb_state(unsigned long tifn)
+{
+	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
+
+	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+}
+
+static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+{
+	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+		amd_set_core_ssb_state(tifn);
+	else
+		intel_set_ssb_state(tifn);
+}
 
 void speculative_store_bypass_update(void)
 {
+	preempt_disable();
 	__speculative_store_bypass_update(current_thread_info()->flags);
+	preempt_enable();
 }
 
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -77,6 +77,7 @@
 #include <asm/i8259.h>
 #include <asm/realmode.h>
 #include <asm/misc.h>
+#include <asm/spec-ctrl.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -245,6 +246,8 @@ static void notrace start_secondary(void
 	 */
 	check_tsc_sync_target();
 
+	speculative_store_bypass_ht_init();
+
 	/*
 	 * Lock vector_lock and initialize the vectors on this cpu
 	 * before setting the cpu online. We must set it online with
@@ -1349,6 +1352,8 @@ void __init native_smp_prepare_cpus(unsi
 	set_mtrr_aps_delayed_init();
 
 	smp_quirk_init_udelay();
+
+	speculative_store_bypass_ht_init();
 }
 
 void arch_enable_nonboot_cpus_begin(void)
