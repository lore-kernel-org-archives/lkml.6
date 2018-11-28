Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZyYbkFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC4E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeK1Vpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:45:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44764 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeK1Vpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:45:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so22951515lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1uQOl0jE+lEJ7qDRZSdw84mH6vUDxYf8b4kB11Qb3Ug=;
        b=UZyYbkFkpBwC3HkfdV23mGo6Oa+RM6a5ahe7ykaVE1nNS065LIt5QBJi+PC/Nwv5Py
         xaRlZGfBUmbND2jpEnHf3PEBjF+izNKix37xIQI6T+qL8IcV1La3HC2t1FvHEG3ZiEI7
         HB3kH+LQ7KUQAIOzdF7k8PNUgI/c+BvGC31mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1uQOl0jE+lEJ7qDRZSdw84mH6vUDxYf8b4kB11Qb3Ug=;
        b=JUICw78jaaFkPFxVP8BKksMuCS6TeT3heCxAazaq7caQg6F6RDgIXCdEYzyjK8wE40
         VB20sqHaPwzKsdwact/oOpuCPOhXDWwSCUIrwXrQfi8DrQFQ6gkGQA5gYQD8kr9S5wDH
         95wiCyKMV0KYYHG42kiFt7CkUbpbXJ675k3bmxSY4EF0Qa/rUxiHsNalNLTnnZAon7HU
         2vs8PfRMgX8ygEjEcmHDtC0nABctCBdYyCckP6iUvcMPNAmKygD/KZUxTf9aCuRAgDJU
         xeW3aKm8FivSjWwymQzkTiYoqjMHX3dD0dgolJoVUSN+8oen2zd9zC1EkcV1+lqFr6s4
         sc8w==
X-Gm-Message-State: AGRZ1gIiGiJ50NWIiSyfhTV5GScqOD4tdenyzLNY2QoS/jC3n89i0eIM
        MXCQ8Eh2sscRwFT47j1eIr/e2w==
X-Google-Smtp-Source: AFSGD/VL7UBmyNixAZ5ZRNxKeg/uvcuobxNJG1ZVHglYWS2Vdhuf4WQ3tMb571r7SxoMqEpnAFhgDw==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr22045671ljr.91.1543401856328;
        Wed, 28 Nov 2018 02:44:16 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c20sm1095101lfj.67.2018.11.28.02.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 02:44:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/10] regulator: tps65090: Let core handle GPIO descriptors
Date:   Wed, 28 Nov 2018 11:43:50 +0100
Message-Id: <20181128104350.31902-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
References: <20181128104350.31902-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod_get_from_of_node() rather than the devm_*
version so that the regulator core can handle the lifecycle
of these descriptors.

This patch requires "gpio: Export gpiod_get_from_of_node()"
to be applied first.

Fixes: 3012e81446d0 ("regulator: tps65090: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/tps65090-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index db714d5edafc..223f6974a9f3 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -376,11 +376,11 @@ static struct tps65090_platform_data *tps65090_parse_dt_reg_data(
 				gflags = GPIOD_OUT_LOW;
 			gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-			rpdata->gpiod = devm_gpiod_get_from_of_node(&pdev->dev,
-								    tps65090_matches[idx].of_node,
-								    "dcdc-ext-control-gpios", 0,
-								    gflags,
-								    "tps65090");
+			rpdata->gpiod = gpiod_get_from_of_node(
+						tps65090_matches[idx].of_node,
+						"dcdc-ext-control-gpios", 0,
+						gflags,
+						"tps65090");
 			if (IS_ERR(rpdata->gpiod))
 				return ERR_CAST(rpdata->gpiod);
 			if (!rpdata->gpiod)
-- 
2.19.1

