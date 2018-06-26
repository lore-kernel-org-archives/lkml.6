Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A770C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B38B2633D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B38B2633D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964772AbeFZAuf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:50:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934580AbeFZAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n1MI039454
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96rbtem-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:29 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:29 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oOtN18153856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4284DB206A;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 235B1B205F;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 52FEA16C05E9; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/13] rcutorture: Make rcu_torture_timer() use rcu_torture_one_read()
Date:   Mon, 25 Jun 2018 17:52:20 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0072-0000-0000-0000037476BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0073-0000-0000-0000487C79A0
Message-Id: <20180626005227.30660-6-paulmck@linux.vnet.ibm.com>
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

This commit saves a few lines of code by making rcu_torture_timer()
invoke rcu_torture_one_read(), thus completing the consolidation of
code between rcu_torture_timer() and rcu_torture_reader().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 47 +----------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d5a5465d2507..ac700aa6dcaf 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1153,53 +1153,8 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
  */
 static void rcu_torture_timer(struct timer_list *unused)
 {
-	int idx;
-	unsigned long started;
-	unsigned long completed;
-	struct rcu_torture *p;
-	int pipe_count;
-	struct torture_random_state *trsp;
-	unsigned long long ts;
-
-	trsp = this_cpu_ptr(&rcu_torture_timer_rand);
 	atomic_long_inc(&n_rcu_torture_timers);
-	idx = cur_ops->readlock();
-	started = cur_ops->get_gp_seq();
-	ts = rcu_trace_clock_local();
-	p = rcu_dereference_check(rcu_torture_current,
-				  rcu_read_lock_bh_held() ||
-				  rcu_read_lock_sched_held() ||
-				  srcu_read_lock_held(srcu_ctlp) ||
-				  torturing_tasks());
-	if (p == NULL) {
-		/* Leave because rcu_torture_writer is not yet underway */
-		cur_ops->readunlock(idx);
-		return;
-	}
-	if (p->rtort_mbtest == 0)
-		atomic_inc(&n_rcu_torture_mberror);
-	cur_ops->read_delay(trsp);
-	preempt_disable();
-	pipe_count = p->rtort_pipe_count;
-	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
-		pipe_count = RCU_TORTURE_PIPE_LEN;
-	}
-	completed = cur_ops->get_gp_seq();
-	if (pipe_count > 1) {
-		do_trace_rcu_torture_read(cur_ops->name, &p->rtort_rcu, ts,
-					  started, completed);
-		rcu_ftrace_dump(DUMP_ALL);
-	}
-	__this_cpu_inc(rcu_torture_count[pipe_count]);
-	completed = rcutorture_seq_diff(completed, started);
-	if (completed > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
-		completed = RCU_TORTURE_PIPE_LEN;
-	}
-	__this_cpu_inc(rcu_torture_batch[completed]);
-	preempt_enable();
-	cur_ops->readunlock(idx);
+	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand));
 
 	/* Test call_rcu() invocation from interrupt handler. */
 	if (cur_ops->call) {
-- 
2.17.1

