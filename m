Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30122C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9A321536
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgNgybUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9A321536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeLFMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39866 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbeLFMoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so239933lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhlKqI8Sf7OwwyTXqg/8o97lEVTsK7W63wvXXbyp2DA=;
        b=NgNgybUVYedAJyqssM+aetsaZYtCBJqAHmLXHKsu3elwVSMH2cra2hWqdiJXCErpFG
         VHMSM+gH3wRZw3Z8T6u4zUWhIdEbC62+nMuhFjLTzG7ulzovGCDz6ofeyDuVmt2dz5yN
         njJut7HTp1QVbwoRnO5rwv9NTpFteEL7OtwTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhlKqI8Sf7OwwyTXqg/8o97lEVTsK7W63wvXXbyp2DA=;
        b=tA84c2cEVBA1d+g8wCBC/UXwEEXuFZ+xuNqJurLKu/r5jWdughMQ6AQu3EH/N2YTFz
         NEEuBLKQLoNrN/zvXvVJfXw2oU0YkH3RJtHQT8n/mmwGP4PmbzNMjQX4/mo/axZJJtEZ
         nHOJrjbLII52v6qt1x8+OvU1/e+k46nHaYXvCV7ldEneBRSPdO6pUNCmkJ8arRGs+GfC
         /flROkxwXF016NCQyr6KfsEodcmydiXN/QnkVNrS0a0IF6SZt6dhjCeFnzEq38zsSHEI
         jGhomFhkqFOkDJSgUzLuhnFpqaE8/Acgh6Ta4Pv27TL8/HvVztqeSG/cz+g5d6x+PKyO
         ZVBA==
X-Gm-Message-State: AA+aEWZBuhRq+PTDfrfsb2KZaucd5CuZs/HkVV5Gsa2PHp50BCK3RSvl
        EgU5lFCK3l7kWra2dfdplr21JQ==
X-Google-Smtp-Source: AFSGD/VW6FqUx2K/ndwPH9PWpFoM2Ykl/Efzhb4vqhm6JCHmJiAuzFOb8sP6abcFAcclFq17jO8Lhw==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr14023531lfi.2.1544100258697;
        Thu, 06 Dec 2018 04:44:18 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/15 v4] gpio: devres: Handle nonexclusive GPIOs
Date:   Thu,  6 Dec 2018 13:43:45 +0100
Message-Id: <20181206124351.10155-10-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get a nonexeclusive GPIO descriptor using managed
resources, we should only add it to the list of managed
resources once: on the first user. Augment the
devm_gpiod_get_index() and devm_gpiod_get_from_of_node()
calls to account for this by checking if the descriptor
is already resource managed before we proceed to allocate
a new resource management struct.

Cc: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: b0ce7b29bfcd ("regulator/gpio: Allow nonexclusive GPIO access")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Pass a pointer to a pointer &desc instead of just the
  descriptor pointer: it is the memory address storing the
  pointer that hooks into resource management.
ChangeLog v1->v3:
- New patch.
- This fix is in response to an issue Marek saw in the fixups
  for resource-managed GPIO descriptors used with ena_gpiod
  in the regulator subsystem.
- I first thought to apply it to the GPIO tree directly, but
  since it is not a regression it is better to put it into
  the regulator tree with the rest of the patches.
---
 drivers/gpio/gpiolib-devres.c | 50 ++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 01959369360b..f9591b5c9748 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -98,15 +98,28 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 	struct gpio_desc **dr;
 	struct gpio_desc *desc;
 
+	desc = gpiod_get_index(dev, con_id, idx, flags);
+	if (IS_ERR(desc))
+		return desc;
+
+	/*
+	 * For non-exclusive GPIO descriptors, check if this descriptor is
+	 * already under resource management by this device.
+	 */
+	if (flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
+		struct devres *dres;
+
+		dres = devres_find(dev, devm_gpiod_release,
+				   devm_gpiod_match, &desc);
+		if (dres)
+			return desc;
+	}
+
 	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
 			  GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		gpiod_put(desc);
 		return ERR_PTR(-ENOMEM);
-
-	desc = gpiod_get_index(dev, con_id, idx, flags);
-	if (IS_ERR(desc)) {
-		devres_free(dr);
-		return desc;
 	}
 
 	*dr = desc;
@@ -140,15 +153,28 @@ struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 	struct gpio_desc **dr;
 	struct gpio_desc *desc;
 
+	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
+	if (IS_ERR(desc))
+		return desc;
+
+	/*
+	 * For non-exclusive GPIO descriptors, check if this descriptor is
+	 * already under resource management by this device.
+	 */
+	if (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
+		struct devres *dres;
+
+		dres = devres_find(dev, devm_gpiod_release,
+				   devm_gpiod_match, &desc);
+		if (dres)
+			return desc;
+	}
+
 	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
 			  GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		gpiod_put(desc);
 		return ERR_PTR(-ENOMEM);
-
-	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
-	if (IS_ERR(desc)) {
-		devres_free(dr);
-		return desc;
 	}
 
 	*dr = desc;
-- 
2.19.2

