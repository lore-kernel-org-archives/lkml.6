Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34948C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6A320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfBYQeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:34:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40842 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfBYQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:34:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gyJDE-0002Cx-Je; Mon, 25 Feb 2019 17:34:40 +0100
Date:   Mon, 25 Feb 2019 17:34:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT 4/2] hrtimer: Don't lose state in cpu_chill()
Message-ID: <20190225163440.ptw2ohijokhumn7i@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190218163137.cmor4ek3odus5m6j@linutronix.de>
 <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
 <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
 <1551105815.6234.14.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551105815.6234.14.camel@gmx.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25 15:43:35 [+0100], Mike Galbraith wrote:
> Hi Sebastian,
Hi Mike,

> My box claims that this patch is busted.  It argues its case by IO
> deadlocking any kernel this patch is applied to when spinning rust is
> flogged, including virgin 4.19-rt14, said kernel becoming stable again
> when I whack the accused.

does the following hunk make any difference?

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6ecdb9469ca9..e154632b90b4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1884,20 +1884,29 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct old_timespec32 __user *, rqtp,
  */
 void cpu_chill(void)
 {
+	struct task_struct *self = current;
 	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
-	long saved_state;
 
-	saved_state = current->state;
-	chill_time = ktime_set(0, NSEC_PER_MSEC);
+	raw_spin_lock_irq(&self->pi_lock);
+	WARN_ON(self->saved_state != TASK_RUNNING);
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

Sebastian
