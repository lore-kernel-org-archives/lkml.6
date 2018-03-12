Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbeCLQ3J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:29:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45116 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932421AbeCLQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:29:05 -0400
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org, PC Liao <pc.liao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mt8173-rt5650: fix child-node lookup" to the asoc tree
In-Reply-To: <20180131055921.25574-1-johan@kernel.org>
Message-Id: <20180312162852.E3DDE44007C@finisterre.ee.mobilebroadband>
Date: Mon, 12 Mar 2018 16:28:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mt8173-rt5650: fix child-node lookup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 06190937b9de9803e15a122762b5bbd442eaee31 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 31 Jan 2018 16:59:21 +1100
Subject: [PATCH] ASoC: mt8173-rt5650: fix child-node lookup

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
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.2
