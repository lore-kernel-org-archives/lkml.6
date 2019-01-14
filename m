Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F471C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058772070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXgs1FX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfANRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:25:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33433 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfANRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:25:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so7890098wmh.0;
        Mon, 14 Jan 2019 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b6soLP5EAlQ812DfEmZHunfsM5OuUsZ6ew8aX6zdqi0=;
        b=uXgs1FX8xIy/7CDVoWDtw7uJfoLeN8X4W/WEt6fojOHzT3YVqViuWh53ycrc3Wf+SH
         rd9AFe3+/4SK/WoZDjKYlW2hkaMeE0X3ecXgs/gouk5rgJU0HHpP1AHLuhLzY9L4va2Y
         2ndxIWEJ85iaj+m2hSwGkxXvC8GXenc2KKi8a8vk0C8ed8RNBgHgCAstE2pMORnAOOXM
         iv4Z48JwZLR3wMaGxToNtfD/6PPD/In6FnrqA1mdEHnQDwcwkpbGOmarOVHT3y0mn+L3
         hp+xEGVFPXEktJEzEZ29a2wa2tDtzlLoYLHLe3ULoXBiNlEhlva5QKZHWSa/v0vIkd10
         22uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6soLP5EAlQ812DfEmZHunfsM5OuUsZ6ew8aX6zdqi0=;
        b=XQIrRbBJSflGhkWiRAa30dE+k4mPpGck75cEXOIPFzjjsiIN4rYePM8SgEWVwdna3F
         trOwo2KLvkeephwN23Iba5pxPoClzHetXiTPW4BlxFqqxTJdxrZVdwotCp1M4+tqBWli
         zDnH/2nLbAVsd/eTCdZQ4TPfZBYymtmOTuAtbj2rUOcbp03XcgSI7DXKvkxfKbFhTNQG
         UUunYBJCS3GO06C9uynoTQODICvojYmOWCPQetVzVpKaSrpdlOFw2lE3j93by06tr8V2
         D+XAFxSe3TMJaa7au2vD+ZtV5dLxMM7iBhVlM+RauwXnBmOWM8q6eRWUSobEY2O4k+aJ
         5kdA==
X-Gm-Message-State: AJcUukfiDHlOs0BRodrps1rznJpvMFEtwdJibZ+0KwOHRUT1t/JVmJVG
        fD+Z3JLm9SSYFjB11a1juow=
X-Google-Smtp-Source: ALg8bN53HGKSEpkD6uyQk9hcU9Dw/Tx+9Mqj5z2rLfJfWWtuItRgm7eUwn4qjCHajYwhed7bm6BNlw==
X-Received: by 2002:a1c:541a:: with SMTP id i26mr147654wmb.128.1547486704677;
        Mon, 14 Jan 2019 09:25:04 -0800 (PST)
Received: from ctocxl0004.cto.st.com ([37.162.94.7])
        by smtp.gmail.com with ESMTPSA id n82sm28476124wma.42.2019.01.14.09.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 09:25:03 -0800 (PST)
From:   Mario Tesi <martepisa@gmail.com>
X-Google-Original-From: Mario Tesi <mario.tesi@st.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.tesi@st.com
Subject: [PATCH] iio:st_pressure:initial lps22hh sensor support
Date:   Mon, 14 Jan 2019 18:24:20 +0100
Message-Id: <1547486660-15359-1-git-send-email-mario.tesi@st.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mario tesi <mario.tesi@st.com>

Initial support for ST LPS22HH pressure sensor. Datasheet:
http://www2.st.com/resource/en/datasheet/lps22hh.pdf

Features:
 * pressure, temperature data and timestamping channels
 * sampling frequency selection [1..200] Hz
 * interrupt based trigger
 * over I2C or SPI interface

Signed-off-by: mario tesi <mario.tesi@st.com>
---
 drivers/iio/pressure/Kconfig            |  2 +-
 drivers/iio/pressure/st_pressure.h      |  2 +
 drivers/iio/pressure/st_pressure_core.c | 69 +++++++++++++++++++++++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c  |  5 +++
 drivers/iio/pressure/st_pressure_spi.c  |  5 +++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index eaa7cfc..efeb89f 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -165,7 +165,7 @@ config IIO_ST_PRESS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics pressure
-	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB.
+	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB, LPS22HH.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index e67eb0d..5794660 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -21,6 +21,7 @@ enum st_press_type {
 	LPS22HB,
 	LPS33HW,
 	LPS35HW,
+	LPS22HH,
 	ST_PRESS_MAX,
 };
 
@@ -30,6 +31,7 @@ enum st_press_type {
 #define LPS22HB_PRESS_DEV_NAME		"lps22hb"
 #define LPS33HW_PRESS_DEV_NAME		"lps33hw"
 #define LPS35HW_PRESS_DEV_NAME		"lps35hw"
+#define LPS22HH_PRESS_DEV_NAME		"lps22hh"
 
 /**
  * struct st_sensors_platform_data - default press platform data
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 4ddb6cf..38dcdb7 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -492,6 +492,75 @@
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
+	{
+		/*
+		 * CUSTOM VALUES FOR LPS22HH SENSOR
+		 * See LPS22HH datasheet:
+		 * http://www2.st.com/resource/en/datasheet/lps22hh.pdf
+		 */
+		.wai = 0xb3,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LPS22HH_PRESS_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
+		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
+		.odr = {
+			.addr = 0x10,
+			.mask = 0x70,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01 },
+				{ .hz = 10, .value = 0x02 },
+				{ .hz = 25, .value = 0x03 },
+				{ .hz = 50, .value = 0x04 },
+				{ .hz = 75, .value = 0x05 },
+				{ .hz = 100, .value = 0x06 },
+				{ .hz = 200, .value = 0x07 },
+			},
+		},
+		.pw = {
+			.addr = 0x10,
+			.mask = 0x70,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.fs = {
+			.fs_avl = {
+				/*
+				 * Pressure and temperature sensitivity values
+				 * as defined in table 3 of LPS22HH datasheet.
+				 */
+				[0] = {
+					.num = ST_PRESS_FS_AVL_1260MB,
+					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
+					.gain2 = ST_PRESS_LPS22HB_LSB_PER_CELSIUS,
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x10,
+			.mask = BIT(1),
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x12,
+				.mask = BIT(2),
+				.addr_od = 0x11,
+				.mask_od = BIT(5),
+			},
+			.addr_ihl = 0x11,
+			.mask_ihl = BIT(6),
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x03,
+			},
+		},
+		.sim = {
+			.addr = 0x10,
+			.value = BIT(0),
+		},
+		.multi_read_bit = false,
+		.bootime = 2,
+	},
 };
 
 static int st_press_write_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 2026a10..a60849d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -45,6 +45,10 @@
 		.compatible = "st,lps35hw",
 		.data = LPS35HW_PRESS_DEV_NAME,
 	},
+	{
+		.compatible = "st,lps22hh",
+		.data = LPS22HH_PRESS_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
@@ -69,6 +73,7 @@
 	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
 	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
 	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
+	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 9a3441b..79a12ed 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -49,6 +49,10 @@
 		.compatible = "st,lps35hw",
 		.data = LPS35HW_PRESS_DEV_NAME,
 	},
+	{
+		.compatible = "st,lps22hh",
+		.data = LPS22HH_PRESS_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
@@ -93,6 +97,7 @@ static int st_press_spi_remove(struct spi_device *spi)
 	{ LPS22HB_PRESS_DEV_NAME },
 	{ LPS33HW_PRESS_DEV_NAME },
 	{ LPS35HW_PRESS_DEV_NAME },
+	{ LPS22HH_PRESS_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_press_id_table);
-- 
1.9.1

