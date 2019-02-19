Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7394AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfBSQIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:08:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34062 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfBSQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:08:46 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gw7wp-0001FM-2l; Tue, 19 Feb 2019 17:08:43 +0100
Date:   Tue, 19 Feb 2019 17:08:43 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/2] hrtimer: Don't lose state in cpu_chill()
Message-ID: <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190218163137.cmor4ek3odus5m6j@linutronix.de>
 <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cpu_chill() the state is set to TASK_UNINTERRUPTIBLE and a timer is
programmed. On return the state is always TASK_RUNNING which means we
lose the state if it was something other than RUNNING. Also
set_current_state() sets ->task_state_change to within cpu_chill() which
is not expected.

Save the task state on entry and restore it on return. Simply set the
state in order to avoid updating ->task_state_change.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 851b2134e77f4..6f2736ec4b8ef 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1902,15 +1902,18 @@ void cpu_chill(void)
 {
 	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
+	long saved_state;
 
+	saved_state = current->state;
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
+	__set_current_state_no_track(saved_state);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
-- 
2.20.1

