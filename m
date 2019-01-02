Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB8DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D9C2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfABUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:06:26 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54289 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbfABUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:06:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THOz2-._1546459534;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THOz2-._1546459534)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Jan 2019 04:05:41 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: memcontrol: delay force empty to css offline
Date:   Thu,  3 Jan 2019 04:05:33 +0800
Message-Id: <1546459533-36247-4-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, force empty reclaims memory synchronously when writing to
memory.force_empty.  It may take some time to return and the afterwards
operations are blocked by it.  Although it can be interrupted by signal,
it still seems suboptimal.

Now css offline is handled by worker, and the typical usecase of force
empty is before memcg offline.  So, handling force empty in css offline
sounds reasonable.

The user may write into any value to memory.force_empty, but I'm
supposed the most used value should be 0 and 1.  To not break existing
applications, writing 0 or 1 still do force empty synchronously, any
other value will tell kernel to do force empty in css offline worker.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/cgroup-v1/memory.txt |  8 ++++++--
 include/linux/memcontrol.h         |  2 ++
 mm/memcontrol.c                    | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/cgroup-v1/memory.txt b/Documentation/cgroup-v1/memory.txt
index 8e2cb1d..313d45f 100644
--- a/Documentation/cgroup-v1/memory.txt
+++ b/Documentation/cgroup-v1/memory.txt
@@ -452,11 +452,15 @@ About use_hierarchy, see Section 6.
 
 5.1 force_empty
   memory.force_empty interface is provided to make cgroup's memory usage empty.
-  When writing anything to this
+  When writing 0 or 1 to this
 
   # echo 0 > memory.force_empty
 
-  the cgroup will be reclaimed and as many pages reclaimed as possible.
+  the cgroup will be reclaimed and as many pages reclaimed as possible
+  synchronously.
+
+  Writing any other value to this, the cgroup will delay the memory reclaim
+  to css offline.
 
   The typical use case for this interface is before calling rmdir().
   Though rmdir() offlines memcg, but the memcg may still stay there due to
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7ab2120..48a5cf2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -311,6 +311,8 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;
 
+	bool delayed_force_empty;
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bbf39b5..620b6c5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2888,10 +2888,25 @@ static ssize_t mem_cgroup_force_empty_write(struct kernfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
+	unsigned long val;
+	ssize_t ret;
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 
 	if (mem_cgroup_is_root(memcg))
 		return -EINVAL;
+
+	buf = strstrip(buf);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != 0 && val != 1) {
+		memcg->delayed_force_empty = true;
+		return nbytes;
+	}
+
+	memcg->delayed_force_empty = false;
 	return mem_cgroup_force_empty(memcg) ?: nbytes;
 }
 
@@ -4531,6 +4546,9 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup_event *event, *tmp;
 
+	if (memcg->delayed_force_empty)
+		mem_cgroup_force_empty(memcg);
+
 	/*
 	 * Unregister events and notify userspace.
 	 * Notify userspace about cgroup removing only after rmdir of cgroup
-- 
1.8.3.1

