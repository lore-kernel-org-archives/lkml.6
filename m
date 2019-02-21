Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23A02084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ffPPfWLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfBURD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:03:57 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:20738 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfBURDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550768581;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Bb4qNjnoSsFX6gssQVbJgzru/6GuCa9xGr0eyLH83FA=;
        b=ffPPfWLkotfHb3HpVXEnLTUKKW1atQgrt81VYDHS8sg3k/psMPjP9/WJPnbjTkhaKs
        WDLwtlh85wN1XZ14A4S6IkqOuD67/lq6D4xEo11lnQQO57tEksxi3E6Rlv/B8MgCl8aT
        RgHM5nAjE/UEcVeDVSlcbI5SiQSHkOxkcK5xI1NZIVI5GuNVBdzqVR1An3cDceFncseE
        2dBEDdoVXOH9mL4mQtZPhyr0POtN+4wMhdaAikoxHbso5RCO0hHsUKRe74gqtkZFD2sv
        k7eMvZ4bFCIlU3lHpCAeJt20PexaEwNIYuoKKGwDECn6oyKnDPCmZO3wUf5ahRG7LT2h
        tszw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2MzNl43D1ri"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1LH31LXI
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
Subject: [PATCH v2 07/10] iio: magnetometer: bmc150: add mount matrix support
Date:   Thu, 21 Feb 2019 18:02:52 +0100
Message-Id: <92f9b04e6540612b8bb8450803df1fcda21e364b.1550768574.git.hns@goldelico.com>
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
 drivers/iio/magnetometer/bmc150_magn.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d91cb845e3d6..b0d8b036d9bb 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -143,6 +143,7 @@ struct bmc150_magn_data {
 	 */
 	struct mutex mutex;
 	struct regmap *regmap;
+	struct iio_mount_matrix orientation;
 	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
 	s32 buffer[6];
 	struct iio_trigger *dready_trig;
@@ -612,6 +613,20 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
 	return len;
 }
 
+static const struct iio_mount_matrix *
+bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	struct bmc150_magn_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmc150_magn_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_magn_get_mount_matrix),
+	{ }
+};
+
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bmc150_magn_show_samp_freq_avail);
 
 static struct attribute *bmc150_magn_attributes[] = {
@@ -638,6 +653,7 @@ static const struct attribute_group bmc150_magn_attrs_group = {
 		.storagebits = 32,					\
 		.endianness = IIO_LE					\
 	},								\
+	.ext_info = bmc150_magn_ext_info,				\
 }
 
 static const struct iio_chan_spec bmc150_magn_channels[] = {
@@ -861,6 +877,11 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	data->irq = irq;
 	data->dev = dev;
 
+	ret = iio_read_mount_matrix(dev, "mount-matrix",
+				&data->orientation);
+	if (ret)
+		return ret;
+
 	if (!name && ACPI_HANDLE(dev))
 		name = bmc150_magn_match_acpi_device(dev);
 
-- 
2.19.1

