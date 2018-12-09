Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB36020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB36020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeLIVzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34542 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbeLIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:09 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002iq-VW; Sun, 09 Dec 2018 21:55:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003DX-C7; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Team OWL337" <icytxw@gmail.com>,
        "John Stultz" <john.stultz@linaro.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.362384152@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 018/328] alarmtimer: Prevent overflow for relative
 nanosleep
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 5f936e19cc0ef97dbe3a56e9498922ad5ba1edef upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/time/alarmtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -775,7 +775,8 @@ static int alarm_timer_nsleep(const cloc
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
 		ktime_t now = alarm_bases[type].gettime();
-		exp = ktime_add(now, exp);
+
+		exp = ktime_add_safe(now, exp);
 	}
 
 	if (alarmtimer_do_nsleep(&alarm, exp))

