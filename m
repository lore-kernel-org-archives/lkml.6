Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E0CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A3B20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896537;
	bh=yk6ZhHemi6IrxFk6K+iWQsMHbxCSkjBjO7xZ0KtIRGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=crf/clI83U4D3R6wRRTsZ7QbgoQJVuabMoVhT0ZFdNpgANyq7mIf67I01y+VvZNI5
	 oGCpvUCR4nRiMFxPYL4tEPqkwkEcTycjoPmzNnzXQ+UXoYYY9L5DTx+C78kz8EcHXR
	 loSQTjgmh0jcKx23hWAZPI3lt03EJeikqOoo4itQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbfBKOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733053AbfBKOsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:48:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4949720844;
        Mon, 11 Feb 2019 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896533;
        bh=yk6ZhHemi6IrxFk6K+iWQsMHbxCSkjBjO7xZ0KtIRGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eK3KhfFEcg7HVjbq5U4Fu3Kv+tmt7JwRoyEIU1V6FBIg+i2CDXDswZdqq8aE9X72S
         Vc16XyDJkiVEEQLphtYiDr8R7ju9WfB98v8K4K1Em6BHKrXKQN2oQpskwoj29CEP69
         CBwEGUkSKkKnQu9laMCRjSsgLrOi+zHhcspqe5uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 215/313] crypto: ux500 - Use proper enum in hash_set_dma_transfer
Date:   Mon, 11 Feb 2019 15:18:15 +0100
Message-Id: <20190211141907.506771947@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 633321a8dd03..a0bb8a6eec3f 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -166,7 +166,7 @@ static int hash_set_dma_transfer(struct hash_ctx *ctx, struct scatterlist *sg,
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



