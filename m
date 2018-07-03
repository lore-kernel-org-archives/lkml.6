Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F835C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494F223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YWGJiYLV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ouQKSYdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494F223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeGCWCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:02:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbeGCWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:02:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9823F60B19; Tue,  3 Jul 2018 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530655369;
        bh=Mw/64kaifQL/Q2pRx51sUdEM3KqJyG58cb1WWuYz/Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=YWGJiYLV+N7a4vzxiNiZagOS6AU/ur9L184RpqztmtJS/LvYrUhjxWrOriLJ1fX7E
         gjdvheGUDjNUP0p8/68bzY6rl0gAc5yQoJzwps7dim2+DDWww8awgrLn1IqhtJOxw2
         X93YonsaBP3zGMTq17FZBOdJHvFqsPTAphFbl2h8=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 698426063F;
        Tue,  3 Jul 2018 22:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530655368;
        bh=Mw/64kaifQL/Q2pRx51sUdEM3KqJyG58cb1WWuYz/Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=ouQKSYdrQ6O3b/pl2AUofg4H4Wq7BGuat4jwu8hDbFuT0n2/ULyXfLOxRAJYT4qm4
         8abqyBGnsxTn0tjuyLtY2U/1Q0YpafaGx9krNBK2KTL+Q7FZGN1vRxWdBkR1C2xRig
         7r4udiN715qlZV7YEFNzUaDDsOXLiRH0kCA4WxcU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 698426063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        gregkh@linuxfoundation.org, pkondeti@codeaurora.org,
        stable@vger.kernel.org
Subject: [PATCH v3] stop_machine: Disable preemption when waking two stopper threads
Date:   Tue,  3 Jul 2018 15:02:14 -0700
Message-Id: <1530655334-4601-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cpu_stop_queue_two_works() begins to wake the stopper
threads, it does so without preemption disabled, which leads
to the following race condition:

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
disable preemption, and begin executing multi_cpu_stop(),
and wait for an ack from the destination CPU's stopper thread,
with preemption still disabled. Since the worker thread that
woke up the stopper thread on the source CPU is affine to the
source CPU, and preemption is disabled on the source CPU, that
thread will never run to dequeue the destination CPU's stopper
thread from the wake queue, and thus, the destination CPU's
stopper thread will never run, causing the source CPU's stopper
thread to wait forever, and stall.

Disable preemption when waking the stopper threads in
cpu_stop_queue_two_works().

Fixes: 0b26351b910f ("stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock")
Co-Developed-by: Prasad Sodagudi <psodagud@codeaurora.org>
Co-Developed-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc: stable@vger.kernel.org
---
 kernel/stop_machine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index f89014a..1ff523d 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -270,7 +270,11 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

