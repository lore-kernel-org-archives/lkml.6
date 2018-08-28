Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02EE2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eyhKJzir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02EE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeH2AlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:41:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40906 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeH2AlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NsxgS46MSXxWYtPSpUDUCS2S5yrr30aMn3yL0/vHhlA=; b=eyhKJzirpWLd
        HrQcTVLr8G62OLgB9m9BbisqYRXhX8UN7dkI0Cryt16Z6jyXoN194i/Yx8lL7dAksXkGtn99Wx9lX
        +ikbsi9kqcToMPKBJY48NV312BEQ5VJNo1M7Xk+D6mXwhHSR5L7KF57GDQyYHW70PnJxjiljOElJS
        8PG2s=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuktW-0007jB-Ny; Tue, 28 Aug 2018 20:47:27 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F3EC244007A; Tue, 28 Aug 2018 21:47:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-tdm: restrict formats depending on slot width" to the asoc tree
In-Reply-To:  <20180827142107.8153-1-jbrunet@baylibre.com>
Message-Id: <20180828204703.F3EC244007A@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:47:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-tdm: restrict formats depending on slot width

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 302df2694b97e6a56f7956c1105630809b141ea0 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 27 Aug 2018 16:21:07 +0200
Subject: [PATCH] ASoC: meson: axg-tdm: restrict formats depending on slot
 width

Restrict the formats possible on the TDM interface depending on the width
of the TDM slot and let dpcm merging do the rest.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 50 +++++++++++++++++------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 7b8baf46d968..585ce030b79b 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -42,6 +42,7 @@ int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
 	struct axg_tdm_stream *rx = (struct axg_tdm_stream *)
 		dai->capture_dma_data;
 	unsigned int tx_slots, rx_slots;
+	unsigned int fmt = 0;
 
 	tx_slots = axg_tdm_slots_total(tx_mask);
 	rx_slots = axg_tdm_slots_total(rx_mask);
@@ -52,38 +53,45 @@ int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
 		return -EINVAL;
 	}
 
-	/*
-	 * Amend the dai driver channel number and let dpcm channel merge do
-	 * its job
-	 */
-	if (tx) {
-		tx->mask = tx_mask;
-		dai->driver->playback.channels_max = tx_slots;
-	}
-
-	if (rx) {
-		rx->mask = rx_mask;
-		dai->driver->capture.channels_max = rx_slots;
-	}
-
 	iface->slots = slots;
 
 	switch (slot_width) {
 	case 0:
-		/* defaults width to 32 if not provided */
-		iface->slot_width = 32;
-		break;
-	case 8:
-	case 16:
-	case 24:
+		slot_width = 32;
+		/* Fall-through */
 	case 32:
-		iface->slot_width = slot_width;
+		fmt |= SNDRV_PCM_FMTBIT_S32_LE;
+		/* Fall-through */
+	case 24:
+		fmt |= SNDRV_PCM_FMTBIT_S24_LE;
+		fmt |= SNDRV_PCM_FMTBIT_S20_LE;
+		/* Fall-through */
+	case 16:
+		fmt |= SNDRV_PCM_FMTBIT_S16_LE;
+		/* Fall-through */
+	case 8:
+		fmt |= SNDRV_PCM_FMTBIT_S8;
 		break;
 	default:
 		dev_err(dai->dev, "unsupported slot width: %d\n", slot_width);
 		return -EINVAL;
 	}
 
+	iface->slot_width = slot_width;
+
+	/* Amend the dai driver and let dpcm merge do its job */
+	if (tx) {
+		tx->mask = tx_mask;
+		dai->driver->playback.channels_max = tx_slots;
+		dai->driver->playback.formats = fmt;
+	}
+
+	if (rx) {
+		rx->mask = rx_mask;
+		dai->driver->capture.channels_max = rx_slots;
+		dai->driver->capture.formats = fmt;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_set_tdm_slots);
-- 
2.18.0

