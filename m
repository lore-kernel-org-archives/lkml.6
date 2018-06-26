Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC1AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A351F262EE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A351F262EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934694AbeFZAHH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:07:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934277AbeFZAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04QEj132117
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96r2nk1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:02 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06vl519202394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F18DB2079;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3942BB206A;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4E67C16CA0A3; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/40] rcutorture: Convert rcutorture_get_gp_data() to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:36 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-00000303F3D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23BCD7
Message-Id: <20180626000859.23572-17-paulmck@linux.vnet.ibm.com>
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

SRCU has long used ->srcu_gp_seq, and now RCU uses ->gp_seq.  This
commit therefore moves the rcutorture_get_gp_data() function from
a ->gpnum / ->completed pair to ->gp_seq.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h        | 17 ++++++-----------
 kernel/rcu/rcutorture.c | 24 ++++++++++--------------
 kernel/rcu/srcutree.c   |  5 ++---
 kernel/rcu/tree.c       |  5 ++---
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7568a3fd0815..003671825d62 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -425,7 +425,7 @@ enum rcutorture_type {
 
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gpnum, unsigned long *completed);
+			    unsigned long *gp_seq);
 void rcutorture_record_test_transition(void);
 void rcutorture_record_progress(unsigned long vernum);
 void do_trace_rcu_torture_read(const char *rcutorturename,
@@ -435,13 +435,10 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c);
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
-					  int *flags,
-					  unsigned long *gpnum,
-					  unsigned long *completed)
+					  int *flags, unsigned long *gp_seq)
 {
 	*flags = 0;
-	*gpnum = 0;
-	*completed = 0;
+	*gp_seq = 0;
 }
 static inline void rcutorture_record_test_transition(void) { }
 static inline void rcutorture_record_progress(unsigned long vernum) { }
@@ -461,21 +458,19 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 
 static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
 					   struct srcu_struct *sp, int *flags,
-					   unsigned long *gpnum,
-					   unsigned long *completed)
+					   unsigned long *gp_seq)
 {
 	if (test_type != SRCU_FLAVOR)
 		return;
 	*flags = 0;
-	*completed = sp->srcu_idx;
-	*gpnum = *completed;
+	*gp_seq = sp->srcu_idx;
 }
 
 #elif defined(CONFIG_TREE_SRCU)
 
 void srcutorture_get_gp_data(enum rcutorture_type test_type,
 			     struct srcu_struct *sp, int *flags,
-			     unsigned long *gpnum, unsigned long *completed);
+			     unsigned long *gp_seq);
 
 #endif
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1f66597c7783..81fb43530d64 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1313,18 +1313,16 @@ rcu_torture_stats_print(void)
 	if (rtcv_snap == rcu_torture_current_version &&
 	    rcu_torture_current != NULL) {
 		int __maybe_unused flags = 0;
-		unsigned long __maybe_unused gpnum = 0;
-		unsigned long __maybe_unused completed = 0;
+		unsigned long __maybe_unused gp_seq = 0;
 
 		rcutorture_get_gp_data(cur_ops->ttype,
-				       &flags, &gpnum, &completed);
+				       &flags, &gp_seq);
 		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
-					&flags, &gpnum, &completed);
+					&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu c%lu f%#x ->state %#lx cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#lx cpu %d\n",
 			 rcu_torture_writer_state_getname(),
-			 rcu_torture_writer_state,
-			 gpnum, completed, flags,
+			 rcu_torture_writer_state, gp_seq, flags,
 			 wtp == NULL ? ~0UL : wtp->state,
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
@@ -1605,8 +1603,7 @@ static void
 rcu_torture_cleanup(void)
 {
 	int flags = 0;
-	unsigned long gpnum = 0;
-	unsigned long completed = 0;
+	unsigned long gp_seq = 0;
 	int i;
 
 	rcutorture_record_test_transition();
@@ -1637,11 +1634,10 @@ rcu_torture_cleanup(void)
 		fakewriter_tasks = NULL;
 	}
 
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gpnum, &completed);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
-				&flags, &gpnum, &completed);
-	pr_alert("%s:  End-test grace-period state: g%lu c%lu f%#x\n",
-		 cur_ops->name, gpnum, completed, flags);
+	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
+	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	pr_alert("%s:  End-test grace-period state: g%lu f%#x\n",
+		 cur_ops->name, gp_seq, flags);
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	for (i = 0; i < ncbflooders; i++)
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5a1a9a07b407..d6d6ea9738c0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1249,13 +1249,12 @@ static void process_srcu(struct work_struct *work)
 
 void srcutorture_get_gp_data(enum rcutorture_type test_type,
 			     struct srcu_struct *sp, int *flags,
-			     unsigned long *gpnum, unsigned long *completed)
+			     unsigned long *gp_seq)
 {
 	if (test_type != SRCU_FLAVOR)
 		return;
 	*flags = 0;
-	*completed = rcu_seq_ctr(sp->srcu_gp_seq);
-	*gpnum = rcu_seq_ctr(sp->srcu_gp_seq_needed);
+	*gp_seq = rcu_seq_current(&sp->srcu_gp_seq);
 }
 EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9452842e0590..779db9644177 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -638,7 +638,7 @@ EXPORT_SYMBOL_GPL(rcutorture_record_test_transition);
  * Send along grace-period-related data for rcutorture diagnostics.
  */
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gpnum, unsigned long *completed)
+			    unsigned long *gp_seq)
 {
 	struct rcu_state *rsp = NULL;
 
@@ -658,8 +658,7 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 	if (rsp == NULL)
 		return;
 	*flags = READ_ONCE(rsp->gp_flags);
-	*gpnum = READ_ONCE(rsp->gpnum);
-	*completed = READ_ONCE(rsp->completed);
+	*gp_seq = rcu_seq_current(&rsp->gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-- 
2.17.1

