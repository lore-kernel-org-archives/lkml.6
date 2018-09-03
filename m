Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7965DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110A2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeICVp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeICVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:28 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 069CAD24;
        Mon,  3 Sep 2018 17:24:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prasad Sodagudi <psodagud@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        matt@codeblueprint.co.uk, bigeasy@linutronix.de
Subject: [PATCH 4.14 104/165] stop_machine: Atomically queue and wake stopper threads
Date:   Mon,  3 Sep 2018 18:56:30 +0200
Message-Id: <20180903165700.729141940@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prasad Sodagudi <psodagud@codeaurora.org>

commit cfd355145c32bb7ccb65fccbe2d67280dc2119e1 upstream.

When cpu_stop_queue_work() releases the lock for the stopper
thread that was queued into its wake queue, preemption is
enabled, which leads to the following deadlock:

CPU0                              CPU1
sched_setaffinity(0, ...)
__set_cpus_allowed_ptr()
stop_one_cpu(0, ...)              stop_two_cpus(0, 1, ...)
cpu_stop_queue_work(0, ...)       cpu_stop_queue_two_works(0, ..., 1, ...)

-grabs lock for migration/0-
                                  -spins with preemption disabled,
                                   waiting for migration/0's lock to be
                                   released-

-adds work items for migration/0
and queues migration/0 to its
wake_q-

-releases lock for migration/0
 and preemption is enabled-

-current thread is preempted,
and __set_cpus_allowed_ptr
has changed the thread's
cpu allowed mask to CPU1 only-

                                  -acquires migration/0 and migration/1's
                                   locks-

                                  -adds work for migration/0 but does not
                                   add migration/0 to wake_q, since it is
                                   already in a wake_q-

                                  -adds work for migration/1 and adds
                                   migration/1 to its wake_q-

                                  -releases migration/0 and migration/1's
                                   locks, wakes migration/1, and enables
                                   preemption-

                                  -since migration/1 is requested to run,
                                   migration/1 begins to run and waits on
                                   migration/0, but migration/0 will never
                                   be able to run, since the thread that
                                   can wake it is affine to CPU1-

Disable preemption in cpu_stop_queue_work() before queueing works for
stopper threads, and queueing the stopper thread in the wake queue, to
ensure that the operation of queueing the works and waking the stopper
threads is atomic.

Fixes: 0b26351b910f ("stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock")
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: matt@codeblueprint.co.uk
Cc: bigeasy@linutronix.de
Cc: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1533329766-4856-1-git-send-email-isaacm@codeaurora.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Co-Developed-by: Isaac J. Manjarres <isaacm@codeaurora.org>

---
 kernel/stop_machine.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -81,6 +81,7 @@ static bool cpu_stop_queue_work(unsigned
 	unsigned long flags;
 	bool enabled;
 
+	preempt_disable();
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
@@ -90,6 +91,7 @@ static bool cpu_stop_queue_work(unsigned
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
+	preempt_enable();
 
 	return enabled;
 }


