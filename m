Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246BDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD32082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsZ1o/yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFD32082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeLEMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:48:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35164 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeLEMsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:48:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so18214209ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0D3WorUOEulyLATldQc2enEjdRGG/LFQCVQP8Gk/E1A=;
        b=AsZ1o/yt0g+Jl+5sVVA+5jLbXIhFIOHs+/E0m5QBdzSqKk3H2HQVQBnPaQ7m1kDg0m
         E4lyBOdtrIWEZZhS042uW6mxIPbj59PtHMPHCG4hJGBzVmVqzOLoeojWXRbdjuTWHQug
         YkAnbaXJL9QUgOwNJ66pXJ3/9RrYCTaWIUyyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0D3WorUOEulyLATldQc2enEjdRGG/LFQCVQP8Gk/E1A=;
        b=bYWvtLo5lmfJZyyBK2AMJFZRgWhRQLfd5ch5Pv6+KxtVH8h7MSlRAO/Ri0UW0RZhcr
         rtqd613xeoOxuZMuhkzZG9FtJJiebnf3jOM6Q5spLuOYSBiQAkhzGvcZI7HY1YI20XoO
         FojljBmHrU/gHeVHSAEie0YKGmMmhjCjyB2d0vqSthsvlLdq9Yu1xfHWRd6ojXmW+NrI
         AlQBjsSpzt/3RHq9tmqcCgGfPujr3JexY7gtGdM8Jrm4eZ75jrMfUaio8M9mE+ajskTx
         ap+ckOa61T3EZdSrxf0BIYRbgEfHjiN9XusQ53MK99zLQMPHcChGGl9LgziJjMCXays2
         HW3w==
X-Gm-Message-State: AA+aEWb5DQdM6m2drWaPCknkMiXBq5T1qClHQx4LDKiba/UJXD4djm7I
        2RH2DwP7vhTBgSyWGg8Unyy07Q==
X-Google-Smtp-Source: AFSGD/WIofgib8lRjgn6ZAULWz+zpWSniDctOVT027gcM/JFpXNricxvHwM80Pu/3Md59MtFl2Gp5Q==
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr15201268ljd.141.1544014078967;
        Wed, 05 Dec 2018 04:47:58 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 14/15 v3] regulator: tps65090: Hand over GPIO to regulator core
Date:   Wed,  5 Dec 2018 13:47:20 +0100
Message-Id: <20181205124721.26624-15-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205124721.26624-1-linus.walleij@linaro.org>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the TPS65090 driver are retrieved
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
 drivers/regulator/tps65090-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index db714d5edafc..0614551796a1 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -480,6 +480,12 @@ static int tps65090_regulator_probe(struct platform_device *pdev)
 		else
 			config.of_node = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(&pdev->dev, config.ena_gpiod);
 		rdev = devm_regulator_register(&pdev->dev, ri->desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
-- 
2.19.2

