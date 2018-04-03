Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeDCHMe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:12:34 -0400
Received: from mx137-tc.baidu.com ([61.135.168.137]:34967 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752286AbeDCHMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:12:33 -0400
From: Li RongQing <lirongqing@baidu.com>
To: hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: avoid the unnecessary waiting when force empty a cgroup
Date: Tue,  3 Apr 2018 15:12:09 +0800
Message-Id: <1522739529-5602-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of writeback and dirty page can be read out from memcg,
the unnecessary waiting can be avoided by these counts

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 mm/memcontrol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9ec024b862ac..5258651bd4ec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2613,9 +2613,13 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 		progress = try_to_free_mem_cgroup_pages(memcg, 1,
 							GFP_KERNEL, true);
 		if (!progress) {
+			unsigned long num;
+
+			num = memcg_page_state(memcg, NR_WRITEBACK) +
+					memcg_page_state(memcg, NR_FILE_DIRTY);
 			nr_retries--;
-			/* maybe some writeback is necessary */
-			congestion_wait(BLK_RW_ASYNC, HZ/10);
+			if (num)
+				congestion_wait(BLK_RW_ASYNC, HZ/10);
 		}
 
 	}
-- 
2.11.0
