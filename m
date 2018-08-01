Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F0920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F0920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388864AbeHAMdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:33:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39177 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbeHAMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:33:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkofP-0006WD-UK; Wed, 01 Aug 2018 10:47:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] ALSA: cs5535audio: remove redundant pointer 'dma'
Date:   Wed,  1 Aug 2018 11:47:35 +0100
Message-Id: <20180801104742.4328-3-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'dma' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up two clang warnings:
warning: variable 'dma' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs5535audio/cs5535audio.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index de409cda50aa..4590086d9cd8 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -192,8 +192,6 @@ static void process_bm0_irq(struct cs5535audio *cs5535au)
 	bm_stat = cs_readb(cs5535au, ACC_BM0_STATUS);
 	spin_unlock(&cs5535au->reg_lock);
 	if (bm_stat & EOP) {
-		struct cs5535audio_dma *dma;
-		dma = cs5535au->playback_substream->runtime->private_data;
 		snd_pcm_period_elapsed(cs5535au->playback_substream);
 	} else {
 		dev_err(cs5535au->card->dev,
@@ -208,11 +206,8 @@ static void process_bm1_irq(struct cs5535audio *cs5535au)
 	spin_lock(&cs5535au->reg_lock);
 	bm_stat = cs_readb(cs5535au, ACC_BM1_STATUS);
 	spin_unlock(&cs5535au->reg_lock);
-	if (bm_stat & EOP) {
-		struct cs5535audio_dma *dma;
-		dma = cs5535au->capture_substream->runtime->private_data;
+	if (bm_stat & EOP)
 		snd_pcm_period_elapsed(cs5535au->capture_substream);
-	}
 }
 
 static irqreturn_t snd_cs5535audio_interrupt(int irq, void *dev_id)
-- 
2.17.1

