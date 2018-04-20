Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDTQPH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:15:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDTQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:15:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rtc: tps6586x: remove mktime usage
Date: Fri, 20 Apr 2018 18:14:26 +0200
Message-Id: <20180420161433.3721192-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180420161433.3721192-1-arnd@arndb.de>
References: <20180420161433.3721192-1-arnd@arndb.de>
X-Provags-ID: V03:K1:uFk+XX53/Bun0nehYpCnUvhWFTU85ztqI+ZUVYREyY7ClPW/b/m
 dYt+MXwYQY2GDInUkNGWZE5D3jKkkfnMg3q2JdF1GpEvqU/NyZ7W7W8s8/0PC5bmoxU+9Nr
 o0fP/J2pJiQpiSNeM4sCZanRYykTof5qHxjIQv27wp+quVhXDeNWfNfKxhL7Qtsb8eS3/PY
 G3CEZUkV3EqQVQ2kd+EIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f7sSTuXSSpE=:PscYx+5khXoWBuyf9Kwhn0
 NeIp+C3b+2Es1jINxyzosxTkiD10E6MXnSGg4M+us+apa4fg4PSXA73QlQhVe80EXdkT3Kjv9
 i41npYRTsRQbjCipg5VcTBqNlz8drtOUqKAe4zq/21Qd+l/wO4qyE/YdBu3TYJUCjVnOGPIGB
 Dil1zMfYqZhmajD8Atg08VE7DrBLWaCmTHutZdO3ZWUpT25q3DIspwLcJF5yfZj5XNvQpbb6p
 f+Ojq9e0Za4gmbWzf+DZFgrXr5XjmjjV0gOi9WlsJn1yEqgnLKceOvJDIwjVTG7Kn+22TN6HV
 WyeSomVeOhyPxLzKvki03Iu6d5kBjXlVYhW9SR86Oh6CC2Aew60jMTg0B8X4yFFfUek+S1/Qu
 gS8cSEd/0Snoul2EDbN9JdMTXCKDT6pzs4QLlOfeypm4EPmfJ4zFv6mRdzvvkn6CAC9xaGD8n
 33O4Wgo3LFMB0j1Mpi1CH2LTigjzzpgky/uWJAF3FZmWk0mTGg4F91YepTVyBeagwIeX9FN6k
 /0mumc+0kWI4VW1VuKLGI6ijuhDy2WI9TiogYbb+tX6JaWdZwljT0ZliSGOvq2d9cW/ofSHX1
 9dB8cKuOJyThqL3XXLhy/o7iIcxhNprRpBNjvwu/OoCLAPkBg7kfIsxVl2xNp4vhYlYHz8AFp
 N4tEXCwh/V22gr/BALpOptjkKAgJo7YuKHcPNa8VOMkvPssqoZSrxPr6geikRktufm9GwmGEb
 zQ8cn9yb+SJshUAg+NowlUWdc0ow0h6IRe+azw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps6586x use a 64-bit 'epoch_start' value, but then computes that
value using an 'mktime()', which has a smaller range and overflows
in 2106 at the latest. As both the hardware and the subsystem interface
support wider than 32-bit ranges for rtc times here, let's change all
the operations on 'seconds' to time64_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-tps6586x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index d7785ae0a2b4..46a19adf9a96 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -58,7 +58,7 @@ struct tps6586x_rtc {
 	struct rtc_device	*rtc;
 	int			irq;
 	bool			irq_en;
-	unsigned long long	epoch_start;
+	time64_t		epoch_start;
 };
 
 static inline struct device *to_tps6586x_dev(struct device *dev)
@@ -71,7 +71,7 @@ static int tps6586x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long long ticks = 0;
-	unsigned long seconds;
+	time64_t seconds;
 	u8 buff[6];
 	int ret;
 	int i;
@@ -98,11 +98,11 @@ static int tps6586x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long long ticks;
-	unsigned long seconds;
+	time64_t seconds;
 	u8 buff[5];
 	int ret;
 
-	rtc_tm_to_time(tm, &seconds);
+	seconds = rtc_tm_to_time64(tm);
 	if (seconds < rtc->epoch_start) {
 		dev_err(dev, "requested time unsupported\n");
 		return -EINVAL;
@@ -157,7 +157,7 @@ static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
-	unsigned long seconds;
+	time64_t seconds;
 	unsigned long ticks;
 	unsigned long rtc_current_time;
 	unsigned long long rticks = 0;
@@ -166,7 +166,7 @@ static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	int ret;
 	int i;
 
-	rtc_tm_to_time(&alrm->time, &seconds);
+	seconds = rtc_tm_to_time64(&alrm->time);
 
 	if (alrm->enabled && (seconds < rtc->epoch_start)) {
 		dev_err(dev, "can't set alarm to requested time\n");
@@ -213,7 +213,7 @@ static int tps6586x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long ticks;
-	unsigned long seconds;
+	time64_t seconds;
 	u8 buff[3];
 	int ret;
 
@@ -227,7 +227,7 @@ static int tps6586x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	seconds = ticks >> 10;
 	seconds += rtc->epoch_start;
 
-	rtc_time_to_tm(seconds, &alrm->time);
+	rtc_time64_to_tm(seconds, &alrm->time);
 	return 0;
 }
 
@@ -261,7 +261,7 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 	rtc->irq = platform_get_irq(pdev, 0);
 
 	/* Set epoch start as 00:00:00:01:01:2009 */
-	rtc->epoch_start = mktime(2009, 1, 1, 0, 0, 0);
+	rtc->epoch_start = mktime64(2009, 1, 1, 0, 0, 0);
 
 	/* 1 kHz tick mode, enable tick counting */
 	ret = tps6586x_update(tps_dev, RTC_CTRL,
-- 
2.9.0
