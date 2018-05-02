Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeEBKAO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:00:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44157 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbeEBKAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:00:13 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH 01/10] crypto: aead - allow to allocate AEAD requests on the stack
Date: Wed,  2 May 2018 11:57:16 +0200
Message-Id: <20180502095725.31935-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502095725.31935-1-antoine.tenart@bootlin.com>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the AEAD_REQUEST_ON_STACK primitive to allow allocating AEAD
requests on the stack, as it can already be done with various other
crypto algorithms within the kernel.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/crypto/aead.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 1e26f790b03f..b67064786546 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -151,6 +151,11 @@ struct aead_alg {
 	struct crypto_alg base;
 };
 
+#define AEAD_REQUEST_ON_STACK(name, tfm) \
+	char __##name##_desc[sizeof(struct aead_request) + \
+		crypto_aead_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+	struct aead_request *name = (void *)__##name##_desc
+
 struct crypto_aead {
 	unsigned int authsize;
 	unsigned int reqsize;
-- 
2.17.0
