Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D2AC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4828D21473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="huONIq9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4828D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeLBDGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39007 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeLBDGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so7622820ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pq6EvrtcoHql5+ikFxa5KOOUuE702pUaeiFm45YZFag=;
        b=huONIq9xiOiCPKdaxpYnglZ90lOJ54IJVNZpMR2kMhewCKA0wlqAs1IgE0stbSmHBN
         bbqEDhA+k2i7sumjFv/YdI9+qx5pF0ZhVf7kwgpnTuKr3uhniUKF/8mCUHcbE3YHYAWr
         9rcbabr9OvsfpJHKEqichuGOFEBPG7otpaZ3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pq6EvrtcoHql5+ikFxa5KOOUuE702pUaeiFm45YZFag=;
        b=tWtfhw5oHTsV4F2HJRx7oFT2PWMd4BPhQ7ihyXSdmD12Kphu8EJkq+cBBG5HA2zOzZ
         QrvFY9KKYA29+e3YfprYA9++0knCYj6A6XEZgRam+lopaMIkD28RZvsakKrec6gdR8Z2
         gj1wx7joXY3hw3gNhjwE0cd75w7tRg18NSyTQfmUbC2k8Beryni3PBXyWXT0iTJn+ggV
         D+5uOHGbOzGvHiGyW7Dmm8gCQ2mIbXqk5wsdIRI7F4VuRRSr5GvfUo9EKnnr/X80japS
         ckO5oo3ge3RbTcJW4+I1g9HI5LWIQmoeT31pzWOSBXR2mE8TuLE8rRSk821syOX6ADJF
         iIFA==
X-Gm-Message-State: AA+aEWYAC5mkkFLCXF97SllakuuZBvyNgoZBTKAoH6FUHvSvNhedQsoz
        2iBjD22ZWy2sZwWhLfUTgGP7sQ==
X-Google-Smtp-Source: AFSGD/U/7IGnKE0tmCd/tblmG66JchUKuEUtRG5E2RCtXrZ8EhYk0HQG6ok2aQHHRnd4EnntLJQ4Rg==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr6173396ljk.114.1543679592216;
        Sat, 01 Dec 2018 07:53:12 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/13 v2] regulator: max8952: Let core handle GPIO descriptor
Date:   Sat,  1 Dec 2018 16:41:43 +0100
Message-Id: <20181201154151.14890-6-linus.walleij@linaro.org>
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

Fixes: d7a261c2d1f2 ("regulator: max8952: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop the gpiod_put() on the errorpath after devm_regulator_register()
  as this will be handled by the regulator core.
- Put a comment in the code so maintainers knows not to
  use managed resources (devm*)
---
 drivers/regulator/max8952.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 6c39fff73b8a..cf2a2912cb1b 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -231,9 +231,13 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	else
 		gflags = GPIOD_OUT_LOW;
 	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
-	gpiod = devm_gpiod_get_optional(&client->dev,
-					"max8952,en",
-					gflags);
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 */
+	gpiod = gpiod_get_optional(&client->dev,
+				   "max8952,en",
+				   gflags);
 	if (IS_ERR(gpiod))
 		return PTR_ERR(gpiod);
 	if (gpiod)
-- 
2.19.1

