Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46595C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8720874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAEAVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:21:03 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44933 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfAEAVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:21:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THYi1he_1546647563;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THYi1he_1546647563)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Jan 2019 08:19:31 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/5] mm: memcontrol: bring force_empty into default hierarchy
Date:   Sat,  5 Jan 2019 08:19:19 +0800
Message-Id: <1546647560-40026-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default hierarchy doesn't support force_empty, but there are some
usecases which create and remove memcgs very frequently, and the
tasks in the memcg may just access the files which are unlikely
accessed by anyone else. So, we prefer force_empty the memcg before
rmdir'ing it to reclaim the page cache so that they don't get
accumulated to incur unnecessary memory pressure. Since the memory
pressure may incur direct reclaim to harm some latency sensitive
applications.

There is another patch which introduces asynchronous memory reclaim when
offlining, but the behavior of force_empty is still needed by some
usecases which want to get the memory reclaimed immediately.  So, bring
force_empty interface in default hierarchy too.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 14 ++++++++++++++
 mm/memcontrol.c                         |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7bf3f12..0290c65 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1289,6 +1289,20 @@ PAGE_SIZE multiple when read back.
 	Shows pressure stall information for memory. See
 	Documentation/accounting/psi.txt for details.
 
+  memory.force_empty
+        This interface is provided to make cgroup's memory usage empty.
+        When writing anything to this
+
+        # echo 0 > memory.force_empty
+
+        the cgroup will be reclaimed and as many pages reclaimed as possible.
+
+        The typical use case for this interface is before calling rmdir().
+        Though rmdir() offlines memcg, but the memcg may still stay there due to
+        charged file caches. Some out-of-use page caches may keep charged until
+        memory pressure happens. If you want to avoid that, force_empty will be
+        useful.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5a13c6b..c4a7dc7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5743,6 +5743,10 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 		.seq_show = wipe_on_offline_show,
 		.write_u64 = wipe_on_offline_write,
 	},
+	{
+		.name = "force_empty",
+		.write = mem_cgroup_force_empty_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
1.8.3.1

