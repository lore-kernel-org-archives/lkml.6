Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8CECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DEA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ux6fls4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DEA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeGSVmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:42:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbeGSVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:42:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKssQ5186386;
        Thu, 19 Jul 2018 20:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=76L+hXw4dZ++psFCY7oel3osnX7hCETHNjr7rIt3qw4=;
 b=ux6fls4xQqKEhXtIXBQGo2BaRRCvNSzLZi0e3MR43t/87wBZx2rEMnBQyGOrlXUzyhdr
 aqPbwOOQQy6ZvWl63RLmPzA0exu/qzKtQi0VyXCSRCAGOVO1BXsVaHdRKl1ktum6DI65
 IJRSU9okJ3IZKuCdaojrMQnQTZJNJg58Ra3jiUcJ+mBCwOiJFsxvdYsp8RE8VN0+Q7U1
 Id4yDl+OBwcVArFSToJ+F+76hzp50QaUTNSeMUP53o4A88yUjt+T1OtX/TCGC9GBL9e4
 JvHm+qHK72I/PhNTf13BwmnKtNuafKULV1qIfMBHocviFvp8nBFHGozIDKsSUI325mW2 IA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3tca8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:57:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKv2bq012177
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:57:02 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKv22W003972;
        Thu, 19 Jul 2018 20:57:02 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:57:01 +0000
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
Subject: [PATCH v15 26/26] x86/tsc:  use tsc_calibrate_cpu_early and pit_hpet_ptimer_calibrate_cpu
Date:   Thu, 19 Jul 2018 16:55:45 -0400
Message-Id: <20180719205545.16512-27-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early in boot enable tsc_calibrate_cpu_early and switch to
tsc_calibrate_cpu() only later. Do this unconditionally, because it is
unknown what methods other cpus will use to calibrate once they are
onlined.

If by the time tsc_init() is called tsc frequency is still unknown do only
pit_hpet_ptimer_calibrate_cpu to calibrate, as this function contails the
only methods that had not been called earlier in boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
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
 
@@ -1374,13 +1374,19 @@ static int __init init_tsc_clocksource(void)
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
-- 
2.18.0

