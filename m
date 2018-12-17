Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB39206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbeLQMbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:31:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731980AbeLQMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:31:08 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gYs37-0000CS-UF; Mon, 17 Dec 2018 13:31:06 +0100
Date:   Mon, 17 Dec 2018 13:31:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+9d38bedac9cc77b8ad5e@syzkaller.appspotmail.com>
cc:     John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] posix-timers: Prevent division by zero
In-Reply-To: <000000000000c867e9057d326295@google.com>
Message-ID: <alpine.DEB.2.21.1812171328050.1880@nanos.tec.linutronix.de>
References: <000000000000c867e9057d326295@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal delivery path of posix-timers can try to rearm the timer even if
the interval is zero. That's handled for the common case (hrtimer) but not
for alarm timers. In that case the forwarding function raises a division by
zero exception.

The handling for hrtimer based posix timers is wrong because it marks the
timer as active despite the fact that it is stopped.

Move the check from common_hrtimer_rearm() to posixtimer_rearm() to cure
both issues.

Reported-by: syzbot+9d38bedac9cc77b8ad5e@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/time/posix-timers.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,9 +289,6 @@ static void common_hrtimer_rearm(struct
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	if (!timr->it_interval)
-		return;
-
 	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
 					    timr->it_interval);
 	hrtimer_restart(timer);
@@ -317,7 +314,7 @@ void posixtimer_rearm(struct kernel_sigi
 	if (!timr)
 		return;
 
-	if (timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;
