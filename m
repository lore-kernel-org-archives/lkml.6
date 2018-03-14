Return-Path: <kernel-hardening-return-12594-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvCqQXVxQAWt0dx1hjvmVvCOEd9bfN8SJvYzWQKUWPrs6qmYJ0dcVo6UzkUZESbJVsXYAAz
ARC-Seal: i=1; a=rsa-sha256; t=1521033475; cv=none;
        d=google.com; s=arc-20160816;
        b=yx9d7z0Ic4F88jG9gIb1e6HJCDRShKg0EulR7cvRDk/4tSoBOgBeUuB3OrKAYwAJ/l
         ce9n/FFR/mvWK9ApNBQDcGKwn83ve/ir9Yk0TIsUJf8zxHxUjv4uifQUEXUCoIkb5Zfj
         LlKEjLE1DlrPIG9/zSZlsIrtt1HdMryvEo/hwqzeWG8H6k2Tr6lIteRAR/XxKmmQvFWu
         iZk/DnzU55+TDpS7vl5GrFfSRz6dxvOStf8q5EvDhW94G0Ox4XTpPLTxYEKHzOWI1vsO
         SRuc0n7ZJq2qMtoPtNKZrB81j9yJ0hQ7ozM5P0Qxm/cy/NR5aAm8/HIKyFdchqPpksFy
         sT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=iITzaUcfAaEIVDvCIBFgWh/44XucP90daGxl2vB0D0M=;
        b=W7I3m1Nfv4LcE1iDk4E8Ls9FEioN9kTEC/Z0GI80CkQS2A2y4bt0gJnWUqoLL7JMMC
         nL+rA4mbuKheIDyWYcqiX9BSHxlO4B1mwNgO8dJzgnLN21Hpp6wtf3yNiIa6SH+C46hR
         1Q3WPyOBaCOYqt+KAzdAUtCep66qAbuL3spoZqlx8gLZ2JS1YQ7tmclWuTzYy8xx9GnP
         eDwg1SADQlQAyisvCZPjrB/GeLX8iNzjJNxXSsVCnmplkjY1gjD5T2agVLy0t1kFUiGW
         2PBFoTpsVXz8ksEe3A7urpTvpqIUzrB/6lSZ/3WONOAixCqj7pENc8tuFa4OeAE86IsY
         roMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Az9dyYXA;
       spf=pass (google.com: domain of kernel-hardening-return-12594-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12594-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Az9dyYXA;
       spf=pass (google.com: domain of kernel-hardening-return-12594-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12594-gregkh=linuxfoundation.org@lists.openwall.com;
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
	Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [PATCH] crypto: ctr: avoid VLA use
Date: Wed, 14 Mar 2018 14:17:30 +0100
Message-Id: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1594919197404593745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All ciphers implemented in Linux have a block size less than or
equal to 16 bytes and the most demanding hw require 16 bits
alignment for the block buffer.
We avoid 2 VLAs[1] by always allocating 16 bytes with 16 bits
alignment, unless the architecture support efficient unaligned
accesses.
We also check, at runtime, that our assumptions still stand,
possibly dynamically allocating a new buffer, just in case
something changes in the future.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---

Notes:
    Can we maybe skip the runtime check?

 crypto/ctr.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/crypto/ctr.c b/crypto/ctr.c
index 854d924..f37adf0 100644
--- a/crypto/ctr.c
+++ b/crypto/ctr.c
@@ -35,6 +35,16 @@ struct crypto_rfc3686_req_ctx {
 	struct skcipher_request subreq CRYPTO_MINALIGN_ATTR;
 };
 
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define DECLARE_CIPHER_BUFFER(name) u8 name[16]
+#else
+#define DECLARE_CIPHER_BUFFER(name) u8 __aligned(16) name[16]
+#endif
+
+#define CHECK_CIPHER_BUFFER(name, size, align)			\
+	likely(size <= sizeof(name) &&				\
+	       name == PTR_ALIGN(((u8 *) name), align + 1))
+
 static int crypto_ctr_setkey(struct crypto_tfm *parent, const u8 *key,
 			     unsigned int keylen)
 {
@@ -52,22 +62,35 @@ static int crypto_ctr_setkey(struct crypto_tfm *parent, const u8 *key,
 	return err;
 }
 
-static void crypto_ctr_crypt_final(struct blkcipher_walk *walk,
-				   struct crypto_cipher *tfm)
+static int crypto_ctr_crypt_final(struct blkcipher_walk *walk,
+				  struct crypto_cipher *tfm)
 {
 	unsigned int bsize = crypto_cipher_blocksize(tfm);
 	unsigned long alignmask = crypto_cipher_alignmask(tfm);
 	u8 *ctrblk = walk->iv;
-	u8 tmp[bsize + alignmask];
-	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
 	unsigned int nbytes = walk->nbytes;
+	DECLARE_CIPHER_BUFFER(tmp);
+	u8 *keystream, *tmp2;
+
+	if (CHECK_CIPHER_BUFFER(tmp, bsize, alignmask))
+		keystream = tmp;
+	else {
+		tmp2 = kmalloc(bsize + alignmask, GFP_ATOMIC);
+		if (!tmp2)
+			return -ENOMEM;
+		keystream = PTR_ALIGN(tmp2 + 0, alignmask + 1);
+	}
 
 	crypto_cipher_encrypt_one(tfm, keystream, ctrblk);
 	crypto_xor_cpy(dst, keystream, src, nbytes);
 
 	crypto_inc(ctrblk, bsize);
+
+	if (unlikely(keystream != tmp))
+		kfree(tmp2);
+	return 0;
 }
 
 static int crypto_ctr_crypt_segment(struct blkcipher_walk *walk,
@@ -106,8 +129,17 @@ static int crypto_ctr_crypt_inplace(struct blkcipher_walk *walk,
 	unsigned int nbytes = walk->nbytes;
 	u8 *ctrblk = walk->iv;
 	u8 *src = walk->src.virt.addr;
-	u8 tmp[bsize + alignmask];
-	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
+	DECLARE_CIPHER_BUFFER(tmp);
+	u8 *keystream, *tmp2;
+
+	if (CHECK_CIPHER_BUFFER(tmp, bsize, alignmask))
+		keystream = tmp;
+	else {
+		tmp2 = kmalloc(bsize + alignmask, GFP_ATOMIC);
+		if (!tmp2)
+			return -ENOMEM;
+		keystream = PTR_ALIGN(tmp2 + 0, alignmask + 1);
+	}
 
 	do {
 		/* create keystream */
@@ -120,6 +152,8 @@ static int crypto_ctr_crypt_inplace(struct blkcipher_walk *walk,
 		src += bsize;
 	} while ((nbytes -= bsize) >= bsize);
 
+	if (unlikely(keystream != tmp))
+		kfree(tmp2);
 	return nbytes;
 }
 
@@ -147,8 +181,8 @@ static int crypto_ctr_crypt(struct blkcipher_desc *desc,
 	}
 
 	if (walk.nbytes) {
-		crypto_ctr_crypt_final(&walk, child);
-		err = blkcipher_walk_done(desc, &walk, 0);
+		err = crypto_ctr_crypt_final(&walk, child);
+		err = blkcipher_walk_done(desc, &walk, err);
 	}
 
 	return err;
-- 
1.9.1
