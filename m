Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D6CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EA220661
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EA220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeHXTkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:40:37 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:40527 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeHXTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:40:35 -0400
Received: from [109.168.11.45] (port=57958 helo=pc-ceresoli.dev.aim)
        by srv-hp10.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ftEaJ-00E38u-CA; Fri, 24 Aug 2018 18:05:15 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     alsa-devel@alsa-project.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] axi-i2s: set period size register
Date:   Fri, 24 Aug 2018 18:04:30 +0200
Message-Id: <20180824160430.10222-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180824160430.10222-1-luca@lucaceresoli.net>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value of the PERIOD_LEN register is 0 and results in
axi-i2s keeping TLAST always asserted in its AXI Stream output.

When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
DMA generating an interrupt flood and ALSA produce a corrupted
recording. This is because AXI-DMA raises an interrupt whenever TLAST
is active.

Fix by setting the PERIOD_LEN register as soon as the period is
known. This way TLAST is emitted once per period, and the DMA raises
interrupts correctly.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 sound/soc/adi/axi-i2s.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index 4c23381727a1..af581a313a40 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -24,6 +24,7 @@
 #define AXI_I2S_REG_CTRL	0x04
 #define AXI_I2S_REG_CLK_CTRL	0x08
 #define AXI_I2S_REG_STATUS	0x10
+#define AXI_I2S_REG_PERIOD_LEN	0x18
 
 #define AXI_I2S_REG_RX_FIFO	0x28
 #define AXI_I2S_REG_TX_FIFO	0x2C
@@ -101,6 +102,17 @@ static int axi_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int axi_i2s_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
+
+	/* adi_i2s counts 32-bit words, thus divide bytes by 4 */
+	return regmap_write(i2s->regmap, AXI_I2S_REG_PERIOD_LEN,
+			    (period_bytes / 4) - 1);
+}
+
 static int axi_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
@@ -147,6 +159,7 @@ static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
 	.shutdown = axi_i2s_shutdown,
 	.trigger = axi_i2s_trigger,
 	.hw_params = axi_i2s_hw_params,
+	.prepare = axi_i2s_prepare,
 };
 
 static struct snd_soc_dai_driver axi_i2s_dai = {
@@ -175,7 +188,7 @@ static const struct regmap_config axi_i2s_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = AXI_I2S_REG_STATUS,
+	.max_register = AXI_I2S_REG_PERIOD_LEN,
 };
 
 static int axi_i2s_probe(struct platform_device *pdev)
-- 
2.17.1

