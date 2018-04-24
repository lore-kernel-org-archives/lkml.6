Return-Path: <kernel-hardening-return-13099-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoPzCTXtMuORnHadA5ZJqrqZVlevfkKFl7t+UFAJC3wH5gjGcrS7lh8LfNdcVWjKlOD6fl3
ARC-Seal: i=1; a=rsa-sha256; t=1524533392; cv=none;
        d=google.com; s=arc-20160816;
        b=JOzW2Itw2kh4ugrOAhvRvnffFSMmdlOnreksV6L/9Yc1cSc1AYLONS0Cqh11Hcjtk8
         f2m2UDm/1pxHmpxHrVksD5GQgVJjQCADe56yBZL1Ge0qw8b2ZPU3C/+vFBmGjiciH0pN
         ErB6XWYdWio8mtfFwmgPMbWwGU2c9YbMqO8eB2Hnn6MhQNGHtHrevuAGuEU9fnRMJZ8P
         s4o6PVLNeFntvvQWh0LODekFkiecp0wAPvDAQ27Bu8m8VmGDdBue1ezQxZtI7rj3a3C8
         osdOlSgPBB01pM7Lhc+kP+fK1QFagvc034hUJCO5UsH/ta09KU63A5ks0+JcHfV/ar4W
         h7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=PopBxbGfzaql5PthbzfuQy9JDtfE3NU4JPCNXim3sd4=;
        b=IedjEfbXyy5/obwnksDJYOHsGI56QtJq2sxskHzCV+6LZkdFhWrkjJw4bWAw9Grqvi
         +MS8DR0p4NMMC1vosOtNebqEden04ef1QHyAHrLq7vNtw8P6oJw+/XIxFv/DmN6XKxrv
         df2Zrg1UHgY2tbSfCGjGa/yVi+ruh8DY1LGW8pENAmy92F6AHCDEYp2zsBz5BQiS2kZk
         uf7w6mEyWLMLIm/dK4jU6llo1TxEa/IJ0SQC7SPDxwMHZBzeOhefGEHjNoAR+yKdVct1
         9luybh9etSsAB3sM1VROBog28hJH/dPA9OTlANzK/LuXdveFNTZFS5YsjZBbysd4GrpU
         XL3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=grndnHWa;
       spf=pass (google.com: domain of kernel-hardening-return-13099-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13099-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=grndnHWa;
       spf=pass (google.com: domain of kernel-hardening-return-13099-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13099-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH 3/3] dh key: get rid of stack allocated array for zeroes
Date: Mon, 23 Apr 2018 19:03:21 -0600
Message-Id: <20180424010321.14739-3-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424010321.14739-1-tycho@tycho.ws>
References: <20180424010321.14739-1-tycho@tycho.ws>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589126678197761?=
X-GMAIL-MSGID: =?utf-8?q?1598589126678197761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're interested in getting rid of all of the stack allocated arrays in
the kernel: https://lkml.org/lkml/2018/3/7/621

This case is interesting, since we really just need an array of bytes that
are zero. The loop already ensures that if the array isn't exactly the
right size that enough zero bytes will be copied in. So, instead of
choosing this value to be the size of the hash, let's just choose it to be
256, since that is a common size, is not to big, and will not result in too
many extra iterations of the loop.

v2: split out from other patch, just hardcode array size instead of
    dynamically allocating something the right size

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: David Howells <dhowells@redhat.com>
CC: James Morris <jmorris@namei.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 security/keys/dh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index 9fecaea6c298..74f8a853872e 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -162,8 +162,8 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
 			goto err;
 
 		if (zlen && h) {
-			u8 tmpbuffer[h];
-			size_t chunk = min_t(size_t, zlen, h);
+			u8 tmpbuffer[256];
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
