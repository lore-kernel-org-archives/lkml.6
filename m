Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C903FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7402638D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7402638D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965171AbeFZAw3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:52:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934621AbeFZAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n1fU039384
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96rbtf2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:29 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oO5S4063612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E53A0B2072;
        Mon, 25 Jun 2018 20:50:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0637B206E;
        Mon, 25 Jun 2018 20:50:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4FE0516CA098; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/13] rcutorture: Use per-CPU random state for rcu_torture_timer()
Date:   Mon, 25 Jun 2018 17:52:19 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0060-0000-0000-000002827CC0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0061-0000-0000-000045935E13
Message-Id: <20180626005227.30660-5-paulmck@linux.vnet.ibm.com>
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

Currently, the rcu_torture_timer() function uses a single global
torture_random_state structure protected by a single global lock.
This conflicts to some extent with performance and scalability,
but even more with the goal of consolidating read-side testing
with rcu_torture_reader().  This commit therefore creates a per-CPU
torture_random_state structure for use by rcu_torture_timer() and
eliminates the lock.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Make rcu_torture_timer_rand static, per 0day Test Robot report. ]
---
 include/linux/torture.h |  2 ++
 kernel/rcu/rcutorture.c | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index a55e80817dae..61dfd93b6ee4 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -64,6 +64,8 @@ struct torture_random_state {
 	long trs_count;
 };
 #define DEFINE_TORTURE_RANDOM(name) struct torture_random_state name = { 0, 0 }
+#define DEFINE_TORTURE_RANDOM_PERCPU(name) \
+	DEFINE_PER_CPU(struct torture_random_state, name)
 unsigned long torture_random(struct torture_random_state *trsp);
 
 /* Task shuffler, which causes CPUs to occasionally go idle. */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2452e4a29923..d5a5465d2507 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1143,6 +1143,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	return true;
 }
 
+static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
+
 /*
  * RCU torture reader from timer handler.  Dereferences rcu_torture_current,
  * incrementing the corresponding element of the pipeline array.  The
@@ -1154,12 +1156,12 @@ static void rcu_torture_timer(struct timer_list *unused)
 	int idx;
 	unsigned long started;
 	unsigned long completed;
-	static DEFINE_TORTURE_RANDOM(rand);
-	static DEFINE_SPINLOCK(rand_lock);
 	struct rcu_torture *p;
 	int pipe_count;
+	struct torture_random_state *trsp;
 	unsigned long long ts;
 
+	trsp = this_cpu_ptr(&rcu_torture_timer_rand);
 	atomic_long_inc(&n_rcu_torture_timers);
 	idx = cur_ops->readlock();
 	started = cur_ops->get_gp_seq();
@@ -1176,9 +1178,7 @@ static void rcu_torture_timer(struct timer_list *unused)
 	}
 	if (p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
-	spin_lock(&rand_lock);
-	cur_ops->read_delay(&rand);
-	spin_unlock(&rand_lock);
+	cur_ops->read_delay(trsp);
 	preempt_disable();
 	pipe_count = p->rtort_pipe_count;
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-- 
2.17.1

