Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C883C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D969C20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eGsUqOmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D969C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbeFTV2Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:28:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51244 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeFTV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:28:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KLOCQT026298;
        Wed, 20 Jun 2018 21:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=RdH70E+D+mkSYu7nX9Lvxp3EDVpProzOX/mSd49opv8=;
 b=eGsUqOmpFI8AABtzftxSRl3GG3JkUS98b2PjyM29/czc2AOnPVMwcbR2fyE5Igpich9d
 DUu6q9DWrleOo97RNIG9jBMwrYzujPn8dTb8cbTGr39tCKDSGNH51wZ4s6nbvexoEcX6
 YVZsd/zbWHYIaG/7/bag59oSI5qlwL6qHo3TqJt5AuvI0oM2h9uHrKSgQF3vjUZRBPcr
 4EcwtMrDv2qTT2v042vj8huKCApy1npuPpriMv8HS1KW9lFjUI8tEcpr2Zh7hGWJiljq
 llhhKb10My7VJWgw+XFyUDAQo2hswmNf9xCoyGDNUen4q7Al9U0kvz51VcCTA6EsVr9V 4Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6xx8q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLRBPu013481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:12 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KLRBWY000326;
        Wed, 20 Jun 2018 21:27:11 GMT
Received: from xakep.us.oracle.com (/10.39.216.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 14:27:11 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v11 4/6] x86/tsc: prepare for early sched_clock
Date:   Wed, 20 Jun 2018 17:26:58 -0400
Message-Id: <20180620212700.29178-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620212700.29178-1-pasha.tatashin@oracle.com>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will change sched_clock() to be called early. But, during boot
sched_clock() changes its output without notifying us about the change of
clock source.

This happens in tsc_init(), when static_branch_enable(&__use_tsc) is
called.

native_sched_clock() changes from outputing jiffies to reading tsc, but
sched is not notified in anyway. So, to preserve the continoutity in this
place we add the offset of sched_clock() to the calculation of cyc2ns.

Without this change, the output would look like this:

[    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.009000] tsc: Fast TSC calibration using PIT
[    0.010000] tsc: Detected 3192.137 MHz processor
[    0.011000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e03465ceb2,    max_idle_ns: 440795259855 ns

static_branch_enable(__use_tsc) is called, and timestamps became precise
but reduced:

[    0.002233] Calibrating delay loop (skipped), value calculated using timer frequency..     6384.27 BogoMIPS (lpj=3192137)
[    0.002516] pid_max: default: 32768 minimum: 301

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 186395041725..654a01cc0358 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -133,7 +133,9 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void set_cyc2ns_scale(unsigned long khz, int cpu,
+			     unsigned long long tsc_now,
+			     unsigned long long sched_now)
 {
 	unsigned long long ns_now;
 	struct cyc2ns_data data;
@@ -146,7 +148,7 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
 	if (!khz)
 		goto done;
 
-	ns_now = cycles_2_ns(tsc_now);
+	ns_now = cycles_2_ns(tsc_now) + sched_now;
 
 	/*
 	 * Compute a new multiplier as per the above comment and ensure our
@@ -936,7 +938,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 			mark_tsc_unstable("cpufreq changes");
 
-		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
+		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc(), 0);
 	}
 
 	return 0;
@@ -1285,7 +1287,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 	/* Update the sched_clock() rate to match the clocksource one */
 	for_each_possible_cpu(cpu)
-		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);
+		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop, 0);
 
 out:
 	if (tsc_unstable)
@@ -1356,7 +1358,7 @@ void __init tsc_early_delay_calibrate(void)
 
 void __init tsc_init(void)
 {
-	u64 lpj, cyc;
+	u64 lpj, cyc, sch;
 	int cpu;
 
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
@@ -1403,9 +1405,10 @@ void __init tsc_init(void)
 	 * up if their speed diverges)
 	 */
 	cyc = rdtsc();
+	sch = local_clock();
 	for_each_possible_cpu(cpu) {
 		cyc2ns_init(cpu);
-		set_cyc2ns_scale(tsc_khz, cpu, cyc);
+		set_cyc2ns_scale(tsc_khz, cpu, cyc, sch);
 	}
 
 	static_branch_enable(&__use_tsc);
-- 
2.17.1

