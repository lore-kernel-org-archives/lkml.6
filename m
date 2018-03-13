Return-Path: <kernel-hardening-return-12493-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuPx/RAPm1bzgjXR15OSYhM45CIxMzkKYoi4wVWLif1AYBcTBEbsV7tj+AOnSCdIo0TYB+1
ARC-Seal: i=1; a=rsa-sha256; t=1520915400; cv=none;
        d=google.com; s=arc-20160816;
        b=J9plCRB/WYofMYrIQLUBo5PWy1O9foTb/J2vStxnmt9w1JoYDZ31ApKW0yPwGGDxe+
         heS0PrDhJVeod0JKWtVxjUNaTittSxVZKdrjjJNj2WRFlPsulfKtpoVJG4s8sdWYwALN
         1fSin82MMravpt02XKq84C1+fym/14B2z1LTRLzx6OPh7Hk6kSuP0WHPmC/a9rkkbz6G
         vWIGLDDB6fbS8h4MWmNUVW2VyWM2AvtXSJamISHUMG7YiYF0aG4H6/JlLI0vgbx4cdP6
         UeoSyW0vlik/7lRQKnHx+HD+/PclMU5Cuu8nwzckOG4E6PFEU185jksDllcsQUuuLAVZ
         7WAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=7elmkvTp7D2Y1qk9MSRAVsX+pNnrR9P0PXvPX04BVgc=;
        b=exdIA/yeITvOQyMv6odBOnRMZNhTCEJEjlISsBR4yP1Kvqr70XEFT2vL3z5xFcN5k8
         z/tJ+tgtoFcJQ9NBM/yC0UvzDcMKxr1oG2ghgdJzGyqV2rT2BZ8L/mY41FlCduyeNx+0
         8GtgQnzpli5i5MXRq406hYs/6v8xu43FUFlXD+5MMPcwmjX4ldFPAiplgpE1NBfIYWNc
         OAkc3GfauYj7lp9k3DHI52nXzCUrBCXmMBOWxccmfbNo0NrMCXkE0EO2Z08GxPixA4GO
         Tm+hgMpmduk0xuQLZXwcN4xgxSuSeg1varn2LaC2vyrLtOrrRyc6dgpHbdWz1XUbZ6IG
         rEog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=EHR72MOv;
       spf=pass (google.com: domain of kernel-hardening-return-12493-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12493-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=EHR72MOv;
       spf=pass (google.com: domain of kernel-hardening-return-12493-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12493-gregkh=linuxfoundation.org@lists.openwall.com
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
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 2/2] dh key: get rid of stack array allocation
Date: Mon, 12 Mar 2018 22:29:07 -0600
Message-Id: <20180313042907.29598-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313042907.29598-1-tycho@tycho.ws>
References: <20180313042907.29598-1-tycho@tycho.ws>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795386978188484?=
X-GMAIL-MSGID: =?utf-8?q?1594795386978188484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Similarly to the previous patch, we would like to get rid of stack
allocated arrays: https://lkml.org/lkml/2018/3/7/621

In this case, we can also use a malloc style approach to free the temporary
buffer, being careful to also use kzfree to free them (indeed, at least one
of these has a memzero_explicit, but it seems like maybe they both
should?).

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/keys/dh.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index d1ea9f325f94..f02261b24759 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -162,19 +162,27 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 			goto err;
 
 		if (zlen && h) {
-			u8 tmpbuffer[h];
+			u8 *tmpbuffer;
 			size_t chunk = min_t(size_t, zlen, h);
-			memset(tmpbuffer, 0, chunk);
+
+			err = -ENOMEM;
+			tmpbuffer = kzalloc(chunk, GFP_KERNEL);
+			if (!tmpbuffer)
+				goto err;
 
 			do {
 				err = crypto_shash_update(desc, tmpbuffer,
 							  chunk);
-				if (err)
+				if (err) {
+					kzfree(tmpbuffer);
 					goto err;
+				}
 
 				zlen -= chunk;
 				chunk = min_t(size_t, zlen, h);
 			} while (zlen);
+
+			kzfree(tmpbuffer);
 		}
 
 		if (src && slen) {
@@ -184,13 +192,20 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 		}
 
 		if (dlen < h) {
-			u8 tmpbuffer[h];
+			u8 *tmpbuffer;
+
+			err = -ENOMEM;
+			tmpbuffer = kzalloc(h, GFP_KERNEL);
+			if (!tmpbuffer)
+				goto err;
 
 			err = crypto_shash_final(desc, tmpbuffer);
-			if (err)
+			if (err) {
+				kzfree(tmpbuffer);
 				goto err;
+			}
 			memcpy(dst, tmpbuffer, dlen);
-			memzero_explicit(tmpbuffer, h);
+			kzfree(tmpbuffer);
 			return 0;
 		} else {
 			err = crypto_shash_final(desc, dst);
-- 
2.15.1
