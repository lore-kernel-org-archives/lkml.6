Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D0DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B38223FC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDafv0P2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B38223FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933803AbeFUV0o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:26:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933597AbeFUV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:26:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LLO2iH138940;
        Thu, 21 Jun 2018 21:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=EA4rK6FgD53gSKDhrlMGw9HRIAkfpAPoqu00fOhzc5U=;
 b=eDafv0P2cuDysDNh7Xsr65tZFAdhdjZ8HoqjViTt/WICSKygs9TL/kpRD7ITs2Eup0f4
 sPI87zCEGzf59amq3C3S+WueSq0SqPv3+Y0FAGi6IGj00I+FgRdYXT9yMuTh95p9z6vK
 4po9YpV2Y52U3Kcp49FE6sCISqkwQCMnfJ3dcdfycly+jQj4VF1WNVDyLyq4hRpa7WEt
 qePD+xp0dFpCZ3joNhzB9mXZPsmBEG6BopTL1ohrtN6vjcHqDBhPt9HvFUR9qDPF5peE
 GeaO7bqf0hmTzedCd+mRAE+1K3SryneKIN+FMF3kEMYlvqMUYkz3HVJrJuromd4FZ3NN pg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgx3qdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPhFg031438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:44 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPgBf014109;
        Thu, 21 Jun 2018 21:25:42 GMT
Received: from xakep.us.oracle.com (/10.39.228.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 14:25:42 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: [PATCH v12 11/11] x86/tsc: use tsc early
Date:   Thu, 21 Jun 2018 17:25:18 -0400
Message-Id: <20180621212518.19914-12-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210230
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
regressions are introduced to this function, with the current approach
sched_clock() path is not modified at all.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 654a01cc0358..b8a893d8f84a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -133,22 +133,13 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
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
@@ -178,12 +169,31 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu,
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
+	static_branch_enable(&__use_tsc);
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -1354,6 +1364,7 @@ void __init tsc_early_delay_calibrate(void)
 	lpj = tsc_khz * 1000;
 	do_div(lpj, HZ);
 	loops_per_jiffy = lpj;
+	sched_clock_early_init(tsc_khz);
 }
 
 void __init tsc_init(void)
@@ -1382,6 +1393,7 @@ void __init tsc_init(void)
 	if (!tsc_khz) {
 		mark_tsc_unstable("could not calculate TSC khz");
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
+		static_branch_disable(&__use_tsc);
 		return;
 	}
 
-- 
2.17.1

