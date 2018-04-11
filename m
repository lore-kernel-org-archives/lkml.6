Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeDKOOD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:14:03 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55547 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeDKOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:14:01 -0400
X-Auth-Info: hU56ZblLKw6fdDnRlqep5K3rx8B83O6DzNQbNzPqf8w=
From: Lukasz Majewski <lukma@denx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] input: touchscreen mc13xxx: Make platform data optional
Date: Wed, 11 Apr 2018 16:13:39 +0200
Message-Id: <20180411141340.30939-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The platform data once was optional, make it optional again. This
is a first step towards device tree support for the mc13xxx touchscreen
driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes from the original patch:
- Commit message typo fixes
---
 drivers/input/touchscreen/mc13783_ts.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index ef64f36c5ffc..610f10e6aadf 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -38,7 +38,8 @@ struct mc13783_ts_priv {
 	struct mc13xxx *mc13xxx;
 	struct delayed_work work;
 	unsigned int sample[4];
-	struct mc13xxx_ts_platform_data *touch;
+	u8 ato;
+	bool atox;
 };
 
 static irqreturn_t mc13783_ts_handler(int irq, void *data)
@@ -128,7 +129,7 @@ static void mc13783_ts_work(struct work_struct *work)
 
 	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
 				mode, channel,
-				priv->touch->ato, priv->touch->atox,
+				priv->ato, priv->atox,
 				priv->sample) == 0)
 		mc13783_ts_report_sample(priv);
 }
@@ -172,6 +173,7 @@ static void mc13783_ts_close(struct input_dev *dev)
 static int __init mc13783_ts_probe(struct platform_device *pdev)
 {
 	struct mc13783_ts_priv *priv;
+	struct mc13xxx_ts_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct input_dev *idev;
 	int ret = -ENOMEM;
 
@@ -183,11 +185,10 @@ static int __init mc13783_ts_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&priv->work, mc13783_ts_work);
 	priv->mc13xxx = dev_get_drvdata(pdev->dev.parent);
 	priv->idev = idev;
-	priv->touch = dev_get_platdata(&pdev->dev);
-	if (!priv->touch) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		ret = -ENODEV;
-		goto err_free_mem;
+
+	if (pdata) {
+		priv->atox = pdata->atox;
+		priv->ato = pdata->ato;
 	}
 
 	idev->name = MC13783_TS_NAME;
-- 
2.11.0
