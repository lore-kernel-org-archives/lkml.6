Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx485FxgYf/AohSgR+pfcvfLF3LvQCr3tUkSMu8/iA5xSIfnBfQqGSEeCEavP2B+aVRj+RNxr
ARC-Seal: i=1; a=rsa-sha256; t=1523022279; cv=none;
        d=google.com; s=arc-20160816;
        b=yg05NBvqv/gs70Xf3LgiMDwqvVreY9lJEQVKlGAhQF2/3nlE8TnnapcSEfAlt0lFLi
         o9/xpIMmSImMpJ3NFSRxz9MNrBqrJ9FZkznIEMgSQ8gZb9KiLKTR0luLTiICMg7Vrud9
         p36S9zQB1WGQQ97FJt5E8ad+bt9wm1hYNbW/QlhqOMNgWk2VDaq1zL08PaSVppgkAFZp
         fUGscorrzGkOy+vuiPY9hOSZAH5Eeuc0boVqDGrdNJK1mIZAV3nL1EBwgZkaJ9TQm6AO
         1bUJxwZxarsKob6Tg1tKaStAUftoGzn/it9GxzzTxF4y7UE9JbFMvGDB7zWTvtbtqfOe
         1sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xt21BsbpyXeY6XFv68ChrN/x87LGf3yqH5RDfy8frAU=;
        b=rxW2t5KLqj4ENQV5N4fKKv0bbLo1o15RyFqIRtZZvaruCNnwLYtnUqgPhmb32kpX9K
         tA2p2dYU8WzQZSTioIZ76tJkA1Qd0JILrjDsecJvV5nqI3iSN1/P7JKG2+2toPUgn7k9
         MTUOZPRJ7Ua/1E1UsjALaAyjLl0igU2JfP8mBRoUOfU9acYaOogfEbS4OPB/TQ53CkGl
         BeS5+h/tZ7URDF3f8ZvrX2e9si+exHAnPeYDL5pFUBuywkuws0lHBVUNAqfomvbiYi8e
         G8X/jOygkknJbMn3dozh0Auyb0JyDXE0Qd4iJ/1ZL6JrIOYHwtL9LL3RWMJGske/Cxr2
         Ds9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Gary R Hook <gary.hook@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.16 18/31] crypto: ccp - return an actual key size from RSA max_size callback
Date: Fri,  6 Apr 2018 15:24:43 +0200
Message-Id: <20180406084343.491606651@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004281875020882?=
X-GMAIL-MSGID: =?utf-8?q?1597004609801276563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

commit 0a9eb80e643064266868bd2fb2cd608e669309b0 upstream.

rsa-pkcs1pad uses a value returned from a RSA implementation max_size
callback as a size of an input buffer passed to the RSA implementation for
encrypt and sign operations.

CCP RSA implementation uses a hardware input buffer which size depends only
on the current RSA key length, so it should return this key length in
the max_size callback, too.
This also matches what the kernel software RSA implementation does.

Previously, the value returned from this callback was always the maximum
RSA key size the CCP hardware supports.
This resulted in this huge buffer being passed by rsa-pkcs1pad to CCP even
for smaller key sizes and then in a buffer overflow when ccp_run_rsa_cmd()
tried to copy this large input buffer into a RSA key length-sized hardware
input buffer.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: ceeec0afd684 ("crypto: ccp - Add support for RSA on the CCP")
Cc: stable@vger.kernel.org
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-crypto-rsa.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/crypto/ccp/ccp-crypto-rsa.c
+++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
@@ -60,10 +60,9 @@ static int ccp_rsa_complete(struct crypt
 
 static unsigned int ccp_rsa_maxsize(struct crypto_akcipher *tfm)
 {
-	if (ccp_version() > CCP_VERSION(3, 0))
-		return CCP5_RSA_MAXMOD;
-	else
-		return CCP_RSA_MAXMOD;
+	struct ccp_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return ctx->u.rsa.n_len;
 }
 
 static int ccp_rsa_crypt(struct akcipher_request *req, bool encrypt)
