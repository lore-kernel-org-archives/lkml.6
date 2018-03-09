Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932618AbeCISqy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:46:54 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43306 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeCISnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:43:03 -0500
X-Google-Smtp-Source: AG47ELuC+ADm+mSj85N2Uxe8U7xZhMlIgy8HC6tsOntc6Fg0gV7vUSGekx5hsOjQNm2xdGUIZD67FA==
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4/4] x86: rtc: Stop using rtc deprecated functions
Date: Fri,  9 Mar 2018 10:42:50 -0800
Message-Id: <1520620971-9567-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
References: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@linaro.org>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/x86/kernel/rtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 69ac9cb..f7b82ed 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -41,11 +41,11 @@ EXPORT_SYMBOL(rtc_lock);
  */
 int mach_set_rtc_mmss(const struct timespec *now)
 {
-	unsigned long nowtime = now->tv_sec;
+	unsigned long long nowtime = now->tv_sec;
 	struct rtc_time tm;
 	int retval = 0;
 
-	rtc_time_to_tm(nowtime, &tm);
+	rtc_time64_to_tm(nowtime, &tm);
 	if (!rtc_valid_tm(&tm)) {
 		retval = mc146818_set_time(&tm);
 		if (retval)
@@ -53,7 +53,7 @@ int mach_set_rtc_mmss(const struct timespec *now)
 			       __func__, retval);
 	} else {
 		printk(KERN_ERR
-		       "%s: Invalid RTC value: write of %lx to RTC failed\n",
+		       "%s: Invalid RTC value: write of %llx to RTC failed\n",
 			__func__, nowtime);
 		retval = -EINVAL;
 	}
-- 
2.7.4
