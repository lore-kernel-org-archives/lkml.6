Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1362BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE73245D6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Kg1L2pJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE73245D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeGCMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:32:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47020 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeGCMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:32:36 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B SoC
Date:   Tue,  3 Jul 2018 14:32:06 +0200
Message-Id: <20180703123214.23090-7-paul@crapouillou.net>
In-Reply-To: <20180703123214.23090-1-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621155; bh=JZYF8f7nUzfetLcg8Rk2QXtCZlzg0IklxLdEOqwCOSs=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kg1L2pJSnv/bfsPP4kcqlleEYItgeyZ1e24NPkECAwDqFoeBzTypFi4y+EJ4FI/u3fvwOeGgtCpbd89t4w5a32lV/+Bz66AkYHE/tdl80Kg8rJpufAgxUDou2sBO+C+27jsdgngKTVhD/fSWd+/9Xe1lKwxRYp3AsSutmVfpVvU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JZ4725B has one DMA core starring six DMA channels.
As for the JZ4770, each DMA channel's clock can be enabled with
a register write, the difference here being that once started, it
is not possible to turn it off.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/dma/jz4780-dma.txt | 1 +
 drivers/dma/dma-jz4780.c                             | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
index d7ca3f925fdf..5d302b488e88 100644
--- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
+++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Should be one of:
   * ingenic,jz4780-dma
   * ingenic,jz4770-dma
+  * ingenic,jz4725b-dma
   * ingenic,jz4740-dma
 - reg: Should contain the DMA channel registers location and length, followed
   by the DMA controller registers location and length.
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ccadbe61dde7..922e4031e70e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -134,6 +134,7 @@ struct jz4780_dma_chan {
 
 enum jz_version {
 	ID_JZ4740,
+	ID_JZ4725B,
 	ID_JZ4770,
 	ID_JZ4780,
 };
@@ -204,6 +205,8 @@ static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
 {
 	if (jzdma->version == ID_JZ4770)
 		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
+	else if (jzdma->version == ID_JZ4725B)
+		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
 }
 
 static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
@@ -249,6 +252,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
 
 static const unsigned int jz4780_dma_ord_max[] = {
 	[ID_JZ4740] = 5,
+	[ID_JZ4725B] = 5,
 	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 7,
 };
@@ -804,12 +808,14 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 
 static const unsigned int jz4780_dma_nb_channels[] = {
 	[ID_JZ4740] = 6,
+	[ID_JZ4725B] = 6,
 	[ID_JZ4770] = 6,
 	[ID_JZ4780] = 32,
 };
 
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
+	{ .compatible = "ingenic,jz4725b-dma", .data = (void *)ID_JZ4725B },
 	{ .compatible = "ingenic,jz4770-dma", .data = (void *)ID_JZ4770 },
 	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
 	{},
-- 
2.18.0

