Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeEQUxf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:53:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39498 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752062AbeEQUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:53:30 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/3] rtc: ls1x: add range
Date: Thu, 17 May 2018 22:53:27 +0200
Message-Id: <20180517205327.29150-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517205327.29150-1-alexandre.belloni@bootlin.com>
References: <20180517205327.29150-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the year in encoded on 32 bits in SYS_TOYWRITE1i/SYS_TOYREAD1. The
Loongson 1c datasheet states that the range is from 0 to 99.

The current code exceeds this range and seems to be working, I deduce that
the leap year algorithm will fail in 2100.

Anyway, alarm registers only encode the year on 14 bits so with alarm
support, the range will always be limited to 0 to 16383.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ls1x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 8aa3f223621c..f4c248655edd 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -177,6 +177,8 @@ static int ls1x_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtcdev);
 	rtcdev->ops = &ls1x_rtc_ops;
+	rtcdev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtcdev->range_max = RTC_TIMESTAMP_END_2099;
 
 	return rtc_register_device(rtcdev);
 }
-- 
2.17.0
