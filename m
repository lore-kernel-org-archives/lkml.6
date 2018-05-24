Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqpccQIvNHXmrQ3et/Y+sM23B2K8cw81NOBMxgKUHeVY7TIHhOcTWl9BK0NYwZhzXulir3/
ARC-Seal: i=1; a=rsa-sha256; t=1527156212; cv=none;
        d=google.com; s=arc-20160816;
        b=udGSJZY9mY/nqhH5MUw7wXV3SBcRFvswj/VJoc7uLwKwP/vp7b5yePYijFvSX5YrQU
         Dj07XcV6aPctob+saLxVkYCxmSCIrDMbhZ24UlTVznWnyKNgfxb9L/sTkYaq/xXHz/IA
         DElMEYab5nPbkbaLrAjaqN+HJi2I6jCRkMh6f9nE9YK1CW43ieH+dx2uBTiUYcRO7zFr
         luaSR688MYwCG/vSOpEsOyFyJkeBeD2tIXvQRt6j6J5h0qOSM8AckwpEe80xZrrZkBTf
         4e6Qn2DV5HIiIftn8C0/ClNIfXr96kzSjJNFQ8dNeR86jdSWpsMstuV3ttZ+SE/lL9FE
         zaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=A8I29wLE7loH0VsUyp+mitLmInkljwNlFR2DBRzGfBw=;
        b=Os+2T0ZxTco8lsF8mw5n03R0tpEQqmXGzPZ89AvcFJ8xsdp2ammzlbyxVxl4AnvVQP
         e6TI0e7ZJnC//Bm0LQFchFRKRfDkMr9wxCCkDsjyl7eo2+CYw1q/6+p3Za2CE24fFnz4
         TZHPtWdtc7ueQUtlEglG8ffQ4Fu/AGKzIFfutsCPFU2aEaQV/X9xbmudopD0ZHTygM2g
         PwMMtnJlRgXic25G14MkhYpPjeTV9wZ/fosEVO3FXqDABYcGHJeaqa/viPsn1kqrCs26
         2z/dWSBzLHEf+TTaIyZsOsxemLIi8dnhuglztysFU+7kpb23GFNJC4DLnL6m5aNBF98Z
         1CjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kmE60q+w;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kmE60q+w;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ofer Heifetz <oferh@marvell.com>,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 097/161] crypto: inside-secure - move the digest to the request context
Date: Thu, 24 May 2018 11:38:42 +0200
Message-Id: <20180524093030.038506488@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339352619047955?=
X-GMAIL-MSGID: =?utf-8?q?1601339352619047955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit b869648c060fbb00bf6578d13cbe83e6f85914bc ]

This patches moves the digest information from the transformation
context to the request context. This fixes cases where HMAC init
functions were called and override the digest value for a short period
of time, as the HMAC init functions call the SHA init one which reset
the value. This lead to a small percentage of HMAC being incorrectly
computed under heavy load.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
[Ofer here did all the work, from seeing the issue to understanding the
root cause. I only made the patch.]
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_hash.c |   30 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -21,7 +21,6 @@ struct safexcel_ahash_ctx {
 	struct safexcel_crypto_priv *priv;
 
 	u32 alg;
-	u32 digest;
 
 	u32 ipad[SHA1_DIGEST_SIZE / sizeof(u32)];
 	u32 opad[SHA1_DIGEST_SIZE / sizeof(u32)];
@@ -35,6 +34,8 @@ struct safexcel_ahash_req {
 
 	int nents;
 
+	u32 digest;
+
 	u8 state_sz;    /* expected sate size, only set once */
 	u32 state[SHA256_DIGEST_SIZE / sizeof(u32)] __aligned(sizeof(u32));
 
@@ -49,6 +50,8 @@ struct safexcel_ahash_export_state {
 	u64 len;
 	u64 processed;
 
+	u32 digest;
+
 	u32 state[SHA256_DIGEST_SIZE / sizeof(u32)];
 	u8 cache[SHA256_BLOCK_SIZE];
 };
@@ -82,9 +85,9 @@ static void safexcel_context_control(str
 
 	cdesc->control_data.control0 |= CONTEXT_CONTROL_TYPE_HASH_OUT;
 	cdesc->control_data.control0 |= ctx->alg;
-	cdesc->control_data.control0 |= ctx->digest;
+	cdesc->control_data.control0 |= req->digest;
 
-	if (ctx->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED) {
+	if (req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED) {
 		if (req->processed) {
 			if (ctx->alg == CONTEXT_CONTROL_CRYPTO_ALG_SHA1)
 				cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(6);
@@ -112,7 +115,7 @@ static void safexcel_context_control(str
 			if (req->finish)
 				ctx->base.ctxr->data[i] = cpu_to_le32(req->processed / blocksize);
 		}
-	} else if (ctx->digest == CONTEXT_CONTROL_DIGEST_HMAC) {
+	} else if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC) {
 		cdesc->control_data.control0 |= CONTEXT_CONTROL_SIZE(10);
 
 		memcpy(ctx->base.ctxr->data, ctx->ipad, digestsize);
@@ -550,7 +553,7 @@ static int safexcel_ahash_enqueue(struct
 	if (ctx->base.ctxr) {
 		if (priv->version == EIP197 &&
 		    !ctx->base.needs_inv && req->processed &&
-		    ctx->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED)
+		    req->digest == CONTEXT_CONTROL_DIGEST_PRECOMPUTED)
 			/* We're still setting needs_inv here, even though it is
 			 * cleared right away, because the needs_inv flag can be
 			 * set in other functions and we want to keep the same
@@ -585,7 +588,6 @@ static int safexcel_ahash_enqueue(struct
 
 static int safexcel_ahash_update(struct ahash_request *areq)
 {
-	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
 	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
 
@@ -601,7 +603,7 @@ static int safexcel_ahash_update(struct
 	 * We're not doing partial updates when performing an hmac request.
 	 * Everything will be handled by the final() call.
 	 */
-	if (ctx->digest == CONTEXT_CONTROL_DIGEST_HMAC)
+	if (req->digest == CONTEXT_CONTROL_DIGEST_HMAC)
 		return 0;
 
 	if (req->hmac)
@@ -660,6 +662,8 @@ static int safexcel_ahash_export(struct
 	export->len = req->len;
 	export->processed = req->processed;
 
+	export->digest = req->digest;
+
 	memcpy(export->state, req->state, req->state_sz);
 	memcpy(export->cache, req->cache, crypto_ahash_blocksize(ahash));
 
@@ -680,6 +684,8 @@ static int safexcel_ahash_import(struct
 	req->len = export->len;
 	req->processed = export->processed;
 
+	req->digest = export->digest;
+
 	memcpy(req->cache, export->cache, crypto_ahash_blocksize(ahash));
 	memcpy(req->state, export->state, req->state_sz);
 
@@ -716,7 +722,7 @@ static int safexcel_sha1_init(struct aha
 	req->state[4] = SHA1_H4;
 
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA1;
-	ctx->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA1_DIGEST_SIZE;
 
 	return 0;
@@ -783,10 +789,10 @@ struct safexcel_alg_template safexcel_al
 
 static int safexcel_hmac_sha1_init(struct ahash_request *areq)
 {
-	struct safexcel_ahash_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(areq));
+	struct safexcel_ahash_req *req = ahash_request_ctx(areq);
 
 	safexcel_sha1_init(areq);
-	ctx->digest = CONTEXT_CONTROL_DIGEST_HMAC;
+	req->digest = CONTEXT_CONTROL_DIGEST_HMAC;
 	return 0;
 }
 
@@ -1024,7 +1030,7 @@ static int safexcel_sha256_init(struct a
 	req->state[7] = SHA256_H7;
 
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA256;
-	ctx->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
 
 	return 0;
@@ -1086,7 +1092,7 @@ static int safexcel_sha224_init(struct a
 	req->state[7] = SHA224_H7;
 
 	ctx->alg = CONTEXT_CONTROL_CRYPTO_ALG_SHA224;
-	ctx->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
+	req->digest = CONTEXT_CONTROL_DIGEST_PRECOMPUTED;
 	req->state_sz = SHA256_DIGEST_SIZE;
 
 	return 0;
