Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ToUP7R03POLVysG9pW5/e/YotDdmAYm8GxwC3BnxDWyyhrLXaS/9cwZP3td+XthXHXN6S
ARC-Seal: i=1; a=rsa-sha256; t=1517591241; cv=none;
        d=google.com; s=arc-20160816;
        b=vS8hrw2k9d6J/PZ/NkCMMR+YZmRl3goBQbWjy/l82RgXnISUWzYOFeeKOtqpWEiqht
         GRG3g5pL9bl8yuYWhgPvfWDx8rWWtaVyQtv5kiXD20E5iUnuwn/LA+qKu5gCE6D6xkL/
         jABpVOEYj+30bi5smBoWg/WtDG/VdJ4VDYap007WfBmeaKJeGWaCGXQI1fWm5OHnYxSv
         NVShGSQJe9IWKplXZ9xMthRo3TSpXqCvsQ6bXoxhnc5Hxo48AM6k7FybS2VrInKnUIsg
         dg8I1BYZ25noEOxfRyUpEBSOg4fsNa9weyEHf1Oa1i4JcnA5ksEiNmRZSTe14nozDFEv
         wvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lDy4UB8uwHhaa6tHwpifSrP2v4BhOBjmoxfdJDYG3RI=;
        b=m8/9E7jJR8x8j+48Z+TiktZHcff6MDBRxYqv85kINrAKY3xQswqgBxoipMHo7PxZL8
         JnxWUC2yzrMm5rTN+JWqrmTQUEAIWnHzdBBfco07uHpDH9kiz9+MYgrPFLlUwUvZvYhf
         0KoqNM+132Yxv8xB+RfeSZo1YzrUX6EJlGQsd7Qhj3rRWs+pmClqYSBGupV7rZyHIjtg
         uHd1A7ANk1CIjCkxkPF9UsFdtjrXmuJF2CPB86fItG1TSp2LQQXSgG4g4y1oYDgpWW7k
         wfKBE5/ZeNSU/OOcC/wab+Ow6MjXhR89QJmc+yo/B0uNXAg9kkvM3P4b8CcwTsTZLxWF
         RWqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Lesokhin <ilyal@mellanox.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stefano Brivio <sbrivio@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 013/156] crypto: aesni - add wrapper for generic gcm(aes)
Date: Fri,  2 Feb 2018 17:56:34 +0100
Message-Id: <20180202140840.909943348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309753777659407?=
X-GMAIL-MSGID: =?utf-8?q?1591309753777659407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit fc8517bf627c9b834f80274a1bc9ecd39b27231b upstream.

When I added generic-gcm-aes I didn't add a wrapper like the one
provided for rfc4106(gcm(aes)). We need to add a cryptd wrapper to fall
back on in case the FPU is not available, otherwise we might corrupt the
FPU state.

Fixes: cce2ea8d90fe ("crypto: aesni - add generic gcm(aes)")
Reported-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |   66 ++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 12 deletions(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -690,8 +690,8 @@ static int common_rfc4106_set_key(struct
 	       rfc4106_set_hash_subkey(ctx->hash_subkey, key, key_len);
 }
 
-static int rfc4106_set_key(struct crypto_aead *parent, const u8 *key,
-			   unsigned int key_len)
+static int gcmaes_wrapper_set_key(struct crypto_aead *parent, const u8 *key,
+				  unsigned int key_len)
 {
 	struct cryptd_aead **ctx = crypto_aead_ctx(parent);
 	struct cryptd_aead *cryptd_tfm = *ctx;
@@ -716,8 +716,8 @@ static int common_rfc4106_set_authsize(s
 
 /* This is the Integrity Check Value (aka the authentication tag length and can
  * be 8, 12 or 16 bytes long. */
-static int rfc4106_set_authsize(struct crypto_aead *parent,
-				unsigned int authsize)
+static int gcmaes_wrapper_set_authsize(struct crypto_aead *parent,
+				       unsigned int authsize)
 {
 	struct cryptd_aead **ctx = crypto_aead_ctx(parent);
 	struct cryptd_aead *cryptd_tfm = *ctx;
@@ -929,7 +929,7 @@ static int helper_rfc4106_decrypt(struct
 			      aes_ctx);
 }
 
-static int rfc4106_encrypt(struct aead_request *req)
+static int gcmaes_wrapper_encrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cryptd_aead **ctx = crypto_aead_ctx(tfm);
@@ -945,7 +945,7 @@ static int rfc4106_encrypt(struct aead_r
 	return crypto_aead_encrypt(req);
 }
 
-static int rfc4106_decrypt(struct aead_request *req)
+static int gcmaes_wrapper_decrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cryptd_aead **ctx = crypto_aead_ctx(tfm);
@@ -1127,6 +1127,30 @@ static int generic_gcmaes_decrypt(struct
 			      aes_ctx);
 }
 
+static int generic_gcmaes_init(struct crypto_aead *aead)
+{
+	struct cryptd_aead *cryptd_tfm;
+	struct cryptd_aead **ctx = crypto_aead_ctx(aead);
+
+	cryptd_tfm = cryptd_alloc_aead("__driver-generic-gcm-aes-aesni",
+				       CRYPTO_ALG_INTERNAL,
+				       CRYPTO_ALG_INTERNAL);
+	if (IS_ERR(cryptd_tfm))
+		return PTR_ERR(cryptd_tfm);
+
+	*ctx = cryptd_tfm;
+	crypto_aead_set_reqsize(aead, crypto_aead_reqsize(&cryptd_tfm->base));
+
+	return 0;
+}
+
+static void generic_gcmaes_exit(struct crypto_aead *aead)
+{
+	struct cryptd_aead **ctx = crypto_aead_ctx(aead);
+
+	cryptd_free_aead(*ctx);
+}
+
 static struct aead_alg aesni_aead_algs[] = { {
 	.setkey			= common_rfc4106_set_key,
 	.setauthsize		= common_rfc4106_set_authsize,
@@ -1146,10 +1170,10 @@ static struct aead_alg aesni_aead_algs[]
 }, {
 	.init			= rfc4106_init,
 	.exit			= rfc4106_exit,
-	.setkey			= rfc4106_set_key,
-	.setauthsize		= rfc4106_set_authsize,
-	.encrypt		= rfc4106_encrypt,
-	.decrypt		= rfc4106_decrypt,
+	.setkey			= gcmaes_wrapper_set_key,
+	.setauthsize		= gcmaes_wrapper_set_authsize,
+	.encrypt		= gcmaes_wrapper_encrypt,
+	.decrypt		= gcmaes_wrapper_decrypt,
 	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
@@ -1169,13 +1193,31 @@ static struct aead_alg aesni_aead_algs[]
 	.ivsize			= GCM_AES_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
+		.cra_name		= "__generic-gcm-aes-aesni",
+		.cra_driver_name	= "__driver-generic-gcm-aes-aesni",
+		.cra_priority		= 0,
+		.cra_flags		= CRYPTO_ALG_INTERNAL,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct generic_gcmaes_ctx),
+		.cra_alignmask		= AESNI_ALIGN - 1,
+		.cra_module		= THIS_MODULE,
+	},
+}, {
+	.init			= generic_gcmaes_init,
+	.exit			= generic_gcmaes_exit,
+	.setkey			= gcmaes_wrapper_set_key,
+	.setauthsize		= gcmaes_wrapper_set_authsize,
+	.encrypt		= gcmaes_wrapper_encrypt,
+	.decrypt		= gcmaes_wrapper_decrypt,
+	.ivsize			= GCM_AES_IV_SIZE,
+	.maxauthsize		= 16,
+	.base = {
 		.cra_name		= "gcm(aes)",
 		.cra_driver_name	= "generic-gcm-aesni",
 		.cra_priority		= 400,
 		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct generic_gcmaes_ctx),
-		.cra_alignmask		= AESNI_ALIGN - 1,
+		.cra_ctxsize		= sizeof(struct cryptd_aead *),
 		.cra_module		= THIS_MODULE,
 	},
 } };
