Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CjqNSHtBqqFyCi4gZ0Mpj+cQaPW95mxaOp2CpDYO+yZD1BxkzmFe2uqdmwsFZENgvez2Z
ARC-Seal: i=1; a=rsa-sha256; t=1523021325; cv=none;
        d=google.com; s=arc-20160816;
        b=s0gSeY7ZFQxon3WaxaoYpICeTFtc08RT0oQIsywqHSMRn72ZHbaxqnNYGonDT/O5WK
         uwfT+Vlbjj5tb0MNTATnvUW4hIX0UOk79h8JoOCGYG42CElU+XEjfyXa9XiF81Zrw2IQ
         e6uu6SA4byfPt5RRwpok/T3KnuyuTx+bmD1gXcTzcub+EYwf8pdhJzLNf+dcPJ0igUR7
         ssdRNSIppucODokZ2/oKK7u9lyecRHKszNS8Gq3Q1nYih9xUZy2NHHrnJTG9Gcr2+dWx
         eZhL2akfOjE43y4CeAp3hUZNwJNTxjNXjJH2ds1IYuBhvJ4wpBnl8MBYh5fkWxnhwDDR
         7S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sjvrUzgeN6O+OFPd6WCNYXeHo1t2LN2qufkHVnvNyB4=;
        b=09Qfx+7PJjUVq4QwKC7gAztDOFa7uwSJuIg+U3tYco8hiPoHpLN4u0M+gFjRXRlZHW
         NebgDDdlqVZ3WE2q96lS8+qBZ2G7pWCrEPZ2ISU31a4UiMnFQ8c6yFCDoJrnW3wqGuOK
         pWI/eoWWSYnHaj9wJLAiVK/hsG4lBxdaOvhWJlAR0B3MslPGWrc7KlMVsU+graIAP/yO
         CLJL1ep4OiHQX3a3fL0MezWoZvpgfhvJZUTIYPwFNf5djBuHFsCxXL8gqKG9oCN3eyG5
         KfIWogu0XTyIIHCPhVI9XR0jZzfz6v60a7iU5C3fz7qDUvbrE0mZvQsTHQ1WYJ6JFwe4
         19XA==
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
Subject: [PATCH 3.18 82/93] crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
Date: Fri,  6 Apr 2018 15:23:51 +0200
Message-Id: <20180406084228.748511934@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003609405057187?=
X-GMAIL-MSGID: =?utf-8?q?1597003609405057187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -67,8 +67,6 @@ static int ecb_crypt(struct blkcipher_de
 	void (*fn)(struct cast5_ctx *ctx, u8 *dst, const u8 *src);
 	int err;
 
-	fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
-
 	err = blkcipher_walk_virt(desc, walk);
 	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
@@ -80,6 +78,7 @@ static int ecb_crypt(struct blkcipher_de
 
 		/* Process multi-block batch */
 		if (nbytes >= bsize * CAST5_PARALLEL_BLOCKS) {
+			fn = (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
 			do {
 				fn(ctx, wdst, wsrc);
 
