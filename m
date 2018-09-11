Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F234C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4CF20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4CF20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeIKVkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:40:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbeIKVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:40:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BGdhVE046948
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:40:36 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mehd1040s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:40:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 17:40:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 17:40:28 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BGeRf766388160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 16:40:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46DE7A405B;
        Tue, 11 Sep 2018 19:40:16 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 793AFA404D;
        Tue, 11 Sep 2018 19:40:15 +0100 (BST)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Sep 2018 19:40:15 +0100 (BST)
Subject: Re: [RFC PATCH v2 2/8] mm: make zone_reclaim_stat updates thread-safe
To:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        dave.dice@oracle.com, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, levyossi@icloud.com,
        mgorman@techsingularity.net, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vdavydov.dev@gmail.com, ying.huang@intel.com
References: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
 <20180911004240.4758-3-daniel.m.jordan@oracle.com>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Tue, 11 Sep 2018 18:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911004240.4758-3-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18091116-0012-0000-0000-000002A743A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091116-0013-0000-0000-000020DB8178
Message-Id: <fe814c4f-f049-9b7f-0f4c-7238f159f144@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 02:42, Daniel Jordan wrote:
> lru_lock needs to be held to update the zone_reclaim_stat statistics.
> Similar to the previous patch, this requirement again arises fairly
> naturally because callers are holding lru_lock already.
> 
> In preparation for allowing concurrent adds and removes from the LRU,
> however, make concurrent updates to these statistics safe without
> lru_lock.  The lock continues to be held until later in the series, when
> it is replaced with a rwlock that also disables preemption, maintaining
> the assumption in the comment above __update_page_reclaim_stat, which is
> introduced here.
> 
> Use a combination of per-cpu counters and atomics.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
>  include/linux/mmzone.h | 50 ++++++++++++++++++++++++++++++++++++++++++
>  init/main.c            |  1 +
>  mm/memcontrol.c        | 20 ++++++++---------
>  mm/memory_hotplug.c    |  1 +
>  mm/mmzone.c            | 14 ++++++++++++
>  mm/swap.c              | 14 ++++++++----
>  mm/vmscan.c            | 42 ++++++++++++++++++++---------------
>  7 files changed, 110 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 32699b2dc52a..6d4c23a3069d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -229,6 +229,12 @@ struct zone_reclaim_stat {
>  	 *
>  	 * The anon LRU stats live in [0], file LRU stats in [1]
>  	 */
> +	atomic_long_t		recent_rotated[2];
> +	atomic_long_t		recent_scanned[2];

It might be better to use a slightly different name for these fields to
distinguish them from the ones in the zone_reclaim_stat_cpu structure.

> +};
> +
> +/* These spill into the counters in struct zone_reclaim_stat beyond a cutoff. */
> +struct zone_reclaim_stat_cpu {
>  	unsigned long		recent_rotated[2];
>  	unsigned long		recent_scanned[2];
>  };
> @@ -236,6 +242,7 @@ struct zone_reclaim_stat {
>  struct lruvec {
>  	struct list_head		lists[NR_LRU_LISTS];
>  	struct zone_reclaim_stat	reclaim_stat;
> +	struct zone_reclaim_stat_cpu __percpu *reclaim_stat_cpu;
>  	/* Evictions & activations on the inactive file list */
>  	atomic_long_t			inactive_age;
>  	/* Refaults at the time of last reclaim cycle */
> @@ -245,6 +252,47 @@ struct lruvec {
>  #endif
>  };
> 
> +#define	RECLAIM_STAT_BATCH	32U	/* From SWAP_CLUSTER_MAX */
> +
> +/*
> + * Callers of the below three functions that update reclaim stats must hold
> + * lru_lock and have preemption disabled.  Use percpu counters that spill into
> + * atomics to allow concurrent updates when multiple readers hold lru_lock.
> + */
> +
> +static inline void __update_page_reclaim_stat(unsigned long count,
> +					      unsigned long *percpu_stat,
> +					      atomic_long_t *stat)
> +{
> +	unsigned long val = *percpu_stat + count;
> +
> +	if (unlikely(val > RECLAIM_STAT_BATCH)) {
> +		atomic_long_add(val, stat);
> +		val = 0;
> +	}
> +	*percpu_stat = val;
> +}
> +
> +static inline void update_reclaim_stat_scanned(struct lruvec *lruvec, int file,
> +					       unsigned long count)
> +{
> +	struct zone_reclaim_stat_cpu __percpu *percpu_stat =
> +					 this_cpu_ptr(lruvec->reclaim_stat_cpu);
> +
> +	__update_page_reclaim_stat(count, &percpu_stat->recent_scanned[file],
> +				   &lruvec->reclaim_stat.recent_scanned[file]);
> +}
> +
> +static inline void update_reclaim_stat_rotated(struct lruvec *lruvec, int file,
> +					       unsigned long count)
> +{
> +	struct zone_reclaim_stat_cpu __percpu *percpu_stat =
> +					 this_cpu_ptr(lruvec->reclaim_stat_cpu);
> +
> +	__update_page_reclaim_stat(count, &percpu_stat->recent_rotated[file],
> +				   &lruvec->reclaim_stat.recent_rotated[file]);
> +}
> +
>  /* Mask used at gathering information at once (see memcontrol.c) */
>  #define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
>  #define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
> @@ -795,6 +843,8 @@ extern void init_currently_empty_zone(struct zone *zone, unsigned long start_pfn
>  				     unsigned long size);
> 
>  extern void lruvec_init(struct lruvec *lruvec);
> +extern void lruvec_init_late(struct lruvec *lruvec);
> +extern void lruvecs_init_late(void);
> 
>  static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
>  {
> diff --git a/init/main.c b/init/main.c
> index 3b4ada11ed52..80ad02fe99de 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -526,6 +526,7 @@ static void __init mm_init(void)
>  	init_espfix_bsp();
>  	/* Should be run after espfix64 is set up. */
>  	pti_init();
> +	lruvecs_init_late();
>  }
> 
>  asmlinkage __visible void __init start_kernel(void)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5463ad160e10..f7f9682482cd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3152,22 +3152,22 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		pg_data_t *pgdat;
>  		struct mem_cgroup_per_node *mz;
>  		struct zone_reclaim_stat *rstat;
> -		unsigned long recent_rotated[2] = {0, 0};
> -		unsigned long recent_scanned[2] = {0, 0};
> +		unsigned long rota[2] = {0, 0};
> +		unsigned long scan[2] = {0, 0};
> 
>  		for_each_online_pgdat(pgdat) {
>  			mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>  			rstat = &mz->lruvec.reclaim_stat;
> 
> -			recent_rotated[0] += rstat->recent_rotated[0];
> -			recent_rotated[1] += rstat->recent_rotated[1];
> -			recent_scanned[0] += rstat->recent_scanned[0];
> -			recent_scanned[1] += rstat->recent_scanned[1];
> +			rota[0] += atomic_long_read(&rstat->recent_rotated[0]);
> +			rota[1] += atomic_long_read(&rstat->recent_rotated[1]);
> +			scan[0] += atomic_long_read(&rstat->recent_scanned[0]);
> +			scan[1] += atomic_long_read(&rstat->recent_scanned[1]);
>  		}
> -		seq_printf(m, "recent_rotated_anon %lu\n", recent_rotated[0]);
> -		seq_printf(m, "recent_rotated_file %lu\n", recent_rotated[1]);
> -		seq_printf(m, "recent_scanned_anon %lu\n", recent_scanned[0]);
> -		seq_printf(m, "recent_scanned_file %lu\n", recent_scanned[1]);
> +		seq_printf(m, "recent_rotated_anon %lu\n", rota[0]);
> +		seq_printf(m, "recent_rotated_file %lu\n", rota[1]);
> +		seq_printf(m, "recent_scanned_anon %lu\n", scan[0]);
> +		seq_printf(m, "recent_scanned_file %lu\n", scan[1]);
>  	}
>  #endif
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 25982467800b..d3ebb11c3f9f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1009,6 +1009,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>  	/* init node's zones as empty zones, we don't have any present pages.*/
>  	free_area_init_node(nid, zones_size, start_pfn, zholes_size);
>  	pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> +	lruvec_init_late(node_lruvec(pgdat));
> 
>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> diff --git a/mm/mmzone.c b/mm/mmzone.c
> index 4686fdc23bb9..090cd4f7effb 100644
> --- a/mm/mmzone.c
> +++ b/mm/mmzone.c
> @@ -9,6 +9,7 @@
>  #include <linux/stddef.h>
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
> +#include <linux/percpu.h>
> 
>  struct pglist_data *first_online_pgdat(void)
>  {
> @@ -96,6 +97,19 @@ void lruvec_init(struct lruvec *lruvec)
>  		INIT_LIST_HEAD(&lruvec->lists[lru]);
>  }
> 
> +void lruvec_init_late(struct lruvec *lruvec)
> +{
> +	lruvec->reclaim_stat_cpu = alloc_percpu(struct zone_reclaim_stat_cpu);
> +}
> +
> +void lruvecs_init_late(void)
> +{
> +	pg_data_t *pgdat;
> +
> +	for_each_online_pgdat(pgdat)
> +		lruvec_init_late(node_lruvec(pgdat));
> +}
> +
>  #if defined(CONFIG_NUMA_BALANCING) && !defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS)
>  int page_cpupid_xchg_last(struct page *page, int cpupid)
>  {
> diff --git a/mm/swap.c b/mm/swap.c
> index 3dd518832096..219c234d632f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -34,6 +34,7 @@
>  #include <linux/uio.h>
>  #include <linux/hugetlb.h>
>  #include <linux/page_idle.h>
> +#include <linux/mmzone.h>
> 
>  #include "internal.h"
> 
> @@ -260,14 +261,19 @@ void rotate_reclaimable_page(struct page *page)
>  	}
>  }
> 
> +/*
> + * Updates page reclaim statistics using per-cpu counters that spill into
> + * atomics above a threshold.
> + *
> + * Assumes that the caller has disabled preemption.  IRQs may be enabled
> + * because this function is not called from irq context.
> + */
>  static void update_page_reclaim_stat(struct lruvec *lruvec,
>  				     int file, int rotated)
>  {
> -	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
> -
> -	reclaim_stat->recent_scanned[file]++;
> +	update_reclaim_stat_scanned(lruvec, file, 1);
>  	if (rotated)
> -		reclaim_stat->recent_rotated[file]++;
> +		update_reclaim_stat_rotated(lruvec, file, 1);
>  }
> 
>  static void __activate_page(struct page *page, struct lruvec *lruvec,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9270a4370d54..730b6d0c6c61 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1655,7 +1655,6 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>  static noinline_for_stack void
>  putback_inactive_pages(struct lruvec *lruvec, struct list_head *page_list)
>  {
> -	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	LIST_HEAD(pages_to_free);
> 
> @@ -1684,7 +1683,7 @@ putback_inactive_pages(struct lruvec *lruvec, struct list_head *page_list)
>  		if (is_active_lru(lru)) {
>  			int file = is_file_lru(lru);
>  			int numpages = hpage_nr_pages(page);
> -			reclaim_stat->recent_rotated[file] += numpages;
> +			update_reclaim_stat_rotated(lruvec, file, numpages);
>  		}
>  		if (put_page_testzero(page)) {
>  			__ClearPageLRU(page);
> @@ -1736,7 +1735,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	isolate_mode_t isolate_mode = 0;
>  	int file = is_file_lru(lru);
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> -	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
>  	bool stalled = false;
> 
>  	while (unlikely(too_many_isolated(pgdat, file, sc))) {
> @@ -1763,7 +1761,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  				     &nr_scanned, sc, isolate_mode, lru);
> 
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
> -	reclaim_stat->recent_scanned[file] += nr_taken;
> +	update_reclaim_stat_scanned(lruvec, file, nr_taken);
> 
>  	if (current_is_kswapd()) {
>  		if (global_reclaim(sc))
> @@ -1914,7 +1912,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	LIST_HEAD(l_active);
>  	LIST_HEAD(l_inactive);
>  	struct page *page;
> -	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
>  	unsigned nr_deactivate, nr_activate;
>  	unsigned nr_rotated = 0;
>  	isolate_mode_t isolate_mode = 0;
> @@ -1932,7 +1929,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  				     &nr_scanned, sc, isolate_mode, lru);
> 
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
> -	reclaim_stat->recent_scanned[file] += nr_taken;
> +	update_reclaim_stat_scanned(lruvec, file, nr_taken);
> 
>  	__count_vm_events(PGREFILL, nr_scanned);
>  	count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
> @@ -1989,7 +1986,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  	 * helps balance scan pressure between file and anonymous pages in
>  	 * get_scan_count.
>  	 */
> -	reclaim_stat->recent_rotated[file] += nr_rotated;
> +	update_reclaim_stat_rotated(lruvec, file, nr_rotated);
> 
>  	nr_activate = move_active_pages_to_lru(lruvec, &l_active, &l_hold, lru);
>  	nr_deactivate = move_active_pages_to_lru(lruvec, &l_inactive, &l_hold, lru - LRU_ACTIVE);
> @@ -2116,7 +2113,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  			   unsigned long *lru_pages)
>  {
>  	int swappiness = mem_cgroup_swappiness(memcg);
> -	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
> +	struct zone_reclaim_stat *rstat = &lruvec->reclaim_stat;
>  	u64 fraction[2];
>  	u64 denominator = 0;	/* gcc */
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> @@ -2125,6 +2122,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  	unsigned long anon, file;
>  	unsigned long ap, fp;
>  	enum lru_list lru;
> +	long recent_scanned[2], recent_rotated[2];
> 
>  	/* If we have no swap space, do not bother scanning anon pages. */
>  	if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
> @@ -2238,14 +2236,22 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  		lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
> 
>  	spin_lock_irq(&pgdat->lru_lock);
> -	if (unlikely(reclaim_stat->recent_scanned[0] > anon / 4)) {
> -		reclaim_stat->recent_scanned[0] /= 2;
> -		reclaim_stat->recent_rotated[0] /= 2;
> +	recent_scanned[0] = atomic_long_read(&rstat->recent_scanned[0]);
> +	recent_rotated[0] = atomic_long_read(&rstat->recent_rotated[0]);
> +	if (unlikely(recent_scanned[0] > anon / 4)) {
> +		recent_scanned[0] /= 2;
> +		recent_rotated[0] /= 2;
> +		atomic_long_set(&rstat->recent_scanned[0], recent_scanned[0]);
> +		atomic_long_set(&rstat->recent_rotated[0], recent_rotated[0]);
>  	}
> 
> -	if (unlikely(reclaim_stat->recent_scanned[1] > file / 4)) {
> -		reclaim_stat->recent_scanned[1] /= 2;
> -		reclaim_stat->recent_rotated[1] /= 2;
> +	recent_scanned[1] = atomic_long_read(&rstat->recent_scanned[1]);
> +	recent_rotated[1] = atomic_long_read(&rstat->recent_rotated[1]);
> +	if (unlikely(recent_scanned[1] > file / 4)) {
> +		recent_scanned[1] /= 2;
> +		recent_rotated[1] /= 2;
> +		atomic_long_set(&rstat->recent_scanned[1], recent_scanned[1]);
> +		atomic_long_set(&rstat->recent_rotated[1], recent_rotated[1]);
>  	}
> 
>  	/*
> @@ -2253,11 +2259,11 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  	 * proportional to the fraction of recently scanned pages on
>  	 * each list that were recently referenced and in active use.
>  	 */
> -	ap = anon_prio * (reclaim_stat->recent_scanned[0] + 1);
> -	ap /= reclaim_stat->recent_rotated[0] + 1;
> +	ap = anon_prio * (recent_scanned[0] + 1);
> +	ap /= recent_rotated[0] + 1;
> 
> -	fp = file_prio * (reclaim_stat->recent_scanned[1] + 1);
> -	fp /= reclaim_stat->recent_rotated[1] + 1;
> +	fp = file_prio * (recent_scanned[1] + 1);
> +	fp /= recent_rotated[1] + 1;
>  	spin_unlock_irq(&pgdat->lru_lock);
> 
>  	fraction[0] = ap;
> 

