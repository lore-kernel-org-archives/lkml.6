Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UjFqzRNeKapRr3enAkbXOlJB5QXxHWJ7kCCXkd922zZuem9c2bcAtQ5GDc7xgfXMil1z5
ARC-Seal: i=1; a=rsa-sha256; t=1523022287; cv=none;
        d=google.com; s=arc-20160816;
        b=S9VikQFJEmFEht5QXZ8NOfDubrCj3RiPOwnKJAEPFVujUUGuaJwciKXZo/M/R+uM05
         Tu1Ib+VdEMBLlPhEMR9X0wBmv/Ms5KLC1zVQGV6L33e5HfyPfK9e0RTt7lyWLTkBRNYQ
         F1xFoInmtLyj9i1EuQsAZedd24weRHpl3bAON/Wd8K0oawis4XsVFlg6jiZcJqQpCqmU
         OcFOITZvJ0A+1sVTpn47pDQSBdiDLtprXB4AlTY0QoLXAS3uVTPZv9v9hNHxffHBxWJg
         tDUS81O38Bk3UuLXJ5omVfYMvTAylPN5tVsJnZMm9PqHxycSgABic254CtJvwVLyj7jm
         HEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4LlrBzrcYfzgSs1ebwDZyJfAy0HSgfBEP+5OakO7o9s=;
        b=Bhd9WVNcHj1aht5W5syP2y6/aPMhONi8yebPEdXavsaUuj07ny65ScQxDidrdQMzLj
         /e1rrnIi3DpLSOMEr2263kWWzTqjaJh1Udv5I0rz5e2ju50EONUe12up7B1MK5qx4110
         ms826MMQPIfyA7vsGgH/jENlON2RsZQVgdAI+6H8biD1b3C4w/pzRn/0z/VNjFHjYDqQ
         +9uwpvmleAEGZjsRRVd5REaX5SSTAVBz+7wJLYRpUCZxr3ZLXlDq43FKiSCDY5BE2i9U
         wgziDQxhm1dxmPPhZjmSgMIvZUgmB49TycygLac+P7R9k1/PvUcY4/twMnxRdPUJyppD
         eJuQ==
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
Subject: [PATCH 4.16 20/31] crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
Date: Fri,  6 Apr 2018 15:24:45 +0200
Message-Id: <20180406084343.765391700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003609405057187?=
X-GMAIL-MSGID: =?utf-8?q?1597004618369986957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
