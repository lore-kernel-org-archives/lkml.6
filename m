Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B27C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9320672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbeLKCGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:06:15 -0500
Received: from muru.com ([72.249.23.125]:57258 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbeLKCGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:06:13 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 48DB68138;
        Tue, 11 Dec 2018 02:06:16 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/2] ASoC: audio-graph-card: Fix parsing of multiple endpoints
Date:   Mon, 10 Dec 2018 18:05:57 -0800
Message-Id: <20181211020557.61783-3-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211020557.61783-1-tony@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently use only the first endpoint even if multiple endpoints
are configured for a port.

We should follow what's specified in the device graph binding
document Documentation/devicetree/bindings/graph.txt in paragraph
"Organisation of ports and endpoints":

"If a single port is connected to more than one remote device, an
 'endpoint' child node must be provided for each link."

This is the case for example for I2S where multiple devices can be
connected to a single I2S port sharing it using TDM (Time-Division
Multiplexing).

To fix this, we need to iterate over each endpoint for a port.

Note that the dts "dais" property should still contain a single
property for each port, and not for each endpoint.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/generic/audio-graph-card.c | 41 ++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -156,17 +156,17 @@ static int asoc_graph_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
+static int asoc_graph_card_ep_of(struct device_node *cpu_port,
+					struct device_node *cpu_ep,
 					struct graph_card_data *priv,
 					int *dai_idx, int link_idx)
 {
 	struct device *dev = graph_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = graph_priv_to_link(priv, link_idx);
 	struct graph_dai_props *dai_props = graph_priv_to_props(priv, link_idx);
+	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 	struct asoc_simple_dai *cpu_dai;
 	struct asoc_simple_dai *codec_dai;
-	struct device_node *cpu_ep    = of_get_next_child(cpu_port, NULL);
-	struct device_node *codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 	int ret;
 
 	cpu_dai			=
@@ -230,6 +230,31 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	return ret;
 }
 
+static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
+					struct graph_card_data *priv,
+					int *dai_idx, int link_idx)
+{
+	struct device *dev = graph_priv_to_dev(priv);
+	struct device_node *ep = NULL;
+	int num_ep, ep_idx, ret;
+
+	num_ep = of_get_child_count(cpu_port);
+	if (!num_ep) {
+		dev_err(dev, "no cpu endpoints found for %pOf\n", cpu_port);
+		return -ENODEV;
+	}
+
+	for (ep_idx = 0; ep_idx < num_ep; ep_idx++) {
+		ep = of_get_next_child(cpu_port, ep);
+		ret = asoc_graph_card_ep_of(cpu_port, ep, priv,
+					    dai_idx, link_idx + ep_idx);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 {
 	struct of_phandle_iterator it;
@@ -272,8 +297,14 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	int count = 0;
 	int rc;
 
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
-		count++;
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+		int ep_count = of_get_child_count(it.node);
+
+		if (ep_count)
+			count += ep_count;
+		else
+			count++;
+	}
 
 	return count;
 }
-- 
2.19.2
