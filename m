Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1A2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD08620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffREEEvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD08620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeLJXuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:50:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54473 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:50:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so394326wmh.4;
        Mon, 10 Dec 2018 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ToFrlIyQsoGi537xPH6rttneoSB2z5FZDlOt7k9tWJU=;
        b=ffREEEvKqG+m7h0+wztQoWmIX1selTL3rAFPxk0KI5hcFb/TTt9QEG7bVhGnAogVJ3
         D0TUqfG8nzYG2eYGNQ1Q0MQyt5TzptAlkkfDOUNVOhuvXa7FVTxxqqMx8+TgJhOZqR22
         txR+8lfWXrIRRL4SrMjII3I1smRPx7z5/Sl6rrdu9cuipjOm9BV1g2etaPAwTfhVZo9l
         mDg/r9CQ7tdLH2lQx/c90gXi/U8MxcTY8rdLjk7QnA3xfbdnXCJMyPsZzLw/IKBcW/78
         9SXQUHyJ1ZLhuzWK0PsbCOBJRDksbD1fsBF9W89IFUOdpPFn5kYtc0VeMq+R/OznhZe3
         j8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ToFrlIyQsoGi537xPH6rttneoSB2z5FZDlOt7k9tWJU=;
        b=IvaFfIDpCBzhvObiF/66ukje/Xpc5tfeR5hC7peWlICgcOn1Ly/k7G1WeduHhqF32J
         M9K/o6ckuKkbXl1v3sloCjYWBfSVgXtYJhpu66X8jpPjh5/pU9WvLqAWdfSunkeUzzFK
         KM6rq9ULORo3w78aEGl6qe0kLpUaBxHVM9zoszXNzWmU+apGGAvzd8TfHyWSAgMV8keC
         //DI0/eVUAmXZ+VDxMLLgpNaKxWMZYommKjOvuMuy36fVIeLyfQhF6XOLjEwAqQWcOX8
         VROHKmGu69YXf9LmTOxgh8CCg1xn7z34A8q1P1neXyWTQYBEuk1kBm0ZeAYh1+SdyhcR
         /IKQ==
X-Gm-Message-State: AA+aEWZmRA4hoYdYRSWZew/xtMzAi3uyxWXICDLAi5+yRF1OUthBo6VZ
        DiVZqCC9/hadHF/D9oj0G8IxrVnchrU=
X-Google-Smtp-Source: AFSGD/VqRpbl/O0NjqKpZjgxO44cTSqAu4gzEDux8plj6+NoW5BN/mpekXx7umTMgFrodC96s3aqWA==
X-Received: by 2002:a1c:5f83:: with SMTP id t125-v6mr329795wmb.53.1544485800339;
        Mon, 10 Dec 2018 15:50:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u204sm986170wmu.30.2018.12.10.15.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:49:59 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] crypto: ux500 - Use proper enum in hash_set_dma_transfer
Date:   Mon, 10 Dec 2018 16:49:54 -0700
Message-Id: <20181210234954.5862-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.0

