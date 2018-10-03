Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0F7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DFE20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DFE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJCPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:49:24 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57833 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJCPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:49:23 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7d2O-0002lr-Q0 from Jiada_Wang@mentor.com ; Wed, 03 Oct 2018 02:01:44 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 3 Oct 2018 02:01:41 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 9/9] ASoC: rsnd: add busif property to dai stream
Date:   Wed, 3 Oct 2018 18:01:36 +0900
Message-ID: <20181003090136.4556-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

in GEN3 SSI may use different BUSIF for data transfer,
this patch adds busif property to each dai stream,
to indicate the BUSIF used by playback/capture stream.

Also adds rsnd_ssi_select_busif() to automatically select
BUSIF (currently only BUSIF0 is selected)

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/core.c |  3 +++
 sound/soc/sh/rcar/dma.c  | 31 +++++++++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  3 +++
 sound/soc/sh/rcar/ssi.c  | 30 +++++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 40d7dc4f7839..5e3e6e65bcdf 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1158,6 +1158,9 @@ static int rsnd_hw_params(struct snd_pcm_substream *substream,
 	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
 	struct rsnd_dai_stream *io = rsnd_rdai_to_io(rdai, substream);
 	int ret;
+	int chan = rsnd_runtime_channel_for_ssi_with_params(io, hw_params);
+
+	rsnd_ssi_select_busif(io, chan);
 
 	ret = rsnd_dai_call(hw_params, io, substream, hw_params);
 	if (ret)
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 6d1947515dc8..bf87939f79bb 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -792,6 +792,37 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 	return rsnd_dai_connect(*dma_mod, io, (*dma_mod)->type);
 }
 
+void rsnd_dma_addr_update(struct rsnd_dai_stream *io)
+{
+	struct rsnd_mod *ssi_mod = rsnd_io_to_mod_ssi(io);
+	struct rsnd_mod *mod_from = NULL;
+	struct rsnd_mod *mod_to = NULL;
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	int is_play = rsnd_io_is_play(io);
+	struct rsnd_dma *dma = rsnd_mod_to_dma(io->dma);
+
+	if (!dmac)
+		return;
+
+	rsnd_dma_of_path(ssi_mod, io, is_play, &mod_from, &mod_to);
+
+	dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
+	dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
+
+	if (mod_from && mod_to) {
+		struct rsnd_dmapp *dmapp = rsnd_dma_to_dmapp(dma);
+
+		dmapp->chcr = rsnd_dmapp_get_chcr(io, mod_from, mod_to) |
+						  PDMACHCR_DE;
+	}
+
+	dev_dbg(dev, "%s[%d] %pad -> %pad\n",
+		rsnd_mod_name(ssi_mod), rsnd_mod_id(ssi_mod),
+		&dma->src_addr, &dma->dst_addr);
+}
+
 int rsnd_dma_probe(struct rsnd_priv *priv)
 {
 	struct platform_device *pdev = rsnd_priv_to_pdev(priv);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 4464d1d0a042..7ce10267c87b 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -227,12 +227,14 @@ void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
+void rsnd_ssi_select_busif(struct rsnd_dai_stream *io, int chan);
 
 /*
  *	R-Car DMA
  */
 int rsnd_dma_attach(struct rsnd_dai_stream *io,
 		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
+void rsnd_dma_addr_update(struct rsnd_dai_stream *io);
 int rsnd_dma_probe(struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 					  struct rsnd_mod *mod, char *name);
@@ -457,6 +459,7 @@ struct rsnd_dai_stream {
 	struct rsnd_dai *rdai;
 	struct device *dmac_dev; /* for IPMMU */
 	u32 parent_ssi_status;
+	u32 busif;
 };
 #define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
 #define rsnd_io_to_mod_ssi(io)	rsnd_io_to_mod((io), RSND_MOD_SSI)
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 992aeac09e76..d515ee192276 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -154,7 +154,35 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 
 int rsnd_ssi_get_busif(struct rsnd_dai_stream *io)
 {
-	return 0; /* BUSIF0 only for now */
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+
+	if (!rsnd_is_gen3(priv))
+		return 0;
+
+	if (!rsnd_ssi_use_busif(io))
+		return 0;
+
+	return io->busif;
+}
+
+void rsnd_ssi_select_busif(struct rsnd_dai_stream *io, int chan)
+{
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	u32 busif = 0; /* BUSIF0 only for now */
+
+	if (!rsnd_is_gen3(priv))
+		return;
+
+	if (!rsnd_ssi_use_busif(io))
+		return;
+
+	/* FIXME: calcuate BUSIF based on SSI mode in future */
+	if (io->busif == busif)
+		return;
+
+	io->busif = busif;
+
+	rsnd_dma_addr_update(io);
 }
 
 static void rsnd_ssi_status_clear(struct rsnd_mod *mod)
-- 
2.17.0

