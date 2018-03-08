Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934901AbeCHCs7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:48:59 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36612 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934577AbeCHCs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:48:57 -0500
X-Google-Smtp-Source: AG47ELu1+zi9/O+H1P7ieJZQx6LwmZm7Z7ojJ64Gw1Pht7SkxVf/637peJ7tS3UhU2BH2xc1rJIuEg==
From: Shakeel Butt <shakeelb@google.com>
To: Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Subject: [PATCH] mm: memcg: expose mem_cgroup_put API
Date: Wed,  7 Mar 2018 18:48:50 -0800
Message-Id: <20180308024850.39737-1-shakeelb@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports mem_cgroup_put API to put the refcnt of the memory
cgroup.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c46016bb25eb..0da79e116a07 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -344,6 +344,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+	css_put(&memcg->css);
+}
+
 #define mem_cgroup_from_counter(counter, member)	\
 	container_of(counter, struct mem_cgroup, member)
 
@@ -789,6 +794,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
 	return true;
 }
 
+static inline void mem_cgroup_put(struct mem_cgroup *memcg)
+{
+}
+
 static inline struct mem_cgroup *
 mem_cgroup_iter(struct mem_cgroup *root,
 		struct mem_cgroup *prev,
-- 
2.16.2.395.g2e18187dfd-goog
