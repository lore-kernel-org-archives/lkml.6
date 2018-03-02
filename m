Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvli0JX0fNuZBvI6goitheUgezyKlu1El/Ia7dyoUV6ogcTxbLx5NZGHc8VkOU3ca8kvunt
ARC-Seal: i=1; a=rsa-sha256; t=1519981307; cv=none;
        d=google.com; s=arc-20160816;
        b=qNNCu9+N0xDHi3bz4fZf3QM6dEAkqJfHULKvkG5C3MyJ2+wKu4z3HFYHIejCleO7Z6
         4Hv2tx1KrKR3qtQyQDP/kcYbN93+HC3SLh7Mxi99PtTLIaOHUG0ayNhQ0zvht8Mqdxrz
         UgpRpYM+v1HqO8WOF+iW4IAaGoQhq6iWr3bWxWi5JrZ/Fnh+RZANo1T2drSqti6efszF
         9pdLOpeTPnaiUY5rgkIyPCOYj7NEK+VizsX4ZBiHl4uS56FxFU4cx3/bt1uxt2MEdLg6
         mF7dLJTXgfcyJH4+fz4FdvFU8qN061GQk1mWl+GPew9F4Q1DxAbCFa1+fYICJM0VHa/r
         AyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gKYpqG7rYOP8jNTfcPNi72VCY/4Wf7VnRogU3uYi4lM=;
        b=qSd12DuV7XUA6V/2YYf+Vem3YRrr/Lx5Jc/CepSesiJX22kmzX/Dq2n+HZjshYta+U
         xpbaW9Ilup95Wb5hbJjKf4ol2xvi9NFOSlQ2jugFMdNkuKCb2tsAbbPmWAbGSireE6EA
         dAyPfugtHNppPTdMve0bMg1JB3n7QdvkzabGEBLb6d89cVnkvL0T8fhNSWAgivm6h6OP
         hE8TLcHSBsevB1VKI0GdpmDdae6f3/rh/yrvXO/5lAlPgDE663Z/ivWkZhFYDGrBkIB1
         rBjvd/e/5BV7bacAmD/AwPzrX1qvlOIyT5yXvYBwI+YNmTIAo2XQw55xRxVzcgyLEHat
         XtDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ofer Heifetz <oferh@marvell.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 052/115] crypto: inside-secure - per request invalidation
Date: Fri,  2 Mar 2018 09:50:55 +0100
Message-Id: <20180302084505.984348008@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815919800408983?=
X-GMAIL-MSGID: =?utf-8?q?1593815919800408983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ofer Heifetz <oferh@marvell.com>


[ Upstream commit 1eb7b40386c97f6c4d1c62931bf306f4535a4bd6 ]

When an invalidation request is needed we currently override the context
.send and .handle_result helpers. This is wrong as under high load other
requests can already be queued and overriding the context helpers will
make them execute the wrong .send and .handle_result functions.

This commit fixes this by adding a needs_inv flag in the request to
choose the action to perform when sending requests or handling their
results. This flag will be set when needed (i.e. when the context flag
will be set).

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Ofer Heifetz <oferh@marvell.com>
[Antoine: commit message, and removed non related changes from the
original commit]
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_cipher.c |   71 ++++++++++++++++++++-----
 drivers/crypto/inside-secure/safexcel_hash.c   |   67 ++++++++++++++++++-----
 2 files changed, 111 insertions(+), 27 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -14,6 +14,7 @@
 
 #include <crypto/aes.h>
 #include <crypto/skcipher.h>
+#include <crypto/internal/skcipher.h>
 
 #include "safexcel.h"
 
@@ -33,6 +34,10 @@ struct safexcel_cipher_ctx {
 	unsigned int key_len;
 };
 
+struct safexcel_cipher_req {
+	bool needs_inv;
+};
+
 static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx,
 				  struct crypto_async_request *async,
 				  struct safexcel_command_desc *cdesc,
@@ -126,9 +131,9 @@ static int safexcel_context_control(stru
 	return 0;
 }
 
-static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int ring,
-				  struct crypto_async_request *async,
-				  bool *should_complete, int *ret)
+static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int ring,
+				      struct crypto_async_request *async,
+				      bool *should_complete, int *ret)
 {
 	struct skcipher_request *req = skcipher_request_cast(async);
 	struct safexcel_result_desc *rdesc;
@@ -265,7 +270,6 @@ static int safexcel_aes_send(struct cryp
 	spin_unlock_bh(&priv->ring[ring].egress_lock);
 
 	request->req = &req->base;
-	ctx->base.handle_result = safexcel_handle_result;
 
 	*commands = n_cdesc;
 	*results = n_rdesc;
@@ -341,8 +345,6 @@ static int safexcel_handle_inv_result(st
 
 	ring = safexcel_select_ring(priv);
 	ctx->base.ring = ring;
-	ctx->base.needs_inv = false;
-	ctx->base.send = safexcel_aes_send;
 
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	enq_ret = crypto_enqueue_request(&priv->ring[ring].queue, async);
@@ -359,6 +361,26 @@ static int safexcel_handle_inv_result(st
 	return ndesc;
 }
 
+static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int ring,
+				  struct crypto_async_request *async,
+				  bool *should_complete, int *ret)
+{
+	struct skcipher_request *req = skcipher_request_cast(async);
+	struct safexcel_cipher_req *sreq = skcipher_request_ctx(req);
+	int err;
+
+	if (sreq->needs_inv) {
+		sreq->needs_inv = false;
+		err = safexcel_handle_inv_result(priv, ring, async,
+						 should_complete, ret);
+	} else {
+		err = safexcel_handle_req_result(priv, ring, async,
+						 should_complete, ret);
+	}
+
+	return err;
+}
+
 static int safexcel_cipher_send_inv(struct crypto_async_request *async,
 				    int ring, struct safexcel_request *request,
 				    int *commands, int *results)
@@ -368,8 +390,6 @@ static int safexcel_cipher_send_inv(stru
 	struct safexcel_crypto_priv *priv = ctx->priv;
 	int ret;
 
-	ctx->base.handle_result = safexcel_handle_inv_result;
-
 	ret = safexcel_invalidate_cache(async, &ctx->base, priv,
 					ctx->base.ctxr_dma, ring, request);
 	if (unlikely(ret))
@@ -381,11 +401,29 @@ static int safexcel_cipher_send_inv(stru
 	return 0;
 }
 
+static int safexcel_send(struct crypto_async_request *async,
+			 int ring, struct safexcel_request *request,
+			 int *commands, int *results)
+{
+	struct skcipher_request *req = skcipher_request_cast(async);
+	struct safexcel_cipher_req *sreq = skcipher_request_ctx(req);
+	int ret;
+
+	if (sreq->needs_inv)
+		ret = safexcel_cipher_send_inv(async, ring, request,
+					       commands, results);
+	else
+		ret = safexcel_aes_send(async, ring, request,
+					commands, results);
+	return ret;
+}
+
 static int safexcel_cipher_exit_inv(struct crypto_tfm *tfm)
 {
 	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv = ctx->priv;
 	struct skcipher_request req;
+	struct safexcel_cipher_req *sreq = skcipher_request_ctx(&req);
 	struct safexcel_inv_result result = {};
 	int ring = ctx->base.ring;
 
@@ -399,7 +437,7 @@ static int safexcel_cipher_exit_inv(stru
 	skcipher_request_set_tfm(&req, __crypto_skcipher_cast(tfm));
 	ctx = crypto_tfm_ctx(req.base.tfm);
 	ctx->base.exit_inv = true;
-	ctx->base.send = safexcel_cipher_send_inv;
+	sreq->needs_inv = true;
 
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	crypto_enqueue_request(&priv->ring[ring].queue, &req.base);
@@ -424,19 +462,21 @@ static int safexcel_aes(struct skcipher_
 			enum safexcel_cipher_direction dir, u32 mode)
 {
 	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(req->base.tfm);
+	struct safexcel_cipher_req *sreq = skcipher_request_ctx(req);
 	struct safexcel_crypto_priv *priv = ctx->priv;
 	int ret, ring;
 
+	sreq->needs_inv = false;
 	ctx->direction = dir;
 	ctx->mode = mode;
 
 	if (ctx->base.ctxr) {
-		if (ctx->base.needs_inv)
-			ctx->base.send = safexcel_cipher_send_inv;
+		if (ctx->base.needs_inv) {
+			sreq->needs_inv = true;
+			ctx->base.needs_inv = false;
+		}
 	} else {
 		ctx->base.ring = safexcel_select_ring(priv);
-		ctx->base.send = safexcel_aes_send;
-
 		ctx->base.ctxr = dma_pool_zalloc(priv->context_pool,
 						 EIP197_GFP_FLAGS(req->base),
 						 &ctx->base.ctxr_dma);
@@ -476,6 +516,11 @@ static int safexcel_skcipher_cra_init(st
 			     alg.skcipher.base);
 
 	ctx->priv = tmpl->priv;
+	ctx->base.send = safexcel_send;
+	ctx->base.handle_result = safexcel_handle_result;
+
+	crypto_skcipher_set_reqsize(__crypto_skcipher_cast(tfm),
+				    sizeof(struct safexcel_cipher_req));
 
 	return 0;
 }
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -32,6 +32,7 @@ struct safexcel_ahash_req {
 	bool last_req;
 	bool finish;
 	bool hmac;
+	bool needs_inv;
 
 	int nents;
 
@@ -121,9 +122,9 @@ static void safexcel_context_control(str
 	}
 }
 
-static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int ring,
-				  struct crypto_async_request *async,
-				  bool *should_complete, int *ret)
+static int safexcel_handle_req_result(struct safexcel_crypto_priv *priv, int ring,
+				      struct crypto_async_request *async,
+				      bool *should_complete, int *ret)
 {
 	struct safexcel_result_desc *rdesc;
 	struct ahash_request *areq = ahash_request_cast(async);
@@ -169,9 +170,9 @@ static int safexcel_handle_result(struct
 	return 1;
 }
 
-static int safexcel_ahash_send(struct crypto_async_request *async, int ring,
-			       struct safexcel_request *request, int *commands,
-			       int *results)
+static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
+				   struct safexcel_request *request,
+				   int *commands, int *results)
 {
 	struct ahash_request *areq = ahash_request_cast(async);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
@@ -310,7 +311,6 @@ send_command:
 
 	req->processed += len;
 	request->req = &areq->base;
-	ctx->base.handle_result = safexcel_handle_result;
 
 	*commands = n_cdesc;
 	*results = 1;
@@ -394,8 +394,6 @@ static int safexcel_handle_inv_result(st
 
 	ring = safexcel_select_ring(priv);
 	ctx->base.ring = ring;
-	ctx->base.needs_inv = false;
-	ctx->base.send = safexcel_ahash_send;
 
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	enq_ret = crypto_enqueue_request(&priv->ring[ring].queue, async);
@@ -412,6 +410,26 @@ static int safexcel_handle_inv_result(st
 	return 1;
 }
 
+static int safexcel_handle_result(struct safexcel_crypto_priv *priv, int ring,
+				  struct crypto_async_request *async,
+				  bool *should_complete, int *ret)
+{
+	struct ahash_request *areq = ahash_request_cast(async);
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	int err;
+
+	if (req->needs_inv) {
+		req->needs_inv = false;
+		err = safexcel_handle_inv_result(priv, ring, async,
+						 should_complete, ret);
+	} else {
+		err = safexcel_handle_req_result(priv, ring, async,
+						 should_complete, ret);
+	}
+
+	return err;
+}
+
 static int safexcel_ahash_send_inv(struct crypto_async_request *async,
 				   int ring, struct safexcel_request *request,
 				   int *commands, int *results)
@@ -420,7 +438,6 @@ static int safexcel_ahash_send_inv(struc
 	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	int ret;
 
-	ctx->base.handle_result = safexcel_handle_inv_result;
 	ret = safexcel_invalidate_cache(async, &ctx->base, ctx->priv,
 					ctx->base.ctxr_dma, ring, request);
 	if (unlikely(ret))
@@ -432,11 +449,29 @@ static int safexcel_ahash_send_inv(struc
 	return 0;
 }
 
+static int safexcel_ahash_send(struct crypto_async_request *async,
+			       int ring, struct safexcel_request *request,
+			       int *commands, int *results)
+{
+	struct ahash_request *areq = ahash_request_cast(async);
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
+	int ret;
+
+	if (req->needs_inv)
+		ret = safexcel_ahash_send_inv(async, ring, request,
+					      commands, results);
+	else
+		ret = safexcel_ahash_send_req(async, ring, request,
+					      commands, results);
+	return ret;
+}
+
 static int safexcel_ahash_exit_inv(struct crypto_tfm *tfm)
 {
 	struct safexcel_ahash_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct safexcel_crypto_priv *priv = ctx->priv;
 	struct ahash_request req;
+	struct safexcel_ahash_req *rctx = ahash_request_ctx(&req);
 	struct safexcel_inv_result result = {};
 	int ring = ctx->base.ring;
 
@@ -450,7 +485,7 @@ static int safexcel_ahash_exit_inv(struc
 	ahash_request_set_tfm(&req, __crypto_ahash_cast(tfm));
 	ctx = crypto_tfm_ctx(req.base.tfm);
 	ctx->base.exit_inv = true;
-	ctx->base.send = safexcel_ahash_send_inv;
+	rctx->needs_inv = true;
 
 	spin_lock_bh(&priv->ring[ring].queue_lock);
 	crypto_enqueue_request(&priv->ring[ring].queue, &req.base);
@@ -501,14 +536,16 @@ static int safexcel_ahash_enqueue(struct
 	struct safexcel_crypto_priv *priv = ctx->priv;
 	int ret, ring;
 
-	ctx->base.send = safexcel_ahash_send;
+	req->needs_inv = false;
 
 	if (req->processed && ctx->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED)
 		ctx->base.needs_inv = safexcel_ahash_needs_inv_get(areq);
 
 	if (ctx->base.ctxr) {
-		if (ctx->base.needs_inv)
-			ctx->base.send = safexcel_ahash_send_inv;
+		if (ctx->base.needs_inv) {
+			ctx->base.needs_inv = false;
+			req->needs_inv = true;
+		}
 	} else {
 		ctx->base.ring = safexcel_select_ring(priv);
 		ctx->base.ctxr = dma_pool_zalloc(priv->context_pool,
@@ -642,6 +679,8 @@ static int safexcel_ahash_cra_init(struc
 			     struct safexcel_alg_template, alg.ahash);
 
 	ctx->priv = tmpl->priv;
+	ctx->base.send = safexcel_ahash_send;
+	ctx->base.handle_result = safexcel_handle_result;
 
 	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
 				 sizeof(struct safexcel_ahash_req));
