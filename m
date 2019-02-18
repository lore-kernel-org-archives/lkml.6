Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692F3217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499003;
	bh=iNJUvk4IF9da/MWEvGwKGP19R8uCDZEjS64I+8SNLUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LcHaqFUyDuiEiTFUUoNZwh5iTmPZr2zOEKa3m1/RF0Pga+zQAmidS5iU3Ecwg78c9
	 WTX7M7Xnw31E49fBXS+MFcmka0rHmY9nIs68SdesIudLceqWGLdz+a7yM9th+/FWs4
	 hW34ApBdOtW7mI1x5JOin3bk8keMBDVIWdNZU3K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391363AbfBROKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390784AbfBROJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:09:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6512A217D7;
        Mon, 18 Feb 2019 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498996;
        bh=iNJUvk4IF9da/MWEvGwKGP19R8uCDZEjS64I+8SNLUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsLIKMSm4yaWthANUVX/GyvyNE8OX60BhvdXgaPZW27M9pxG4Q38KOcZuYZoLdc3g
         4VO4EZLWDEJiHF+zQ2xe/Xy7Ernwtcn0+9Z6CpFvughZd2HCZnowrXfaXfZTTtRdbv
         1cPs2t54GFKQG93KeBScJt8/AMY8Sk1hZbyx3HfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 043/108] crypto: ux500 - Use proper enum in cryp_set_dma_transfer
Date:   Mon, 18 Feb 2019 14:43:39 +0100
Message-Id: <20190218133521.527628803@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9d880c5945c748d8edcac30965f3349a602158c4 ]

Clang warns when one enumerated type is implicitly converted to another:

drivers/crypto/ux500/cryp/cryp_core.c:559:5: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                                direction, DMA_CTRL_ACK);
                                ^~~~~~~~~
drivers/crypto/ux500/cryp/cryp_core.c:583:5: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                                direction,
                                ^~~~~~~~~
2 warnings generated.

dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
Because we know the value of the dma_data_direction enum from the
switch statement, we can just use the proper value from
dma_transfer_direction so there is no more conversion.

DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ux500/cryp/cryp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index e4cea7c45142..3897bfe41c8b 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -555,7 +555,7 @@ static int cryp_set_dma_transfer(struct cryp_ctx *ctx,
 		desc = dmaengine_prep_slave_sg(channel,
 				ctx->device->dma.sg_src,
 				ctx->device->dma.sg_src_len,
-				direction, DMA_CTRL_ACK);
+				DMA_MEM_TO_DEV, DMA_CTRL_ACK);
 		break;
 
 	case DMA_FROM_DEVICE:
@@ -579,7 +579,7 @@ static int cryp_set_dma_transfer(struct cryp_ctx *ctx,
 		desc = dmaengine_prep_slave_sg(channel,
 				ctx->device->dma.sg_dst,
 				ctx->device->dma.sg_dst_len,
-				direction,
+				DMA_DEV_TO_MEM,
 				DMA_CTRL_ACK |
 				DMA_PREP_INTERRUPT);
 
-- 
2.19.1



