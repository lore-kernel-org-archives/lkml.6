Return-Path: <kernel-hardening-return-12922-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48SqzBCowjQH/MXNE+isF29y/qotxrlnwgdl4q47fEqeFiCrKyQKhVg2emrDNXZheiHq37X
ARC-Seal: i=1; a=rsa-sha256; t=1523282133; cv=none;
        d=google.com; s=arc-20160816;
        b=KS4gzwkC9h7ArEcgd5AVggR6xGpoCDAVNIbvQAkOOocpgvWMgx5lHT0rQy9f6riCO5
         O6/Y/wSq/Is1dY++DJbzqOonY2cVNIhHw40zvfiNiRIocw39eEgv+y4s1TS20oNZbPwl
         jVqwdkWsS0v5qrcXx0JHv/ivycMVKwvJzDnOPDlfK0ieHniIF9qMM7Qqo5Km8WM0lNvv
         L6rsGXj6Qblr87umdb3XnKasbWvx6KtOH1dzNe4uCDUPnJ807rLymvdrM35/B3zQCIp6
         NiMkfWP4oSw/3tjIs13YREwVidn6+LxU+V+a+efrezffHBj3QowPtg3/Ca3NVm/z6abi
         QW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=otcFk/LhYCI6+Eka1h1DNCCDW9Ubad/bpWI6UKakoZM=;
        b=OanVRHOZ5S7ieHcFHXoTAoNj0qNQ3VeC9r9IQZXUt+9GkeoDk1xo545Y3t615ptADd
         +zYW1EOSqq1gbLNAGcKCJhO9AwXFNEdvitRy9MyzNc5Jvnxbf0jr57Xtmcq/+j3H6YuZ
         ltXYIXSf8I0oj2PuFlK2IkCq9H/aGVIl4JOSOkeWdU7CkDvCgHgNl0sk+tyJCCBSBQ/5
         sPGfmhO83yAusG05Jj2euQWMIeT58cW4GUVjyY5J7opbrjgVTCBK14Hm7JsQVz51sUIr
         RdKDDqzx/lvHdh5SbVlLxVOxteAYq4FLDebPhCEZFYK34UgGOk3bKxgslm1ctQlnUzNX
         aXeA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tbVjcGKY;
       spf=pass (google.com: domain of kernel-hardening-return-12922-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12922-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tbVjcGKY;
       spf=pass (google.com: domain of kernel-hardening-return-12922-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12922-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 4/6] crypto: pcbc - avoid VLA use
Date: Mon,  9 Apr 2018 15:54:02 +0200
Message-Id: <1523282044-22075-5-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277086910893506?=
X-GMAIL-MSGID: =?utf-8?q?1597277086910893506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We avoid 2 VLAs[1] by always allocating MAX_BLOCKSIZE bytes.
We also check the selected cipher at instance creation time, if
it doesn't comply with these limits, the creation will fail.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/pcbc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/crypto/pcbc.c b/crypto/pcbc.c
index d9e45a9..797da2f 100644
--- a/crypto/pcbc.c
+++ b/crypto/pcbc.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/compiler.h>
+#include "internal.h"
 
 struct crypto_pcbc_ctx {
 	struct crypto_cipher *child;
@@ -72,7 +73,7 @@ static int crypto_pcbc_encrypt_inplace(struct skcipher_request *req,
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
 	u8 *iv = walk->iv;
-	u8 tmpbuf[bsize];
+	u8 tmpbuf[MAX_BLOCKSIZE];
 
 	do {
 		memcpy(tmpbuf, src, bsize);
@@ -144,7 +145,7 @@ static int crypto_pcbc_decrypt_inplace(struct skcipher_request *req,
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
 	u8 *iv = walk->iv;
-	u8 tmpbuf[bsize] __aligned(__alignof__(u32));
+	u8 tmpbuf[MAX_BLOCKSIZE] __aligned(__alignof__(u32));
 
 	do {
 		memcpy(tmpbuf, src, bsize);
@@ -251,6 +252,10 @@ static int crypto_pcbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (err)
 		goto err_drop_spawn;
 
+	err = -EINVAL;
+	if (alg->cra_blocksize > MAX_BLOCKSIZE)
+		goto err_drop_spawn;
+
 	inst->alg.base.cra_flags = alg->cra_flags & CRYPTO_ALG_INTERNAL;
 	inst->alg.base.cra_priority = alg->cra_priority;
 	inst->alg.base.cra_blocksize = alg->cra_blocksize;
-- 
1.9.1
