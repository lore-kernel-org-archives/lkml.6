Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F26ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E0B20857
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E0B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGMOmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:42:55 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeGMOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:42:55 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MUyXA-1fYVNe3BUa-00YCYW; Fri, 13 Jul 2018 16:27:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2, RESEND] cachefiles: avoid deprecated get_seconds()
Date:   Fri, 13 Jul 2018 16:27:44 +0200
Message-Id: <20180713142753.3139243-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:yeXq+fZ8EN7ss+kOiJ73y1gVzdEiikqs1lzJtaF4wDhZqXLb19t
 EgLxKf8Am/xOmHf5hsk7DbhPo0QNFYgS2UJ7mcltC+kHWPUcs85jnfWv0TAbZCB9dC9S34L
 GIMMB/MnREtyvefCgkq8CX5S7LK6nDsJC/HkLyivWKOHCc4Q/Cx2EYRq0SXOBiCvPcTb1xo
 IjLbyahKGSd1ox6ha442Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:beObR7mqFZo=:QazBiH1Z2YyBqA3Mjzj6um
 ArtFvSsRT0HVvhQgRXG9ZhnwzgcOJ07wftFjhsyzZhsPPxXnfAmpYh3F0saXZXhQFrL9XzTdx
 MbOqe/AOhGAwiE99wNz8kkr5CtBSZ3lK32Jn5g8EOjHNW9X7d16NeLK6f/CFFqihuNsf2odjm
 BdE4QY3Evg9rtz/P37EHox/Jfi4GkaOL27Bsgi2PgrdQox9jm4rEpAqQXEYs7mdU36XPloslj
 5aD+us0FowYVkyx6zX/YJALivALxzXnMZYSv+pk9wG4ifix2QRQWkXgNpsKfm02AtrEQWJCXb
 yqIZv2U927p/nFR4PYQg/Z6To1BZkODsVRsSf9xX3sBz+S8lNnSTD8BnQOrwkhrQF/13E3s0o
 W7lZCbxEmKgS+isQAOu01eb376d4rAHDCtdDguX9R5nh8m9uHAt+szTdG3j3EZIxmWr4Dg7qW
 8LLgJG00I26HldZf5Ht6SWJEqG0sXly6nTQ/mLIxFM6Sj/9fv6P02pVcAKAY+p+ZNqwMusLJN
 6QtTM5bHyDbUZl6EuWzDsF6HI5JeBc/o/yJZ9ZMWimSO4t4GErRUgJQlIU1hOvH7B5OWzJoXy
 BR3iDntiO9Qd5UcC+fkR5Y/aCwMCA/C3XCQufrGeHq3wcAJr98pw9H8gCO9ARRCopitKqJQYo
 vLzg16YeRmz3mWpErZFojg6Fwl28OAlCZpYUH7s8fNqD9YdGVnGAmLnFC700yzE+0aGk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() returns an unsigned long can overflow on some architectures
and is deprecated because of that. In cachefs, we cast that number to
a a 32-bit integer, which will overflow in year 2106 on all architectures.

As confirmed by David Howells, the overflow probably isn't harmful
in the end, since the timestamps are only used to make the file names
unique, but they don't strictly have to be in monotonically increasing
order since the files only exist in order to be deleted as quickly
as possible.

Moving to ktime_get_real_seconds() avoids the deprecated interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: only change to ktime_get_real_seconds() without printing the
    extra leading digits

    Originally submitted this on June 20, but got no reply.
    Resending this in case it got lost somewhere on the way.
    David, can you pick this up?
---
 fs/cachefiles/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ab0bbe93b398..0a38978b8cd3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -337,7 +337,7 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
 	sprintf(nbuffer, "%08x%08x",
-		(uint32_t) get_seconds(),
+		(uint32_t) ktime_get_real_seconds(),
 		(uint32_t) atomic_inc_return(&cache->gravecounter));
 
 	/* do the multiway lock magic */
-- 
2.9.0

