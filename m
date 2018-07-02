Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E4F24FE3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="USCKgRRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E4F24FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeGBVUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:20:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55602 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbeGBVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:12 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so255025itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5e+YRQymzw8XOzquPKh8N+zTFcrUq+WIpxNeYloeNo=;
        b=USCKgRRHMh5VbtllZ5qgJKGDchqQkrQVKiQ9R214ghtni9C30/RUxJbyRKa6ihqX4Z
         xtbK78M9qkUkfV2hIrUAoEViTTHigm7D2PvxJ0dPEiElQXQo38glsbwdTz/SEFYbZakO
         H54/Q+m51o5iu42Zu+m9hB49MVaGjPs+OSVVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5e+YRQymzw8XOzquPKh8N+zTFcrUq+WIpxNeYloeNo=;
        b=nwBbGKekmnz6yIz//YBHJYY0uDwqrxHZnR+xew5zabJueRHPpwJu6pgpfQCKM8EOrZ
         VkAXVV011RUtnC678teYuuQ36JaVqQyy4mZRS9ej19DyYWPT/GmuJECyHKoObwv7/0Sv
         1ivDKOujFjJsDGwujXOb7aMpkH0F1D9Ebc2gANKXECd4Rn9qRuKrZqZ/0IGjvZ0iDwWv
         i6xUuvfL5kxIXFZAwddrtHNCp3cVO5sMr+fzKvJONP4tHNVnvUbx8Y/ipXwver0uX15L
         0YHOaX9zZx/EHyexa/jL9HrJghVUuFrGEA6j3CDGMzkh4liSNbYZk/33p/pvgDoKHfWO
         Ty1Q==
X-Gm-Message-State: APt69E05clBbhGjXB/S6iGVUAW9IApYMVX7b2tEBFh5rDZtRdkvL8Dim
        meeYsNWVcl0ZAU0T/8QOYJeWjA==
X-Google-Smtp-Source: AAOMgpcK1ewCqq6odrwJhFpkSrexBENdFrCFrGon7HVnL3WEzRaBixZ9j2u6sWU6fE7Le4EpcywDCw==
X-Received: by 2002:a24:eb0e:: with SMTP id h14-v6mr7899414itj.69.1530566411606;
        Mon, 02 Jul 2018 14:20:11 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id h75-v6sm776729ioh.50.2018.07.02.14.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:20:11 -0700 (PDT)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] ASoC: AMD: Fix Capture DMA channel names
Date:   Mon,  2 Jul 2018 15:19:53 -0600
Message-Id: <20180702211956.149355-4-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On capture, audio data is first copied from I2S to ACP memory, and then
to SYSRAM.  For each step the channel number increases, so the names in
the driver were wrong.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 24 ++++++++++++------------
 sound/soc/amd/acp.h         |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 224383fef0c3a..2a6a6e65e27c3 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -697,31 +697,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
-		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
-			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		acp_reg_write((intr_flag &
-			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
@@ -899,8 +899,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
-			rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
-			rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->ch1 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
 			rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
@@ -914,8 +914,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		case I2S_SP_INSTANCE:
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-			rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
-			rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+			rtd->ch1 = I2S_TO_ACP_DMA_CH_NUM;
+			rtd->ch2 = ACP_TO_SYSRAM_CH_NUM;
 			switch (adata->asic_type) {
 			case CHIP_STONEY:
 				rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3190fdce63074..0a2240bff62e1 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -74,16 +74,16 @@
 #define ACP_TO_I2S_DMA_CH_NUM 13
 
 /* Capture DMA channels */
-#define ACP_TO_SYSRAM_CH_NUM 14
-#define I2S_TO_ACP_DMA_CH_NUM 15
+#define I2S_TO_ACP_DMA_CH_NUM 14
+#define ACP_TO_SYSRAM_CH_NUM 15
 
 /* Playback DMA Channels for I2S BT instance */
 #define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
 #define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
 
 /* Capture DMA Channels for I2S BT Instance */
-#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
-#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 10
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 11
 
 #define NUM_DSCRS_PER_CHANNEL 2
 
-- 
2.18.0.399.gad0ab374a1-goog

