Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC59C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388E52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeH1Tgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:36:53 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:47069 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Tgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:36:52 -0400
Received: by mail-oi0-f44.google.com with SMTP id y207-v6so3617264oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=xiuxQdP6s+Tq5IPOSJJx7r94IM2H7aQMfWi0PAGfZSE=;
        b=J/Mw5ITbN+0PMSbj67NAC0sb63wVpL+aFP5hEOM+ucpihTFxJhPS6dADEbIoi0AS1i
         6Rt2bc+G12IYphKz+zQv8GGUF9/en1VUe5C0LAfB/+04rlimCBEr5oxVL9HSYuP+WrJO
         sq0IWry689VQVDBpwbhpJChH8C4ufne3acu+5EVV/flPBj+Wm1B9GJA5OiZLG5osMDbf
         K5IOzel7x/Y5lncGHXQTAvgSB+JAODizG3bfGuwfUFmyUFcAnzS0qsM3NQbAl54PtBOE
         W2MtB52Wt1WePZPkixc3SuG9yeBbVMUoYASzG/DIEtBfOzS3rWenv2GMxN04eAYlc3yh
         zs3A==
X-Gm-Message-State: APzg51ACCXtJY6bZCI+fWH/BTYm6KGEyA10PRfh+gbWejdwrmVTAN0So
        awJRi8KkdhzzFCoGUAtdSPxNUAY=
X-Google-Smtp-Source: ANB0VdZyUOa4pDM2jANstMCfYUj2TZdPPHbZdL/Yp0ZIzobXZQW0tLxBRpXPtAYXF6IN+ejhh5SUBw==
X-Received: by 2002:aca:acc8:: with SMTP id v191-v6mr1586463oie.354.1535471076622;
        Tue, 28 Aug 2018 08:44:36 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f4-v6sm1808331oic.52.2018.08.28.08.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:44:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Timur Tabi <timur@kernel.org>,
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
Subject: [PATCH v2] ASoC: Convert to using %pOFn instead of device_node.name
Date:   Tue, 28 Aug 2018 10:44:28 -0500
Message-Id: <20180828154433.5693-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828154433.5693-1-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
In-Reply-To: <20180828015252.28511-51-robh@kernel.org>
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
v2:
- stm32_sai_sub: Unwrap now shorter line

 sound/soc/fsl/fsl_esai.c      | 2 +-
 sound/soc/fsl/fsl_utils.c     | 4 ++--
 sound/soc/meson/axg-card.c    | 2 +-
 sound/soc/stm/stm32_sai.c     | 2 +-
 sound/soc/stm/stm32_sai_sub.c | 7 +++----
 5 files changed, 8 insertions(+), 9 deletions(-)

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
index 06fba9650ac4..56a227e0bd71 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1124,16 +1124,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	sai->sync = SAI_SYNC_NONE;
 	if (args.np) {
 		if (args.np == np) {
-			dev_err(&pdev->dev, "%s sync own reference\n",
-				np->name);
+			dev_err(&pdev->dev, "%pOFn sync own reference\n", np);
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
