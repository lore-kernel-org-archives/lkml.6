Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D04C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E652084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="r8DwQJuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfBURDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:04 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:17816 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBURDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768579;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=//btGGaAqs4z3lpgjAd0R0OMrIOkVfOP9OUmFGNPP7M=;
        b=r8DwQJuCm8tT5H6HvWXbtdLJQXrpoK58VTR7wX5b1/st+FDAseGuS0v1Wr1DZrDO/A
        QI4lwPPxmRkyIUFG74JVdzgOhcnmi0eYGVhORbv+hUswxJOz8rNxBbQ3sQfJLENfujJr
        d6QJ12bsCNvAfQTp9w9sJe9KKTV/U6c3lDM9AHoeGXEAoVuXlOHe17TTlVqTAYf3sZal
        6OW7NqW+SlTJOxGUSyMkxmZJQPIBdlorhXoNN425Zu0711iDGxDw/+SZNvmJ0SucA1Oj
        qDBjpwi+MVQyF919tPBc9uLzsKkwQg4PF6gNetW4FQNoLkw4iZsdemi5Q+bItSw+d4OS
        RTWQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH2wLXE
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Feb 2019 18:02:58 +0100 (CET)
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
Subject: [PATCH v2 03/10] iio: accel: bmc150: add mount matrix support
Date:   Thu, 21 Feb 2019 18:02:48 +0100
Message-Id: <5d256b403997704072ea5f5889a63adfe67b3a86.1550768574.git.hns@goldelico.com>
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
 drivers/iio/accel/bmc150-accel-core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 383c802eb5b8..b4e2d9b04e1d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -204,6 +204,7 @@ struct bmc150_accel_data {
 	int ev_enable_state;
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
+	struct iio_mount_matrix orientation;
 };
 
 static const struct {
@@ -796,6 +797,20 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 	return sprintf(buf, "%d\n", state);
 }
 
+static const struct iio_mount_matrix *
+bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan)
+{
+	struct bmc150_accel_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_accel_get_mount_matrix),
+	{ }
+};
+
 static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
 static IIO_CONST_ATTR(hwfifo_watermark_max,
 		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
@@ -978,6 +993,7 @@ static const struct iio_event_spec bmc150_accel_event = {
 		.shift = 16 - (bits),					\
 		.endianness = IIO_LE,					\
 	},								\
+	.ext_info = bmc150_accel_ext_info,				\
 	.event_spec = &bmc150_accel_event,				\
 	.num_event_specs = 1						\
 }
@@ -1555,6 +1571,11 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	data->regmap = regmap;
 
+	ret = iio_read_mount_matrix(dev, "mount-matrix",
+				     &data->orientation);
+	if (ret)
+		return ret;
+
 	ret = bmc150_accel_chip_init(data);
 	if (ret < 0)
 		return ret;
-- 
2.19.1

