Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC2D2157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC2D2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeI0L2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:28:30 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58135 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0L2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:28:30 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g5Oas-0002wS-0M from Jiada_Wang@mentor.com ; Wed, 26 Sep 2018 22:12:06 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 22:12:02 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next 09/10] ASoC: rsnd: add busif property to dai stream
Date:   Thu, 27 Sep 2018 14:12:12 +0900
Message-ID: <20180927051212.18032-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

SSI may use different busif for data transfer, this patch
adds busif property to each dai stream, to indicate the
busif used by playback/capture stream.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/core.c | 16 +++++++++++++++-
 sound/soc/sh/rcar/rsnd.h |  3 +++
 sound/soc/sh/rcar/ssi.c  |  5 ++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 40d7dc4f7839..aee3132c72b9 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -560,6 +560,14 @@ struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id)
 	return priv->rdai + id;
 }
 
+struct rsnd_kctrl_cfg_s *rsnd_busif_get(struct rsnd_priv *priv, int id)
+{
+	if ((id < 0) || (id >= 2 * rsnd_rdai_nr(priv)))
+		return NULL;
+
+	return priv->busif + id;
+}
+
 static struct snd_soc_dai_driver
 *rsnd_daidrv_get(struct rsnd_priv *priv, int id)
 {
@@ -1045,6 +1053,9 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	io_playback	= &rdai->playback;
 	io_capture	= &rdai->capture;
 
+	io_playback->busif = rsnd_busif_get(priv, dai_i);
+	io_capture->busif  = rsnd_busif_get(priv, rsnd_rdai_nr(priv) + dai_i);
+
 	snprintf(rdai->name, RSND_DAI_NAME_SIZE, "rsnd-dai.%d", dai_i);
 
 	rdai->priv	= priv;
@@ -1108,6 +1119,7 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 	struct snd_soc_dai_driver *rdrv;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_dai *rdai;
+	struct rsnd_kctrl_cfg_s *busif;
 	int nr;
 	int is_graph;
 	int dai_i;
@@ -1123,12 +1135,14 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 
 	rdrv = devm_kcalloc(dev, nr, sizeof(*rdrv), GFP_KERNEL);
 	rdai = devm_kcalloc(dev, nr, sizeof(*rdai), GFP_KERNEL);
-	if (!rdrv || !rdai)
+	busif = devm_kcalloc(dev, 2 * nr, sizeof(*busif), GFP_KERNEL);
+	if (!rdrv || !rdai || !busif)
 		return -ENOMEM;
 
 	priv->rdai_nr	= nr;
 	priv->daidrv	= rdrv;
 	priv->rdai	= rdai;
+	priv->busif	= busif;
 
 	/*
 	 * parse all dai
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 4464d1d0a042..59b6d89d8edc 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -456,6 +456,7 @@ struct rsnd_dai_stream {
 	struct rsnd_mod *dma;
 	struct rsnd_dai *rdai;
 	struct device *dmac_dev; /* for IPMMU */
+	struct rsnd_kctrl_cfg_s *busif;
 	u32 parent_ssi_status;
 };
 #define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
@@ -629,6 +630,8 @@ struct rsnd_priv {
 	 */
 	struct snd_soc_dai_driver *daidrv;
 	struct rsnd_dai *rdai;
+	struct rsnd_kctrl_cfg_s *busif;
+
 	int rdai_nr;
 };
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 75a3d15084c2..4ac4b5b75ae2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -154,7 +154,10 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 
 int rsnd_ssi_get_busif(struct rsnd_dai_stream *io)
 {
-	return 0; /* BUSIF0 only for now */
+	if (!rsnd_ssi_use_busif(io))
+		return 0;
+
+	return io->busif->val;
 }
 
 static void rsnd_ssi_status_clear(struct rsnd_mod *mod)
-- 
2.17.0

