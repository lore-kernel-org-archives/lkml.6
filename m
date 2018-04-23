Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeDWIxO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:53:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754186AbeDWIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:53:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org
Cc: Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>, Sam Creasey <sammy@sammy.net>,
        y2038@lists.linaro.org, baolin.wang@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: use read_persistent_clock64 consistently
Date: Mon, 23 Apr 2018 10:52:28 +0200
Message-Id: <20180423085242.3140416-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fvqUw+Uv+2si+CxgLBkTIFex6LTGzofrA6BA5n5x26lvppavHCC
 Hz77CjMIgGmM7YD35rda2r50R8XB4zpqtXWWC6cRBxNCmFucN/Vvw/a3dwTCWSU58iZ7naO
 qSTrzNntzC7Hn6PhnSOVF6BaHvYHV4urz7aZPjVKOkH6i8j188jN0Ukh/Xl01oNrLMOzEGz
 qgz/2175Fa/3KTByik2ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9nx4kfXddHU=:u8lims6uQgO2OYHO1zKaOo
 z35OGbDsbSnNWHxmQ7JAP/VXcc0xU3EfNDO4WQy3TdoJClpd/TkAcQJlytYpoY138No7rcbCi
 QOxxy2RhpKG/B69QCcS7Xp6a57hN/YfY64Esa4I1Hl0bVql2FhS+cvOU68LjkUdGtYwZ2ED/V
 DFYsLf3Iqfm/qNhKcXjYcWkIfMb99TdLcO6zx3v+dGnMmOlKgaAg9leJr2sqCHFs+moLNV9oH
 ZOuiNG4NeJbABNLs8HbZyA/dC/6jM8aM72t2YpH2TF/IR4exXFbHL8yAh4GhpzZNDdAPknNii
 ew2YMkFjuMlKblvdtid+QJT8gd+LDOxGwmJAPTS1kDEcDcQfRY2zBNTIqJN7s3MLW/sh3ET1w
 SRZC302k8Gc/04UTAKyvbsmzhQgA7zaJocFj+Y8TggBMoZ5n0zFWRN+SAM+bm/ndjZWWtAUKm
 l7wGWlFYCJKBz0vvB4WIq9oNlUVkeJVEJUT3WMQonIla9QIyOdB90Msc18cn7CYZ4XOuRUO+L
 GOH44A7i/RX++zj8C3yWdherSR1NZNyK24IgGiHN+ficH5bN3xaz0h+H2sW9dcwAzipsYqnlu
 tI5Qp170odkd+LPCMjJyxZJ4q1YvyTX1MY56JGeSiGkLOM/sEZ0F4VH2TYF5FGYdbEy1sN2hS
 wyIUaOtFtg0DROnbk9UXhnwBDAjli+qCQW20YT8JuQFVjX2NFZG5nTptLhgDFiLL9mrQOOLhO
 WL91HTb03SFcBk9nUfN1DXAAsn4nUS2whzSQag==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two ways of getting the current time from a platform at boot
or during suspend: either using read_persistent_clock() or the rtc
class operation. We never need both, so I'm hiding the
read_persistent_clock variant when the generic RTC is enabled.

Since read_persistent_clock() and mktime() are deprecated because of
the y2038 overflow of time_t, we should use the time64_t based
replacements here.

Finally, the dependency on CONFIG_ARCH_USES_GETTIMEOFFSET looks
completely bogus in this case, so let's remove that. It was
added in commit b13b3f51ff7b ("m68k: fix inclusion of
arch_gettimeoffset for non-MMU 68k classic CPU types") to deal
with arch_gettimeoffset(), which has since been removed from
this file and is unrelated to the RTC functions.

The rtc accessors are only used by classic machines, while
coldfire uses proper RTC drivers, so we can put the old
ifdef back around both functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/time.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 6b4389a6e8ea..3a8b47f8f97b 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -71,7 +71,9 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
 	return IRQ_HANDLED;
 }
 
-void read_persistent_clock(struct timespec *ts)
+#ifdef CONFIG_M68KCLASSIC
+#if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	struct rtc_time time;
 
@@ -83,11 +85,12 @@ void read_persistent_clock(struct timespec *ts)
 
 	mach_hwclk(0, &time);
 
-	ts->tv_sec = mktime(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
-			    time.tm_hour, time.tm_min, time.tm_sec);
+	ts->tv_sec = mktime64(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
+			      time.tm_hour, time.tm_min, time.tm_sec);
 }
+#endif
 
-#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
+#if IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
 static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
 	mach_hwclk(0, tm);
@@ -145,8 +148,8 @@ static int __init rtc_init(void)
 }
 
 module_init(rtc_init);
-
-#endif /* CONFIG_ARCH_USES_GETTIMEOFFSET */
+#endif /* CONFIG_RTC_DRV_GENERIC */
+#endif /* CONFIG M68KCLASSIC */
 
 void __init time_init(void)
 {
-- 
2.9.0
