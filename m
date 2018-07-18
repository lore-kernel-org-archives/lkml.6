Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467CECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB962075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObhVDMJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB962075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbeGRC7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:59:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbeGRC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2Jde6006898;
        Wed, 18 Jul 2018 02:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=o3x3pCNDg0OIK/EZ7Q6NbKtW+08Dt29Tx5w0Oewg4jo=;
 b=ObhVDMJYknYniXvYzOBthLIIjIdYVviX6HuspYUZoIPQRvdWX5CmldpCeer/bSyZPb7r
 SOwKVzsHo37h4j12NTfWLa3W6MLcmypIIXaAluqDlluZGx6gFYkzZBdSN8wq5UAJxhB6
 07cfG5h2H0/QZtXDig70jWtlWRci94WFhxGlbyOs+QCslV5XQvxHUijiDa/ZFHxsMUwj
 rmBmQLgM44CgduTSKYo/UBPqNz7Ug0tq29bo3uSqLT/ZHdSkgpZJFuSLzqGWwg8yj1GK
 KIZBl+4yb90faCYcvdkw9u5upmacs8Y6r5Z3lKMdXZNiaBtm/ZsIb6yGub90j8sLgo+Z CA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k7a3432sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MpYY023810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:51 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I2MpIB015995;
        Wed, 18 Jul 2018 02:22:51 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:51 -0700
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
Subject: [PATCH v14 13/25] x86/xen/time: initialize pv xen time in init_hypervisor_platform
Date:   Tue, 17 Jul 2018 22:21:59 -0400
Message-Id: <20180718022211.6259-14-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/xen/enlighten_pv.c | 51 +++++++++++++++++--------------------
 arch/x86/xen/mmu_pv.c       |  6 ++---
 arch/x86/xen/suspend_pv.c   |  5 ++--
 arch/x86/xen/time.c         |  7 +++--
 arch/x86/xen/xen-ops.h      |  6 ++---
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
 
-- 
2.18.0

