Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F43C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F3220C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F3220C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeGEQbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:31:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753982AbeGEQbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:31:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94C5A400B455;
        Thu,  5 Jul 2018 16:31:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31FE2111AF05;
        Thu,  5 Jul 2018 16:31:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/4] fscache: Fix reference overput in
 fscache_attach_object() error handling
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     kiran.modukuri@gmail.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        neilb@suse.com, aderobertis@metrics.net, dhowells@redhat.com,
        dja@axtens.net
Date:   Thu, 05 Jul 2018 17:31:14 +0100
Message-ID: <153080827470.5496.11719544134805228821.stgit@warthog.procyon.org.uk>
In-Reply-To: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 16:31:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 05 Jul 2018 16:31:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

When a cookie is allocated that causes fscache_object structs to be
allocated, those objects are initialised with the cookie pointer, but
aren't blessed with a ref on that cookie unless the attachment is
successfully completed in fscache_attach_object().

If attachment fails because the parent object was dying or there was a
collision, fscache_attach_object() returns without incrementing the cookie
counter - but upon failure of this function, the object is released which
then puts the cookie, whether or not a ref was taken on the cookie.

Fix this by taking a ref on the cookie when it is assigned in
fscache_object_init(), even when we're creating a root object.


Analysis from Kiran Kumar:

This bug has been seen in 4.4.0-124-generic #148-Ubuntu kernel

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1776277

fscache cookie ref count updated incorrectly during fscache object
allocation resulting in following Oops.

kernel BUG at /build/linux-Y09MKI/linux-4.4.0/fs/fscache/internal.h:321!
kernel BUG at /build/linux-Y09MKI/linux-4.4.0/fs/fscache/cookie.c:639!

[Cause]
Two threads are trying to do operate on a cookie and two objects.

(1) One thread tries to unmount the filesystem and in process goes over a
    huge list of objects marking them dead and deleting the objects.
    cookie->usage is also decremented in following path:

      nfs_fscache_release_super_cookie
       -> __fscache_relinquish_cookie
        ->__fscache_cookie_put
        ->BUG_ON(atomic_read(&cookie->usage) <= 0);

(2) A second thread tries to lookup an object for reading data in following
    path:

    fscache_alloc_object
    1) cachefiles_alloc_object
        -> fscache_object_init
           -> assign cookie, but usage not bumped.
    2) fscache_attach_object -> fails in cant_attach_object because the
         cookie's backing object or cookie's->parent object are going away
    3) fscache_put_object
        -> cachefiles_put_object
          ->fscache_object_destroy
            ->fscache_cookie_put
               ->BUG_ON(atomic_read(&cookie->usage) <= 0);

[NOTE from dhowells] It's unclear as to the circumstances in which (2) can
take place, given that thread (1) is in nfs_kill_super(), however a
conflicting NFS mount with slightly different parameters that creates a
different superblock would do it, but no backtrace was included.

[Fix] Bump up the cookie usage in fscache_object_init, when it is first
being assigned a cookie atomically such that the cookie is added and bumped
up if its refcount is not zero.  Remove the assignment in
fscache_attach_object().

[Testcase]
I have run ~100 hours of NFS stress tests and not seen this bug recur.

[Regression Potential]
 - Limited to fscache/cachefiles.

Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c |    3 ++-
 fs/fscache/cache.c   |    2 +-
 fs/fscache/cookie.c  |    7 ++++---
 fs/fscache/object.c  |    1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index d9f001078e08..4a717d400807 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -218,7 +218,8 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 			   "%s",
 			   fsdef->dentry->d_sb->s_id);
 
-	fscache_object_init(&fsdef->fscache, NULL, &cache->cache);
+	fscache_object_init(&fsdef->fscache, &fscache_fsdef_index,
+			    &cache->cache);
 
 	ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
 	if (ret < 0)
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index c184c5a356ff..cdcb376ef8df 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -220,6 +220,7 @@ int fscache_add_cache(struct fscache_cache *cache,
 {
 	struct fscache_cache_tag *tag;
 
+	ASSERTCMP(ifsdef->cookie, ==, &fscache_fsdef_index);
 	BUG_ON(!cache->ops);
 	BUG_ON(!ifsdef);
 
@@ -248,7 +249,6 @@ int fscache_add_cache(struct fscache_cache *cache,
 	if (!cache->kobj)
 		goto error;
 
-	ifsdef->cookie = &fscache_fsdef_index;
 	ifsdef->cache = cache;
 	cache->fsdef = ifsdef;
 
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 97137d7ec5ee..83bfe04456b6 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -516,6 +516,7 @@ static int fscache_alloc_object(struct fscache_cache *cache,
 		goto error;
 	}
 
+	ASSERTCMP(object->cookie, ==, cookie);
 	fscache_stat(&fscache_n_object_alloc);
 
 	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
@@ -571,6 +572,8 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
 
 	_enter("{%s},{OBJ%x}", cookie->def->name, object->debug_id);
 
+	ASSERTCMP(object->cookie, ==, cookie);
+
 	spin_lock(&cookie->lock);
 
 	/* there may be multiple initial creations of this object, but we only
@@ -610,9 +613,7 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
 		spin_unlock(&cache->object_list_lock);
 	}
 
-	/* attach to the cookie */
-	object->cookie = cookie;
-	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
+	/* Attach to the cookie.  The object already has a ref on it. */
 	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
 
 	fscache_objlist_add(object);
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 20e0d0a4dc8c..9edc920f651f 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -327,6 +327,7 @@ void fscache_object_init(struct fscache_object *object,
 	object->store_limit_l = 0;
 	object->cache = cache;
 	object->cookie = cookie;
+	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
 	object->parent = NULL;
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	RB_CLEAR_NODE(&object->objlist_link);

