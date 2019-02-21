Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EA32077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DoFpGSDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfBURDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:06 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.173]:28493 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBURDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768579;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uN2R+Bp3hLSDrzisYlD3VTQSLxI7298D5STEY1XzS8U=;
        b=DoFpGSDKH8n+PD7z6DcoMthhFKdi7Kb1MC2s79Sv9zv59+OWaaPx0Gk0lFhUTewQlm
        KlUVVW5ENRoRrdveT6hX+PvLhGfVCjO4guJniG9FtPk5aFvZY0BWwygfy8HJtt11iM4/
        HWjtlOO54J2zVo6ChLw2awF5d6LBqgQW9vpILHmVkW8d73gbwTN71kkH3Ga8B8p/C9JA
        lVp1XwtSUmfW47TNvzNc3v122J1bIZ73efsox319wCkYV1mBB0irGSFuNdxqDTPfmmC/
        CsIC7dPIvMOD4EKwWI4vKXqlHGjgoDC563ZMoQ0/fpg5TRwYv4rax4MWV/VUEyFg4DsE
        Cn6A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH2xLXF
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:02:59 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] iio: accel: bma180: add mount matrix support
Date:   Thu, 21 Feb 2019 18:02:49 +0100
Message-Id: <39eb050ab5ba5a10f624f95f2bf4582e4e7ccbde.1550768574.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
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
 drivers/iio/accel/bma180.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index cb9765a3de60..f9720a1e8a7c 100644
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
@@ -561,6 +562,15 @@ static int bma180_set_power_mode(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static const struct iio_mount_matrix *
+bma180_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan)
+{
+	struct bma180_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static const struct iio_enum bma180_power_mode_enum = {
 	.items = bma180_power_modes,
 	.num_items = ARRAY_SIZE(bma180_power_modes),
@@ -571,7 +581,8 @@ static const struct iio_enum bma180_power_mode_enum = {
 static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
 	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
-	{ },
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
+	{ }
 };
 
 #define BMA180_ACC_CHANNEL(_axis, _bits) {				\
@@ -722,6 +733,11 @@ static int bma180_probe(struct i2c_client *client,
 		chip = id->driver_data;
 	data->part_info = &bma180_part_info[chip];
 
+	ret = iio_read_mount_matrix(&client->dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	ret = data->part_info->chip_config(data);
 	if (ret < 0)
 		goto err_chip_disable;
-- 
2.19.1

