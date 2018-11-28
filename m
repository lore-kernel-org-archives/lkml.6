Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A801205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcWJrBHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A801205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeK1VpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36942 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeK1VpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so22981635lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0ANQBd09LcGDKebw9OrEkrU3xRG8J5BfhAYKK76wok=;
        b=EcWJrBHi25Mrr1atFR0tEoCdEdwFxVdh5RM0THY+2gytq0Ri1MOvDGAb6PpL/AGNK9
         6z4IN6RqNgtaZE2zLaLNEUsQx4ALWt7nr3Qa1S91/3Ggj9n7PGNDCucGSzhcbo0Ogiv2
         MvqKUn2Pv5WyVTgZGuia2X+Ixcb3KFBk9Nmtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0ANQBd09LcGDKebw9OrEkrU3xRG8J5BfhAYKK76wok=;
        b=Qe2j3ALKtySDvrpyEd1QkXLaRhNikaKMhhl5FLOqdNJGc6CSNsyyxrnNE6qhNyXsa3
         6fl8pPNPIPL24YO51/t31nSIJLQf5wkqDfwZOahvqFB9fVEfI6egwvlHaZ/DIXZyDliE
         TefwErzCrJ991IjXbNB6G1xl/rkyyuROolUE9bCinH8qHJylXiLnB1hdxlRlspGTgudr
         dQboJ4N6d0jj+lEs1LY4zAhcjWa4hCMD0IBRCoKQK6hrZDI95oBuCPv04mMIrRGU2StN
         QiAGjLJYcW9S/HlM8sruNmcCsJ5QNmWOuDn6U1o4pPWLsKid0SxmfYFtEVs/Ue506iI4
         CrjQ==
X-Gm-Message-State: AA+aEWYJGFcl27q/l6U9Ke+vCZia/80E9WbKzw5bW80FDTHlxkn2f3WV
        qK9MZK/AT70jc5+nz0o5XVsD5A==
X-Google-Smtp-Source: AFSGD/UQoBYqX1BBJuKVNkmeRiFPzXHbwqEoRVZBtPZGoTjbEdyHMbG0r+ilnrci8uAgaNV12TPK0A==
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr6496603ljj.146.1543401842378;
        Wed, 28 Nov 2018 02:44:02 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/10] regulator: lp8788-ldo: Let core handle GPIO descriptor
Date:   Wed, 28 Nov 2018 11:43:43 +0100
Message-Id: <20181128104350.31902-4-linus.walleij@linaro.org>
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

Fixes: 2468f0d51548 ("regulator: lp8788-ldo: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/lp8788-ldo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 553b4790050f..416d073ec62c 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -502,7 +502,7 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 	}
 
 	/* FIXME: check default mode for GPIO here: high or low? */
-	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
+	ldo->ena_gpiod = gpiod_get_index_optional(&pdev->dev,
 					       "enable",
 					       enable_id,
 					       GPIOD_OUT_HIGH |
@@ -548,6 +548,8 @@ static int lp8788_dldo_probe(struct platform_device *pdev)
 
 	rdev = devm_regulator_register(&pdev->dev, &lp8788_dldo_desc[id], &cfg);
 	if (IS_ERR(rdev)) {
+		if (ldo->ena_gpiod)
+			gpiod_put(ldo->ena_gpiod);
 		ret = PTR_ERR(rdev);
 		dev_err(&pdev->dev, "DLDO%d regulator register err = %d\n",
 				id + 1, ret);
-- 
2.19.1

