Return-Path: <kernel-hardening-return-12878-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/JbS6ClNF3rlCDOxVWAW64CJEfe5KdrZFGlbQkjyeugJS0myHfyh6iv4pAo1BhZ03xPY6O
ARC-Seal: i=1; a=rsa-sha256; t=1523126374; cv=none;
        d=google.com; s=arc-20160816;
        b=bWZHnozrHXAQi3KcjYe66DtLQ+T3smb63LZ6czb8eqM9Wc4sVCgn/+Uyj6xKhUgA/r
         ntCeSEq/E05fNEma05sNhOhe7ASgDWLtj2wETZNn/LCpJRCAdQN2wcstfFmoJf5G87kY
         WS+yfaetlXStSlpQrIf+YXHK03XSIrQcTdYaWodGu/qnhMzTN39sbmV/hVrd2etjMJJ1
         kG8HVN4o7RGcza0T9Cg3h0lFF3rF1lwVaBWHdTG/boMrvhWToMAITHXONukcNBi0JTwz
         8o2VC3P0t8Hah4la8y2Z+XeAK2ATxopPmXAQqzTzt/sSJ/NbQfiu49YDHRr9ou7FfvDq
         7bQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=oZJHlz74leLbB95syiNmkrgCZhugYvoNKD0PdVRJfUI=;
        b=LsVk8JCBPykY1lv3Pkdpx/5FHkPz4OAhtp9ujT4LTo7Jz+UM1Xd9qeuuLJZ2qzeyAw
         2YmC6jD8meQ6VSbnmH75u0Ehs/ujb9F+y1o+Thgv9ZcOh3aPJLwMMd64i5g11ZX4LIyd
         chJSjJlUwk/90r77occz9Ijg630hJCJERw0Q5NUhoxYgVt8RpWtTbOdaAlwPuiRcRRCQ
         YoSBmIJSLVBsQGWsni5yb1StEaFerEDGOIs0xGTG1z11x6mMIT/0XpQLXBWSTdL5mfqZ
         S9V2oy9F2Kg0EPuRZ3v0g5uu5OyvlKkliOQa0WyF/4wAh/B1LV3eoNo54TELjsDrkH/8
         nKkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LTYSPFeE;
       spf=pass (google.com: domain of kernel-hardening-return-12878-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12878-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LTYSPFeE;
       spf=pass (google.com: domain of kernel-hardening-return-12878-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12878-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 2/6] crypto: ctr - avoid VLA use
Date: Sat,  7 Apr 2018 20:38:19 +0200
Message-Id: <1523126303-23205-3-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113761628441569?=
X-GMAIL-MSGID: =?utf-8?q?1597113761628441569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We avoid 2 VLAs[1] by always allocating MAX_BLOCKSIZE +
MAX_ALIGNMASK bytes.
We also check the selected cipher at instance creation time, if
it doesn't comply with these limits, the creation will fail.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/ctr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/crypto/ctr.c b/crypto/ctr.c
index 854d924..ce62552 100644
--- a/crypto/ctr.c
+++ b/crypto/ctr.c
@@ -20,6 +20,7 @@
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include "internal.h"
 
 struct crypto_ctr_ctx {
 	struct crypto_cipher *child;
@@ -58,7 +59,7 @@ static void crypto_ctr_crypt_final(struct blkcipher_walk *walk,
 	unsigned int bsize = crypto_cipher_blocksize(tfm);
 	unsigned long alignmask = crypto_cipher_alignmask(tfm);
 	u8 *ctrblk = walk->iv;
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
@@ -106,7 +107,7 @@ static int crypto_ctr_crypt_inplace(struct blkcipher_walk *walk,
 	unsigned int nbytes = walk->nbytes;
 	u8 *ctrblk = walk->iv;
 	u8 *src = walk->src.virt.addr;
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 
 	do {
@@ -206,6 +207,14 @@ static struct crypto_instance *crypto_ctr_alloc(struct rtattr **tb)
 	if (alg->cra_blocksize < 4)
 		goto out_put_alg;
 
+	/* Block size must be <= MAX_BLOCKSIZE. */
+	if (alg->cra_blocksize > MAX_BLOCKSIZE)
+		goto out_put_alg;
+
+	/* Alignmask must be <= MAX_ALIGNMASK. */
+	if (alg->cra_alignmask > MAX_ALIGNMASK)
+		goto out_put_alg;
+
 	/* If this is false we'd fail the alignment of crypto_inc. */
 	if (alg->cra_blocksize % 4)
 		goto out_put_alg;
-- 
1.9.1
