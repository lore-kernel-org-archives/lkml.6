Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B874C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8572146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8572146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeLADuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:50:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbeLADuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:50:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ADD9300127F;
        Fri, 30 Nov 2018 16:40:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804BD5EE03;
        Fri, 30 Nov 2018 16:39:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/7] cachefiles: Fix an assertion failure when trying to
 update a failed object
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Zhibin Li <zhibli@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:39:53 +0000
Message-ID: <154359599280.18703.15983385548712952353.stgit@warthog.procyon.org.uk>
In-Reply-To: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
References: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 30 Nov 2018 16:40:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cachefiles gets an error other then ENOENT when trying to look up an
object in the cache (in this case, EACCES), the object state machine will
eventually transition to the DROP_OBJECT state.

This state invokes fscache_drop_object() which tries to sync the auxiliary
data with the cache (this is done lazily since commit 402cb8dda949d) on an
incomplete cache object struct.

The problem comes when cachefiles_update_object_xattr() is called to
rewrite the xattr holding the data.  There's an assertion there that the
cache object points to a dentry as we're going to update its xattr.  The
assertion trips, however, as dentry didn't get set.

Fix the problem by skipping the update in cachefiles if the object doesn't
refer to a dentry.  A better way to do it could be to skip the update from
the DROP_OBJECT state handler in fscache, but that might deny the cache the
opportunity to update intermediate state.

If this error occurs, the kernel log includes lines that look like the
following:

 CacheFiles: Lookup failed error -13
 CacheFiles:
 CacheFiles: Assertion failed
 ------------[ cut here ]------------
 kernel BUG at fs/cachefiles/xattr.c:138!
 ...
 Workqueue: fscache_object fscache_object_work_func [fscache]
 RIP: 0010:cachefiles_update_object_xattr.cold.4+0x18/0x1a [cachefiles]
 ...
 Call Trace:
  cachefiles_update_object+0xdd/0x1c0 [cachefiles]
  fscache_update_aux_data+0x23/0x30 [fscache]
  fscache_drop_object+0x18e/0x1c0 [fscache]
  fscache_object_work_func+0x74/0x2b0 [fscache]
  process_one_work+0x18d/0x340
  worker_thread+0x2e/0x390
  ? pwq_unbound_release_workfn+0xd0/0xd0
  kthread+0x112/0x130
  ? kthread_bind+0x30/0x30
  ret_from_fork+0x35/0x40

Note that there are actually two issues here: (1) EACCES happened on a
cache object and (2) an oops occurred.  I think that the second is a
consequence of the first (it certainly looks like it ought to be).  This
patch only deals with the second.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Reported-by: Zhibin Li <zhibli@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/xattr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 0a29a00aed2e..511e6c68156a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -135,7 +135,8 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
 	struct dentry *dentry = object->dentry;
 	int ret;
 
-	ASSERT(dentry);
+	if (!dentry)
+		return -ESTALE;
 
 	_enter("%p,#%d", object, auxdata->len);
 

