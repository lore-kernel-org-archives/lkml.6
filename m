Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D172C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1520672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA1520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeLKCGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:06:16 -0500
Received: from muru.com ([72.249.23.125]:57244 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeLKCGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:06:12 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B9EE78132;
        Tue, 11 Dec 2018 02:06:14 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/2] ASoC: simple-card-utils: revert port changes to follow graph binding
Date:   Mon, 10 Dec 2018 18:05:56 -0800
Message-Id: <20181211020557.61783-2-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211020557.61783-1-tony@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b6f3fc005a2c ("ASoC: simple-card-utils: fixup
asoc_simple_card_get_dai_id() counting") changed endpoint parsing for
asoc_simple_card_get_dai_id(), but it seems the old code is correct.

This code should follow the generic binding documentation for
Documentation/devicetree/bindings/graph.txt that allows multiple
endpoints for each port.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/generic/simple-card-utils.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -269,19 +269,35 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
 
 static int asoc_simple_card_get_dai_id(struct device_node *ep)
 {
-	struct of_endpoint info;
+	struct device_node *node;
+	struct device_node *endpoint;
+	int i, id;
 	int ret;
 
 	ret = snd_soc_get_dai_id(ep);
 	if (ret != -ENOTSUPP)
 		return ret;
 
+	node = of_graph_get_port_parent(ep);
+
 	/*
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	of_graph_parse_endpoint(ep, &info);
-	return info.port;
+	i = 0;
+	id = -1;
+	for_each_endpoint_of_node(node, endpoint) {
+		if (endpoint == ep)
+			id = i;
+		i++;
+	}
+
+	of_node_put(node);
+
+	if (id < 0)
+		return -ENODEV;
+
+	return id;
 }
 
 int asoc_simple_card_parse_graph_dai(struct device_node *ep,
-- 
2.19.2
