Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E34ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017DE205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017DE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeJQWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:19:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQWTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 893693084027;
        Wed, 17 Oct 2018 14:23:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E24C82B5AC;
        Wed, 17 Oct 2018 14:23:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/4] fscache: Fix race in fscache_op_complete() due to split
 atomic_sub & read
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 15:23:38 +0100
Message-ID: <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
In-Reply-To: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
References: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Oct 2018 14:23:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kiran.modukuri <kiran.modukuri@gmail.com>

The code in fscache_retrieval_complete is using atomic_sub followed by an
atomic_read:

        atomic_sub(n_pages, &op->n_pages);
        if (atomic_read(&op->n_pages) <= 0)
                fscache_op_complete(&op->op, true);

This causes two threads doing a decrement of n_pages to race with each
other seeing the op->refcount 0 at same time - and they end up calling
fscache_op_complete() in both the threads leading to an assertion failure.

Fix this by using atomic_sub_return() instead of two calls.

The oops looks something like:

FS-Cache: Assertion failed
FS-Cache: 0 > 0 is false
...
kernel BUG at /usr/src/linux-4.4.0/fs/fscache/operation.c:449!
...
Workqueue: fscache_operation fscache_op_work_func [fscache]
...
RIP: 0010:[<ffffffffc037eacd>] fscache_op_complete+0x10d/0x180 [fscache]
...
Call Trace:
 [<ffffffffc1464cf9>] cachefiles_read_copier+0x3a9/0x410 [cachefiles]
 [<ffffffffc037e272>] fscache_op_work_func+0x22/0x50 [fscache]
 [<ffffffff81096da0>] process_one_work+0x150/0x3f0
 [<ffffffff8109751a>] worker_thread+0x11a/0x470
 [<ffffffff81808e59>] ? __schedule+0x359/0x980
 [<ffffffff81097400>] ? rescuer_thread+0x310/0x310
 [<ffffffff8109cdd6>] kthread+0xd6/0xf0
 [<ffffffff8109cd00>] ? kthread_park+0x60/0x60
 [<ffffffff8180d0cf>] ret_from_fork+0x3f/0x70
 [<ffffffff8109cd00>] ? kthread_park+0x60/0x60

This seen this in 4.4.x kernels and the same bug affects fscache in latest
upstreams kernels.

Fixes: 1bb4b7f98f36 ("FS-Cache: The retrieval remaining-pages counter needs to be atomic_t")
Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fscache-cache.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 34cf0fdd7dc7..bf98ed803af2 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -196,11 +196,11 @@ static inline void fscache_enqueue_retrieval(struct fscache_retrieval *op)
 static inline void fscache_retrieval_complete(struct fscache_retrieval *op,
 					      int n_pages)
 {
-	atomic_sub(n_pages, &op->n_pages);
-	if (atomic_read(&op->n_pages) <= 0)
+	if (atomic_sub_return(n_pages, &op->n_pages) <= 0)
 		fscache_op_complete(&op->op, false);
 }
 
+
 /**
  * fscache_put_retrieval - Drop a reference to a retrieval operation
  * @op: The retrieval operation affected

