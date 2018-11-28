Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F89FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71AD205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij1NGoa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71AD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeK1VpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46203 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeK1VpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so22950848ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSq5Ux3lrLmf0ju6pKXh6bN4YVbhItoKJwwx9fdJpto=;
        b=Ij1NGoa/A2B/u/G+rImlfcOhPrcxErU8dgsxUZqhi+BwomCsddOelRw6r/ZZH24v1e
         h8qeB6gVF0Ap0XtKhPVDBg/ryDGKVewCd3vR9JcjLxDK/JN7vb2WMgiA1AD+6gQuEEE1
         Vs7D7qpmxHlb+uDF3Mh8i5F8OCeJow8eiVVwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSq5Ux3lrLmf0ju6pKXh6bN4YVbhItoKJwwx9fdJpto=;
        b=hycIVoYwdPoj6fsjTG3jdd7c7dtWgsRKnVFoh8Je03KU9XOehtOM1jl2BWhB2JjjWJ
         Rn2BzYA1Cw2Hie1qCeMqP9zzDd6e9j9o5w7dOA0lxbzMwrCN6o5PYjQkEw0oLiFm+Y/3
         yS1lbhJDAHx9e0II+iUX1XPoeHYzW9doIBKyb60EsVM0nhQ8SopGoHETf67d4mWsXBZX
         JBvNi8yX8vF/TKddwPW8C/UO4CcNdBw1HXuQNyA8KDZ4a0O/vp4SxYLjlXsPoYnxSG64
         lwWp+ux+xH+mSRAto20hsFfeT4uRlzS2H39lDiaJ4DNbIvYLriCOoCXC0/458R6LLcfB
         zBQQ==
X-Gm-Message-State: AA+aEWao2+m1hZhTIbGs42ePRMPF9Za2N/1MmvSjKq89wpNUyD7iEGHK
        F/y8TOaY8bWZJ0G5gR81J29Y7A==
X-Google-Smtp-Source: AFSGD/VrvRQpAGFNSzK0ic/DlHYHhg3TXYbfdXukkqKOjFx/CxOHrw0j025HUPl3VdGRgeoWmw7bww==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr24873236ljb.89.1543401838245;
        Wed, 28 Nov 2018 02:43:58 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:43:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/10] regulator: fixed: Let core handle GPIO descriptor
Date:   Wed, 28 Nov 2018 11:43:41 +0100
Message-Id: <20181128104350.31902-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
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
 drivers/regulator/fixed.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ccc29038f19a..52091ebf7164 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -183,7 +183,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	 */
 	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	cfg.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, gflags);
+	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, NULL, gflags);
 	if (IS_ERR(cfg.ena_gpiod))
 		return PTR_ERR(cfg.ena_gpiod);
 
@@ -195,6 +195,8 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	drvdata->dev = devm_regulator_register(&pdev->dev, &drvdata->desc,
 					       &cfg);
 	if (IS_ERR(drvdata->dev)) {
+		if (cfg.ena_gpiod)
+			gpiod_put(cfg.ena_gpiod);
 		ret = PTR_ERR(drvdata->dev);
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
 		return ret;
-- 
2.19.1

