Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeDVU0v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:26:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35661 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753586AbeDVU0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:26:49 -0400
X-Google-Smtp-Source: AIpwx49I1g+BNW8K1UpE1m9FOnm78lYV8XvGXoYF32x/EzAl0WAi2f7V4Xk3P4CVdPixtkguBioxjg==
From: Greg Thelen <gthelen@google.com>
To: guro@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, kernel-team@fb.com,
        Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: [RFC PATCH 1/2] memcg: fix memory.low
Date: Sun, 22 Apr 2018 13:26:11 -0700
Message-Id: <20180422202612.127760-2-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180422202612.127760-1-gthelen@google.com>
References: <20180320223353.5673-1-guro@fb.com>
 <20180422202612.127760-1-gthelen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When targeting reclaim to a memcg, protect that memcg from reclaim is
memory consumption of any level is below respective memory.low.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 mm/memcontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 670e99b68aa6..9668f620203a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5341,8 +5341,8 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
- * Returns %true if memory consumption of @memcg, and that of all
- * ancestors up to (but not including) @root, is below the normal range.
+ * Returns %true if memory consumption of @memcg, or any of its ancestors
+ * up to (but not including) @root, is below the normal range.
  *
  * @root is exclusive; it is never low when looked at directly and isn't
  * checked when traversing the hierarchy.
@@ -5379,12 +5379,12 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 	if (memcg == root)
 		return false;
 
+	/* If any level is under, then protect @memcg from reclaim */
 	for (; memcg != root; memcg = parent_mem_cgroup(memcg)) {
-		if (page_counter_read(&memcg->memory) >= memcg->low)
-			return false;
+		if (page_counter_read(&memcg->memory) <= memcg->low)
+			return true; /* protect from reclaim */
 	}
-
-	return true;
+	return false; /* not protected from reclaim */
 }
 
 /**
-- 
2.17.0.484.g0c8726318c-goog
