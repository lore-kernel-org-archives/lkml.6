Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF8ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655BE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pquaBNdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655BE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeGRC7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:59:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbeGRC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2JVX6169033;
        Wed, 18 Jul 2018 02:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1OKYBYbjpBzdL78BrlqCdhIvSCqx7ycLk3y3b/PE7ic=;
 b=pquaBNdHAypzAlFFwoEC6Rih3uDZgioYR4h7TeW2g9jRr5b53+WgII+uqBo3JHr9hVHk
 gEsagKq3PBaDVN5AGS5fcBCFYCABZ0hP2z9MaG5FOVeMfqzKSOppW2NUhreAp8ewZyJZ
 qhs/9M93Rhv2+Mhi8oKDtY9SX09WptSTnKJgTxstAbooFDyFPoBWwmRcN71pSwlPpE2n
 SdGXne/gbIKV1+1HpSjsMmoh2LFJFSfCiBxbA92SXaox9sKDFyhmrzWYZ5VjeZ/BXX5j
 GdvE3jkF07LwVcKO+U+FYvgT5UYBMauN1DpIvClionJsnQ0NU72ZPK8C2IkA46G7fHkg 6w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2k7a3tb44c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NAXw028297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:10 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2N96c020835;
        Wed, 18 Jul 2018 02:23:09 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:09 -0700
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
Subject: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
Date:   Tue, 17 Jul 2018 22:22:06 -0400
Message-Id: <20180718022211.6259-21-pasha.tatashin@oracle.com>
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
---
 arch/x86/include/asm/tsc.h |  2 +-
 arch/x86/kernel/setup.c    |  2 +-
 arch/x86/kernel/tsc.c      | 86 ++++++++++++++++++++------------------
 3 files changed, 48 insertions(+), 42 deletions(-)

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
index 186395041725..bc8eb82050a3 100644
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
@@ -1335,34 +1337,10 @@ static int __init init_tsc_clocksource(void)
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
+static bool determine_cpu_tsc_frequncies(void)
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
@@ -1377,20 +1355,51 @@ void __init tsc_init(void)
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
+static unsigned long get_loops_per_jiffy(void)
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
+	if (!determine_cpu_tsc_frequncies())
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
+		if (!determine_cpu_tsc_frequncies()) {
+			mark_tsc_unstable("could not calculate TSC khz");
+			return;
+		}
 	}
 
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
@@ -1413,10 +1422,7 @@ void __init tsc_init(void)
 	if (!no_sched_irq_time)
 		enable_sched_clock_irqtime();
 
-	lpj = ((u64)tsc_khz * 1000);
-	do_div(lpj, HZ);
-	lpj_fine = lpj;
-
+	lpj_fine = get_loops_per_jiffy();
 	use_tsc_delay();
 
 	check_system_tsc_reliable();
-- 
2.18.0

