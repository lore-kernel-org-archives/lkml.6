Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3118C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E007261BD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JR7wukCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E007261BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937007AbeF3Kc4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:32:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43070 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936856AbeF3Kcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:32:50 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5UAWmqi064965;
        Sat, 30 Jun 2018 05:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530354768;
        bh=N1O7OjeCgjP4thwXujxIi9rYHNRvlMyt2gg3WTu3sr4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JR7wukCEirID2PgvoWpHbgLZGTh93KAtNsG+f25lMZ3P+QPmri+4ULELUyMjHNq+H
         Caq+9x9w5J3jWtmtuwFZ0NAcGKLIMdajfdw4htquUNmC64T0FHVccwCTvHZLRubBaR
         rM5WAr2c5/tbPLrxOOqz/9/2N8zpqwbm/THkjVrw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWmrg025985;
        Sat, 30 Jun 2018 05:32:48 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 30
 Jun 2018 05:32:47 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 30 Jun 2018 05:32:47 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWd6U013640;
        Sat, 30 Jun 2018 05:32:45 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: [PATCH 2/5] Input: ti_am335x_tsc: Mark TSC device as wakeup source
Date:   Sat, 30 Jun 2018 16:03:15 +0530
Message-ID: <20180630103318.25355-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of TSCADC MFD device, mark TSC as wakeup source and change all
wakeup related PM calls to operate on TSC device.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index b86c1e5fbc11..a4f25a915ffc 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -46,6 +46,7 @@ static const int config_pins[] = {
 struct titsc {
 	struct input_dev	*input;
 	struct ti_tscadc_dev	*mfd_tscadc;
+	struct device		*dev;
 	unsigned int		irq;
 	unsigned int		wires;
 	unsigned int		x_plate_resistance;
@@ -276,7 +277,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	if (status & IRQENB_HW_PEN) {
 		ts_dev->pen_down = true;
 		irqclr |= IRQENB_HW_PEN;
-		pm_stay_awake(ts_dev->mfd_tscadc->dev);
+		pm_stay_awake(ts_dev->dev);
 	}
 
 	if (status & IRQENB_PENUP) {
@@ -286,7 +287,7 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
-			pm_relax(ts_dev->mfd_tscadc->dev);
+			pm_relax(ts_dev->dev);
 		} else {
 			ts_dev->pen_down = true;
 		}
@@ -422,6 +423,7 @@ static int titsc_probe(struct platform_device *pdev)
 	ts_dev->mfd_tscadc = tscadc_dev;
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
+	ts_dev->dev = &pdev->dev;
 
 	err = titsc_parse_dt(pdev, ts_dev);
 	if (err) {
@@ -436,6 +438,8 @@ static int titsc_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
+	device_init_wakeup(&pdev->dev, true);
+
 	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_EOS);
@@ -467,6 +471,7 @@ static int titsc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 err_free_mem:
 	input_free_device(input_dev);
@@ -479,6 +484,7 @@ static int titsc_remove(struct platform_device *pdev)
 	struct titsc *ts_dev = platform_get_drvdata(pdev);
 	u32 steps;
 
+	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 
 	/* total steps followed by the enable mask */
@@ -499,7 +505,7 @@ static int __maybe_unused titsc_suspend(struct device *dev)
 	unsigned int idle;
 
 	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
-	if (device_may_wakeup(tscadc_dev->dev)) {
+	if (device_may_wakeup(dev)) {
 		titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 		idle = titsc_readl(ts_dev, REG_IRQENABLE);
 		titsc_writel(ts_dev, REG_IRQENABLE,
@@ -515,11 +521,11 @@ static int __maybe_unused titsc_resume(struct device *dev)
 	struct ti_tscadc_dev *tscadc_dev;
 
 	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
-	if (device_may_wakeup(tscadc_dev->dev)) {
+	if (device_may_wakeup(dev)) {
 		titsc_writel(ts_dev, REG_IRQWAKEUP,
 				0x00);
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
-		pm_relax(ts_dev->mfd_tscadc->dev);
+		pm_relax(dev);
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-- 
2.18.0

