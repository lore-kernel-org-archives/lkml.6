Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3348BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8E8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8E8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbeGTUBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:01:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388292AbeGTUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:01:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KJ3aPt103356
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:11:23 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kbnj2rafb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:11:23 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 15:11:22 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 15:11:21 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6KJBK9j9896282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 19:11:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A63B2064;
        Fri, 20 Jul 2018 15:11:08 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19D59B2066;
        Fri, 20 Jul 2018 15:11:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jul 2018 15:11:08 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A5D0D16CA229; Fri, 20 Jul 2018 12:11:21 -0700 (PDT)
Date:   Fri, 20 Jul 2018 12:11:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC tip/core/rcu] rcutorture: Limit reader duration if irq or
 bh disabled
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072019-0068-0000-0000-0000031B462F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009399; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01063656; UDB=6.00546225; IPR=6.00841507;
 MB=3.00022234; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-20 19:11:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072019-0069-0000-0000-0000451A1B53
Message-Id: <20180720191121.GA18061@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thomas,

As discussed on IRC.  Thoughts?

							Thanx, Paul


commit 6ba3f37d31b614d7a41c3a1eb472dfc4e44944af
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Fri Jul 20 12:04:12 2018 -0700

    rcutorture: Limit reader duration if irq or bh disabled
    
    There are debug checks in some environments that will complain if the
    duration of a bh-disabled region of code exceeds about 50 milliseconds.
    Because rcu_read_delay() can produce a 50-millisecond delay and because
    there could be up to eight reader segments with such delays, this commit
    limits the maximum delay to 10 milliseconds if either interrupts or
    softirqs are disabled.
    
    Reported-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 28af5db3e7d1..16735a3545d2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -341,7 +341,7 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg * rtrsp)
 	unsigned long started;
 	unsigned long completed;
 	const unsigned long shortdelay_us = 200;
-	const unsigned long longdelay_ms = 300;
+	unsigned long longdelay_ms = 300;
 	unsigned long long ts;
 
 	/* We want a short delay sometimes to make a reader delay the grace
@@ -351,6 +351,8 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg * rtrsp)
 	if (!(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
+		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
+			longdelay_ms = 5; /* Avoid triggering BH limits. */
 		mdelay(longdelay_ms);
 		rtrsp->rt_delay_ms = longdelay_ms;
 		completed = cur_ops->get_gp_seq();

