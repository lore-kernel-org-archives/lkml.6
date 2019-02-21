Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B359C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C89C2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="PjKKP/Rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfBURDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:24 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:34454 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfBURDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768582;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yL5GvNyfXfc5QJRF7NpJkIoJuarqFd1g+366bCn7ypY=;
        b=PjKKP/RhMJ6Q1niA7pjReNLY7GK9KdocNVAwJuKvVAvVDmtVKW7AZMwRKq12rXIzyG
        cRpAJspD6vXQZhFw5sqD0AC1xYTKImp+a5cvs0I4w09znyevy6YoOKzD1cuZJg91NZNe
        gxCFpjeuts/VfpKeTZOzYvNyBE1IeE7293w1tMHt2Rkn3hsPWS5lPXKzn3HhONPjxrlm
        VKH0x6TDC9aPp744o9fsswPhe02ekGdtgYCmUtuJrjkIw5CGFX7y1GqSV8qmuHHCz3gd
        NBG1xrTBqTQNTvVRpNwNuNoe4cHBVduXuV0OvN3pv2ZYFinzSXpl+9bKJgJziGqBIkpb
        4P8A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH31LXJ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:03:01 +0100 (CET)
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
Subject: [PATCH v2 08/10] iio: magnetometer: hmc5843: add mount matrix support
Date:   Thu, 21 Feb 2019 18:02:53 +0100
Message-Id: <fc3228d92f0c428e96e9925cd28378983596738d.1550768574.git.hns@goldelico.com>
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
 drivers/iio/magnetometer/hmc5843.h      |  1 +
 drivers/iio/magnetometer/hmc5843_core.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index a75224cf99df..e3e22d2508d3 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -43,6 +43,7 @@ struct hmc5843_data {
 	struct mutex lock;
 	struct regmap *regmap;
 	const struct hmc5843_chip_info *variant;
+	struct iio_mount_matrix orientation;
 	__be16 buffer[8];
 };
 
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index ada142fb7aa3..05629ec56d80 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -237,6 +237,15 @@ int hmc5843_set_measurement_configuration(struct iio_dev *indio_dev,
 	return hmc5843_set_meas_conf(data, meas_conf);
 }
 
+static const struct iio_mount_matrix *
+hmc5843_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
+{
+	struct hmc5843_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static const struct iio_enum hmc5843_meas_conf_enum = {
 	.items = hmc5843_meas_conf_modes,
 	.num_items = ARRAY_SIZE(hmc5843_meas_conf_modes),
@@ -247,7 +256,8 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
 static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
 	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
-	{ },
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
+	{ }
 };
 
 static const struct iio_enum hmc5983_meas_conf_enum = {
@@ -260,7 +270,8 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
 static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
 	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
-	{ },
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
+	{ }
 };
 
 static
@@ -635,6 +646,11 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 	data->variant = &hmc5843_chip_info_tbl[id];
 	mutex_init(&data->lock);
 
+	ret = iio_read_mount_matrix(dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->info = &hmc5843_info;
-- 
2.19.1

