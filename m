Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315FFC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E969520849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="g6vySxA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E969520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeLMOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:46:07 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44036 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbeLMOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:46:05 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] usb: musb: jz4740: Add support for devicetree
Date:   Thu, 13 Dec 2018 15:45:53 +0100
Message-Id: <20181213144555.24031-2-paul@crapouillou.net>
In-Reply-To: <20181213144555.24031-1-paul@crapouillou.net>
References: <20181213144555.24031-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544712363; bh=qdVdUvaR2WUq/vrKQ9BM0PkyF6HXTrTJD84/ZZzJuEE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=g6vySxA1fuWw2xURqQamCxOrbw33KQjABpIuxyC3I82F1Loc/yDg++m/EcDG/XZMcA82IjDapnuMaXYMi4wE09ppaG+yY7JBeQBUbQ+53oH3KqSQqDk68UfAbFLzHXOn4cPKeXcsxsZ3F1QVTYh08Tp9v7QmzxKeaFMpi2sz+PI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the driver from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index 04d8b2bc205a..9a2cebcac260 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/usb/usb_phy_generic.h>
 
@@ -188,11 +189,17 @@ static int jz4740_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id jz4740_musb_of_match[] = {
+	{ .compatible = "ingenic,jz4740-musb" },
+	{},
+};
+
 static struct platform_driver jz4740_driver = {
 	.probe		= jz4740_probe,
 	.remove		= jz4740_remove,
 	.driver		= {
 		.name	= "musb-jz4740",
+		.of_match_table = of_match_ptr(jz4740_musb_of_match),
 	},
 };
 
-- 
2.11.0

