Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9252BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB13206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA6E4JE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB13206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbeKLIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403867AbeKLIWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:54 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B09622419;
        Sun, 11 Nov 2018 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975576;
        bh=g0/YgQDSvhy4z9Tt4YNoAPmR0i9xIzc5x2fg9AqhYQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pA6E4JE6yG3nELQSiWcmeABJDZX7fISMkUS0voH9foPTg1lDJhKgeObHV7jpjXBpH
         An7wTYO5JhJ1z5Nty8u8NdxTRRaK9c1/8ILAiJ6XxceW4a0OCiMj5DXcJSnQqeosNg
         wODuJ9/JdJk1HktygW32ccL/bprJFTCQl0kdLoPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 159/222] iio: ad5064: Fix regulator handling
Date:   Sun, 11 Nov 2018 14:24:16 -0800
Message-Id: <20181111221701.532553252@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/dac/ad5064.c |   53 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 15 deletions(-)

--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -809,6 +809,40 @@ static int ad5064_set_config(struct ad50
 	return ad5064_write(st, cmd, 0, val, 0);
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
+	ret = ad5064_set_config(st, AD5064_CONFIG_INT_VREF_ENABLE);
+	if (ret)
+		dev_err(dev, "Failed to enable internal vref: %d\n", ret);
+
+	return ret;
+}
+
 static int ad5064_probe(struct device *dev, enum ad5064_type type,
 			const char *name, ad5064_write_func write)
 {
@@ -829,22 +863,11 @@ static int ad5064_probe(struct device *d
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
-		ret = ad5064_set_config(st, AD5064_CONFIG_INT_VREF_ENABLE);
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


