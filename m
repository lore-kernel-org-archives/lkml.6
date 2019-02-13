Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B39C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E0E222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbvStbwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfBMM5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:57:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45372 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBMM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:57:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so1110763pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CPPv6Jzg9P/aebeLf3ZxPc0L74Cg5kK5kTUL5QG7TZQ=;
        b=lbvStbwnN6iVzruVupgQavG0FGIyVz7Xj6SORlC4Wy4TkALjN3LUlw0het8EZFCOgy
         W0HqLTuTwwvl8pA7DKHuHs3+a8/uLeVCIMRKo6FZ1suT5gIBgFKeZ4PnWo5+Ufcih4AN
         JrOZk+9+bg27HntKEX3SjLGk2km2gBarx/81ZBpCaq0QGKKdD8HekgnEsdIm6De6FAXe
         hHTo2G8uNe1BdeIO7ag5wL5v09swgKLJTB8fynNyaA88jv1sFwi5suKi7L6WM9pwYy5C
         11YS4r+cZ4QzW6gGF/3QI0F5yUQ0iViuukp8G5jGErviqL1xCtsB3+5ngCbM5mNGVZcE
         4zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CPPv6Jzg9P/aebeLf3ZxPc0L74Cg5kK5kTUL5QG7TZQ=;
        b=YutPLqlnoKADpJZ/KoachK4E45crieh5atKlif0rOHUvJBs1FaYhKAePPA3dndDW9l
         uOcL6tEyFXaypXHOfKQ2mxUpMmlufbPoY3i36lSRvTNlKYriGR6J+i+MduSZ3hrGiMCq
         dSNNiiIkS3AhtmVgX4wawtsKgv3Bhe4J6+APuk23KX6S1kmh/frryJH9NhmnIo0sCuF6
         fotB+8cDFqYBBO8K9WuoThtXnw/YhAlTegGlPOaS4iQeqk7dR65wMCNUEr0gT7pjYUEa
         LN+PURIYmoKVubCCsxMgIxY8kVfBJMINhD1ZBOuuunkhUlyF8ndECNG0LhF3bP402HP0
         zzgQ==
X-Gm-Message-State: AHQUAuYgOrAlRHvBCOqYYKepPg+HiiiIFr/mJU/9Eel4/xwms2doY1G4
        V/qlrptihUnWucFdfion8AGe9w==
X-Google-Smtp-Source: AHgI3IZLHC0M5alZT70dmSyCihFsy1bFfjpB6FcxCtUu3DxEg2KAE1gKqbGG1r7zB6wgsuxENyIVOA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr430375pld.184.1550062653156;
        Wed, 13 Feb 2019 04:57:33 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v9sm19336871pgs.3.2019.02.13.04.57.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:57:32 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     lee.jones@linaro.org
Cc:     arnd@arndb.de, broonie@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sc27xx: Use SoC compatible string for PMIC devices
Date:   Wed, 13 Feb 2019 20:56:19 +0800
Message-Id: <3d1f18412a927f69c733b6ed31659b7770610442.1550062410.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use SoC compatible string in stead of wildcard string for
PMIC child devices.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mfd/sprd-sc27xx-spi.c |   42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 69df277..43ac716 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -53,67 +53,67 @@ struct sprd_pmic_data {
 static const struct mfd_cell sprd_pmic_devs[] = {
 	{
 		.name = "sc27xx-wdt",
-		.of_compatible = "sprd,sc27xx-wdt",
+		.of_compatible = "sprd,sc2731-wdt",
 	}, {
 		.name = "sc27xx-rtc",
-		.of_compatible = "sprd,sc27xx-rtc",
+		.of_compatible = "sprd,sc2731-rtc",
 	}, {
 		.name = "sc27xx-charger",
-		.of_compatible = "sprd,sc27xx-charger",
+		.of_compatible = "sprd,sc2731-charger",
 	}, {
 		.name = "sc27xx-chg-timer",
-		.of_compatible = "sprd,sc27xx-chg-timer",
+		.of_compatible = "sprd,sc2731-chg-timer",
 	}, {
 		.name = "sc27xx-fast-chg",
-		.of_compatible = "sprd,sc27xx-fast-chg",
+		.of_compatible = "sprd,sc2731-fast-chg",
 	}, {
 		.name = "sc27xx-chg-wdt",
-		.of_compatible = "sprd,sc27xx-chg-wdt",
+		.of_compatible = "sprd,sc2731-chg-wdt",
 	}, {
 		.name = "sc27xx-typec",
-		.of_compatible = "sprd,sc27xx-typec",
+		.of_compatible = "sprd,sc2731-typec",
 	}, {
 		.name = "sc27xx-flash",
-		.of_compatible = "sprd,sc27xx-flash",
+		.of_compatible = "sprd,sc2731-flash",
 	}, {
 		.name = "sc27xx-eic",
-		.of_compatible = "sprd,sc27xx-eic",
+		.of_compatible = "sprd,sc2731-eic",
 	}, {
 		.name = "sc27xx-efuse",
-		.of_compatible = "sprd,sc27xx-efuse",
+		.of_compatible = "sprd,sc2731-efuse",
 	}, {
 		.name = "sc27xx-thermal",
-		.of_compatible = "sprd,sc27xx-thermal",
+		.of_compatible = "sprd,sc2731-thermal",
 	}, {
 		.name = "sc27xx-adc",
-		.of_compatible = "sprd,sc27xx-adc",
+		.of_compatible = "sprd,sc2731-adc",
 	}, {
 		.name = "sc27xx-audio-codec",
-		.of_compatible = "sprd,sc27xx-audio-codec",
+		.of_compatible = "sprd,sc2731-audio-codec",
 	}, {
 		.name = "sc27xx-regulator",
-		.of_compatible = "sprd,sc27xx-regulator",
+		.of_compatible = "sprd,sc2731-regulator",
 	}, {
 		.name = "sc27xx-vibrator",
-		.of_compatible = "sprd,sc27xx-vibrator",
+		.of_compatible = "sprd,sc2731-vibrator",
 	}, {
 		.name = "sc27xx-keypad-led",
-		.of_compatible = "sprd,sc27xx-keypad-led",
+		.of_compatible = "sprd,sc2731-keypad-led",
 	}, {
 		.name = "sc27xx-bltc",
-		.of_compatible = "sprd,sc27xx-bltc",
+		.of_compatible = "sprd,sc2731-bltc",
 	}, {
 		.name = "sc27xx-fgu",
-		.of_compatible = "sprd,sc27xx-fgu",
+		.of_compatible = "sprd,sc2731-fgu",
 	}, {
 		.name = "sc27xx-7sreset",
-		.of_compatible = "sprd,sc27xx-7sreset",
+		.of_compatible = "sprd,sc2731-7sreset",
 	}, {
 		.name = "sc27xx-poweroff",
-		.of_compatible = "sprd,sc27xx-poweroff",
+		.of_compatible = "sprd,sc2731-poweroff",
 	}, {
 		.name = "sc27xx-syscon",
-		.of_compatible = "sprd,sc27xx-syscon",
+		.of_compatible = "sprd,sc2731-syscon",
 	},
 };
 
-- 
1.7.9.5

