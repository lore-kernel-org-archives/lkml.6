Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0853C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A020C21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A020C21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeI0L2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:28:47 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58151 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0L2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:28:47 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g5Ob9-0002xI-Cw from Jiada_Wang@mentor.com ; Wed, 26 Sep 2018 22:12:23 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 22:12:19 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next 10/10] ASoC: rsnd: Add kctrl to configure dai's busif
Date:   Thu, 27 Sep 2018 14:12:29 +0900
Message-ID: <20180927051229.18080-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

ssi0, ssi1, ssi2, ssi3, ssi4 and ssi9 have busif0 to busif7,
currently only busif0 is used by all ssi.
But tdm split and tdm ex-split mode, which require busif1 to
busif7.

This patch adds kctrl in ssi for dai-link, to make it possible
to configure the busif used by each dai-link.
Also adds rsnd_dma_addr_update() interface to make it possible
to update dma data address when there is change in condition
of dai connection.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/dma.c  | 32 ++++++++++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  2 ++
 sound/soc/sh/rcar/ssi.c  | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 6d1947515dc8..8c284fd73fc1 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -792,6 +792,38 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 	return rsnd_dai_connect(*dma_mod, io, (*dma_mod)->type);
 }
 
+void rsnd_dma_addr_update(struct rsnd_dai_stream *io,
+			  struct rsnd_mod *mod,
+			  struct rsnd_mod *dma_mod)
+{
+	struct rsnd_mod *mod_from = NULL;
+	struct rsnd_mod *mod_to = NULL;
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	int is_play = rsnd_io_is_play(io);
+	struct rsnd_dma *dma = rsnd_mod_to_dma(dma_mod);
+
+	if (!dmac)
+		return;
+
+	rsnd_dma_of_path(mod, io, is_play, &mod_from, &mod_to);
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
+		rsnd_mod_name(mod), rsnd_mod_id(mod),
+		&dma->src_addr, &dma->dst_addr);
+}
+
 int rsnd_dma_probe(struct rsnd_priv *priv)
 {
 	struct platform_device *pdev = rsnd_priv_to_pdev(priv);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 59b6d89d8edc..6c16d8403f7a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -233,6 +233,8 @@ u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
  */
 int rsnd_dma_attach(struct rsnd_dai_stream *io,
 		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
+void rsnd_dma_addr_update(struct rsnd_dai_stream *io,
+			  struct rsnd_mod *mod, struct rsnd_mod *dma_mod);
 int rsnd_dma_probe(struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 					  struct rsnd_mod *mod, char *name);
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 4ac4b5b75ae2..b469db238697 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -160,6 +160,15 @@ int rsnd_ssi_get_busif(struct rsnd_dai_stream *io)
 	return io->busif->val;
 }
 
+static void rsnd_ssi_set_busif(struct rsnd_dai_stream *io,
+			       struct rsnd_mod *mod)
+{
+	if (!rsnd_ssi_use_busif(io))
+		return;
+
+	rsnd_dma_addr_update(io, mod, io->dma);
+}
+
 static void rsnd_ssi_status_clear(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, SSISR, 0);
@@ -718,6 +727,10 @@ static int rsnd_ssi_pcm_new(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    struct snd_soc_pcm_runtime *rtd)
 {
+	int is_play = rsnd_io_is_play(io);
+	int id = rsnd_mod_id(mod);
+	int ret = 0;
+
 	/*
 	 * rsnd_rdai_is_clk_master() will be enabled after set_fmt,
 	 * and, pcm_new will be called after it.
@@ -725,7 +738,23 @@ static int rsnd_ssi_pcm_new(struct rsnd_mod *mod,
 	 */
 	rsnd_ssi_parent_attach(mod, io);
 
-	return 0;
+	if (!rsnd_ssi_use_busif(io))
+		return 0;
+
+	if (rsnd_ssi_is_multi_slave(mod, io))
+		return 0;
+
+	/* SSI5 to SSI8 only have one BUSIF */
+	if (id <= 4 || id == 9)
+		ret = rsnd_kctrl_new_s(mod, io, rtd,
+				       is_play ?
+				       "SSI Out BUSIF" :
+				       "SSI In BUSIF",
+				       rsnd_kctrl_accept_anytime,
+				       rsnd_ssi_set_busif,
+				       io->busif, 7);
+
+	return ret;
 }
 
 static int rsnd_ssi_common_probe(struct rsnd_mod *mod,
-- 
2.17.0

