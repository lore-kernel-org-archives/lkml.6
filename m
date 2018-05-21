Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeEUXiF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:38:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751074AbeEUXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:38:03 -0400
Date: Mon, 21 May 2018 16:39:34 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/4] rcu: Cleanup the variables used to request a new
 grace period
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521044220.123933-3-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052123-0036-0000-0000-000002F850E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009063; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035745; UDB=6.00529795; IPR=6.00814873;
 MB=3.00021229; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-21 23:38:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052123-0037-0000-0000-0000446A2548
Message-Id: <20180521233934.GL3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210269
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 09:42:18PM -0700, Joel Fernandes wrote:
> The 'c' variable was used previously to store the grace period that is
> being requested. However it is not very meaningful since the gp_seq
> conversions. This patch replaces it with gp_seq_req indicating that
> this is the grace period that was requested. Also updating tracing with
> the new name.
> 
> Previous patch discussion is at:
> https://patchwork.kernel.org/patch/10396579/
> 
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>

Very good, I have queued this for review and testing.  I reworked the
commit log a bit, please see below for the version that I have queued.

							Thanx, Paul

------------------------------------------------------------------------

commit e7296d223f4ea37a7dcb089fb1bdc8c78651d276
Author: Joel Fernandes <joelaf@google.com>
Date:   Sun May 20 21:42:18 2018 -0700

    rcu: Rename the grace-period-request variables and parameters
    
    The name 'c' is used for variables and parameters holding the requested
    grace-period sequence number.  However it is no longer very meaningful
    given the conversions from ->gpnum and (especially) ->completed to
    ->gp_seq. This commit therefore renames 'c' to 'gp_seq_req'.
    
    Previous patch discussion is at:
    https://patchwork.kernel.org/patch/10396579/
    
    Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

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
index 030a12839d97..106bd8d62c67 100644
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
