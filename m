Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4E32082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBImvxxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4E32082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeLEMst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39944 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLEMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so18208205lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/tSaH5O7cNIBaIVmHZFPw2uq5T69lxPBmIyOOIA2ik=;
        b=WBImvxxnrLj10G/y4YEWYG2puvBbKj7GH0JoF5G/lDv2wynU9DgaAsouFmDQ5jSwC7
         ExweG2i/py0nlbYJTr+ghEqr8MTKmYpk0uufPqZ9Jh06P+ZCYa1nnETFOWRXLtir2D/U
         mxV0o9VssUFLZp6jmcSuDh34XAml0OnIfp9tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/tSaH5O7cNIBaIVmHZFPw2uq5T69lxPBmIyOOIA2ik=;
        b=M+fPUpaqW4qkz1Sq2Np5K5dxqCbVywKEKNbnLe8hxRUT0cu3I+fhLdGC+V6DpO4QSw
         SK28SUtFPinh3//vD2uPtSTghyKJVUfbc+K4tmBanVU1MOrlPfK81S6ZQFudv8zF5iZm
         g3CmsW+ySdwk2JqnU0KfIzC1wlImAefhMrEvD8wHAJYR2i5QIJphnIJNs0Pf2hUhTXMg
         wNP2i0qbJI6JCEApOZE6IEiNCrS8IaZuJ++ggQq91B+FERB1W6ihWa5hX7ID1gyZ/hvV
         Vr8GTlq/0Pe8utkGdbvii/KYqIqqo68whfvG563MBAPyY+fAjVT8mJbESLkctjDl1dtS
         Np+g==
X-Gm-Message-State: AA+aEWbwtDXz/qDVnRiBZum+bcgj9+YvlWOz1h+IzRuAoOfgjsUmdAx4
        EYcaPHuNXyX/mbiIWoog0vJEYA==
X-Google-Smtp-Source: AFSGD/Uv8I5IjK47/6gc+GYMQV2KnPz6JM1e1aF+LaTNFEWwtjwjWghEs/sHf2E235ARXapvxCeQ/w==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr15208124ljf.47.1544014053364;
        Wed, 05 Dec 2018 04:47:33 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/15 v3] regulator: fixed: Let core handle GPIO descriptor
Date:   Wed,  5 Dec 2018 13:47:08 +0100
Message-Id: <20181205124721.26624-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Drop the conditional gpiod_put() on the errorpath: the
  regulator core will take care of that once
  devm_regulator_register() gets called.
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/fixed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ccc29038f19a..9abdb9130766 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -183,7 +183,11 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	 */
 	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 */
+	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, NULL, gflags);
 	if (IS_ERR(cfg.ena_gpiod))
 		return PTR_ERR(cfg.ena_gpiod);
 
-- 
2.19.2

