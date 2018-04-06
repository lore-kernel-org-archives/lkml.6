Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5+Ho0ObhPyZW83kFGJZmqJZcCk+l8jJynWMjaSUB7ca0oaDOTf96HSrJ3Cj+ICL0gUaG+
ARC-Seal: i=1; a=rsa-sha256; t=1523021966; cv=none;
        d=google.com; s=arc-20160816;
        b=WC5hi+EnXxuCXELYqU35K7k24ihS3egwm2xrK/DgNfYvWmo4jRnBG1v1Ewuzj7B/Z/
         1QReis/BwgjLQ9YmPrZAoTxKQZWucRR/wJcCrWC/XLixzQ3qPxfZgwbDJfwWhK7C6A5r
         o2jY4rVzhTnfVUEQPrkkqI9mEb52hxLXUsfL1+KDliUQDBU2f71xbdUZRPiHNa7USPAI
         TbjinahltIZWlpd6s9y8C02jvq9nIqW9L6WqRaBU7tRcB1/IrHmq8n1I8OBFAhN9Z82r
         nPw68H5n2fVuIKXuk2RpLqtff8E7UHiaPghs0zoKvT6HyzppbFHZaSkE36LwFdZOC5ZZ
         OXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZV/CNItST6gI1OePc6QV5odH2ItvLFkPpuS5OfeeJjA=;
        b=fV2/dMUl1wQCjdmlSssJYaocuyYpgd7W5n6runln5cWApw/J8E9mu6XRCno4nnKeNA
         ugp1qQXQMQCrMZPfEoUTed44BOdY+Wpi/v15bS6/BXlHjvOe5ypZRjfleZmaFw9Ychb/
         9iHWNjpXRkb7uC7ccU6QKTZndQyQBz5RF+eW2K9EluMz72VOUOHJsuGF9GJ2/k4bk3tg
         A+l15ZKlumUWe7XkFLj3wx1g61apA4YB/lVu9USpXxkEI93e+XXmFuXw8/wMiAmirVJ3
         5yqqH05P8KDj7CbVYbE6XTy7GGgwapqQOHHTdh4U5ZFPsnzJVOPYLawn+5v/DoAjrJUk
         awuQ==
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
Subject: [PATCH 4.14 51/67] crypto: ccp - return an actual key size from RSA max_size callback
Date: Fri,  6 Apr 2018 15:24:21 +0200
Message-Id: <20180406084347.718756197@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004281875020882?=
X-GMAIL-MSGID: =?utf-8?q?1597004281875020882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
