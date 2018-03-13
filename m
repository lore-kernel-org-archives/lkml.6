Return-Path: <kernel-hardening-return-12492-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu8zyln29F/+ArZy7Z0wMwd0FEYapHf2fiH888H6hFqxiWwSgywMRK1upeL08JrtwdCgCmX
ARC-Seal: i=1; a=rsa-sha256; t=1520915423; cv=none;
        d=google.com; s=arc-20160816;
        b=vmz+i5ZE0U9kDKNv42aiu6nnfSfxl6sj0z9Rb694jz6BFvGJS9Fd7b6VmOOjPAoISt
         RCbiVsnrHbpC9vbivmzkKAKX/1h0QanS4rEkQB86k6R3AMarHCiuUEKjUTBS0mqq6XoY
         4tNz8DjAEryNtE1CyedSLsHVUeSp/Kwb8t4kMEZ/+zjkYKvGd7R2QK+c9RKL1GvXORSH
         r0LcvnkTA+i4pxgdAF9TwBIbgXuD1q0+DA1JU5grAbJzBaCMOCWjcr2/TSuRmbg0f5+r
         c1B9Y7IBs1t6bYu2UQXwzkjfXPidT/3fI54iDaStHnVRCMEPevjgF+heAS6zo0TvD6A0
         5WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=3m64m4812TaCibAtDMzmJiivBFzUMendi6gNta4oOlM=;
        b=EDMiNIIQM/UTV4mtSdA+G2VvEmeM7bRkMWYbZuNhwKKiB/zwV16+U/GEzM/2zVB+ZI
         wOPSoEb0ab85SpNQ1C9wXNECUqMLtQL788raOiiupvlfKFjfSkpIUi09jllsfEn7s6q5
         Gs01iBYOTOs89UjJ+0AplDK6SSpLY3G2bYrUXR/hpLcLtqLWUIlI6RhXA0kNRf/uUtqD
         qtnWrSLDxiEZhFvQ3F6mG3AL2+I3UhR1ZAO3YKKDzvCNII6swuOldyfiO7wESMNyzjUP
         e+HU7bWTnc+B73CFSuvC9kUJmvPW6Pod+xj3xF2DGMuVF/H638515hbRryQN8iN2Dj7r
         OIjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=dX53qXgS;
       spf=pass (google.com: domain of kernel-hardening-return-12492-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12492-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=dX53qXgS;
       spf=pass (google.com: domain of kernel-hardening-return-12492-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12492-gregkh=linuxfoundation.org@lists.openwall.com
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
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/2] big key: get rid of stack array allocation
Date: Mon, 12 Mar 2018 22:29:06 -0600
Message-Id: <20180313042907.29598-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795410426531293?=
X-GMAIL-MSGID: =?utf-8?q?1594795410426531293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're interested in getting rid of all of the stack allocated arrays in the
kernel [1]. This patch removes one in keys by switching to malloc/free.
Note that we use kzalloc, to avoid leaking the nonce. I'm not sure this is
really necessary, but extra paranoia seems prudent.

Manually tested using the program from the add_key man page to trigger
big_key.

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jason A. Donenfeld <Jason@zx2c4.com>
---
 security/keys/big_key.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index fa728f662a6f..70f9f785c59d 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -108,13 +108,18 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
 	 * an .update function, so there's no chance we'll wind up reusing the
 	 * key to encrypt updated data. Simply put: one key, one encryption.
 	 */
-	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
+	u8 *zero_nonce;
+
+	zero_nonce = kzalloc(crypto_aead_ivsize(big_key_aead), GFP_KERNEL);
+	if (!zero_nonce)
+		return -ENOMEM;
 
 	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
-	if (!aead_req)
+	if (!aead_req) {
+		kfree(zero_nonce);
 		return -ENOMEM;
+	}
 
-	memset(zero_nonce, 0, sizeof(zero_nonce));
 	aead_request_set_crypt(aead_req, buf->sg, buf->sg, datalen, zero_nonce);
 	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 	aead_request_set_ad(aead_req, 0);
@@ -131,6 +136,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
 error:
 	mutex_unlock(&big_key_aead_lock);
 	aead_request_free(aead_req);
+	kzfree(zero_nonce);
 	return ret;
 }
 
-- 
2.15.1
