Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeCSIZc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:25:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48574 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbeCSIYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:24:04 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH v2 6/9] crypto: inside-secure - improve the skcipher token
Date: Mon, 19 Mar 2018 09:21:18 +0100
Message-Id: <20180319082121.32103-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319082121.32103-1-antoine.tenart@bootlin.com>
References: <20180319082121.32103-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The token used for encryption and decryption of skcipher algorithms sets
its stat field to "last packet". As it's a cipher only algorithm, there
is not hash operation and thus the "last hash" bit should be set to tell
the internal engine no hash operation should be performed.

This does not fix a bug, but improves the token definition to follow
exactly what's advised by the datasheet.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 17a7725a6f6d..bafb60505fab 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -58,7 +58,8 @@ static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx,
 
 	token[0].opcode = EIP197_TOKEN_OPCODE_DIRECTION;
 	token[0].packet_length = length;
-	token[0].stat = EIP197_TOKEN_STAT_LAST_PACKET;
+	token[0].stat = EIP197_TOKEN_STAT_LAST_PACKET |
+			EIP197_TOKEN_STAT_LAST_HASH;
 	token[0].instructions = EIP197_TOKEN_INS_LAST |
 				EIP197_TOKEN_INS_TYPE_CRYTO |
 				EIP197_TOKEN_INS_TYPE_OUTPUT;
-- 
2.14.3
