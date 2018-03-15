Return-Path: <kernel-hardening-return-12628-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvXM0VzLMD5x5DCyRqnzxbFhSt23qlSIgLMzkIGK/vxV7eQ7fTbb/GIa6riy4EZJOqy7632
ARC-Seal: i=1; a=rsa-sha256; t=1521112762; cv=none;
        d=google.com; s=arc-20160816;
        b=meZCumKF2ql4CO84J/jBxTRwsem+yZ5gRQtSwnQ8cJUjqeu6oHc6oQYW6V0Zo1CF62
         s49K3EizXZdhISVNOWAIOotE5AkAQLdJ1Gi5zk87pX23SEeqqfV1hbnvy66fw3A9I/OQ
         ohiUqe6LFSwX6V4+yrBcIEIlmJytpifQsHQJ7rlE6l6DiNATg/oqJ2eUH7qeozFg2iRb
         wEqPtdGzOQl7vDU0BTXwGHxlve9eB1r31iQ4qyP9bAKQigE/D7S+4zvyPpBK5SjC5z0B
         P+DQ5AuTNQp8m5zkXIMTjQmNyeK1SkwBzkZlwPiVLoDcNrNtb9/7eezbu1YGwI8Fy2b1
         GHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=CCOraF1ENi0Qya1aqRcFbMsdYxqwQG8l0x5jyIxFoSE=;
        b=ZxQh5875t2hZuxH58wq2gs9Yp+0W8BXkK3tWa2yyj1Daz6nX2wfdFzhvehzBv2J3vd
         yn70VG5N/OKECAW85UVvZu6CDiFG16n1t2g8YnQ4gvxD5b00RRNqQr39U0tdD+e0STRp
         WoMzUYnsP5HVLf1iFmQIFhWxWLM4SSBJ7SGCdTjkL2XaWAYVMfsV4gHV9w54Xsdmy+IT
         5eIxZC1LWZPIYa1kmpMqCndsRV+oqBOuCXQE2qhJTSjoMihDJjVI3obUEqAN/YN2tIVO
         TjD4OL21IoC+i1wP5iMNHM/y50+kpkkNm2L7zZZ/RFDoHfoadV4Iq8sFvmO+butLZUF8
         AWnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L094oNTW;
       spf=pass (google.com: domain of kernel-hardening-return-12628-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12628-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=L094oNTW;
       spf=pass (google.com: domain of kernel-hardening-return-12628-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12628-gregkh=linuxfoundation.org@lists.openwall.com;
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
	Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] crypto: ctr - avoid VLA use
Date: Thu, 15 Mar 2018 12:18:58 +0100
Message-Id: <1521112738-13250-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595002335438491834?=
X-GMAIL-MSGID: =?utf-8?q?1595002335438491834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All ciphers implemented in Linux have a block size less than or
equal to 16 bytes and the most demanding hw require 16 bytes
alignment for the block buffer.
We avoid 2 VLAs[1] by always allocating 16 bytes with 16 bytes
alignment, unless the architecture supports efficient unaligned
accesses.
We also check the selected cipher at instance creation time, if
it doesn't comply with these limits, we fail the creation.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/ctr.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/crypto/ctr.c b/crypto/ctr.c
index 854d924..2c9f80f 100644
--- a/crypto/ctr.c
+++ b/crypto/ctr.c
@@ -21,6 +21,14 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
+#define MAX_BLOCKSIZE 16
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define MAX_ALIGNMASK 15
+#else
+#define MAX_ALIGNMASK 0
+#endif
+
 struct crypto_ctr_ctx {
 	struct crypto_cipher *child;
 };
@@ -58,7 +66,7 @@ static void crypto_ctr_crypt_final(struct blkcipher_walk *walk,
 	unsigned int bsize = crypto_cipher_blocksize(tfm);
 	unsigned long alignmask = crypto_cipher_alignmask(tfm);
 	u8 *ctrblk = walk->iv;
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
@@ -106,7 +114,7 @@ static int crypto_ctr_crypt_inplace(struct blkcipher_walk *walk,
 	unsigned int nbytes = walk->nbytes;
 	u8 *ctrblk = walk->iv;
 	u8 *src = walk->src.virt.addr;
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 
 	do {
@@ -206,6 +214,14 @@ static struct crypto_instance *crypto_ctr_alloc(struct rtattr **tb)
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
