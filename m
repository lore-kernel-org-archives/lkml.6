Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A868EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F95D208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F95D208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbeHWL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:56:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeHWL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:56:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D45F8B1;
        Thu, 23 Aug 2018 08:28:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 112/217] drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 modes
Date:   Thu, 23 Aug 2018 09:53:45 +0200
Message-Id: <20180823075510.515726845@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit dd209ef809080ced903e7747ee3ef640c923a1d2 ]

Fix following issues related to planar YUV pixel format configuration:
- NV16/61 modes were incorrectly programmed as NV12/21,
- YVU420 was programmed as YUV420 on source,
- YVU420 and YUV422 were programmed as YUV420 on output.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c |   29 ++++++++++++++++++++---------
 drivers/gpu/drm/exynos/regs-gsc.h       |    1 +
 2 files changed, 21 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -532,21 +532,25 @@ static int gsc_src_set_fmt(struct device
 			GSC_IN_CHROMA_ORDER_CRCB);
 		break;
 	case DRM_FORMAT_NV21:
+		cfg |= (GSC_IN_CHROMA_ORDER_CRCB | GSC_IN_YUV420_2P);
+		break;
 	case DRM_FORMAT_NV61:
-		cfg |= (GSC_IN_CHROMA_ORDER_CRCB |
-			GSC_IN_YUV420_2P);
+		cfg |= (GSC_IN_CHROMA_ORDER_CRCB | GSC_IN_YUV422_2P);
 		break;
 	case DRM_FORMAT_YUV422:
 		cfg |= GSC_IN_YUV422_3P;
 		break;
 	case DRM_FORMAT_YUV420:
+		cfg |= (GSC_IN_CHROMA_ORDER_CBCR | GSC_IN_YUV420_3P);
+		break;
 	case DRM_FORMAT_YVU420:
-		cfg |= GSC_IN_YUV420_3P;
+		cfg |= (GSC_IN_CHROMA_ORDER_CRCB | GSC_IN_YUV420_3P);
 		break;
 	case DRM_FORMAT_NV12:
+		cfg |= (GSC_IN_CHROMA_ORDER_CBCR | GSC_IN_YUV420_2P);
+		break;
 	case DRM_FORMAT_NV16:
-		cfg |= (GSC_IN_CHROMA_ORDER_CBCR |
-			GSC_IN_YUV420_2P);
+		cfg |= (GSC_IN_CHROMA_ORDER_CBCR | GSC_IN_YUV422_2P);
 		break;
 	default:
 		dev_err(ippdrv->dev, "invalid target yuv order 0x%x.\n", fmt);
@@ -806,18 +810,25 @@ static int gsc_dst_set_fmt(struct device
 			GSC_OUT_CHROMA_ORDER_CRCB);
 		break;
 	case DRM_FORMAT_NV21:
-	case DRM_FORMAT_NV61:
 		cfg |= (GSC_OUT_CHROMA_ORDER_CRCB | GSC_OUT_YUV420_2P);
 		break;
+	case DRM_FORMAT_NV61:
+		cfg |= (GSC_OUT_CHROMA_ORDER_CRCB | GSC_OUT_YUV422_2P);
+		break;
 	case DRM_FORMAT_YUV422:
+		cfg |= GSC_OUT_YUV422_3P;
+		break;
 	case DRM_FORMAT_YUV420:
+		cfg |= (GSC_OUT_CHROMA_ORDER_CBCR | GSC_OUT_YUV420_3P);
+		break;
 	case DRM_FORMAT_YVU420:
-		cfg |= GSC_OUT_YUV420_3P;
+		cfg |= (GSC_OUT_CHROMA_ORDER_CRCB | GSC_OUT_YUV420_3P);
 		break;
 	case DRM_FORMAT_NV12:
+		cfg |= (GSC_OUT_CHROMA_ORDER_CBCR | GSC_OUT_YUV420_2P);
+		break;
 	case DRM_FORMAT_NV16:
-		cfg |= (GSC_OUT_CHROMA_ORDER_CBCR |
-			GSC_OUT_YUV420_2P);
+		cfg |= (GSC_OUT_CHROMA_ORDER_CBCR | GSC_OUT_YUV422_2P);
 		break;
 	default:
 		dev_err(ippdrv->dev, "invalid target yuv order 0x%x.\n", fmt);
--- a/drivers/gpu/drm/exynos/regs-gsc.h
+++ b/drivers/gpu/drm/exynos/regs-gsc.h
@@ -138,6 +138,7 @@
 #define GSC_OUT_YUV420_3P		(3 << 4)
 #define GSC_OUT_YUV422_1P		(4 << 4)
 #define GSC_OUT_YUV422_2P		(5 << 4)
+#define GSC_OUT_YUV422_3P		(6 << 4)
 #define GSC_OUT_YUV444			(7 << 4)
 #define GSC_OUT_TILE_TYPE_MASK		(1 << 2)
 #define GSC_OUT_TILE_C_16x8		(0 << 2)


