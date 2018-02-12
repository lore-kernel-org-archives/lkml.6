Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeBLWsv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:51 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37579 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeBLWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:37 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 25/45] rtc: m48t59: switch to rtc_register_device
Date: Mon, 12 Feb 2018 23:47:39 +0100
Message-Id: <20180212224759.15999-26-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m48t59.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index d99a705bec07..e248e56ff8a1 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -480,11 +480,16 @@ static int m48t59_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&m48t59->lock);
 	platform_set_drvdata(pdev, m48t59);
 
-	m48t59->rtc = devm_rtc_device_register(&pdev->dev, name, ops,
-						THIS_MODULE);
+	m48t59->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(m48t59->rtc))
 		return PTR_ERR(m48t59->rtc);
 
+	m48t59->rtc->ops = ops;
+
+	ret = rtc_register_device(m48t59->rtc);
+	if (ret)
+		return ret;
+
 	m48t59_nvram_attr.size = pdata->offset;
 
 	ret = sysfs_create_bin_file(&pdev->dev.kobj, &m48t59_nvram_attr);
-- 
2.16.1
