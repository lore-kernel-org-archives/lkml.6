Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeCFTVD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:21:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeCFTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:21:02 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@oracle.com, m.mizuma@jp.fujitsu.com,
        akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: might_sleep warning
Date: Tue,  6 Mar 2018 14:20:22 -0500
Message-Id: <20180306192022.28289-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robot reported this issue:
https://lkml.org/lkml/2018/2/27/851

That is introduced by:
mm: initialize pages on demand during boot

The problem is caused by changing static branch value within spin lock.
Spin lock disables preemption, and changing static branch value takes
mutex lock in its path, and thus may sleep.

The fix is to add another boolean variable to avoid the need to change
static branch within spinlock.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b337a026007c..52edc6695b2b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1579,6 +1579,7 @@ static int __init deferred_init_memmap(void *data)
  * page_alloc_init_late() soon after smp_init() is complete.
  */
 static __initdata DEFINE_SPINLOCK(deferred_zone_grow_lock);
+static bool deferred_zone_grow __initdata = true;
 static DEFINE_STATIC_KEY_TRUE(deferred_pages);
 
 /*
@@ -1616,7 +1617,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
 	 * Bail if we raced with another thread that disabled on demand
 	 * initialization.
 	 */
-	if (!static_branch_unlikely(&deferred_pages)) {
+	if (!static_branch_unlikely(&deferred_pages) || !deferred_zone_grow) {
 		spin_unlock_irqrestore(&deferred_zone_grow_lock, flags);
 		return false;
 	}
@@ -1683,10 +1684,15 @@ void __init page_alloc_init_late(void)
 	/*
 	 * We are about to initialize the rest of deferred pages, permanently
 	 * disable on-demand struct page initialization.
+	 *
+	 * Note: it is prohibited to modify static branches in non-preemptible
+	 * context. Since, spin_lock() disables preemption, we must use an
+	 * extra boolean deferred_zone_grow.
 	 */
 	spin_lock(&deferred_zone_grow_lock);
-	static_branch_disable(&deferred_pages);
+	deferred_zone_grow = false;
 	spin_unlock(&deferred_zone_grow_lock);
+	static_branch_disable(&deferred_pages);
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
-- 
2.16.2
