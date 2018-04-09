Return-Path: <kernel-hardening-return-12923-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48HyvUVTJba5PcJBfJbbpC9jT2IDPyFwGw9nBLmKoYXEm9GZ9sEmmz7SJji47O6EJJITy8e
ARC-Seal: i=1; a=rsa-sha256; t=1523282144; cv=none;
        d=google.com; s=arc-20160816;
        b=gnY7vOzcj423TrJTEDSxA9ybxErS+BHxrdMS9rQSulq607UJ93xt4G3gUXRfYTy4kC
         4ZIBgN0z3UIbu0KHAfF2srK5tsv52THUioUEbtRRGv21iLxmVXcLu+p9y0O+GbSRW930
         IWSk+P/4u1AP9clCemipTw2Xb3VDARAKzhefKrhO3pVZg+pWI06CdEuo07BFhLhuIaHF
         hQBbU/k/BfiI6o1HKfAiiQZ7aynjk4G9a660XnZP7hO9azf+43iRpiI0lsu8c+w5sIgn
         IYqkbWCZg69i9hexW7dYps5OHPjqLYFu507iPuLWUukpfdRdWYodtCPDV2zMsDiFOr+5
         WPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=bvfZVgukrG4Uz/3K/kgiuiCeoBiYKZFn3z8Tr50BqHA=;
        b=n3sFMfwkY+mpOS7RsVxFYcnCuHGOm0rZL+IPOqld+eE2sRaUWeSCPmJx910iklfwQx
         9p+MhpyMNi3rp3LdyPcyOOxc09gqoe+CVGMvg6jfucZ2a6xoMltwjM7BiCZmXO2z0jf+
         9chlcppwjrh0/bhHVnV4qqbGCTfwCPAskqyIhY3Y9JiCv50wRpsOUCCAWLUgDHPvpFhO
         dn5D3Ya9eVRd6FVGV4ZhjRFfqSlCWqG4zooe3NcCcuXxaHuTvQWs/y6HLfRICCmbUsZm
         a0viAw/DWgh4Zkxup06Q+6hazIiOhLcf00GI/UNwu7ZVIRxQ7S1haBeQ63cJ9+75PNp+
         ZOKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aCA0tdrK;
       spf=pass (google.com: domain of kernel-hardening-return-12923-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12923-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aCA0tdrK;
       spf=pass (google.com: domain of kernel-hardening-return-12923-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12923-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 5/6] crypto: cts - avoid VLA use
Date: Mon,  9 Apr 2018 15:54:03 +0200
Message-Id: <1523282044-22075-6-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277098191964143?=
X-GMAIL-MSGID: =?utf-8?q?1597277098191964143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We avoid 2 VLAs[1] by always allocating MAX_BLOCKSIZE*2 bytes.
We also check the selected cipher at instance creation time, if
it doesn't comply with these limits, the creation will fail.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/cts.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/crypto/cts.c b/crypto/cts.c
index 4773c18..12e6bd3 100644
--- a/crypto/cts.c
+++ b/crypto/cts.c
@@ -50,6 +50,7 @@
 #include <crypto/scatterwalk.h>
 #include <linux/slab.h>
 #include <linux/compiler.h>
+#include "internal.h"
 
 struct crypto_cts_ctx {
 	struct crypto_skcipher *child;
@@ -104,7 +105,7 @@ static int cts_cbc_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct skcipher_request *subreq = &rctx->subreq;
 	int bsize = crypto_skcipher_blocksize(tfm);
-	u8 d[bsize * 2] __aligned(__alignof__(u32));
+	u8 d[MAX_BLOCKSIZE * 2] __aligned(__alignof__(u32));
 	struct scatterlist *sg;
 	unsigned int offset;
 	int lastn;
@@ -183,7 +184,7 @@ static int cts_cbc_decrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct skcipher_request *subreq = &rctx->subreq;
 	int bsize = crypto_skcipher_blocksize(tfm);
-	u8 d[bsize * 2] __aligned(__alignof__(u32));
+	u8 d[MAX_BLOCKSIZE * 2] __aligned(__alignof__(u32));
 	struct scatterlist *sg;
 	unsigned int offset;
 	u8 *space;
@@ -359,6 +360,9 @@ static int crypto_cts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (crypto_skcipher_alg_ivsize(alg) != alg->base.cra_blocksize)
 		goto err_drop_spawn;
 
+	if (alg->base.cra_blocksize > MAX_BLOCKSIZE)
+		goto err_drop_spawn;
+
 	if (strncmp(alg->base.cra_name, "cbc(", 4))
 		goto err_drop_spawn;
 
-- 
1.9.1
