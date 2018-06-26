Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25329C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6602451A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6602451A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935148AbeFZAJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934585AbeFZAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04M8g061796
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:06 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96ttuky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06uPK9568562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 851DBB2072;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64FFCB206B;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6F9A416CA093; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 23/40] rcu: Convert rcu_preempt_task tracepoint to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:42 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0068-0000-0000-0000030E182A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0069-0000-0000-000044CF089A
Message-Id: <20180626000859.23572-23-paulmck@linux.vnet.ibm.com>
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

This commit makes the rcu_preempt_task tracepoint use ->gp_seq instead
of ->gpnum.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 12 ++++++------
 kernel/rcu/tree_plugin.h   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 892016ad0647..38dbd97d65a3 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -298,24 +298,24 @@ TRACE_EVENT(rcu_nocb_wake,
  */
 TRACE_EVENT(rcu_preempt_task,
 
-	TP_PROTO(const char *rcuname, int pid, unsigned long gpnum),
+	TP_PROTO(const char *rcuname, int pid, unsigned long gp_seq),
 
-	TP_ARGS(rcuname, pid, gpnum),
+	TP_ARGS(rcuname, pid, gp_seq),
 
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
 
 	TP_printk("%s %lu %d",
-		  __entry->rcuname, __entry->gpnum, __entry->pid)
+		  __entry->rcuname, __entry->gp_seq, __entry->pid)
 );
 
 /*
@@ -761,7 +761,7 @@ TRACE_EVENT(rcu_barrier,
 #define trace_rcu_exp_funnel_lock(rcuname, level, grplo, grphi, gpevent) \
 	do { } while (0)
 #define trace_rcu_nocb_wake(rcuname, cpu, reason) do { } while (0)
-#define trace_rcu_preempt_task(rcuname, pid, gpnum) do { } while (0)
+#define trace_rcu_preempt_task(rcuname, pid, gp_seq) do { } while (0)
 #define trace_rcu_unlock_preempted_task(rcuname, gpnum, pid) do { } while (0)
 #define trace_rcu_quiescent_state_report(rcuname, gpnum, mask, qsmask, level, \
 					 grplo, grphi, gp_tasks) do { } \
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index aca9d187c509..02ca3b4e6a8f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -350,8 +350,8 @@ static void rcu_preempt_note_context_switch(bool preempt)
 		trace_rcu_preempt_task(rdp->rsp->name,
 				       t->pid,
 				       (rnp->qsmask & rdp->grpmask)
-				       ? rnp->gpnum
-				       : rnp->gpnum + 1);
+				       ? rnp->gp_seq
+				       : rcu_seq_snap(&rnp->gp_seq));
 		rcu_preempt_ctxt_queue(rnp, rdp);
 	} else if (t->rcu_read_lock_nesting < 0 &&
 		   t->rcu_read_unlock_special.s) {
-- 
2.17.1

