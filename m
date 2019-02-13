Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934CD222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083524;
	bh=bOfjkS540hVu8Ua+fahNnjDeFRxIFAw1v3m2TTzRPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OxKyjbKH+cB/CKT8DGvNKnM6cBexbKGgi+tDZzgx6OeKoOKfn9g13z8+nezlYVUqm
	 PtFdaMEiA7lzv5jfnHOWuvI8tTxDIGGvoYq6z/lcT0oetyGYwuerZ3gSieD1B8WI6+
	 UEjnTLgLsHd2kxgORMhVvhmCp8xBIxxprN26DnO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406220AbfBMSpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406203AbfBMSpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEEF20835;
        Wed, 13 Feb 2019 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083515;
        bh=bOfjkS540hVu8Ua+fahNnjDeFRxIFAw1v3m2TTzRPy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F49RWp6kHdST2v2OGNRxl1teHUw8Kx9NdK5oy5LPRMGLqydA6U02oMnhjvVIcbWDU
         JuFJmIr+xz+xPIKecvuxXa5gaLQ10mv03nwYmRofUYJGQ7gEGxJJ1hwjLG+JHBCkRB
         HJZUf2u5cLjK8Ok8q1TCPhRWRODbqkGB3piRxZeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.20 07/50] iio: adc: axp288: Fix TS-pin handling
Date:   Wed, 13 Feb 2019 19:38:12 +0100
Message-Id: <20190213183656.370670564@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 9bcf15f75cac3c6a00d8f8083a635de9c8537799 upstream.

Prior to this commit there were 3 issues with our handling of the TS-pin:

1) There are 2 ways how the firmware can disable monitoring of the TS-pin
for designs which do not have a temperature-sensor for the battery:
a) Clearing bit 0 of the AXP20X_ADC_EN1 register
b) Setting bit 2 of the AXP288_ADC_TS_PIN_CTRL monitoring

Prior to this commit we were unconditionally setting both bits to the
value used on devices with a TS. This causes the temperature protection to
kick in on devices without a TS, such as the Jumper ezbook v2, causing
them to not charge under Linux.

This commit fixes this by using regmap_update_bits when updating these 2
registers, leaving the 2 mentioned bits alone.

The next 2 problems are related to our handling of the current-source
for the TS-pin. The current-source used for the battery temp-sensor (TS)
is shared with the GPADC. For proper fuel-gauge and charger operation the
TS current-source needs to be permanently on. But to read the GPADC we
need to temporary switch the TS current-source to ondemand, so that the
GPADC can use it, otherwise we will always read an all 0 value.

2) Problem 2 is we were writing hardcoded values to the ADC TS pin-ctrl
register, overwriting various other unrelated bits. Specifically we were
overwriting the current-source setting for the TS and GPIO0 pins, forcing
it to 80ųA independent of its original setting. On a Chuwi Vi10 tablet
this was causing us to get a too high adc value (due to a too high
current-source) resulting in the following errors being logged:

ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
ACPI Error: Method parse/execution failed \_SB.SXP1._TMP, AE_ERROR

This commit fixes this by using regmap_update_bits to change only the
relevant bits.

3) After reading the GPADC channel we were unconditionally enabling the
TS current-source even on devices where the TS-pin is not used and the
current-source thus was off before axp288_adc_read_raw call.

This commit fixes this by making axp288_adc_set_ts a nop on devices where
the ADC is not enabled for the TS-pin.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1610545
Fixes: 3091141d7803 ("iio: adc: axp288: Fix the GPADC pin ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/axp288_adc.c |   76 +++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 16 deletions(-)

--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -27,9 +27,18 @@
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
 
-#define AXP288_ADC_EN_MASK		0xF1
-#define AXP288_ADC_TS_PIN_GPADC		0xF2
-#define AXP288_ADC_TS_PIN_ON		0xF3
+/*
+ * This mask enables all ADCs except for the battery temp-sensor (TS), that is
+ * left as-is to avoid breaking charging on devices without a temp-sensor.
+ */
+#define AXP288_ADC_EN_MASK				0xF0
+#define AXP288_ADC_TS_ENABLE				0x01
+
+#define AXP288_ADC_TS_CURRENT_ON_OFF_MASK		GENMASK(1, 0)
+#define AXP288_ADC_TS_CURRENT_OFF			(0 << 0)
+#define AXP288_ADC_TS_CURRENT_ON_WHEN_CHARGING		(1 << 0)
+#define AXP288_ADC_TS_CURRENT_ON_ONDEMAND		(2 << 0)
+#define AXP288_ADC_TS_CURRENT_ON			(3 << 0)
 
 enum axp288_adc_id {
 	AXP288_ADC_TS,
@@ -44,6 +53,7 @@ enum axp288_adc_id {
 struct axp288_adc_info {
 	int irq;
 	struct regmap *regmap;
+	bool ts_enabled;
 };
 
 static const struct iio_chan_spec axp288_adc_channels[] = {
@@ -115,21 +125,33 @@ static int axp288_adc_read_channel(int *
 	return IIO_VAL_INT;
 }
 
-static int axp288_adc_set_ts(struct regmap *regmap, unsigned int mode,
-				unsigned long address)
+/*
+ * The current-source used for the battery temp-sensor (TS) is shared
+ * with the GPADC. For proper fuel-gauge and charger operation the TS
+ * current-source needs to be permanently on. But to read the GPADC we
+ * need to temporary switch the TS current-source to ondemand, so that
+ * the GPADC can use it, otherwise we will always read an all 0 value.
+ */
+static int axp288_adc_set_ts(struct axp288_adc_info *info,
+			     unsigned int mode, unsigned long address)
 {
 	int ret;
 
-	/* channels other than GPADC do not need to switch TS pin */
+	/* No need to switch the current-source if the TS pin is disabled */
+	if (!info->ts_enabled)
+		return 0;
+
+	/* Channels other than GPADC do not need the current source */
 	if (address != AXP288_GP_ADC_H)
 		return 0;
 
-	ret = regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
+	ret = regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
+				 AXP288_ADC_TS_CURRENT_ON_OFF_MASK, mode);
 	if (ret)
 		return ret;
 
 	/* When switching to the GPADC pin give things some time to settle */
-	if (mode == AXP288_ADC_TS_PIN_GPADC)
+	if (mode == AXP288_ADC_TS_CURRENT_ON_ONDEMAND)
 		usleep_range(6000, 10000);
 
 	return 0;
@@ -145,14 +167,14 @@ static int axp288_adc_read_raw(struct ii
 	mutex_lock(&indio_dev->mlock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_GPADC,
+		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON_ONDEMAND,
 					chan->address)) {
 			dev_err(&indio_dev->dev, "GPADC mode\n");
 			ret = -EINVAL;
 			break;
 		}
 		ret = axp288_adc_read_channel(val, chan->address, info->regmap);
-		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_ON,
+		if (axp288_adc_set_ts(info, AXP288_ADC_TS_CURRENT_ON,
 						chan->address))
 			dev_err(&indio_dev->dev, "TS pin restore\n");
 		break;
@@ -164,13 +186,35 @@ static int axp288_adc_read_raw(struct ii
 	return ret;
 }
 
-static int axp288_adc_set_state(struct regmap *regmap)
+static int axp288_adc_initialize(struct axp288_adc_info *info)
 {
-	/* ADC should be always enabled for internal FG to function */
-	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON))
-		return -EIO;
+	int ret, adc_enable_val;
+
+	/*
+	 * Determine if the TS pin is enabled and set the TS current-source
+	 * accordingly.
+	 */
+	ret = regmap_read(info->regmap, AXP20X_ADC_EN1, &adc_enable_val);
+	if (ret)
+		return ret;
+
+	if (adc_enable_val & AXP288_ADC_TS_ENABLE) {
+		info->ts_enabled = true;
+		ret = regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
+					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
+					 AXP288_ADC_TS_CURRENT_ON);
+	} else {
+		info->ts_enabled = false;
+		ret = regmap_update_bits(info->regmap, AXP288_ADC_TS_PIN_CTRL,
+					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
+					 AXP288_ADC_TS_CURRENT_OFF);
+	}
+	if (ret)
+		return ret;
 
-	return regmap_write(regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
+	/* Turn on the ADC for all channels except TS, leave TS as is */
+	return regmap_update_bits(info->regmap, AXP20X_ADC_EN1,
+				  AXP288_ADC_EN_MASK, AXP288_ADC_EN_MASK);
 }
 
 static const struct iio_info axp288_adc_iio_info = {
@@ -200,7 +244,7 @@ static int axp288_adc_probe(struct platf
 	 * Set ADC to enabled state at all time, including system suspend.
 	 * otherwise internal fuel gauge functionality may be affected.
 	 */
-	ret = axp288_adc_set_state(axp20x->regmap);
+	ret = axp288_adc_initialize(info);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to enable ADC device\n");
 		return ret;


