Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BD5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE55820671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE55820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGSXKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:10:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:10:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMPB2P2438788
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:25:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMPBWg2438784;
        Thu, 19 Jul 2018 15:25:11 -0700
Date:   Thu, 19 Jul 2018 15:25:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-95a3d4454bb1cf5bfd666c27fdd2dc188e17c14d@git.kernel.org>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, pasha.tatashin@oracle.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: pasha.tatashin@oracle.com, pbonzini@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20180719205545.16512-8-pasha.tatashin@oracle.com>
References: <20180719205545.16512-8-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Switch kvmclock data to a PER_CPU
 variable
Git-Commit-ID: 95a3d4454bb1cf5bfd666c27fdd2dc188e17c14d
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

Commit-ID:  95a3d4454bb1cf5bfd666c27fdd2dc188e17c14d
Gitweb:     https://git.kernel.org/tip/95a3d4454bb1cf5bfd666c27fdd2dc188e17c14d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 19 Jul 2018 16:55:26 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:38 +0200

x86/kvmclock: Switch kvmclock data to a PER_CPU variable

The previous removal of the memblock dependency from kvmclock introduced a
static data array sized 64bytes * CONFIG_NR_CPUS. That's wasteful on large
systems when kvmclock is not used.

Replace it with:

 - A static page sized array of pvclock data. It's page sized because the
   pvclock data of the boot cpu is mapped into the VDSO so otherwise random
   other data would be exposed to the vDSO

 - A PER_CPU variable of pvclock data pointers. This is used to access the
   pcvlock data storage on each CPU.

The setup is done in two stages:

 - Early boot stores the pointer to the static page for the boot CPU in
   the per cpu data.

 - In the preparatory stage of CPU hotplug assign either an element of
   the static array (when the CPU number is in that range) or allocate
   memory and initialize the per cpu pointer.

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
Link: https://lkml.kernel.org/r/20180719205545.16512-8-pasha.tatashin@oracle.com

---
 arch/x86/kernel/kvmclock.c | 99 +++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 7d690d2238f8..91b94c0ae4e3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -23,6 +23,7 @@
 #include <asm/apic.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/cpuhotplug.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
@@ -55,12 +56,23 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
+#define HVC_BOOT_ARRAY_SIZE \
+	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
-static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
-
-/* The hypervisor will put information about time periodically here */
-static struct pvclock_vsyscall_time_info *hv_clock __ro_after_init;
+static struct pvclock_vsyscall_time_info
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
 static struct pvclock_wall_clock wall_clock;
+static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
+
+static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
+{
+	return &this_cpu_read(hv_clock_per_cpu)->pvti;
+}
+
+static inline struct pvclock_vsyscall_time_info *this_cpu_hvclock(void)
+{
+	return this_cpu_read(hv_clock_per_cpu);
+}
 
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
@@ -69,17 +81,10 @@ static struct pvclock_wall_clock wall_clock;
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
-	struct pvclock_vcpu_time_info *vcpu_time;
-	int cpu;
-
 	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
-
-	cpu = get_cpu();
-
-	vcpu_time = &hv_clock[cpu].pvti;
-	pvclock_read_wallclock(&wall_clock, vcpu_time, now);
-
-	put_cpu();
+	preempt_disable();
+	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
+	preempt_enable();
 }
 
 static int kvm_set_wallclock(const struct timespec64 *now)
@@ -89,14 +94,10 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 
 static u64 kvm_clock_read(void)
 {
-	struct pvclock_vcpu_time_info *src;
 	u64 ret;
-	int cpu;
 
 	preempt_disable_notrace();
-	cpu = smp_processor_id();
-	src = &hv_clock[cpu].pvti;
-	ret = pvclock_clocksource_read(src);
+	ret = pvclock_clocksource_read(this_cpu_pvti());
 	preempt_enable_notrace();
 	return ret;
 }
@@ -141,7 +142,7 @@ static inline void kvm_sched_clock_init(bool stable)
 static unsigned long kvm_get_tsc_khz(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	return pvclock_tsc_khz(&hv_clock[0].pvti);
+	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
 static void kvm_get_preset_lpj(void)
@@ -158,15 +159,14 @@ static void kvm_get_preset_lpj(void)
 
 bool kvm_check_and_clear_guest_paused(void)
 {
-	struct pvclock_vcpu_time_info *src;
+	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
 	bool ret = false;
 
-	if (!hv_clock)
+	if (!src)
 		return ret;
 
-	src = &hv_clock[smp_processor_id()].pvti;
-	if ((src->flags & PVCLOCK_GUEST_STOPPED) != 0) {
-		src->flags &= ~PVCLOCK_GUEST_STOPPED;
+	if ((src->pvti.flags & PVCLOCK_GUEST_STOPPED) != 0) {
+		src->pvti.flags &= ~PVCLOCK_GUEST_STOPPED;
 		pvclock_touch_watchdogs();
 		ret = true;
 	}
@@ -184,17 +184,15 @@ EXPORT_SYMBOL_GPL(kvm_clock);
 
 static void kvm_register_clock(char *txt)
 {
-	struct pvclock_vcpu_time_info *src;
-	int cpu = smp_processor_id();
+	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
 	u64 pa;
 
-	if (!hv_clock)
+	if (!src)
 		return;
 
-	src = &hv_clock[cpu].pvti;
-	pa = slow_virt_to_phys(src) | 0x01ULL;
+	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
-	pr_info("kvm-clock: cpu %d, msr %llx, %s", cpu, pa, txt);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -242,12 +240,12 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 #ifdef CONFIG_X86_64
 	u8 flags;
 
-	if (!hv_clock || !kvmclock_vsyscall)
+	if (!per_cpu(hv_clock_per_cpu, 0) || !kvmclock_vsyscall)
 		return 0;
 
-	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
-		return 1;
+		return 0;
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
@@ -255,6 +253,28 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 }
 early_initcall(kvm_setup_vsyscall_timeinfo);
 
+static int kvmclock_setup_percpu(unsigned int cpu)
+{
+	struct pvclock_vsyscall_time_info *p = per_cpu(hv_clock_per_cpu, cpu);
+
+	/*
+	 * The per cpu area setup replicates CPU0 data to all cpu
+	 * pointers. So carefully check. CPU0 has been set up in init
+	 * already.
+	 */
+	if (!cpu || (p && p != per_cpu(hv_clock_per_cpu, 0)))
+		return 0;
+
+	/* Use the static page for the first CPUs, allocate otherwise */
+	if (cpu < HVC_BOOT_ARRAY_SIZE)
+		p = &hv_clock_boot[cpu];
+	else
+		p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	per_cpu(hv_clock_per_cpu, cpu) = p;
+	return p ? 0 : -ENOMEM;
+}
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
@@ -269,17 +289,22 @@ void __init kvmclock_init(void)
 		return;
 	}
 
+	if (cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "kvmclock:setup_percpu",
+			      kvmclock_setup_percpu, NULL) < 0) {
+		return;
+	}
+
 	pr_info("kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
-	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
+	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
 	kvm_register_clock("primary cpu clock");
-	pvclock_set_pvti_cpu0_va(hv_clock);
+	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
 	x86_platform.calibrate_tsc = kvm_get_tsc_khz;
