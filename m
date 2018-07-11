Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85242C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490CD20857
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490CD20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbeGKN4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:56:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40187 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387708AbeGKN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:56:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fdFXV-0001Je-JW; Wed, 11 Jul 2018 15:52:17 +0200
Date:   Wed, 11 Jul 2018 15:52:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        Peter Zilstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RT] Revert "posix-timers: Prevent broadcast signals"
Message-ID: <20180711135217.s6at5tj4yiup2fxw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit "posix-timers: Prevent broadcast signals".
Broadcast signals are not prevented by preventing sig_kernel_only() and
sig_kernel_coredump() (as explained by Eric W. Biederman).
This change was probably required in the early days but I can't find a
reason why it should be still required.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e1c5b9b64140..0d14e044b46f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -434,7 +434,6 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn = current->group_leader;
-	int sig = event->sigev_signo;
 
 	switch (event->sigev_notify) {
 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
@@ -444,8 +443,7 @@ static struct pid *good_sigevent(sigevent_t * event)
 		/* FALLTHRU */
 	case SIGEV_SIGNAL:
 	case SIGEV_THREAD:
-		if (sig <= 0 || sig > SIGRTMAX ||
-		    sig_kernel_only(sig) || sig_kernel_coredump(sig))
+		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
 			return NULL;
 		/* FALLTHRU */
 	case SIGEV_NONE:
-- 
2.18.0

