Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BEBC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690D2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeI3EWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:22:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52029 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728749AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000Gs-T6; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006ro-BB; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.490638408@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 037/131] x86/speculation: Handle HT correctly on AMD
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 1f50ddb4f4189243c05926b842dc1a0332195f31 upstream.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - s/topology_sibling_cpumask/topology_thread_cpumask/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/spec-ctrl.h |   6 ++
 arch/x86/kernel/process.c        | 125 +++++++++++++++++++++++++++++--
 arch/x86/kernel/smpboot.c        |   5 ++
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
@@ -217,22 +217,135 @@ static inline void switch_to_bitmap(stru
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
+	for_each_cpu(cpu, topology_thread_cpumask(this_cpu)) {
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
 
 /* State of each CPU */
 DEFINE_PER_CPU(int, cpu_state) = { 0 };
@@ -243,6 +244,8 @@ static void notrace start_secondary(void
 	 */
 	check_tsc_sync_target();
 
+	speculative_store_bypass_ht_init();
+
 	/*
 	 * Enable the espfix hack for this CPU
 	 */
@@ -1162,6 +1165,8 @@ void __init native_smp_prepare_cpus(unsi
 	set_mtrr_aps_delayed_init();
 out:
 	preempt_enable();
+
+	speculative_store_bypass_ht_init();
 }
 
 void arch_enable_nonboot_cpus_begin(void)

