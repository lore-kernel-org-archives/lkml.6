Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D97C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACEE218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MLbvVgEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407780AbfBNQAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:00:46 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46494 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393948AbfBNQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:00:44 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214160040epoutp0289e8ef9b8b90cbc41755db2eacdf6aee~DRlf19cwj2813928139epoutp02o;
        Thu, 14 Feb 2019 16:00:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214160040epoutp0289e8ef9b8b90cbc41755db2eacdf6aee~DRlf19cwj2813928139epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550160040;
        bh=cDFL8dMhFiGT2Iv66WAKXwmlcSlSqlEVHwxoYDltNlo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MLbvVgEYxZ3vH2h13mhOSS9Q9U55UKocJSonjb1AqM/lCvOzuzvbNyvLFujghjIQw
         XUOrwiRBo8yrjGGhOGBI3ukksWJKHFD7hyo/FCliIR2dqZHltMdNMuUTMlpH+36TWA
         SptFHqpaY9QDzuAbcmNh5KnBuEqz3e+vw4Yxagzg=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190214160039epcas2p46257536854fac361ffa16e98ee170e4c~DRlfCEqVz2519625196epcas2p4A;
        Thu, 14 Feb 2019 16:00:39 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.7F.04138.7A0956C5; Fri, 15 Feb 2019 01:00:39 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1~DRlerhfyV0742407424epcas2p3U;
        Thu, 14 Feb 2019 16:00:39 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-08-5c6590a7e6d1
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1E.17.03689.6A0956C5; Fri, 15 Feb
        2019 01:00:39 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMX00ACXB4T7W90@mmp2.samsung.com>; Fri, 15 Feb 2019
        01:00:38 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on pri/sec
 PCM
Date:   Thu, 14 Feb 2019 17:00:11 +0100
Message-id: <20190214160011.3940-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdljTXHf5hNQYgwN3JS2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNovDb9pZLS6u+MLkwO6x4XMTm8fOWXfZPTat6mTz6NuyitHj8ya5
        ANYoLpuU1JzMstQifbsEroy3l/ILrspWzP0wh62B8YVEFyMnh4SAicS/K39Yuxi5OIQEdjBK
        XF45ixnC+c4oMXn7UyCHA6zqxPswiPgGRond266zgnQLCfxilJi4VwrEZhMwlOg92scIYosI
        iEncntMJNohZYCWjxJZ9m9hAEsICQRKH/v5gB7FZBFQl/s1bBTaIV8BKYkbDbVaIk+QlVm84
        ANYsIfCRVeLr6jY2iISLxJczsxkhbGmJZ6s2QtnVEru2d0M1dDBKtFzYzgyRsJY4fPwi2FRm
        AT6JjsN/2SHe4ZXoaBOCKPGQWPC0mw0kLCQQK/FhReIERvEFjAyrGMVSC4pz01OLjQoM9YoT
        c4tL89L1kvNzNzGCI0nLdQfjjHM+hxgFOBiVeHhXZKTGCLEmlhVX5h5ilOBgVhLhfdMDFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM77SHputJBAemJJanZqakFqEUyWiYNTqoFx0Wenx5ZGMw9l
        JCyTleCS3cTrY3vrYf4OZ23xattA58xzLqLz1p2Rbnp6u+fZQ459Xav9nxt+iuA+V2Oh/Pzq
        X16OQydm7Gy6fFvc9L544e7HNYGlZ1QOhq1nkHF9tFCrtfBicdaJZe095mbSZ4WULD6KbNAz
        Zw/5eNTl8IZZKZG18w9x9oUrsRRnJBpqMRcVJwIAb1v29KACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsVy+t9jQd3lE1JjDA5vZrS4cvEQk8XUh0/Y
        LM6f38Bu8e1KB5PF5V1z2CwOv2lntbi44guTA7vHhs9NbB47Z91l99i0qpPNo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDLeXsovuCpbMffDHLYGxhcSXYwcHBICJhIn3od1MXJxCAmsY5TY
        9eweI4Tzi1Fiz64prF2MnBxsAoYSvUf7GEFsEQExidtzOplBipgFVjJKHPm+CiwhLBAg8bZl
        PRuIzSKgKvFv3iqwZl4BK4kZDbfBbAkBeYnVGw4wT2DkWsDIsIpRMrWgODc9t9iowCgvtVyv
        ODG3uDQvXS85P3cTIzAoth3W6t/B+HhJ/CFGAQ5GJR7eFRmpMUKsiWXFlbmHGCU4mJVEeN/0
        AIV4UxIrq1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwLgkMc7p9
        wOi8hf1Okxl1xn871sjmXzlxTXjvQisxlo3LxG3keeVCNcofPzz22sxxtlKmdF6z5Ny07FlG
        jqeYb12s1Hi8lJGj1v1SUKf8jjmv1ry1rp5y+uvtkD1/xNa/3NXc5rm2f+L/6woqIQcFsv04
        eP9GdvHe2XXvW1X8fkahRQembPr5RomlOCPRUIu5qDgRACfBgyAGAgAA
X-CMS-MailID: 20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1
References: <CGME20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when playing sound with different sample rates actual
sample rate will be determined by audio stream which starts first
on either primary or secondary PCM. The audio root clock will be
configured appropriately only for the first stream. As the hardware
is limited to same sample rate on both interfaces we need to disallow
streams with different sample rates. It is done by this patch by
returning error in FE hw_params if there is already active stream
running with different sample rate.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/odroid.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 18bb3bfe0300..941e8c3f67a4 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -20,6 +20,11 @@ struct odroid_priv {
 	struct snd_soc_card card;
 	struct clk *clk_i2s_bus;
 	struct clk *sclk_i2s;
+
+	/* Spinlock protecting fields below */
+	spinlock_t lock;
+	unsigned int be_sample_rate;
+	bool be_active;
 };
 
 static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
@@ -31,8 +36,25 @@ static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int odroid_card_fe_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->be_active && priv->be_sample_rate != params_rate(params))
+		ret = -EINVAL;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
 static const struct snd_soc_ops odroid_card_fe_ops = {
 	.startup = odroid_card_fe_startup,
+	.hw_params = odroid_card_fe_hw_params,
 };
 
 static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
@@ -41,6 +63,7 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	unsigned int pll_freq, rclk_freq, rfs;
+	unsigned long flags;
 	int ret;
 
 	switch (params_rate(params)) {
@@ -87,11 +110,43 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->be_sample_rate = params_rate(params);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int odroid_card_be_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->be_active = true;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->be_active = false;
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return 0;
 }
 
 static const struct snd_soc_ops odroid_card_be_ops = {
 	.hw_params = odroid_card_be_hw_params,
+	.trigger = odroid_card_be_trigger,
 };
 
 static struct snd_soc_dai_link odroid_card_dais[] = {
@@ -150,6 +205,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	card->owner = THIS_MODULE;
 	card->fully_routed = true;
 
+	spin_lock_init(&priv->lock);
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = snd_soc_of_parse_card_name(card, "model");
-- 
2.17.1

