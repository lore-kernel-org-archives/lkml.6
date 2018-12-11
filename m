Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3076C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8692082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfuZnd1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8692082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeLKJxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:53:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46223 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeLKJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:53:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so12327518ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kanK1ADQJ84RZMElpetldmLcARBv+ZdrFC6bdBVdaw=;
        b=cfuZnd1zXhBa64EQ/9iHYJtaxeXlNRbaB+Mr0uhl0pePo780Axff1DLmWXVObPCBI5
         BgQKsF9EpB+tY32WbwwXTqNcfJtMG3HapRGCRJ3qpXz5HR78YlpwODSHiHWqnSWw4fH7
         +sysjCR/Y4ue9IbvJ9RwhGsQHVZvTA0T47qNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kanK1ADQJ84RZMElpetldmLcARBv+ZdrFC6bdBVdaw=;
        b=TA5a0gESXsb1iSotGya+tXUsNd3R33OsFt3AOYCUfzIWwkuL2kZdI7sBh5tZFFHif8
         atSQvDMlBPif/xEfb2DUxmta1QO16hpVd1tWz8Vt2Ao+Es5yTVFBoefljwgaMYfs0HGo
         P8YyDlSlnXCT1vcpnTqPuOhA14UVKaEpflq7M/kdO3fA37g5Qt/tF/Q6VwzfHs9pyeAy
         XrXpi5iQIbge+6JyezgXbPjBrYttJDo3e3JvI2yyBe/yleCLtd2IrSfGhB7PZM54t+1g
         aH4gTZ/0M5swS9ou6mjeiisLiNMKyJ3jnRrtTaEolKKiPyetTwBdxpIgDsHM7AWLBUrz
         VyxQ==
X-Gm-Message-State: AA+aEWahcaoonYA48qwzrrTfbPv4AJZH1I30nw9ekUi1HZa6T3wV1vgm
        /sv9FY06ugDUYf5Uk+pOdV+0/w==
X-Google-Smtp-Source: AFSGD/Wu8aovULE0iG4MvxAiwtQmG4/r96avJDGj9U33OhySOsOUMwQK6mij08uNzquKf4EmCBFkVg==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr8993900ljd.137.1544522006429;
        Tue, 11 Dec 2018 01:53:26 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u30sm2740505lfc.90.2018.12.11.01.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 01:53:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] regulator: arizona-ldo1: Rely on core to handle GPIO descriptor
Date:   Tue, 11 Dec 2018 10:53:19 +0100
Message-Id: <20181211095319.11393-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211095319.11393-1-linus.walleij@linaro.org>
References: <20181211095319.11393-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After making sure that the regulator core always take over
handling of the GPIO descriptors, the gpiod_put()
on the errorpath of the Arizona LDO1 driver becomes
redundant.

Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/arizona-ldo1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 9a72eae4926d..b9a93049e41e 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -283,9 +283,6 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
 	of_node_put(config.of_node);
 
 	if (IS_ERR(ldo1->regulator)) {
-		if (config.ena_gpiod)
-			gpiod_put(config.ena_gpiod);
-
 		ret = PTR_ERR(ldo1->regulator);
 		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
 			ret);
-- 
2.19.2

