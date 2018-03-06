Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeCFWkr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:40:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754306AbeCFWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:40:46 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@oracle.com, m.mizuma@jp.fujitsu.com,
        akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: might_sleep warning
Date: Tue,  6 Mar 2018 17:40:04 -0500
Message-Id: <20180306224004.25150-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060243
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

Also, as noticed by Andrew, change spin_lock to spin_lock_irq, in order
to disable interrupts and avoid possible deadlock with
deferred_grow_zone().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/page_alloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b337a026007c..5df1ca40a2ff 100644
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
-	spin_lock(&deferred_zone_grow_lock);
+	spin_lock_irq(&deferred_zone_grow_lock);
+	deferred_zone_grow = false;
+	spin_unlock_irq(&deferred_zone_grow_lock);
 	static_branch_disable(&deferred_pages);
-	spin_unlock(&deferred_zone_grow_lock);
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
-- 
2.16.2
