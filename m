Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeDTQOy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:14:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:14:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtc: vr41xx: remove mktime usage
Date: Fri, 20 Apr 2018 18:14:24 +0200
Message-Id: <20180420161433.3721192-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:5q6Yn/6t1PHM/iTwtOaUQDAOWGhqGQWn6ZhUBQMPfwOfzH+FHzT
 lPcDQWyLVkYwosho7qesbDYm9bKzB8SEehzgf7dFfSdhlCMVzD+M6V+OSVuf3PyAXzHOBf0
 JUciYlMbFP4xPEvDvkkKr2m7SIyaLtodIGHfERJe2+ascePIaow3A6krgqcx/AuCdjwkJMy
 xfAXAgLzuw317DAFfRjOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g6+nH7Yf/T0=:uwuoSN6lV6R9JG4aoWip+T
 RGzfW6EpOXgfsFg6v7VpSuCFhlBRXu/VsUz6YKeGu7QByI9QzSOeL4o7803I1ZTDWBLrjzz+x
 Fh4Zdwqr0XI5sdDgCHdq/DJyWYPBkgh0mFgRHS40tHREkjr75yHNqLPDvSjVxxcPmMLv/LWtv
 a4U5UCDPojT78iz/cMhGMW/sNV5VMpS718gh3Uxh/XdmxEqCmpEq36yQQwX/DaZM6YREoUplj
 d8RljjZv9NxQZyve5z+q2xc+V0LVJ0i8sauCbDYDnA3g6GW1Cwso8ekGRyReu7OEnoxvypcCI
 ooz+wpF8KqS3eDYbTHiD9un0vTAezeYQpUeuSQiUA8oSCojUW8LFVaMToWUi0sPC4metPttRx
 W0Xf7GZP0YdzCspwm7GK2OcvLKI0We6QvoJoOZgzFZPCdprP9MySg2WMctzjjt6WWjchdfKm9
 H7TiK5pNNs+PcQthIFeCRZESlUkVtXjn5hr9LWQ9SzP+w3indY1xE5BFgp9LB4QWirGGKOTJo
 18N1fWPS5mG1qpwEtMZoZYlNPeTRTadT9TzcvZtMGc+faxoMmF0/lkcVPqC9RdsiYkU7VPu8Y
 FGKSOKun2hQ2rp98I/Q1Lo7xZHr8CjI6kyaiMj4Sh4eZzsHn3Uq8nSiUfPkrzd3zWXKgJMXIh
 15kTswAAZEnb5PxeYC5xL+1hRNriDOddZSvkBeAWhSnoJu9O56TwmanPZXDCMYmjJ3OI915kh
 RuzQgBlSNajILJLQgLdNpGZDWEahtedKtMlbVA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver uses mktime() and rtc_time_to_tm() to convert between time
values. This works fine on 64-bit kernels over the whole supported
range, and the vr41xx chip is a 64-bit MIPS implementation, but it is
inconsistent because it doesn't do the same thing on 32-bit kernels that
overflow in 2106 or 2038.

Changing it to use mktime64/rtc_time64_to_tm() should have no visible
impact on vr41xx but gets us closer to removing the 32-bit interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-vr41xx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 7ce22967fd16..480cffe8d321 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -88,7 +88,7 @@ static unsigned int alarm_enabled;
 static int aie_irq;
 static int pie_irq;
 
-static inline unsigned long read_elapsed_second(void)
+static inline time64_t read_elapsed_second(void)
 {
 
 	unsigned long first_low, first_mid, first_high;
@@ -105,10 +105,10 @@ static inline unsigned long read_elapsed_second(void)
 	} while (first_low != second_low || first_mid != second_mid ||
 		 first_high != second_high);
 
-	return (first_high << 17) | (first_mid << 1) | (first_low >> 15);
+	return ((u64)first_high << 17) | (first_mid << 1) | (first_low >> 15);
 }
 
-static inline void write_elapsed_second(unsigned long sec)
+static inline void write_elapsed_second(time64_t sec)
 {
 	spin_lock_irq(&rtc_lock);
 
@@ -121,22 +121,22 @@ static inline void write_elapsed_second(unsigned long sec)
 
 static int vr41xx_rtc_read_time(struct device *dev, struct rtc_time *time)
 {
-	unsigned long epoch_sec, elapsed_sec;
+	time64_t epoch_sec, elapsed_sec;
 
-	epoch_sec = mktime(epoch, 1, 1, 0, 0, 0);
+	epoch_sec = mktime64(epoch, 1, 1, 0, 0, 0);
 	elapsed_sec = read_elapsed_second();
 
-	rtc_time_to_tm(epoch_sec + elapsed_sec, time);
+	rtc_time64_to_tm(epoch_sec + elapsed_sec, time);
 
 	return 0;
 }
 
 static int vr41xx_rtc_set_time(struct device *dev, struct rtc_time *time)
 {
-	unsigned long epoch_sec, current_sec;
+	time64_t epoch_sec, current_sec;
 
-	epoch_sec = mktime(epoch, 1, 1, 0, 0, 0);
-	current_sec = mktime(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
+	epoch_sec = mktime64(epoch, 1, 1, 0, 0, 0);
+	current_sec = mktime64(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
 			     time->tm_hour, time->tm_min, time->tm_sec);
 
 	write_elapsed_second(current_sec - epoch_sec);
@@ -165,11 +165,11 @@ static int vr41xx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 
 static int vr41xx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 {
-	unsigned long alarm_sec;
+	time64_t alarm_sec;
 	struct rtc_time *time = &wkalrm->time;
 
-	alarm_sec = mktime(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
-			   time->tm_hour, time->tm_min, time->tm_sec);
+	alarm_sec = mktime64(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
+			     time->tm_hour, time->tm_min, time->tm_sec);
 
 	spin_lock_irq(&rtc_lock);
 
-- 
2.9.0
