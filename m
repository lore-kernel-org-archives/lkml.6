Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFF0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FC42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FC42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeGSXQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:16:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57239 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbeGSXQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:16:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMVHrT2439532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:31:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMVHlx2439529;
        Thu, 19 Jul 2018 15:31:17 -0700
Date:   Thu, 19 Jul 2018 15:31:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-cf7a63ef4e0203f6f33284c69e8188d91422de83@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: pasha.tatashin@oracle.com, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180719205545.16512-20-pasha.tatashin@oracle.com>
References: <20180719205545.16512-20-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Calibrate tsc only once
Git-Commit-ID: cf7a63ef4e0203f6f33284c69e8188d91422de83
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

Commit-ID:  cf7a63ef4e0203f6f33284c69e8188d91422de83
Gitweb:     https://git.kernel.org/tip/cf7a63ef4e0203f6f33284c69e8188d91422de83
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:38 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:42 +0200

x86/tsc: Calibrate tsc only once

During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
and the second time in tsc_init().

Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
the calibration is done only early, and make tsc_init() to use the values
already determined in tsc_early_init().

Sometimes it is not possible to determine tsc early, as the subsystem that
is required is not yet initialized, in such case try again later in
tsc_init().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
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
Link: https://lkml.kernel.org/r/20180719205545.16512-20-pasha.tatashin@oracle.com

---
 arch/x86/include/asm/tsc.h |  2 +-
 arch/x86/kernel/setup.c    |  2 +-
 arch/x86/kernel/tsc.c      | 87 +++++++++++++++++++++++++---------------------
 3 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 2701d221583a..c4368ff73652 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -33,7 +33,7 @@ static inline cycles_t get_cycles(void)
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
-extern void tsc_early_delay_calibrate(void);
+extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 7490de925a81..5d32c55aeb8b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1014,6 +1014,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	init_hypervisor_platform();
 
+	tsc_early_init();
 	x86_init.resources.probe_roms();
 
 	/* after parse_early_param, so could debug it */
@@ -1199,7 +1200,6 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_find_dma_reserve();
 
-	tsc_early_delay_calibrate();
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 186395041725..4cab2236169e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -33,6 +33,8 @@ EXPORT_SYMBOL(cpu_khz);
 unsigned int __read_mostly tsc_khz;
 EXPORT_SYMBOL(tsc_khz);
 
+#define KHZ	1000
+
 /*
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
  */
@@ -1335,34 +1337,10 @@ unreg:
  */
 device_initcall(init_tsc_clocksource);
 
-void __init tsc_early_delay_calibrate(void)
-{
-	unsigned long lpj;
-
-	if (!boot_cpu_has(X86_FEATURE_TSC))
-		return;
-
-	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
-
-	tsc_khz = tsc_khz ? : cpu_khz;
-	if (!tsc_khz)
-		return;
-
-	lpj = tsc_khz * 1000;
-	do_div(lpj, HZ);
-	loops_per_jiffy = lpj;
-}
-
-void __init tsc_init(void)
+static bool __init determine_cpu_tsc_frequencies(void)
 {
-	u64 lpj, cyc;
-	int cpu;
-
-	if (!boot_cpu_has(X86_FEATURE_TSC)) {
-		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
-	}
+	/* Make sure that cpu and tsc are not already calibrated */
+	WARN_ON(cpu_khz || tsc_khz);
 
 	cpu_khz = x86_platform.calibrate_cpu();
 	tsc_khz = x86_platform.calibrate_tsc();
@@ -1377,20 +1355,52 @@ void __init tsc_init(void)
 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
 		cpu_khz = tsc_khz;
 
-	if (!tsc_khz) {
-		mark_tsc_unstable("could not calculate TSC khz");
-		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
-	}
+	if (tsc_khz == 0)
+		return false;
 
 	pr_info("Detected %lu.%03lu MHz processor\n",
-		(unsigned long)cpu_khz / 1000,
-		(unsigned long)cpu_khz % 1000);
+		(unsigned long)cpu_khz / KHZ,
+		(unsigned long)cpu_khz % KHZ);
 
 	if (cpu_khz != tsc_khz) {
 		pr_info("Detected %lu.%03lu MHz TSC",
-			(unsigned long)tsc_khz / 1000,
-			(unsigned long)tsc_khz % 1000);
+			(unsigned long)tsc_khz / KHZ,
+			(unsigned long)tsc_khz % KHZ);
+	}
+	return true;
+}
+
+static unsigned long __init get_loops_per_jiffy(void)
+{
+	unsigned long lpj = tsc_khz * KHZ;
+
+	do_div(lpj, HZ);
+	return lpj;
+}
+
+void __init tsc_early_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TSC))
+		return;
+	if (!determine_cpu_tsc_frequencies())
+		return;
+	loops_per_jiffy = get_loops_per_jiffy();
+}
+
+void __init tsc_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TSC)) {
+		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
+		return;
+	}
+
+	if (!tsc_khz) {
+		/* We failed to determine frequencies earlier, try again */
+		if (!determine_cpu_tsc_frequencies()) {
+			mark_tsc_unstable("could not calculate TSC khz");
+			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
+			return;
+		}
 	}
 
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
@@ -1413,10 +1423,7 @@ void __init tsc_init(void)
 	if (!no_sched_irq_time)
 		enable_sched_clock_irqtime();
 
-	lpj = ((u64)tsc_khz * 1000);
-	do_div(lpj, HZ);
-	lpj_fine = lpj;
-
+	lpj_fine = get_loops_per_jiffy();
 	use_tsc_delay();
 
 	check_system_tsc_reliable();
