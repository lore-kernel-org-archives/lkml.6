Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1118AC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C837A21473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3DMkc9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C837A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeLBDF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:05:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47056 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeLBDFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:05:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so6180451lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iUsZ/16+oDFR/k1SSqoY5Bn/jlRg+zr47SC2D/gEWM=;
        b=j3DMkc9ddwMjPqKCKbD7hXOMHd2rlLnPLk6WsLo2IASfy3MDmNSzo4yEfkwl6w9fDO
         e5H5wiTmvGwZfk634qy9KHznxDvTwiL/1184WnjfTe+o6Xt6e8XJHym+JM7K/6iQuLYk
         NgePIWkTJ7aV7V6YD0hGP37ah01Qd039ZIWJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iUsZ/16+oDFR/k1SSqoY5Bn/jlRg+zr47SC2D/gEWM=;
        b=hkgqPTpQQaPONfpgg/4T55p+knB5L/zKfHYd7mOArP2FkahIq0nFKeyX57Bcf2Yq5I
         HmE+chPeOJwHRFOU2QMweE/07EFtNRoRgA9ukofmk81lU47cjwcMrWsjw8/wHThSGOIT
         L0hkhsMeAy2RfMrNREHhMeNvepvrL/D+WcFEzMO5ykztYZq/ybTEvMvij8HE5uMRl2oW
         SBBCj9zH2YTHENkju0NPx17rFwCD6yX+xmbmAQmbLizYiOyM+zpcPYPInKbeuZU/1qny
         9kSKFvEaD0me5wjFE1ktpue222oOVxyredFrCnxFxW39qHQfrSf94IKvG0zINVdO0Ibe
         08VA==
X-Gm-Message-State: AA+aEWZu7fr5BhWlq48W5l8a29qvddMD8axX+MbxtvT5OMTpz19YL85b
        W3NBT3ur4njdGVgIBytl3qv5eg==
X-Google-Smtp-Source: AFSGD/VzWf9Esb0CfflUQAHPI3wSVrzonO+F0mqgVT/XHH1csIcT4N4RUOCwx87P5t83mAyalLTAYA==
X-Received: by 2002:a19:9904:: with SMTP id b4mr5610949lfe.95.1543679585544;
        Sat, 01 Dec 2018 07:53:05 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/13 v2] regulator: fixed: Let core handle GPIO descriptor
Date:   Sat,  1 Dec 2018 16:41:40 +0100
Message-Id: <20181201154151.14890-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
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
2.19.1

