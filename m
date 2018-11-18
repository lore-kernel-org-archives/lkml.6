Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B243920817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="aUWb2But"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B243920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeKSITz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:19:55 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52548 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbeKSITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t3B3l8VIggkSXnv4U/Fsu0ElHYuyPPhuVFrf9TC8Xho=; b=aUWb2ButCiCWDixki6+47FSV5
        mDrSLn8PYoyBfKkmkUsrh+ZeeHooPJyyom+x8bqzZMzrF1dDWkN89U3uRDHV2d+abxMVx0hkUOL9p
        qcMN8wEiG2Ho8H/HNDsQ84fV+omrwWVtQDG1n79Im7Y452gZqXZ9+PO/KMmraEIvLy1zM=;
Received: from p200300ccfbe8ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbe8:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV59-00078V-D8; Sun, 18 Nov 2018 22:58:19 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gOV59-0003DH-41; Sun, 18 Nov 2018 22:58:19 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 4/5] gnss: sirf: add a separate supply for a lna
Date:   Sun, 18 Nov 2018 22:58:00 +0100
Message-Id: <20181118215801.12280-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181118215801.12280-1-andreas@kemnade.info>
References: <20181118215801.12280-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices might have a separate lna between antenna output of the gps
chip and the antenna which might have a separate supply

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gnss/sirf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 6a0e5c0a2d62..f7573ca2dacd 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -30,6 +30,7 @@ struct sirf_data {
 	struct serdev_device *serdev;
 	speed_t	speed;
 	struct regulator *vcc;
+	struct regulator *lna;
 	struct gpio_desc *on_off;
 	struct gpio_desc *wakeup;
 	int irq;
@@ -217,6 +218,7 @@ static int sirf_runtime_suspend(struct device *dev)
 
 	if (!data->on_off)
 		return regulator_disable(data->vcc);
+	regulator_disable(data->lna);
 	ret = sirf_set_active(data, false);
 
 	if (ret)
@@ -245,13 +247,20 @@ static int sirf_runtime_resume(struct device *dev)
 		if (ret)
 			goto err_close_serdev;
 	}
+
+	ret = regulator_enable(data->lna);
+	if (ret)
+		goto err_disable_vcc;
+
 	ret = sirf_set_active(data, true);
 
 	if (!ret)
 		return 0;
 
+err_disable_vcc:
 	if (!data->on_off)
 		regulator_disable(data->vcc);
+
 err_close_serdev:
 	serdev_device_close(data->serdev);
 	return ret;
@@ -340,6 +349,12 @@ static int sirf_probe(struct serdev_device *serdev)
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

