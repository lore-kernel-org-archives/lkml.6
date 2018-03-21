Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeCUU7y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:59:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36596 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:59:51 -0400
X-Google-Smtp-Source: AG47ELsbENAwMmro4AZHm24DOWJyWHf+0n2rzYYwQ8QBrdP8mWq4ZL2l9cqDPzWF19NVcs83HjJQTA==
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] memcg, thp: do not invoke oom killer on thp charges
Date: Wed, 21 Mar 2018 21:59:28 +0100
Message-Id: <20180321205928.22240-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

David has noticed that THP memcg charge can trigger the oom killer
since 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
madvised allocations"). We have used an explicit __GFP_NORETRY
previously which ruled the OOM killer automagically.

Memcg charge path should be semantically compliant with the allocation
path and that means that if we do not trigger the OOM killer for costly
orders which should do the same in the memcg charge path as well.
Otherwise we are forcing callers to distinguish the two and use
different gfp masks which is both non-intuitive and bug prone. Not to
mention the maintenance burden.

Teach mem_cgroup_oom to bail out on costly order requests to fix the THP
issue as well as any other costly OOM eligible allocations to be added
in future.

Fixes: 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and madvised allocations")
Reported-by: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi,
this is an alternative patch to [1]. I strongly believe that using
different gfp masks for the allocation and memcg charging is to be
avoided as much as possible. There doesn't seem to be any good reason
why THP charges should be an exception here.

I would be tempted to mark this for stable even though we haven't seen
any unexpected memcg OOM killer reports since 4.8 which is quite some
time.

[1] http://lkml.kernel.org/r/alpine.DEB.2.20.1803191409420.124411@chino.kir.corp.google.com

 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1a917b5b7b7..08accbcd1a18 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1493,7 +1493,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 
 static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
-	if (!current->memcg_may_oom)
+	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
 		return;
 	/*
 	 * We are in the middle of the charge context here, so we
-- 
2.16.2
