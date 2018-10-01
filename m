Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3320E2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3320E2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJBEXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:23:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46851 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:23:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id q4-v6so14700735otf.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L9kqBX3pi22PnrQtBzvtfL5T0DK9Glho7IjZ925GE14=;
        b=n8MR7iOzJN5sViaw4IMFHpfBjGFkdOrNkJYKRsGVWT1FQq4xgmSzTKK66PY+vbcmHI
         nNxdY10Es/64ptUTMphBStK8PSUcr6RXyugrcmw/XBeJZraWAjB+fPUDg1HBqMVWchlv
         Oc2oLXjUST48Bb2HQD87+wkeHGNFrKGYZKUGNi8eOTDiNQM52fvGxEYX/ErIwbXa8BA8
         Uvx5Ip9RnfICoE6E/bjbjVRQY+nsWRXff4X4YmOCR7fU9um6XGrbPGTviLeCT6TXqFfd
         9LzPniWwNoaniDRsQAE4QbJcOu31fHLna3lBkwWmP0qrkGhwamqg+69fRVGbrWUzC5To
         jxbQ==
X-Gm-Message-State: ABuFfoiYq+U9K0I1PbWbz6kZfALVQL/UXfCB72MEd43d8awBanDkf1ZH
        DjNXLj/jawxX+nJYZHj9KPyr9hctZQ==
X-Google-Smtp-Source: ACcGV62mOm+WNmN/eCBgu0j8DujFR4M3k7zdV1SDUJUsfnpTjoF10rvTPLPHThoz9qldKRIau2eZaA==
X-Received: by 2002:a9d:3437:: with SMTP id v52-v6mr7274970otb.231.1538430232940;
        Mon, 01 Oct 2018 14:43:52 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h22-v6sm6401661otd.21.2018.10.01.14.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:43:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: Convert a few more users to using %pOFn instead of device_node.name
Date:   Mon,  1 Oct 2018 16:43:48 -0500
Message-Id: <20181001214351.13230-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 2 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 2 +-
 sound/soc/stm/stm32_sai.c                  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 192f4d7b37b6..bff7d71d0742 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -828,7 +828,7 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
 	if (!irq_id) {
-		dev_err(dev, "%s no irq found\n", dev->of_node->name);
+		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
 		return -ENXIO;
 	}
 	ret = devm_request_irq(dev, irq_id, mt6797_afe_irq_handler,
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index c0b6697503fd..166aed28330d 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1092,7 +1092,7 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	irq_id = platform_get_irq(pdev, 0);
 	if (irq_id <= 0) {
-		dev_err(afe->dev, "np %s no irq\n", afe->dev->of_node->name);
+		dev_err(afe->dev, "np %pOFn no irq\n", afe->dev->of_node);
 		return irq_id < 0 ? irq_id : -ENXIO;
 	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index d597eba61992..bcb35cae2a2c 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -74,14 +74,14 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 		return ret;
 	}
 
-	dev_dbg(&sai->pdev->dev, "Set %s%s as synchro provider\n",
-		sai->pdev->dev.of_node->name,
+	dev_dbg(&sai->pdev->dev, "Set %pOFn%s as synchro provider\n",
+		sai->pdev->dev.of_node,
 		synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
 
 	prev_synco = FIELD_GET(SAI_GCR_SYNCOUT_MASK, readl_relaxed(sai->base));
 	if (prev_synco != STM_SAI_SYNC_OUT_NONE && synco != prev_synco) {
-		dev_err(&sai->pdev->dev, "%s%s already set as sync provider\n",
-			sai->pdev->dev.of_node->name,
+		dev_err(&sai->pdev->dev, "%pOFn%s already set as sync provider\n",
+			sai->pdev->dev.of_node,
 			prev_synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
 		clk_disable_unprepare(sai->pclk);
 		return -EINVAL;
-- 
2.17.1

