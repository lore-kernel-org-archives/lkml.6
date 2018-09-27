Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D832C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CD82156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CD82156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeI0LU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:20:27 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57674 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeI0LU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:20:26 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g5OT6-0002AR-PT from Jiada_Wang@mentor.com ; Wed, 26 Sep 2018 22:04:04 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 22:04:01 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next 01/10] ASoC: rsnd: ssi: Request dedicated dma channels for busif1 to 7
Date:   Thu, 27 Sep 2018 14:03:58 +0900
Message-ID: <20180927050407.17765-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180927050407.17765-1-jiada_wang@mentor.com>
References: <20180927050407.17765-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently ssi driver only request dma channel for SSI_0,
which is used to transfer data to/from busif0.

But since busif1 to busif7 also maybe used, dedicated dma channels
are request for data transfer between these busif.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3adcc4f778f7..75a3d15084c2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -76,6 +76,8 @@
 
 #define SSI_NAME "ssi"
 
+#define SSI_DMA_NAME_SIZE	10
+
 struct rsnd_ssi {
 	struct rsnd_mod mod;
 
@@ -938,12 +940,20 @@ static struct dma_chan *rsnd_ssi_dma_req(struct rsnd_dai_stream *io,
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	int is_play = rsnd_io_is_play(io);
-	char *name;
+	int busif = rsnd_ssi_get_busif(io);
+	char name[SSI_DMA_NAME_SIZE];
 
-	if (rsnd_ssi_use_busif(io))
-		name = is_play ? "rxu" : "txu";
-	else
-		name = is_play ? "rx" : "tx";
+	if (rsnd_ssi_use_busif(io)) {
+		if (is_play)
+			snprintf(name, SSI_DMA_NAME_SIZE, "rxu%d", busif);
+		else
+			snprintf(name, SSI_DMA_NAME_SIZE, "txu%d", busif);
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

