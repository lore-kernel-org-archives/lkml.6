Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/N5CCxT0RiWkbhVegYNpnd8/4XWg61dNMwtR4UdMnBSP2nSAOlbaBpDgIIz+dkYg9zMtOK
ARC-Seal: i=1; a=rsa-sha256; t=1523021548; cv=none;
        d=google.com; s=arc-20160816;
        b=tiI3/grdsp+coF0VKdHW/7wfBpl56faQoCcmdZwLgPK1hgioEUbNYtHbsp6ro3tqM8
         5EPgtbc8tCxtPtFhHGItsRjrf9togvjpY3Cwky+y9rrAKZu2RMX92MOBXIpa/UI+LypZ
         Yg36s5/sPefDzjnCITpQp0TYKsJFEFFzrtrPGj3Nxc71ultuKKgFMyLpthkZYzTqx6kO
         5niKxWvBenkQegj4oN6mVqdK0+RzHuHn80mf0KdtaN/FHZcZoevW4KoWgS7zPpVkWFhA
         NQm5LlHepGLipLIBdg3LnUPdZq2keMMMTuZyRKrX/priyyIK4UXnUbxTuFe0oSdmkGCt
         ZY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oDP6FuvO/NvwNTR93l8WolbFrHsPPbOpxbM6VXxO/Bc=;
        b=Xz/APnTzrRszhm2aH6bEHwr+g0wr7RzmGuJn3wgfUX3BjScCzf/dBsD18RB7R8r5wL
         SS7PE4PJ6mKCfbWZVvrGfUztuc/bmeXKIZt032bmuqV0rFvL3HXOBUbI3sBfDLrrSpsb
         AOtl8+PSLPU6JJEptTv3nky9oSF3aigQVtgzw4TlqECCDO8qc2GX1zMMsBYs8nsycmp9
         q5iAf/FWcN3jAK7cHo4FxM6zlXMR08EAfp3MZW9ak9fLzPuVoOoRDqPxoN33HNCc/VKD
         Rqq3ipmCuFalfnANSLbHuZleqGosFm52r7wh1IQDXbQZEKe64KDLAsV6Azzo2H88OMsP
         n1rA==
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
Subject: [PATCH 4.4 52/72] crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
Date: Fri,  6 Apr 2018 15:23:53 +0200
Message-Id: <20180406084309.628555327@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003609405057187?=
X-GMAIL-MSGID: =?utf-8?q?1597003843417144585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
