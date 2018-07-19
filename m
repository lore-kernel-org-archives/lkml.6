Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47CECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19AE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19AE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGSXJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:09:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41285 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:09:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMNbqe2437099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:23:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMNbII2437096;
        Thu, 19 Jul 2018 15:23:37 -0700
Date:   Thu, 19 Jul 2018 15:23:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-146c394d0c3c8e88df433a179c2b0b85fd8cf247@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, pasha.tatashin@oracle.com,
        tglx@linutronix.de
Reply-To: pbonzini@redhat.com, mingo@kernel.org, pasha.tatashin@oracle.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180719205545.16512-5-pasha.tatashin@oracle.com>
References: <20180719205545.16512-5-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Cleanup the code
Git-Commit-ID: 146c394d0c3c8e88df433a179c2b0b85fd8cf247
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  146c394d0c3c8e88df433a179c2b0b85fd8cf247
Gitweb:     https://git.kernel.org/tip/146c394d0c3c8e88df433a179c2b0b85fd8cf247
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 19 Jul 2018 16:55:23 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:37 +0200

x86/kvmclock: Cleanup the code

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
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Link: https://lkml.kernel.org/r/20180719205545.16512-5-pasha.tatashin@oracle.com

---
 arch/x86/kernel/kvmclock.c | 72 ++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index f0a0aef5e9fa..4afb03e49a4f 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -37,7 +37,7 @@ static int msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
 static int msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
 static u64 kvm_sched_clock_offset;
 
-static int parse_no_kvmclock(char *arg)
+static int __init parse_no_kvmclock(char *arg)
 {
 	kvmclock = 0;
 	return 0;
@@ -61,13 +61,9 @@ static struct pvclock_wall_clock wall_clock;
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
 
@@ -117,11 +113,11 @@ static inline void kvm_sched_clock_init(bool stable)
 	kvm_sched_clock_offset = kvm_clock_read();
 	pv_time_ops.sched_clock = kvm_sched_clock_read;
 
-	printk(KERN_INFO "kvm-clock: using sched offset of %llu cycles\n",
-			kvm_sched_clock_offset);
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
 
 	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-	         sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
 }
 
 /*
@@ -135,16 +131,8 @@ static inline void kvm_sched_clock_init(bool stable)
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
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	return tsc_khz;
+	return pvclock_tsc_khz(&hv_clock[0].pvti);
 }
 
 static void kvm_get_preset_lpj(void)
@@ -161,29 +149,27 @@ static void kvm_get_preset_lpj(void)
 
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
 
@@ -199,7 +185,7 @@ static void kvm_register_clock(char *txt)
 	src = &hv_clock[cpu].pvti;
 	pa = slow_virt_to_phys(src) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
-	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s", cpu, pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -244,20 +230,19 @@ static void kvm_shutdown(void)
 
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
@@ -267,20 +252,15 @@ void __init kvmclock_init(void)
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
@@ -296,20 +276,12 @@ void __init kvmclock_init(void)
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
-	put_cpu();
-
+	flags = pvclock_read_flags(&hv_clock[0].pvti);
 	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
 		return 1;
 
