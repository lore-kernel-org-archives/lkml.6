Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59783C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7E020866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfAOPhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:37:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfAOPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:37:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0FFatRP2576546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 07:36:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0FFatjt2576543;
        Tue, 15 Jan 2019 07:36:55 -0800
Date:   Tue, 15 Jan 2019 07:36:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-93ad0fc088c5b4631f796c995bdd27a082ef33a6@git.kernel.org>
Cc:     mingo@kernel.org, hjl.tools@gmail.com, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org
Reply-To: peterz@infradead.org, hpa@zytor.com, hjl.tools@gmail.com,
          mingo@kernel.org, john.stultz@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20190111133500.840117406@linutronix.de>
References: <20190111133500.840117406@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] posix-cpu-timers: Unbreak timer rearming
Git-Commit-ID: 93ad0fc088c5b4631f796c995bdd27a082ef33a6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  93ad0fc088c5b4631f796c995bdd27a082ef33a6
Gitweb:     https://git.kernel.org/tip/93ad0fc088c5b4631f796c995bdd27a082ef33a6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 11 Jan 2019 14:33:16 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 16:34:37 +0100

posix-cpu-timers: Unbreak timer rearming

The recent commit which prevented a division by 0 issue in the alarm timer
code broke posix CPU timers as an unwanted side effect.

The reason is that the common rearm code checks for timer->it_interval
being 0 now. What went unnoticed is that the posix cpu timer setup does not
initialize timer->it_interval as it stores the interval in CPU timer
specific storage. The reason for the separate storage is historical as the
posix CPU timers always had a 64bit nanoseconds representation internally
while timer->it_interval is type ktime_t which used to be a modified
timespec representation on 32bit machines.

Instead of reverting the offending commit and fixing the alarmtimer issue
in the alarmtimer code, store the interval in timer->it_interval at CPU
timer setup time so the common code check works. This also repairs the
existing inconistency of the posix CPU timer code which kept a single shot
timer armed despite of the interval being 0.

The separate storage can be removed in mainline, but that needs to be a
separate commit as the current one has to be backported to stable kernels.

Fixes: 0e334db6bb4b ("posix-timers: Fix division by zero bug")
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190111133500.840117406@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 8f0644af40be..80f955210861 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -685,6 +685,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * set up the signal and overrun bookkeeping.
 	 */
 	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
+	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
 
 	/*
 	 * This acts as a modification timestamp for the timer,
