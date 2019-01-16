Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17520C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F0720840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GSFLxpWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfAPVS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:18:56 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55584 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfAPVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JOfMVAOXKfX7faGG0NTzeUEvAQuesgUG1fLuu4NCrGI=; b=GSFLxpWVgTRsKDrh4sk5pHp+a
        QjSan0PVNLpqKq2JvQa0J5twDpMOJqKTXEWgyBrl+Ij3nwwuqlH5WfZ7h0dhQPe6zV3LqKjDhcfDo
        OEXv+jIK58SMWAcReCIkCXdco4k3aMfwhJV4UpjcUIIigibx3Tm0NQdpbfGipQwGEiGjg=;
Received: from p200300ccfbcc8e007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsaG-0006JL-Vl; Wed, 16 Jan 2019 22:18:49 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsaF-0001fG-Gd; Wed, 16 Jan 2019 22:18:47 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 5/6] gnss: sirf: add a separate supply for a lna
Date:   Wed, 16 Jan 2019 22:18:11 +0100
Message-Id: <20190116211812.6337-6-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190116211812.6337-1-andreas@kemnade.info>
References: <20190116211812.6337-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices might have a separate lna between antenna input of the gps
chip and the antenna which might have a separate supply.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v3:
 - improved error checking
 - style cleanup

Changes in v2:
 - handle lna also if there is no on-off gpio
 - rebase on changed 2/5

 drivers/gnss/sirf.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 943a2ec9b708..7de98edf198a 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -41,6 +41,7 @@ struct sirf_data {
 	struct serdev_device *serdev;
 	speed_t	speed;
 	struct regulator *vcc;
+	struct regulator *lna;
 	struct gpio_desc *on_off;
 	struct gpio_desc *wakeup;
 	int irq;
@@ -293,21 +294,52 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 static int sirf_runtime_suspend(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret;
 
-	if (!data->on_off)
-		return regulator_disable(data->vcc);
+	if (data->on_off)
+		ret = sirf_set_active(data, false);
+	else
+		ret = regulator_disable(data->vcc);
+
+	if (ret)
+		return ret;
 
-	return sirf_set_active(data, false);
+	ret = regulator_disable(data->lna);
+	if (ret) {
+		int reenable_ret;
+
+		if (data->on_off)
+			reenable_ret = sirf_set_active(data, true);
+		else
+			reenable_ret = regulator_enable(data->vcc);
+
+		if (reenable_ret)
+			dev_err(dev,
+				"failed to reenable power on failed suspend: %d\n",
+				reenable_ret);
+	}
+
+	return ret;
 }
 
 static int sirf_runtime_resume(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_enable(data->lna);
+	if (ret)
+		return ret;
 
-	if (!data->on_off)
-		return regulator_enable(data->vcc);
+	if (data->on_off)
+		ret = sirf_set_active(data, true);
+	else
+		ret = regulator_enable(data->vcc);
 
-	return sirf_set_active(data, true);
+	if (ret)
+		regulator_disable(data->lna);
+
+	return ret;
 }
 
 static int __maybe_unused sirf_suspend(struct device *dev)
@@ -395,6 +427,12 @@ static int sirf_probe(struct serdev_device *serdev)
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

