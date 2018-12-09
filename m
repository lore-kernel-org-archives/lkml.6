Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4CEC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8752082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="U5OSxEku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8752082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeLITwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:52:13 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:40648 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeLITwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DP3WrD0RNn5/QPCbCSvK5py97Snb6BbQz1Rb9BnrjBk=; b=U5OSxEkuQocy496k+03bU+6Hs
        JcfeTSV7rqHbERQ+ON+nJaESvXu7Os2/jIvrRkreXba+2LiKf92/nT5lNHnk1j9sTfNu4nKaW9MEr
        hMMTuaqHB0H8fKf8qLOcE70LffGZJ2fbPQHMjYagLnjv1pVGffrr+304oDxg7qo8BmNcQ=;
Received: from p200300ccfbead7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbea:d700:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57W-0008K5-4m; Sun, 09 Dec 2018 20:52:06 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gW57V-0001NU-SJ; Sun, 09 Dec 2018 20:52:05 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 4/5] gnss: sirf: add a separate supply for a lna
Date:   Sun,  9 Dec 2018 20:51:49 +0100
Message-Id: <20181209195150.5192-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181209195150.5192-1-andreas@kemnade.info>
References: <20181209195150.5192-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices might have a separate lna between antenna output of the gps
chip and the antenna which might have a separate supply.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 - handle lna also if there is no on-off gpio
 - rebase on changed 2/5

 drivers/gnss/sirf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index c64369494afb..d339e8ef2508 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -36,6 +36,7 @@ struct sirf_data {
 	struct serdev_device *serdev;
 	speed_t	speed;
 	struct regulator *vcc;
+	struct regulator *lna;
 	struct gpio_desc *on_off;
 	struct gpio_desc *wakeup;
 	int irq;
@@ -282,21 +283,32 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 static int sirf_runtime_suspend(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret = 0;
 
 	if (!data->on_off)
-		return regulator_disable(data->vcc);
+		ret = regulator_disable(data->vcc);
+	else
+		ret = sirf_set_active(data, false);
 
-	return sirf_set_active(data, false);
+	if (ret)
+		return ret;
+
+	return regulator_disable(data->lna);
 }
 
 static int sirf_runtime_resume(struct device *dev)
 {
 	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_enable(data->lna);
+	if (ret)
+		return ret;
 
 	if (!data->on_off)
 		return regulator_enable(data->vcc);
-
-	return sirf_set_active(data, true);
+	else
+		return sirf_set_active(data, true);
 }
 
 static int __maybe_unused sirf_suspend(struct device *dev)
@@ -384,6 +396,12 @@ static int sirf_probe(struct serdev_device *serdev)
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

