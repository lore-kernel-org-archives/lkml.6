Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B00C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F58F20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F58F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeKLFs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50856 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730628AbeKLFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000l4-Pv; Sun, 11 Nov 2018 19:58:56 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mB-4A; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Howells" <dhowells@redhat.com>,
        "Anthony DeRobertis" <aderobertis@metrics.net>,
        "Lei Xue" <carmark.dlut@gmail.com>,
        "Kiran Kumar Modukuri" <kiran.modukuri@gmail.com>,
        "Vegard Nossum" <vegard.nossum@gmail.com>,
        "NeilBrown" <neilb@suse.com>, "Daniel Axtens" <dja@axtens.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.274664968@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 289/366] cachefiles: Fix refcounting bug in
 backing-file read monitoring
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

commit 934140ab028713a61de8bca58c05332416d037d1 upstream.

cachefiles_read_waiter() has the right to access a 'monitor' object by
virtue of being called under the waitqueue lock for one of the pages in its
purview.  However, it has no ref on that monitor object or on the
associated operation.

What it is allowed to do is to move the monitor object to the operation's
to_do list, but once it drops the work_lock, it's actually no longer
permitted to access that object.  However, it is trying to enqueue the
retrieval operation for processing - but it can only do this via a pointer
in the monitor object, something it shouldn't be doing.

If it doesn't enqueue the operation, the operation may not get processed.
If the order is flipped so that the enqueue is first, then it's possible
for the work processor to look at the to_do list before the monitor is
enqueued upon it.

Fix this by getting a ref on the operation so that we can trust that it
will still be there once we've added the monitor to the to_do list and
dropped the work_lock.  The op can then be enqueued after the lock is
dropped.

The bug can manifest in one of a couple of ways.  The first manifestation
looks like:

 FS-Cache:
 FS-Cache: Assertion failed
 FS-Cache: 6 == 5 is false
 ------------[ cut here ]------------
 kernel BUG at fs/fscache/operation.c:494!
 RIP: 0010:fscache_put_operation+0x1e3/0x1f0
 ...
 fscache_op_work_func+0x26/0x50
 process_one_work+0x131/0x290
 worker_thread+0x45/0x360
 kthread+0xf8/0x130
 ? create_worker+0x190/0x190
 ? kthread_cancel_work_sync+0x10/0x10
 ret_from_fork+0x1f/0x30

This is due to the operation being in the DEAD state (6) rather than
INITIALISED, COMPLETE or CANCELLED (5) because it's already passed through
fscache_put_operation().

The bug can also manifest like the following:

 kernel BUG at fs/fscache/operation.c:69!
 ...
    [exception RIP: fscache_enqueue_operation+246]
 ...
 #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
 #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
 #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028

I'm not entirely certain as to which is line 69 in Lei's kernel, so I'm not
entirely clear which assertion failed.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Reported-by: Lei Xue <carmark.dlut@gmail.com>
Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
Reported-by: Anthony DeRobertis <aderobertis@metrics.net>
Reported-by: NeilBrown <neilb@suse.com>
Reported-by: Daniel Axtens <dja@axtens.net>
Reported-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cachefiles/rdwr.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -27,6 +27,7 @@ static int cachefiles_read_waiter(wait_q
 	struct cachefiles_one_read *monitor =
 		container_of(wait, struct cachefiles_one_read, monitor);
 	struct cachefiles_object *object;
+	struct fscache_retrieval *op = monitor->op;
 	struct wait_bit_key *key = _key;
 	struct page *page = wait->private;
 
@@ -51,16 +52,22 @@ static int cachefiles_read_waiter(wait_q
 	list_del(&wait->task_list);
 
 	/* move onto the action list and queue for FS-Cache thread pool */
-	ASSERT(monitor->op);
+	ASSERT(op);
 
-	object = container_of(monitor->op->op.object,
-			      struct cachefiles_object, fscache);
+	/* We need to temporarily bump the usage count as we don't own a ref
+	 * here otherwise cachefiles_read_copier() may free the op between the
+	 * monitor being enqueued on the op->to_do list and the op getting
+	 * enqueued on the work queue.
+	 */
+	fscache_get_retrieval(op);
 
+	object = container_of(op->op.object, struct cachefiles_object, fscache);
 	spin_lock(&object->work_lock);
-	list_add_tail(&monitor->op_link, &monitor->op->to_do);
+	list_add_tail(&monitor->op_link, &op->to_do);
 	spin_unlock(&object->work_lock);
 
-	fscache_enqueue_retrieval(monitor->op);
+	fscache_enqueue_retrieval(op);
+	fscache_put_retrieval(op);
 	return 0;
 }
 

