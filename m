Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD2C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8162073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfBCO3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:29:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55394 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729933AbfBCOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:26 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdE-0006Iy-Lk; Sun, 03 Feb 2019 14:20:24 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006rA-9g; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.199298877@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 050/305] iio: ad5064: Fix regulator handling
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

commit 8911a43bc198877fad9f4b0246a866b26bb547ab upstream.

The correct way to handle errors returned by regualtor_get() and friends is
to propagate the error since that means that an regulator was specified,
but something went wrong when requesting it.

For handling optional regulators, e.g. when the device has an internal
vref, regulator_get_optional() should be used to avoid getting the dummy
regulator that the regulator core otherwise provides.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 3.16: Keep using ad5064_write() instead of
 ad5064_set_config().]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/iio/dac/ad5064.c | 53 ++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -469,6 +469,41 @@ static const char * const ad5064_vref_na
 	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
 }
 
+static int ad5064_request_vref(struct ad5064_state *st, struct device *dev)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ad5064_num_vref(st); ++i)
+		st->vref_reg[i].supply = ad5064_vref_name(st, i);
+
+	if (!st->chip_info->internal_vref)
+		return devm_regulator_bulk_get(dev, ad5064_num_vref(st),
+					       st->vref_reg);
+
+	/*
+	 * This assumes that when the regulator has an internal VREF
+	 * there is only one external VREF connection, which is
+	 * currently the case for all supported devices.
+	 */
+	st->vref_reg[0].consumer = devm_regulator_get_optional(dev, "vref");
+	if (!IS_ERR(st->vref_reg[0].consumer))
+		return 0;
+
+	ret = PTR_ERR(st->vref_reg[0].consumer);
+	if (ret != -ENODEV)
+		return ret;
+
+	/* If no external regulator was supplied use the internal VREF */
+	st->use_internal_vref = true;
+	ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
+		AD5064_CONFIG_INT_VREF_ENABLE, 0);
+	if (ret)
+		dev_err(dev, "Failed to enable internal vref: %d\n", ret);
+
+	return ret;
+}
+
 static int ad5064_probe(struct device *dev, enum ad5064_type type,
 			const char *name, ad5064_write_func write)
 {
@@ -489,23 +524,11 @@ static int ad5064_probe(struct device *d
 	st->dev = dev;
 	st->write = write;
 
-	for (i = 0; i < ad5064_num_vref(st); ++i)
-		st->vref_reg[i].supply = ad5064_vref_name(st, i);
+	ret = ad5064_request_vref(st, dev);
+	if (ret)
+		return ret;
 
-	ret = devm_regulator_bulk_get(dev, ad5064_num_vref(st),
-		st->vref_reg);
-	if (ret) {
-		if (!st->chip_info->internal_vref)
-			return ret;
-		st->use_internal_vref = true;
-		ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
-			AD5064_CONFIG_INT_VREF_ENABLE, 0);
-		if (ret) {
-			dev_err(dev, "Failed to enable internal vref: %d\n",
-				ret);
-			return ret;
-		}
-	} else {
+	if (!st->use_internal_vref) {
 		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
 		if (ret)
 			return ret;

