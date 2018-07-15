Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263CECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FE3208DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FE3208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeGOKic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:38:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeGOKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:38:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FAFt8j738816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 03:15:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FAFoFP738776;
        Sun, 15 Jul 2018 03:15:50 -0700
Date:   Sun, 15 Jul 2018 03:15:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Isaac J. Manjarres" <tipbot@zytor.com>
Message-ID: <tip-9fb8d5dc4b649dd190e1af4ead670753e71bf907@git.kernel.org>
Cc:     mingo@kernel.org, pkondeti@codeaurora.org, psodagud@codeaurora.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        isaacm@codeaurora.org
Reply-To: isaacm@codeaurora.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, psodagud@codeaurora.org,
          pkondeti@codeaurora.org
In-Reply-To: <1530655334-4601-1-git-send-email-isaacm@codeaurora.org>
References: <1530655334-4601-1-git-send-email-isaacm@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] stop_machine: Disable preemption when waking two
 stopper threads
Git-Commit-ID: 9fb8d5dc4b649dd190e1af4ead670753e71bf907
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

Commit-ID:  9fb8d5dc4b649dd190e1af4ead670753e71bf907
Gitweb:     https://git.kernel.org/tip/9fb8d5dc4b649dd190e1af4ead670753e71bf907
Author:     Isaac J. Manjarres <isaacm@codeaurora.org>
AuthorDate: Tue, 3 Jul 2018 15:02:14 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 15 Jul 2018 12:12:45 +0200

stop_machine: Disable preemption when waking two stopper threads

When cpu_stop_queue_two_works() begins to wake the stopper threads, it does
so without preemption disabled, which leads to the following race
condition:

The source CPU calls cpu_stop_queue_two_works(), with cpu1 as the source
CPU, and cpu2 as the destination CPU. When adding the stopper threads to
the wake queue used in this function, the source CPU stopper thread is
added first, and the destination CPU stopper thread is added last.

When wake_up_q() is invoked to wake the stopper threads, the threads are
woken up in the order that they are queued in, so the source CPU's stopper
thread is woken up first, and it preempts the thread running on the source
CPU.

The stopper thread will then execute on the source CPU, disable preemption,
and begin executing multi_cpu_stop(), and wait for an ack from the
destination CPU's stopper thread, with preemption still disabled. Since the
worker thread that woke up the stopper thread on the source CPU is affine
to the source CPU, and preemption is disabled on the source CPU, that
thread will never run to dequeue the destination CPU's stopper thread from
the wake queue, and thus, the destination CPU's stopper thread will never
run, causing the source CPU's stopper thread to wait forever, and stall.

Disable preemption when waking the stopper threads in
cpu_stop_queue_two_works().

Fixes: 0b26351b910f ("stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock")
Co-Developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Co-Developed-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: matt@codeblueprint.co.uk
Cc: bigeasy@linutronix.de
Cc: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1530655334-4601-1-git-send-email-isaacm@codeaurora.org

---
 kernel/stop_machine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a2c238..1ff523dae6e2 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -270,7 +270,11 @@ unlock:
 		goto retry;
 	}
 
-	wake_up_q(&wakeq);
+	if (!err) {
+		preempt_disable();
+		wake_up_q(&wakeq);
+		preempt_enable();
+	}
 
 	return err;
 }
