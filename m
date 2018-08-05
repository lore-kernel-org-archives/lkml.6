Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F333C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C45218FE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C45218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeHEWGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:06:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeHEWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:06:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w75K0vkG581001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Aug 2018 13:00:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w75K0vhP580998;
        Sun, 5 Aug 2018 13:00:57 -0700
Date:   Sun, 5 Aug 2018 13:00:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Prasad Sodagudi <tipbot@zytor.com>
Message-ID: <tip-cfd355145c32bb7ccb65fccbe2d67280dc2119e1@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, psodagud@codeaurora.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, isaacm@codeaurora.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          psodagud@codeaurora.org, linux-kernel@vger.kernel.org,
          isaacm@codeaurora.org
In-Reply-To: <1533329766-4856-1-git-send-email-isaacm@codeaurora.org>
References: <1533329766-4856-1-git-send-email-isaacm@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] stop_machine: Atomically queue and wake stopper
 threads
Git-Commit-ID: cfd355145c32bb7ccb65fccbe2d67280dc2119e1
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

Commit-ID:  cfd355145c32bb7ccb65fccbe2d67280dc2119e1
Gitweb:     https://git.kernel.org/tip/cfd355145c32bb7ccb65fccbe2d67280dc2119e1
Author:     Prasad Sodagudi <psodagud@codeaurora.org>
AuthorDate: Fri, 3 Aug 2018 13:56:06 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 5 Aug 2018 21:58:31 +0200

stop_machine: Atomically queue and wake stopper threads

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

Co-Developed-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 kernel/stop_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index e190d1ef3a23..69eb76daed34 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -81,6 +81,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	unsigned long flags;
 	bool enabled;
 
+	preempt_disable();
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
@@ -90,6 +91,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	wake_up_q(&wakeq);
+	preempt_enable();
 
 	return enabled;
 }
