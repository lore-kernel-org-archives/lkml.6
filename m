Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeB1F6H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:58:07 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43843 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeB1F6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:58:05 -0500
X-Google-Smtp-Source: AH8x227YxSoKNkprsskd9u1qJbrsH81TdUnvlwxVN63ZCDWbTRAmVF2y83vf4W23+0duZF9KFtyiow==
From: Baolin Wang <baolin.wang@linaro.org>
To: john.stultz@linaro.org, nicstange@gmail.com, arnd@arndb.de
Cc: adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] blackfin: time: Use read_persistent_clock64() instead of read_persistent_clock()
Date: Wed, 28 Feb 2018 13:57:22 +0800
Message-Id: <6d0c9ea91b9e33757073a05756e2ac1078168945.1519796369.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/blackfin/kernel/time-ts.c |    6 ++++--
 arch/blackfin/kernel/time.c    |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/blackfin/kernel/time-ts.c b/arch/blackfin/kernel/time-ts.c
index 0135055..95a80ab 100644
--- a/arch/blackfin/kernel/time-ts.c
+++ b/arch/blackfin/kernel/time-ts.c
@@ -357,9 +357,11 @@ void bfin_coretmr_clockevent_init(void)
 #endif /* CONFIG_TICKSOURCE_CORETMR */
 
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
-	time_t secs_since_1970 = (365 * 37 + 9) * 24 * 60 * 60;	/* 1 Jan 2007 */
+	/* 1 Jan 2007 */
+	time64_t secs_since_1970 = (365 * 37 + 9) * 24 * 60 * 60;
+
 	ts->tv_sec = secs_since_1970;
 	ts->tv_nsec = 0;
 }
diff --git a/arch/blackfin/kernel/time.c b/arch/blackfin/kernel/time.c
index 3126b92..48a6684 100644
--- a/arch/blackfin/kernel/time.c
+++ b/arch/blackfin/kernel/time.c
@@ -132,9 +132,11 @@ irqreturn_t timer_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
-	time_t secs_since_1970 = (365 * 37 + 9) * 24 * 60 * 60;	/* 1 Jan 2007 */
+	/* 1 Jan 2007 */
+	time64_t secs_since_1970 = (365 * 37 + 9) * 24 * 60 * 60;
+
 	ts->tv_sec = secs_since_1970;
 	ts->tv_nsec = 0;
 }
-- 
1.7.9.5
