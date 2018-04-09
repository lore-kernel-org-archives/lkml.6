Return-Path: <kernel-hardening-return-12924-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+R95ivWcVghB2q06drxv+4AQ8cIyNM4vFo8S4tZmiYZBjOgRMhBiL+Th2X8YHwDPcE8BKQ
ARC-Seal: i=1; a=rsa-sha256; t=1523282153; cv=none;
        d=google.com; s=arc-20160816;
        b=X1pkiPLhKXHWWZlQ8eR77LclBOIAEzbsAgWVnnsRMi2aE6k3qmT6HsDtEs8G8mJuH+
         usa2ABZL6uuvc878NPrmG3P3hojCpQ4Sb3tueMQ765hcp9b/WqjkVHilUZh5+oGRpjvN
         rIcrVuYnxRP6nTiG6OdZfC6MLgZzFUyw/pH6n9fxrb0dRxBaCf2CQU6E2SkMbjPqibF/
         DIxPRhS6LCmravJXY3dZp9ySxJT5Q05vTrnbBiegbMcvnhM8Y/XqIAJ43vcOKiNT0+RM
         1Cge13JWD9d6vaOK1bnPF+5yDq71XGOT83oYDM5CfPfsa2VwFJT4iTCGztsdoKYZWdU3
         L+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=6NB0vqSoUgWTZAcA6cfxu0y92CQriqdtNfdKQsTwrqs=;
        b=wiL1t//L26eCp8M9FiiA+wme0F1OBeSX3lW+cfdlSVAH04J+Sq10/nwE389xAGRzMJ
         3dvhMixrxga/mNJFgj3D2qPYS4JfNsdmRam4o36LfB1klx8Yh5/HiA58fAW1iWYPHJuf
         sbDvGU9LZMxfhXSbYbQG1Mtt36rKIn80bJCG+s637+KwO5/t7tEB9+EWVmhRkbdpy+o4
         +EP01WwnLdUw6i3lnodQJSjndmisfX2zp921jQsSTrA8GSogO6o2SPKSqXfUDxrU7+hz
         3iF0pSykB4aUN8woJzJGrqamdBXT8vAk6ufRWUZTern0eI2jQQCl5rhv5PUGkB97uxzv
         mzCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tbp/m8cH;
       spf=pass (google.com: domain of kernel-hardening-return-12924-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12924-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Tbp/m8cH;
       spf=pass (google.com: domain of kernel-hardening-return-12924-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12924-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 6/6] crypto: cfb - avoid VLA use
Date: Mon,  9 Apr 2018 15:54:04 +0200
Message-Id: <1523282044-22075-7-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277107754358358?=
X-GMAIL-MSGID: =?utf-8?q?1597277107754358358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We avoid 3 VLAs[1] by always allocating MAX_BLOCKSIZE bytes or,
when needed for alignement, MAX_BLOCKSIZE + MAX_ALIGNMASK bytes.
We also check the selected cipher at instance creation time, if
it doesn't comply with these limits, the creation will fail.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/cfb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/crypto/cfb.c b/crypto/cfb.c
index 94ee39b..f500816 100644
--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include "internal.h"
 
 struct crypto_cfb_ctx {
 	struct crypto_cipher *child;
@@ -53,9 +54,8 @@ static void crypto_cfb_encrypt_one(struct crypto_skcipher *tfm,
 static void crypto_cfb_final(struct skcipher_walk *walk,
 			     struct crypto_skcipher *tfm)
 {
-	const unsigned int bsize = crypto_cfb_bsize(tfm);
 	const unsigned long alignmask = crypto_skcipher_alignmask(tfm);
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *stream = PTR_ALIGN(tmp + 0, alignmask + 1);
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
@@ -94,7 +94,7 @@ static int crypto_cfb_encrypt_inplace(struct skcipher_walk *walk,
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
 	u8 *iv = walk->iv;
-	u8 tmp[bsize];
+	u8 tmp[MAX_BLOCKSIZE];
 
 	do {
 		crypto_cfb_encrypt_one(tfm, iv, tmp);
@@ -164,7 +164,7 @@ static int crypto_cfb_decrypt_inplace(struct skcipher_walk *walk,
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
 	u8 *iv = walk->iv;
-	u8 tmp[bsize];
+	u8 tmp[MAX_BLOCKSIZE];
 
 	do {
 		crypto_cfb_encrypt_one(tfm, iv, tmp);
@@ -295,6 +295,12 @@ static int crypto_cfb_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (err)
 		goto err_drop_spawn;
 
+	err = -EINVAL;
+	if (alg->cra_blocksize > MAX_BLOCKSIZE)
+		goto err_drop_spawn;
+	if (alg->cra_alignmask > MAX_ALIGNMASK)
+		goto err_drop_spawn;
+
 	inst->alg.base.cra_priority = alg->cra_priority;
 	/* we're a stream cipher independend of the crypto cra_blocksize */
 	inst->alg.base.cra_blocksize = 1;
-- 
1.9.1
