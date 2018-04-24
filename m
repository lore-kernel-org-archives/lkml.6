Return-Path: <kernel-hardening-return-13126-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrYKL8S1xWTVuE3F7rLSx2p5GZYqd6xOKjkD4AyBV+4WbqJVSiV6JBnwLGjXuGh7C6g7hTA
ARC-Seal: i=1; a=rsa-sha256; t=1524601723; cv=none;
        d=google.com; s=arc-20160816;
        b=cfrMDniFB0NeSQLX2BmhnMwa3bmbJs49ZLfg/hEWXAaDfTu8lpezGIPSqk0HXJhAKk
         3CahVUd50zR2i/jvS/IKs6I+9FsxP4CfT9SL02nHqH9N8TeaSyUe5PbcWEyNnBmy/lum
         BgO8WtSEWRDG4lb+x4KQKjYmeS6w6iNB5xzeu/iAM+KffMw8Qoj5BTIp5aJpuZvDRm6S
         FHIOc3kClgagJAdmjUS10O0KPX3mlpwjm7wP6ohltWdU88KojsvKiIoqXDH8B0Akr/24
         ohT0T07PN719kclzWpxfi7LHcuqD9Hm8dkoH6v24v4aUWcK/JqUoZ+GdAOxxDab9gVv6
         4RHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=zVwg/XtOp7qOT82C31VjLPjQE83Md8m19QwRBi3Aiho=;
        b=u9psS0GHLfZJADgKRRi0kMS7qxkSHXfXnSFqcncyaFkg4toJyxuBopFVtANgGwxo36
         f/uXWhgDsXU+VazNdO6cyUQoXYDQ6Vwhtd6/MGJe1Q1NPHdgzsJsc5zM3gKXF2+tuOAK
         ZFcq0LakPY5uiG++E3Kf6kQhVCp21fYSQkXNROd0LQo0NeSqzDDjf25eFcLEnreeO7Xp
         IOeAU3AfVZ2pobRrS/KlL69CwlBgeVu7irxfLKbZQr0lpik0hcF82WyL0Yt7mHik7iMW
         Oe89CSXXSeblWzZWss4griBCQkNqMfcuHaOJj6WfP9ZdWU1x+w9RbKzMHbE8Vr99tBFQ
         cEjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=qYqWEPrv;
       spf=pass (google.com: domain of kernel-hardening-return-13126-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13126-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=qYqWEPrv;
       spf=pass (google.com: domain of kernel-hardening-return-13126-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13126-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH v3 3/3] dh key: get rid of stack allocated array for zeroes
Date: Tue, 24 Apr 2018 14:26:39 -0600
Message-Id: <20180424202639.19830-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424202639.19830-1-tycho@tycho.ws>
References: <20180424202639.19830-1-tycho@tycho.ws>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598660776438987100?=
X-GMAIL-MSGID: =?utf-8?q?1598660776438987100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're interested in getting rid of all of the stack allocated arrays in
the kernel: https://lkml.org/lkml/2018/3/7/621

This case is interesting, since we really just need an array of bytes that
are zero. The loop already ensures that if the array isn't exactly the
right size that enough zero bytes will be copied in. So, instead of
choosing this value to be the size of the hash, let's just choose it to be
32, since that is a common size, is not too big, and will not result in too
many extra iterations of the loop.

v2: split out from other patch, just hardcode array size instead of
    dynamically allocating something the right size
v3: fix typo of 256 -> 32

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 security/keys/dh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index 9fecaea6c298..f7403821db7f 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -162,8 +162,8 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 			goto err;
 
 		if (zlen && h) {
-			u8 tmpbuffer[h];
-			size_t chunk = min_t(size_t, zlen, h);
+			u8 tmpbuffer[32];
+			size_t chunk = min_t(size_t, zlen, sizeof(tmpbuffer));
 			memset(tmpbuffer, 0, chunk);
 
 			do {
@@ -173,7 +173,7 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 					goto err;
 
 				zlen -= chunk;
-				chunk = min_t(size_t, zlen, h);
+				chunk = min_t(size_t, zlen, sizeof(tmpbuffer));
 			} while (zlen);
 		}
 
-- 
2.17.0
