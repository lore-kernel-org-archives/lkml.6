Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18597C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7A426382
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7A426382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935156AbeFZAul (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:50:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934604AbeFZAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n1E0060283
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96rku6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:29 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oOOd8454486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C5ADB2072;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C631B2068;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 612F716CA09B; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 08/13] rcutorture: Emphasize testing of single reader protection type
Date:   Mon, 25 Jun 2018 17:52:22 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-00000445293F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B3EFF
Message-Id: <20180626005227.30660-8-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RCU implementations supporting multiple types of reader protection,
rcutorture currently randomly selects the combinations of types of
protection for each phase of each reader.  The problem with this,
for example, given the four kinds of protection for RCU-sched
(local_irq_disable(), local_bh_disable(), preempt_disable(), and
rcu_read_lock_sched()), the reader will be protected by a single
mechanism only 25% of the time.  We really heavier testing of single
read-side mechanisms.

This commit therefore uses only a single mechanism about 60% of the time,
half of the time explicitly and one-eighth of the time by chance.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f97757755207..aa0be7ec2a26 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -69,6 +69,7 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com> and Josh Triplett <josh@jos
 #define RCUTORTURE_RDR_IRQ	 0x2	/*  ... disabling interrupts. */
 #define RCUTORTURE_RDR_PREEMPT	 0x4	/*  ... disabling preemption. */
 #define RCUTORTURE_RDR_RCU	 0x8	/*  ... entering another RCU reader. */
+#define RCUTORTURE_RDR_NBITS	 4	/* Number of bits defined above. */
 #define RCUTORTURE_MAX_EXTEND	 (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | \
 				  RCUTORTURE_RDR_PREEMPT)
 #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
@@ -1198,9 +1199,15 @@ static int
 rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 {
 	int mask = rcutorture_extend_mask_max();
+	unsigned long randmask1 = torture_random(trsp) >> 8;
+	unsigned long randmask2 = randmask1 >> 1;
 
 	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
-	mask = mask & (torture_random(trsp) >> RCUTORTURE_RDR_SHIFT);
+	/* Half the time lots of bits, half the time only one bit. */
+	if (randmask1 & 0x1)
+		mask = mask & randmask2;
+	else
+		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
 	if ((mask & RCUTORTURE_RDR_IRQ) &&
 	    !(mask & RCUTORTURE_RDR_BH) &&
 	    (oldmask & RCUTORTURE_RDR_BH))
-- 
2.17.1

