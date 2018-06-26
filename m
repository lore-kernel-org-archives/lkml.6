Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5E26314
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE5E26314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935268AbeFZAKi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:10:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934556AbeFZAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04MSf061843
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96ttukd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06wGl4391402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E3D4B2077;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4713FB2064;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 744AE16CA096; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 24/40] rcu: Convert rcu_unlock_preempted_task tracepoint to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-00000303F3D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23BCD5
Message-Id: <20180626000859.23572-24-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the rcu_unlock_preempted_task tracepoint use ->gp_seq
instead of ->gpnum.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 12 ++++++------
 kernel/rcu/tree_plugin.h   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 38dbd97d65a3..95b7491196aa 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -325,23 +325,23 @@ TRACE_EVENT(rcu_preempt_task,
  */
 TRACE_EVENT(rcu_unlock_preempted_task,
 
-	TP_PROTO(const char *rcuname, unsigned long gpnum, int pid),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq, int pid),
 
-	TP_ARGS(rcuname, gpnum, pid),
+	TP_ARGS(rcuname, gp_seq, pid),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(unsigned long, gpnum)
+		__field(unsigned long, gp_seq)
 		__field(int, pid)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->gpnum = gpnum;
+		__entry->gp_seq = gp_seq;
 		__entry->pid = pid;
 	),
 
-	TP_printk("%s %lu %d", __entry->rcuname, __entry->gpnum, __entry->pid)
+	TP_printk("%s %lu %d", __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
 /*
@@ -762,7 +762,7 @@ TRACE_EVENT(rcu_barrier,
 	do { } while (0)
 #define trace_rcu_nocb_wake(rcuname, cpu, reason) do { } while (0)
 #define trace_rcu_preempt_task(rcuname, pid, gp_seq) do { } while (0)
-#define trace_rcu_unlock_preempted_task(rcuname, gpnum, pid) do { } while (0)
+#define trace_rcu_unlock_preempted_task(rcuname, gp_seq, pid) do { } while (0)
 #define trace_rcu_quiescent_state_report(rcuname, gpnum, mask, qsmask, level, \
 					 grplo, grphi, gp_tasks) do { } \
 	while (0)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 02ca3b4e6a8f..a10b0e26ce19 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -545,7 +545,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 		list_del_init(&t->rcu_node_entry);
 		t->rcu_blocked_node = NULL;
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt"),
-						rnp->gpnum, t->pid);
+						rnp->gp_seq, t->pid);
 		if (&t->rcu_node_entry == rnp->gp_tasks)
 			rnp->gp_tasks = np;
 		if (&t->rcu_node_entry == rnp->exp_tasks)
@@ -708,7 +708,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 		t = container_of(rnp->gp_tasks, struct task_struct,
 				 rcu_node_entry);
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt-GPS"),
-						rnp->gpnum, t->pid);
+						rnp->gp_seq, t->pid);
 	}
 	WARN_ON_ONCE(rnp->qsmask);
 }
-- 
2.17.1

