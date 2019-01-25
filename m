Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98018C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695E1218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC+L/fLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAYKE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:04:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35595 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfAYKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:04:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so6951780edx.2;
        Fri, 25 Jan 2019 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvohXcEKajDUL0TBJ4gjZVmzI1Z8Ns4WdfDOcdvTKgA=;
        b=aC+L/fLT5ny3bdPfz9DhqkJBTFLacEzfFtXpV/sDiL8sOgHu8fz4EUggDRMjTjB74D
         hdkhaFc+mKuN6FlPS5WvpifssMxwp+4cW9BcD5f3Q7+sLSI4ZFu8UwovYK22yQWSvW4N
         cbuOjuKPYJ+S4AYQB6A+4TBtdDT68bsbjIpeQ6dmstWXPCkOYGeqJMWxEAddjy87t3Db
         WRJH7JRos/+107/y0XEAfAJQ/81V9FsBHHVBLzfxOAfVxwoirKloViDIbprb8fWExQSm
         g/eEFRqowIY2TME0UJ7cHm2UoIb8UsDqfPaO2wCCinYzS/zWhaxGUH4t59wrBHCYU1kp
         /Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZvohXcEKajDUL0TBJ4gjZVmzI1Z8Ns4WdfDOcdvTKgA=;
        b=F7ztxVY7rjq5ej199fUXMH/KXunNvCXb/tsQGCIAJBiI9eQ/UwjMgKFzOyCi+3b9Bn
         FZTKsyB2rqGCzFoGKA4uLErTfCAkk5gfl55LmPRcMUp6I9sdGId2SSpNUDK/drUZHP4E
         1B1AhEdWNvihgcE3iipSPq+66aCJTEbc4xbpiM2sE6vf8lf12ZBSLNAcWBdlmSlDLDXa
         izf7M8f0ihqkdOQ3PNNvOjxj9Zev7UdVsVoNTfIMD0EFWDZPXV5arpejTWdVXEyZ7wqk
         rOPKRDc/LXmK6n2n33ars1srn5nQXd4ySg6+nANX7Z/80pE8FnADoR9kgEy3XpRJtQtI
         5TIw==
X-Gm-Message-State: AJcUukcju1rMlvBi29tAwIWLxek+2gLBK58dv5eW3k36Xre1Bms+ivbJ
        sljKkVdz/xw5NwimUl1TxsQ=
X-Google-Smtp-Source: ALg8bN6Rv+wK24wNAW/a33aKAOps4d++ftpf/Xmr1wOWj004yCMJD3W5t6LtEfdNh4SdlTC2eGb+Tg==
X-Received: by 2002:a17:906:b292:: with SMTP id q18mr8959462ejz.184.1548410694111;
        Fri, 25 Jan 2019 02:04:54 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id g16sm1181467ejb.65.2019.01.25.02.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:04:52 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH v2] iio: adc: ad7476: Add support for ADS786X ADCs
Date:   Fri, 25 Jan 2019 11:04:51 +0100
Message-Id: <20190125100451.15011-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
ADC.

Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
v2: I have missnamed the devices
 drivers/iio/adc/Kconfig  |  3 ++-
 drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f9354e5ee65c..d86900fc2634 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -64,7 +64,8 @@ config AD7476
 	help
 	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
 	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
-	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
+	  AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
+	  to digital converters (ADC).
 
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

