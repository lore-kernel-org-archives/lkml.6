Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B6CECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F502075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ev9VbxzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F502075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeGRBYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:24:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37895 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbeGRBYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:24:34 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so1774671itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gCuAeFsBocnt2TCTl7l3vZ0A5Xa/gAxFCMcGKMOHw8=;
        b=Ev9VbxzDs4yOyQYKXTJRuhlyu+cqHXdI/KK4viZEyIsIr7nK5Q72NpH56RJ9tOoS0C
         NnhZkUrtjW/2y3PQ67Y+O6V6vs78LIE6rjRrfZXNAXDjLxJTBSh58guoXxanSjH4JdYB
         8dssivMqgjbSNOiehaptvXUzzSiTsaHXGZG9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5gCuAeFsBocnt2TCTl7l3vZ0A5Xa/gAxFCMcGKMOHw8=;
        b=k5ucQiQ2r5IztUJ3F0+DVZ9ziBgolpeGJNYVGYOFmWdz2yioL9OEbuD43mHisW6hHx
         KyifUUC/6f0r7940d/5hexgTppG3aoodqltKR3LOdbKkyz8PhX1O/BYs7gIteadd3VHM
         9lOG4fnQhW4cBnPjnd4JQCcGnxG3BsmyIL3J2D/u0EzfDQTH7cj19pYGJnpKarg7WZHx
         4OoLS73/tXjG4gZ9PcqUrYlWD8x0rbV1W6chW2sW95AvMH2fUt6vkQG2yXPUXca4CJ7S
         wUii+TeuWLHRdrwdaTtoc1JTgpZEtgMK07RWLhFNM8YK8A7K8D8oWKHKyPNghz5Nb86D
         LPaA==
X-Gm-Message-State: AOUpUlG3RffsTytfLzjgcnBsAEf+a/A1wOpdGw+jvrBbuvRndglWjVgL
        WDjX+y8JdOMR7MhgvRDrYsZnkjzWMJU=
X-Google-Smtp-Source: AAOMgpcAINcDbns3QGEIjjX9sYQ8zSEEaKKx6oOn9p1+iqQEqKrbYBtHjjG6qSTLvusfHgDi5dyc/g==
X-Received: by 2002:a24:e4cf:: with SMTP id o198-v6mr286413ith.21.1531874962458;
        Tue, 17 Jul 2018 17:49:22 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id z71-v6sm3275425ioz.34.2018.07.17.17.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 17:49:22 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ASoC: AMD: Add an always on fixed 1.8V regulator for da7219 VDDIO
Date:   Tue, 17 Jul 2018 18:49:09 -0600
Message-Id: <20180718004909.213735-3-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180718004909.213735-1-djkurtz@chromium.org>
References: <20180718004909.213735-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

DA7219's VDDIO for our platform need to be configured for 1.8V.
Hence we register a fixed 1.8V voltage regulator in the machine driver.

Change-Id: I65fd93e1dd37c3e0d38265b4b1492ea53b93afd4
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp-da7219-max98357a.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 6cbf9cf4d1a4c2..58c1dcb4d2550f 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -8,6 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
+	select REGULATOR
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc6650b9c79..6ea0f42f5b7692 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -32,6 +32,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
@@ -278,11 +280,23 @@ static struct snd_soc_card cz_card = {
 	.num_controls = ARRAY_SIZE(cz_mc_controls),
 };
 
+static struct regulator_consumer_supply acp_da7219_supplies[] = {
+	REGULATOR_SUPPLY("VDDIO", "i2c-DLGS7219:00")
+};
+
 static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp_platform_info *machine;
+	struct platform_device *reg;
+
+	reg = regulator_register_always_on(0, "fixed-1.8V",
+					   acp_da7219_supplies,
+					   ARRAY_SIZE(acp_da7219_supplies),
+					   1800000);
+	if (!reg)
+		return -ENOMEM;
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
 			       GFP_KERNEL);
-- 
2.18.0.203.gfac676dfb9-goog

