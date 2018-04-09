Return-Path: <kernel-hardening-return-12919-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+JaW98UXoQYIAlFp0qlTUr1onMqerCQfKvksPw8NXFm2ciKFgnu5gNE/H9C7VtJV/Xs4SX
ARC-Seal: i=1; a=rsa-sha256; t=1523282102; cv=none;
        d=google.com; s=arc-20160816;
        b=gWglWk1XUQcp0Uq1kEqi0xo5Z4gnROU2QOlto8tEQ3bZXicvfDuUnJu+X7/uszDICS
         m4T3YRQazWiHn4NInhpwLRTEu5M2IiVteVb2HUABLyL9xyT95GJ37IIlMmQ5zMb1JyqM
         +WpMQxDPYL5zrBcwOw4XMOpT4tDGgqjFIDjXfAzDnF3r2+lib7bCbwjama2CRW9/Aopx
         928k1GCthz9Bjw7aamkFEzXP3LumqFNHtDdzq4SDybq5mJhfYIiCLq+fqJSV32ehWMfL
         ZJ695UmY6XXShqCJGY9VIzeWahTP+tVYvEr5jXlsHKfFvQ6y6t6VvOntKrwwfcAqspG8
         p+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=830I2FtaCI7kkwpzHkb1D64AA5JBuPJRaD87G/HzoCY=;
        b=WnUbRt+Fu5NofYzsuYgQgSiFkiGsujl+yTi1c20zk9ZYyY/CVT0LcLGCcIZD22Gctm
         UTp56idsfwMm2UoWLkvM4D4PS0PLRVZu1ul+Lr124Zmxfj26ilexML/mLKYjqP/Yyu+o
         5pAOB1gbxfXxfbb1aPD9OaFJUaYIo9IEkhOLC5lIvcJJ/x/55mb/bwquSoFFrqB+nesJ
         JaQLgHVNOee1e5J5xDLyNpiJeOgpYHTvGYGz8GgxepS54+8XIWp795aBXz3mU1lZW+s1
         pQyJBvlnPkrr4+giY8Kw80zhJ6AiKLpg8Jse80TO+D67BYeITKplRevE4VwmCn5MbtUG
         AOMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fCI23bJw;
       spf=pass (google.com: domain of kernel-hardening-return-12919-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12919-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fCI23bJw;
       spf=pass (google.com: domain of kernel-hardening-return-12919-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12919-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 1/6] crypto: api - laying macros for statically allocated buffers
Date: Mon,  9 Apr 2018 15:53:59 +0200
Message-Id: <1523282044-22075-2-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277054591902411?=
X-GMAIL-MSGID: =?utf-8?q?1597277054591902411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Creating 2 new compile-time constants for internal use,
in preparation for the removal of VLAs[1] from crypto code.
All ciphers implemented in Linux have a block size less than or
equal to 16 bytes and the most demanding hw require 16 bytes
alignment for the block buffer.

[1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 crypto/internal.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/crypto/internal.h b/crypto/internal.h
index 9a3f399..89ae41e 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -26,6 +26,14 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 
+/*
+ * Maximum values for blocksize and alignmask, used to allocate
+ * static buffers that are big enough for any combination of
+ * ciphers and architectures.
+ */
+#define MAX_BLOCKSIZE			16
+#define MAX_ALIGNMASK			15
+
 /* Crypto notification events. */
 enum {
 	CRYPTO_MSG_ALG_REQUEST,
-- 
1.9.1
