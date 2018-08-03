Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B9C4646A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C08217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="clEpDsNz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="clEpDsNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C08217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbeHCWyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:54:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbeHCWyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:54:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1CF9606DD; Fri,  3 Aug 2018 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533329781;
        bh=+/nJSFIWfQkJZwUEBl0cuL3v0U2Yno0jKG8eqyfduzA=;
        h=From:To:Cc:Subject:Date:From;
        b=clEpDsNzaQo0wGxTk7ZH6XxiG05DD20UK/gE5UwL6x2EC720EjcepsRlxPMWrzofS
         hZAQvXjlSCLfPeuzhDdxQcHYl0oeE/5duHEUqYVOG4o4B7B4ENujtm8YHnSMzHMorh
         0vnRnfNry/voQlxrZ2VUb5XSvf9/gdUWKsJiSD0w=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B549360264;
        Fri,  3 Aug 2018 20:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533329781;
        bh=+/nJSFIWfQkJZwUEBl0cuL3v0U2Yno0jKG8eqyfduzA=;
        h=From:To:Cc:Subject:Date:From;
        b=clEpDsNzaQo0wGxTk7ZH6XxiG05DD20UK/gE5UwL6x2EC720EjcepsRlxPMWrzofS
         hZAQvXjlSCLfPeuzhDdxQcHYl0oeE/5duHEUqYVOG4o4B7B4ENujtm8YHnSMzHMorh
         0vnRnfNry/voQlxrZ2VUb5XSvf9/gdUWKsJiSD0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B549360264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        stable@vger.kernel.org
Subject: [PATCH] stop_machine: Atomically queue and wake stopper threads
Date:   Fri,  3 Aug 2018 13:56:06 -0700
Message-Id: <1533329766-4856-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasad Sodagudi <psodagud@codeaurora.org>

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

Disable preemption in cpu_stop_queue_work() before
queueing works for stopper threads, and queueing the stopper
thread in the wake queue, to ensure that the operation
of queueing the works and waking the stopper threads is atomic.

Fixes: 0b26351b910f ("stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock")
Co-Developed-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Cc: stable@vger.kernel.org
---
 kernel/stop_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 34b6652..067cb83 100644
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

