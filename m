Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDJH0G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:26:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40983 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeDJH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:26:02 -0400
X-Google-Smtp-Source: AIpwx4/9NEbrG4UEU1Kpxizi3Q/9ahCc/W03T6yB6pNSD0OB8enL3BWow36tI7hdfAQzg4EpN9qiuA==
From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Cc: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>,
        Taiyi Wu <taiyity.wu@moxa.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] rtc: tps65910: add bounds checking
Date: Tue, 10 Apr 2018 15:24:17 +0800
Message-Id: <20180410072417.7078-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tm->tm_year is the offset relative to 1900, it needs to check for
positive value to avoid overflow in YEARS_REG register.

The system will hang at the following stage on the next boot when overflow
has occurred.

[    2.221192] systemd[1]: Time has been changed

This patch fixes the above hanging issue by adding bounds checking.

Signed-off-by: Taiyi Wu <taiyity.wu@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
---
 drivers/rtc/rtc-tps65910.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index d0244d7979fc..6be9f7bb0f1b 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -105,6 +105,12 @@ static int tps65910_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct tps65910 *tps = dev_get_drvdata(dev->parent);
 	int ret;
 
+	if ((tm->tm_year - 100) < 0) {
+		dev_err(dev, "the requested year %d is unsupported\n",
+			1900 + tm->tm_year);
+		return -EINVAL;
+	}
+
 	rtc_data[0] = bin2bcd(tm->tm_sec);
 	rtc_data[1] = bin2bcd(tm->tm_min);
 	rtc_data[2] = bin2bcd(tm->tm_hour);
-- 
2.17.0
