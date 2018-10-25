Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0026ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C862086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOXkfNy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C862086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeJYWsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbeJYWsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:43 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6C52085B;
        Thu, 25 Oct 2018 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476946;
        bh=I2qOR67k4oYVOLRtXMXNqI+Gj5Jz3wU5UJ5s2gl2uss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOXkfNy5F+kOgYRmCEwxz0RHaqPu3YwiJjnV0Aa5iMlo3rayf+Ll4jxuGqBnEH2s/
         r7dW3WskrJ5SjT6/2xcw704BmcdUR5agmiaCpfJ2OsFhItQeFVTRcLNAMaoh1nZLcC
         jhlumbHMxByFDVxy3Q0t/ARPinzg0tLOKkT8l03Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 56/98] iio: adc: Revert "axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL register modifications"
Date:   Thu, 25 Oct 2018 10:13:41 -0400
Message-Id: <20181025141423.213774-56-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 631b010abc5b57009c6a8328f51492665f6ef310 ]

Inheriting the ADC BIAS current settings from the BIOS instead of
hardcoding then causes the AXP288 to disable charging (I think it
mis-detects an overheated battery) on at least one model tablet.

So lets go back to hard coding the values, this reverts
commit fa2849e9649b ("iio: adc: axp288: Drop bogus
AXP288_ADC_TS_PIN_CTRL register modifications"), fixing charging not
working on the model tablet in question.

The exact cause is not fully understood, hence the revert to a known working
state.

Cc: stable@vger.kernel.org
Reported-by: Umberto Ixxo <sfumato1977@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/axp288_adc.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 64799ad7ebad..7fd24949c0c1 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -28,6 +28,8 @@
 #include <linux/iio/driver.h>
 
 #define AXP288_ADC_EN_MASK		0xF1
+#define AXP288_ADC_TS_PIN_GPADC		0xF2
+#define AXP288_ADC_TS_PIN_ON		0xF3
 
 enum axp288_adc_id {
 	AXP288_ADC_TS,
@@ -121,6 +123,16 @@ static int axp288_adc_read_channel(int *val, unsigned long address,
 	return IIO_VAL_INT;
 }
 
+static int axp288_adc_set_ts(struct regmap *regmap, unsigned int mode,
+				unsigned long address)
+{
+	/* channels other than GPADC do not need to switch TS pin */
+	if (address != AXP288_GP_ADC_H)
+		return 0;
+
+	return regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
+}
+
 static int axp288_adc_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
 			int *val, int *val2, long mask)
@@ -131,7 +143,16 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_GPADC,
+					chan->address)) {
+			dev_err(&indio_dev->dev, "GPADC mode\n");
+			ret = -EINVAL;
+			break;
+		}
 		ret = axp288_adc_read_channel(val, chan->address, info->regmap);
+		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_ON,
+						chan->address))
+			dev_err(&indio_dev->dev, "TS pin restore\n");
 		break;
 	default:
 		ret = -EINVAL;
@@ -141,6 +162,15 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int axp288_adc_set_state(struct regmap *regmap)
+{
+	/* ADC should be always enabled for internal FG to function */
+	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON))
+		return -EIO;
+
+	return regmap_write(regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
+}
+
 static const struct iio_info axp288_adc_iio_info = {
 	.read_raw = &axp288_adc_read_raw,
 	.driver_module = THIS_MODULE,
@@ -169,7 +199,7 @@ static int axp288_adc_probe(struct platform_device *pdev)
 	 * Set ADC to enabled state at all time, including system suspend.
 	 * otherwise internal fuel gauge functionality may be affected.
 	 */
-	ret = regmap_write(info->regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
+	ret = axp288_adc_set_state(axp20x->regmap);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to enable ADC device\n");
 		return ret;
-- 
2.17.1

