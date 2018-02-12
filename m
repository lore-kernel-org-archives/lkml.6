Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933266AbeBLWwn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:52:43 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37594 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeBLWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:46 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 39/45] rtc: stk17ta8: fix possible race condition
Date: Mon, 12 Feb 2018 23:47:53 +0100
Message-Id: <20180212224759.15999-40-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-stk17ta8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index f936accf622f..1d6febbe7d39 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -334,11 +334,11 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 
 	pdata->rtc->ops = &stk17ta8_rtc_ops;
 
-	ret = rtc_register_device(pdata->rtc);
+	ret = sysfs_create_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_bin_file(&pdev->dev.kobj, &stk17ta8_nvram_attr);
+	ret = rtc_register_device(pdata->rtc);
 
 	return ret;
 }
-- 
2.16.1
