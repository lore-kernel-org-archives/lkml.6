Return-Path: <kernel-hardening-return-12882-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/k13Z0Yf/GP5T3EfH0GHBDglO/NZgsL2vqHUsbjd7hAKh6V9Cwqdj3QM7ni4nthJ8WdsAm
ARC-Seal: i=1; a=rsa-sha256; t=1523126418; cv=none;
        d=google.com; s=arc-20160816;
        b=FcI0IrtOoKhIL+Bmk13Jh4Fj8WrY7k+KDISLQg43bFPURVC4CtiCGTQBZxMK307Man
         X8kSO42w5ypgc6j6GRRdSzhc3yi3uoENInaknaHOIhlf4nQSWgz5oAoHWWfX4jCMaoEI
         OZT5nYgBH25+hCGMRCJpray73d5068HwPt3Tc+5xv6qrZWYedhIUYmLTs0FMg1YbfAOa
         TQO0U0aQREatOetROGDxdOAb0bJx/cM+xzaM8pwn7LCd0C4J95SyNAdyMKUnHtKKYCo7
         MmQ8+0KFGJqTfc9/VF2vNTnOB8px8FtZqFaMgWeHbPsPYrjz7z+ecC4JBQ71uoQiegUQ
         aV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=bvfZVgukrG4Uz/3K/kgiuiCeoBiYKZFn3z8Tr50BqHA=;
        b=g9GGSF3k1Nqz9/lcIpkg2RXstKDmwFthvSV9TJyV1dcN0ZtahfcyGhbvCvE33zLOx0
         At7BDZzTPKiECEYTh1AolslXVpQJFc4SEnnRQu0Z09tbBu+mnvV26yY9hUEKDWZgVnD3
         OCqS2rO7beF9Y0nRUAnlmXT1IzDzi9gsMqAFUCI423pzdYobkBGAB5iXcQMcTr1hyzsg
         TZqrj3IaiXzX/WzfFv0YxWealDI0cpDI2PKvdsayFnBa8++fzgpF/f/+Nvd4tnWNFUoK
         PYMkGJiap3eQ97DwMNMSVcsJ2RF64RJhZCkcvjsoGOH7F7Lw3UOcNOGYyUjp69EEb5mk
         1+qw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CkE8ofFR;
       spf=pass (google.com: domain of kernel-hardening-return-12882-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12882-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CkE8ofFR;
       spf=pass (google.com: domain of kernel-hardening-return-12882-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12882-gregkh=linuxfoundation.org@lists.openwall.com;
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
Date: Sat,  7 Apr 2018 20:38:22 +0200
Message-Id: <1523126303-23205-6-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113807116019745?=
X-GMAIL-MSGID: =?utf-8?q?1597113807116019745?=
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
