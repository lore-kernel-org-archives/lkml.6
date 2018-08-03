Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AEAC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A83621708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="eyEDEWMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A83621708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbeHCCMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:12:40 -0400
Received: from onstation.org ([52.200.56.107]:34016 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731831AbeHCCMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:39 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 0AED129DD;
        Fri,  3 Aug 2018 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1533255544;
        bh=zEmyRk63i31pd6J5GosQSR2QpWIroWdVDqYkr++V7HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyEDEWMdc6MpWTJFGAaIRjvURVy9xK9yI4DwbrYsGApMM5EHo2N/BVB7UrgXtyK2v
         Zu/En7f7kTYy9HwWXB26s92fLMZ10m1BSwEXa7kJwUKhn4mFjS0v8r5CT+RndA8m0W
         PfeCruMDgdc49lX1bjh0rnWBqJHFtJYMiktBCNLQ=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 3/9] iio: tsl2772: add support for reading proximity led settings from device tree
Date:   Thu,  2 Aug 2018 20:18:54 -0400
Message-Id: <20180803001900.25371-4-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for optionally reading the proximity led diode
and current settings from device tree. This was tested using a LG
Nexus 5 (hammerhead) which requires a different diode than the driver
default for the IR LED.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/tsl2772.c | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index df5b2a0da96c..ae00edf0d87e 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -107,6 +107,8 @@
 #define TSL2772_ALS_GAIN_TRIM_MIN	250
 #define TSL2772_ALS_GAIN_TRIM_MAX	4000
 
+#define TSL2772_MAX_PROX_LEDS		2
+
 /* Device family members */
 enum {
 	tsl2571,
@@ -141,6 +143,14 @@ struct tsl2772_chip_info {
 	const struct iio_info *info;
 };
 
+static const int tsl2772_led_currents[][2] = {
+	{ 100000, TSL2772_100_mA },
+	{  50000, TSL2772_50_mA },
+	{  25000, TSL2772_25_mA },
+	{  13000, TSL2772_13_mA },
+	{      0, 0 }
+};
+
 struct tsl2772_chip {
 	kernel_ulong_t id;
 	struct mutex prox_mutex;
@@ -515,6 +525,75 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
+{
+	struct device_node *of_node = chip->client->dev.of_node;
+	int ret, tmp, i;
+
+	ret = of_property_read_u32(of_node, "led-max-microamp", &tmp);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; tsl2772_led_currents[i][0] != 0; i++) {
+		if (tmp == tsl2772_led_currents[i][0]) {
+			chip->settings.prox_power = tsl2772_led_currents[i][1];
+			return 0;
+		}
+	}
+
+	dev_err(&chip->client->dev, "Invalid value %d for led-max-microamp\n",
+		tmp);
+
+	return -EINVAL;
+
+}
+
+static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
+{
+	struct device_node *of_node = chip->client->dev.of_node;
+	int i, ret, num_leds, prox_diode_mask;
+	u32 leds[TSL2772_MAX_PROX_LEDS];
+
+	ret = of_property_count_u32_elems(of_node, "amstaos,proximity-diodes");
+	if (ret < 0)
+		return ret;
+
+	num_leds = ret;
+	if (num_leds > TSL2772_MAX_PROX_LEDS)
+		num_leds = TSL2772_MAX_PROX_LEDS;
+
+	ret = of_property_read_u32_array(of_node, "amstaos,proximity-diodes",
+					 leds, num_leds);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"Invalid value for amstaos,proximity-diodes: %d.\n",
+			ret);
+		return ret;
+	}
+
+	prox_diode_mask = 0;
+	for (i = 0; i < num_leds; i++) {
+		if (leds[i] == 0)
+			prox_diode_mask |= TSL2772_DIODE0;
+		else if (leds[i] == 1)
+			prox_diode_mask |= TSL2772_DIODE1;
+		else {
+			dev_err(&chip->client->dev,
+				"Invalid value %d in amstaos,proximity-diodes.\n",
+				leds[i]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void tsl2772_parse_dt(struct tsl2772_chip *chip)
+{
+	tsl2772_read_prox_led_current(chip);
+	tsl2772_read_prox_diodes(chip);
+}
+
 /**
  * tsl2772_defaults() - Populates the device nominal operating parameters
  *                      with those provided by a 'platform' data struct or
@@ -541,6 +620,8 @@ static void tsl2772_defaults(struct tsl2772_chip *chip)
 		memcpy(chip->tsl2772_device_lux,
 		       tsl2772_default_lux_table_group[chip->id],
 		       TSL2772_DEFAULT_TABLE_BYTES);
+
+	tsl2772_parse_dt(chip);
 }
 
 /**
-- 
2.17.1

