Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B40AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AA720840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AA720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbeHAUSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:18:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404002AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 58FBA11C2;
        Wed,  1 Aug 2018 17:07:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 246/336] stop_machine: Use raw spinlocks
Date:   Wed,  1 Aug 2018 18:49:41 +0200
Message-Id: <20180801165038.475735787@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit de5b55c1d4e30740009864eb35ce4ed856aac01d ]

Use raw-locks in stop_machine() to allow locking in irq-off and
preempt-disabled regions on -RT. This also documents the possible locking
context in general.

[bigeasy: update patch description.]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20180423191635.6014-1-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/stop_machine.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -37,7 +37,7 @@ struct cpu_stop_done {
 struct cpu_stopper {
 	struct task_struct	*thread;
 
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	bool			enabled;	/* is this stopper enabled? */
 	struct list_head	works;		/* list of pending works */
 
@@ -81,13 +81,13 @@ static bool cpu_stop_queue_work(unsigned
 	unsigned long flags;
 	bool enabled;
 
-	spin_lock_irqsave(&stopper->lock, flags);
+	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work, &wakeq);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
-	spin_unlock_irqrestore(&stopper->lock, flags);
+	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
 
@@ -237,8 +237,8 @@ static int cpu_stop_queue_two_works(int
 	DEFINE_WAKE_Q(wakeq);
 	int err;
 retry:
-	spin_lock_irq(&stopper1->lock);
-	spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock_irq(&stopper1->lock);
+	raw_spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
 
 	err = -ENOENT;
 	if (!stopper1->enabled || !stopper2->enabled)
@@ -261,8 +261,8 @@ retry:
 	__cpu_stop_queue_work(stopper1, work1, &wakeq);
 	__cpu_stop_queue_work(stopper2, work2, &wakeq);
 unlock:
-	spin_unlock(&stopper2->lock);
-	spin_unlock_irq(&stopper1->lock);
+	raw_spin_unlock(&stopper2->lock);
+	raw_spin_unlock_irq(&stopper1->lock);
 
 	if (unlikely(err == -EDEADLK)) {
 		while (stop_cpus_in_progress)
@@ -461,9 +461,9 @@ static int cpu_stop_should_run(unsigned
 	unsigned long flags;
 	int run;
 
-	spin_lock_irqsave(&stopper->lock, flags);
+	raw_spin_lock_irqsave(&stopper->lock, flags);
 	run = !list_empty(&stopper->works);
-	spin_unlock_irqrestore(&stopper->lock, flags);
+	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 	return run;
 }
 
@@ -474,13 +474,13 @@ static void cpu_stopper_thread(unsigned
 
 repeat:
 	work = NULL;
-	spin_lock_irq(&stopper->lock);
+	raw_spin_lock_irq(&stopper->lock);
 	if (!list_empty(&stopper->works)) {
 		work = list_first_entry(&stopper->works,
 					struct cpu_stop_work, list);
 		list_del_init(&work->list);
 	}
-	spin_unlock_irq(&stopper->lock);
+	raw_spin_unlock_irq(&stopper->lock);
 
 	if (work) {
 		cpu_stop_fn_t fn = work->fn;
@@ -554,7 +554,7 @@ static int __init cpu_stop_init(void)
 	for_each_possible_cpu(cpu) {
 		struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
 
-		spin_lock_init(&stopper->lock);
+		raw_spin_lock_init(&stopper->lock);
 		INIT_LIST_HEAD(&stopper->works);
 	}
 


