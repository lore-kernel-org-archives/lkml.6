Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E28C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C132C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HwOdDyFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfAXGe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:34:56 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:48652 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAXGez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gKLOeExGCnrigDD9sKoDqYFQ/A9d8sTUINNf2R9diPM=; b=HwOdDyFhMU1bN4NuXj/g2OOSE
        Rg97d8bXYIAGrjQJ2Iq4PQTr3YcKvgf7qzjJkhTRXJsgw8SMQfKHo+bVz+mnD86Hf2Va50JrF5AP0
        5pQHRVPrwxoaoTDmq3S9f3g+eskW9P/TnvAvHcS0OxkR7H8MC6vvoazzKpYwDPreJUB4c=;
Received: from [77.247.85.78] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb9-0000up-G7; Thu, 24 Jan 2019 07:34:47 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb8-0007rU-6q; Thu, 24 Jan 2019 07:34:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 4/5] gnss: sirf: add a separate supply for a lna
Date:   Thu, 24 Jan 2019 07:34:38 +0100
Message-Id: <20190124063439.29897-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190124063439.29897-1-andreas@kemnade.info>
References: <20190124063439.29897-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices might have a separate lna between antenna input of the gps
chip and the antenna which might have a separate supply.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v4:
 - cleaned up error checking
 - was 5/6 earlier

Changes in v3:
 - improved error checking
 - style cleanup

Changes in v2:
 - handle lna also if there is no on-off gpio
 - rebase on changed 2/5

 drivers/gnss/sirf.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index b42a383e26e0..bd6bd9a94c55 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -40,6 +40,7 @@ struct sirf_data {
 	struct serdev_device *serdev;
 	speed_t	speed;
 	struct regulator *vcc;
+	struct regulator *lna;
 	struct gpio_desc *on_off;
 	struct gpio_desc *wakeup;
 	int irq;
@@ -300,21 +301,60 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 static int sirf_runtime_suspend(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret2;
+	int ret;
+
+	if (data->on_off)
+		ret = sirf_set_active(data, false);
+	else
+		ret = regulator_disable(data->vcc);
+
+	if (ret)
+		return ret;
+
+	ret = regulator_disable(data->lna);
+	if (ret)
+		goto err_reenable;
+
+	return 0;
+
+err_reenable:
+	if (data->on_off)
+		ret2 = sirf_set_active(data, true);
+	else
+		ret2 = regulator_enable(data->vcc);
 
-	if (!data->on_off)
-		return regulator_disable(data->vcc);
+	if (ret2)
+		dev_err(dev,
+			"failed to reenable power on failed suspend: %d\n",
+			ret2);
 
-	return sirf_set_active(data, false);
+	return ret;
 }
 
 static int sirf_runtime_resume(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret;
 
-	if (!data->on_off)
-		return regulator_enable(data->vcc);
+	ret = regulator_enable(data->lna);
+	if (ret)
+		return ret;
+
+	if (data->on_off)
+		ret = sirf_set_active(data, true);
+	else
+		ret = regulator_enable(data->vcc);
+
+	if (ret)
+		goto err_disable_lna;
 
-	return sirf_set_active(data, true);
+	return 0;
+
+err_disable_lna:
+	regulator_disable(data->lna);
+
+	return ret;
 }
 
 static int __maybe_unused sirf_suspend(struct device *dev)
@@ -402,6 +442,12 @@ static int sirf_probe(struct serdev_device *serdev)
 		goto err_put_device;
 	}
 
+	data->lna = devm_regulator_get(dev, "lna");
+	if (IS_ERR(data->lna)) {
+		ret = PTR_ERR(data->lna);
+		goto err_put_device;
+	}
+
 	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
 			GPIOD_OUT_LOW);
 	if (IS_ERR(data->on_off))
-- 
2.11.0

