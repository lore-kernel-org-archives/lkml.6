Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E47C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7512083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7512083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeJBUKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbeJBUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:53 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C2FA7BF0;
        Tue,  2 Oct 2018 13:27:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 062/228] iio: accel: adxl345: convert address field usage in iio_chan_spec
Date:   Tue,  2 Oct 2018 06:22:39 -0700
Message-Id: <20181002132503.472398918@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 9048f1f18a70a01eaa3c8e7166fdb2538929d780 ]

Currently the address field in iio_chan_spec is filled with an accel
data register address for the corresponding axis.

In preparation for adding calibration offset support, this sets the
address field to the index of accel data registers instead of the actual
register address.

This change makes it easier to access both accel registers and
calibration offset registers with fewer lines of code as these are
located in X-axis, Y-axis, Z-axis order.

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adxl345_core.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -21,6 +21,8 @@
 #define ADXL345_REG_DATAX0		0x32
 #define ADXL345_REG_DATAY0		0x34
 #define ADXL345_REG_DATAZ0		0x36
+#define ADXL345_REG_DATA_AXIS(index)	\
+	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
 
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
@@ -47,19 +49,19 @@ struct adxl345_data {
 	u8 data_range;
 };
 
-#define ADXL345_CHANNEL(reg, axis) {					\
+#define ADXL345_CHANNEL(index, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.address = reg,							\
+	.address = index,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 }
 
 static const struct iio_chan_spec adxl345_channels[] = {
-	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
-	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
-	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
+	ADXL345_CHANNEL(0, X),
+	ADXL345_CHANNEL(1, Y),
+	ADXL345_CHANNEL(2, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -67,7 +69,7 @@ static int adxl345_read_raw(struct iio_d
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
-	__le16 regval;
+	__le16 accel;
 	int ret;
 
 	switch (mask) {
@@ -77,12 +79,13 @@ static int adxl345_read_raw(struct iio_d
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
-		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
-				       sizeof(regval));
+		ret = regmap_bulk_read(data->regmap,
+				       ADXL345_REG_DATA_AXIS(chan->address),
+				       &accel, sizeof(accel));
 		if (ret < 0)
 			return ret;
 
-		*val = sign_extend32(le16_to_cpu(regval), 12);
+		*val = sign_extend32(le16_to_cpu(accel), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;


