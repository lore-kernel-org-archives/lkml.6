Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164584AbeE1Mva (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164467AbeE1K4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:56:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xidong Wang <wangxidong_97@163.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitalywool@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 326/496] z3fold: fix memory leak
Date: Mon, 28 May 2018 12:01:51 +0200
Message-Id: <20180528100333.567291601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xidong Wang <wangxidong_97@163.com>

[ Upstream commit 1ec6995d1290bfb87cc3a51f0836c889e857cef9 ]

In z3fold_create_pool(), the memory allocated by __alloc_percpu() is not
released on the error path that pool->compact_wq , which holds the
return value of create_singlethread_workqueue(), is NULL.  This will
result in a memory leak bug.

[akpm@linux-foundation.org: fix oops on kzalloc() failure, check __alloc_percpu() retval]
Link: http://lkml.kernel.org/r/1522803111-29209-1-git-send-email-wangxidong_97@163.com
Signed-off-by: Xidong Wang <wangxidong_97@163.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitalywool@gmail.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/z3fold.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -469,6 +469,8 @@ static struct z3fold_pool *z3fold_create
 	spin_lock_init(&pool->lock);
 	spin_lock_init(&pool->stale_lock);
 	pool->unbuddied = __alloc_percpu(sizeof(struct list_head)*NCHUNKS, 2);
+	if (!pool->unbuddied)
+		goto out_pool;
 	for_each_possible_cpu(cpu) {
 		struct list_head *unbuddied =
 				per_cpu_ptr(pool->unbuddied, cpu);
@@ -481,7 +483,7 @@ static struct z3fold_pool *z3fold_create
 	pool->name = name;
 	pool->compact_wq = create_singlethread_workqueue(pool->name);
 	if (!pool->compact_wq)
-		goto out;
+		goto out_unbuddied;
 	pool->release_wq = create_singlethread_workqueue(pool->name);
 	if (!pool->release_wq)
 		goto out_wq;
@@ -491,8 +493,11 @@ static struct z3fold_pool *z3fold_create
 
 out_wq:
 	destroy_workqueue(pool->compact_wq);
-out:
+out_unbuddied:
+	free_percpu(pool->unbuddied);
+out_pool:
 	kfree(pool);
+out:
 	return NULL;
 }
 
