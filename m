Return-Path: <kernel-hardening-return-13124-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZprnbA7exGTfd9GHK5taYlI5LUJqFeosWzy68n4bWfxb/e/ODO3tVg4LkQji+AkIlrSL9VQ
ARC-Seal: i=1; a=rsa-sha256; t=1524601707; cv=none;
        d=google.com; s=arc-20160816;
        b=H5Q8HDA9zZWrklwn0aC9yDmb0qDcI5HJPkiVHF2MRPDgBgosUq8oR8jCuCEDvjZ3Le
         Zz5Ox6NYsd42r/jN2hp2ido4P/syq8JNA4q5a3qgoR1P6V/M4UMCOtqsuuqPj4RM12LK
         Ujzu3j1ckPm65Zy4nY8N3k7KnnWsakAydoymyv47Q8QJjrHmx/kZmHQH127X8DnjbNnw
         5rYB05+7oQ7PvwHK4+YgUvn//6c/o+1ul6HBih8rEjQMq+vglBiyvn0XAd5E3CVgpMPo
         f5YRkP1O992sbcfpxnM+PfyfweBqE25ruFQ+HZDAB03Er/ASRuLqFuAfsW1t68jUi6HD
         D7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=IcY/S5ZAzHbKulcj9WVk/KdMuvl+h2gFrtIzyQskksg=;
        b=cSkn8CWk64SRhMcHZQgQjGEttgJC9+pqE1bDcU4SdP52GwC5qGo4kPvcp+UWMhM5T4
         MoJyxIoPXNxizZ2QDcfd8N1YG5XGgc2WTo1oovKkBL4G5AK7oiwGAKhuvfGCMVYr26g5
         0qncqMNgem4sPCQ/Yb2hK5F4UfMvy0Q1C13eqyZycfIE9ncWZme/NAk9M/R1CK/dRKHV
         5Liz2xHmSulx34KgKSL4dhvCZTyo9JjbNPBROj1xCq4FmvmqH3eLcp58fBWTKaupU1Dx
         6EOTMV3tj6ujRVo+FEDl7C1dEmJdwxrNdX2+aZ80dSwK47UNQJD0tQPlvYnes7JZUIfA
         Zc8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=iRybSTdQ;
       spf=pass (google.com: domain of kernel-hardening-return-13124-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13124-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=iRybSTdQ;
       spf=pass (google.com: domain of kernel-hardening-return-13124-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13124-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH v3 1/3] big key: get rid of stack array allocation
Date: Tue, 24 Apr 2018 14:26:37 -0600
Message-Id: <20180424202639.19830-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598660759746921800?=
X-GMAIL-MSGID: =?utf-8?q?1598660759746921800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're interested in getting rid of all of the stack allocated arrays in the
kernel [1]. This patch simply hardcodes the iv length to match that of the
hardcoded cipher.

[1]: https://lkml.org/lkml/2018/3/7/621

v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
    sanity check in init(), Eric Biggers
v3: * remember to free big_key_aead when sanity check fails
    * define a constant for big key IV size so it can be changed along side
      the algorithm in the code

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jason A. Donenfeld <Jason@zx2c4.com>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 security/keys/big_key.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 933623784ccd..2806e70d7f8f 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -22,6 +22,7 @@
 #include <keys/user-type.h>
 #include <keys/big_key-type.h>
 #include <crypto/aead.h>
+#include <crypto/gcm.h>
 
 struct big_key_buf {
 	unsigned int		nr_pages;
@@ -85,6 +86,7 @@ struct key_type key_type_big_key = {
  * Crypto names for big_key data authenticated encryption
  */
 static const char big_key_alg_name[] = "gcm(aes)";
+#define BIG_KEY_IV_SIZE		GCM_AES_IV_SIZE
 
 /*
  * Crypto algorithms for big_key data authenticated encryption
@@ -109,7 +111,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
 	 * an .update function, so there's no chance we'll wind up reusing the
 	 * key to encrypt updated data. Simply put: one key, one encryption.
 	 */
-	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
+	u8 zero_nonce[BIG_KEY_IV_SIZE];
 
 	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
 	if (!aead_req)
@@ -425,6 +427,13 @@ static int __init big_key_init(void)
 		pr_err("Can't alloc crypto: %d\n", ret);
 		return ret;
 	}
+
+	if (unlikely(crypto_aead_ivsize(big_key_aead) != BIG_KEY_IV_SIZE)) {
+		WARN(1, "big key algorithm changed?");
+		ret = -EINVAL;
+		goto free_aead;
+	}
+
 	ret = crypto_aead_setauthsize(big_key_aead, ENC_AUTHTAG_SIZE);
 	if (ret < 0) {
 		pr_err("Can't set crypto auth tag len: %d\n", ret);
-- 
2.17.0
