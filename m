Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1780FC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC8220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JcFlXMyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC8220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeFTVaT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:30:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42394 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933232AbeFTVaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:30:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KLOg3F135054;
        Wed, 20 Jun 2018 21:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=u0P1NPcYX3U4zix9MiVkIf6c6BLb2cdZ6+Xw8LqqXUs=;
 b=JcFlXMyhbQPivIO36Y3R9s2nURP4NYEaQyUoQYN2/ytIRYEtkDPYshqojEWtbl6cxo4z
 yAnmifK1Tihhe3EVbOytyuD3IlutskoI0az2D8BtiTnB17chROb4Ik5hA+d0E83XQEF+
 3t7oEUrKi71kr+3VAfsgimF+sSOPv3Jqa4TR2inoBwqfOmt8IUxi4ZhVq870ZbBYIP5r
 pc6q1B5I5Ko9GJtneZcXNrwGwu4o4SZ9cut37vmEsWC5xtlY6oWevnhQ/7UDUxytA1TR
 N9snD6czaWWdN6gubMEySxqMWYaWdfLGR9wOTN7ywV2HRzYHDRP5+JjLCusevgHyVVP4 Og== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jmr2mpewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLRFF1001939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:15 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KLRE09026996;
        Wed, 20 Jun 2018 21:27:14 GMT
Received: from xakep.us.oracle.com (/10.39.216.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 14:27:13 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v11 6/6] x86/tsc: use tsc early
Date:   Wed, 20 Jun 2018 17:27:00 -0400
Message-Id: <20180620212700.29178-7-pasha.tatashin@oracle.com>
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

We want to get timestamps and high resultion clock available to us as early
as possible in boot. But, native_sched_clock() outputs time based either on
tsc after tsc_init() is called later in boot, or using jiffies when clock
interrupts are enabled, which is also happens later in boot.

On the other hand, we know tsc frequency from as early as when
tsc_early_delay_calibrate() is called. So, we use the early tsc calibration
to output timestamps early. Later in boot when tsc_init() is called we
calibrate tsc again using more precise methods, and start using that.

Since sched_clock() is in a hot path, we want to make sure that no
regressions are introduced to this function after machine is booted, this
is why we are using static branch that is enabled by default, but is
disabled once we have initialized a permanent clock source.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 64 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 654a01cc0358..1dd69612c69c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -39,6 +39,9 @@ EXPORT_SYMBOL(tsc_khz);
 static int __read_mostly tsc_unstable;
 
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
+static DEFINE_STATIC_KEY_TRUE(tsc_early_enabled);
+
+static bool tsc_early_sched_clock;
 
 int tsc_clocksource_reliable;
 
@@ -133,22 +136,13 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu,
-			     unsigned long long tsc_now,
-			     unsigned long long sched_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu,
+			       unsigned long long tsc_now,
+			       unsigned long long sched_now)
 {
-	unsigned long long ns_now;
+	unsigned long long ns_now = cycles_2_ns(tsc_now) + sched_now;
 	struct cyc2ns_data data;
 	struct cyc2ns *c2n;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	sched_clock_idle_sleep_event();
-
-	if (!khz)
-		goto done;
-
-	ns_now = cycles_2_ns(tsc_now) + sched_now;
 
 	/*
 	 * Compute a new multiplier as per the above comment and ensure our
@@ -178,22 +172,47 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu,
 	c2n->data[0] = data;
 	raw_write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+}
+
+static void set_cyc2ns_scale(unsigned long khz, int cpu,
+			     unsigned long long tsc_now,
+			     unsigned long long sched_now)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	if (khz)
+		__set_cyc2ns_scale(khz, cpu, tsc_now, sched_now);
 
-done:
 	sched_clock_idle_wakeup_event();
 	local_irq_restore(flags);
 }
 
+static void __init sched_clock_early_init(unsigned int khz)
+{
+	cyc2ns_init(smp_processor_id());
+	__set_cyc2ns_scale(khz, smp_processor_id(), rdtsc(), 0);
+	tsc_early_sched_clock = true;
+}
+
+static void __init sched_clock_early_exit(void)
+{
+	static_branch_disable(&tsc_early_enabled);
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
 u64 native_sched_clock(void)
 {
-	if (static_branch_likely(&__use_tsc)) {
-		u64 tsc_now = rdtsc();
+	if (static_branch_likely(&__use_tsc))
+		return cycles_2_ns(rdtsc());
 
-		/* return the value in ns */
-		return cycles_2_ns(tsc_now);
+	if (static_branch_unlikely(&tsc_early_enabled)) {
+		if (tsc_early_sched_clock)
+			return cycles_2_ns(rdtsc());
 	}
 
 	/*
@@ -1354,9 +1373,10 @@ void __init tsc_early_delay_calibrate(void)
 	lpj = tsc_khz * 1000;
 	do_div(lpj, HZ);
 	loops_per_jiffy = lpj;
+	sched_clock_early_init(tsc_khz);
 }
 
-void __init tsc_init(void)
+static void __init __tsc_init(void)
 {
 	u64 lpj, cyc, sch;
 	int cpu;
@@ -1433,6 +1453,12 @@ void __init tsc_init(void)
 	detect_art();
 }
 
+void __init tsc_init(void)
+{
+	__tsc_init();
+	sched_clock_early_exit();
+}
+
 #ifdef CONFIG_SMP
 /*
  * If we have a constant TSC and are using the TSC for the delay loop,
-- 
2.17.1

