Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DFCECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582CB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582CB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbeGWNaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:30:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:30:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D254CC03;
        Mon, 23 Jul 2018 12:29:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prasad Sodagudi <psodagud@codeaurora.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        matt@codeblueprint.co.uk, bigeasy@linutronix.de
Subject: [PATCH 4.14 19/44] stop_machine: Disable preemption when waking two stopper threads
Date:   Mon, 23 Jul 2018 14:24:55 +0200
Message-Id: <20180723122438.423181742@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
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

From: Isaac J. Manjarres <isaacm@codeaurora.org>

commit 9fb8d5dc4b649dd190e1af4ead670753e71bf907 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/stop_machine.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

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


