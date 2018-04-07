Return-Path: <kernel-hardening-return-12877-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/EGR1viSINBQGHbXMDR4dlGx4PO7LuWXMLoFpCelj1YQsgNTcTPZCDH77JFX3RYT7kGecI
ARC-Seal: i=1; a=rsa-sha256; t=1523126366; cv=none;
        d=google.com; s=arc-20160816;
        b=lff+UJl0SZQmXhIn3MKkJpd83MxYl/GtKuHdZQ4KlSNIHB/db90q0JUgmisu5btg1K
         fPmmggDy1rGzfOrVhPJp/mS1EzZcSqQVsDqZpR2lInoManF+TzAUJjuK1JHoqRkhe8tL
         rcM+k6CdizDWqvUawjfVH6yQvfgvP7u3do6BN38uyTa99xZl4PB05isaYOFP9TBz7dtv
         aCgUeac8kmD/z39jgvB+tzCeQDtfT6ZAQA1FR8vVTYFzVfTvDaqkTOVB/O6o1fbFgSYt
         KVjElQql4HEY9BHBl4QD9bUhySUJI5cFXn07LnylytvBkq9BIgEaDbXINUTC3YLdXREp
         OdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=830I2FtaCI7kkwpzHkb1D64AA5JBuPJRaD87G/HzoCY=;
        b=rnue9hvQFN+J0wWbltq61dCfSMWPqdJ2ZstHAiPdl/GRNGAZXaoNOQ6sjh4yITMm3G
         wYe1FlUvRe8dOLblFzhjM25gl8eiLN2/zasvHaPnZnUCxnTyslG3X00rV8T2PExvyzAQ
         feg5HUiT9g3Ms/gl6TcZbd0gFETmqHYn8uBkF8wSt1bsRoSbjEUQk5n+XZEcpfumSwSK
         FHP2nrO941izG+HfotBEMhYN2v/nL2yQDWztvgLu8BBf5id4vzzmM1aM+HIvUJuxe8GH
         Cjb1TnDy+5aSAs8MnJY7FNO/91Dfvilx1aX3Ubx4cKLncrPeGFO/VmbwlO/zkt70j2EV
         0/DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B8gND4Up;
       spf=pass (google.com: domain of kernel-hardening-return-12877-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12877-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B8gND4Up;
       spf=pass (google.com: domain of kernel-hardening-return-12877-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12877-gregkh=linuxfoundation.org@lists.openwall.com;
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
Date: Sat,  7 Apr 2018 20:38:18 +0200
Message-Id: <1523126303-23205-2-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113752919288094?=
X-GMAIL-MSGID: =?utf-8?q?1597113752919288094?=
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
