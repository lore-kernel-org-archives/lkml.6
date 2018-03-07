Return-Path: <kernel-hardening-return-12215-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELut0x1GTV+rkCw8XgdaUlezyRT89O3IkzQIvM7J0WjQconTbg1SSFxZuH2jRsq/hvnIXZ+U
ARC-Seal: i=1; a=rsa-sha256; t=1520459810; cv=none;
        d=google.com; s=arc-20160816;
        b=L5duF+vHDVl0H7u1tVgCwufHVM5lTfAQsmd7r4soV5B47ri7a/Wvh/fVICIxXncjnj
         UANpSdXOmKw7lh94xdCmpk/65/1zE2tyQok0RFm2Ahe80rykFm9mhCPGOjO355l3PsNV
         6bGm+n5R/LYAPW6yXgM64R5P4GxzflQfNq+hmASiLFLfJQl16r8H95xIzG03Up3jkyuE
         n7wdwRRM3VymvoyHGQoqo52gxMJ7Rb0fml0wAylEMO+B9VC8UVDPIBDGAcXfdcBsn2Np
         nXDqCHbD8s7rhWFGCmSmgfJlK9pPjedNhM8Y+9KAyAU7SQcpwyxcYTtB337Fkyd1vHlu
         7dUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ouZF0y5KLhRn9w9F0iNKpmOk6Nmmj31Co9EY3r/FL4c=;
        b=PDzlzxWZxN7oWVxwEjshQaLjxgTIkuhoNqmNouVEDmoUgHz7n76lrzAqVPaVcN/Xji
         X8claYWj0yXwqe3P/q454C8IhKD9P/071RdPUD/oyGFCLWim6F/lXFLjQrFjVpwNNIrX
         XYUpe16KWiWh8ss+278sRO6IA22Yc/fgbRtr6FZsY6Xtf+e86JLn5DPwX3vrX8A8Dt9Q
         i7NOejVDqDgTFijQTd/8+H+bN3pqpNWRIcql22ZU02hNi/wKmudrhca3bmj7y8shJ63A
         QCnixmvhi5uiip/RSh53kE/KoDkEDLQXHF4wIBgdCSAnh3r2aPUH30UG4icbzUsMfeR0
         mdNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=bmMIilWI;
       spf=pass (google.com: domain of kernel-hardening-return-12215-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12215-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=bmMIilWI;
       spf=pass (google.com: domain of kernel-hardening-return-12215-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12215-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 13:56:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] crypto/ecc: Remove stack VLA usage
Message-ID: <20180307215615.GA18928@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1594317666211482580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On the quest to remove all VLAs from the kernel[1], this switches to
a pair of kmalloc regions instead of using the stack. This also moves
the get_random_bytes() after all allocations (and drops the needless
"nbytes" variable).

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ecc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 18f32f2a5e1c..5bfa63603da0 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1025,9 +1025,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 {
 	int ret = 0;
 	struct ecc_point *product, *pk;
-	u64 priv[ndigits];
-	u64 rand_z[ndigits];
-	unsigned int nbytes;
+	u64 *priv, *rand_z;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
 	if (!private_key || !public_key || !curve) {
@@ -1035,14 +1033,22 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto out;
 	}
 
-	nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+	priv = kmalloc_array(ndigits, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	get_random_bytes(rand_z, nbytes);
+	rand_z = kmalloc_array(ndigits, sizeof(*rand_z), GFP_KERNEL);
+	if (!rand_z) {
+		ret = -ENOMEM;
+		goto kfree_out;
+	}
 
 	pk = ecc_alloc_point(ndigits);
 	if (!pk) {
 		ret = -ENOMEM;
-		goto out;
+		goto kfree_out;
 	}
 
 	product = ecc_alloc_point(ndigits);
@@ -1051,6 +1057,8 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 		goto err_alloc_product;
 	}
 
+	get_random_bytes(rand_z, ndigits << ECC_DIGITS_TO_BYTES_SHIFT);
+
 	ecc_swap_digits(public_key, pk->x, ndigits);
 	ecc_swap_digits(&public_key[ndigits], pk->y, ndigits);
 	ecc_swap_digits(private_key, priv, ndigits);
@@ -1065,6 +1073,9 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	ecc_free_point(product);
 err_alloc_product:
 	ecc_free_point(pk);
+kfree_out:
+	kfree(priv);
+	kfree(rand_z);
 out:
 	return ret;
 }
-- 
2.7.4


-- 
Kees Cook
Pixel Security
