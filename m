Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DA3206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QwLtm8Ch";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QC0MWs+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DA3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeGQRD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:03:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeGQRD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:03:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 632C0607C6; Tue, 17 Jul 2018 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531845031;
        bh=o/MmxlsRLDcZX/3ufmC5YLiCfFkKOCiNtV0e2YnFQEk=;
        h=From:To:Cc:Subject:Date:From;
        b=QwLtm8Ch1fIEwiKsC/xuc/uVzCSjJxP+8hTWrNUcjXBa71BvzzRCM6iaqwBrpeEpi
         GF77z+7evjST5WtKMgQFAPB8kijWXPT24dIe7LGiRRhKcO3XCxjAigOBIrZLczfAi1
         xBjPq2cjIQfQgSgi6ZV3yYNvpQ66Jv/Q5CCPjq80=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44E0760481;
        Tue, 17 Jul 2018 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531845030;
        bh=o/MmxlsRLDcZX/3ufmC5YLiCfFkKOCiNtV0e2YnFQEk=;
        h=From:To:Cc:Subject:Date:From;
        b=QC0MWs+4oy46Bx5xea9p1Rdrn6OwowLeXCR8VZDJGI1dspzc+l6aRfvOeFztSd7xD
         dfUmXcd0gz3Yx4iVrv+6XAe2Ep7k8kra8DizR6yh2UPn5nEvENqg4+EVUgGgG1lt63
         35tlZmSvxjbWB+t6gfOPJnvq0uVKH3Q7wkyZ2UNM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44E0760481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        gregkh@linuxfoundation.org, pkondeti@codeaurora.org,
        stable@vger.kernel.org
Subject: [PATCH v4] stop_machine: Disable preemption after queueing stopper threads
Date:   Tue, 17 Jul 2018 09:30:17 -0700
Message-Id: <1531845017-19935-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After cpu_stop_queue_two_works() queues the cpu_stop works
for the stopper threads, it releases the locks held for
both threads, which enables preemption, which allows the
following race condition to occur:

On one CPU, call it CPU 3, thread 1 invokes
cpu_stop_queue_two_works(2, 3,...), and the execution is such
that thread 1 queues the works for migration/2 and migration/3,
and is preempted after releasing the locks for migration/2 and
migration/3, but before waking the threads.

Then, On CPU 2, a kworker, call it thread 2, is running,
and it invokes cpu_stop_queue_two_works(1, 2,...), such that
thread 2 queues the works for migration/1 and migration/2.
Meanwhile, on CPU 3, thread 1 resumes execution, and wakes
migration/2 and migration/3. This means that when CPU 2
releases the locks for migration/1 and migration/2, but before
it wakes those threads, it can be preempted by migration/2.

If thread 2 is preempted by migration/2, then migration/2 will
execute the first work item successfully, since migration/3
was woken up by CPU 3, but when it goes to execute the second
work item, it disables preemption, calls multi_cpu_stop(),
and thus, CPU 2 will wait forever for migration/1, which should
have been woken up by thread 2. However migration/1 cannot be
woken up by thread 2, since it is a kworker, so it is affine to
CPU 2, but CPU 2 is running migration/2 with preemption
disabled, so thread 2 will never run.

Disable preemption after queueing works for stopper threads
to ensure that the operation of queueing the works and waking
the stopper threads is atomic.

Fixes: 0b26351b910f ("stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock")
Co-Developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
Co-Developed-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc: stable@vger.kernel.org
---
 kernel/stop_machine.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a..e190d1e 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -260,6 +260,15 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	err = 0;
 	__cpu_stop_queue_work(stopper1, work1, &wakeq);
 	__cpu_stop_queue_work(stopper2, work2, &wakeq);
+	/*
+	 * The waking up of stopper threads has to happen
+	 * in the same scheduling context as the queueing.
+	 * Otherwise, there is a possibility of one of the
+	 * above stoppers being woken up by another CPU,
+	 * and preempting us. This will cause us to n ot
+	 * wake up the other stopper forever.
+	 */
+	preempt_disable();
 unlock:
 	raw_spin_unlock(&stopper2->lock);
 	raw_spin_unlock_irq(&stopper1->lock);
@@ -270,7 +279,10 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 		goto retry;
 	}
 
-	wake_up_q(&wakeq);
+	if (!err) {
+		wake_up_q(&wakeq);
+		preempt_enable();
+	}
 
 	return err;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

