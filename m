Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC35C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB5C24445
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="slJmdE25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB5C24445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934268AbeF0Lzy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:55:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35982 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbeF0LzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:55:03 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] GPIO: ingenic: Implement .get_direction
Date:   Wed, 27 Jun 2018 13:49:04 +0200
Message-Id: <20180627114904.10890-6-paul@crapouillou.net>
In-Reply-To: <20180627114904.10890-1-paul@crapouillou.net>
References: <20180627114904.10890-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530100167; bh=3iIC0mKGcQL2afXocns87TpI26KILfpuLB3D/IcHyag=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=slJmdE25b4aoqiA1cGD6rr3KLF0kkQRK+Xi6Xjlpc7BkIDgnjjaC97BvvqQtdIfRMln0fS9QR0wpbZbM+YR60kk3t0oUuWHCH+tp5cdBIKI2Y12ECTODUdofot/ZHNQyqk4Iy3XQ9i44VuPorggUJJCHOO69tgTc0vOAREf1snY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced pinctrl_gpio_get_direction to implement the
.get_direction callback.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpio/gpio-ingenic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-ingenic.c b/drivers/gpio/gpio-ingenic.c
index e738e384a5ca..79e8b67fe83d 100644
--- a/drivers/gpio/gpio-ingenic.c
+++ b/drivers/gpio/gpio-ingenic.c
@@ -274,6 +274,12 @@ static int ingenic_gpio_direction_output(struct gpio_chip *gc,
 	return pinctrl_gpio_direction_output(gc->base + offset);
 }
 
+static int ingenic_gpio_get_direction(struct gpio_chip *gc,
+		unsigned int offset)
+{
+	return pinctrl_gpio_get_direction(gc->base + offset);
+}
+
 static const struct of_device_id ingenic_gpio_of_match[] = {
 	{ .compatible = "ingenic,jz4740-gpio", .data = (void *)ID_JZ4740 },
 	{ .compatible = "ingenic,jz4770-gpio", .data = (void *)ID_JZ4770 },
@@ -325,6 +331,7 @@ static int ingenic_gpio_probe(struct platform_device *pdev)
 
 	jzgc->gc.set = ingenic_gpio_set;
 	jzgc->gc.get = ingenic_gpio_get;
+	jzgc->gc.get_direction = ingenic_gpio_get_direction;
 	jzgc->gc.direction_input = ingenic_gpio_direction_input;
 	jzgc->gc.direction_output = ingenic_gpio_direction_output;
 
-- 
2.11.0

