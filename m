Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0370ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gRfP7isw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbeGRC7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:59:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbeGRC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2MUD4171063;
        Wed, 18 Jul 2018 02:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=6rw+jxGwYNPhdW6VXob9xlTG2WwM5ul8hwCwB++y7qo=;
 b=gRfP7iswuzP7/KKSo8CwDjI/u5+BNEN/aezkZCIVIAhwBhOoey9JeGqqeNp+gHUSwDWa
 Lp6IhAS3OAkp1vtoDBvZKbXYpuo6pPH5V3z9RGzrIGUBBbfH2HnX03HRk0z5nZ2D60w1
 WAT53pFtk3KK6BGjzK2J2M5GGFtRYQgH3QDFRigKIJCZ0zf9uq5eetb2ZC8Qztbmvy/L
 VatqSswPRk70buCOdZ1pHfvyfqd5D5fmz1bJ+RDY699RUww1nHtFWWHe1HD8s2DEVCrG
 sPNzjE/di8mr7Zd8G+T+H3rBRMCBHeivrjqQIi5K5eyOjbxXb7rvl6ICOXa33eJPVUnQ dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k7a3tb43g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MUxL023450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:30 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MT3h020555;
        Wed, 18 Jul 2018 02:22:29 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:28 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH v14 04/25] x86/kvmclock: Cleanup the code
Date:   Tue, 17 Jul 2018 22:21:50 -0400
Message-Id: <20180718022211.6259-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
---
 arch/x86/kernel/kvmclock.c | 76 ++++++++++++--------------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index cbf0a6b9217b..04d2f5e1d783 100644
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
@@ -135,15 +131,7 @@ static inline void kvm_sched_clock_init(bool stable)
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
 
@@ -198,7 +184,7 @@ static void kvm_register_clock(char *txt)
 	src = &hv_clock[cpu].pvti;
 	pa = slow_virt_to_phys(src) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
-	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s", cpu, pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -243,20 +229,19 @@ static void kvm_shutdown(void)
 
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
@@ -265,20 +250,15 @@ void __init kvmclock_init(void)
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
@@ -294,26 +274,16 @@ void __init kvmclock_init(void)
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
-- 
2.18.0

