Return-Path: <kernel-hardening-return-12880-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49yXcG9PFfZA5aOrleFox5Cnp6XhvMBia7fouuPMcc3TsM3gP6Iv21M7/KBFxvNlCvbPBk1
ARC-Seal: i=1; a=rsa-sha256; t=1523126399; cv=none;
        d=google.com; s=arc-20160816;
        b=NZHlK+L/uOeQlZp5F9l6m6b2Q3+vYj5XucQ6Gyr1fSeydCFjME8O3hX6NVUi7ArB/i
         3P4LA4Q0wOgWZIc5mcqPFJERt3vOuF7iEKPFSYD9JaorB0v/7r+iRHKqUQ0EO6gw9z7j
         vDxi5Vib4GqlpTY9lLwWUvQFFlq/IB1upVbpG1GZ46oRkiZNIQmApRmr9zj8xfufk9pl
         1JIj1ipJT0WZaNu0HzD4ObYo55Z/eEQXotSOpFKm73C2KP2FJoCd6y5UYwrU0WAxOlvT
         5wAutrZ+Xb5siWIvqbc+Vq702cgeBzuaG9DkY4EDK7tCXJQut+KYLDecEZ+gJJ+jkoFY
         V3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=otcFk/LhYCI6+Eka1h1DNCCDW9Ubad/bpWI6UKakoZM=;
        b=DbSDX4c9yXxbDWWkt9kzgI3BK1iIgQc3bFdqx3nkwOTyJr/LMhmphYWMpjpNHPi0YL
         TE8LskKiT+BK7GCzB6fWblGDFXE2iKJs4v0THei6BFHvoRMYsBqz7/HJVBgMW1ErFncx
         GXSrZRL/f9HdqmXa/2V7Ssy3gj3MpnQaMBjzdpaFp8iBP+cLtca0NHk7A/R6ehdFwdKn
         6fOYRRXWPEWbCryAUclGIV0dMARPiqD9aV5bwImTWynXCVEPJHPHP1NwQvvVOPTFhfic
         BUuw482eyESr6lxb5899ZK1YaJPNAYfwcStB79ii2KHLWroS7K5bomfkULW+X4j+YfCQ
         4cJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IF08NNkU;
       spf=pass (google.com: domain of kernel-hardening-return-12880-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12880-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IF08NNkU;
       spf=pass (google.com: domain of kernel-hardening-return-12880-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12880-gregkh=linuxfoundation.org@lists.openwall.com;
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
Date: Sat,  7 Apr 2018 20:38:21 +0200
Message-Id: <1523126303-23205-5-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113787790138764?=
X-GMAIL-MSGID: =?utf-8?q?1597113787790138764?=
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
