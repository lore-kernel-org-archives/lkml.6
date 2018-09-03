Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D7720867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D7720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeICVjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:39:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeICVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:39:00 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D637D09;
        Mon,  3 Sep 2018 17:17:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei Xue <carmark.dlut@gmail.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        Anthony DeRobertis <aderobertis@metrics.net>,
        NeilBrown <neilb@suse.com>, Daniel Axtens <dja@axtens.net>,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 052/165] cachefiles: Fix refcounting bug in backing-file read monitoring
Date:   Mon,  3 Sep 2018 18:55:38 +0200
Message-Id: <20180903165657.751807823@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

[ Upstream commit 934140ab028713a61de8bca58c05332416d037d1 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/rdwr.c |   17 ++++++++++++-----
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
 	list_del(&wait->entry);
 
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
 


