Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710751-2-5314464085321147684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710750; b=lGQr3pT5WyK8Tydw+1eLxR3Gsji0QOE0JdERMVaaxpv2vqK
    F80LxfwsfE+clE2WHa0OnSKzxFXKeHTyRQiTgZ8snKuyRHDncl5SBcbo3vrxq7or
    rK9gdOhP9PRq6FB8dUKjtmV4rNxybvoUDv/Ys6acse8yT6JUHhrwHA1MfjU92GJO
    11Noo7dK30yDxoInpZF6wwcj9Y88G9rPhPE8ZBxcGI9Yxwr/BmEK7/e2HN7dsboL
    /7b3akiugzWf26ZYzP760Mq7bgCxM2NqL9ir3TSGeWfQHlFAIAkh28jWg4ADpncx
    pIgm0rNnyuj80LI8WX5ImT5Axbnqjsi2FoEg25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710750; bh=wRH5E/gxeoqqVgVrb4nfKZGLq7
    PgCvcBBUnktftBO0Q=; b=TRBFBFnOGAIFyPoYP0sNFYoPZP9ykgYMbl/3tXZWcY
    9IcqJzTdDXNrksml0pVGPyn0F1FwP4uyHophnHzWDrLtbWz2McGdJ49g6txno6Jl
    CXWJWGInu0tW6JNJEfHhPdqvUrlJUmkYK3Va4qUWp/HdlkEJjAkucey4NAj47aVH
    PQAfPAtGDH0a/O15P4kxwRpWilG6frZpZKbiDprdduwB/WnvNrpY7/mSIJCQ5nXf
    FKNixteJL4MpMtlxvtr9n4D/zg5fG3FPRrKKLIPdg8Kt+azTO3zU3P1oLA06w4uV
    JoPoGrhhWXFAUxyoh+3G8sApJAlajMhcGrVUtPD/TEvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424761AbeBOQFi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:05:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424612AbeBOPqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 128/202] crypto: sha512-mb - initialize pending lengths correctly
Date: Thu, 15 Feb 2018 16:17:08 +0100
Message-Id: <20180215151719.902458550@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit eff84b379089cd8b4e83599639c1f5f6e34ef7bf upstream.

The SHA-512 multibuffer code keeps track of the number of blocks pending
in each lane.  The minimum of these values is used to identify the next
lane that will be completed.  Unused lanes are set to a large number
(0xFFFFFFFF) so that they don't affect this calculation.

However, it was forgotten to set the lengths to this value in the
initial state, where all lanes are unused.  As a result it was possible
for sha512_mb_mgr_get_comp_job_avx2() to select an unused lane, causing
a NULL pointer dereference.  Specifically this could happen in the case
where ->update() was passed fewer than SHA512_BLOCK_SIZE bytes of data,
so it then called sha_complete_job() without having actually submitted
any blocks to the multi-buffer code.  This hit a NULL pointer
dereference if another task happened to have submitted blocks
concurrently to the same CPU and the flush timer had not yet expired.

Fix this by initializing sha512_mb_mgr->lens correctly.

As usual, this bug was found by syzkaller.

Fixes: 45691e2d9b18 ("crypto: sha512-mb - submit/flush routines for AVX2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c
+++ b/arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c
@@ -57,10 +57,12 @@ void sha512_mb_mgr_init_avx2(struct sha5
 {
 	unsigned int j;
 
-	state->lens[0] = 0;
-	state->lens[1] = 1;
-	state->lens[2] = 2;
-	state->lens[3] = 3;
+	/* initially all lanes are unused */
+	state->lens[0] = 0xFFFFFFFF00000000;
+	state->lens[1] = 0xFFFFFFFF00000001;
+	state->lens[2] = 0xFFFFFFFF00000002;
+	state->lens[3] = 0xFFFFFFFF00000003;
+
 	state->unused_lanes = 0xFF03020100;
 	for (j = 0; j < 4; j++)
 		state->ldata[j].job_in_lane = NULL;
