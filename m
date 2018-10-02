Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27635C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4A1206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4A1206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbeJBUTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732883AbeJBUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:18 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB5D6C2B;
        Tue,  2 Oct 2018 13:35:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Team OWL337 <icytxw@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 27/94] alarmtimer: Prevent overflow for relative nanosleep
Date:   Tue,  2 Oct 2018 06:24:41 -0700
Message-Id: <20181002132502.389394923@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 5f936e19cc0ef97dbe3a56e9498922ad5ba1edef ]

Air Icy reported:

  UBSAN: Undefined behaviour in kernel/time/alarmtimer.c:811:7
  signed integer overflow:
  1529859276030040771 + 9223372036854775807 cannot be represented in type 'long long int'
  Call Trace:
   alarm_timer_nsleep+0x44c/0x510 kernel/time/alarmtimer.c:811
   __do_sys_clock_nanosleep kernel/time/posix-timers.c:1235 [inline]
   __se_sys_clock_nanosleep kernel/time/posix-timers.c:1213 [inline]
   __x64_sys_clock_nanosleep+0x326/0x4e0 kernel/time/posix-timers.c:1213
   do_syscall_64+0xb8/0x3a0 arch/x86/entry/common.c:290

alarm_timer_nsleep() uses ktime_add() to add the current time and the
relative expiry value. ktime_add() has no sanity checks so the addition
can overflow when the relative timeout is large enough.

Use ktime_add_safe() which has the necessary sanity checks in place and
limits the result to the valid range.

Fixes: 9a7adcf5c6de ("timers: Posix interface for alarm-timers")
Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1807020926360.1595@nanos.tec.linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/alarmtimer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -786,7 +786,8 @@ static int alarm_timer_nsleep(const cloc
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
 		ktime_t now = alarm_bases[type].gettime();
-		exp = ktime_add(now, exp);
+
+		exp = ktime_add_safe(now, exp);
 	}
 
 	if (alarmtimer_do_nsleep(&alarm, exp))


