Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB54C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F9D24FE3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fFuqR2/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F9D24FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeGBVVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:21:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40616 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeGBVUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:14 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so255490ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPbxhTSWC6O0G+NWKxurVzbQQPIYMg5fubB9OKv6290=;
        b=fFuqR2/9BeLWrYyal2lCpLKX0IlXcM4wfFuK+OT0cZ0vIggq3Z2EyYwuVQdot1FugP
         LRzceLNAYBNe+FnZlBg8ITBTNJdaSUiz8H3H/S3PWfgMlUALzXhiILwg+/fhZFwIhvmv
         fR6Ct05wfk0hf0zy4ZBkMBHqcINFYZyEjzFO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kPbxhTSWC6O0G+NWKxurVzbQQPIYMg5fubB9OKv6290=;
        b=TZ4ksx7VvniAJjAr5kYFd/eOPLxnvyNpbidKmnvQ6XVAIUP9X22ERtrNQqWNh7dUxA
         g68zlOLe/jOAb2E8+na/0uFQni71PP/GMS8VMVKqIcnWu8kDlpQ90TLwzvONPkXAaibV
         GvWb7ILW14YlX95qzCTQBe9j4t4/XaFEv9FEy7xpvdHgh68GDYx7jRchMU504Lsh7GaM
         AJ2ckgPH9BvunVwRRIk90PADO2KwnDleMmyZPImd0NW9z2eU3lN0tIvqCXkgSdQRPAl/
         ihPmbyjHhR4ItBkRHPuX//F/OGZfc+Wn4OXUieHBopP7TcaJmAKDdig1Pyt1kdJzKDKp
         J6Jw==
X-Gm-Message-State: APt69E086vUbUWvt2aRAKY8oVBz3+rn+AI5JSmE6mLg5LU0aj0EoDiVV
        O78Myb0Pv0VNK/DIP8AzFrwAeQ==
X-Google-Smtp-Source: AAOMgpeWrZvpkqugR09+1c2G/TxtS12yrdAgbgJ1ISIMUcMDOxO3tImz43tVW880qU/2P32Ubf7/7w==
X-Received: by 2002:a24:73c1:: with SMTP id y184-v6mr2977234itb.31.1530566414328;
        Mon, 02 Jul 2018 14:20:14 -0700 (PDT)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id h75-v6sm776729ioh.50.2018.07.02.14.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:20:13 -0700 (PDT)
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
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/6] ASoC: AMD: Do not generate interrups for every captured sample
Date:   Mon,  2 Jul 2018 15:19:54 -0600
Message-Id: <20180702211956.149355-5-djkurtz@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
In-Reply-To: <20180702211956.149355-1-djkurtz@chromium.org>
References: <20180702211956.149355-1-djkurtz@chromium.org>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On capture, audio data is first copied from I2S to ACP memory, and then
from ACP to SYSRAM.  The I2S_TO_ACP_DMA interrupt fires on every sample
transferred from I2S to ACP memory.  That is it fires ~48000 times per
second when capturing @ 48 kHz.  Since we don't do anything on this
interrupt anyway, disable it to save quite a few unnecessary interrupts.
The real "work" (calling snd_pcm_period_elapsed()) is done when transfer
from ACP to SYSRAM is complete.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 2a6a6e65e27c3..ab60129f4f266 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -412,10 +412,8 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 	switch (ch_num) {
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
-	case I2S_TO_ACP_DMA_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
 	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
-	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -704,12 +702,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
-		valid_irq = true;
-		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
-			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
-	}
-
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
@@ -718,13 +710,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
-		valid_irq = true;
-		acp_reg_write((intr_flag &
-			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
-			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
-	}
-
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
-- 
2.18.0.399.gad0ab374a1-goog

