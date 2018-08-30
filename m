Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7CCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E520835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="HNKYf96p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1E520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeHaBXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:23:20 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21459 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeHaBXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1535663926; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=nqBn4O9y3UzaYLwQptixUtBnqUUyGwR9q0B+RD+YwTnW50QfX+RDYyActB9qCMuesefOOk9w1vcxBIeFMAasEZYCS+ywNeo+iPkqd0FmCvvH7Ko2VosD3Wgn+7dduF5aHBNmRX2eG13vLLtGqgsRYS2aGG3SiecWlNztYEBiW5k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1535663926; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=eAW5An9RCuJprFAy43ywmA8+nBK2HExgCGNyQWS/1tU=; 
        b=HV3Fw+4fp2YWaomyNuOEc+IWUyFi/v6LKzQWR8yVDmeteVp1/DuG0nqb56LkXdatHzgspM2kSnnlpHrGTF32BBuruDT7y5m8+P4iRvyJaz4F8l1YiAaJn3DMDKCKKjuOtBVs9OALHSwq9KHeqk4iYXDyKPDxJDr1jbek+wC/tx4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1535663926;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=6554; bh=eAW5An9RCuJprFAy43ywmA8+nBK2HExgCGNyQWS/1tU=;
        b=HNKYf96pbtLydtC1U9kJWWS33f0Vp9zhjqZCBosF/3Olezzrib1BTmuWLyEtI7Yk
        qziSmsXTdEPR2T4jsUyNLFlgpkvwgCVJD495zmdWsmUFV7n/phjY7wqV1yLCzyQ+lu0
        +Ba1B0FFrNEpTWGpt/R8XFSzeNgSFhTA65/d2vcY=
Received: from localhost (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1535663925528538.8302636866927; Thu, 30 Aug 2018 14:18:45 -0700 (PDT)
From:   Afonso Bordado <afonsobordado@az8.co>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] iio: fxas21002c: add ODR/Scale support
Date:   Thu, 30 Aug 2018 22:18:24 +0100
Message-Id: <20180830211825.12202-3-afonsobordado@az8.co>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830211825.12202-1-afonsobordado@az8.co>
References: <20180830211825.12202-1-afonsobordado@az8.co>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for reading/writing ODR/Scale

We don't support the scale boost modes.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 drivers/iio/gyro/fxas21002c.c | 161 +++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index 7471e9b80010..b3f18d984e81 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -7,7 +7,7 @@
  * IIO driver for FXAS21002C (7-bit I2C slave address 0x20 or 0x21).
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
- *        ODR / Scale Support
+ *        Scale boost mode
  *        Power management
  *        GPIO Reset
  *        Power supplies
@@ -43,7 +43,10 @@
 #define FXAS21002C_REG_F_EVENT         0x0A
 #define FXAS21002C_REG_INT_SRC_FLAG    0x0B
 #define FXAS21002C_REG_WHO_AM_I        0x0C
+
 #define FXAS21002C_REG_CTRL_REG0       0x0D
+#define FXAS21002C_SCALE_MASK          GENMASK(1, 0)
+
 #define FXAS21002C_REG_RT_CFG          0x0E
 #define FXAS21002C_REG_RT_SRC          0x0F
 #define FXAS21002C_REG_RT_THS          0x10
@@ -55,14 +58,12 @@
 #define FXAS21002C_ACTIVE_BIT          BIT(1)
 #define FXAS21002C_READY_BIT           BIT(0)
 
+#define FXAS21002C_ODR_SHIFT           2
+#define FXAS21002C_ODR_MASK            GENMASK(4, 2)
+
 #define FXAS21002C_REG_CTRL_REG2       0x14
 #define FXAS21002C_REG_CTRL_REG3       0x15
 
-#define FXAS21002C_DEFAULT_ODR_HZ      800
-
-/* 0.0625 deg/s */
-#define FXAS21002C_DEFAULT_SENSITIVITY IIO_DEGREE_TO_RAD(62500)
-
 #define FXAS21002C_TEMP_SCALE          1000
 
 enum fxas21002c_id {
@@ -81,6 +82,40 @@ struct fxas21002c_data {
 	struct regmap *regmap;
 };
 
+enum fxas21002c_scale {
+	FXAS21002C_SCALE_62MDPS,
+	FXAS21002C_SCALE_31MDPS,
+	FXAS21002C_SCALE_15MDPS,
+	FXAS21002C_SCALE_7MDPS,
+};
+
+static const int fxas21002c_anglevel_scale_avail[4][2] = {
+	[FXAS21002C_SCALE_62MDPS] = { 0, IIO_DEGREE_TO_RAD(62500) },
+	[FXAS21002C_SCALE_31MDPS] = { 0, IIO_DEGREE_TO_RAD(31250) },
+	[FXAS21002C_SCALE_15MDPS] = { 0, IIO_DEGREE_TO_RAD(15625) },
+	[FXAS21002C_SCALE_7MDPS]  = { 0, IIO_DEGREE_TO_RAD(7812) },
+};
+
+enum fxas21002c_odr {
+	FXAS21002C_ODR_800,
+	FXAS21002C_ODR_400,
+	FXAS21002C_ODR_200,
+	FXAS21002C_ODR_100,
+	FXAS21002C_ODR_50,
+	FXAS21002C_ODR_25,
+	FXAS21002C_ODR_12_5,
+};
+
+static const int fxas21002c_sample_freq_avail[7][2] = {
+	[FXAS21002C_ODR_800]  = { 800, 0 },
+	[FXAS21002C_ODR_400]  = { 400, 0 },
+	[FXAS21002C_ODR_200]  = { 200, 0 },
+	[FXAS21002C_ODR_100]  = { 100, 0 },
+	[FXAS21002C_ODR_50]   = { 50, 0 },
+	[FXAS21002C_ODR_25]   = { 25, 0 },
+	[FXAS21002C_ODR_12_5] = { 12, 500000 },
+};
+
 static const struct regmap_range fxas21002c_writable_ranges[] = {
 	regmap_reg_range(FXAS21002C_REG_F_SETUP, FXAS21002C_REG_F_SETUP),
 	regmap_reg_range(FXAS21002C_REG_CTRL_REG0, FXAS21002C_REG_RT_CFG),
@@ -252,6 +287,49 @@ static int fxas21002c_read_oneshot(struct fxas21002c_data *data,
 	}
 }
 
+static int fxas21002c_scale_read(struct fxas21002c_data *data, int *val,
+				 int *val2)
+{
+	int ret;
+	unsigned int raw;
+
+	ret = regmap_read(data->regmap, FXAS21002C_REG_CTRL_REG0, &raw);
+	if (ret)
+		return ret;
+
+	raw &= FXAS21002C_SCALE_MASK;
+
+	*val = fxas21002c_anglevel_scale_avail[raw][0];
+	*val2 = fxas21002c_anglevel_scale_avail[raw][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int fxas21002c_odr_read(struct fxas21002c_data *data, int *val,
+			       int *val2)
+{
+	int ret;
+	unsigned int raw;
+
+	ret = regmap_read(data->regmap, FXAS21002C_REG_CTRL_REG1, &raw);
+	if (ret)
+		return ret;
+
+	raw = (raw & FXAS21002C_ODR_MASK) >> FXAS21002C_ODR_SHIFT;
+
+	/*
+	 * We don't use this mode but according to the datasheet its
+	 * also a 12.5Hz
+	 */
+	if (raw == 7)
+		raw = FXAS21002C_ODR_12_5;
+
+	*val = fxas21002c_sample_freq_avail[raw][0];
+	*val2 = fxas21002c_sample_freq_avail[raw][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 static int fxas21002c_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan, int *val,
 			       int *val2, long mask)
@@ -264,10 +342,7 @@ static int fxas21002c_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			*val = 0;
-			*val2 = FXAS21002C_DEFAULT_SENSITIVITY;
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			return fxas21002c_scale_read(data, val, val2);
 		case IIO_TEMP:
 			*val = FXAS21002C_TEMP_SCALE;
 
@@ -279,16 +354,76 @@ static int fxas21002c_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_ANGL_VEL)
 			return -EINVAL;
 
-		*val = FXAS21002C_DEFAULT_ODR_HZ;
-
-		return IIO_VAL_INT;
+		return fxas21002c_odr_read(data, val, val2);
 	}
 
 	return -EINVAL;
 }
 
+static int fxas21002c_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int val,
+				int val2, long mask)
+{
+	struct fxas21002c_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(fxas21002c_sample_freq_avail); i++) {
+			if (fxas21002c_sample_freq_avail[i][0] == val &&
+			    fxas21002c_sample_freq_avail[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(fxas21002c_sample_freq_avail))
+			break;
+
+		return regmap_update_bits(data->regmap,
+					  FXAS21002C_REG_CTRL_REG1,
+					  FXAS21002C_ODR_MASK,
+					  i << FXAS21002C_ODR_SHIFT);
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(fxas21002c_anglevel_scale_avail);
+		     i++) {
+			if (fxas21002c_anglevel_scale_avail[i][0] == val &&
+			    fxas21002c_anglevel_scale_avail[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(fxas21002c_anglevel_scale_avail))
+			break;
+
+		return regmap_update_bits(data->regmap,
+					  FXAS21002C_REG_CTRL_REG0,
+					  FXAS21002C_SCALE_MASK, i);
+	}
+
+	return ret;
+}
+
+static IIO_CONST_ATTR(anglevel_scale_available,
+		      "0.001090831 "  /* 62.5    mdps */
+		      "0.000545415 "  /* 31.25   mdps */
+		      "0.000272708 "  /* 15.625  mdps */
+		      "0.000136354"); /*  7.8125 mdps */
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("800 400 200 100 50 25 12.5");
+
+static struct attribute *fxas21002c_attributes[] = {
+	&iio_const_attr_anglevel_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group fxas21002c_attribute_group = {
+	.attrs = fxas21002c_attributes,
+};
+
 static const struct iio_info fxas21002c_info = {
 	.read_raw		= fxas21002c_read_raw,
+	.write_raw              = fxas21002c_write_raw,
+	.attrs                  = &fxas21002c_attribute_group,
 };
 
 static int fxas21002c_probe(struct i2c_client *client,
-- 
2.18.0


