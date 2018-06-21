Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005E2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA703223FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jODceS5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA703223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933784AbeFUV0n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:26:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37454 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933760AbeFUV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:26:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LLO7YM138947;
        Thu, 21 Jun 2018 21:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=PhlQovQUtqxvQY7YwG/AEyhHnbXUMSQojHf+J/RT/Wo=;
 b=jODceS5NoEmCkzGz8lZtfg1Km3Nt88dQ8aOM2S1ZytLvFFZIegNixpdOgIFs8K1PhdGU
 yHN4bp5S1LzEQ9NmR8Nvk2zOFUoOo0e8rGe7nZn+cq/LoWJXrobyyIHMlexVOdC9kp2n
 UlT0Mfloj66E3fobkOOpmNCTDxR+aouQB387RWB4vHSbYkWLXOqhzW+32Vkt5v1fHmy0
 8db/PRkjxZIOkcuo8c2Hiny4PeDtcoijCjLSY4ecfo35s55ByWzPDzd6BVqWnSuhH2hY
 /hdULI4LJt4RNeNKTyANRZ38fkYq15K0NXDJhS/WKCuKi+LeV4zpxSgJD0gWSJG85ILx XQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jmtgx3qdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPgfE003567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:42 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPfu3014094;
        Thu, 21 Jun 2018 21:25:41 GMT
Received: from xakep.us.oracle.com (/10.39.228.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 14:25:41 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: [PATCH v12 10/11] sched: early boot clock
Date:   Thu, 21 Jun 2018 17:25:17 -0400
Message-Id: <20180621212518.19914-11-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sched_clock() to be used before schec_clock_init() and
sched_clock_init_late() are called. This provides us with a way to get
early boot timestamps on machines with unstable clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/sched/clock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 10c83e73837a..f034392b0f6c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -205,6 +205,11 @@ void clear_sched_clock_stable(void)
  */
 static int __init sched_clock_init_late(void)
 {
+	/* Transition to unstable clock from early clock */
+	local_irq_disable();
+	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
+	local_irq_enable();
+
 	sched_clock_running = 2;
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
@@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
-		return 0ull;
+	/* Use early clock until sched_clock_init_late() */
+	if (unlikely(sched_clock_running < 2))
+		return sched_clock() + __sched_clock_offset;
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
-- 
2.17.1

