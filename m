Return-Path: <kernel-hardening-return-12269-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvERs5C2nzHBZo1hyayR3XPFLr7W2kwp9aDlJA9sjWPoXfxNIEfkPrjuqiLmMzcPm1HS+qv
ARC-Seal: i=1; a=rsa-sha256; t=1520546241; cv=none;
        d=google.com; s=arc-20160816;
        b=LCqlEhDjJrGoT2wJUSHnsAImEF0dSp1ugN1tHlxGBw0Lc5gSFrgUz9EV+ADIEx/yH4
         xq51WrAluzV4VhvuEzOhVgbvNBldyE7oHnlzKNDtIqJzAABtMNqB30USi2k3eCbzacys
         VLzcjQxigOpx0cokstctlhS9KdJVTDvAnmJOQKX7Hb26hFJhGnTHFohz8j4aVygxetki
         1y7+J830NshzBl5FxykvEhCrbuu5q2Fs0KBGnxPhBpHXDGubXtB0MkFRohuC7niVbvx+
         xJH3KccAK9KyzvJNYfHLga8mJDiOoz9Q55dp1y/LzJz7GZT4VlIFdss1zKY5p1/fLOcC
         BIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=w0U19uYN3nSjPLiSqmXDBEuAMXFjl13Cwv1eIZMdKfw=;
        b=vjEEsdvIhtsmoX8mFdD3anfHWKXNxwnMH9QufLhYFjG56mCRyx5tLeiWZ14/Z6LAfx
         bG6/AKaDLjnFIWuhEgQnlOK8+RoZ57fK4iGn/HSaXdOvTuW7KOCR/+maP/8CWaNnJSck
         y3hlyLM8T81SBo7QP5kzz8ubUvX8gA89MvV92DFAcOK3L8I6hUM2jlJNIpkwBxg3pVeG
         KzxpLh51dwjHqS6rIWeBHsGSHDUAbW9mSp1YoQdF9tNmHWOu98/XHb8rjt9f+pSFO8Nd
         p8W6eBRkyrerPFHqW4NfI1RUC4jZUujDCuqq9yAF231NEEFcMiHeIcZ+9tPgZLjoH5Al
         pwSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NszixnG1;
       spf=pass (google.com: domain of kernel-hardening-return-12269-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12269-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NszixnG1;
       spf=pass (google.com: domain of kernel-hardening-return-12269-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12269-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 13:57:02 -0800
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto/ecc: Remove stack VLA usage
Message-ID: <20180308215702.GA9902@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1594408295451970999?=
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
index 18f32f2a5e1c..9c066b5ac12d 100644
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
+	kzfree(priv);
+	kzfree(rand_z);
 out:
 	return ret;
 }
-- 
2.7.4


-- 
Kees Cook
Pixel Security
