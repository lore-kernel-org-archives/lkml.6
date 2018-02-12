Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeBLWy3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:54:29 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37578 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeBLWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:37 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 22/45] rtc: ds1343: switch to rtc_register_device
Date: Mon, 12 Feb 2018 23:47:36 +0100
Message-Id: <20180212224759.15999-23-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows for future improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1343.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index b5102cdd7f61..a5a5a363c6e1 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -642,12 +642,15 @@ static int ds1343_probe(struct spi_device *spi)
 	data &= ~(DS1343_OSF | DS1343_IRQF1 | DS1343_IRQF0);
 	regmap_write(priv->map, DS1343_STATUS_REG, data);
 
-	priv->rtc = devm_rtc_device_register(&spi->dev, "ds1343",
-					&ds1343_rtc_ops, THIS_MODULE);
-	if (IS_ERR(priv->rtc)) {
-		dev_err(&spi->dev, "unable to register rtc ds1343\n");
+	priv->rtc = devm_rtc_allocate_device(&spi->dev);
+	if (IS_ERR(priv->rtc))
 		return PTR_ERR(priv->rtc);
-	}
+
+	priv->rtc->ops = &ds1343_rtc_ops;
+
+	res = rtc_register_device(priv->rtc);
+	if (res)
+		return res;
 
 	priv->irq = spi->irq;
 
-- 
2.16.1
