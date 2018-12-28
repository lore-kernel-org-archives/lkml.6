Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B285C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2A12184B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999380;
	bh=rAIlrZbDQYTKCFRc4har1wxqsFSdVh0izl/ghOVbOK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d0mrGxgCXYa5Trz+3+XxvgohfuAEQqxw8kSW/F1GGrHPwSHu7iOi1lQxbUY3dc6SI
	 TkhXUjg5AY7zQIsQ8/ZQ3HkWO9cag5x8r72Sz7glSDXHU4uuCfh8ZvHpaGwHE9/QA/
	 6ylCoN6yhXO7y2csJMAYaiwCeIqHu7smFGizkKEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbeL1MQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732624AbeL1MQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D40E2087F;
        Fri, 28 Dec 2018 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999370;
        bh=rAIlrZbDQYTKCFRc4har1wxqsFSdVh0izl/ghOVbOK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfPIQ5v+VHUXMch9Bn77amQ87mTlkhipmMrYT3La8t08f4QkBUClfRaTYhYLebWAA
         aA7Z19PNR0vMikH98fksEWXRVt1y14JvcMNQLRnCa6ATmjNTPO1nvhe34hWyuA6j31
         MLCC6ohwT0YT9iV2HknMkG8ZDgYyQMfEwoBKV8K8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9d38bedac9cc77b8ad5e@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 23/36] posix-timers: Fix division by zero bug
Date:   Fri, 28 Dec 2018 12:52:39 +0100
Message-Id: <20181228113128.135627109@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 upstream.

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
Cc: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: sboyd@kernel.org
Cc: stable@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1812171328050.1880@nanos.tec.linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/posix-timers.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,9 +298,6 @@ static void common_hrtimer_rearm(struct
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	if (!timr->it_interval)
-		return;
-
 	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
 					    timr->it_interval);
 	hrtimer_restart(timer);
@@ -326,7 +323,7 @@ void posixtimer_rearm(struct siginfo *in
 	if (!timr)
 		return;
 
-	if (timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;


