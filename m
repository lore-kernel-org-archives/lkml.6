Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339CAECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F4820647
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJAy8NjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F4820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGUBDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 21:03:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38210 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeGUBDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 21:03:17 -0400
Received: by mail-it0-f66.google.com with SMTP id v71-v6so16723557itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=01kAA8Gx9bfJinHEJzBec7mAnldCS7OcBanPkghUBOk=;
        b=iJAy8NjYpoKEJLpjTQGbKh4EKG/8aGJY0Ff38i4F+jpgUmFE3r86JuANFmWoVXRclD
         Tlwq6t49mv32DneWXYliANKVdye9lOCS8lvNWpo0J6kywLBj5bPXiPJfJShKgv0TZ0o8
         z73c0Fj/2ihV1uGTLwyP2gjBZLP0mQ09DKME8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=01kAA8Gx9bfJinHEJzBec7mAnldCS7OcBanPkghUBOk=;
        b=K31Yu81vK0p2gKyNqrUcfTXH87oicLaYuc0xqzUVM8MIK2moTsq/pO9jdRiXS/gRtk
         kvl0e4THeZB4AmtwZzE07Lnmvzzq28qNkfZriBEhc/kN3r94WOU/jvTTzUEdXEqg0VJC
         7Myjm0Mib83r5EgD7CLbvQIiyZNnqLj+tqudypnxdxfEiWV3EMhIudmppn/4J9GlVlUW
         7fNDG2R0XmBNp5nzbI5fGa37iy5VtqeTxBoHjVOQOdGOb8MHj91dNlSSBfxQ2m4wyGgq
         cE8fZfvc/ovmLZiSB5XTB6xLLWb9vMMz36X0TN5LbXwu9lyoJ7OD/026DDJ+zxnTdnlk
         S9eA==
X-Gm-Message-State: AOUpUlE175TuzV2pXeSm3Tjwh9YxCUABX+4qcmuylt/4xqVuYDSgWFzI
        XMZQIeOXar8eNkuP/RNtmhTX/g==
X-Google-Smtp-Source: AAOMgpcggZQU+4wwnefrxBllp4iVpTurlkVQK/mhamgs3Swc4j6h6fe84lpmVAgsAf6Vj2/bDtApKA==
X-Received: by 2002:a24:624f:: with SMTP id d76-v6mr3571576itc.78.1532131961511;
        Fri, 20 Jul 2018 17:12:41 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id e19-v6sm1014142ioc.46.2018.07.20.17.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 17:12:40 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: da7219: Allow pdata to specify a VDDIO
Date:   Fri, 20 Jul 2018 18:12:35 -0600
Message-Id: <20180721001235.164891-1-djkurtz@chromium.org>
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

This patch tries to solve the same problem as in the following patches,
but does so in a way that doesn't require registering fixed regulators in
the audio machine-driver:
  https://patchwork.kernel.org/patch/10531097 & 10531099
  https://patchwork.kernel.org/patch/10536023/

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
index 980a6a8bf56d38..d8f202c57f958d 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1634,6 +1634,9 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 	else
 		pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;
 
+	if (!device_property_read_string(dev, "dlg,vddio", &of_val32))
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

