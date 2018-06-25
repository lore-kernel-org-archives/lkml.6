Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E393C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260DD2627A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260DD2627A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeFYXC7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:02:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753205AbeFYXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:02:31 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMwrQq082660
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:02:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96q8v6a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:02:30 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 19:02:30 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 19:02:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PN2O7f4063592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 23:02:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1A9FB206A;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98F10B2064;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EC44D16CA097; Mon, 25 Jun 2018 16:04:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/5] rcu: Exclude near-simultaneous RCU CPU stall warnings
Date:   Mon, 25 Jun 2018 16:04:25 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625230410.GA13250@linux.vnet.ibm.com>
References: <20180625230410.GA13250@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062523-0052-0000-0000-00000303EDCC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052306; UDB=6.00539451; IPR=6.00830231;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 23:02:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062523-0053-0000-0000-00005D239ACE
Message-Id: <20180625230427.13877-3-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a two-jiffy delay between the time that a CPU will self-report
an RCU CPU stall warning and the time that some other CPU will report a
warning on behalf of the first CPU.  This has worked well in the past,
but on busy systems, it is possible for the two warnings to overlap,
which makes interpreting them extremely difficult.

This commit therefore uses a cmpxchg-based timing decision that
allows only one report in a given one-minute period (assuming default
stall-warning Kconfig parameters).  This approach will of course fail
if you are seeing minute-long vCPU preemption, but in that case the
overlapping RCU CPU stall warnings are the least of your worries.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79c7fe978b17..b1fffa21b9e4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1368,7 +1368,6 @@ static inline void panic_on_rcu_stall(void)
 static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 {
 	int cpu;
-	long delta;
 	unsigned long flags;
 	unsigned long gpa;
 	unsigned long j;
@@ -1381,18 +1380,6 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 	if (rcu_cpu_stall_suppress)
 		return;
 
-	/* Only let one CPU complain about others per time interval. */
-
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	delta = jiffies - READ_ONCE(rsp->jiffies_stall);
-	if (delta < RCU_STALL_RAT_DELAY || !rcu_gp_in_progress(rsp)) {
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		return;
-	}
-	WRITE_ONCE(rsp->jiffies_stall,
-		   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
@@ -1441,6 +1428,10 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 			sched_show_task(current);
 		}
 	}
+	/* Rewrite if needed in case of slow consoles. */
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
+		WRITE_ONCE(rsp->jiffies_stall,
+			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
 	rcu_check_gp_kthread_starvation(rsp);
 
@@ -1485,6 +1476,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	rcu_dump_cpu_stacks(rsp);
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	/* Rewrite if needed in case of slow consoles. */
 	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
 		WRITE_ONCE(rsp->jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
@@ -1508,6 +1500,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	unsigned long gpnum;
 	unsigned long gps;
 	unsigned long j;
+	unsigned long jn;
 	unsigned long js;
 	struct rcu_node *rnp;
 
@@ -1546,14 +1539,17 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	    ULONG_CMP_GE(gps, js))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
+	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
 	if (rcu_gp_in_progress(rsp) &&
-	    (READ_ONCE(rnp->qsmask) & rdp->grpmask)) {
+	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
+	    cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(rsp);
 
 	} else if (rcu_gp_in_progress(rsp) &&
-		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) {
+		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
+		   cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(rsp, gpnum);
-- 
2.17.1

