Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C5620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C5620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932154AbeFTJko (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:40:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755017AbeFTJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:40:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K9eKUE3448430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 02:40:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K9eKpE3448427;
        Wed, 20 Jun 2018 02:40:20 -0700
Date:   Wed, 20 Jun 2018 02:40:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-0abf17bc7790dd0467ed0e38522242f23c5da1c4@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org
In-Reply-To: <20180612083909.209762413@infradead.org>
References: <20180612083909.209762413@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/swait: Switch to full exclusive mode
Git-Commit-ID: 0abf17bc7790dd0467ed0e38522242f23c5da1c4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0abf17bc7790dd0467ed0e38522242f23c5da1c4
Gitweb:     https://git.kernel.org/tip/0abf17bc7790dd0467ed0e38522242f23c5da1c4
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 12 Jun 2018 10:34:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 11:35:56 +0200

sched/swait: Switch to full exclusive mode

Linus noted that swait basically implements exclusive mode -- because
swake_up() only wakes a single waiter. And because of that it should
take care to properly deal with the interruptible case.

In short, the problem is that swake_up() can race with a signal. In
this this case it is possible the swake_up() 'wakes' the waiter that
is already on the way out because it just got a signal and the wakeup
gets lost.

The normal wait code is very careful and avoids this situation, make
sure we do too.

Copy the exact exclusive semantics from wait.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bigeasy@linutronix.de
Cc: oleg@redhat.com
Cc: paulmck@linux.vnet.ibm.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180612083909.209762413@infradead.org

---
 include/linux/swait.h | 11 ++++++-----
 kernel/sched/swait.c  | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index d6a5e949e4ca..dd032061112d 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -38,8 +38,8 @@
  *    all wakeups are TASK_NORMAL in order to avoid O(n) lookups for the right
  *    sleeper state.
  *
- *  - the exclusive mode; because this requires preserving the list order
- *    and this is hard.
+ *  - the !exclusive mode; because that leads to O(n) wakeups, everything is
+ *    exclusive.
  *
  *  - custom wake callback functions; because you cannot give any guarantees
  *    about random code. This also allows swait to be used in RT, such that
@@ -167,9 +167,10 @@ extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queu
 extern void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
-/* as per ___wait_event() but for swait, therefore "exclusive == 0" */
+/* as per ___wait_event() but for swait, therefore "exclusive == 1" */
 #define ___swait_event(wq, condition, state, ret, cmd)			\
 ({									\
+	__label__ __out;						\
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
@@ -182,13 +183,13 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 									\
 		if (___wait_is_interruptible(state) && __int) {		\
 			__ret = __int;					\
-			break;						\
+			goto __out;					\
 		}							\
 									\
 		cmd;							\
 	}								\
 	finish_swait(&wq, &__wait);					\
-	__ret;								\
+__out:	__ret;								\
 })
 
 #define __swait_event(wq, condition)					\
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e68bb1398b05..66890de93ee5 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -73,7 +73,7 @@ static void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *w
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))
-		list_add(&wait->task_list, &q->task_list);
+		list_add_tail(&wait->task_list, &q->task_list);
 }
 
 void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
@@ -89,12 +89,24 @@ EXPORT_SYMBOL(prepare_to_swait);
 
 long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state)
 {
-	if (signal_pending_state(state, current))
-		return -ERESTARTSYS;
+	unsigned long flags;
+	long ret = 0;
 
-	prepare_to_swait(q, wait, state);
+	raw_spin_lock_irqsave(&q->lock, flags);
+	if (unlikely(signal_pending_state(state, current))) {
+		/*
+		 * See prepare_to_wait_event(). TL;DR, subsequent swake_up()
+		 * must not see us.
+		 */
+		list_del_init(&wait->task_list);
+		ret = -ERESTARTSYS;
+	} else {
+		__prepare_to_swait(q, wait);
+		set_current_state(state);
+	}
+	raw_spin_unlock_irqrestore(&q->lock, flags);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(prepare_to_swait_event);
 
