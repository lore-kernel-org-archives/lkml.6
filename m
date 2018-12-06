Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF450C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD9921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD9921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeLFKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:15:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50890 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:15:58 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gUqhH-0004et-Lh; Thu, 06 Dec 2018 11:15:55 +0100
Date:   Thu, 6 Dec 2018 11:15:55 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH RT] hrtimer: move state change before hrtimer_cancel in
 do_nanosleep()
Message-ID: <20181206101555.xqrz2fl6k36bvezm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index bf0ec3fbbe797..851b2134e77f4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1785,12 +1785,12 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
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
2.20.0.rc2

