Return-Path: <kernel-hardening-return-12926-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+y1KiW8UJWPSemLGjibtqDOBbDhoFz2eiR35DqxNBaJLdu2JTs1XFub3br885aEqz17ri8
ARC-Seal: i=1; a=rsa-sha256; t=1523282176; cv=none;
        d=google.com; s=arc-20160816;
        b=BBJTTmLy3UOVty5bZwbhXYuCLc86HX5rsAymMm7a9RroVAARWPYbTGxDhHQHEOKgXO
         xk//RMkUdO7zcbFVBCXtwu1KSs8IXt1wFIZKGt0jiPck675VeVQUvDPYBOIk5EXAJcWq
         z+9+3983iYpoXabVk3HMgmB/lCHWXP/qw+R0MivEY4ZbEdnWm3firGR+FAWdj0L1ampx
         inPp6bk8jeiVu21Bl22D3KyLwQiAVX7l3oFhIwKPlVNS8W2RIv3m/RqX+WghFpx3Rdwq
         LGEDGLKZ/D9tAjzjIuMKS7sLgvkGUO/osXuOA2INCaqj+uEqOQp1xyhXI0kpREgtiJPM
         NMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=hL2osvmSw3S+5hhTzGihfdv/1tHo1fUxHNZ4oL5PviA=;
        b=CrmyLJLLhPtpCcKKpyL+NGXJ2iP63yMd5THgXblmz+e/lPGiO61EGhZ0+utrl4eNfV
         9vmCf0FymnBvDOwxojk/4QxfPG/LX4kHMnfs/9ZnG2I2O2IGTfzmfXhpWm8a01eO0Igo
         1gIHlub9pnbJwfTtXo3/MmC9Uq3/0PoubliEhw5bEop2QYMzp14a6LvsvD9IXZtO6fI6
         RzxzynH2FD977WzU5sLb+78AWsJKGbcm4iwjZKMMxPpy9j/kY94fT/W3tiLd/5zxMuUC
         gLrE+4xSylwm+VOBzHT6FcBkiFg1b+Ocx8fkEKgsA3MDZKqIcWppLzu1qQ0NvHqNeFo5
         C6jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KFkpUjSz;
       spf=pass (google.com: domain of kernel-hardening-return-12926-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12926-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KFkpUjSz;
       spf=pass (google.com: domain of kernel-hardening-return-12926-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12926-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v2 1/2] crypto: api - laying defines and checks for statically allocated buffers
Date: Mon,  9 Apr 2018 15:54:46 +0200
Message-Id: <1523282087-22128-2-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282087-22128-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277131780850504?=
X-GMAIL-MSGID: =?utf-8?q?1597277131780850504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation for the removal of VLAs[1] from crypto code.
We create 2 new compile-time constants: all ciphers implemented
in Linux have a block size less than or equal to 16 bytes and
the most demanding hw require 16 bytes alignment for the block
buffer.
We also enforce these limits in crypto_check_alg when a new
cipher is registered.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/algapi.c         | 10 ++++++++++
 include/crypto/algapi.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 2a0271b..c0755cf 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <crypto/algapi.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fips.h>
@@ -59,6 +60,15 @@ static int crypto_check_alg(struct crypto_alg *alg)
 	if (alg->cra_blocksize > PAGE_SIZE / 8)
 		return -EINVAL;
 
+	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
+			       CRYPTO_ALG_TYPE_CIPHER) {
+		if (alg->cra_alignmask > MAX_CIPHER_ALIGNMASK)
+			return -EINVAL;
+
+		if (alg->cra_blocksize > MAX_CIPHER_BLOCKSIZE)
+			return -EINVAL;
+	}
+
 	if (alg->cra_priority < 0)
 		return -EINVAL;
 
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 1aba888..bd5e8cc 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -17,6 +17,14 @@
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
 
+/*
+ * Maximum values for blocksize and alignmask, used to allocate
+ * static buffers that are big enough for any combination of
+ * ciphers and architectures.
+ */
+#define MAX_CIPHER_BLOCKSIZE		16
+#define MAX_CIPHER_ALIGNMASK		15
+
 struct crypto_aead;
 struct crypto_instance;
 struct module;
-- 
1.9.1
