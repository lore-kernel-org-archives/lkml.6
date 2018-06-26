Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA41AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD52636C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCD52636C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935306AbeFZAgo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:36:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934580AbeFZAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0SbU6134148
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96puq7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:10 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0X9kl5833170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46836B2072;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3038BB2070;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AE57A16C9ED6; Mon, 25 Jun 2018 17:35:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/27] rcu: Improve rcu_note_voluntary_context_switch() reporting
Date:   Mon, 25 Jun 2018 17:34:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003204527
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539470; IPR=6.00830262;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B764CB
Message-Id: <20180626003513.27812-2-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Byungchul Park <byungchul.park@lge.com>

We expect a quiescent state of TASKS_RCU when cond_resched_tasks_rcu_qs()
is called, no matter whether it actually be scheduled or not. However,
it currently doesn't report the quiescent state when the task enters
into __schedule() as it's called with preempt = true. So make it report
the quiescent state unconditionally when cond_resched_tasks_rcu_qs() is
called.

And in TINY_RCU, even though the quiescent state of rcu_bh also should
be reported when the tick interrupt comes from user, it doesn't. So make
it reported.

Lastly in TREE_RCU, rcu_note_voluntary_context_switch() should be
reported when the tick interrupt comes from not only user but also idle,
as an extended quiescent state.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Simplify rcutiny portion given no RCU-tasks for !PREEMPT. ]
---
 include/linux/rcupdate.h | 4 ++--
 kernel/rcu/tiny.c        | 4 +---
 kernel/rcu/tree.c        | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 67ec077c7ee5..5cab15e7ec83 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -194,8 +194,8 @@ static inline void exit_tasks_rcu_finish(void) { }
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
-	if (!cond_resched()) \
-		rcu_note_voluntary_context_switch_lite(current); \
+	rcu_note_voluntary_context_switch_lite(current); \
+	cond_resched(); \
 } while (0)
 
 /*
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index a64eee0db39e..befc9321a89c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -122,10 +122,8 @@ void rcu_check_callbacks(int user)
 {
 	if (user)
 		rcu_sched_qs();
-	else if (!in_softirq())
+	if (user || !in_softirq())
 		rcu_bh_qs();
-	if (user)
-		rcu_note_voluntary_context_switch(current);
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4b0aee4f9318..50a8f49e1763 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2645,6 +2645,7 @@ void rcu_check_callbacks(int user)
 
 		rcu_sched_qs();
 		rcu_bh_qs();
+		rcu_note_voluntary_context_switch(current);
 
 	} else if (!in_softirq()) {
 
@@ -2660,8 +2661,7 @@ void rcu_check_callbacks(int user)
 	rcu_preempt_check_callbacks();
 	if (rcu_pending())
 		invoke_rcu_core();
-	if (user)
-		rcu_note_voluntary_context_switch(current);
+
 	trace_rcu_utilization(TPS("End scheduler-tick"));
 }
 
-- 
2.17.1

