Return-Path: <kernel-hardening-return-13100-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49WvX7dPYcxvvLoMeuh9PpEQWb7ZPCCOxswscgIDbbum1aGw/rO+oakbFJC4pUMPtJLrTcx
ARC-Seal: i=1; a=rsa-sha256; t=1524533516; cv=none;
        d=google.com; s=arc-20160816;
        b=RtXzoINyVqKq3lBFy8WV4WnMCO0pPZ3Y55BPTHiVuVfK+gw9ymIj11fxJtcy8Sr/JK
         /aM7beCpMtLgJEkYgZlxoWRxOUOMT9exPjgKurlJ4fU+P3z3VWLx2EkwGVcoZuZKWNpz
         enpdeoDGeGcmk82rid5ZGDQ38CiEFXkHuKSN9SgHUc2bOXcmW0hR6xOqK3D2g69gjGjq
         CZJZ53nQLONJA636HnvvdVJkqKpsLYHl5XQhWAZKAJ2rlUoI7svUv2T5lkYRhTjbtJAt
         o7Gpk/pC9/zmd2XAP1g8t9S9YBLBZREIEEQ6N0iHnZRueMsv0Oxo0A9XDCnMCteUIpcj
         uaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=SJErzKT9nbvMFCOiOIf+uqZIZJ+5ZpCdx6U/gxgdK3g=;
        b=mK0J4roQhjf09tkm2lJXI5+9ni/3wFLtNJEwyItSgVVx6IS5aWXigatyz39YrMBNjS
         MlmrtNGeHVqW2fMw03/fDAfmb1stXZka1Az0fYA+mTvMUnb8Gfmx+Zuo2666wqvspjWE
         xDquldetJ+B6Cog+U9C7O2oplf7d9g+nfHbMi/jG0TbOV+QxecN5mKr3MvFysPKfRR1o
         sgDEyjeJIqnabhn3XpX/pLyCSQmXbsJuufHrhT+15O2RMhM2LvWCYFxnqmvwLh2rqln2
         YC8oMolXCjtVhdBxXxwVFvatc6ef+wNm7gN83mFrSMiQINaOTqryI3lMJrfWujYASR35
         52Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Y1Srcwxg;
       spf=pass (google.com: domain of kernel-hardening-return-13100-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13100-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Y1Srcwxg;
       spf=pass (google.com: domain of kernel-hardening-return-13100-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13100-gregkh=linuxfoundation.org@lists.openwall.com
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
	Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/3] dh key: get rid of stack allocated array
Date: Mon, 23 Apr 2018 19:03:20 -0600
Message-Id: <20180424010321.14739-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424010321.14739-1-tycho@tycho.ws>
References: <20180424010321.14739-1-tycho@tycho.ws>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589256399427295?=
X-GMAIL-MSGID: =?utf-8?q?1598589256399427295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're interested in getting rid of all of the stack allocated arrays in the
kernel: https://lkml.org/lkml/2018/3/7/621

This particular vla is used as a temporary output buffer in case there is
too much hash output for the destination buffer. Instead, let's just
allocate a buffer that's big enough initially, but only copy back to
userspace the amount that was originally asked for.

v2: allocate enough in the original output buffer vs creating a temporary
    output buffer

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 security/keys/dh.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index d1ea9f325f94..9fecaea6c298 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -183,24 +183,13 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 				goto err;
 		}
 
-		if (dlen < h) {
-			u8 tmpbuffer[h];
-
-			err = crypto_shash_final(desc, tmpbuffer);
-			if (err)
-				goto err;
-			memcpy(dst, tmpbuffer, dlen);
-			memzero_explicit(tmpbuffer, h);
-			return 0;
-		} else {
-			err = crypto_shash_final(desc, dst);
-			if (err)
-				goto err;
+		err = crypto_shash_final(desc, dst);
+		if (err)
+			goto err;
 
-			dlen -= h;
-			dst += h;
-			counter = cpu_to_be32(be32_to_cpu(counter) + 1);
-		}
+		dlen -= h;
+		dst += h;
+		counter = cpu_to_be32(be32_to_cpu(counter) + 1);
 	}
 
 	return 0;
@@ -216,14 +205,16 @@ static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
 {
 	uint8_t *outbuf = NULL;
 	int ret;
+	size_t outbuf_len = round_up(buflen,
+			             crypto_shash_digestsize(sdesc->shash.tfm));
 
-	outbuf = kmalloc(buflen, GFP_KERNEL);
+	outbuf = kmalloc(outbuf_len, GFP_KERNEL);
 	if (!outbuf) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = kdf_ctr(sdesc, kbuf, kbuflen, outbuf, buflen, lzero);
+	ret = kdf_ctr(sdesc, kbuf, kbuflen, outbuf, outbuf_len, lzero);
 	if (ret)
 		goto err;
 
-- 
2.17.0
