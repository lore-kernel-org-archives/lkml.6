Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F415C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CFC20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CFC20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeKLFs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50848 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730579AbeKLFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000l8-Pl; Sun, 11 Nov 2018 19:58:56 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mG-5j; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kiran Kumar Modukuri" <kiran.modukuri@gmail.com>,
        "David Howells" <dhowells@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.54947428@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 290/366] fscache: Fix reference overput in
 fscache_attach_object() error handling
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

commit f29507ce66701084c39aeb1b0ae71690cbff3554 upstream.

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
different superblock would do it.  A backtrace from Kiran seems to show
that this is a possibility:

    kernel BUG at/build/linux-Y09MKI/linux-4.4.0/fs/fscache/cookie.c:639!
    ...
    RIP: __fscache_cookie_put+0x3a/0x40 [fscache]
    Call Trace:
     __fscache_relinquish_cookie+0x87/0x120 [fscache]
     nfs_fscache_release_super_cookie+0x2d/0xb0 [nfs]
     nfs_kill_super+0x29/0x40 [nfs]
     deactivate_locked_super+0x48/0x80
     deactivate_super+0x5c/0x60
     cleanup_mnt+0x3f/0x90
     __cleanup_mnt+0x12/0x20
     task_work_run+0x86/0xb0
     exit_to_usermode_loop+0xc2/0xd0
     syscall_return_slowpath+0x4e/0x60
     int_ret_from_sys_call+0x25/0x9f

[Fix] Bump up the cookie usage in fscache_object_init, when it is first
being assigned a cookie atomically such that the cookie is added and bumped
up if its refcount is not zero.  Remove the assignment in
fscache_attach_object().

[Testcase]
I have run ~100 hours of NFS stress tests and not seen this bug recur.

[Regression Potential]
 - Limited to fscache/cachefiles.

Fixes: ccc4fc3d11e9 ("FS-Cache: Implement the cookie management part of the netfs API")
Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
[bwh: Backported to 3.16: Keep using atomic_inc() instead of
 fscache_cookie_get()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cachefiles/bind.c | 3 ++-
 fs/fscache/cache.c   | 2 +-
 fs/fscache/cookie.c  | 7 ++++---
 fs/fscache/object.c  | 1 +
 4 files changed, 8 insertions(+), 5 deletions(-)

--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -218,7 +218,8 @@ static int cachefiles_daemon_add_cache(s
 			   "%s",
 			   fsdef->dentry->d_sb->s_id);
 
-	fscache_object_init(&fsdef->fscache, NULL, &cache->cache);
+	fscache_object_init(&fsdef->fscache, &fscache_fsdef_index,
+			    &cache->cache);
 
 	ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
 	if (ret < 0)
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -220,6 +220,7 @@ int fscache_add_cache(struct fscache_cac
 {
 	struct fscache_cache_tag *tag;
 
+	ASSERTCMP(ifsdef->cookie, ==, &fscache_fsdef_index);
 	BUG_ON(!cache->ops);
 	BUG_ON(!ifsdef);
 
@@ -248,7 +249,6 @@ int fscache_add_cache(struct fscache_cac
 	if (!cache->kobj)
 		goto error;
 
-	ifsdef->cookie = &fscache_fsdef_index;
 	ifsdef->cache = cache;
 	cache->fsdef = ifsdef;
 
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -302,6 +302,7 @@ static int fscache_alloc_object(struct f
 		goto error;
 	}
 
+	ASSERTCMP(object->cookie, ==, cookie);
 	fscache_stat(&fscache_n_object_alloc);
 
 	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
@@ -356,6 +357,8 @@ static int fscache_attach_object(struct
 
 	_enter("{%s},{OBJ%x}", cookie->def->name, object->debug_id);
 
+	ASSERTCMP(object->cookie, ==, cookie);
+
 	spin_lock(&cookie->lock);
 
 	/* there may be multiple initial creations of this object, but we only
@@ -395,9 +398,7 @@ static int fscache_attach_object(struct
 		spin_unlock(&cache->object_list_lock);
 	}
 
-	/* attach to the cookie */
-	object->cookie = cookie;
-	atomic_inc(&cookie->usage);
+	/* Attach to the cookie.  The object already has a ref on it. */
 	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
 
 	fscache_objlist_add(object);
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -313,6 +313,7 @@ void fscache_object_init(struct fscache_
 	object->store_limit_l = 0;
 	object->cache = cache;
 	object->cookie = cookie;
+	atomic_inc(&cookie->usage);
 	object->parent = NULL;
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	RB_CLEAR_NODE(&object->objlist_link);

