Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99113C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F202173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498604;
	bh=vA1cNHHmZJEohciBrbtkPSwXnbJ7PbCOKHtlv+A783o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mskQfaS3NAmBzotglxaFtOuOMrgHuP+ht80O6X9gLEMSjUSOQTmX9fP0uwjme49nC
	 BKG0vxOUJ/tjZefzQLmdPWUDiwX5EchiCC0tY4yX3sdrQuvZe4q+YcSqN1SWrnxITU
	 25c63sO7j4afQ3BqbXDfx52z1yvmqD7TZ/cO8yt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbfBRODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389652AbfBRODR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4ED2070D;
        Mon, 18 Feb 2019 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498597;
        bh=vA1cNHHmZJEohciBrbtkPSwXnbJ7PbCOKHtlv+A783o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD8CMga2s0d+KD2hg2U97wc+uz66cMlgCPkmx6qbmjslC5vCQolF2G9+gWfJ7mrXE
         iAftIIe5TwVbyjbt6zD8FEDZ3A4xPlVngQOeeXcLeup9lgVk5TqupaOt07g/i0RPem
         qx4s4/FRVkRQy4UJi62EgXVnFFT4LdH/+6lqotLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 060/143] crypto: ux500 - Use proper enum in hash_set_dma_transfer
Date:   Mon, 18 Feb 2019 14:43:08 +0100
Message-Id: <20190218133531.303082456@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5ac93f808338f4dd465402e91869702eb87db241 ]

Clang warns when one enumerated type is implicitly converted to another:

drivers/crypto/ux500/hash/hash_core.c:169:4: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                        direction, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
                        ^~~~~~~~~
1 warning generated.

dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
We know that the only direction supported by this function is
DMA_TO_DEVICE because of the check at the top of this function so we can
just use the equivalent value from dma_transfer_direction.

DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ux500/hash/hash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index cd4398498495..bca6b701c067 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -181,7 +181,7 @@ static int hash_set_dma_transfer(struct hash_ctx *ctx, struct scatterlist *sg,
 		__func__);
 	desc = dmaengine_prep_slave_sg(channel,
 			ctx->device->dma.sg, ctx->device->dma.sg_len,
-			direction, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+			DMA_MEM_TO_DEV, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dev_err(ctx->device->dev,
 			"%s: dmaengine_prep_slave_sg() failed!\n", __func__);
-- 
2.19.1



