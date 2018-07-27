Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D50C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5777C208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMzmuAi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5777C208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbeG0Nmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:42:45 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35079 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbeG0NmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:42:18 -0400
Received: by mail-wm0-f41.google.com with SMTP id o18-v6so5303627wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZK3aZZmMS5jIsxS4UJebqaLkFNDfvrcm6KnJrtXhjs=;
        b=dMzmuAi3tWaVm8AiF5df/j+hLlE2ls3dAB92TcAPG+9s4LfB/RcPlKskycWb0i9EBI
         7XQdRMZINlIvaQBCt2TLw5ptFVTmHu4yjPycyTOPh7EfsWQ/vTnoNYm8tkFsv+GuDqcd
         pgnNAAzi2zfRuNjDKD9PjFLBEhYcurupaVspU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZK3aZZmMS5jIsxS4UJebqaLkFNDfvrcm6KnJrtXhjs=;
        b=ITjWeMOyIz4HV9kyKnnE8DPVl85aqeM0+J3Dax7dlYiCxIpEJkFEZshe1DXHb3Ie5M
         Vwayr85mFxSry1M5MQzo2qDxfYmyLnrxXvLjgV0VdzSj9MCWQYPaJz8anNFgaasRw+qy
         4WhgcEphvE7wp8dC0g8WEyTmbe7jbfDqdIZkuAuvuN5gO5+vEncXgzWju3/5IIzTqOYI
         hOUUbjuux48irzkKZkWPVPg/xTJnbJneVJ1K0oDxQiu7S92MFRBdW+voUjO1SL5s4Tub
         eJopzHcuF+h3v7alSYJa3AQOq1GROtNNXJALV5aJVuDTg0GR2g1h2z56jVqfIhx5eSWR
         d4XA==
X-Gm-Message-State: AOUpUlGAdeYUlE287aQAEZ2eqXjSJivWEswg3aUROk9dVzrbZLAKOOPO
        IZbp5Rc21w/ArjhgEbHi1FZ/dg==
X-Google-Smtp-Source: AAOMgpdIKmeKjvNLcJ9fIbOcmFcvxCHgxRJ9NxqquC2dEpjJI9ezVe0wB5czaOqyU8Dg3tJOgteCTg==
X-Received: by 2002:a1c:5f56:: with SMTP id t83-v6mr4380246wmb.27.1532694036279;
        Fri, 27 Jul 2018 05:20:36 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6178522wmf.41.2018.07.27.05.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 05:20:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 09/10] ASoC: wcd9335: add audio routings
Date:   Fri, 27 Jul 2018 13:18:05 +0100
Message-Id: <20180727121806.18209-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 189 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 55b5582144ef..b5a388966a43 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -102,6 +102,67 @@
 /* vout step value */
 #define WCD9335_CALCULATE_VOUT_D(req_mv) (((req_mv - 650) * 10) / 25)
 
+#define WCD9335_INTERPOLATOR_PATH(id)			\
+	{"RX INT" #id "_1 MIX1 INP0", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_1 MIX1 INP0", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_1 MIX1 INP1", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_1 MIX1 INP2", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_2 MUX", "RX0", "SLIM RX0"},	\
+	{"RX INT" #id "_2 MUX", "RX1", "SLIM RX1"},	\
+	{"RX INT" #id "_2 MUX", "RX2", "SLIM RX2"},	\
+	{"RX INT" #id "_2 MUX", "RX3", "SLIM RX3"},	\
+	{"RX INT" #id "_2 MUX", "RX4", "SLIM RX4"},	\
+	{"RX INT" #id "_2 MUX", "RX5", "SLIM RX5"},	\
+	{"RX INT" #id "_2 MUX", "RX6", "SLIM RX6"},	\
+	{"RX INT" #id "_2 MUX", "RX7", "SLIM RX7"},	\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP0"},	\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP1"},	\
+	{"RX INT" #id "_1 MIX1", NULL, "RX INT" #id "_1 MIX1 INP2"},	\
+	{"RX INT" #id " SEC MIX", NULL, "RX INT" #id "_2 MUX"},		\
+	{"RX INT" #id " SEC MIX", NULL, "RX INT" #id "_1 MIX1"},	\
+	{"RX INT" #id " MIX2", NULL, "RX INT" #id " SEC MIX"},		\
+	{"RX INT" #id " INTERP", NULL, "RX INT" #id " MIX2"}
+
+#define WCD9335_ADC_MUX_PATH(id)			\
+	{"AIF1_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id " MUX"}, \
+	{"AIF2_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id " MUX"}, \
+	{"AIF3_CAP Mixer", "SLIM TX" #id, "SLIM TX" #id " MUX"}, \
+	{"SLIM TX" #id " MUX", "DEC" #id, "ADC MUX" #id}, \
+	{"ADC MUX" #id, "DMIC", "DMIC MUX" #id},	\
+	{"ADC MUX" #id, "AMIC", "AMIC MUX" #id},	\
+	{"DMIC MUX" #id, "DMIC0", "DMIC0"},		\
+	{"DMIC MUX" #id, "DMIC1", "DMIC1"},		\
+	{"DMIC MUX" #id, "DMIC2", "DMIC2"},		\
+	{"DMIC MUX" #id, "DMIC3", "DMIC3"},		\
+	{"DMIC MUX" #id, "DMIC4", "DMIC4"},		\
+	{"DMIC MUX" #id, "DMIC5", "DMIC5"},		\
+	{"AMIC MUX" #id, "ADC1", "ADC1"},		\
+	{"AMIC MUX" #id, "ADC2", "ADC2"},		\
+	{"AMIC MUX" #id, "ADC3", "ADC3"},		\
+	{"AMIC MUX" #id, "ADC4", "ADC4"},		\
+	{"AMIC MUX" #id, "ADC5", "ADC5"},		\
+	{"AMIC MUX" #id, "ADC6", "ADC6"}
+
 enum {
 	WCD9335_RX0 = 0,
 	WCD9335_RX1,
@@ -2327,6 +2388,132 @@ static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
 	SOC_ENUM("TX8 HPF cut off", cf_dec8_enum),
 };
 
+static const struct snd_soc_dapm_route wcd9335_audio_map[] = {
+	{"SLIM RX0 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX1 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX2 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX3 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX4 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX5 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX6 MUX", "AIF1_PB", "AIF1 PB"},
+	{"SLIM RX7 MUX", "AIF1_PB", "AIF1 PB"},
+
+	{"SLIM RX0 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX1 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX2 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX3 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX4 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX5 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX6 MUX", "AIF2_PB", "AIF2 PB"},
+	{"SLIM RX7 MUX", "AIF2_PB", "AIF2 PB"},
+
+	{"SLIM RX0 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX1 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX2 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX3 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX4 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX5 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX6 MUX", "AIF3_PB", "AIF3 PB"},
+	{"SLIM RX7 MUX", "AIF3_PB", "AIF3 PB"},
+
+	{"SLIM RX0 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX1 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX2 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX3 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX4 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX5 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX6 MUX", "AIF4_PB", "AIF4 PB"},
+	{"SLIM RX7 MUX", "AIF4_PB", "AIF4 PB"},
+
+	{"SLIM RX0", NULL, "SLIM RX0 MUX"},
+	{"SLIM RX1", NULL, "SLIM RX1 MUX"},
+	{"SLIM RX2", NULL, "SLIM RX2 MUX"},
+	{"SLIM RX3", NULL, "SLIM RX3 MUX"},
+	{"SLIM RX4", NULL, "SLIM RX4 MUX"},
+	{"SLIM RX5", NULL, "SLIM RX5 MUX"},
+	{"SLIM RX6", NULL, "SLIM RX6 MUX"},
+	{"SLIM RX7", NULL, "SLIM RX7 MUX"},
+
+	WCD9335_INTERPOLATOR_PATH(0),
+	WCD9335_INTERPOLATOR_PATH(1),
+	WCD9335_INTERPOLATOR_PATH(2),
+	WCD9335_INTERPOLATOR_PATH(3),
+	WCD9335_INTERPOLATOR_PATH(4),
+	WCD9335_INTERPOLATOR_PATH(5),
+	WCD9335_INTERPOLATOR_PATH(6),
+	WCD9335_INTERPOLATOR_PATH(7),
+	WCD9335_INTERPOLATOR_PATH(8),
+
+	/* EAR PA */
+	{"RX INT0 DEM MUX", "CLSH_DSM_OUT", "RX INT0 INTERP"},
+	{"RX INT0 DAC", NULL, "RX INT0 DEM MUX"},
+	{"RX INT0 DAC", NULL, "RX_BIAS"},
+	{"EAR PA", NULL, "RX INT0 DAC"},
+	{"EAR", NULL, "EAR PA"},
+
+	/* HPHL */
+	{"RX INT1 DEM MUX", "CLSH_DSM_OUT", "RX INT1 INTERP"},
+	{"RX INT1 DAC", NULL, "RX INT1 DEM MUX"},
+	{"RX INT1 DAC", NULL, "RX_BIAS"},
+	{"HPHL PA", NULL, "RX INT1 DAC"},
+	{"HPHL", NULL, "HPHL PA"},
+
+	/* HPHR */
+	{"RX INT2 DEM MUX", "CLSH_DSM_OUT", "RX INT2 INTERP"},
+	{"RX INT2 DAC", NULL, "RX INT2 DEM MUX"},
+	{"RX INT2 DAC", NULL, "RX_BIAS"},
+	{"HPHR PA", NULL, "RX INT2 DAC"},
+	{"HPHR", NULL, "HPHR PA"},
+
+	/* LINEOUT1 */
+	{"RX INT3 DAC", NULL, "RX INT3 INTERP"},
+	{"RX INT3 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT1 PA", NULL, "RX INT3 DAC"},
+	{"LINEOUT1", NULL, "LINEOUT1 PA"},
+
+	/* LINEOUT2 */
+	{"RX INT4 DAC", NULL, "RX INT4 INTERP"},
+	{"RX INT4 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT2 PA", NULL, "RX INT4 DAC"},
+	{"LINEOUT2", NULL, "LINEOUT2 PA"},
+
+	/* LINEOUT3 */
+	{"RX INT5 DAC", NULL, "RX INT5 INTERP"},
+	{"RX INT5 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT3 PA", NULL, "RX INT5 DAC"},
+	{"LINEOUT3", NULL, "LINEOUT3 PA"},
+
+	/* LINEOUT4 */
+	{"RX INT6 DAC", NULL, "RX INT6 INTERP"},
+	{"RX INT6 DAC", NULL, "RX_BIAS"},
+	{"LINEOUT4 PA", NULL, "RX INT6 DAC"},
+	{"LINEOUT4", NULL, "LINEOUT4 PA"},
+
+	/* SLIMBUS Connections */
+	{"AIF1 CAP", NULL, "AIF1_CAP Mixer"},
+	{"AIF2 CAP", NULL, "AIF2_CAP Mixer"},
+	{"AIF3 CAP", NULL, "AIF3_CAP Mixer"},
+
+	/* ADC Mux */
+	WCD9335_ADC_MUX_PATH(0),
+	WCD9335_ADC_MUX_PATH(1),
+	WCD9335_ADC_MUX_PATH(2),
+	WCD9335_ADC_MUX_PATH(3),
+	WCD9335_ADC_MUX_PATH(4),
+	WCD9335_ADC_MUX_PATH(5),
+	WCD9335_ADC_MUX_PATH(6),
+	WCD9335_ADC_MUX_PATH(7),
+	WCD9335_ADC_MUX_PATH(8),
+
+	/* ADC Connections */
+	{"ADC1", NULL, "AMIC1"},
+	{"ADC2", NULL, "AMIC2"},
+	{"ADC3", NULL, "AMIC3"},
+	{"ADC4", NULL, "AMIC4"},
+	{"ADC5", NULL, "AMIC5"},
+	{"ADC6", NULL, "AMIC6"},
+};
+
 static int wcd9335_micbias_control(struct snd_soc_component *component,
 				   int micb_num, int req, bool is_dapm)
 {
@@ -4728,6 +4915,8 @@ static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.num_controls = ARRAY_SIZE(wcd9335_snd_controls),
 	.dapm_widgets = wcd9335_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wcd9335_dapm_widgets),
+	.dapm_routes = wcd9335_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wcd9335_audio_map),
 };
 
 static int wcd9335_probe(struct platform_device *pdev)
-- 
2.16.2

