Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44797C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F5820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F5820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394221AbeKVVCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:02:36 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:48298 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394192AbeKVVCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:36 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 43CE95FCA9; Thu, 22 Nov 2018 18:23:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v9 2/8] ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply
Date:   Thu, 22 Nov 2018 18:23:19 +0800
Message-Id: <20181122102325.29495-3-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Allwinner A64 SoCs, the audio codec has a built-in headphone
amplifier. This amplifier has a power supply separate from the rest of
the analog audio circuitry, labeled cpvdd.

This patch adds a DAPM widget for this supply, and ties it to the
headphone amp widget.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 8f5f999df631..df1fed0aa001 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -274,6 +274,7 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
+	SND_SOC_DAPM_REGULATOR_SUPPLY("hpvcc", 0, 0),
 	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
@@ -361,6 +362,7 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
 	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
 	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "Headphone Amp", NULL, "hpvcc" },
 	{ "HP", NULL, "Headphone Amp" },
 
 	/* Microphone Routes */
-- 
2.19.1

