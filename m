Return-Path: <kernel-hardening-return-12879-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49nSJU0vr3HtGoKYeBTwoEAgWRgz3cxyoH9B6IKJJRp0hFkLbmKVY8yRTNiTYuZtDP8bZvj
ARC-Seal: i=1; a=rsa-sha256; t=1523126386; cv=none;
        d=google.com; s=arc-20160816;
        b=sNwXJUwsAmTbdDxhbij8xxoDK1R9yvwDyGFXqEqgViP3ZAlwFpqiEjgx8SerD0Bj5/
         waf/c7wyjEouuWGa4K2D/n0QD2LcLEM2NB3cMhcYsF9K8HF/fA+i7m1hKcGwU5xKv2/Q
         mYjTYkT+xEENuOoq5KHgydeXSLJJm0nxIoR0AiKb85mA+8TZiQ+ta34eh4HAXrJezxS+
         /syQATU/W8bQbw26yFBW6B3/hi3iHr5FIfXcKaaDO0sXhK/PREo0bt1dVmBqSW5Wap3p
         gUG2Y5v6kUj4RkXix9YIbjjUfVWlKJbLQ6eWlhLpzhwI6VrTj6QxfxNV37h+NSnZ71rU
         Hs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=YAlTGdnPdSsRn+04SbOD45FkZFw5nVfUTH5BnaTOpDI=;
        b=RCRBi6FlgXMxR7PsjtRFf7nmc0sYWuaq8+weq18ndaI9IJbD0+c34DAGxGK8NVMlPW
         lNZA7hAs5EjaOuSmtZ2AEo7i54+NLxgRJ3gCqkJvjw2xdWF9boIzz+EPJwgEOqOJITx2
         xtAAwyhfeUZfUxwpaVwJm/Y5/3lL2IbWCWs0D5A/5mXFweXMTRAxjP46XCns9EphTuzZ
         VnueETmTjK2AcOEuUaulJCFUZ4sbAcvNcglgp38GSq3en3FoBukzprX8AocFw54yy7pD
         P0VWGfJCDTy32pChvZhkNwFXbAR3wIy1cLq+MbmTz0I1P7ikKEzAbnD/SBNWPFOFca8E
         CKYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fQbxwYCQ;
       spf=pass (google.com: domain of kernel-hardening-return-12879-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12879-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fQbxwYCQ;
       spf=pass (google.com: domain of kernel-hardening-return-12879-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12879-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: [PATCH 3/6] crypto: api - avoid VLA use
Date: Sat,  7 Apr 2018 20:38:20 +0200
Message-Id: <1523126303-23205-4-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113773763364977?=
X-GMAIL-MSGID: =?utf-8?q?1597113773763364977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We avoid a VLA[1] by always allocating MAX_BLOCKSIZE +
MAX_ALIGNMASK bytes.
We also check the selected cipher at initialization time, if
it doesn't comply with these limits, the initialization will
fail.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/cipher.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 94fa355..9cedf23 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -67,7 +67,7 @@ static void cipher_crypt_unaligned(void (*fn)(struct crypto_tfm *, u8 *,
 {
 	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
 	unsigned int size = crypto_tfm_alg_blocksize(tfm);
-	u8 buffer[size + alignmask];
+	u8 buffer[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *tmp = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 
 	memcpy(tmp, src, size);
@@ -105,9 +105,14 @@ static void cipher_decrypt_unaligned(struct crypto_tfm *tfm,
 
 int crypto_init_cipher_ops(struct crypto_tfm *tfm)
 {
+	const unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
+	const unsigned int size = crypto_tfm_alg_blocksize(tfm);
 	struct cipher_tfm *ops = &tfm->crt_cipher;
 	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
 
+	if (size > MAX_BLOCKSIZE || alignmask > MAX_ALIGNMASK)
+		return -EINVAL;
+
 	ops->cit_setkey = setkey;
 	ops->cit_encrypt_one = crypto_tfm_alg_alignmask(tfm) ?
 		cipher_encrypt_unaligned : cipher->cia_encrypt;
-- 
1.9.1
