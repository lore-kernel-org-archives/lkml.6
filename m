Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489WtkroNU/REwJ7QXY6/G/+NGmdm/7MQFozG/P1OogmnpyCMw3td0E2aOZveKJciXkcDBU
ARC-Seal: i=1; a=rsa-sha256; t=1523022247; cv=none;
        d=google.com; s=arc-20160816;
        b=Z5dZwysyzp5i8nVyKQNm0iYGBtXJ1lqDBVJeILUkdzoBfKvfoP6BblOOtv56Z7u9IH
         lhoJ0U9o8rpj1w0FTChh+eA1uLHIlvH3VqAFt0mNvZXxWwJkUvXlCptH6Awgltzfj3AO
         YRgUrpT2lKvs5fMPKI3zwfYVRGZCzlbeEEk49XBvTLoHbfpIHgObLVb92EQBYxlVv5VC
         VD9uvfOBDLrV6hD0WSKsLigO1Qy6M2+nhEn58HbQXoLGO09VHxemHMQYHRU7n68EHTgL
         nyzFfWJrN71BMNGV99VeQ8TYIX6WLRt0Lkml0d4A8Shljrj1LNLLKVeAa8VonmZm8Tsu
         YHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Paidl6TvicTBFZyQ755ab7ZFaplfNyKJpK1x1SWKy7o=;
        b=LcmFutlKDC1YlY3c6z3qpZ8/KLNEnYtlrFB7CRyxc8vYR7rv1wU8w+JWGpRtBoiSSS
         /kDaILbwHczj6F+4qmhhLUja6xGYbuEgnftSLEk19CaQPjUlaLnNRdtbVECUlBMpOZbT
         KPA6c9DeDTgEhmywqleQqOVzpo/MJqBPG6+QVQdtKTrl4V4WGU5zdLMthG/0uLVBqxUN
         Jd9upYuLn74bxpbt6Ns7RVLw40Se8MB4UGLW8LyBomQWyoFOoslEQJN0h90cEvm2xk5d
         RVwc3nq5kgfA0wbKSjec23P+TpohcweTwFl6Z9EMN/V4f2q6AeNqNIwc08S902ZEb+SL
         wGjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 58/72] crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
Date: Fri,  6 Apr 2018 15:24:33 +0200
Message-Id: <20180406084353.361242662@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003609405057187?=
X-GMAIL-MSGID: =?utf-8?q?1597004575791028885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 8f461b1e02ed546fbd0f11611138da67fd85a30f upstream.

With ecb-cast5-avx, if a 128+ byte scatterlist element followed a
shorter one, then the algorithm accidentally encrypted/decrypted only 8
bytes instead of the expected 128 bytes.  Fix it by setting the
encryption/decryption 'fn' correctly.

Fixes: c12ab20b162c ("crypto: cast5/avx - avoid using temporary stack buffers")
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/cast5_avx_glue.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -66,8 +66,6 @@ static int ecb_crypt(struct blkcipher_de
 	void (*fn)(struct cast5_ctx *ctx, u8 *dst, const u8 *src);
 	int err;
 
-	fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
-
 	err = blkcipher_walk_virt(desc, walk);
 	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
@@ -79,6 +77,7 @@ static int ecb_crypt(struct blkcipher_de
 
 		/* Process multi-block batch */
 		if (nbytes >= bsize * CAST5_PARALLEL_BLOCKS) {
+			fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
 			do {
 				fn(ctx, wdst, wsrc);
 
