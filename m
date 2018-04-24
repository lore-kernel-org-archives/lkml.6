Return-Path: <kernel-hardening-return-13101-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48Fc4tiJdjVQ6EnYSK4tmZFt+EYEA9LrqiwZMzlOblO43q5j0H+GjuzoB2HQ9MUQeOmLtMz
ARC-Seal: i=1; a=rsa-sha256; t=1524533702; cv=none;
        d=google.com; s=arc-20160816;
        b=yRpZXeuRAij6iSwebhtmYl8Z/BBHWqZzyj4HstOzH81gQzFLmfqdPAzOjtKjJB/qKc
         fh9z4xKIgdJFjS1gG/CovuQ2iBEx0EzVCgU075cDjF5GbsS1KvdvrnETzDAglsVw9yC7
         RGW78iiSYwXTFMrTw6cZvg9zMbdcgkViF8xqda8FZMXiVbQPDl40/WmsdE8QlP7PUgRK
         X5JYPCsz4FXKB9R/Z/DQWngv4tRpy0PKcFZM64rBc1i2AWElBViX7YWrriCL+t58hSGF
         UoSjKxIfgkI+z2K4ZkXp8aq1pHxEexQn5Na6ZuKuWpDJXhMFkwYWFNKGh8+7Ik73NMnz
         tuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Yk/g0djB0jPedGHm0mvrwwxkD9dHO9VodP3jlVLORRA=;
        b=algckVwguerdhqDfBqwxr7rGtTE++u1cCbsr/ihAUaFNGb2fWr2zvQBXA8lBLGjjWp
         LryW2tFNtnsOZiUt/zpuHrDXtfhXlJGC35QzCjmH4LuQVHSNq60PAIE1WLZdwdVhUMFK
         NDYO82UFYdE9P6xiVDU2GyV4kHOTKC34Hlqmp34ynUoeGG44c2HvkjRnSz5llxDaVJfV
         hgjnlMC7XIq+Ij9Rr0lOB8UEoLDVtz372xXuIRD0SNgoYRS/ZwfNyqMznJb14TZEqq4r
         wugpQ75Q6cN056KjK7YQZbJE6wjdjgNSc+xggs2/jaZnBmYEiCehE6rDUxMlEsgayb0/
         yHMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=t7EqQ7Ow;
       spf=pass (google.com: domain of kernel-hardening-return-13101-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13101-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=t7EqQ7Ow;
       spf=pass (google.com: domain of kernel-hardening-return-13101-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13101-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Tycho Andersen <tycho@tycho.ws>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/3] big key: get rid of stack array allocation
Date: Mon, 23 Apr 2018 19:03:19 -0600
Message-Id: <20180424010321.14739-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598589451187807410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're interested in getting rid of all of the stack allocated arrays in the
kernel [1]. This patch simply hardcodes the iv length to match that of the
hardcoded cipher.

[1]: https://lkml.org/lkml/2018/3/7/621

v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
    sanity check in init(), Eric Biggers

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jason A. Donenfeld <Jason@zx2c4.com>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 security/keys/big_key.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 933623784ccd..75c46786a166 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -22,6 +22,7 @@
 #include <keys/user-type.h>
 #include <keys/big_key-type.h>
 #include <crypto/aead.h>
+#include <crypto/gcm.h>
 
 struct big_key_buf {
 	unsigned int		nr_pages;
@@ -109,7 +110,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
 	 * an .update function, so there's no chance we'll wind up reusing the
 	 * key to encrypt updated data. Simply put: one key, one encryption.
 	 */
-	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
+	u8 zero_nonce[GCM_AES_IV_SIZE];
 
 	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
 	if (!aead_req)
@@ -425,6 +426,12 @@ static int __init big_key_init(void)
 		pr_err("Can't alloc crypto: %d\n", ret);
 		return ret;
 	}
+
+	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
+		WARN(1, "big key algorithm changed?");
+		return -EINVAL;
+	}
+
 	ret = crypto_aead_setauthsize(big_key_aead, ENC_AUTHTAG_SIZE);
 	if (ret < 0) {
 		pr_err("Can't set crypto auth tag len: %d\n", ret);
-- 
2.17.0
