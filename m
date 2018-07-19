Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F41ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF4520671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeGSXM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:12:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:12:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMRhRh2439149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:27:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMRhuf2439146;
        Thu, 19 Jul 2018 15:27:43 -0700
Date:   Thu, 19 Jul 2018 15:27:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-7b25b9cb0dad8395b5cf5a02196d0e88ccda67d5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pasha.tatashin@oracle.com, hpa@zytor.com, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, pasha.tatashin@oracle.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180719205545.16512-13-pasha.tatashin@oracle.com>
References: <20180719205545.16512-13-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/xen/time: Initialize pv xen time in
 init_hypervisor_platform()
Git-Commit-ID: 7b25b9cb0dad8395b5cf5a02196d0e88ccda67d5
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

Commit-ID:  7b25b9cb0dad8395b5cf5a02196d0e88ccda67d5
Gitweb:     https://git.kernel.org/tip/7b25b9cb0dad8395b5cf5a02196d0e88ccda67d5
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:31 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:39 +0200

x86/xen/time: Initialize pv xen time in init_hypervisor_platform()

In every hypervisor except for xen pv time ops are initialized in
init_hypervisor_platform().

Xen PV domains initialize time ops in x86_init.paging.pagetable_init(),
by calling xen_setup_shared_info() which is a poor design, as time is
needed prior to memory allocator.

xen_setup_shared_info() is called from two places: during boot, and
after suspend. Split the content of xen_setup_shared_info() into
three places:

1. add the clock relavent data into new xen pv init_platform vector, and
   set clock ops in there.

2. move xen_setup_vcpu_info_placement() to new xen_pv_guest_late_init()
   call.

3. Re-initializing parts of shared info copy to xen_pv_post_suspend() to
   be symmetric to xen_pv_pre_suspend

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-13-pasha.tatashin@oracle.com

---
 arch/x86/xen/enlighten_pv.c | 51 +++++++++++++++++++++------------------------
 arch/x86/xen/mmu_pv.c       |  6 ++----
 arch/x86/xen/suspend_pv.c   |  5 +++--
 arch/x86/xen/time.c         |  7 +++----
 arch/x86/xen/xen-ops.h      |  6 ++----
 5 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 439a94bf89ad..105a57d73701 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -119,6 +119,27 @@ static void __init xen_banner(void)
 	       version >> 16, version & 0xffff, extra.extraversion,
 	       xen_feature(XENFEAT_mmu_pt_update_preserve_ad) ? " (preserve-AD)" : "");
 }
+
+static void __init xen_pv_init_platform(void)
+{
+	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
+	HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
+
+	/* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
+	xen_vcpu_info_reset(0);
+
+	/* pvclock is in shared info area */
+	xen_init_time_ops();
+}
+
+static void __init xen_pv_guest_late_init(void)
+{
+#ifndef CONFIG_SMP
+	/* Setup shared vcpu info for non-smp configurations */
+	xen_setup_vcpu_info_placement();
+#endif
+}
+
 /* Check if running on Xen version (major, minor) or later */
 bool
 xen_running_on_version_or_later(unsigned int major, unsigned int minor)
@@ -947,34 +968,8 @@ static void xen_write_msr(unsigned int msr, unsigned low, unsigned high)
 	xen_write_msr_safe(msr, low, high);
 }
 
-void xen_setup_shared_info(void)
-{
-	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
-
-	HYPERVISOR_shared_info =
-		(struct shared_info *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
-
-	xen_setup_mfn_list_list();
-
-	if (system_state == SYSTEM_BOOTING) {
-#ifndef CONFIG_SMP
-		/*
-		 * In UP this is as good a place as any to set up shared info.
-		 * Limit this to boot only, at restore vcpu setup is done via
-		 * xen_vcpu_restore().
-		 */
-		xen_setup_vcpu_info_placement();
-#endif
-		/*
-		 * Now that shared info is set up we can start using routines
-		 * that point to pvclock area.
-		 */
-		xen_init_time_ops();
-	}
-}
-
 /* This is called once we have the cpu_possible_mask */
-void __ref xen_setup_vcpu_info_placement(void)
+void __init xen_setup_vcpu_info_placement(void)
 {
 	int cpu;
 
@@ -1228,6 +1223,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	x86_init.irqs.intr_mode_init	= x86_init_noop;
 	x86_init.oem.arch_setup = xen_arch_setup;
 	x86_init.oem.banner = xen_banner;
+	x86_init.hyper.init_platform = xen_pv_init_platform;
+	x86_init.hyper.guest_late_init = xen_pv_guest_late_init;
 
 	/*
 	 * Set up some pagetable state before starting to set any ptes.
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2c30cabfda90..52206ad81e4b 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1230,8 +1230,7 @@ static void __init xen_pagetable_p2m_free(void)
 	 * We roundup to the PMD, which means that if anybody at this stage is
 	 * using the __ka address of xen_start_info or
 	 * xen_start_info->shared_info they are in going to crash. Fortunatly
-	 * we have already revectored in xen_setup_kernel_pagetable and in
-	 * xen_setup_shared_info.
+	 * we have already revectored in xen_setup_kernel_pagetable.
 	 */
 	size = roundup(size, PMD_SIZE);
 
@@ -1292,8 +1291,7 @@ static void __init xen_pagetable_init(void)
 
 	/* Remap memory freed due to conflicts with E820 map */
 	xen_remap_memory();
-
-	xen_setup_shared_info();
+	xen_setup_mfn_list_list();
 }
 static void xen_write_cr2(unsigned long cr2)
 {
diff --git a/arch/x86/xen/suspend_pv.c b/arch/x86/xen/suspend_pv.c
index a2e0f110af56..8303b58c79a9 100644
--- a/arch/x86/xen/suspend_pv.c
+++ b/arch/x86/xen/suspend_pv.c
@@ -27,8 +27,9 @@ void xen_pv_pre_suspend(void)
 void xen_pv_post_suspend(int suspend_cancelled)
 {
 	xen_build_mfn_list_list();
-
-	xen_setup_shared_info();
+	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
+	HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
+	xen_setup_mfn_list_list();
 
 	if (suspend_cancelled) {
 		xen_start_info->store_mfn =
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e0f1bcf01d63..53bb7a8d10b5 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -40,7 +40,7 @@ static unsigned long xen_tsc_khz(void)
 	return pvclock_tsc_khz(info);
 }
 
-u64 xen_clocksource_read(void)
+static u64 xen_clocksource_read(void)
 {
         struct pvclock_vcpu_time_info *src;
 	u64 ret;
@@ -503,7 +503,7 @@ static void __init xen_time_init(void)
 		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
 }
 
-void __ref xen_init_time_ops(void)
+void __init xen_init_time_ops(void)
 {
 	pv_time_ops = xen_time_ops;
 
@@ -542,8 +542,7 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 
 	if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
-		printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
-				"disable pv timer\n");
+		pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
 		return;
 	}
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 3b34745d0a52..e78684597f57 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -31,7 +31,6 @@ extern struct shared_info xen_dummy_shared_info;
 extern struct shared_info *HYPERVISOR_shared_info;
 
 void xen_setup_mfn_list_list(void);
-void xen_setup_shared_info(void);
 void xen_build_mfn_list_list(void);
 void xen_setup_machphys_mapping(void);
 void xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn);
@@ -68,12 +67,11 @@ void xen_init_irq_ops(void);
 void xen_setup_timer(int cpu);
 void xen_setup_runstate_info(int cpu);
 void xen_teardown_timer(int cpu);
-u64 xen_clocksource_read(void);
 void xen_setup_cpu_clockevents(void);
 void xen_save_time_memory_area(void);
 void xen_restore_time_memory_area(void);
-void __ref xen_init_time_ops(void);
-void __init xen_hvm_init_time_ops(void);
+void xen_init_time_ops(void);
+void xen_hvm_init_time_ops(void);
 
 irqreturn_t xen_debug_interrupt(int irq, void *dev_id);
 
