Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C438CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6950C26386
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6950C26386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965052AbeFZAur (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:50:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934858AbeFZAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n3l7085442
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:32 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96uc3ab-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:32 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:30 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oO1O9765390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51203B205F;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B63B2064;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5BC5216CA09A; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/13] rcutorture: Handle extended read-side critical sections
Date:   Mon, 25 Jun 2018 17:52:21 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-00000445293C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B3F01
Message-Id: <20180626005227.30660-7-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables rcutorture to test whether RCU properly aggregates
different types of read-side critical sections into a larger section
covering the set.  It does this by extending an initial read-side
critical section randomly for a random number of extensions.  There is
a new rcu_torture_ops field ->extendable that specifies what extensions
are permitted for a given flavor of RCU (for example, SRCU does not
permit any extensions, while RCU-sched permits all types).  Note that
if a given operation (for example, local_bh_disable()) extends an RCU
read-side critical section, then rcutorture feels free to also start
and end the critical section with that operation's type of disabling.

Disabling operations include local_bh_disable(), local_irq_disable(),
and preempt_disable().  This commit also adds a new "busted_srcud"
torture type, which verifies rcutorture's ability to detect extensions
of RCU read-side critical sections that are not handled.  Gotta test
the test, after all!

Note that it is not legal to invoke local_bh_disable() with interrupts
disabled, and this transition is avoided by overriding the random-number
generator when it wants to call local_bh_disable() while interrupts
are disabled.  The code instead leaves both interrupts and bh/softirq
disabled in this case.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 158 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 152 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ac700aa6dcaf..f97757755207 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -62,6 +62,18 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
 
+/* Bits for ->extendables field, extendables param, and related definitions. */
+#define RCUTORTURE_RDR_SHIFT	 8	/* Put SRCU index in upper bits. */
+#define RCUTORTURE_RDR_MASK	 ((1 << RCUTORTURE_RDR_SHIFT) - 1)
+#define RCUTORTURE_RDR_BH	 0x1	/* Extend readers by disabling bh. */
+#define RCUTORTURE_RDR_IRQ	 0x2	/*  ... disabling interrupts. */
+#define RCUTORTURE_RDR_PREEMPT	 0x4	/*  ... disabling preemption. */
+#define RCUTORTURE_RDR_RCU	 0x8	/*  ... entering another RCU reader. */
+#define RCUTORTURE_MAX_EXTEND	 (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | \
+				  RCUTORTURE_RDR_PREEMPT)
+#define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
+					/* Must be power of two minus one. */
+
 torture_param(int, cbflood_inter_holdoff, HZ,
 	      "Holdoff between floods (jiffies)");
 torture_param(int, cbflood_intra_holdoff, 1,
@@ -69,6 +81,8 @@ torture_param(int, cbflood_intra_holdoff, 1,
 torture_param(int, cbflood_n_burst, 3, "# bursts in flood, zero to disable");
 torture_param(int, cbflood_n_per_burst, 20000,
 	      "# callbacks per burst in flood");
+torture_param(int, extendables, RCUTORTURE_MAX_EXTEND,
+	      "Extend readers by disabling bh (1), irqs (2), or preempt (4)");
 torture_param(int, fqs_duration, 0,
 	      "Duration of fqs bursts (us), 0 to disable");
 torture_param(int, fqs_holdoff, 0, "Holdoff time within fqs bursts (us)");
@@ -277,6 +291,8 @@ struct rcu_torture_ops {
 	void (*stats)(void);
 	int irq_capable;
 	int can_boost;
+	int extendables;
+	int ext_irq_conflict;
 	const char *name;
 };
 
@@ -452,6 +468,8 @@ static struct rcu_torture_ops rcu_bh_ops = {
 	.fqs		= rcu_bh_force_quiescent_state,
 	.stats		= NULL,
 	.irq_capable	= 1,
+	.extendables	= (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ),
+	.ext_irq_conflict = RCUTORTURE_RDR_RCU,
 	.name		= "rcu_bh"
 };
 
@@ -622,6 +640,26 @@ static struct rcu_torture_ops srcud_ops = {
 	.name		= "srcud"
 };
 
+/* As above, but broken due to inappropriate reader extension. */
+static struct rcu_torture_ops busted_srcud_ops = {
+	.ttype		= SRCU_FLAVOR,
+	.init		= srcu_torture_init,
+	.cleanup	= srcu_torture_cleanup,
+	.readlock	= srcu_torture_read_lock,
+	.read_delay	= rcu_read_delay,
+	.readunlock	= srcu_torture_read_unlock,
+	.get_gp_seq	= srcu_torture_completed,
+	.deferred_free	= srcu_torture_deferred_free,
+	.sync		= srcu_torture_synchronize,
+	.exp_sync	= srcu_torture_synchronize_expedited,
+	.call		= srcu_torture_call,
+	.cb_barrier	= srcu_torture_barrier,
+	.stats		= srcu_torture_stats,
+	.irq_capable	= 1,
+	.extendables	= RCUTORTURE_MAX_EXTEND,
+	.name		= "busted_srcud"
+};
+
 /*
  * Definitions for sched torture testing.
  */
@@ -660,6 +698,7 @@ static struct rcu_torture_ops sched_ops = {
 	.fqs		= rcu_sched_force_quiescent_state,
 	.stats		= NULL,
 	.irq_capable	= 1,
+	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "sched"
 };
 
@@ -1089,6 +1128,110 @@ static void rcu_torture_timer_cb(struct rcu_head *rhp)
 	kfree(rhp);
 }
 
+/*
+ * Do one extension of an RCU read-side critical section using the
+ * current reader state in readstate (set to zero for initial entry
+ * to extended critical section), set the new state as specified by
+ * newstate (set to zero for final exit from extended critical section),
+ * and random-number-generator state in trsp.  If this is neither the
+ * beginning or end of the critical section and if there was actually a
+ * change, do a ->read_delay().
+ */
+static void rcutorture_one_extend(int *readstate, int newstate,
+				  struct torture_random_state *trsp)
+{
+	int idxnew = -1;
+	int idxold = *readstate;
+	int statesnew = ~*readstate & newstate;
+	int statesold = *readstate & ~newstate;
+
+	WARN_ON_ONCE(idxold < 0);
+	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
+
+	/* First, put new protection in place to avoid critical-section gap. */
+	if (statesnew & RCUTORTURE_RDR_BH)
+		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_IRQ)
+		local_irq_disable();
+	if (statesnew & RCUTORTURE_RDR_PREEMPT)
+		preempt_disable();
+	if (statesnew & RCUTORTURE_RDR_RCU)
+		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
+
+	/* Next, remove old protection, irq first due to bh conflict. */
+	if (statesold & RCUTORTURE_RDR_IRQ)
+		local_irq_enable();
+	if (statesold & RCUTORTURE_RDR_BH)
+		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_PREEMPT)
+		preempt_enable();
+	if (statesold & RCUTORTURE_RDR_RCU)
+		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
+
+	/* Delay if neither beginning nor end and there was a change. */
+	if ((statesnew || statesold) && *readstate && newstate)
+		cur_ops->read_delay(trsp);
+
+	/* Update the reader state. */
+	if (idxnew == -1)
+		idxnew = idxold & ~RCUTORTURE_RDR_MASK;
+	WARN_ON_ONCE(idxnew < 0);
+	WARN_ON_ONCE((idxnew >> RCUTORTURE_RDR_SHIFT) > 1);
+	*readstate = idxnew | newstate;
+	WARN_ON_ONCE((*readstate >> RCUTORTURE_RDR_SHIFT) < 0);
+	WARN_ON_ONCE((*readstate >> RCUTORTURE_RDR_SHIFT) > 1);
+}
+
+/* Return the biggest extendables mask given current RCU and boot parameters. */
+static int rcutorture_extend_mask_max(void)
+{
+	int mask;
+
+	WARN_ON_ONCE(extendables & ~RCUTORTURE_MAX_EXTEND);
+	mask = extendables & RCUTORTURE_MAX_EXTEND & cur_ops->extendables;
+	mask = mask | RCUTORTURE_RDR_RCU;
+	return mask;
+}
+
+/* Return a random protection state mask, but with at least one bit set. */
+static int
+rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
+{
+	int mask = rcutorture_extend_mask_max();
+
+	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
+	mask = mask & (torture_random(trsp) >> RCUTORTURE_RDR_SHIFT);
+	if ((mask & RCUTORTURE_RDR_IRQ) &&
+	    !(mask & RCUTORTURE_RDR_BH) &&
+	    (oldmask & RCUTORTURE_RDR_BH))
+		mask |= RCUTORTURE_RDR_BH; /* Can't enable bh w/irq disabled. */
+	if ((mask & RCUTORTURE_RDR_IRQ) &&
+	    !(mask & cur_ops->ext_irq_conflict) &&
+	    (oldmask & cur_ops->ext_irq_conflict))
+		mask |= cur_ops->ext_irq_conflict; /* Or if readers object. */
+	return mask ?: RCUTORTURE_RDR_RCU;
+}
+
+/*
+ * Do a randomly selected number of extensions of an existing RCU read-side
+ * critical section.
+ */
+static void rcutorture_loop_extend(int *readstate,
+				   struct torture_random_state *trsp)
+{
+	int i;
+	int mask = rcutorture_extend_mask_max();
+
+	WARN_ON_ONCE(!*readstate); /* -Existing- RCU read-side critsect! */
+	if (!((mask - 1) & mask))
+		return;  /* Current RCU flavor not extendable. */
+	i = (torture_random(trsp) >> 3) & RCUTORTURE_RDR_MAX_LOOPS;
+	while (i--) {
+		mask = rcutorture_extend_mask(*readstate, trsp);
+		rcutorture_one_extend(readstate, mask, trsp);
+	}
+}
+
 /*
  * Do one read-side critical section, returning false if there was
  * no data to read.  Can be invoked both from process context and
@@ -1096,14 +1239,16 @@ static void rcu_torture_timer_cb(struct rcu_head *rhp)
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp)
 {
-	int idx;
 	unsigned long started;
 	unsigned long completed;
+	int newstate;
 	struct rcu_torture *p;
 	int pipe_count;
+	int readstate = 0;
 	unsigned long long ts;
 
-	idx = cur_ops->readlock();
+	newstate = rcutorture_extend_mask(readstate, trsp);
+	rcutorture_one_extend(&readstate, newstate, trsp);
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
@@ -1113,12 +1258,12 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 				  torturing_tasks());
 	if (p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
-		cur_ops->readunlock(idx);
+		rcutorture_one_extend(&readstate, 0, trsp);
 		return false;
 	}
 	if (p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
-	cur_ops->read_delay(trsp);
+	rcutorture_loop_extend(&readstate, trsp);
 	preempt_disable();
 	pipe_count = p->rtort_pipe_count;
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
@@ -1139,7 +1284,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
-	cur_ops->readunlock(idx);
+	rcutorture_one_extend(&readstate, 0, trsp);
+	WARN_ON_ONCE(readstate & RCUTORTURE_RDR_MASK);
 	return true;
 }
 
@@ -1704,7 +1850,7 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_bh_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&sched_ops, &tasks_ops,
+		&busted_srcud_ops, &sched_ops, &tasks_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
-- 
2.17.1

