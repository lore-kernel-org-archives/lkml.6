Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F622086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfANRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfANRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:25:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDB8E2070B;
        Mon, 14 Jan 2019 17:25:41 +0000 (UTC)
Date:   Mon, 14 Jan 2019 12:25:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] sbitmap: Protect swap_lock from softirqs
Message-ID: <20190114122540.7a54e6f3@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

The swap_lock used by sbitmap has a chain with locks taken from
softirq, but the swap_lock is not protected from being preempted by
softirqs.

A chain exists of:

 sbq->ws[i].wait -> dispatch_wait_lock -> swap_lock

Where the sbq->ws[i].wait lock can be taken from softirq context, which
means all locks below it in the chain must also be protected from
softirqs.

Cc: stable@vger.kernel.org
Reported-by: Clark Williams <williams@redhat.com>
Fixes: 58ab5e32e6fd ("sbitmap: silence bogus lockdep IRQ warning")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 65c2d06250a6..864354000e04 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -26,14 +26,9 @@
 static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 {
 	unsigned long mask, val;
-	unsigned long __maybe_unused flags;
 	bool ret = false;
 
-	/* Silence bogus lockdep warning */
-#if defined(CONFIG_LOCKDEP)
-	local_irq_save(flags);
-#endif
-	spin_lock(&sb->map[index].swap_lock);
+	spin_lock_bh(&sb->map[index].swap_lock);
 
 	if (!sb->map[index].cleared)
 		goto out_unlock;
@@ -54,10 +49,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 
 	ret = true;
 out_unlock:
-	spin_unlock(&sb->map[index].swap_lock);
-#if defined(CONFIG_LOCKDEP)
-	local_irq_restore(flags);
-#endif
+	spin_unlock_bh(&sb->map[index].swap_lock);
 	return ret;
 }
 
