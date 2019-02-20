Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA00120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfBTOBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:01:19 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:25731 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfBTOBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:01:07 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE12Eqb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:01:02 +0100 (CET)
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
Subject: [PATCH 9/9] iio: magnetometer: hmc5843: add mount matrix support
Date:   Wed, 20 Feb 2019 15:00:56 +0100
Message-Id: <effcfa7fb13fb8ba2b8b13ab07a6eb86defec77e.1550671256.git.hns@goldelico.com>
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
 drivers/iio/magnetometer/hmc5843.h      |  1 +
 drivers/iio/magnetometer/hmc5843_core.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

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
index ada142fb7aa3..e6b6da70c152 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -237,6 +237,13 @@ int hmc5843_set_measurement_configuration(struct iio_dev *indio_dev,
 	return hmc5843_set_meas_conf(data, meas_conf);
 }
 
+static const struct iio_mount_matrix *
+hmc5843_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
+{
+	return &((struct hmc5843_data *)iio_priv(indio_dev))->orientation;
+}
+
 static const struct iio_enum hmc5843_meas_conf_enum = {
 	.items = hmc5843_meas_conf_modes,
 	.num_items = ARRAY_SIZE(hmc5843_meas_conf_modes),
@@ -247,6 +254,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
 static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
 	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
 	{ },
 };
 
@@ -260,6 +268,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
 static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
 	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
 	{ },
 };
 
@@ -635,6 +644,11 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 	data->variant = &hmc5843_chip_info_tbl[id];
 	mutex_init(&data->lock);
 
+	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->info = &hmc5843_info;
-- 
2.19.1

