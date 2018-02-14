Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030443AbeBNORn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:17:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030288AbeBNORl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:17:41 -0500
From: Jason Wang <jasowang@redhat.com>
To: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mst@redhat.com, Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, hannes@cmpxchg.org
Subject: [PATCH net] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in __cpu_map_entry_alloc()
Date: Wed, 14 Feb 2018 22:17:34 +0800
Message-Id: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're several implications after commit 0bf7800f1799 ("ptr_ring:
try vmalloc() when kmalloc() fails") with the using of vmalloc() since
can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
since cpumap try to call with GFP_ATOMIC. Fortunately, entry
allocation of cpumap can only be done through syscall path which means
GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
with GFP_KERNEL.

Reported-by: syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com
Fixes: 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails")
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: akpm@linux-foundation.org
Cc: dhowells@redhat.com
Cc: hannes@cmpxchg.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 kernel/bpf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index fbfdada6..a4bb0b3 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -334,7 +334,7 @@ static int cpu_map_kthread_run(void *data)
 static struct bpf_cpu_map_entry *__cpu_map_entry_alloc(u32 qsize, u32 cpu,
 						       int map_id)
 {
-	gfp_t gfp = GFP_ATOMIC|__GFP_NOWARN;
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct bpf_cpu_map_entry *rcpu;
 	int numa, err;
 
-- 
2.7.4
