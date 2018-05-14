Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeENDRO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:17:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36246 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeENDQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:16:03 -0400
X-Google-Smtp-Source: AB8JxZoYQnELGfa+6SXdC44mJEZjXoyxke733vlJWwzgPJM3bEojGp2whjKiVVLu5s/r1Pk1vZ5gWw==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: [PATCH RFC 4/8] rcu: Get rid of old c variable from places in tree RCU
Date: Sun, 13 May 2018 20:15:37 -0700
Message-Id: <20180514031541.67247-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180514031541.67247-1-joel@joelfernandes.org>
References: <20180514031541.67247-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'c' variable was used previously to store the grace period
that is being requested. However it is not very meaningful for
a code reader, this patch replaces it with gp_seq_start indicating that
this is the grace period that was requested. Also updating tracing with
the new name.

Just a clean up patch, no logical change.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 15 ++++++------
 kernel/rcu/tree.c          | 47 ++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index ce9d1a1cac78..539900a9f8c7 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -103,15 +103,16 @@ TRACE_EVENT(rcu_grace_period,
  */
 TRACE_EVENT(rcu_future_grace_period,
 
-	TP_PROTO(const char *rcuname, unsigned long gp_seq, unsigned long c,
-		 u8 level, int grplo, int grphi, const char *gpevent),
+	TP_PROTO(const char *rcuname, unsigned long gp_seq,
+		 unsigned long gp_seq_start, u8 level, int grplo, int grphi,
+		 const char *gpevent),
 
-	TP_ARGS(rcuname, gp_seq, c, level, grplo, grphi, gpevent),
+	TP_ARGS(rcuname, gp_seq, gp_seq_start, level, grplo, grphi, gpevent),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(unsigned long, gp_seq)
-		__field(unsigned long, c)
+		__field(unsigned long, gp_seq_start)
 		__field(u8, level)
 		__field(int, grplo)
 		__field(int, grphi)
@@ -121,7 +122,7 @@ TRACE_EVENT(rcu_future_grace_period,
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
 		__entry->gp_seq = gp_seq;
-		__entry->c = c;
+		__entry->gp_seq_start = gp_seq_start;
 		__entry->level = level;
 		__entry->grplo = grplo;
 		__entry->grphi = grphi;
@@ -129,7 +130,7 @@ TRACE_EVENT(rcu_future_grace_period,
 	),
 
 	TP_printk("%s %lu %lu %u %d %d %s",
-		  __entry->rcuname, __entry->gp_seq, __entry->c, __entry->level,
+		  __entry->rcuname, __entry->gp_seq, __entry->gp_seq_start, __entry->level,
 		  __entry->grplo, __entry->grphi, __entry->gpevent)
 );
 
@@ -751,7 +752,7 @@ TRACE_EVENT(rcu_barrier,
 #else /* #ifdef CONFIG_RCU_TRACE */
 
 #define trace_rcu_grace_period(rcuname, gp_seq, gpevent) do { } while (0)
-#define trace_rcu_future_grace_period(rcuname, gp_seq, c, \
+#define trace_rcu_future_grace_period(rcuname, gp_seq, gp_seq_start, \
 				      level, grplo, grphi, event) \
 				      do { } while (0)
 #define trace_rcu_grace_period_init(rcuname, gp_seq, level, grplo, grphi, \
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 29ccc60bdbfc..9f5679ba413b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1541,13 +1541,18 @@ void rcu_cpu_stall_reset(void)
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long c, const char *s)
+			      unsigned long gp_seq_start, const char *s)
 {
-	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, c,
+	trace_rcu_future_grace_period(rdp->rsp->name, rnp->gp_seq, gp_seq_start,
 				      rnp->level, rnp->grplo, rnp->grphi, s);
 }
 
 /*
+ * rcu_start_this_gp - Request the start of a particular grace period
+ * @rnp: The leaf node of the CPU from which to start.
+ * @rdp: The rcu_data corresponding to the CPU from which to start.
+ * @gp_seq_start: The gp_seq of the grace period to start.
+ *
  * Start the specified grace period, as needed to handle newly arrived
  * callbacks.  The required future grace periods are recorded in each
  * rcu_node structure's ->gp_seq_needed field.  Returns true if there
@@ -1555,9 +1560,11 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  *
  * The caller must hold the specified rcu_node structure's ->lock, which
  * is why the caller is responsible for waking the grace-period kthread.
+ *
+ * Returns true if the GP thread needs to be awakened else false.
  */
 static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long c)
+			      unsigned long gp_seq_start)
 {
 	bool ret = false;
 	struct rcu_state *rsp = rdp->rsp;
@@ -1573,18 +1580,19 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp);
-	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
+	trace_rcu_this_gp(rnp, rdp, gp_seq_start, TPS("Startleaf"));
 	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
 		if (rnp_root != rnp)
 			raw_spin_lock_rcu_node(rnp_root);
-		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c) ||
-		    rcu_seq_done(&rnp_root->gp_seq, c) ||
+		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_start) ||
+		    rcu_seq_done(&rnp_root->gp_seq, gp_seq_start) ||
 		    (rnp != rnp_root &&
 		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
-			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
+			trace_rcu_this_gp(rnp_root, rdp, gp_seq_start,
+					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp_root->gp_seq_needed = c;
+		rnp_root->gp_seq_needed = gp_seq_start;
 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
 			goto unlock_out;
 		if (rnp_root != rnp && rnp_root->parent != NULL)
@@ -1595,14 +1603,14 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress(rsp)) {
-		trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp_root, rdp, gp_seq_start, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp_root, rdp, gp_seq_start, TPS("Startedroot"));
 	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
 	rsp->gp_req_activity = jiffies;
 	if (!rsp->gp_kthread) {
-		trace_rcu_this_gp(rnp_root, rdp, c, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp_root, rdp, gp_seq_start, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
@@ -1611,9 +1619,9 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	if (rnp != rnp_root)
 		raw_spin_unlock_rcu_node(rnp_root);
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
-	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c)) {
-		rnp->gp_seq_needed = c;
-		rdp->gp_seq_needed = c;
+	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_start)) {
+		rnp->gp_seq_needed = gp_seq_start;
+		rdp->gp_seq_needed = gp_seq_start;
 	}
 	return ret;
 }
@@ -1624,14 +1632,13 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
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
@@ -1667,7 +1674,7 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 			       struct rcu_data *rdp)
 {
-	unsigned long c;
+	unsigned long gp_seq_start;
 	bool ret = false;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -1686,9 +1693,9 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	c = rcu_seq_snap(&rsp->gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, c))
-		ret = rcu_start_this_gp(rnp, rdp, c);
+	gp_seq_start = rcu_seq_snap(&rsp->gp_seq);
+	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_start))
+		ret = rcu_start_this_gp(rnp, rdp, gp_seq_start);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-- 
2.17.0.441.gb46fe60e1d-goog
