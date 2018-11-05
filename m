Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE69C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1D82081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8hcULPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1D82081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbeKFCT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:19:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38800 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbeKFCRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5Gs5AK097190;
        Mon, 5 Nov 2018 16:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=gmXHeNTucBAhP5oOOIcBjLrTNKwY0b2G6CBWPMLTzgY=;
 b=U8hcULPwR1YXjpnkRNNkZpVOXWU/iuEeoayHLOibvlpvwD2FGOJnGTMgEgA5eTw1DbsH
 1S6pGD1I2f50NUSo032DTf3iDHCtq116VySLP+wgy5MjHt5+noiydGbdMavzGqq6MQHe
 khYC4oYTcWvlJkb2d4WE2BEx3tnHsdBwDVlN8a6vju9tG7lNuSZ9TLqPe//nwRkAwKaM
 mSqOzUl3Pi7Jzo+qMFqcxrVvI35mTOfRCXOLSizTZjsh7r4Aqbk8nKZmfp/xcRAwDglj
 8GZuCo4rFzXVnqeINsOea8+2fWI6VY1o3TW3Qr5bMe6CM8addCfcPxvy/ONPJaUuLqLc 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nh33tr6bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 16:56:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuPw2005090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 16:56:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5GuP8O018749;
        Mon, 5 Nov 2018 16:56:25 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 08:56:25 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        daniel.m.jordan@oracle.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: [RFC PATCH v4 11/13] mm: parallelize deferred struct page initialization within each node
Date:   Mon,  5 Nov 2018 11:55:56 -0500
Message-Id: <20181105165558.11698-12-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred struct page initialization currently runs one thread per node,
but this is a bottleneck during boot on big machines, so use ktask
within each pgdatinit thread to parallelize the struct page
initialization, allowing the system to take better advantage of its
memory bandwidth.

Because the system is not fully up yet and most CPUs are idle, use more
than the default maximum number of ktask threads.  The kernel doesn't
know the memory bandwidth of a given system to get the most efficient
number of threads, so there's some guesswork involved.  In testing, a
reasonable value turned out to be about a quarter of the CPUs on the
node.

__free_pages_core used to increase the zone's managed page count by the
number of pages being freed.  To accommodate multiple threads, however,
account the number of freed pages with an atomic shared across the ktask
threads and bump the managed page count with it after ktask is finished.

Test:    Boot the machine with deferred struct page init three times

Machine: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz, 88 CPUs, 503G memory,
         2 sockets

kernel                   speedup   max time per   stdev
                                   node (ms)

baseline (4.15-rc2)                        5860     8.6
ktask                      9.56x            613    12.4

---

Machine: Intel(R) Xeon(R) CPU E7-8895 v3 @ 2.60GHz, 288 CPUs, 1T memory
         8 sockets

kernel                   speedup   max time per   stdev
                                   node (ms)
baseline (4.15-rc2)                        1261     1.9
ktask                      3.88x            325     5.0

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Suggested-by: Pavel Tatashin <Pavel.Tatashin@microsoft.com>
---
 mm/page_alloc.c | 91 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ae31839874b8..fe7b681567ba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -66,6 +66,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/ktask.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1275,7 +1276,6 @@ void __free_pages_core(struct page *page, unsigned int order)
 		set_page_count(p, 0);
 	}
 
-	page_zone(page)->managed_pages += nr_pages;
 	set_page_refcounted(page);
 	__free_pages(page, order);
 }
@@ -1340,6 +1340,7 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 	if (early_page_uninitialised(pfn))
 		return;
 	__free_pages_core(page, order);
+	page_zone(page)->managed_pages += 1UL << order;
 }
 
 /*
@@ -1477,23 +1478,31 @@ deferred_pfn_valid(int nid, unsigned long pfn,
 	return true;
 }
 
+struct deferred_args {
+	int nid;
+	int zid;
+	atomic64_t nr_pages;
+};
+
 /*
  * Free pages to buddy allocator. Try to free aligned pages in
  * pageblock_nr_pages sizes.
  */
-static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
-				       unsigned long end_pfn)
+static int __init deferred_free_pages(int nid, int zid, unsigned long pfn,
+				      unsigned long end_pfn)
 {
 	struct mminit_pfnnid_cache nid_init_state = { };
 	unsigned long nr_pgmask = pageblock_nr_pages - 1;
-	unsigned long nr_free = 0;
+	unsigned long nr_free = 0, nr_pages = 0;
 
 	for (; pfn < end_pfn; pfn++) {
 		if (!deferred_pfn_valid(nid, pfn, &nid_init_state)) {
 			deferred_free_range(pfn - nr_free, nr_free);
+			nr_pages += nr_free;
 			nr_free = 0;
 		} else if (!(pfn & nr_pgmask)) {
 			deferred_free_range(pfn - nr_free, nr_free);
+			nr_pages += nr_free;
 			nr_free = 1;
 			touch_nmi_watchdog();
 		} else {
@@ -1502,16 +1511,27 @@ static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
 	}
 	/* Free the last block of pages to allocator */
 	deferred_free_range(pfn - nr_free, nr_free);
+	nr_pages += nr_free;
+
+	return nr_pages;
+}
+
+static int __init deferred_free_chunk(unsigned long pfn, unsigned long end_pfn,
+				      struct deferred_args *args)
+{
+	unsigned long nr_pages = deferred_free_pages(args->nid, args->zid, pfn,
+						     end_pfn);
+	atomic64_add(nr_pages, &args->nr_pages);
+	return KTASK_RETURN_SUCCESS;
 }
 
 /*
  * Initialize struct pages.  We minimize pfn page lookups and scheduler checks
  * by performing it only once every pageblock_nr_pages.
- * Return number of pages initialized.
+ * Return number of pages initialized in deferred_args.
  */
-static unsigned long  __init deferred_init_pages(int nid, int zid,
-						 unsigned long pfn,
-						 unsigned long end_pfn)
+static int __init deferred_init_pages(int nid, int zid, unsigned long pfn,
+				      unsigned long end_pfn)
 {
 	struct mminit_pfnnid_cache nid_init_state = { };
 	unsigned long nr_pgmask = pageblock_nr_pages - 1;
@@ -1531,7 +1551,17 @@ static unsigned long  __init deferred_init_pages(int nid, int zid,
 		__init_single_page(page, pfn, zid, nid);
 		nr_pages++;
 	}
-	return (nr_pages);
+
+	return nr_pages;
+}
+
+static int __init deferred_init_chunk(unsigned long pfn, unsigned long end_pfn,
+				      struct deferred_args *args)
+{
+	unsigned long nr_pages = deferred_init_pages(args->nid, args->zid, pfn,
+						     end_pfn);
+	atomic64_add(nr_pages, &args->nr_pages);
+	return KTASK_RETURN_SUCCESS;
 }
 
 /* Initialise remaining memory on a node */
@@ -1540,13 +1570,15 @@ static int __init deferred_init_memmap(void *data)
 	pg_data_t *pgdat = data;
 	int nid = pgdat->node_id;
 	unsigned long start = jiffies;
-	unsigned long nr_pages = 0;
+	unsigned long nr_init = 0, nr_free = 0;
 	unsigned long spfn, epfn, first_init_pfn, flags;
 	phys_addr_t spa, epa;
 	int zid;
 	struct zone *zone;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
 	u64 i;
+	unsigned long nr_node_cpus;
+	struct ktask_node kn;
 
 	/* Bind memory initialisation thread to a local node if possible */
 	if (!cpumask_empty(cpumask))
@@ -1560,6 +1592,14 @@ static int __init deferred_init_memmap(void *data)
 		return 0;
 	}
 
+	/*
+	 * We'd like to know the memory bandwidth of the chip to calculate the
+	 * most efficient number of threads to start, but we can't.  In
+	 * testing, a good value for a variety of systems was a quarter of the
+	 * CPUs on the node.
+	 */
+	nr_node_cpus = DIV_ROUND_UP(cpumask_weight(cpumask), 4);
+
 	/* Sanity check boundaries */
 	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
 	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
@@ -1580,21 +1620,46 @@ static int __init deferred_init_memmap(void *data)
 	 * page in __free_one_page()).
 	 */
 	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
+		struct deferred_args args = { nid, zid, ATOMIC64_INIT(0) };
+		DEFINE_KTASK_CTL(ctl, deferred_init_chunk, &args,
+				 KTASK_PTE_MINCHUNK);
+		ktask_ctl_set_max_threads(&ctl, nr_node_cpus);
+
 		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
 		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
-		nr_pages += deferred_init_pages(nid, zid, spfn, epfn);
+
+		kn.kn_start	= (void *)spfn;
+		kn.kn_task_size	= (spfn < epfn) ? epfn - spfn : 0;
+		kn.kn_nid	= nid;
+		(void) ktask_run_numa(&kn, 1, &ctl);
+
+		nr_init += atomic64_read(&args.nr_pages);
 	}
 	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &spa, &epa, NULL) {
+		struct deferred_args args = { nid, zid, ATOMIC64_INIT(0) };
+		DEFINE_KTASK_CTL(ctl, deferred_free_chunk, &args,
+				 KTASK_PTE_MINCHUNK);
+		ktask_ctl_set_max_threads(&ctl, nr_node_cpus);
+
 		spfn = max_t(unsigned long, first_init_pfn, PFN_UP(spa));
 		epfn = min_t(unsigned long, zone_end_pfn(zone), PFN_DOWN(epa));
-		deferred_free_pages(nid, zid, spfn, epfn);
+
+		kn.kn_start	= (void *)spfn;
+		kn.kn_task_size	= (spfn < epfn) ? epfn - spfn : 0;
+		kn.kn_nid	= nid;
+		(void) ktask_run_numa(&kn, 1, &ctl);
+
+		nr_free += atomic64_read(&args.nr_pages);
 	}
 	pgdat_resize_unlock(pgdat, &flags);
 
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
+	VM_BUG_ON(nr_init != nr_free);
+
+	zone->managed_pages += nr_free;
 
-	pr_info("node %d initialised, %lu pages in %ums\n", nid, nr_pages,
+	pr_info("node %d initialised, %lu pages in %ums\n", nid, nr_free,
 					jiffies_to_msecs(jiffies - start));
 
 	pgdat_init_report_one_done();
-- 
2.19.1

