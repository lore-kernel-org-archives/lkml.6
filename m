Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3161C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B642220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAfT1TWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B642220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeLEJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbeLEJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:05 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089EC2084C;
        Wed,  5 Dec 2018 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002864;
        bh=vn2W9lsmO56lv8OhRZFUgZHvqg3PUeAnZaPha3Y6jY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAfT1TWox78mxZAZq1NvCgTEwb1CUb77ZMQO834EjZfDNCI8LSXy0DvrYgVJkSzqs
         YQi76qki/i5g+IYANyRlYWNirEnf8C6Vf+m4+5/9aOAGj2IuDo09nmesLAGO+nlVlx
         A9ClYlIXRCir7lwEiI8ti8fx4dsdKqRBLYCrkNns=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "kiran.modukuri" <kiran.modukuri@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 092/123] fscache: Fix race in fscache_op_complete() due to split atomic_sub & read
Date:   Wed,  5 Dec 2018 04:35:24 -0500
Message-Id: <20181205093555.5386-92-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "kiran.modukuri" <kiran.modukuri@gmail.com>

[ Upstream commit 3f2b7b9035107d6096ea438ea3d97dcf0481b6d2 ]

The code in fscache_retrieval_complete is using atomic_sub followed by an
atomic_read:

        atomic_sub(n_pages, &op->n_pages);
        if (atomic_read(&op->n_pages) <= 0)
                fscache_op_complete(&op->op, true);

This causes two threads doing a decrement of n_pages to race with each
other seeing the op->refcount 0 at same time - and they end up calling
fscache_op_complete() in both the threads leading to an assertion failure.

Fix this by using atomic_sub_return_relaxed() instead of two calls.  Note
that I'm using 'relaxed' rather than, say, 'release' as there aren't
multiple variables that appear to need ordering across the release.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fscache-cache.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 34cf0fdd7dc7..610815e3f1aa 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -196,8 +196,7 @@ static inline void fscache_enqueue_retrieval(struct fscache_retrieval *op)
 static inline void fscache_retrieval_complete(struct fscache_retrieval *op,
 					      int n_pages)
 {
-	atomic_sub(n_pages, &op->n_pages);
-	if (atomic_read(&op->n_pages) <= 0)
+	if (atomic_sub_return_relaxed(n_pages, &op->n_pages) <= 0)
 		fscache_op_complete(&op->op, false);
 }
 
-- 
2.17.1

