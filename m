Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58198C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102242145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/2RXDDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102242145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbeK3B3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbeK3B3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6576205C9;
        Thu, 29 Nov 2018 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501421;
        bh=vgNjUOhjL5ZJ9pTV9PWuDsAe44lkfx3uW1GVjTuAPgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/2RXDDiHc43CbR6bD9W48/wtaXxFvc2zqDtOaoIzquDspKpEi019/eChfpIjNOx9
         /OG5QVrpYtlBpBAilYgAH/TGlFE96kUkfvijZ9XoG/zOD2p68EanK8l8MPktF9E+7l
         xA4LyR41GZPb3XCuzRBWcJOyNCaIAVQT8R2Yh1Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@osdl.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 83/92] sched/core: Allow __sched_setscheduler() in interrupts when PI is not used
Date:   Thu, 29 Nov 2018 15:12:52 +0100
Message-Id: <20181129140113.332024968@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 896bbb2522587e3b8eb2a0d204d43ccc1042a00d upstream.

When priority inheritance was added back in 2.6.18 to sched_setscheduler(), it
added a path to taking an rt-mutex wait_lock, which is not IRQ safe. As PI
is not a common occurrence, lockdep will likely never trigger if
sched_setscheduler was called from interrupt context. A BUG_ON() was added
to trigger if __sched_setscheduler() was ever called from interrupt context
because there was a possibility to take the wait_lock.

Today the wait_lock is irq safe, but the path to taking it in
sched_setscheduler() is the same as the path to taking it from normal
context. The wait_lock is taken with raw_spin_lock_irq() and released with
raw_spin_unlock_irq() which will indiscriminately enable interrupts,
which would be bad in interrupt context.

The problem is that normalize_rt_tasks, which is called by triggering the
sysrq nice-all-RT-tasks was changed to call __sched_setscheduler(), and this
is done from interrupt context!

Now __sched_setscheduler() takes a "pi" parameter that is used to know if
the priority inheritance should be called or not. As the BUG_ON() only cares
about calling the PI code, it should only bug if called from interrupt
context with the "pi" parameter set to true.

Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: dbc7f069b93a ("sched: Use replace normalize_task() with __sched_setscheduler()")
Link: http://lkml.kernel.org/r/20170308124654.10e598f2@gandalf.local.home
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4087,8 +4087,8 @@ static int __sched_setscheduler(struct t
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 	struct rq *rq;
 
-	/* may grab non-irq protected spin_locks */
-	BUG_ON(in_interrupt());
+	/* The pi code expects interrupts enabled */
+	BUG_ON(pi && in_interrupt());
 recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0) {


