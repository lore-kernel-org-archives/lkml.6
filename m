Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5462C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D4C20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D4C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbeKLGKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731830AbeKLGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJF1f020763
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npd3sbh73-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:34 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:28 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKRCS20447450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A280AB206B;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61584B205F;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 954CD16C5D38; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/17] rcutorture: Add call_rcu() flooding forward-progress tests
Date:   Sun, 11 Nov 2018 12:20:11 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0072-0000-0000-000003C6F5DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00577118; IPR=6.00896132;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0073-0000-0000-00004A13578D
Message-Id: <20181111202027.13585-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

This commit adds a call_rcu() flooding loop to the forward-progress test.
This emulates tight userspace loops that force call_rcu() invocations,
for example, the infamous loop containing close(open()) that instigated
the addition of blimit.  If RCU does not make sufficient forward progress
in invoking the resulting flood of callbacks, rcutorture emits a warning.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 129 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 210c77460365..8cf700ca7845 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -259,6 +259,8 @@ static atomic_t barrier_cbs_invoked;	/* Barrier callbacks invoked. */
 static wait_queue_head_t *barrier_cbs_wq; /* Coordinate barrier testing. */
 static DECLARE_WAIT_QUEUE_HEAD(barrier_wq);
 
+static bool rcu_fwd_cb_nodelay;		/* Short rcu_torture_delay() delays. */
+
 /*
  * Allocate an element from the rcu_tortures pool.
  */
@@ -348,7 +350,8 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	 * period, and we want a long delay occasionally to trigger
 	 * force_quiescent_state. */
 
-	if (!(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
+	if (!rcu_fwd_cb_nodelay &&
+	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
 		if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
@@ -1674,6 +1677,43 @@ static void rcu_torture_fwd_prog_cb(struct rcu_head *rhp)
 	cur_ops->call(&fcsp->rh, rcu_torture_fwd_prog_cb);
 }
 
+/* State for continuous-flood RCU callbacks. */
+struct rcu_fwd_cb {
+	struct rcu_head rh;
+	struct rcu_fwd_cb *rfc_next;
+	int rfc_gps;
+};
+static DEFINE_SPINLOCK(rcu_fwd_lock);
+static struct rcu_fwd_cb *rcu_fwd_cb_head;
+static struct rcu_fwd_cb **rcu_fwd_cb_tail = &rcu_fwd_cb_head;
+static long n_launders_cb;
+static unsigned long rcu_fwd_startat;
+#define MAX_FWD_CB_JIFFIES	(8 * HZ) /* Maximum CB test duration. */
+#define MIN_FWD_CB_LAUNDERS	3	/* This many CB invocations to count. */
+#define MIN_FWD_CBS_LAUNDERED	100	/* Number of counted CBs. */
+static long n_launders_hist[2 * MAX_FWD_CB_JIFFIES / HZ];
+
+/* Callback function for continuous-flood RCU callbacks. */
+static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
+{
+	int i;
+	struct rcu_fwd_cb *rfcp = container_of(rhp, struct rcu_fwd_cb, rh);
+	struct rcu_fwd_cb **rfcpp;
+
+	rfcp->rfc_next = NULL;
+	rfcp->rfc_gps++;
+	spin_lock(&rcu_fwd_lock);
+	rfcpp = rcu_fwd_cb_tail;
+	rcu_fwd_cb_tail = &rfcp->rfc_next;
+	WRITE_ONCE(*rfcpp, rfcp);
+	WRITE_ONCE(n_launders_cb, n_launders_cb + 1);
+	i = ((jiffies - rcu_fwd_startat) / HZ);
+	if (i >= ARRAY_SIZE(n_launders_hist))
+		i = ARRAY_SIZE(n_launders_hist) - 1;
+	n_launders_hist[i]++;
+	spin_unlock(&rcu_fwd_lock);
+}
+
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
@@ -1681,11 +1721,21 @@ static int rcu_torture_fwd_prog(void *args)
 	unsigned long dur;
 	struct fwd_cb_state fcs;
 	unsigned long gps;
+	int i;
 	int idx;
+	int j;
+	long n_launders;
+	long n_launders_cb_snap;
+	long n_launders_sa;
+	long n_max_cbs;
+	long n_max_gps;
+	struct rcu_fwd_cb *rfcp;
+	struct rcu_fwd_cb *rfcpn;
 	int sd;
 	int sd4;
 	bool selfpropcb = false;
 	unsigned long stopat;
+	unsigned long stoppedat;
 	int tested = 0;
 	int tested_tries = 0;
 	static DEFINE_TORTURE_RANDOM(trs);
@@ -1699,6 +1749,8 @@ static int rcu_torture_fwd_prog(void *args)
 	}
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
+
+		/* Tight loop containing cond_resched(). */
 		if  (selfpropcb) {
 			WRITE_ONCE(fcs.stop, 0);
 			cur_ops->call(&fcs.rh, rcu_torture_fwd_prog_cb);
@@ -1708,7 +1760,8 @@ static int rcu_torture_fwd_prog(void *args)
 		sd = cur_ops->stall_dur() + 1;
 		sd4 = (sd + fwd_progress_div - 1) / fwd_progress_div;
 		dur = sd4 + torture_random(&trs) % (sd - sd4);
-		stopat = jiffies + dur;
+		rcu_fwd_startat = jiffies;
+		stopat = rcu_fwd_startat + dur;
 		while (time_before(jiffies, stopat) && !torture_must_stop()) {
 			idx = cur_ops->readlock();
 			udelay(10);
@@ -1729,6 +1782,78 @@ static int rcu_torture_fwd_prog(void *args)
 			cur_ops->sync(); /* Wait for running CB to complete. */
 			cur_ops->cb_barrier(); /* Wait for queued callbacks. */
 		}
+
+		/* Loop continuously posting RCU callbacks. */
+		WRITE_ONCE(rcu_fwd_cb_nodelay, true);
+		cur_ops->sync(); /* Later readers see above write. */
+		rcu_fwd_startat = jiffies;
+		stopat = rcu_fwd_startat + MAX_FWD_CB_JIFFIES;
+		n_launders = 0;
+		n_launders_cb = 0;
+		n_launders_sa = 0;
+		n_max_cbs = 0;
+		n_max_gps = 0;
+		for (i = 0; i < ARRAY_SIZE(n_launders_hist); i++)
+			n_launders_hist[i] = 0;
+		cver = READ_ONCE(rcu_torture_current_version);
+		gps = cur_ops->get_gp_seq();
+		while (time_before(jiffies, stopat) && !torture_must_stop()) {
+			rfcp = READ_ONCE(rcu_fwd_cb_head);
+			rfcpn = NULL;
+			if (rfcp)
+				rfcpn = READ_ONCE(rfcp->rfc_next);
+			if (rfcpn) {
+				if (rfcp->rfc_gps >= MIN_FWD_CB_LAUNDERS &&
+				    ++n_max_gps >= MIN_FWD_CBS_LAUNDERED)
+					break;
+				rcu_fwd_cb_head = rfcpn;
+				n_launders++;
+				n_launders_sa++;
+			} else {
+				rfcp = kmalloc(sizeof(*rfcp), GFP_KERNEL);
+				if (WARN_ON_ONCE(!rfcp)) {
+					schedule_timeout_interruptible(1);
+					continue;
+				}
+				n_max_cbs++;
+				n_launders_sa = 0;
+				rfcp->rfc_gps = 0;
+			}
+			cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
+			cond_resched();
+		}
+		stoppedat = jiffies;
+		n_launders_cb_snap = READ_ONCE(n_launders_cb);
+		cver = READ_ONCE(rcu_torture_current_version) - cver;
+		gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
+		cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
+		for (;;) {
+			rfcp = rcu_fwd_cb_head;
+			if (!rfcp)
+				break;
+			rcu_fwd_cb_head = rfcp->rfc_next;
+			kfree(rfcp);
+		}
+		rcu_fwd_cb_tail = &rcu_fwd_cb_head;
+		WRITE_ONCE(rcu_fwd_cb_nodelay, false);
+		if (!torture_must_stop()) {
+			WARN_ON(n_max_gps < MIN_FWD_CBS_LAUNDERED);
+			pr_alert("%s Duration %lu barrier: %lu pending %ld n_launders: %ld n_launders_sa: %ld n_max_gps: %ld n_max_cbs: %ld cver %ld gps %ld\n",
+				 __func__,
+				 stoppedat - rcu_fwd_startat,
+				 jiffies - stoppedat,
+				 n_launders + n_max_cbs - n_launders_cb_snap,
+				 n_launders, n_launders_sa,
+				 n_max_gps, n_max_cbs, cver, gps);
+			for (i = ARRAY_SIZE(n_launders_hist) - 1; i > 0; i--)
+				if (n_launders_hist[i] > 0)
+					break;
+			pr_alert("Callback-invocation histogram:");
+			for (j = 0; j <= i; j++)
+				pr_cont(" %ds: %ld", j + 1, n_launders_hist[j]);
+			pr_cont("\n");
+		}
+
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
 	} while (!torture_must_stop());
-- 
2.17.1

