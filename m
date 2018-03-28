Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeC1OGC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:06:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeC1OGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:06:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Ganesh Goudar <ganeshgr@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Yeshaswi M R Gowda <yeshaswi@chelsio.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: chelsio: move chcr_ahash_continue declation out of header
Date: Wed, 28 Mar 2018 16:05:23 +0200
Message-Id: <20180328140539.2694734-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Fpnox6EB5FuqJLFZd+py/0vl5i+scxU51BHpCgFKemp82zrE04J
 kIYSc+uRNIPUB47OlmofYwBkFfE8DtYPTGiUVSrp071bK7159yWDJrOnRzwQjUldXceGky/
 0hxXSqwSOjIJkzvexLHtmqCpk8HRDv04oZ/yQs7aWKWSLrKGCzXnZIxztNN4FwsNthhhdkn
 4X9kYlWqZB9gPNc5eU+jA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lA1xHhAq1PY=:AR/05/LrQRG9dCzr9aKjCb
 24z8XNg0KMpByiugP5agQqFcoWrKDVkCLBoL8qGdyYv/mmyHkKyr9flydJ53nbcO8VlCvMkkJ
 jJV42YkMKz/xDZBM1ZrEbM0eK+2v+XyhzMSd1TICbzNVhJePYB48PrVTrBW7bhcC+LosCoJWd
 hRdTc11RapYEgQTbuXQyAxOlumQDstfY22XR57oh2Twi7UrkbmFm2YVhL975hGpF5g+RsjxKI
 exTO1a3Lqg0rGpiGeAMWYbWoUCL9u7z7MYvtannjxOszIXKU/Z40wCdmFuydyya1K5ZJAH0Jg
 2mzvz8KWaQ004VKx7iUAnJMx7pFuiaNu/M8AqpCHKQwUswSAh66SJ14jYUCUUEb0EFJhk6pZQ
 PYn7J3AJw6PANK6Ay5ztIWrevy246uvfgaHQ4UHiES5CVvet98J1eYNIWkSM9jF/WBA+JZnoI
 u9owuiZ2dxa6qUGbV4TJux0yrDT+4zqJE/w9kpVgSyarjrBecH76QPIKMAuh9sTmJU/mtl9Mq
 klWamtmNXK0vid68mbs/j5tt9IQSYZ0wWa3Bz2gcUfkHF/g3HVSOmUzPd36qiYH+pvcMdwDRM
 ooGDXT+v7xa4PZ4XDi1MFa9XNZGXkWUEAJkNMGnZx1h4TSkdBvu919taQgNqGCG9iamHIQeZS
 nWtwaIjBblPXqJSp5T52V0QkY7WKJwdWpmKSZDLu5zKNTsLqdomQmAhSM/ptingWqnrXAIblo
 K5KA6P9oCP6GBQxG5HvrYSaZSt4OQYQrVCfv+g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static function declarations don't belong in a header file, as shown
by this compiler warning:

In file included from /git/arm-soc/drivers/crypto/chelsio/chcr_ipsec.c:66:
drivers/crypto/chelsio/chcr_crypto.h:343:12: error: 'chcr_ahash_continue' declared 'static' but never defined [-Werror=unused-function]

This moves the declaration into the file that actually needs it.

Fixes: 5110e65536f3 ("crypto: chelsio -Split Hash requests for large scatter gather list")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/chelsio/chcr_algo.c   | 1 +
 drivers/crypto/chelsio/chcr_crypto.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 4617c7acf4da..ebc96f2fae01 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -95,6 +95,7 @@ static u32 round_constant[11] = {
 
 static int chcr_handle_cipher_resp(struct ablkcipher_request *req,
 				   unsigned char *input, int err);
+static int chcr_ahash_continue(struct ahash_request *req);
 
 static inline  struct chcr_aead_ctx *AEAD_CTX(struct chcr_context *ctx)
 {
diff --git a/drivers/crypto/chelsio/chcr_crypto.h b/drivers/crypto/chelsio/chcr_crypto.h
index 71025ea9c3db..c8e8972af283 100644
--- a/drivers/crypto/chelsio/chcr_crypto.h
+++ b/drivers/crypto/chelsio/chcr_crypto.h
@@ -340,5 +340,4 @@ void chcr_add_hash_src_ent(struct ahash_request *req, struct ulptx_sgl *ulptx,
 			   struct hash_wr_param *param);
 int chcr_hash_dma_map(struct device *dev, struct ahash_request *req);
 void chcr_hash_dma_unmap(struct device *dev, struct ahash_request *req);
-static int chcr_ahash_continue(struct ahash_request *req);
 #endif /* __CHCR_CRYPTO_H__ */
-- 
2.9.0
