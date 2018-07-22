Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E026BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF972075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aj1LIbpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF972075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGWA0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 20:26:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44071 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGWA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 20:26:51 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so14114732ioh.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lXYAkWMrTXMvydA4fDC57KPIQEb94LnE1NrDFLI3MDY=;
        b=Aj1LIbpaJaIEUZwSZs6L/QboaqBAYgK0IsG/xkAiKWpgwcOOLFAhyJ6Yr/kkzkqAAZ
         bqA1c0asnR2SZ1o6tfhiZ4Ko7IKbr9cQVNrwzb2iZEfS1qb2MlpGDVzo6VdzXY1U1Y9F
         +8CPjgvT9GfNMoTybjJl5n+jVnwH7cYlJ0fAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lXYAkWMrTXMvydA4fDC57KPIQEb94LnE1NrDFLI3MDY=;
        b=cUrGYQ89EC4LhP2JiF6YhD1SzWohEP+20b2bcDkWuP12WBoICwiMYW/m3UwjXlJN6U
         mA3osV+NEWrcTSjVj/VrZwrKm02Z1dijv+iLxx8Ffy+mhIgM2E+C2pwtYzq2GfPcSm9p
         b/6siC/pCPnawf7RTT2SLtjLwSjRlz8JUpMwH1uk1Fe6+4iAXHXmcxloSTXL8rLEc/1C
         1ukaJy8HudYjjXawxy4b1GoF0rLmQaxujjSP/FVDBQZs2IaGEGqMbuIuXP2Fxg6D4OsZ
         LdWoMyxdLeXnZSaEUgdd6och2rJeL/H6VaPoYPJoKRvkMod2XIt1LoME0QuywRnmAzVd
         V5tA==
X-Gm-Message-State: AOUpUlFqOIkqnbYnwgdraCezp2w2Xv52jFT66v4J04RRFetAOxozTCqV
        llsL1Km7THO0X1gFYI55NlqDkA==
X-Google-Smtp-Source: AAOMgpfdl/mK/JWSbZaZOiG+WdkOvtH2jzENJWBCi0eEGqrYj4MEr2UpGngAZHQJpuyXHkqYz4LlgQ==
X-Received: by 2002:a6b:a715:: with SMTP id q21-v6mr8353954ioe.61.1532302106558;
        Sun, 22 Jul 2018 16:28:26 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id f24-v6sm2334281ioc.52.2018.07.22.16.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 16:28:25 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ASoC: da7219: Allow pdata to specify a VDDIO
Date:   Sun, 22 Jul 2018 17:28:22 -0600
Message-Id: <20180722232822.34641-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems do not have software controllable regulators driving the
DA7219's supplies, nor can they use device tree to create "always-on fixed
regulators" to easily pretend like they do.

On these systems the call to devm_regulator_bulk_get() just creates
a set of dummy registers.  Calling regulator_get_voltage() on a dummy
regulator just returns -EINVAL, in which case the DA7219 is always set up
to use the default VDDIO voltage range of 2.5-3.6V.

Provide a new device property to let such systems specify a different
VDDIO if needed (e.g., 1.8V).

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
Changes for v2:
 - fix to use device_property_read_u32()

 include/sound/da7219.h    |  2 ++
 sound/soc/codecs/da7219.c | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 1bfcb16f2d10ab..16ab125ad4adbf 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -38,6 +38,8 @@ struct da7219_pdata {
 
 	const char *dai_clks_name;
 
+	u32 vddio;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 980a6a8bf56d38..9893920b26f41f 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1634,6 +1634,9 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 	else
 		pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;
 
+	if (device_property_read_u32(dev, "dlg,vddio", &of_val32) >= 0)
+		pdata->vddio = of_val32;
+
 	return pdata;
 }
 
@@ -1717,8 +1720,12 @@ static int da7219_handle_supplies(struct snd_soc_component *component)
 	/* Determine VDDIO voltage provided */
 	vddio = da7219->supplies[DA7219_SUPPLY_VDDIO].consumer;
 	ret = regulator_get_voltage(vddio);
+	/* If regulator_get_voltage() fails, try to use vddio from pdata. */
+	if (ret < 0 && da7219->pdata)
+		ret = da7219->pdata->vddio;
 	if (ret < 1200000)
-		dev_warn(component->dev, "Invalid VDDIO voltage\n");
+		dev_warn(component->dev, "Invalid VDDIO voltage: %d mV\n",
+			 ret);
 	else if (ret < 2800000)
 		io_voltage_lvl = DA7219_IO_VOLTAGE_LEVEL_1_2V_2_8V;
 
@@ -1872,6 +1879,11 @@ static int da7219_probe(struct snd_soc_component *component)
 	mutex_init(&da7219->ctrl_lock);
 	mutex_init(&da7219->pll_lock);
 
+	/* Handle DT/ACPI/Platform data */
+	da7219->pdata = dev_get_platdata(component->dev);
+	if (!da7219->pdata)
+		da7219->pdata = da7219_fw_to_pdata(component);
+
 	/* Regulator configuration */
 	ret = da7219_handle_supplies(component);
 	if (ret)
@@ -1897,11 +1909,6 @@ static int da7219_probe(struct snd_soc_component *component)
 		break;
 	}
 
-	/* Handle DT/ACPI/Platform data */
-	da7219->pdata = dev_get_platdata(component->dev);
-	if (!da7219->pdata)
-		da7219->pdata = da7219_fw_to_pdata(component);
-
 	da7219_handle_pdata(component);
 
 	/* Check if MCLK provided */
-- 
2.18.0.233.g985f88cf7e-goog

