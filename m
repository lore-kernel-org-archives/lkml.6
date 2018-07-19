Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F658ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2135220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2135220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeGSXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:20:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbeGSXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:20:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMZ1vJ2439993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:35:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMZ0b22439990;
        Thu, 19 Jul 2018 15:35:00 -0700
Date:   Thu, 19 Jul 2018 15:35:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-8dbe438589f373544a1af8b4a859e4da853c0f90@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, pasha.tatashin@oracle.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, pasha.tatashin@oracle.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180719205545.16512-27-pasha.tatashin@oracle.com>
References: <20180719205545.16512-27-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Make use of tsc_calibrate_cpu_early()
Git-Commit-ID: 8dbe438589f373544a1af8b4a859e4da853c0f90
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

Commit-ID:  8dbe438589f373544a1af8b4a859e4da853c0f90
Gitweb:     https://git.kernel.org/tip/8dbe438589f373544a1af8b4a859e4da853c0f90
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:45 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:44 +0200

x86/tsc: Make use of tsc_calibrate_cpu_early()

During early boot enable tsc_calibrate_cpu_early() and switch to
tsc_calibrate_cpu() only later. Do this unconditionally, because it is
unknown what methods other cpus will use to calibrate once they are
onlined.

If by the time tsc_init() is called tsc frequency is still unknown do only
pit_hpet_ptimer_calibrate_cpu() to calibrate, as this function contains the
only methods wich have not been called and tried earlier.

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
Link: https://lkml.kernel.org/r/20180719205545.16512-27-pasha.tatashin@oracle.com

---
 arch/x86/include/asm/tsc.h |  1 -
 arch/x86/kernel/tsc.c      | 25 +++++++++++++++++++------
 arch/x86/kernel/x86_init.c |  2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 88140e4f2292..eb5bbfeccb66 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -39,7 +39,6 @@ extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
-extern unsigned long native_calibrate_cpu(void);
 extern unsigned long native_calibrate_cpu_early(void);
 extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 60586779b02c..02e416b87ac1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -854,7 +854,7 @@ unsigned long native_calibrate_cpu_early(void)
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
-unsigned long native_calibrate_cpu(void)
+static unsigned long native_calibrate_cpu(void)
 {
 	unsigned long tsc_freq = native_calibrate_cpu_early();
 
@@ -1374,13 +1374,19 @@ unreg:
  */
 device_initcall(init_tsc_clocksource);
 
-static bool __init determine_cpu_tsc_frequencies(void)
+static bool __init determine_cpu_tsc_frequencies(bool early)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
 	WARN_ON(cpu_khz || tsc_khz);
 
-	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
+	if (early) {
+		cpu_khz = x86_platform.calibrate_cpu();
+		tsc_khz = x86_platform.calibrate_tsc();
+	} else {
+		/* We should not be here with non-native cpu calibration */
+		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
+		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
+	}
 
 	/*
 	 * Trust non-zero tsc_khz as authorative,
@@ -1419,7 +1425,7 @@ void __init tsc_early_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
-	if (!determine_cpu_tsc_frequencies())
+	if (!determine_cpu_tsc_frequencies(true))
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
 
@@ -1431,6 +1437,13 @@ void __init tsc_early_init(void)
 
 void __init tsc_init(void)
 {
+	/*
+	 * native_calibrate_cpu_early can only calibrate using methods that are
+	 * available early in boot.
+	 */
+	if (x86_platform.calibrate_cpu == native_calibrate_cpu_early)
+		x86_platform.calibrate_cpu = native_calibrate_cpu;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 		return;
@@ -1438,7 +1451,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies()) {
+		if (!determine_cpu_tsc_frequencies(false)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 3ab867603e81..2792b5573818 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -109,7 +109,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 static void default_nmi_init(void) { };
 
 struct x86_platform_ops x86_platform __ro_after_init = {
-	.calibrate_cpu			= native_calibrate_cpu,
+	.calibrate_cpu			= native_calibrate_cpu_early,
 	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
 	.set_wallclock			= mach_set_rtc_mmss,
