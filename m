Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DDF20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8Ypw5eD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DDF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeLEMsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38063 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeLEMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:48:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so18213880lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvbe/TI6Rhb2D1rfWmfe80Bc3HpvIOlePt1WuzAwmR8=;
        b=f8Ypw5eDceNhgRdXslCuTXFxSyiXSv8KrlT/tecx8xboeHWIn1NIKL3cwKZST+fa24
         CycsVp/wytPMYh1JQbwYhBaXf2K/cBaQ/CfiXB4FfYF3IedTyrKD0ygERiyoWTpoYuYw
         GD7t1FcntszXPtsjkKJEV1xUtUGQiy5yCjXzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvbe/TI6Rhb2D1rfWmfe80Bc3HpvIOlePt1WuzAwmR8=;
        b=Dsi8TtBXB0/0zyTeaKd8SunaemqfC2pOZPkVurMz+iddENM8pQ5+zNXsDLZAXzT9+I
         mxH14pQ3MjAy+wc21OjAznrSmbWQm+9iZoR10WR2Z8/nLLXlNcZ9hXrtcoZXaje4TfMT
         ioEQV5qVka2TVfDg6vsYTi4Cedi3SIWfnXZU8/PoE8UXtjxeH/jRMvOLRlm/Cdc/y9fW
         by/2tKH8UHY1R00izDDaFJWD1LouXlQQR/choxQIeFncSLpOfM9mJCfEac2zvRxpqN5d
         kZppsLqjeyaodxRMLI71iPBk5LY1P4fUUKjuYZkRBzaxkrCmTXAfk2MaGH6D3Fvw5Lpo
         QtDg==
X-Gm-Message-State: AA+aEWbJ1CpoC06MVmGjOEEnqy5J58lnvzPKdG38HjE17AmJxBBtqyND
        zxwCxjBzpYQkuh+cCYUDOdg5lA==
X-Google-Smtp-Source: AFSGD/WKBaMAwHAvOQRLRkm9henT9BElOChiekVxRNFTfQDhOwsWqOuAlRI/Wa6eLPeHLM6XJsSc4Q==
X-Received: by 2002:a2e:8786:: with SMTP id n6-v6mr10153266lji.100.1544014080987;
        Wed, 05 Dec 2018 04:48:00 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:48:00 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 15/15 v3] regulator: s2mps11: Hand over GPIO to regulator core
Date:   Wed,  5 Dec 2018 13:47:21 +0100
Message-Id: <20181205124721.26624-16-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the S2MPS11 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- New patch handling this drivers GPIO descriptors properly.
---
 drivers/regulator/s2mps11.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 63e66f485cc0..ee4a23ab0663 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1178,7 +1178,12 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 			config.of_node = rdata[i].of_node;
 		}
 		config.ena_gpiod = s2mps11->ext_control_gpiod[i];
-
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(&pdev->dev, config.ena_gpiod);
 		regulator = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(regulator)) {
-- 
2.19.2

