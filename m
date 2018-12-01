Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46844C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A3720834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JThfbg/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A3720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLBDGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45217 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeLBDGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6179743lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRRqVVwMz5ixbamRKAl9gUoe/zOElJopLPpSl/n7en4=;
        b=JThfbg/lOMn+xzuNaXHGw5fxxc6JgwX3c8sTa9g9M1xQwp2EdSRPgWwBwkTv5fyiAG
         Q3e3FBWNCQNW7ilQSIPXLa4S5eNrDgiL1yYMZoxNu/gVHPnb4ljyOvTejUHcuP091y8Y
         VNgyfKsYQnhYGgaRvJ7otQBDfkt20Rl5yEbrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRRqVVwMz5ixbamRKAl9gUoe/zOElJopLPpSl/n7en4=;
        b=kw3Wgz64FSedQb7Fnpx6FFROYB5GTjelVTjY0h922aCz1tbgpHCjQhjC6dfTa09Uas
         hNnJGF67iH9HwqoOHPd/bF9vYohBMNm88gWijxRr6N/avlE7glbCjaQWEz+pJC3AZILN
         Dhy7zPHJXVFqO6Ilve3GUwpK0z4HGWu+0pyk0jMogtZrqfyaHRZORjRWWOBhuWvhshRi
         6cezyzIEgsnoJ6hbiyJl8yxtiuAiFHAlEZtkERyiIf6H3g0OMmHKiK/9jGmF0g/bKFwR
         0Ga/yb6wv0AzQaKUaMFs+Me2PIJSMwz/7DBowPa0oDsN90zS4/+oB5qKdTo5Y8uR3igJ
         WhIw==
X-Gm-Message-State: AA+aEWb6Mas2aylV2vKPMOQY2NVc/+Kuq8HGt61cmFNoYI2KOp2pQ+F+
        CWBW4wZ1PTpOcGflJWA/GVVQ6g==
X-Google-Smtp-Source: AFSGD/VJpCOCB7CUnIR+AxwYNRDLs6nRSYrC9f6OHv0tOG6hLpf2++rze+tuBU7hCzoTJxhOIfwrUQ==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr6080583lfi.21.1543679590022;
        Sat, 01 Dec 2018 07:53:10 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/13 v2] regulator: lp8788-ldo: Let core handle GPIO descriptor
Date:   Sat,  1 Dec 2018 16:41:42 +0100
Message-Id: <20181201154151.14890-5-linus.walleij@linaro.org>
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

Fixes: 2468f0d51548 ("regulator: lp8788-ldo: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
2.19.1

