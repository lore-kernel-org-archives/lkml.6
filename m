Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E6DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F373D208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui+zLHTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F373D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeLFMoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:44:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46785 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbeLFMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:44:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so210797lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/2aw+P83R8elX2tp0ut9Zm1k1q1tBogpgmcBikeeU0=;
        b=Ui+zLHTpafJQyKa25wAkhePyr5xNBilE4jN/WQ5QNhqvVoUhFUlI+0sqFvLIkJgkO7
         dLTgZ5hYpqbBTZn5nW1g9hv8hIEiMMEDzqCzTwOr84M/mOZTxO2jtqHfiz5lA/uobIvF
         uiCu+ZDPRzEQKcSvRxzpJSx7ACOsr8+8fV87Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/2aw+P83R8elX2tp0ut9Zm1k1q1tBogpgmcBikeeU0=;
        b=dA4zGxaF+KuYrinVzgm5RYz40zz/zDoTmwndW461y3bsQF1sH2r7xUlEvIFH433Hl+
         YN5moL7PsuTJjn0Xz/1+eIKoWkGId+3P1623YxCGJ0i+1f4XhQDJf+EXNZZBM6lcm83C
         Hv5q7Uw2252M6mhmIG19CX/BRcF/lJD34f8u1vVdzwbNBAGR7Q4m/QjQmjzsmmNecMwj
         Aru6v6BtDBn5eJpbgPF3itmkess32Tl2yro8MY6N4eE6nnPekECQw0tChMRbLBcxKyIb
         lB51YZc++MiCePqw2LMrc3bSEC0vLkWsmyXp9S7w1/h4BoLigfAqe9u7HnHw9NoQzelu
         lILw==
X-Gm-Message-State: AA+aEWa4WNL0Ne0BSxJ1GZRqG87vifEM7pIZ3yHJ4sCgl+0e8MQLFyLf
        2pIX0FipfmA8iFLM9Rae6jQ2HA==
X-Google-Smtp-Source: AFSGD/UAJmWsdl9/inKM+Z1PIj1BNq8CVUSc40FvaLQfhIP4I6LjQ/0Nn8V4FMnaKT/gQU1XiaeylQ==
X-Received: by 2002:a19:d857:: with SMTP id p84mr16351987lfg.44.1544100250347;
        Thu, 06 Dec 2018 04:44:10 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:44:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/15 v4] regulator: max8952: Let core handle GPIO descriptor
Date:   Thu,  6 Dec 2018 13:43:41 +0100
Message-Id: <20181206124351.10155-6-linus.walleij@linaro.org>
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

Fixes: d7a261c2d1f2 ("regulator: max8952: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Resending.
ChangeLog v2->v3:
- Resending.
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
2.19.2

