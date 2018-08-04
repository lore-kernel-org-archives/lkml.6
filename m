Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FF5C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC956217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC956217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbeHDLFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:05:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:05:23 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C928BB3;
        Sat,  4 Aug 2018 09:05:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Chen <david.chen@nutanix.com>
Subject: [PATCH 4.9 17/32] sched/wait: Remove the lockless swait_active() check in swake_up*()
Date:   Sat,  4 Aug 2018 11:01:07 +0200
Message-Id: <20180804082650.826684034@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boqun Feng <boqun.feng@gmail.com>

commit 35a2897c2a306cca344ca5c0b43416707018f434 upstream.

Steven Rostedt reported a potential race in RCU core because of
swake_up():

        CPU0                            CPU1
        ----                            ----
                                __call_rcu_core() {

                                 spin_lock(rnp_root)
                                 need_wake = __rcu_start_gp() {
                                  rcu_start_gp_advanced() {
                                   gp_flags = FLAG_INIT
                                  }
                                 }

 rcu_gp_kthread() {
   swait_event_interruptible(wq,
        gp_flags & FLAG_INIT) {
   spin_lock(q->lock)

                                *fetch wq->task_list here! *

   list_add(wq->task_list, q->task_list)
   spin_unlock(q->lock);

   *fetch old value of gp_flags here *

                                 spin_unlock(rnp_root)

                                 rcu_gp_kthread_wake() {
                                  swake_up(wq) {
                                   swait_active(wq) {
                                    list_empty(wq->task_list)

                                   } * return false *

  if (condition) * false *
    schedule();

In this case, a wakeup is missed, which could cause the rcu_gp_kthread
waits for a long time.

The reason of this is that we do a lockless swait_active() check in
swake_up(). To fix this, we can either 1) add a smp_mb() in swake_up()
before swait_active() to provide the proper order or 2) simply remove
the swait_active() in swake_up().

The solution 2 not only fixes this problem but also keeps the swait and
wait API as close as possible, as wake_up() doesn't provide a full
barrier and doesn't do a lockless check of the wait queue either.
Moreover, there are users already using swait_active() to do their quick
checks for the wait queues, so it make less sense that swake_up() and
swake_up_all() do this on their own.

This patch then removes the lockless swait_active() check in swake_up()
and swake_up_all().

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170615041828.zk3a3sfyudm5p6nl@tardis
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Chen <david.chen@nutanix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/swait.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -33,9 +33,6 @@ void swake_up(struct swait_queue_head *q
 {
 	unsigned long flags;
 
-	if (!swait_active(q))
-		return;
-
 	raw_spin_lock_irqsave(&q->lock, flags);
 	swake_up_locked(q);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
@@ -51,9 +48,6 @@ void swake_up_all(struct swait_queue_hea
 	struct swait_queue *curr;
 	LIST_HEAD(tmp);
 
-	if (!swait_active(q))
-		return;
-
 	raw_spin_lock_irq(&q->lock);
 	list_splice_init(&q->task_list, &tmp);
 	while (!list_empty(&tmp)) {


