Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBUTOr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:14:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeBUTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:14:41 -0500
Date: Wed, 21 Feb 2018 20:14:39 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Rue <dan.rue@linaro.org>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] hugetlb: fix surplus pages accounting
Message-ID: <20180221191439.GM2231@dhcp22.suse.cz>
References: <20180103093213.26329-1-mhocko@kernel.org>
 <20180103093213.26329-6-mhocko@kernel.org>
 <20180221042457.uolmhlmv5je5dqx7@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221042457.uolmhlmv5je5dqx7@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so here we go with the fix.

>From bc55c70ca2325f3305a80cfca5731f9550205589 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 21 Feb 2018 19:47:33 +0100
Subject: [PATCH] hugetlb: fix surplus pages accounting

Dan Rue has noticed that libhugetlbfs test suite fails counter test:

root@localhost:~# mount_point="/mnt/hugetlb/"
root@localhost:~# echo 200 > /proc/sys/vm/nr_hugepages
root@localhost:~# mkdir -p "${mount_point}"
root@localhost:~# mount -t hugetlbfs hugetlbfs "${mount_point}"
root@localhost:~# export LD_LIBRARY_PATH=/root/libhugetlbfs/libhugetlbfs-2.20/obj64
root@localhost:~# /root/libhugetlbfs/libhugetlbfs-2.20/tests/obj64/counters
Starting testcase "/root/libhugetlbfs/libhugetlbfs-2.20/tests/obj64/counters", pid 3319
Base pool size: 0
Clean...
FAIL    Line 326: Bad HugePages_Total: expected 0, actual 1

The bug was bisected to 0c397daea1d4 ("mm, hugetlb: further simplify
hugetlb allocation API"). The reason is that alloc_surplus_huge_page misaccounts
per node surplus pages. We should increase surplus_huge_pages_node rather than
nr_huge_pages_node which is already handled by alloc_fresh_huge_page.

Fixes: 0c397daea1d4 ("mm, hugetlb: further simplify hugetlb allocation API")
Reported-by: Dan Rue <dan.rue@linaro.org>
Tested-by: Dan Rue <dan.rue@linaro.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c204e3d132b..a963f2034dfc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1583,7 +1583,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		page = NULL;
 	} else {
 		h->surplus_huge_pages++;
-		h->nr_huge_pages_node[page_to_nid(page)]++;
+		h->surplus_huge_pages_node[page_to_nid(page)]++;
 	}
 
 out_unlock:
-- 
2.16.1

-- 
Michal Hocko
SUSE Labs
