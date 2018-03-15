Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeCOIwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:52:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeCOIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:52:50 -0400
Date: Thu, 15 Mar 2018 01:52:34 -0700
From: tip-bot for Benjamin Gaignard <tipbot@zytor.com>
Message-ID: <tip-13cc36d76bc4f5a9801ae32630bc8240ba0cc522@git.kernel.org>
Cc: tglx@linutronix.de, arnd@arndb.de, mingo@kernel.org,
        mlichvar@redhat.com, linux-kernel@vger.kernel.org, prarit@redhat.com,
        richardcochran@gmail.com, benjamin.gaignard@linaro.org,
        alexandre.belloni@free-electrons.com, stephen.boyd@linaro.org,
        john.stultz@linaro.org, hpa@zytor.com
Reply-To: richardcochran@gmail.com, benjamin.gaignard@linaro.org,
        stephen.boyd@linaro.org, alexandre.belloni@free-electrons.com,
        john.stultz@linaro.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        mlichvar@redhat.com, prarit@redhat.com
In-Reply-To: <1520620971-9567-5-git-send-email-john.stultz@linaro.org>
References: <1520620971-9567-5-git-send-email-john.stultz@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/rtc: Stop using deprecated functions
Git-Commit-ID: 13cc36d76bc4f5a9801ae32630bc8240ba0cc522
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  13cc36d76bc4f5a9801ae32630bc8240ba0cc522
Gitweb:     https://git.kernel.org/tip/13cc36d76bc4f5a9801ae32630bc8240ba0cc522
Author:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
AuthorDate: Fri, 9 Mar 2018 10:42:50 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 15 Mar 2018 09:47:24 +0100

x86/rtc: Stop using deprecated functions

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.

Use the proper y2038 safe functions.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Link: https://lkml.kernel.org/r/1520620971-9567-5-git-send-email-john.stultz@linaro.org

---
 arch/x86/kernel/rtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 69ac9cb9cac6..f7b82ed7b5b5 100644
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
