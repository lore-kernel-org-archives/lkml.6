Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F33C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FC721473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="awaJkCYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FC721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeLBDGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44045 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeLBDGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so6189539lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSHgOcFCcORkAA/FyvR5Vyf7Y6Xs7jW379bIdSME4VA=;
        b=awaJkCYRZMHwI3+jvDJmJ/DvUoUFidnG+SAaLBjW16slimg8aAoDF0vH9xZQqT9Z3k
         qLgLlVi3ugAetbLrtWXMjvGv/oyg6aY5udlJgo5cjBdRgeu6SOQv0q7/w7toNYRsorHK
         2u4SC4UDt3vTPKpq2ir/1B/oUihVXAUfNPmeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSHgOcFCcORkAA/FyvR5Vyf7Y6Xs7jW379bIdSME4VA=;
        b=ezqQgNtwG++5AxcYhkG1opUI4FMwow9TPXWSrFFWWj6NOi3HTD5Y6knMWfIBLG0k6o
         8XMix6KMaoLRgN7PF6L1v6Uum3BdI2vvRKQySiU4euC5v3G3xOjy03GXvvwC6sCJ7QGX
         BxRoFsxjgYRBy5lAwFrrSx1wm4KgkR0syrXfmlS34ajJJdPLAlRNHVXHPU1M36s/qxAO
         S7iOzkIEwitDgRbjVYAIBaodYMypQ7m1+v0/jJeUc+9+bWaeU+C7acU5ZH5mSrriNAuF
         Qj3boz044Hv4X0gvztkO5BASqM38kROCQr4zsEhMnt+q7iuswC55oh2FHwLWbO/L+0my
         oV/A==
X-Gm-Message-State: AA+aEWa2JMi/LY4O1YGFotDbQORdv3n6NPh5jrAgwzPy4CNfo8Sgxqj/
        K2VVDmoqlMetZ+imf2ek+QaCIw==
X-Google-Smtp-Source: AFSGD/XI9Z+9yvIwbUTTOb6CBMsO1ey1JHYYoO0mDajoia9hNr31Yggx01mrtBDj94uKp8eqJWFQEw==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr6058120lfe.45.1543679602693;
        Sat, 01 Dec 2018 07:53:22 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:21 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/13 v2] regulator: da9211: Hand over GPIO to regulator core
Date:   Sat,  1 Dec 2018 16:41:48 +0100
Message-Id: <20181201154151.14890-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the DA9211 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch handling this drivers GPIO descriptors properly.
---
 drivers/regulator/da9211-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 8f68c7a05d27..109ee12d4362 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -389,6 +389,12 @@ static int da9211_regulator_init(struct da9211 *chip)
 		else
 			config.ena_gpiod = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from GPIO devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(chip->dev, config.ena_gpiod);
 		chip->rdev[i] = devm_regulator_register(chip->dev,
 			&da9211_regulators[i], &config);
 		if (IS_ERR(chip->rdev[i])) {
-- 
2.19.1

