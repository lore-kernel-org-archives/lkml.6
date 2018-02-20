Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226HYLI12ZQIsq8dvOmlyiqHIzrCWy/QvPSAJopn7oqVcvO+L6FZPTPf9HkEHznCO0Q3V1Zu
ARC-Seal: i=1; a=rsa-sha256; t=1519093494; cv=none;
        d=google.com; s=arc-20160816;
        b=KvMcOowfzkCQoU+9DUFFC+j25owd/yU7daib/E4SPuiXxqd8ga72oZmltb1Mcs7EkK
         Ut/s96jH/HWufZ8KKEITzV1Y1HvQ75JXqvimpFj4ev1QEaSemfg6Sd8DaDFhDfRU5FwB
         IDYEuFofONKmQM5+WePWg6hIZtUSUzXEMjagReE2jUSj6NijoslsRJXkK6tHGUH6XSag
         c9QVxWi3tSeHzebD7LpHyBvLt2yn4hpwF3bNfHpRTGf/uMpila8/Kpkc+33AevYTVNyb
         RBY+0SCfAuFBm6kTvpRkbMYYWm1SA95gLYwJTdiO8+R+1Q9DE45Ykjd2OQgUAFWh+eCK
         /rHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=y04Lk55AurMzsqdQzMFjisw5lZyPkvzvoIq+fitsrIs=;
        b=zgGNjFqelQERP2WVdCkxQtlYydMSBOjA+3Z/U4O1elI2ZT4E5lTyClqIAtLumNKBhw
         wGZjTkIk4Evk/fuY9DPXGrx0aiZEzOueGtUnVjnFKue0pjWh77kmhqYPHUv/KK/kPLM+
         fSJcrWVMJ3oO6thswebLyMxHd4U0HGtk6CIPN854HhPpRHQbnBNneu69xtuIOLVaNuQe
         Np/EwUmCqUWYACrjMvDWKmkRSxe+lrjXwjX2A+8uabsapkZQjdGcosBSnblimnjq65vg
         o9bT1CZehRsqNTS+RqNCa+urs78bY4JuLBJZhD7ChS8XMEiJNrGOJOaywOJ2m1G+TNPv
         /vTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:37 +1100
Subject: [PATCH 05/21] staging: lustre: lnet: remove cfs_block_allsigs calls.
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341769.25814.4922187814462338726.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592884980277324714?=
X-GMAIL-MSGID: =?utf-8?q?1592884980277324714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both places that cfs_block_allsigs() is used here,
the goal is to turn an interruptible wait into an
uninterruptible way.
So instead of blocking the signals, change TASK_INTERRUPTIBLE to
TASK_NOLOAD.
In each case, no other functions called while signals are blocked
will sleep - just the one that has been fixed.
In one case, an extra 'interruptible' flag needs to be passed
down so the waiting decision can be made at the right place.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/include/linux/lnet/api.h |    1 +
 drivers/staging/lustre/lnet/lnet/api-ni.c       |   15 +++------------
 drivers/staging/lustre/lnet/lnet/lib-eq.c       |   10 +++++++---
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/lnet/api.h b/drivers/staging/lustre/include/linux/lnet/api.h
index 31fcd33171b4..dae2e4f0056c 100644
--- a/drivers/staging/lustre/include/linux/lnet/api.h
+++ b/drivers/staging/lustre/include/linux/lnet/api.h
@@ -169,6 +169,7 @@ int LNetEQFree(struct lnet_handle_eq eventq_in);
 int LNetEQPoll(struct lnet_handle_eq *eventqs_in,
 	       int		 neq_in,
 	       int		 timeout_ms,
+	       int		 interruptible,
 	       struct lnet_event *event_out,
 	       int		*which_eq_out);
 /** @} lnet_eq */
diff --git a/drivers/staging/lustre/lnet/lnet/api-ni.c b/drivers/staging/lustre/lnet/lnet/api-ni.c
index 93e6274e9dac..48d25ccadbb3 100644
--- a/drivers/staging/lustre/lnet/lnet/api-ni.c
+++ b/drivers/staging/lustre/lnet/lnet/api-ni.c
@@ -961,19 +961,15 @@ static void
 lnet_ping_md_unlink(struct lnet_ping_info *pinfo,
 		    struct lnet_handle_md *md_handle)
 {
-	sigset_t blocked = cfs_block_allsigs();
-
 	LNetMDUnlink(*md_handle);
 	LNetInvalidateMDHandle(md_handle);
 
 	/* NB md could be busy; this just starts the unlink */
 	while (pinfo->pi_features != LNET_PING_FEAT_INVAL) {
 		CDEBUG(D_NET, "Still waiting for ping MD to unlink\n");
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_NOLOAD);
 		schedule_timeout(HZ);
 	}
-
-	cfs_restore_sigs(blocked);
 }
 
 static void
@@ -2141,7 +2137,6 @@ static int lnet_ping(struct lnet_process_id id, int timeout_ms,
 	int nob;
 	int rc;
 	int rc2;
-	sigset_t blocked;
 
 	infosz = offsetof(struct lnet_ping_info, pi_ni[n_ids]);
 
@@ -2197,13 +2192,9 @@ static int lnet_ping(struct lnet_process_id id, int timeout_ms,
 
 	do {
 		/* MUST block for unlink to complete */
-		if (unlinked)
-			blocked = cfs_block_allsigs();
-
-		rc2 = LNetEQPoll(&eqh, 1, timeout_ms, &event, &which);
 
-		if (unlinked)
-			cfs_restore_sigs(blocked);
+		rc2 = LNetEQPoll(&eqh, 1, timeout_ms, !unlinked,
+				 &event, &which);
 
 		CDEBUG(D_NET, "poll %d(%d %d)%s\n", rc2,
 		       (rc2 <= 0) ? -1 : event.type,
diff --git a/drivers/staging/lustre/lnet/lnet/lib-eq.c b/drivers/staging/lustre/lnet/lnet/lib-eq.c
index a173b69e2f92..ea53b5cb3f72 100644
--- a/drivers/staging/lustre/lnet/lnet/lib-eq.c
+++ b/drivers/staging/lustre/lnet/lnet/lib-eq.c
@@ -308,7 +308,7 @@ lnet_eq_dequeue_event(struct lnet_eq *eq, struct lnet_event *ev)
  */
 
 static int
-lnet_eq_wait_locked(int *timeout_ms)
+lnet_eq_wait_locked(int *timeout_ms, long state)
 __must_hold(&the_lnet.ln_eq_wait_lock)
 {
 	int tms = *timeout_ms;
@@ -320,7 +320,7 @@ __must_hold(&the_lnet.ln_eq_wait_lock)
 		return -ENXIO; /* don't want to wait and no new event */
 
 	init_waitqueue_entry(&wl, current);
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(state);
 	add_wait_queue(&the_lnet.ln_eq_waitq, &wl);
 
 	lnet_eq_wait_unlock();
@@ -359,6 +359,7 @@ __must_hold(&the_lnet.ln_eq_wait_lock)
  * \param timeout_ms Time in milliseconds to wait for an event to occur on
  * one of the EQs. The constant LNET_TIME_FOREVER can be used to indicate an
  * infinite timeout.
+ * \param interruptible, if true, use TASK_INTERRUPTIBLE, else TASK_NOLOAD
  * \param event,which On successful return (1 or -EOVERFLOW), \a event will
  * hold the next event in the EQs, and \a which will contain the index of the
  * EQ from which the event was taken.
@@ -372,6 +373,7 @@ __must_hold(&the_lnet.ln_eq_wait_lock)
  */
 int
 LNetEQPoll(struct lnet_handle_eq *eventqs, int neq, int timeout_ms,
+	   int interruptible,
 	   struct lnet_event *event, int *which)
 {
 	int wait = 1;
@@ -412,7 +414,9 @@ LNetEQPoll(struct lnet_handle_eq *eventqs, int neq, int timeout_ms,
 		 *  0 : don't want to wait anymore, but might have new event
 		 *      so need to call dequeue again
 		 */
-		wait = lnet_eq_wait_locked(&timeout_ms);
+		wait = lnet_eq_wait_locked(&timeout_ms,
+					   interruptible ? TASK_INTERRUPTIBLE
+					   : TASK_NOLOAD);
 		if (wait < 0) /* no new event */
 			break;
 	}
