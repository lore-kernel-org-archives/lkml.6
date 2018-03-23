Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeCWXNq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:13:46 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37845 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbeCWXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:13:41 -0400
X-Google-Smtp-Source: AG47ELvPsgN8l4YUJiYTqOMYVOeZ1UpnReDJ/S5Yk+R0jOD9RP2SQ+iAPWnaMjeQA+TR75TkoGcR8w==
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/8] cgroup: Add memory barriers to plug cgroup_rstat_updated() race window
Date: Fri, 23 Mar 2018 16:13:13 -0700
Message-Id: <20180323231313.1254142-9-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180323231313.1254142-1-tj@kernel.org>
References: <20180323231313.1254142-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup_rstat_updated() has a small race window where an updated
signaling can race with flush and could be lost till the next update.
This wasn't a problem for the existing usages, but we plan to use
rstat to track counters which need to be accurate.

This patch plugs the race window by synchronizing
cgroup_rstat_updated() and flush path with memory barriers around
cgroup_rstat_cpu->updated_next pointer.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/rstat.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 18b464a..662d7ae 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -28,9 +28,12 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	unsigned long flags;
 
 	/*
-	 * Speculative already-on-list test.  This may race leading to
-	 * temporary inaccuracies, which is fine.
-	 *
+	 * Paired with the one in cgroup_rstat_cpu_pop_upated().  Either we
+	 * see NULL updated_next or they see our updated stat.
+	 */
+	smp_mb();
+
+	/*
 	 * Because @parent's updated_children is terminated with @parent
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
@@ -125,6 +128,13 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 
 		*nextp = rstatc->updated_next;
 		rstatc->updated_next = NULL;
+
+		/*
+		 * Paired with the one in cgroup_rstat_cpu_updated().
+		 * Either they see NULL updated_next or we see their
+		 * updated stat.
+		 */
+		smp_mb();
 	}
 
 	return pos;
-- 
2.9.5
