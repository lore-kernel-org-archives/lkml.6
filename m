Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DEBEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6149208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g7RjQ8DT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6149208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbeFLIlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:41:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933439AbeFLIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=32GAVEzaejEIPUgUeHYeTjxYTmEbGRVK+fIYDkvVA0k=; b=g7RjQ8DTAAOo6Zjljge8E3F1o+
        YQhzaH30QzSvosMCLQT7qDXBVVzCo2rc5E1MSUMscEOpbB2TgyCmzEl/E1F5hlJ7deo3zTqfCTIAA
        bA0TKHc5dwDun9idQ27+y5FRKZd026FEWapR3L/PmbkHai6cwg3RvPIOSkFviuUEESO8YE1Y0nd2Q
        VJ2JGSDUpSSA7L+e5yV3aaDA2RukZTpfRuxEuViOiD3dzLxqzYoLoO+oO/HAulvAY/x2mOpGm0U5v
        yC2q9D2jUCBgJWqibk5zX3+H+n7NF9AnI62QjUAdxkEyDpvnWBL4dsq7P4R88+/w0wSzelYf1wJ/5
        /dC/8G/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSepu-0001z4-U5; Tue, 12 Jun 2018 08:39:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 78C70201EA7CC; Tue, 12 Jun 2018 10:39:28 +0200 (CEST)
Message-Id: <20180612083909.209762413@infradead.org>
User-Agent: quilt/0.63-1
Date:   Tue, 12 Jun 2018 10:34:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, bigeasy@linutronix.de, oleg@redhat.com,
        paulmck@linux.vnet.ibm.com, pbonzini@redhat.com
Subject: [PATCH 2/3] sched/swait: Switch to full exclusive mode
References: <20180612083449.100099222@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-swait-1.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/swait.h |   11 ++++++-----
 kernel/sched/swait.c  |   22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 10 deletions(-)

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
@@ -167,9 +167,10 @@ extern long prepare_to_swait_event(struc
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
@@ -182,13 +183,13 @@ extern void finish_swait(struct swait_qu
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
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -73,7 +73,7 @@ static void __prepare_to_swait(struct sw
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
 


