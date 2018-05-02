Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeEBKAY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:00:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44177 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbeEBKAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:00:15 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH 05/10] crypto: inside-secure - make the key and context size computation dynamic
Date: Wed,  2 May 2018 11:57:20 +0200
Message-Id: <20180502095725.31935-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502095725.31935-1-antoine.tenart@bootlin.com>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches makes the key and context size computation dynamic when
using memzero_explicit() on these two arrays. This is safer, cleaner and
will help future modifications of the driver when these two parameters
sizes will changes (the context size will be bigger when using AEAD
algorithms).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 7c801aace04b..a658f8f14002 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -554,13 +554,13 @@ static int safexcel_cipher_cra_exit(struct crypto_tfm *tfm)
 {
 	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	memzero_explicit(ctx->key, 8 * sizeof(u32));
+	memzero_explicit(ctx->key, sizeof(ctx->key));
 
 	/* context not allocated, skip invalidation */
 	if (!ctx->base.ctxr)
 		return -ENOMEM;
 
-	memzero_explicit(ctx->base.ctxr->data, 8 * sizeof(u32));
+	memzero_explicit(ctx->base.ctxr->data, sizeof(ctx->base.ctxr->data));
 	return 0;
 }
 
-- 
2.17.0
