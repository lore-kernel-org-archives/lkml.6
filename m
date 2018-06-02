Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeFBP1x (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 11:27:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34519 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFBP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 11:27:51 -0400
X-Google-Smtp-Source: ADUXVKJATshII/xjWDPsJYwM1DiUV+52fciFAwNXrMvWSPRsa53z6zyFK2jx4lPTrknoxnQPBM4yzA==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2] DMA: OMAP: fix OMAP1510 incorrect residue_granularity
Date: Sat,  2 Jun 2018 17:27:19 +0200
Message-Id: <20180602152719.28464-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0198d7bb8a0c ("ASoC: omap-mcbsp: Convert to use the sdma-pcm
instead of omap-pcm") resulted in broken audio playback on OMAP1510
(discovered on Amstrad Delta).

When running on OMAP1510, omap-pcm used to obtain DMA offset from
snd_dmaengine_pcm_pointer_no_residue() based on DMA interrupt triggered
software calculations instead of snd_dmaengine_pcm_pointer() which
depended on residue value calculated from omap_dma_get_src_pos().
Similar code path is still available in now used
sound/soc/soc-generic-dmaengine-pcm.c but it is not triggered.

It was verified already before that omap_get_dma_src_pos() from
arch/arm/plat-omap/dma.c didn't work correctly for OMAP1510 - see
commit 1bdd7419910c ("ASoC: OMAP: fix OMAP1510 broken PCM pointer
callback") for details.  Apparently the same applies to its successor,
omap_dma_get_src_pos() from drivers/dma/ti/omap-dma.c.

On the other hand, snd_dmaengine_pcm_pointer_no_residue() is described
as depreciated and discouraged for use in new drivers because of its
unreliable accuracy.  However, it seems the only working option for
OPAM1510 now, as long as a software calculated residue is not
implemented as OMAP1510 fallback in omap-dma.

Using snd_dmaengine_pcm_pointer_no_residue() code path instead of
snd_dmaengine_pcm_pointer() in sound/soc/soc-generic-dmaengine-pcm.c
can be triggered in two ways:
- by passing pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE from
  sound/soc/omap/sdma-pcm.c,
- by passing dma_caps.residue_granularity =
  DMA_RESIDUE_GRANULARITY_DESCRIPTOR from DMA engine.

Let's do the latter.

Created and tested against next-20180531 tag from linux-next tree.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: apply the patch against omap-dma.c moved to drivers/dma/ti/

 drivers/dma/ti/omap-dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index b73fb51fbc81..96b5096c26dd 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1485,7 +1485,11 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.src_addr_widths = OMAP_DMA_BUSWIDTHS;
 	od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
 	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	if (__dma_omap15xx(od->plat->dma_attr))
+		od->ddev.residue_granularity =
+				DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	else
+		od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	od->ddev.max_burst = SZ_16M - 1; /* CCEN: 24bit unsigned */
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
-- 
2.16.1
