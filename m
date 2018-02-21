Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBUX6L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:58:11 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:58540 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBUX6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:58:10 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [QUESTION] srcu: Remove the SCAN2 state
Date: Thu, 22 Feb 2018 08:57:27 +0900
Message-Id: <1519257447-4232-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm sorry for bothering you, and I seem to be obviously missing
something, but I'm really wondering why we check try_check_zero()
again in the state, SCAN1, for the previous srcu_idx.

I mean, since we've already checked try_check_zero() in the previous
grace period and gotten 'true' as a return value, all readers who see
the flipped idx via srcu_flip() won't update the src_{lock,unlock}_count
for the previous idx until it gets flipped back again.

Is there any reasons we check try_check_zero() again in the state, SCAN1?
Is there any problems if the following patch's applied?

Thanks in advance,
Byungchul

---
 kernel/rcu/srcutree.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 39e50fe..215c44a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1125,24 +1125,10 @@ static void srcu_advance_state(struct srcu_struct *sp)
 			mutex_unlock(&sp->srcu_gp_mutex);
 			return; /* Someone else started the grace period. */
 		}
-	}
-
-	if (rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
-		idx = 1 ^ (sp->srcu_idx & 1);
-		if (!try_check_zero(sp, idx, 1)) {
-			mutex_unlock(&sp->srcu_gp_mutex);
-			return; /* readers present, retry later. */
-		}
 		srcu_flip(sp);
-		rcu_seq_set_state(&sp->srcu_gp_seq, SRCU_STATE_SCAN2);
 	}
 
-	if (rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
-
-		/*
-		 * SRCU read-side critical sections are normally short,
-		 * so check at least twice in quick succession after a flip.
-		 */
+	if (rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
 		idx = 1 ^ (sp->srcu_idx & 1);
 		if (!try_check_zero(sp, idx, 2)) {
 			mutex_unlock(&sp->srcu_gp_mutex);
-- 
1.9.1
