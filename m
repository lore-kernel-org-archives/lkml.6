Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeAaGCF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:02:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38060 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbeAaGCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:02:04 -0500
X-Google-Smtp-Source: AH8x227XTXSs4KFeRVYTBqVlX9biF7zZ0IeLwHar54kPLFEAq4508XnPGcZK2iFGtnY+2BgUQd7aUw==
X-Google-Original-Sender: <johan@kernel.org>
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Johan Hovold <johan@kernel.org>, PC Liao <pc.liao@mediatek.com>
Subject: [PATCH] ASoC: mt8173-rt5650: fix child-node lookup
Date: Wed, 31 Jan 2018 16:59:21 +1100
Message-Id: <20180131055921.25574-1-johan@kernel.org>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver used the wrong OF-helper when looking up the optional
capture-codec child node during probe. Instead of searching just
children of the sound node, a tree-wide depth-first search starting at
the unrelated platform node was done. Not only could this end up
matching an unrelated node or no node at all; the platform node could
also be prematurely freed since of_find_node_by_name() drops a reference
to its first argument. This particular pattern has been observed leading
to crashes after probe deferrals in other drivers.

Fix this by dropping the broken call to of_find_node_by_name() and
keeping only the second, correct lookup using of_get_child_by_name()
while taking care not to bail out if the optional node is missing.

Note that this also addresses two capture-codec node-reference leaks
(one for each of the original helper calls).

Compile tested only.

Fixes: d349caeb0510 ("ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver")
Cc: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 40ebefd625c1..679fc8bea0a3 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -272,15 +272,10 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	}
 	mt8173_rt5650_codecs[1].of_node = mt8173_rt5650_codecs[0].of_node;
 
-	if (of_find_node_by_name(platform_node, "codec-capture")) {
-		np = of_get_child_by_name(pdev->dev.of_node, "codec-capture");
-		if (!np) {
-			dev_err(&pdev->dev,
-				"%s: Can't find codec-capture DT node\n",
-				__func__);
-			return -EINVAL;
-		}
+	np = of_get_child_by_name(pdev->dev.of_node, "codec-capture");
+	if (np) {
 		ret = snd_soc_of_get_dai_name(np, &codec_capture_dai);
+		of_node_put(np);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
 				"%s codec_capture_dai name fail %d\n",
-- 
2.13.6
