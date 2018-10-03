Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D9EC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6B820835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6B820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeJCPtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:49:00 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57801 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJCPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:48:59 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g7d2A-0002j0-4w from Jiada_Wang@mentor.com ; Wed, 03 Oct 2018 02:01:30 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 3 Oct 2018 02:01:26 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 8/9] ASoC: rsnd: ssi: Request dedicated dma channels for busif0 to 7
Date:   Wed, 3 Oct 2018 18:01:22 +0900
Message-ID: <20181003090122.4508-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently ssi driver only request dma channel for SSI_0,
which is used to transfer data to/from busif0.

But in GEN3 busif1 to busif7 also maybe used, dedicated dma channels
are requested for data transfer through these busif.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssi.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3adcc4f778f7..992aeac09e76 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -76,6 +76,8 @@
 
 #define SSI_NAME "ssi"
 
+#define SSI_DMA_NAME_SIZE	10
+
 struct rsnd_ssi {
 	struct rsnd_mod mod;
 
@@ -938,12 +940,28 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
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
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu");
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu");
+
+		if (rsnd_is_gen3(priv)) {
+			/*
+			 * Gen3 supports to use all available BUSIF
+			 */
+			int busif = rsnd_ssi_get_busif(io);
+
+			snprintf(name, SSI_DMA_NAME_SIZE, "%s%d", name, busif);
+		}
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

