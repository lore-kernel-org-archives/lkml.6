Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeBLWs6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:58 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37600 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933080AbeBLWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:48 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 44/45] rtc: tx4939: fix possible race condition
Date: Mon, 12 Feb 2018 23:47:58 +0100
Message-Id: <20180212224759.15999-45-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function is not allowed to fail after registering the RTC. Call
rtc_register_device() at the end.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tx4939.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 75c3887fbc6c..5a3a6b457b8f 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -289,12 +289,13 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 
 	rtc->ops = &tx4939_rtc_ops;
 
-	ret = rtc_register_device(rtc);
+	ret = sysfs_create_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
 	if (ret)
 		return ret;
 
 	pdata->rtc = rtc;
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
+
+	ret = rtc_register_device(rtc);
 
 	return ret;
 }
-- 
2.16.1
