Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52BC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EA92083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EA92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeHWMKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49870 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731514AbeHWMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:17 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E0368B1;
        Thu, 23 Aug 2018 08:41:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 051/324] dmaengine: ti: omap-dma: Fix OMAP1510 incorrect residue_granularity
Date:   Thu, 23 Aug 2018 09:51:57 +0200
Message-Id: <20180823074958.353762867@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit c9bd0946da243a8eb86b44ff613e2c813f9b683b ]

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

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/omap-dma.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1485,7 +1485,11 @@ static int omap_dma_probe(struct platfor
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


