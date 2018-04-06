Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DDXe9vPC8frXW3IejaVACB1pgmk2FHqhB/4M4Gwy943TqzXJ3+9xVl3bj5Wuq8IR+Uwnr
ARC-Seal: i=1; a=rsa-sha256; t=1523021766; cv=none;
        d=google.com; s=arc-20160816;
        b=p95rWIs6SsB7L/srphWBPpGX9B789AoDZNu4CJDRcpJeIIPUvTG1gSbYLwD+M225Jr
         53uWMTcxHJCs7QYieqUeUpbVyracDmfgyh8QhX7XsacsSHPVMGLe3GKeZUsr5QjNHzsC
         no33NsBii0SIm3cj6LGwypjmrcSnKZuyotrhhOy1prhHMCuQ2OnbZvgXwPOzFG5SHdcb
         ca8nPsvXem4BnIihL30zN2Y9ZMoiDxbYrq6fnYRvsPfp2dMzXryt6BHZkBy9qBtoXq9A
         xfY8gy4AfkabfmaCpbGBCQyx+sNgyScmEIHGDHuRTYnBEITU8302iSn5aZwIFy5i9/pG
         ZncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kLJx2r0RFLG30UOJSAslwDWiYXBaa8alo/o5e5tsgXo=;
        b=IhP/y/VkqscLpqoWp2L8TXxqyGKDKCs5DuXTBulHiFjhxcc7tLaQgjPhre/S5ImbWU
         ULWZwMNJd5BBpFHLyXucn012hQ+zLoFhxnl/MEPPGk0Jg6mbHoms3SqOw2vDigMukmQq
         VAq/W2/sgVR6LWQhW2ZX7fYdGvWnIfAYIZexlkmiV8VEdAds32sm7gntVp8j+gW5HOSW
         fZqEA/bxWgiOQOR/UsYUkgBaFzyFsgu2GiCI/aBfrbSOuFeSKDi2FU4W87R9VCHkvY8s
         3Ph8VRRMEdsXtk9uTfc2I0hzanetY4s9eiuQRvvP03rT5Vndp32pZOb+n3IpnLiO3iL1
         1lIQ==
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
Subject: [PATCH 4.9 084/102] crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
Date: Fri,  6 Apr 2018 15:24:05 +0200
Message-Id: <20180406084343.265931664@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003609405057187?=
X-GMAIL-MSGID: =?utf-8?q?1597004072164318287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
