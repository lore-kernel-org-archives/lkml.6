Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEUEdi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:33:38 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37212 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEUEdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:33:25 -0400
X-Google-Smtp-Source: AB8JxZrzNr/2WhCfChatUw1pOMNxXf8OVZbLkNytlbjcNocD+KC8HF53KM3uqbFlVqFTf9ecucYlxQ==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH v2 3/4] rcu: Cleanup the variables used to request a new grace period
Date: Sun, 20 May 2018 21:32:50 -0700
Message-Id: <20180521043251.120953-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180521043251.120953-1-joel@joelfernandes.org>
References: <20180521043251.120953-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'c' variable was used previously to store the grace period that is
being requested. However it is not very meaningful since the gp_seq
conversions. This patch replaces it with gp_seq_req indicating that
this is the grace period that was requested. Also updating tracing with
the new name.

Previous patch discussion is at:
https://patchwork.kernel.org/patch/10396579/

Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 15 ++++++------
 kernel/rcu/tree.c          | 50 ++++++++++++++++++++++----------------
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5373bc61ae08..a8d07feff6a0 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -103,15 +103,16 @@ TRACE_EVENT(rcu_grace_period,
  */
 TRACE_EVENT(rcu_future_grace_period,
 
-	TP_PROTO(const char *rcuname, unsigned long gp_seq, unsigned long c,
-		 u8 level, int grplo, int grphi, const char *gpevent),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq,
+		 unsigned long gp_seq_req, u8 level, int grplo, int grphi,
+		 const char *gpevent),
 
-	TP_ARGS(rcuname, gp_seq, c, level, grplo, grphi, gpevent),
+	TP_ARGS(rcuname, gp_seq, gp_seq_req, level, grplo, grphi, gpevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(unsigned long, gp_seq)
-		__field(unsigned long, c)
+		__field(unsigned long, gp_seq_req)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -121,7 +122,7 @@ TRACE_EVENT(rcu_future_grace_period,
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
 		__entry->gp_seq = gp_seq;
-		__entry->c = c;
+		__entry->gp_seq_req = gp_seq_req;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
@@ -129,7 +130,7 @@ TRACE_EVENT(rcu_future_grace_period,
 	),
 
 	TP_printk("%s %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->c, __entry->level,
+		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_req, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
@@ -751,7 +752,7 @@ TRACE_EVENT(rcu_barrier,
 #else /* #ifdef CONFIG_RCU_TRACE */
 
 #define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
-#define trace_rcu_future_grace_period(rcuname, gp_seq, c, \
+#define trace_rcu_future_grace_period(rcuname, gp_seq, gp_seq_req, \
 				      level, grplo, grphi, event) \
 				      do { } while (0)
 #define trace_rcu_grace_period_init(rcuname, gp_seq, level, grplo, grphi, \
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c06e1ab90cd..0ffd41ba304f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1518,13 +1518,18 @@ void rcu_cpu_stall_reset(void)
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long c, const char *s)
+			      unsigned long gp_seq_req, const char *s)
 {
-	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, c,
+	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, gp_seq_req,
 				      rnp->level, rnp->grplo, rnp->grphi, s);
 }
 
 /*
+ * rcu_start_this_gp - Request the start of a particular grace period
+ * @rnp: The leaf node of the CPU from which to start.
+ * @rdp: The rcu_data corresponding to the CPU from which to start.
+ * @gp_seq_req: The gp_seq of the grace period to start.
+ *
  * Start the specified grace period, as needed to handle newly arrived
  * callbacks.  The required future grace periods are recorded in each
  * rcu_node structure's ->gp_seq_needed field.  Returns true if there
@@ -1532,9 +1537,11 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  *
  * The caller must hold the specified rcu_node structure's ->lock, which
  * is why the caller is responsible for waking the grace-period kthread.
+ *
+ * Returns true if the GP thread needs to be awakened else false.
  */
 static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long c)
+			      unsigned long gp_seq_req)
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
@@ -1550,25 +1557,27 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp);
-	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
+	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startleaf"));
 	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
 		if (rnp_root != rnp)
 			raw_spin_lock_rcu_node(rnp_root);
-		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c) ||
-		    rcu_seq_started(&rnp_root->gp_seq, c) ||
+		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req) ||
+		    rcu_seq_started(&rnp_root->gp_seq, gp_seq_req) ||
 		    (rnp != rnp_root &&
 		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
-			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
+			trace_rcu_this_gp(rnp_root, rdp, gp_seq_req,
+					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp_root->gp_seq_needed = c;
+		rnp_root->gp_seq_needed = gp_seq_req;
 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
 			/*
 			 * We just marked the leaf, and a grace period
 			 * is in progress, which means that rcu_gp_cleanup()
 			 * will see the marking.  Bail to reduce contention.
 			 */
-			trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleaf"));
+			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
+					  TPS("Startedleaf"));
 			goto unlock_out;
 		}
 		if (rnp_root != rnp && rnp_root->parent != NULL)
@@ -1579,14 +1588,14 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress(rsp)) {
-		trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
 	rsp->gp_req_activity = jiffies;
 	if (!rsp->gp_kthread) {
-		trace_rcu_this_gp(rnp_root, rdp, c, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
@@ -1595,9 +1604,9 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	if (rnp != rnp_root)
 		raw_spin_unlock_rcu_node(rnp_root);
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c)) {
-		rnp->gp_seq_needed = c;
-		rdp->gp_seq_needed = c;
+	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req)) {
+		rnp->gp_seq_needed = gp_seq_req;
+		rdp->gp_seq_needed = gp_seq_req;
 	}
 	return ret;
 }
@@ -1608,14 +1617,13 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  */
 static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 {
-	unsigned long c = rnp->gp_seq;
 	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
 	needmore = ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed);
 	if (!needmore)
 		rnp->gp_seq_needed = rnp->gp_seq; /* Avoid counter wrap. */
-	trace_rcu_this_gp(rnp, rdp, c,
+	trace_rcu_this_gp(rnp, rdp, rnp->gp_seq,
 			  needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
 }
@@ -1651,7 +1659,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 			       struct rcu_data *rdp)
 {
-	unsigned long c;
+	unsigned long gp_seq_req;
 	bool ret = false;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -1670,9 +1678,9 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	c = rcu_seq_snap(&rsp->gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, c))
-		ret = rcu_start_this_gp(rnp, rdp, c);
+	gp_seq_req = rcu_seq_snap(&rsp->gp_seq);
+	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
+		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-- 
2.17.0.441.gb46fe60e1d-goog
