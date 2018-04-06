Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8n/SpNmUjonPz8tQOj2d6H+fUGHReuFukVnsf+r8ZWdQQbfZbdViqGq27Sgqp6WLru2Dc
ARC-Seal: i=1; a=rsa-sha256; t=1523021974; cv=none;
        d=google.com; s=arc-20160816;
        b=W6eXVKw4p1/mRNeFy7kyNze6KQW5gLKpnQUVSjX+I2x+mGBOcL5UMR2xFvLU/Cl9vf
         scdsClHfO/9T/qF4TR1p1Z/Q5kB77XhHqFcSBRivIDvvmCgKGqi0PSO9dHQy3QaL5B9N
         HR7YLxjH8vmsVIpsXTPWpekVoAeWxVFposCNhC/x2P+2QY26HXFRz1BjGSuhEHQKxFVh
         A3GUshV9BpSBFy8aQZwXxdu0LAp9g27Y3o5YuMtsUqZlu58/FjWy8sY/eta+6Z2+ARjZ
         tCXiU5OJpG2lnhCutITurUBlrRhsJFz4c6iHlVvcmO1BgB5UhVH/GuTJOv1xZn1FHN6r
         fsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XM5SFN9RmiGHnL1o9+N176+I0FD61IDxKNZjBOxidcs=;
        b=EE0ZW18iqowCCbGHSwlBuNZQaV3wn2tZ+iMTrhCbCVt5BqFLXbjh+HBIFh5/XWwCeN
         Qa53lqNIm8B7Jn+YmlMnmaYB9JnS3k0pb8aAeSv+g39JZg/BEIVj2TsrvYuUvsX5GOpw
         coYctNzpKuCYEVqFLFTSouJv3CvmGGBxOIhyIB5GvWOEc4bE/hfeOR3DtB1L30lMkVmZ
         5s1PTkGkBMXtbOTxUT2gRQYKbhRGiFJUhLB2rpxtMA7HxRuGNrg4L+p4QRjSUubv9HyM
         S4ODPKNS9xIRwpuzIuTP0+d4Sv7syZn2ygg7mtCnjBnBObhLt/ybyLPWJdmqIElVnjlO
         HMjw==
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
Subject: [PATCH 4.14 53/67] crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
Date: Fri,  6 Apr 2018 15:24:23 +0200
Message-Id: <20180406084347.829092660@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003609405057187?=
X-GMAIL-MSGID: =?utf-8?q?1597004290461586234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
