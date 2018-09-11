Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6089EC46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E753C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yE9q03bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E753C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeIKFjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:39:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKFjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:39:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B0clcb087637;
        Tue, 11 Sep 2018 00:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=AYffcWNGUXpctZYcdeMQTwk8kPozUsCUImBciAV0wPQ=;
 b=yE9q03bGg4DiTrzu//XkMz0lWNcWcMHJRdVcfQidV3VrlNKaKs91rjE0E5osBLaYN1QS
 9/b5H7DspSjo409QRAhFRZBAm+3yiIEBCLldWsPSvUnAc1khkA8bjZyATQMs2y+RY0w4
 Di3rFSVnxWPxbTzqocWWlm3ZPsPzQ1+PiErwTJp3HWKpcBJwSss0FajR+i7jXjm4cKGK
 D6UthFjwuorYfjBVp24QCf7XKFwj4lGDXlYx7iRdLPjewj8MTpAg5QtxXCFY7xNSZRSy
 W22Cu/tezk62jWB5yfW55DXrDx/wEFHhXRKUFvaMUY+0pWIBOaRyBXAhwAcM4Sw9tGOt Sw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mc6cph1fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:42:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0gmR3008962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:42:48 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8B0gmw1018658;
        Tue, 11 Sep 2018 00:42:48 GMT
Received: from localhost.localdomain (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 17:42:47 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        dave.dice@oracle.com, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, levyossi@icloud.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mhocko@kernel.org, Pavel.Tatashin@microsoft.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com,
        vdavydov.dev@gmail.com, ying.huang@intel.com
Subject: [RFC PATCH v2 1/8] mm, memcontrol.c: make memcg lru stats thread-safe without lru_lock
Date:   Mon, 10 Sep 2018 20:42:33 -0400
Message-Id: <20180911004240.4758-2-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
References: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lru_lock needs to be held to update memcg LRU statistics.  This
requirement arises fairly naturally based on when the stats are updated
because callers are holding lru_lock already.

In preparation for allowing concurrent adds and removes from the LRU,
however, make concurrent updates to these statistics safe without
lru_lock.  The lock continues to be held until later in the series, when
it is replaced with a rwlock that also disables preemption, maintaining
the assumption of __mod_lru_zone_size, which is introduced here.

Follow the existing pattern for statistics in memcontrol.h by using a
combination of per-cpu counters and atomics.

Remove the negative statistics warning from ca707239e8a7 ("mm:
update_lru_size warn and reset bad lru_size").  Although an earlier
version of this patch updated the warning to account for the error
introduced by the per-cpu counters, Hugh says this warning has not been
seen in the wild and that for simplicity's sake it should probably just
be removed.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/memcontrol.h | 43 +++++++++++++++++++++++++++++---------
 mm/memcontrol.c            | 29 +++++++------------------
 2 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..6377dc76dc41 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -99,7 +99,8 @@ struct mem_cgroup_reclaim_iter {
 };
 
 struct lruvec_stat {
-	long count[NR_VM_NODE_STAT_ITEMS];
+	long node[NR_VM_NODE_STAT_ITEMS];
+	long lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 };
 
 /*
@@ -109,9 +110,8 @@ struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
 	struct lruvec_stat __percpu *lruvec_stat_cpu;
-	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
-
-	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
+	atomic_long_t		node_stat[NR_VM_NODE_STAT_ITEMS];
+	atomic_long_t		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
@@ -446,7 +446,7 @@ unsigned long mem_cgroup_get_lru_size(struct lruvec *lruvec, enum lru_list lru)
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	for (zid = 0; zid < MAX_NR_ZONES; zid++)
-		nr_pages += mz->lru_zone_size[zid][lru];
+		nr_pages += atomic64_read(&mz->lru_zone_size[zid][lru]);
 	return nr_pages;
 }
 
@@ -457,7 +457,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	struct mem_cgroup_per_node *mz;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	return mz->lru_zone_size[zone_idx][lru];
+	return atomic64_read(&mz->lru_zone_size[zone_idx][lru]);
 }
 
 void mem_cgroup_handle_over_high(void);
@@ -575,7 +575,7 @@ static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = atomic_long_read(&pn->lruvec_stat[idx]);
+	x = atomic_long_read(&pn->node_stat[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -601,12 +601,12 @@ static inline void __mod_lruvec_state(struct lruvec *lruvec,
 	__mod_memcg_state(pn->memcg, idx, val);
 
 	/* Update lruvec */
-	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
+	x = val + __this_cpu_read(pn->lruvec_stat_cpu->node[idx]);
 	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
-		atomic_long_add(x, &pn->lruvec_stat[idx]);
+		atomic_long_add(x, &pn->node_stat[idx]);
 		x = 0;
 	}
-	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	__this_cpu_write(pn->lruvec_stat_cpu->node[idx], x);
 }
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
@@ -619,6 +619,29 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	local_irq_restore(flags);
 }
 
+/**
+ * __mod_lru_zone_size - update memcg lru statistics in batches
+ *
+ * Updates memcg lru statistics using per-cpu counters that spill into atomics
+ * above a threshold.
+ *
+ * Assumes that the caller has disabled preemption.  IRQs may be enabled
+ * because this function is not called from irq context.
+ */
+static inline void __mod_lru_zone_size(struct mem_cgroup_per_node *pn,
+				       enum lru_list lru, int zid, int val)
+{
+	long x;
+	struct lruvec_stat __percpu *lruvec_stat_cpu = pn->lruvec_stat_cpu;
+
+	x = val + __this_cpu_read(lruvec_stat_cpu->lru_zone_size[zid][lru]);
+	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+		atomic_long_add(x, &pn->lru_zone_size[zid][lru]);
+		x = 0;
+	}
+	__this_cpu_write(lruvec_stat_cpu->lru_zone_size[zid][lru], x);
+}
+
 static inline void __mod_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2bd3df3d101a..5463ad160e10 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -962,36 +962,20 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
  * @zid: zone id of the accounted pages
  * @nr_pages: positive when adding or negative when removing
  *
- * This function must be called under lru_lock, just before a page is added
- * to or just after a page is removed from an lru list (that ordering being
- * so as to allow it to check that lru_size 0 is consistent with list_empty).
+ * This function must be called just before a page is added to, or just after a
+ * page is removed from, an lru list.  Callers aren't required to hold lru_lock
+ * because these statistics use per-cpu counters and atomics.
  */
 void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 				int zid, int nr_pages)
 {
 	struct mem_cgroup_per_node *mz;
-	unsigned long *lru_size;
-	long size;
 
 	if (mem_cgroup_disabled())
 		return;
 
 	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	lru_size = &mz->lru_zone_size[zid][lru];
-
-	if (nr_pages < 0)
-		*lru_size += nr_pages;
-
-	size = *lru_size;
-	if (WARN_ONCE(size < 0,
-		"%s(%p, %d, %d): lru_size %ld\n",
-		__func__, lruvec, lru, nr_pages, size)) {
-		VM_BUG_ON(1);
-		*lru_size = 0;
-	}
-
-	if (nr_pages > 0)
-		*lru_size += nr_pages;
+	__mod_lru_zone_size(mz, lru, zid, nr_pages);
 }
 
 bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg)
@@ -1833,9 +1817,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 				struct mem_cgroup_per_node *pn;
 
 				pn = mem_cgroup_nodeinfo(memcg, nid);
-				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
+				x = this_cpu_xchg(pn->lruvec_stat_cpu->node[i],
+						  0);
 				if (x)
-					atomic_long_add(x, &pn->lruvec_stat[i]);
+					atomic_long_add(x, &pn->node_stat[i]);
 			}
 		}
 
-- 
2.18.0

