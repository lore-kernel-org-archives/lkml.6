Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E1C5ACC7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60A2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E60A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeKUIIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:35018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKUIIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="281632610"
Received: from pmvancle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.10.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2018 13:36:57 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/6] ASoC: Intel: Skylake: stop init/probe if DSP is not present
Date:   Tue, 20 Nov 2018 15:36:40 -0600
Message-Id: <20181120213644.19103-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check immediately if the DSP can be found, bail and avoid doing inits
to enable legacy fallback without delay.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index df36b8fe6d5e..1d7146773d19 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -931,6 +931,12 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
+	/* check if dsp is there */
+	if (!bus->ppcap) {
+		dev_err(bus->dev, "bus ppcap not set, DSP not present?\n");
+		return -ENODEV;
+	}
+
 	if (skl_acquire_irq(bus, 0) < 0)
 		return -EBUSY;
 
@@ -940,23 +946,25 @@ static int skl_first_init(struct hdac_bus *bus)
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
 
-	/* allow 64bit DMA address if supported by H/W */
-	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
-		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
-	} else {
-		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
-		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
-	}
-
 	/* read number of streams from GCAP register */
 	cp_streams = (gcap >> 8) & 0x0f;
 	pb_streams = (gcap >> 12) & 0x0f;
 
-	if (!pb_streams && !cp_streams)
+	if (!pb_streams && !cp_streams) {
+		dev_err(bus->dev, "no streams found in GCAP definitions?\n");
 		return -EIO;
+	}
 
 	bus->num_streams = cp_streams + pb_streams;
 
+	/* allow 64bit DMA address if supported by H/W */
+	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
+		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
+	} else {
+		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
+		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
+	}
+
 	/* initialize streams */
 	snd_hdac_ext_stream_init_all
 		(bus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
-- 
2.17.1

