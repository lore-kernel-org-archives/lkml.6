Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC05DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A236321900
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfAEAXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:23:18 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40191 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfAEAXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:23:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THYi1he_1546647563;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THYi1he_1546647563)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Jan 2019 08:19:30 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/5] doc: memcontrol: fix the obsolete content about force empty
Date:   Sat,  5 Jan 2019 08:19:16 +0800
Message-Id: <1546647560-40026-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't do page cache reparent anymore when offlining memcg, so update
force empty related content accordingly.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/cgroup-v1/memory.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/cgroup-v1/memory.txt b/Documentation/cgroup-v1/memory.txt
index 3682e99..8e2cb1d 100644
--- a/Documentation/cgroup-v1/memory.txt
+++ b/Documentation/cgroup-v1/memory.txt
@@ -70,7 +70,7 @@ Brief summary of control files.
  memory.soft_limit_in_bytes	 # set/show soft limit of memory usage
  memory.stat			 # show various statistics
  memory.use_hierarchy		 # set/show hierarchical account enabled
- memory.force_empty		 # trigger forced move charge to parent
+ memory.force_empty		 # trigger forced page reclaim
  memory.pressure_level		 # set memory pressure notifications
  memory.swappiness		 # set/show swappiness parameter of vmscan
 				 (See sysctl's vm.swappiness)
@@ -459,8 +459,9 @@ About use_hierarchy, see Section 6.
   the cgroup will be reclaimed and as many pages reclaimed as possible.
 
   The typical use case for this interface is before calling rmdir().
-  Because rmdir() moves all pages to parent, some out-of-use page caches can be
-  moved to the parent. If you want to avoid that, force_empty will be useful.
+  Though rmdir() offlines memcg, but the memcg may still stay there due to
+  charged file caches. Some out-of-use page caches may keep charged until
+  memory pressure happens. If you want to avoid that, force_empty will be useful.
 
   Also, note that when memory.kmem.limit_in_bytes is set the charges due to
   kernel pages will still be seen. This is not considered a failure and the
-- 
1.8.3.1

