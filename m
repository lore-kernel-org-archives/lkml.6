Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53670ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A17D20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rmjGQdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A17D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbeKIHm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbeKIHmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A4D20844;
        Thu,  8 Nov 2018 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714723;
        bh=Se+WEDEEOTNvaZuD2yTvFk4An51bNGl371jth/a8gAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rmjGQdTjjnJoIh0cQDycjm0GVgw5CTkEPdM6h/+F/W0JdQZbhxWV+nLibAzvlljG
         hKIdSctWLULVsGTeOcBPQR+EYgNbY4RiNrnWJSSGu0rGjlt/lKOTmj1G6ofrWdlOeJ
         Lx3uQZim07Wi40C9grq+hS7xhIdQqi8VqZSCLBco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Umberto Ixxo <sfumato1977@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 086/171] iio: adc: Revert "axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL register modifications"
Date:   Thu,  8 Nov 2018 13:50:56 -0800
Message-Id: <20181108215133.680455174@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



