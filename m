Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AC6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063502229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ovhNKDzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbfBLSE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:04:59 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:44108 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbfBLSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:53 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190212180450epoutp047d61cdca3b165f86d59c697219bb1dac~Cr-V410rP1944219442epoutp04N;
        Tue, 12 Feb 2019 18:04:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190212180450epoutp047d61cdca3b165f86d59c697219bb1dac~Cr-V410rP1944219442epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994690;
        bh=hDFH6nAvYV0mV9T/urICuXj+l++l2fNaDp5UXV8K44s=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ovhNKDzxmUvfKwcRFq3Dqye0wU3fQKkDBuPwwpQhl68IP2MOPurCPVLMwPxxtfzxr
         68Ngass5aX08ACHY23DT3nbf5ZCwbp0hEO/TfKKuFl6x8kk1AjuPHbxFMCUU1Ppqs8
         YzOxOBXqj/g8ERljkUK/WAtyQJtlzsxa7bqqmmmM=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180449epcas1p24f41ae3d67b8e495f616c010fee0e18b~Cr-Ur2knH0550005500epcas1p2v;
        Tue, 12 Feb 2019 18:04:49 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.7E.04206.1CA036C5; Wed, 13 Feb 2019 03:04:49 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180449epcas1p232598bff05255c7f9c582a16b27797c7~Cr-UZ2QE_1433014330epcas1p2F;
        Tue, 12 Feb 2019 18:04:49 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-bc-5c630ac1dc83
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 21.11.04015.0CA036C5; Wed, 13 Feb
        2019 03:04:48 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:48 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 03/21] ASoC: samsung: i2s: Add widgets and routes for
 DPCM support
Date:   Tue, 12 Feb 2019 19:03:24 +0100
Message-id: <20190212180342.32040-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmnu5BruQYg83t/BZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MnfduMhYsFKr43vSQpYFxLn8XIyeH
        hICJxKmPT1i7GLk4hAR2MEpMm3iPDcL5ziix9GwbC0zVlPXd7BCJDYwSS163QlX9YpTY0P6H
        FaSKTcBQovdoHyOILSIgJnF7TiczSBGzQAuTxJy5S5lBEsIC4RILZj1lArFZBFQlVq09wAZi
        8wpYS1y8/5gNYp28xPnedewgNqeAjcSzhd9YIGoEJX5MvgdmMwPVHLzynAVkgYTAETaJsydX
        AjVzADkuEt8PakKY0hKXjtpCjKyW2LW9mxmivINRouXCdmaIhLXE4eMXWSFm8km8+9rDCtHL
        K9HRJgRR4iHR+HopE8TD/YwSb/88YprAKDULyUmzkJy0gJFpFaNYakFxbnpqsWGBqV5xYm5x
        aV66XnJ+7iZGcJRrWe5gPHbO5xCjAAejEg/viqNJMUKsiWXFlbmHGCU4mJVEeNOYk2OEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ8653cI4REkhPLEnNTk0tSC2CyTJxcEo1MBp5zOZr2deddrii
        aRtv2aQZL46sTWK8v0U+R3GOzueZG3umb7ma+/Xw5WMcKZuDT4Q5um/0r2bbylu2cmN2/7np
        fR/OXXntFsjf1a3UZcss7PWza+/sgAN/dl2JWOK38KDVhv/n1vNl3HS7un5O/5+JvxanvNcT
        ZEjfv7qlaK7U0Q9GbpNW+SgrsRRnJBpqMRcVJwIAAoQpnO4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd0DXMkxBpuXm1tcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgydt67yViwUKjie9NDlgbGufxdjJwc
        EgImElPWd7N3MXJxCAmsY5T4PWcDM4Tzi1Fixrtz7CBVbAKGEr1H+xhBbBEBMYnbczrBipgF
        mpgkdt2+CFTEwSEsEC7x94gdSA2LgKrEqrUH2EBsXgFriYv3H7NBbJOXON+7Dmwmp4CNxLOF
        31hAWoWAaq5ssoUoF5T4MfkeC4jNDFR+8MpzlgmMfLOQpGYhSS1gZFrFKJlaUJybnltsVGCY
        l1quV5yYW1yal66XnJ+7iREYwtsOa/XtYLy/JP4QowAHoxIP74qjSTFCrIllxZW5hxglOJiV
        RHjTmJNjhHhTEiurUovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamA0
        OrdCk7v7pOmuHj9XP8+tVy2KCpT9lj4W/L1vjVkBi7oS++mNlyakPL1gdPRry46pbqtuiPUL
        fT1Y/NtWWO7ilgfrd7F93jrz0ePCLNddUoesqkSLpe/Z7riaGW32MyFjHY+26A/JrPJnmqey
        XK5u6H8f5i+s12r94/OEr6szJVYIdAdv3NmhxFKckWioxVxUnAgAEp2RF10CAAA=
X-CMS-MailID: 20190212180449epcas1p232598bff05255c7f9c582a16b27797c7
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180449epcas1p232598bff05255c7f9c582a16b27797c7
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180449epcas1p232598bff05255c7f9c582a16b27797c7@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DAPM widgets required to model the internal mixer
of the I2S controller merging audio streams from the primary and
from the secondary PCM interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fffc76ab60da..29bcfca20572 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1116,8 +1116,31 @@ static const struct snd_soc_dai_ops samsung_i2s_dai_ops = {
 	.delay = i2s_delay,
 };
 
+static const struct snd_soc_dapm_widget samsung_i2s_widgets[] = {
+	/* Backend DAI  */
+	SND_SOC_DAPM_AIF_OUT("Mixer DAI TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("Mixer DAI RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+
+	/* Playback Mixer */
+	SND_SOC_DAPM_MIXER("Playback Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_route samsung_i2s_dapm_routes[] = {
+	{ "Playback Mixer", NULL, "Primary" },
+	{ "Playback Mixer", NULL, "Secondary" },
+
+	{ "Mixer DAI TX", NULL, "Playback Mixer" },
+	{ "Playback Mixer", NULL, "Mixer DAI RX" },
+};
+
 static const struct snd_soc_component_driver samsung_i2s_component = {
-	.name		= "samsung-i2s",
+	.name = "samsung-i2s",
+
+	.dapm_widgets = samsung_i2s_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(samsung_i2s_widgets),
+
+	.dapm_routes = samsung_i2s_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(samsung_i2s_dapm_routes),
 };
 
 #define SAMSUNG_I2S_FMTS	(SNDRV_PCM_FMTBIT_S8 | \
@@ -1129,6 +1152,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 			  int num_dais)
 {
 	static const char *dai_names[] = { "samsung-i2s", "samsung-i2s-sec" };
+	static const char *stream_names[] = { "Primary", "Secondary" };
 	struct snd_soc_dai_driver *dai_drv;
 	struct i2s_dai *dai;
 	int i;
@@ -1158,6 +1182,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 		dai_drv->playback.channels_max = 2;
 		dai_drv->playback.rates = i2s_dai_data->pcm_rates;
 		dai_drv->playback.formats = SAMSUNG_I2S_FMTS;
+		dai_drv->playback.stream_name = stream_names[i];
 
 		dai_drv->id = i + 1;
 		dai_drv->name = dai_names[i];
-- 
2.20.1

