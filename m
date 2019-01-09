Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACD7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfAITVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:21:21 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34069 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728279AbfAITVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:21:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THtvvDg_1547061291;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THtvvDg_1547061291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jan 2019 03:14:59 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/5] mm: memcontrol: add may_swap parameter to mem_cgroup_force_empty()
Date:   Thu, 10 Jan 2019 03:14:42 +0800
Message-Id: <1547061285-100329-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_force_empty() will be reused by the following patch which
does memory reclaim when offlining.  It is unnecessary to do swap in that
path, but force_empty still needs keep intact since it is also used by
other usecases per Shakeel.

So, introduce may_swap parameter to mem_cgroup_force_empty().  This is
the preparation for the following patch.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b..eaa3970 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2878,7 +2878,7 @@ static inline bool memcg_has_children(struct mem_cgroup *memcg)
  *
  * Caller is responsible for holding css reference for memcg.
  */
-static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
+static int mem_cgroup_force_empty(struct mem_cgroup *memcg, bool may_swap)
 {
 	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 
@@ -2895,7 +2895,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		progress = try_to_free_mem_cgroup_pages(memcg, 1,
-							GFP_KERNEL, true);
+							GFP_KERNEL, may_swap);
 		if (!progress) {
 			nr_retries--;
 			/* maybe some writeback is necessary */
@@ -2915,7 +2915,7 @@ static ssize_t mem_cgroup_force_empty_write(struct kernfs_open_file *of,
 
 	if (mem_cgroup_is_root(memcg))
 		return -EINVAL;
-	return mem_cgroup_force_empty(memcg) ?: nbytes;
+	return mem_cgroup_force_empty(memcg, true) ?: nbytes;
 }
 
 static u64 mem_cgroup_hierarchy_read(struct cgroup_subsys_state *css,
-- 
1.8.3.1

