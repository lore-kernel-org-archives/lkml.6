Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFDAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8592085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8592085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJJQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:38:50 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:51193 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:38:50 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gAAcV-0000Qy-4n from Jiada_Wang@mentor.com ; Wed, 10 Oct 2018 02:17:31 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 10 Oct 2018 02:17:27 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next v3 1/1] ASoC: rsnd: ssi: Request dedicated dma channels for busif0 to 7
Date:   Wed, 10 Oct 2018 18:17:25 +0900
Message-ID: <20181010091725.10016-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently ssi driver only requests dma channel for SSI_0, with
naming of 'rxu/txu', which is used to transfer data to/from busif0.
But for GEN2/GEN3, there are also busif1 ~ busif7, which need to
be used when SSI works in TDM Split/Ex-Split mode.

This patch adds support to firstly try to request busif indexed
dma channel with naming "rxu[busif]/txu[busif]", if these dma channel
don't exist, then try to request 'rxu/txu' dma channel to keep
compatibility with platform hasn't had device-tree updated.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
v3:
- Drop device-tree changes
- Drop automatic busif selection

v2:
- Instead of configure BUSIF by kctl interface "SSI Out/In BUSIF",
  use rsnd_ssi_select_busif() to automatically select BUSIF.
- Keep 'rxu/txu' dma request, to keep compatibility with GEN2 series
- Re-order patch-set to satisfy git bisect

v1: initial version
---
 sound/soc/sh/rcar/ssi.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3adcc4f778f7..7e21b29249d7 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -76,6 +76,8 @@
 
 #define SSI_NAME "ssi"
 
+#define SSI_DMA_NAME_SIZE	10
+
 struct rsnd_ssi {
 	struct rsnd_mod mod;
 
@@ -938,12 +940,37 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	int is_play = rsnd_io_is_play(io);
-	char *name;
+	char name[SSI_DMA_NAME_SIZE];
 
-	if (rsnd_ssi_use_busif(io))
-		name = is_play ? "rxu" : "txu";
-	else
-		name = is_play ? "rx" : "tx";
+	if (rsnd_ssi_use_busif(io)) {
+		int busif = rsnd_ssi_get_busif(io);
+		struct dma_chan *chan = NULL;
+
+		/* try to request rxu/txu channel with busif index first */
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu%d", busif);
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu%d", busif);
+
+		chan = rsnd_dma_request_channel(rsnd_ssi_of_node(priv),
+						mod, name);
+		if (!IS_ERR(chan))
+			return chan;
+
+		/*
+		 * If dma channel with busif index doesn't exist
+		 * request rxu/txu dma channel
+		 */
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu");
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu");
+	} else {
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rx");
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "tx");
+	}
 
 	return rsnd_dma_request_channel(rsnd_ssi_of_node(priv),
 					mod, name);
-- 
2.17.0

