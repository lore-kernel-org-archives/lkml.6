Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDFKJP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:09:15 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45824 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbeDFKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:09:14 -0400
X-Google-Smtp-Source: AIpwx4/Hzb3jAHUPBWak8ymV42Kg4A3xLm5Y2qaZ3zOR4pAlh/xS7gCCNItYQPSSPKKXU5zwaSyN7w==
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        syzbot+8a5de3cce7cdc70e9ebe@syzkaller.appspotmail.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] memcg: fix per_node_info cleanup
Date: Fri,  6 Apr 2018 12:09:06 +0200
Message-Id: <20180406100906.17790-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

syzbot has triggered a NULL ptr dereference when allocation fault
injection enforces a failure and alloc_mem_cgroup_per_node_info
initializes memcg->nodeinfo only half way through. __mem_cgroup_free
still tries to free all per-node data and dereferences pn->lruvec_stat_cpu
unconditioanlly even if the specific per-node data hasn't been
initialized.

The bug is quite unlikely to hit because small allocations do not fail
and we would need quite some numa nodes to make struct mem_cgroup_per_node
large enough to cross the costly order.

Reported-by: syzbot+8a5de3cce7cdc70e9ebe@syzkaller.appspotmail.com
Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi!
Previously posted [1] based on the syzkaller report [2]. I haven't heard
back from syzkaller but this seems like the right fix. Andrew could you
add this to the pile?

[1] http://lkml.kernel.org/r/20180403105048.GK5501@dhcp22.suse.cz
[2] http://lkml.kernel.org/r/001a113fe4c0a623b10568bb75ea@google.com

 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7667ea9daf4f..8c2ed1c2b72c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4340,6 +4340,9 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
+	if (!pn)
+		return;
+
 	free_percpu(pn->lruvec_stat_cpu);
 	kfree(pn);
 }
-- 
2.16.3
