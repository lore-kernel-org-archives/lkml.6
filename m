Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeDDAw2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 20:52:28 -0400
Received: from m12-18.163.com ([220.181.12.18]:58715 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753298AbeDDAw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 20:52:27 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitalywool@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: wangxidong_97@163.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] z3fold: fix memory leak
Date: Wed,  4 Apr 2018 08:51:51 +0800
Message-Id: <1522803111-29209-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowABXFkeqIcRaUDbfDA--.39463S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw17JrWUGr1kKr48Aw4rGrg_yoWxtFg_Gr
        W8Ww10gr9xJ3WjqrWDAa18AryI9398Zr47WFnIkry7KFWYyF92krn7Xr93WFW8u3y7WFyU
        CrW5K3W7XanxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5gmRUUUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbi8AEe81UMDaEh0AAAsY
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function z3fold_create_pool(), the memory allocated by
__alloc_percpu() is not released on the error path that pool->compact_wq
, which holds the return value of create_singlethread_workqueue(), is NULL.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 mm/z3fold.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index d589d31..b987cc5 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -490,6 +490,7 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 out_wq:
 	destroy_workqueue(pool->compact_wq);
 out:
+	free_percpu(pool->unbuddied);
 	kfree(pool);
 	return NULL;
 }
-- 
2.7.4
