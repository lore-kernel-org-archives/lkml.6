Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670AAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338002183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAGTyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfAGTxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:35 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 730CA218C3;
        Mon,  7 Jan 2019 19:53:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxp-0000Ll-Ed; Mon, 07 Jan 2019 14:53:33 -0500
Message-Id: <20190107195333.322706801@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:53:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH RT 09/13] hrtimer: move state change before hrtimer_cancel in do_nanosleep()
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 8115ac730fd5aa27134f002cf710204b5dd7cd5e ]

There is a small window between setting t->task to NULL and waking the
task up (which would set TASK_RUNNING). So the timer would fire, run and
set ->task to NULL while the other side/do_nanosleep() wouldn't enter
freezable_schedule(). After all we are peemptible here (in
do_nanosleep() and on the timer wake up path) and on KVM/virt the
virt-CPU might get preempted.
So do_nanosleep() wouldn't enter freezable_schedule() but cancel the
timer which is still running and wait for it via
hrtimer_wait_for_timer(). Then wait_event()/might_sleep() would complain
that it is invoked with state != TASK_RUNNING.
This isn't a problem since it would be reset to TASK_RUNNING later
anyway and we don't rely on the previous state.

Move the state update to TASK_RUNNING before hrtimer_cancel() so there
are no complains from might_sleep() about wrong state.

Cc: stable-rt@vger.kernel.org
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b59e009087a9..c8d806126381 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1753,12 +1753,12 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 		if (likely(t->task))
 			freezable_schedule();
 
+		__set_current_state(TASK_RUNNING);
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
-	__set_current_state(TASK_RUNNING);
 
 	if (!t->task)
 		return 0;
-- 
2.19.2


