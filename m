Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28240C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF71F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rT6Tq613"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfBGRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:21 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46784 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBGRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:16 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190207170113epoutp024aa7d8f3476b5065c869616cca012776~BI5XpzCzc0530705307epoutp02F;
        Thu,  7 Feb 2019 17:01:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190207170113epoutp024aa7d8f3476b5065c869616cca012776~BI5XpzCzc0530705307epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558873;
        bh=tr3teq5FXrCMqB9mlSIoDLcOpZJLhsPkbwRQRaxD5pU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=rT6Tq613RTrenaAOKyAyAwZNpmlzwLktIoz0HRt1G4/dwAF60lBiNG05vf7PfsWIF
         2IuLssLsU3oAKZjSaVaLS7s6d2JVmtPxFxVVBVUzqEa7sQ12I3tAdppoSqb1DulQbk
         MXT9qtiX/KQROFBJhRRa2z5Zm4P/p7TmuUyat1lY=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170113epcas1p2778a199eedab4669278b4aea7d717043~BI5XSF0U11808618086epcas1p2W;
        Thu,  7 Feb 2019 17:01:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.AE.04206.9546C5C5; Fri,  8 Feb 2019 02:01:13 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170112epcas1p31ed740ef43d8a3eb71ca7245fba1bc3d~BI5W66pmw2640626406epcas1p3a;
        Thu,  7 Feb 2019 17:01:12 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-5e-5c5c6459dbe3
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.C8.04015.8546C5C5; Fri,  8 Feb 2019 02:01:12 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:12 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 08/22] ASoC: samsung: i2s: Add widgets and routes for DPCM
 support
Date:   Thu, 07 Feb 2019 18:00:16 +0100
Message-id: <20190207170028.720-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCmvm5kSkyMwZm9bBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MD83N7AUfBCt+dcxjbmD8yNfFyMkh
        IWAi8XtGI2MXIxeHkMAORok5J9eyQTjfGSXOXfrAAlO18dJKJojEbkaJS43vWCCcX4wSV6cu
        ZwapYhMwlOg92scIYosIiEncntPJDFLELNDCJDFn7lKwImGBEImuyUfBxrIIqEpMfLyCFcTm
        FbCUuHawlw1inbzE+d517CA2p4CVxK39O1ggagQlfky+B2YzA9UcvPIc7AoJgQNsEo2v9zJB
        NLtIPP3yEKiZA8iWlrh01BYiXC2xa3s3M0R9B6NEy4XtzBAJa4nDxy+yQgzlk3j3tYcVopdX
        oqNNCKLEA+jmFnaIj3sZJSY97mKcwCg1C8lNs5DctICRaRWjWGpBcW56arFhgalecWJucWle
        ul5yfu4mRnCca1nuYDx2zucQowAHoxIP7wXtmBgh1sSy4srcQ4wSHMxKIryyCUAh3pTEyqrU
        ovz4otKc1OJDjNIcLErivOsdnGOEBNITS1KzU1MLUotgskwcnFINjGGu0qtfzCsvMbZo3Wz3
        7QLvLK1LMz4VCKgHaTXn61Uu+Wj1JUHg1bmY119zI9ROu9o9d6qTENjacu2Un/GOkPmFc6on
        Bt5S13y30aLL7fIeY9ZLLbY++y8sYVSxzDrPPK3p6RvRHA3NN4wTX+2o+Xa1skkvcdWnXYdy
        td6ztWhXaTx/aJDlqsRSnJFoqMVcVJwIADETvU3vAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd2IlJgYg52XNCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZH5qb2Qs+CFb86pjH3MD4ka+LkZND
        QsBEYuOllUxdjFwcQgI7GSUWXX7IBpIQEvjFKDF3vh2IzSZgKNF7tI8RxBYREJO4PaeTGaSB
        WaCJSWLX7YvsIAlhgRCJrslHWUBsFgFViYmPV7CC2LwClhLXDvayQWyTlzjfuw6snlPASuLW
        /h0sEMssJT5MaIKqF5T4MfkeWJwZqP7glecsExj5ZiFJzUKSWsDItIpRMrWgODc9t9iowDAv
        tVyvODG3uDQvXS85P3cTIzCItx3W6tvBeH9J/CFGAQ5GJR7eC9oxMUKsiWXFlbmHGCU4mJVE
        eGUTgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwSkp0
        5Qsuv527OuZrqXXK1FdPe18f3zt3D8/5NW7LcjY/tdGw8PiTf15iv9SqmOQirisJ+k/Wvdu1
        b9pCPY+jeor756+8LNAjnz/nXY/TqoXJWXELdqYkLmq4tKSkYdmsNUdSo7ZtcLGqXet3TvoJ
        g9PiR+yRTZynDYtEMmy2/usKWCnZuuftDiWW4oxEQy3mouJEAE/8LoteAgAA
X-CMS-MailID: 20190207170112epcas1p31ed740ef43d8a3eb71ca7245fba1bc3d
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170112epcas1p31ed740ef43d8a3eb71ca7245fba1bc3d
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170112epcas1p31ed740ef43d8a3eb71ca7245fba1bc3d@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DAPM widgets required to model the internal mixer
of the I2S controller merging audio streams from the primary and
from the secondary PCM interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 978614673ffb..b435e6226ec2 100644
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

