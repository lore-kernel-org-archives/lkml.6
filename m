Return-Path: <kernel-hardening-return-12833-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/I8vZEhM8sfnSaUcaLEIO3bot9LcOANoK9Z7MnWPe8ktywKyXzOnkjP0LycnEsyidZJ19G
ARC-Seal: i=1; a=rsa-sha256; t=1522400037; cv=none;
        d=google.com; s=arc-20160816;
        b=sY7aZzTlIPjnr4aL+O7fEPXjcdRtzMK8L02h/m2POdMSmkHfDkjau8AIbYixHWV9Mj
         iX/+rhsbMLXtv6hMQ9OYyBlIoFlgb7xLN+ecc9xM2bsI6tERj7hUh2EmoCsKg6VJ/+Bx
         0v1VdlgRySSUUzgCdIvgPS9RLKRB4deradiEFb5zrL7boUaWdd0yFHMQyaDlZOO1k0dh
         V2U8kMSCy4Ddu9MN7K+3ZqcmFxCjkKcg1rAILUnHDSXKnSlR/bbDLr7KNcUv0zeZD5EM
         kqlPKNJ9tvdkYXoYUCn98K8KO6Gz7Yhi+AEpq9qzTgv5AC9iZLT5cqRtG3MUUiscKaff
         cTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=pDoNOVwK7qAVEtx0ZUWXAmQXO3jwjzFr/1BD4vPGBZ4=;
        b=0JjpGdmiKrG/Nj/+f5uU6EVMwzOWEu+wWRXTrmHFGSLZhULiGPKipnzSjdR1Yep9ky
         hFJoOQvDHhaMrkF+jP28v9HpRn6o/8By6g4sr0UwcmMD83EIb6imiv5apxCZOk3QdjA0
         AEwZgfgBKQONzxpjeS01X0/06AP/FlW1gLoqZc+2lijUGLpU5fFSI+oe/Vs/hWqJYnnx
         dxnc6cUEiHsYlm16Qw6RmK6QDWw1ACLPStLJQR66VUuIHTKtaDHIqk4LFV9yivqe9qO9
         LUF+PzKfiIwWXJFWn+z44jyB5mHuPzVaQ9ZoB7RsCgGBA38Lw4AVzANujq21e1kZbuY5
         0V7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QxF86thL;
       spf=pass (google.com: domain of kernel-hardening-return-12833-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12833-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QxF86thL;
       spf=pass (google.com: domain of kernel-hardening-return-12833-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12833-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [v3] crypto: ctr - avoid VLA use
Date: Fri, 30 Mar 2018 10:53:26 +0200
Message-Id: <1522400006-8859-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596352141229362174?=
X-GMAIL-MSGID: =?utf-8?q?1596352141229362174?=
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
 crypto/ctr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/crypto/ctr.c b/crypto/ctr.c
index 854d924..49c469d 100644
--- a/crypto/ctr.c
+++ b/crypto/ctr.c
@@ -21,6 +21,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
+#define MAX_BLOCKSIZE 16
+#define MAX_ALIGNMASK 15
+
 struct crypto_ctr_ctx {
 	struct crypto_cipher *child;
 };
@@ -58,7 +61,7 @@ static void crypto_ctr_crypt_final(struct blkcipher_walk *walk,
 	unsigned int bsize = crypto_cipher_blocksize(tfm);
 	unsigned long alignmask = crypto_cipher_alignmask(tfm);
 	u8 *ctrblk = walk->iv;
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
@@ -106,7 +109,7 @@ static int crypto_ctr_crypt_inplace(struct blkcipher_walk *walk,
 	unsigned int nbytes = walk->nbytes;
 	u8 *ctrblk = walk->iv;
 	u8 *src = walk->src.virt.addr;
-	u8 tmp[bsize + alignmask];
+	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
 	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 
 	do {
@@ -206,6 +209,14 @@ static struct crypto_instance *crypto_ctr_alloc(struct rtattr **tb)
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
