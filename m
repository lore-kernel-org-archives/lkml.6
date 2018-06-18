Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F93C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B77B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B77B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967885AbeFRIf1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:35:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36022 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967323AbeFRIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:35:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AC74FCB0;
        Mon, 18 Jun 2018 08:35:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 106/189] kthread, sched/wait: Fix kthread_parkme() wait-loop
Date:   Mon, 18 Jun 2018 10:13:22 +0200
Message-Id: <20180618081213.535323359@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 741a76b350897604c48fb12beff1c9b77724dc96 ]

Gaurav reported a problem with __kthread_parkme() where a concurrent
try_to_wake_up() could result in competing stores to ->state which,
when the TASK_PARKED store got lost bad things would happen.

The comment near set_current_state() actually mentions this competing
store, but only mentions the case against TASK_RUNNING. This same
store, with different timing, can happen against a subsequent !RUNNING
store.

This normally is not a problem, because as per that same comment, the
!RUNNING state store is inside a condition based wait-loop:

  for (;;) {
    set_current_state(TASK_UNINTERRUPTIBLE);
    if (!need_sleep)
      break;
    schedule();
  }
  __set_current_state(TASK_RUNNING);

If we loose the (first) TASK_UNINTERRUPTIBLE store to a previous
(concurrent) wakeup, the schedule() will NO-OP and we'll go around the
loop once more.

The problem here is that the TASK_PARKED store is not inside the
KTHREAD_SHOULD_PARK condition wait-loop.

There is a genuine issue with sleeps that do not have a condition;
this is addressed in a subsequent patch.

Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kthread.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -169,12 +169,13 @@ void *kthread_probe_data(struct task_str
 
 static void __kthread_parkme(struct kthread *self)
 {
-	__set_current_state(TASK_PARKED);
-	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
+	for (;;) {
+		set_current_state(TASK_PARKED);
+		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
+			break;
 		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
 			complete(&self->parked);
 		schedule();
-		__set_current_state(TASK_PARKED);
 	}
 	clear_bit(KTHREAD_IS_PARKED, &self->flags);
 	__set_current_state(TASK_RUNNING);


