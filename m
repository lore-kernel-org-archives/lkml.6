Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535EBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D57520878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bk5IIEKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D57520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeLEMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:47:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35139 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeLEMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so18213188ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRudiYan1+9SGUqT2YYA3x44wsGQ0MYaQO8d+oaHrpo=;
        b=bk5IIEKIAvyo3fv7E8AC9gwr+k7nsDv+5+bAtfzoX4iPntU0cCnQrlpAYzyFCdL1lJ
         s+7IgNHQHSVnlOVS7SRuV2IPPrnBrKOdOlXsKUMbAqE8TwKbaZfvnduHP4b3FFZuuBq4
         XK6onBb/yZ9pXTcrQ5zudiHRqqnCNuerc+0KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRudiYan1+9SGUqT2YYA3x44wsGQ0MYaQO8d+oaHrpo=;
        b=t9enMZ12BZg7ws1wI7DS+tJIj4Zr/ovzL6KwXBIly5FYJqGwFeoImwXWibQpo137Vj
         i50jgkbhEj8laiDbQA7lWJeAj523AkMCMKbwdhD36K/19MqtVwhhEXe66UCPpHm5CKZj
         76Arkt8h/pqnARb6JY0/6wzus+EO1rxRJ8qh9Ug/6PkzehRuJ53QdrvIaTg3NAai+c54
         ASyGBdCVscUGGbO+2mW28r73P7rE6D+Ve0V+WLCRM3kcDZvx0ZPILqrK3uMMNvvX/SDr
         HeBYpmBjxX4WQWSSABxqLtij++3XTbmDZcdwtCNf1sRtYwnMphi6F77B/MJzfxEeY0sB
         VoPA==
X-Gm-Message-State: AA+aEWaGZ5rU8Ts7tm7MoUzTdTqI+5sa++oi0RE3Gq4GOMMV0nSWvIgi
        xH9zLnAfbJkMCZTdceQCSRrDHg==
X-Google-Smtp-Source: AFSGD/UnIDithsbCo019pVfgaS0UxnaUSZzAwLTySu1gwvGmbrAyytAoqR3Tcl34WZMcjnwV6QxbZA==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr3516884ljj.18.1544014058007;
        Wed, 05 Dec 2018 04:47:38 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/15 v3] regulator: lp8788-ldo: Let core handle GPIO descriptor
Date:   Wed,  5 Dec 2018 13:47:10 +0100
Message-Id: <20181205124721.26624-5-linus.walleij@linaro.org>
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

Fixes: 2468f0d51548 ("regulator: lp8788-ldo: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/lp8788-ldo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 553b4790050f..2ee22e7ea675 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -501,8 +501,12 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 		return 0;
 	}
 
-	/* FIXME: check default mode for GPIO here: high or low? */
-	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 * FIXME: check default mode for GPIO here: high or low?
+	 */
+	ldo->ena_gpiod = gpiod_get_index_optional(&pdev->dev,
 					       "enable",
 					       enable_id,
 					       GPIOD_OUT_HIGH |
-- 
2.19.2

