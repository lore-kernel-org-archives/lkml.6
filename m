Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F7A22516
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dPoxJFRy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bWEcEjY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F7A22516
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeFZV2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:28:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48568 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbeFZV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:28:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A3C860711; Tue, 26 Jun 2018 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530048519;
        bh=G8jKNI8RKiuMGS31SwLbIizPkCfGiSDV0fZjGC9uclw=;
        h=From:To:Cc:Subject:Date:From;
        b=dPoxJFRyQa44p2VGQuBtUrxFz/M+LUy3rE/nYEX3zLXvm1j3TB4ZPiIchU/V3ejLL
         p+UTYHvEv9eAuwsUOZsfGFNkorUinWnBrcjSWmTnxc24anV+8EaYBNKSljuGoln63l
         irTl5Bhrq5P7l1OLTNSUUXO54CFjrOE+TtUOhLUY=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59CFD606FC;
        Tue, 26 Jun 2018 21:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530048518;
        bh=G8jKNI8RKiuMGS31SwLbIizPkCfGiSDV0fZjGC9uclw=;
        h=From:To:Cc:Subject:Date:From;
        b=bWEcEjY29DYoH+7tBQ3cfVNU/LEttwNqWygvOJRXEr9PCkDtYrMJt8WaWvk63e6ok
         MU/L+wtmE6yvzXM6i579Q8jYa3cSyGSl3iEuwgWtxSJNlqKNRvTmGruDL9xYmVvZJt
         sWcxVH0MrNPM0SeaUGoNrdS0eWVXLCxL/FcRsEqA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59CFD606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org
Subject: [PATCH] stop_machine: Remove cpu swap from stop_two_cpus
Date:   Tue, 26 Jun 2018 14:28:26 -0700
Message-Id: <1530048506-21393-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When invoking migrate_swap(), stop_two_cpus() swaps the
source and destination CPU IDs if the destination CPU
ID is greater than the source CPU ID. This leads to the
following race condition:

The source CPU invokes migrate_swap and sets itself as
the source CPU, and sets the destination CPU to another
CPU, such that the CPU ID of the destination CPU is
greater than that of the source CPU ID, and invokes
stop_two_cpus(cpu1=destination CPU, cpu2=source CPU,...)
Now, stop_two_cpus sees that the destination CPU ID is
greater than the source CPU ID, and performs the swap, so
that cpu1=source CPU, and cpu2=destination CPU.

The source CPU calls cpu_stop_queue_two_works(), with cpu1
as the source CPU, and cpu2 as the destination CPU. When
adding the stopper threads to the wake queue used in this
function, the source CPU stopper thread is added first,
and the destination CPU stopper thread is added last.

When wake_up_q() is invoked to wake the stopper threads, the
threads are woken up in the order that they are queued in,
so the source CPU's stopper thread is woken up first, and
it preempts the thread running on the source CPU.

The stopper thread will then execute on the source CPU,
disable preemption, and begin executing multi_cpu_stop()
and wait for an ack from the destination CPU's stopper thread,
with preemption still disabled. Since the worker thread that
woke up the stopper thread on the source CPU is affine to the
source CPU, and preemption is disabled on the source CPU, that
thread will never run to dequeue the destination CPU's stopper
thread from the wake queue, and thus, the destination CPU's
stopper thread will never run, causing the source CPU's stopper
thread to wait forever, and stall.

Remove CPU ID swapping in stop_two_cpus() so that the
source CPU's stopper thread is added to the wake queue last,
so that the source CPU's stopper thread is woken up last,
ensuring that all other threads that it depends on are woken
up before it runs.

Co-developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 kernel/stop_machine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a..d10d633 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -307,8 +307,6 @@ int stop_two_cpus(unsigned int cpu1, unsigned int cpu2, cpu_stop_fn_t fn, void *
 	cpu_stop_init_done(&done, 2);
 	set_state(&msdata, MULTI_STOP_PREPARE);
 
-	if (cpu1 > cpu2)
-		swap(cpu1, cpu2);
 	if (cpu_stop_queue_two_works(cpu1, &work1, cpu2, &work2))
 		return -ENOENT;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

