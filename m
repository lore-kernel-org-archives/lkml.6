Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F497ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5D8205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5D8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJQWTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQWTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:19:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA3008046B;
        Wed, 17 Oct 2018 14:23:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBE325E255;
        Wed, 17 Oct 2018 14:23:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/4] fscache: Fix incomplete initialisation of inline key
 space
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com,
        Eric Sandeen <sandeen@redhat.com>, viro@zeniv.linux.org.uk,
        sandeen@redhat.com, dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 15:23:45 +0100
Message-ID: <153978622578.8478.2358113657075991349.stgit@warthog.procyon.org.uk>
In-Reply-To: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
References: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 17 Oct 2018 14:23:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline key in struct rxrpc_cookie is insufficiently initialized,
zeroing only 3 of the 4 slots, therefore an index_key_len between 13 and 15
bytes will end up hashing uninitialized memory because the memcpy only
partially fills the last buf[] element.

Fix this by clearing fscache_cookie objects on allocation rather than using
the slab constructor to initialise them.  We're going to pretty much fill
in the entire struct anyway, so bringing it into our dcache writably
shouldn't incur much overhead.

This removes the need to do clearance in fscache_set_key() (where we aren't
doing it correctly anyway).

Also, we don't need to set cookie->key_len in fscache_set_key() as we
already did it in the only caller, so remove that.

Fixes: ec0328e46d6e ("fscache: Maintain a catalogue of allocated cookies")
Reported-by: syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com
Reported-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c   |   23 ++++-------------------
 fs/fscache/internal.h |    1 -
 fs/fscache/main.c     |    4 +---
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 83bfe04456b6..b52f1dcd5dea 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -69,19 +69,6 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
 	}
 }
 
-/*
- * initialise an cookie jar slab element prior to any use
- */
-void fscache_cookie_init_once(void *_cookie)
-{
-	struct fscache_cookie *cookie = _cookie;
-
-	memset(cookie, 0, sizeof(*cookie));
-	spin_lock_init(&cookie->lock);
-	spin_lock_init(&cookie->stores_lock);
-	INIT_HLIST_HEAD(&cookie->backing_objects);
-}
-
 /*
  * Set the index key in a cookie.  The cookie struct has space for a 12-byte
  * key plus length and hash, but if that's not big enough, it's instead a
@@ -95,8 +82,6 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 	u32 *buf;
 	int i;
 
-	cookie->key_len = index_key_len;
-
 	if (index_key_len > sizeof(cookie->inline_key)) {
 		buf = kzalloc(index_key_len, GFP_KERNEL);
 		if (!buf)
@@ -104,9 +89,6 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 		cookie->key = buf;
 	} else {
 		buf = (u32 *)cookie->inline_key;
-		buf[0] = 0;
-		buf[1] = 0;
-		buf[2] = 0;
 	}
 
 	memcpy(buf, index_key, index_key_len);
@@ -161,7 +143,7 @@ struct fscache_cookie *fscache_alloc_cookie(
 	struct fscache_cookie *cookie;
 
 	/* allocate and initialise a cookie */
-	cookie = kmem_cache_alloc(fscache_cookie_jar, GFP_KERNEL);
+	cookie = kmem_cache_zalloc(fscache_cookie_jar, GFP_KERNEL);
 	if (!cookie)
 		return NULL;
 
@@ -192,6 +174,9 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie->netfs_data	= netfs_data;
 	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
 	cookie->type		= def->type;
+	spin_lock_init(&cookie->lock);
+	spin_lock_init(&cookie->stores_lock);
+	INIT_HLIST_HEAD(&cookie->backing_objects);
 
 	/* radix tree insertion won't use the preallocation pool unless it's
 	 * told it may not wait */
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index f83328a7f048..d6209022e965 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -51,7 +51,6 @@ extern struct fscache_cache *fscache_select_cache_for_object(
 extern struct kmem_cache *fscache_cookie_jar;
 
 extern void fscache_free_cookie(struct fscache_cookie *);
-extern void fscache_cookie_init_once(void *);
 extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
 						   const struct fscache_cookie_def *,
 						   const void *, size_t,
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 7dce110bf17d..30ad89db1efc 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -143,9 +143,7 @@ static int __init fscache_init(void)
 
 	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
 					       sizeof(struct fscache_cookie),
-					       0,
-					       0,
-					       fscache_cookie_init_once);
+					       0, 0, NULL);
 	if (!fscache_cookie_jar) {
 		pr_notice("Failed to allocate a cookie jar\n");
 		ret = -ENOMEM;

