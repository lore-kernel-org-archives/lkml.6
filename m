Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6FFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D9D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D9D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeH1Foh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33524 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeH1Fog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:36 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so53786oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=55lHpuNsCJJAxN4AHRFm8FDVcJW+iNwvqKUpkyhMS40=;
        b=R0sRmln7zokyUd8BniVyqyr5qiWrQK6H/kao/Mx+YXxO1edcv34PsD+0ghVAetqVzf
         9eA+vXnVBETZ6KjfCbAgHrgVLgM7BeWHLtuYSsSkZdQI7pnmCKheovl1Nnx4SWWGrLlm
         u43qyPy+54mPgdOhcHldwIPRRrcaVrSCbl1xCU/UIESR7cwbfYu64oD9uO+j7bJHVEeZ
         h6IZ47LfyyjcA4N8u0X5RWi0aYVq0iILnT4iXhbA1dwarTwHFS4kKOZGoHCgJBYtUFg+
         KjGLU6TtJUrUTX97vfEUc2H5cu3OBCtUppkz+P8G2skwEpoU+uclcBW2WStIUMl3e0AZ
         xNMg==
X-Gm-Message-State: APzg51AucHjRg9D7m8cU8HS7s2L8+Q0DhDugQaeUS1C89K24bfQvTRp+
        pQoj5/PhlSltxpV8ZTbsYMwJmF0=
X-Google-Smtp-Source: ANB0VdbNCCnft4LPYdktaqopsPKfsBTeJxoso2RWxcyOroPgQHs81v8smDCMeF3hkSMYf8Ga4pNgpg==
X-Received: by 2002:aca:3003:: with SMTP id w3-v6mr360623oiw.231.1535421320495;
        Mon, 27 Aug 2018 18:55:20 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:52 -0500
Message-Id: <20180828015252.28511-51-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/fsl/fsl_esai.c      | 2 +-
 sound/soc/fsl/fsl_utils.c     | 4 ++--
 sound/soc/meson/axg-card.c    | 2 +-
 sound/soc/stm/stm32_sai.c     | 2 +-
 sound/soc/stm/stm32_sai_sub.c | 8 ++++----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c1d1d06783e5..57b484768a58 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -807,7 +807,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	esai_priv->pdev = pdev;
-	strncpy(esai_priv->name, np->name, sizeof(esai_priv->name) - 1);
+	snprintf(esai_priv->name, sizeof(esai_priv->name), "%pOFn", np);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 7f0fa4b52223..9981668ab590 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -57,8 +57,8 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 		of_node_put(dma_channel_np);
 		return ret;
 	}
-	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
-		 (unsigned long long) res.start, dma_channel_np->name);
+	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
+		 (unsigned long long) res.start, dma_channel_np);
 
 	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
 	if (!iprop) {
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 2914ba0d965b..b76a5f4f1785 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -478,7 +478,7 @@ static int axg_card_set_be_link(struct snd_soc_card *card,
 
 	ret = axg_card_set_link_name(card, link, "be");
 	if (ret)
-		dev_err(card->dev, "error setting %s link name\n", np->name);
+		dev_err(card->dev, "error setting %pOFn link name\n", np);
 
 	return ret;
 }
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index f22654253c43..d597eba61992 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -104,7 +104,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
-			"Device not found for node %s\n", np_provider->name);
+			"Device not found for node %pOFn\n", np_provider);
 		return -ENODEV;
 	}
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 06fba9650ac4..cad8c7888292 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1124,16 +1124,16 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	sai->sync = SAI_SYNC_NONE;
 	if (args.np) {
 		if (args.np == np) {
-			dev_err(&pdev->dev, "%s sync own reference\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn sync own reference\n",
+				np);
 			of_node_put(args.np);
 			return -EINVAL;
 		}
 
 		sai->np_sync_provider  = of_get_parent(args.np);
 		if (!sai->np_sync_provider) {
-			dev_err(&pdev->dev, "%s parent node not found\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn parent node not found\n",
+				np);
 			of_node_put(args.np);
 			return -ENODEV;
 		}
-- 
2.17.1

