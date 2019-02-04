Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D68C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52EB2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZZotEbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfBDMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:44:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42853 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfBDMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:44:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so11387633lja.9;
        Mon, 04 Feb 2019 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gUMAsh6yP7V2UHWJxHmkcnfBDrErlHA2Kt7jgGm2SIU=;
        b=UZZotEbVV6VIrtS2vjFCIoLp1/0Gr9i+JiLjZhRvRSRupEQUdIRAoys/EWW55NUEe4
         HMfpbfEMkiet1VuBKRTz1SdusznE0TFh04FO0/Iww58xLcDPtbdy0MjvEt6Hgrfn6uMS
         01Yjfg/Y6PFsrstR14PrtO9cW3WJY8zQpScTUhJD0zG8WRcFGybiPkOyH0HXQwI+GbmX
         LL8T+Fq5SgQ/LRG109Dwo6q2U6xEKb3ABV3/ukamXdx7JuG7to3OgbqZFupoZH8KINam
         cfTEgx/paoFAcc7A0koMEytG3lSmFCQaBb9Slwb3AkpUB+SafldY3C7d9uM4lw7WRMXF
         qsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gUMAsh6yP7V2UHWJxHmkcnfBDrErlHA2Kt7jgGm2SIU=;
        b=Jt1psFW+FGDdqQPRE10xt36X7V9U10QDHLdPPxQjD4HKtID13Qp7TaDpIhLbiuih6m
         l8JPHrgiSZCh+T6iKEziVcGDn/r1NFyWZOTaByUGd29/oHsaetp1H0e7jSUGtWIoGseg
         W/6d2A4X/qW65emZpjG3YYmyo7usGdjc9RAH1zUSsru20GVow/YTY2L9j/fq5G7YCvzK
         5RwNodYVk1F+oLnT/68Ask3+C3/cAPE0VchQf6jkcL1ahSqDa8ZYLgdIbDLMJPzUeUIr
         x9/ivxCrAVBubBTM2g6c1FuL5dfdUtTwwYbwJdqK4NaWwHw0R2sID357e6mdNMbDwHHP
         IiNA==
X-Gm-Message-State: AHQUAuYZrDprrUKJdW5Pifs1Cg8kzNEbK69zfOBVezwd8l/vneg78EDe
        +5tDQHYGyHCyMKDmbKDGyhE=
X-Google-Smtp-Source: AHgI3IaYbf16COfXzO3x19lLnoDwItnBs6O4JmTdOmPD6iAZxlJVvYScnEMGJH7pIQU9cYmTW6NxLQ==
X-Received: by 2002:a2e:85c9:: with SMTP id h9-v6mr3288431ljj.101.1549284284164;
        Mon, 04 Feb 2019 04:44:44 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id s127sm3107091lfe.8.2019.02.04.04.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 04:44:43 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH v4] iio: adc: ad7476: Add support for TI ADS786X ADCs
Date:   Mon,  4 Feb 2019 13:44:41 +0100
Message-Id: <20190204124441.18079-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Texas Instruments ADS7866, ADS7867 and ADS7868
8/10/12 bit Single channel ADC.

Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
v4: Changes by Alexandru Ardelean <ardeleanalex@gmail.com>

Break Kconfig into a table

 drivers/iio/adc/Kconfig  | 11 +++++++----
 drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f9354e5ee65c..3d82727fa977 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -57,14 +57,17 @@ config AD7298
 	  module will be called ad7298.
 
 config AD7476
-	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
+	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD an TI"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
-	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
-	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
+	  Say yes here to build support for the following SPI analog to
+	  digital converters (ADCs):
+	  Analog Devices: AD7273, AD7274, AD7276, AD7277, AD7278, AD7475,
+	  AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495, AD7910,
+	  AD7920.
+	  Texas Instruments: ADS7866, ADS7867, ADS7868.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 0549686b9ef8..76747488044b 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
 	ID_ADC081S,
 	ID_ADC101S,
 	ID_ADC121S,
+	ID_ADS7866,
+	ID_ADS7867,
+	ID_ADS7868,
 };
 
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
@@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
 #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
+#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
+		BIT(IIO_CHAN_INFO_RAW))
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7091R] = {
@@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.channel[0] = ADC081S_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
+	[ID_ADS7866] = {
+		.channel[0] = ADS786X_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADS7867] = {
+		.channel[0] = ADS786X_CHAN(10),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADS7868] = {
+		.channel[0] = ADS786X_CHAN(8),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
 };
 
 static const struct iio_info ad7476_info = {
@@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
 	{"adc081s", ID_ADC081S},
 	{"adc101s", ID_ADC101S},
 	{"adc121s", ID_ADC121S},
+	{"ads7866", ID_ADS7866},
+	{"ads7867", ID_ADS7867},
+	{"ads7868", ID_ADS7868},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
-- 
2.20.1

