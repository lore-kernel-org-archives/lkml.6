Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A82C6778D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB63E2623C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IKjNdOhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63E2623C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030353AbeF3KdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:33:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43084 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936984AbeF3Kcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:32:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5UAWr6s064989;
        Sat, 30 Jun 2018 05:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530354773;
        bh=lYNNUbLaIK0CIjMdPe1FlHZIXE09WE717aCO4DbSvVk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IKjNdOhlxmeXdTVN6frtSMfuBpZByF3FDuRM99W1e9aV+7U5khKWcyUtX6KxkWG9W
         +JnMy0AI9OtuU0Vx2jaU8ACUubW1mkE9iMILSOSE69SqpMfpwynLTZRxP2DSTv71Ii
         8b/KEGL8L2kAtJF1yNlUCJ2zBXo462pRfnCBQLR0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWr9M020357;
        Sat, 30 Jun 2018 05:32:53 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 30
 Jun 2018 05:32:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 30 Jun 2018 05:32:52 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWd6W013640;
        Sat, 30 Jun 2018 05:32:50 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
Date:   Sat, 30 Jun 2018 16:03:17 +0530
Message-ID: <20180630103318.25355-5-vigneshr@ti.com>
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

Parent MFD device takes care of enabling ADC interface whenever
touchscreen is marked wakeup capable. Therefore, unconditionally disable
ADC interface during system suspend to save power in case of system with
just ADC and no TSC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 80df5a377d30..cafb1dcadc48 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -693,16 +693,12 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	struct ti_tscadc_dev *tscadc_dev;
 	unsigned int idle;
 
-	tscadc_dev = ti_tscadc_dev_get(to_platform_device(dev));
-	if (!device_may_wakeup(tscadc_dev->dev)) {
-		idle = tiadc_readl(adc_dev, REG_CTRL);
-		idle &= ~(CNTRLREG_TSCSSENB);
-		tiadc_writel(adc_dev, REG_CTRL, (idle |
-				CNTRLREG_POWERDOWN));
-	}
+	idle = tiadc_readl(adc_dev, REG_CTRL);
+	idle &= ~(CNTRLREG_TSCSSENB);
+	tiadc_writel(adc_dev, REG_CTRL, (idle |
+			CNTRLREG_POWERDOWN));
 
 	return 0;
 }
-- 
2.18.0

