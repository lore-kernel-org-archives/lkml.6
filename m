Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A19C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB98020892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPMamB9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB98020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeLFMoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41264 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeLFMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so269922ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VEANXWZbVqprII34eupTEX+PE8o+MRtLs3B6IBk600=;
        b=IPMamB9KYnwZi438OBhj+UVdVNuf5OLp++/S263ecahVnGvJcBonnfx10j8cDroEnd
         UYqmDTZ6XfqtuWHP1tlFGCZs3RjBSXSC7G55YMjP9vILMfjAAMVMxAkr8jJhQPy4NKFa
         aa1nyT9xfe/GA/hj59Pciz+PvJYVDlK3E0XqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VEANXWZbVqprII34eupTEX+PE8o+MRtLs3B6IBk600=;
        b=L05IFQgumb8nA+NE7JF2ZlL/JmI5d05CB1rL60j0ewkxkSHk8a0XQRldvxmrfhDUMZ
         RYVsukLyn302bMHeCpnfVqe1o6t/g1eKjxpMEqxz8WyuMNVLuSeLM1mhqmGLdeNIYNnK
         9o2iKKsAthj9at0fK6DuUMkziqoyQb4xaXaw4sv7mJWAjYrXgVpvW4cG8sYCsWkQ54fx
         jb/DQTj1TBQSjhw8xh76E3l3YmAcC+MxxmL9lmL3cu8a52+hei5mHDGBrD6UeUtrdzTS
         S6ubeCS7ghnVI2FgONf3M+DYXLb5zi61FS6FMbxrt1tOz8Ri2Cr8aVkAt/L/ewx1wCA0
         ZRDQ==
X-Gm-Message-State: AA+aEWZXRN8kv8nwch9Vi1RrkmSOkE9pYl1rgHGgjm9m0p15YXIMfthG
        4OUIYV502pH/hRlXWJrpuSo96REMz+1JJQ==
X-Google-Smtp-Source: AFSGD/Vbccs+xGZgt8R6k7hwNM81AA7bI0x1mNphmaYf83c5/b2GV34pGN8L0Qq8oX7dGmp9F5aUvg==
X-Received: by 2002:a2e:478f:: with SMTP id u137-v6mr18104660lja.142.1544100243897;
        Thu, 06 Dec 2018 04:44:03 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/15 v4] regulator: fixed: Let core handle GPIO descriptor
Date:   Thu,  6 Dec 2018 13:43:38 +0100
Message-Id: <20181206124351.10155-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
References: <20181206124351.10155-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Resending.
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

