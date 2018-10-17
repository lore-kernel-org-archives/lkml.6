Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC63C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF872150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF872150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJQN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:57:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58482 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJQN56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:57:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 55E1C1A01C3;
        Wed, 17 Oct 2018 08:03:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE7481A01E2;
        Wed, 17 Oct 2018 08:03:49 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C453E402F0;
        Wed, 17 Oct 2018 14:03:41 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Peng Ma <peng.ma@nxp.com>,
        Wen He <wen.he_1@nxp.com>
Subject: [v9 2/7] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT implement for ARM platform
Date:   Wed, 17 Oct 2018 13:59:52 +0800
Message-Id: <20181017055957.542-2-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181017055957.542-1-peng.ma@nxp.com>
References: <20181017055957.542-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the macro FSL_DMA_IN/OUT implement for ARM platform.

Signed-off-by: Wen He <wen.he_1@nxp.com>
Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
change in v9:
	- rewrite function fsl_ioread64 and fsl_ioread64be to make a better read

 drivers/dma/fsldma.h |   59 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 982845b..f635bc1 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -196,39 +196,60 @@ struct fsldma_chan {
 #define to_fsl_desc(lh) container_of(lh, struct fsl_desc_sw, node)
 #define tx_to_fsl_desc(tx) container_of(tx, struct fsl_desc_sw, async_tx)
 
+#ifdef	CONFIG_PPC
+#define fsl_ioread32(p)		in_le32(p)
+#define fsl_ioread32be(p)	in_be32(p)
+#define fsl_iowrite32(v, p)	out_le32(p, v)
+#define fsl_iowrite32be(v, p)	out_be32(p, v)
+
 #ifndef __powerpc64__
-static u64 in_be64(const u64 __iomem *addr)
+static u64 fsl_ioread64(const u64 __iomem *addr)
 {
-	return ((u64)in_be32((u32 __iomem *)addr) << 32) |
-		(in_be32((u32 __iomem *)addr + 1));
+	u32 fsl_addr = lower_32_bits(addr);
+
+	return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
 }
 
-static void out_be64(u64 __iomem *addr, u64 val)
+static void fsl_iowrite64(u64 val, u64 __iomem *addr)
 {
-	out_be32((u32 __iomem *)addr, val >> 32);
-	out_be32((u32 __iomem *)addr + 1, (u32)val);
+	out_le32((u32 __iomem *)addr + 1, val >> 32);
+	out_le32((u32 __iomem *)addr, (u32)val);
 }
 
-/* There is no asm instructions for 64 bits reverse loads and stores */
-static u64 in_le64(const u64 __iomem *addr)
+static u64 fsl_ioread64be(const u64 __iomem *addr)
 {
-	return ((u64)in_le32((u32 __iomem *)addr + 1) << 32) |
-		(in_le32((u32 __iomem *)addr));
+	u32 fsl_addr = lower_32_bits(addr);
+
+	return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
 }
 
-static void out_le64(u64 __iomem *addr, u64 val)
+static void fsl_iowrite64be(u64 val, u64 __iomem *addr)
 {
-	out_le32((u32 __iomem *)addr + 1, val >> 32);
-	out_le32((u32 __iomem *)addr, (u32)val);
+	out_be32((u32 __iomem *)addr, val >> 32);
+	out_be32((u32 __iomem *)addr + 1, (u32)val);
 }
 #endif
+#endif
 
-#define FSL_DMA_IN(fsl_chan, addr, width)				\
-		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-			in_be##width(addr) : in_le##width(addr))
-#define FSL_DMA_OUT(fsl_chan, addr, val, width)			\
-		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-			out_be##width(addr, val) : out_le##width(addr, val))
+#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
+#define fsl_ioread32(p)		ioread32(p)
+#define fsl_ioread32be(p)	ioread32be(p)
+#define fsl_iowrite32(v, p)	iowrite32(v, p)
+#define fsl_iowrite32be(v, p)	iowrite32be(v, p)
+#define fsl_ioread64(p)		ioread64(p)
+#define fsl_ioread64be(p)	ioread64be(p)
+#define fsl_iowrite64(v, p)	iowrite64(v, p)
+#define fsl_iowrite64be(v, p)	iowrite64be(v, p)
+#endif
+
+#define FSL_DMA_IN(fsl_dma, addr, width)			\
+		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
+			fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
+
+#define FSL_DMA_OUT(fsl_dma, addr, val, width)			\
+		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
+			fsl_iowrite##width##be(val, addr) : fsl_iowrite	\
+		##width(val, addr))
 
 #define DMA_TO_CPU(fsl_chan, d, width)					\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
-- 
1.7.1

