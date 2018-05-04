Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeEDU4A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:56:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40564 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEDUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:55:57 -0400
X-Google-Smtp-Source: AB8JxZoXxJNVzYFki5ZZZr+HfCbfiQCah8P34Z4JnA2ifq+V9kX6SCZA7HbxFLAPI9oO3522Lgb7yg==
From: Shakeel Butt <shakeelb@google.com>
To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm: memcontrol: drain stocks on resize limit
Date: Fri,  4 May 2018 13:55:48 -0700
Message-Id: <20180504205548.110696-1-shakeelb@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resizing the memcg limit for cgroup-v2 drains the stocks before
triggering the memcg reclaim. Do the same for cgroup-v1 to make the
behavior consistent.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25b148c2d222..e2d33a37f971 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2463,6 +2463,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 				 unsigned long max, bool memsw)
 {
 	bool enlarge = false;
+	bool drained = false;
 	int ret;
 	bool limits_invariant;
 	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
@@ -2493,6 +2494,12 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		if (!ret)
 			break;
 
+		if (!drained) {
+			drain_all_stock(memcg);
+			drained = true;
+			continue;
+		}
+
 		if (!try_to_free_mem_cgroup_pages(memcg, 1,
 					GFP_KERNEL, !memsw)) {
 			ret = -EBUSY;
-- 
2.17.0.441.gb46fe60e1d-goog
