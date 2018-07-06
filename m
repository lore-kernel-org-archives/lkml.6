Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C28DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3223EA4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF3223EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeGFQXn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:23:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55159 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbeGFQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:23:37 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbTVs-00006a-OT; Fri, 06 Jul 2018 18:23:16 +0200
Message-ID: <20180706162049.585702951@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Jul 2018 18:13:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: [patch 4/7] x86/kvmclock: Cleanup the code
References: <20180706161307.733337643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Cleanup the mrs write for wall clock. The type casts to (int) are sloppy
  because the wrmsr parameters are u32 and aside of that wrmsrl() already
  provides the high/low split for free.

- Remove the pointless get_cpu()/put_cpu() dance from various
  functions. Either they are called during early init where CPU is
  guaranteed to be 0 or they are already called from non preemptible
  context where smp_processor_id() can be used safely

- Simplify the convoluted check for kvmclock in the init function.

- Mark the parameter parsing function __init. No point in keeping it
  around.

- Convert to pr_info()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
---
 arch/x86/kernel/kvmclock.c |   75 +++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 52 deletions(-)

--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -37,7 +37,7 @@ static int msr_kvm_system_time = MSR_KVM
 static int msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
 static u64 kvm_sched_clock_offset;
 
-static int parse_no_kvmclock(char *arg)
+static int __init parse_no_kvmclock(char *arg)
 {
 	kvmclock = 0;
 	return 0;
@@ -61,13 +61,9 @@ static struct pvclock_wall_clock wall_cl
 static void kvm_get_wallclock(struct timespec64 *now)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
-	int low, high;
 	int cpu;
 
-	low = (int)slow_virt_to_phys(&wall_clock);
-	high = ((u64)slow_virt_to_phys(&wall_clock) >> 32);
-
-	native_write_msr(msr_kvm_wall_clock, low, high);
+	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 
 	cpu = get_cpu();
 
@@ -117,11 +113,11 @@ static inline void kvm_sched_clock_init(
 	kvm_sched_clock_offset = kvm_clock_read();
 	pv_time_ops.sched_clock = kvm_sched_clock_read;
 
-	printk(KERN_INFO "kvm-clock: using sched offset of %llu cycles\n",
-			kvm_sched_clock_offset);
+	pr_info("kvm-clock: using sched offset of %llu cycles\n",
+		kvm_sched_clock_offset);
 
 	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-	         sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
 }
 
 /*
@@ -135,15 +131,7 @@ static inline void kvm_sched_clock_init(
  */
 static unsigned long kvm_get_tsc_khz(void)
 {
-	struct pvclock_vcpu_time_info *src;
-	int cpu;
-	unsigned long tsc_khz;
-
-	cpu = get_cpu();
-	src = &hv_clock[cpu].pvti;
-	tsc_khz = pvclock_tsc_khz(src);
-	put_cpu();
-	return tsc_khz;
+	return pvclock_tsc_khz(&hv_clock[0].pvti);
 }
 
 static void kvm_get_preset_lpj(void)
@@ -160,29 +148,27 @@ static void kvm_get_preset_lpj(void)
 
 bool kvm_check_and_clear_guest_paused(void)
 {
-	bool ret = false;
 	struct pvclock_vcpu_time_info *src;
-	int cpu = smp_processor_id();
+	bool ret = false;
 
 	if (!hv_clock)
 		return ret;
 
-	src = &hv_clock[cpu].pvti;
+	src = &hv_clock[smp_processor_id()].pvti;
 	if ((src->flags & PVCLOCK_GUEST_STOPPED) != 0) {
 		src->flags &= ~PVCLOCK_GUEST_STOPPED;
 		pvclock_touch_watchdogs();
 		ret = true;
 	}
-
 	return ret;
 }
 
 struct clocksource kvm_clock = {
-	.name = "kvm-clock",
-	.read = kvm_clock_get_cycles,
-	.rating = 400,
-	.mask = CLOCKSOURCE_MASK(64),
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.name	= "kvm-clock",
+	.read	= kvm_clock_get_cycles,
+	.rating	= 400,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
 
@@ -195,6 +181,7 @@ static void kvm_register_clock(char *txt
 	if (!hv_clock)
 		return;
 
+	src = &hv_clock[cpu].pvti;
 	pa = slow_virt_to_phys(src) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
 	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
@@ -242,20 +229,19 @@ static void kvm_shutdown(void)
 
 void __init kvmclock_init(void)
 {
-	struct pvclock_vcpu_time_info *vcpu_time;
-	int cpu;
 	u8 flags;
 
-	if (!kvm_para_available())
+	if (!kvm_para_available() || !kvmclock)
 		return;
 
-	if (kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
+	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
 		msr_kvm_system_time = MSR_KVM_SYSTEM_TIME_NEW;
 		msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK_NEW;
-	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
+	} else if (!kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)) {
 		return;
+	}
 
-	printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
+	pr_info("kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
 	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
@@ -264,20 +250,15 @@ void __init kvmclock_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	cpu = get_cpu();
-	vcpu_time = &hv_clock[cpu].pvti;
-	flags = pvclock_read_flags(vcpu_time);
-
+	flags = pvclock_read_flags(&hv_clock[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
-	put_cpu();
 
 	x86_platform.calibrate_tsc = kvm_get_tsc_khz;
 	x86_platform.calibrate_cpu = kvm_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
-	x86_cpuinit.early_percpu_clock_init =
-		kvm_setup_secondary_clock;
+	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
 	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
@@ -293,26 +274,16 @@ void __init kvmclock_init(void)
 int __init kvm_setup_vsyscall_timeinfo(void)
 {
 #ifdef CONFIG_X86_64
-	int cpu;
 	u8 flags;
-	struct pvclock_vcpu_time_info *vcpu_time;
 
 	if (!hv_clock)
 		return 0;
 
-	cpu = get_cpu();
-
-	vcpu_time = &hv_clock[cpu].pvti;
-	flags = pvclock_read_flags(vcpu_time);
-
-	if (!(flags & PVCLOCK_TSC_STABLE_BIT)) {
-		put_cpu();
+	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
 		return 1;
-	}
 
 	pvclock_set_pvti_cpu0_va(hv_clock);
-	put_cpu();
-
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
 	return 0;


