Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29961C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FAA20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FAA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbeKLGKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731821AbeKLGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJ9rq110680
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdbntw3e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:34 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKS4b46071864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39DF3B206B;
        Sun, 11 Nov 2018 20:20:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A31CB2070;
        Sun, 11 Nov 2018 20:20:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E74E616C5DA8; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 15/17] rcutorture: Recover from OOM during forward-progress tests
Date:   Sun, 11 Nov 2018 12:20:25 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0064-0000-0000-0000037230EB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00577118; IPR=6.00896131;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0065-0000-0000-00003B4D501B
Message-Id: <20181111202027.13585-15-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit causes the OOM handler to do rcu_barrier() calls and to
free up forward-progress callbacks in order to recover from OOM events.
The current test is terminated, but subsequent forward-progress tests can
proceed.  This allows a long test to result in multiple forward-progress
failures, greatly reducing the required testing time.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 60 +++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 080b5ac6340c..afa98162575d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1649,13 +1649,14 @@ static void rcu_torture_fwd_cb_hist(void)
 /* Callback function for continuous-flood RCU callbacks. */
 static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 {
+	unsigned long flags;
 	int i;
 	struct rcu_fwd_cb *rfcp = container_of(rhp, struct rcu_fwd_cb, rh);
 	struct rcu_fwd_cb **rfcpp;
 
 	rfcp->rfc_next = NULL;
 	rfcp->rfc_gps++;
-	spin_lock(&rcu_fwd_lock);
+	spin_lock_irqsave(&rcu_fwd_lock, flags);
 	rfcpp = rcu_fwd_cb_tail;
 	rcu_fwd_cb_tail = &rfcp->rfc_next;
 	WRITE_ONCE(*rfcpp, rfcp);
@@ -1664,7 +1665,33 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	if (i >= ARRAY_SIZE(n_launders_hist))
 		i = ARRAY_SIZE(n_launders_hist) - 1;
 	n_launders_hist[i]++;
-	spin_unlock(&rcu_fwd_lock);
+	spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+}
+
+/*
+ * Free all callbacks on the rcu_fwd_cb_head list, either because the
+ * test is over or because we hit an OOM event.
+ */
+static unsigned long rcu_torture_fwd_prog_cbfree(void)
+{
+	unsigned long flags;
+	unsigned long freed = 0;
+	struct rcu_fwd_cb *rfcp;
+
+	for (;;) {
+		spin_lock_irqsave(&rcu_fwd_lock, flags);
+		rfcp = rcu_fwd_cb_head;
+		if (!rfcp)
+			break;
+		rcu_fwd_cb_head = rfcp->rfc_next;
+		if (!rcu_fwd_cb_head)
+			rcu_fwd_cb_tail = &rcu_fwd_cb_head;
+		spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+		kfree(rfcp);
+		freed++;
+	}
+	spin_unlock_irqrestore(&rcu_fwd_lock, flags);
+	return freed;
 }
 
 /* Carry out need_resched()/cond_resched() forward-progress testing. */
@@ -1743,6 +1770,9 @@ static void rcu_torture_fwd_prog_cr(void)
 	unsigned long stopat;
 	unsigned long stoppedat;
 
+	if (READ_ONCE(rcu_fwd_emergency_stop))
+		return; /* Get out of the way quickly, no GP wait! */
+
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
 	cur_ops->sync(); /* Later readers see above write. */
@@ -1788,16 +1818,10 @@ static void rcu_torture_fwd_prog_cr(void)
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
-	for (;;) {
-		rfcp = rcu_fwd_cb_head;
-		if (!rfcp)
-			break;
-		rcu_fwd_cb_head = rfcp->rfc_next;
-		kfree(rfcp);
-	}
-	rcu_fwd_cb_tail = &rcu_fwd_cb_head;
+	(void)rcu_torture_fwd_prog_cbfree();
+
 	WRITE_ONCE(rcu_fwd_cb_nodelay, false);
-	if (!torture_must_stop()) {
+	if (!torture_must_stop() && !READ_ONCE(rcu_fwd_emergency_stop)) {
 		WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
 		pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
 			 __func__,
@@ -1817,9 +1841,23 @@ static void rcu_torture_fwd_prog_cr(void)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
+	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
+	     __func__);
 	rcu_torture_fwd_cb_hist();
 	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwd_startat) / 2));
 	WRITE_ONCE(rcu_fwd_emergency_stop, true);
+	smp_mb(); /* Emergency stop before free and wait to avoid hangs. */
+	pr_info("%s: Freed %lu RCU callbacks.\n",
+		__func__, rcu_torture_fwd_prog_cbfree());
+	rcu_barrier();
+	pr_info("%s: Freed %lu RCU callbacks.\n",
+		__func__, rcu_torture_fwd_prog_cbfree());
+	rcu_barrier();
+	pr_info("%s: Freed %lu RCU callbacks.\n",
+		__func__, rcu_torture_fwd_prog_cbfree());
+	smp_mb(); /* Frees before return to avoid redoing OOM. */
+	(*(unsigned long *)nfreed)++; /* Forward progress CBs freed! */
+	pr_info("%s returning after OOM processing.\n", __func__);
 	return NOTIFY_OK;
 }
 
-- 
2.17.1

