Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeFDLCW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:02:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52022 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752029AbeFDLCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:02:21 -0400
From: nixiaoming <nixiaoming@huawei.com>
To: <akpm@linux-foundation.org>, <vdavydov.dev@gmail.com>,
        <hannes@cmpxchg.org>, <garsilva@embeddedor.com>,
        <ktkhai@virtuozzo.com>, <stummala@codeaurora.org>
CC: <nixiaoming@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH] mm: Add conditions to avoid out-of-bounds
Date: Mon, 4 Jun 2018 18:37:35 +0800
Message-ID: <20180604103735.42781-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function memcg_init_list_lru
if call goto fail when i == 0, will cause out-of-bounds at lru->node[i]

The same out-of-bounds access scenario exists in the functions
memcg_update_list_lru and __memcg_init_list_lru_node

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 mm/list_lru.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index fcfb6c8..ec6bdd9 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -298,6 +298,9 @@ static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 {
 	int i;
 
+	if (unlikely(begin >= end))
+		return;
+
 	for (i = begin; i < end; i++)
 		kfree(memcg_lrus->lru[i]);
 }
@@ -422,6 +425,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 	}
 	return 0;
 fail:
+	if (unlikely(i == 0))
+		return -ENOMEM;
 	for (i = i - 1; i >= 0; i--) {
 		if (!lru->node[i].memcg_lrus)
 			continue;
@@ -456,6 +461,8 @@ static int memcg_update_list_lru(struct list_lru *lru,
 	}
 	return 0;
 fail:
+	if (unlikely(i == 0))
+		return -ENOMEM;
 	for (i = i - 1; i >= 0; i--) {
 		if (!lru->node[i].memcg_lrus)
 			continue;
-- 
2.10.1
