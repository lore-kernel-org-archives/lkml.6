Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeDSGXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:23:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40902 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeDSGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:23:06 -0400
X-Google-Smtp-Source: AIpwx48emqfPJSh/DnZ3yvPsxJ5iEYJwefDs/NFhdOpZ5NXi4u4EsBMqMXVIj9OAKGJ4Get/vChxsg==
From: Baolin Wang <baolin.wang@linaro.org>
To: geert@linux-m68k.org
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de, broonie@kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH] m68k: Remove read_persistent_clock()
Date: Thu, 19 Apr 2018 14:22:20 +0800
Message-Id: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read_persistent_clock() uses a timespec, which is not year 2038 safe
on 32bit systems. Moreover on m68k architecture, we have implemented generic
RTC drivers that can be used to compensate the system suspend time. So
we can remove the obsolete read_persistent_clock().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/m68k/kernel/time.c |   16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 97dd4e2..cb386d8 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -71,22 +71,6 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-void read_persistent_clock(struct timespec *ts)
-{
-	struct rtc_time time;
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-
-	if (mach_hwclk) {
-		mach_hwclk(0, &time);
-
-		if ((time.tm_year += 1900) < 1970)
-			time.tm_year += 100;
-		ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
-				      time.tm_hour, time.tm_min, time.tm_sec);
-	}
-}
-
 #if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
 static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
-- 
1.7.9.5
