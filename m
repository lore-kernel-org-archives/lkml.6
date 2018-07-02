Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD95C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635F025475
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635F025475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeGBJiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:38:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48147 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGBJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:38:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w629c4DT4024422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 02:38:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w629c4PD4024419;
        Mon, 2 Jul 2018 02:38:04 -0700
Date:   Mon, 2 Jul 2018 02:38:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-5f936e19cc0ef97dbe3a56e9498922ad5ba1edef@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, icytxw@gmail.com, john.stultz@linaro.org
Reply-To: john.stultz@linaro.org, icytxw@gmail.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1807020926360.1595@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1807020926360.1595@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] alarmtimer: Prevent overflow for relative
 nanosleep
Git-Commit-ID: 5f936e19cc0ef97dbe3a56e9498922ad5ba1edef
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

Commit-ID:  5f936e19cc0ef97dbe3a56e9498922ad5ba1edef
Gitweb:     https://git.kernel.org/tip/5f936e19cc0ef97dbe3a56e9498922ad5ba1edef
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 2 Jul 2018 09:34:29 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 2 Jul 2018 11:33:26 +0200

alarmtimer: Prevent overflow for relative nanosleep

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

---
 kernel/time/alarmtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 78a3cc555823..fa5de5e8de61 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -808,7 +808,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
 		ktime_t now = alarm_bases[type].gettime();
-		exp = ktime_add(now, exp);
+
+		exp = ktime_add_safe(now, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
