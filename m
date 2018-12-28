Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29576C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB56218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998028;
	bh=XILmnMNxl+5yQbAFPAVKMnYu5eSbkdXM0ba5V+YPP1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VPqTmAGBVqxQ8+hde7ljqk56VcGqe2SdaO7e3LiU888z1+ZHitXK4fN9vejxV0Shp
	 SKuELWCIaoAhoWjTASfVgoeoG9wt0qJInNLruWrazmXMLPiszy+lFojMBG72/RlWcY
	 zSZIs2v+T0x+pd1XVCXNMuN+S9lVCXSciDi3ecGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbeL1Lxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732322AbeL1Lxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5132087F;
        Fri, 28 Dec 2018 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998019;
        bh=XILmnMNxl+5yQbAFPAVKMnYu5eSbkdXM0ba5V+YPP1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuMWiysKpIqoA+XYasA3C4jJ9GsDC/ztwjO5GlARqzjU0Fy4bRiR/B4ptlaozgT8+
         lv0f8rwvTO8/EC6uHwknz5N5gxgl8mcaZBt7E7Jpdk8ygJwfnynsQzKhEDvZUIYBYR
         AkDiJLDkrw2LsYbq68HXgmjL+ldHXQKziGAqvX8A=
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
Subject: [PATCH 4.19 20/46] posix-timers: Fix division by zero bug
Date:   Fri, 28 Dec 2018 12:52:14 +0100
Message-Id: <20181228113125.967556121@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -289,9 +289,6 @@ static void common_hrtimer_rearm(struct
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	if (!timr->it_interval)
-		return;
-
 	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
 					    timr->it_interval);
 	hrtimer_restart(timer);
@@ -317,7 +314,7 @@ void posixtimer_rearm(struct siginfo *in
 	if (!timr)
 		return;
 
-	if (timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;


