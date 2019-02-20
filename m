Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9853AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DC320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfBTOBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:01:02 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:25224 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfBTOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:01:02 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE0xEqW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:00:59 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] iio: accel: bma180: add mount matrix support
Date:   Wed, 20 Feb 2019 15:00:51 +0100
Message-Id: <445e2cafb4c741859219830bc1204bb3cb87f152.1550671256.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to read a mount-matrix device tree
property and report to user-space or in-kernel iio
clients.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/accel/bma180.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index cb9765a3de60..248be67e4f41 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -116,6 +116,7 @@ struct bma180_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	const struct bma180_part_info *part_info;
+	struct iio_mount_matrix orientation;
 	struct mutex mutex;
 	bool sleep_state;
 	int scale;
@@ -561,6 +562,13 @@ static int bma180_set_power_mode(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static const struct iio_mount_matrix *
+bma180_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan)
+{
+	return &((struct bma180_data *)iio_priv(indio_dev))->orientation;
+}
+
 static const struct iio_enum bma180_power_mode_enum = {
 	.items = bma180_power_modes,
 	.num_items = ARRAY_SIZE(bma180_power_modes),
@@ -571,6 +579,7 @@ static const struct iio_enum bma180_power_mode_enum = {
 static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
 	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
 	{ },
 };
 
@@ -722,6 +731,11 @@ static int bma180_probe(struct i2c_client *client,
 		chip = id->driver_data;
 	data->part_info = &bma180_part_info[chip];
 
+	ret = of_iio_read_mount_matrix(&client->dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	ret = data->part_info->chip_config(data);
 	if (ret < 0)
 		goto err_chip_disable;
-- 
2.19.1

