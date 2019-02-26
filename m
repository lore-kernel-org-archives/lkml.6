Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88990217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfBZLia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:38:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBZLia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:38:30 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gyb45-0005V6-Rt; Tue, 26 Feb 2019 12:38:25 +0100
Date:   Tue, 26 Feb 2019 12:38:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT 4/2] hrtimer: Don't lose state in cpu_chill()
Message-ID: <20190226113825.cusw372nwlbju4hh@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190218163137.cmor4ek3odus5m6j@linutronix.de>
 <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
 <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
 <1551105815.6234.14.camel@gmx.de>
 <20190225163440.ptw2ohijokhumn7i@linutronix.de>
 <1551116436.5281.5.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551116436.5281.5.camel@gmx.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25 18:40:36 [+0100], Mike Galbraith wrote:
> Ah.  Yup, box says you're right.

Thank you. Added:

Subject: [PATCH] hrtimer: cpu_chill(): save task state in ->saved_state()

In the previous change I saved the current task state on stack. This was
bad because while the task is scheduled-out it might receive a wake-up.
The wake up changes the task state and we must not destroy it.

Save the task-state in ->saved_state under a PI-lock to unsure that
state changes during are not missed while the task temporary scheduled
out.

Reported-by: Mike Galbraith <efault@gmx.de>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6f2736ec4b8ef..e1040b80362c9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1900,20 +1900,28 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
  */
 void cpu_chill(void)
 {
-	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
-	long saved_state;
+	struct task_struct *self = current;
+	ktime_t chill_time;
 
-	saved_state = current->state;
-	chill_time = ktime_set(0, NSEC_PER_MSEC);
+	raw_spin_lock_irq(&self->pi_lock);
+	self->saved_state = self->state;
 	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+	raw_spin_unlock_irq(&self->pi_lock);
+
+	chill_time = ktime_set(0, NSEC_PER_MSEC);
+
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
-	__set_current_state_no_track(saved_state);
+
+	raw_spin_lock_irq(&self->pi_lock);
+	__set_current_state_no_track(self->saved_state);
+	self->saved_state = TASK_RUNNING;
+	raw_spin_unlock_irq(&self->pi_lock);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
-- 
2.20.1


Sebastian
