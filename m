Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeCRUY4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:24:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42228 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeCRUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:24:53 -0400
X-Google-Smtp-Source: AG47ELtk6e0qhgkpQbHyE6rdWWbk67KpSTJDf1iU0sFgBGfd31/puMRGyxEUCsH+4oqyArue0Tx7mw==
Date: Sun, 18 Mar 2018 13:24:51 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Shakeel Butt <shakeelb@google.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch -mm] mm: memcg: remote memcg charging for kmem allocations
 fix
In-Reply-To: <20180305182951.34462-2-shakeelb@google.com>
Message-ID: <alpine.DEB.2.20.1803181318530.241887@chino.kir.corp.google.com>
References: <20180305182951.34462-1-shakeelb@google.com> <20180305182951.34462-2-shakeelb@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix build warning for CONFIG_SLOB:

mm/memcontrol.c:706:27: warning: 'get_mem_cgroup' defined but not used [-Wunused-function]
static struct mem_cgroup *get_mem_cgroup(struct mem_cgroup *memcg)

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/memcontrol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -701,15 +701,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return memcg;
 }
 
-static struct mem_cgroup *get_mem_cgroup(struct mem_cgroup *memcg)
-{
-	rcu_read_lock();
-	if (!css_tryget_online(&memcg->css))
-		memcg = NULL;
-	rcu_read_unlock();
-	return memcg;
-}
-
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -2128,6 +2119,15 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 }
 
 #ifndef CONFIG_SLOB
+static struct mem_cgroup *get_mem_cgroup(struct mem_cgroup *memcg)
+{
+	rcu_read_lock();
+	if (!css_tryget_online(&memcg->css))
+		memcg = NULL;
+	rcu_read_unlock();
+	return memcg;
+}
+
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
