Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCWPUy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:20:54 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751551AbeCWPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:20:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 3/4] mm/vmscan: Don't change pgdat state on base of a single LRU list state.
Date: Fri, 23 Mar 2018 18:20:28 +0300
Message-Id: <20180323152029.11084-4-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323152029.11084-1-aryabinin@virtuozzo.com>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::21) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f72fea96-9ebf-438d-81e9-08d590d18c94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:JXaANmOMp3vjpyvMiJ5tf0J0dxEg06fwkfh45rV/KBdLJN0YoR6WrglIbmoBqAqC9NCD4z2+bpsQaXHtn7YbKpuvAC3W5aTSxKFl4Ok7A7e5haSEyXp227dP40nJvriHKGUOhv8WX/oDsLY0g6283orLf47jyHAzWgGvG8OzJcchr+1yZj+oQ6lX7q2CUxmJZsNyDmJ3V23j6i6e/oxOk/Doh0xNF81eDpsi3QROmzVyf023WDzwnu53yriqovMg;25:e7RcvP6Alravj1fZuAWX6jnnWaXTRbXYa6v5JPii7Iw9QS51Ls9yRbL2PRDCLbROavGiSfgi8LgrDt4mFO/HqWc3fMmV9QBKTlgPNzWHFdIWyF8BlOsQlVaLqokekUahKyLEeEeVvLJLiKft1sk2CeRz2Y2ZzzsOWJsMn3gEbidp1/5QgGsy63Q8L83oeoI7iScWtbG5022dsTQl5InRCJUTpQEE2fX76i4lJeHxqFwY4XkTuc9uR4uMQ33J1d8Qs1iwxU1xvfu/k9a2Har4U8izNeVqwQ/wLN9S1NnET6Kmhv3swU2GhOrRDSIjpxzDsZ0ZmDESUiGsGhI6DmO3TQ==;31:Q4SWur+ol4s0doqGb/cFcz6yX2J+wHsnmgMJqXcdWInai7NuNrh85vwQRkrGr7wmxEBw0KfCfDAjOzje8k/Gdh+EWN9vYDdIj1YAGdsLc9yNlDmU8U9a98EcXufU/grWcfHppkLgkwFspA8cnJjseVqKUXZ+M8U2/ESDwgcYHcCqmPemcMx1xAicoG5e33wuvJil97CPsfWhKzbUEYklF+l6XdPJePI14f+ccnOfEPM=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:DEi1Ujl23/cxcBonYnkIJiAe4fZayGy2OilH7T57JE5TdVEBJEhxM4397TJVsJ6iPJXE6LA3ZBQJniEaoKqMZRPVCujISrH2r0mgBL8lGLz9wT4xbuoRv2rHcMtHO6sDRCVu9wWO7DbGa1AVPi6pQ2Qw2U/5WbmxjbQeMgW81D2ErGxX21m/v7itnZdzQ94bfuBhhzriZOPVjwqViQJUSXEzREz3MnCRcv2Q2XtVuk686buZ/L7K0wGfMFRHGiu8HqoOYPO8f35x6kv+no6gYFqDd5AKmol51BUbZ/Rbw854NA+q6obWkkrdPobKyxWKvCHQCyFjO9yyM3fCY/PHQbbCl+eExAeLd0yYt0bKb8ibxEn3VwR4WkaTpMYfYrbbL2ejjMxXhEINM9bRjxJo6lB3vKXQIBJ6+w0NXlioBT5FgiEVEAzBigjUl1WT7UBjo5v/ssOYB8uUDYWq87URA052HjcZyRIhLyDnuNUq/59RuhzJjWKsT8LQlbuVOrk+;4:OZlVddVM8sjLmwOXx8VAtG8WHodcNaWLG3P9CuJIklqpR58WB79Al6JqGAFmiWYjfmWu3712UrmJwR1Q7SA/MB0RbevGfsdGoXOSfIAyN56vSjO0pWKTnTdglaf0RZFa1TcjkH8CUM8uoYOscFkwSQyHTirex6j2DlOqxLA85wbEg1/mVaGLMpefoq3NpzfEO9LXsaMGtEpv4v3CHN/HemezRz0mmIm21Egfs58iIyzblPksapOwTBHtJkrrThdx4Dbr0Bhgxh3U4vewx1nQvQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253FC086CB36F5E36DCC430B0A80@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(39380400002)(366004)(396003)(376002)(189003)(199004)(36756003)(25786009)(186003)(97736004)(1076002)(3846002)(53416004)(478600001)(48376002)(11346002)(50466002)(66066001)(47776003)(105586002)(106356001)(53936002)(305945005)(6512007)(4326008)(7736002)(50226002)(81156014)(8936002)(52116002)(6666003)(54906003)(76176011)(81166006)(386003)(86362001)(6506007)(7416002)(2906002)(51416003)(316002)(68736007)(55236004)(6486002)(446003)(6116002)(6916009)(5660300001)(16586007)(8676002)(26005)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3253;23:51YyV6JCdOERJxbBDV2omvG8/uIOo3uIYdyyo18U6?=
 =?us-ascii?Q?IzqhCddlz4WCropuJfDLQihOhslKxr2MiwVuj/FIGNUniGu/sY6FUiTcfSC8?=
 =?us-ascii?Q?ZfqIfxfyXPxoD6fi7ulmFJ1jI4rv/jlPzXKKzxk3XZUbJahduSrooLbJH4oc?=
 =?us-ascii?Q?25iq1bXnHAaObTjYAzeIvGtmFcFPmxPq3RSlyibJ0ixawfLKfSY3HWXbTNQe?=
 =?us-ascii?Q?8y/uBR+kh3Y1N70fg5p7IKoZFWIiP0fjevwqJbQiJnaZLA+WuNPkxYlFJ+fG?=
 =?us-ascii?Q?Ez6/zu6l41AqK+wihkb8FdF2Tlz2gE2ZWBtAgPDuir0Bmpi5+d4mfIBSA89/?=
 =?us-ascii?Q?kyEzhkgp6RYR3/Sm3+hJcix7VzzSNbH6CZuEfrhq9sGHh+ad5zooOo4p3iI/?=
 =?us-ascii?Q?oU8bke4qSeTk9PC6xRj3rBDfjVJpu0gleO4HsKXqcb83V//0kA3M6sPWkbVv?=
 =?us-ascii?Q?tZVFXcWOPInIWpW8HSSyZIhy9lghgKo43SzWdtyXNbvRgP71yUf/Twig7Oo7?=
 =?us-ascii?Q?u0h3Vzjdefouhz+ejv3DyZZP4+QXKXUKepBS8Q8vUV95dUtZw1jp28zLeweZ?=
 =?us-ascii?Q?4nITQ89cc4wpyrbCgfDej1JNm5NiyGen6n4+iLhWdrM/90myJlQa7TJscigq?=
 =?us-ascii?Q?bN5yGfhSI6O/IR7U0A9WlDkBTb/L5aqoMDOQ1bG5JfI8fLTlc5oix/Sb4Cxo?=
 =?us-ascii?Q?2bJBYGQC/3RWzX+KwvPKrsLODDkHGxKvDp5M22eJ/QktzFzs36jz2YfWRBNy?=
 =?us-ascii?Q?fBJtZ8D16lMjp5kxlMK4uZgmBXNvm8aKI+cquczvrEI2+Wm1Ns9iP0NA9NUT?=
 =?us-ascii?Q?gJ5qi0w7afkUjHl5iVeamDoS/GCSQOpTX2tr3Mlt2VMqn2qRMrbDnN3mRLNv?=
 =?us-ascii?Q?YUoLISQNUdlfSNCfuU0lGQF84cfl9KrmErkxE6gE/UOd/rUDeBf8iygu4F0i?=
 =?us-ascii?Q?q/gI8tQ2C1XP5HTSbtyHfA73z4y9bHGU+04TSKymeS+hDllAcO6aMuAQjaW/?=
 =?us-ascii?Q?vDYosX1CFzn2CgApFlm/NFz22Sex/bkTmuB6mfdQF0FtnEnrYujuP07AIOvf?=
 =?us-ascii?Q?CeMVNDBbNZxN8hwUwSlVgyidm9Vq/Pur3Jj1KW/2fy6oHbBcQD7t18Pbuhev?=
 =?us-ascii?Q?mjedrjD84esZcvis1iORzh3OpAAo8dmko67txMYlbwgxofE2LeibHo8uh83x?=
 =?us-ascii?Q?CNN7V0nkBWPCqeJOS56FEZUs6GBGy+/9n5J?=
X-Microsoft-Antispam-Message-Info: J0pZcBxEXrnf/rrVWI3q0ACePaacnkjhzccOP93D+6hnIOF6T6nu5Z/IqQsb2p1olA48PFWi+0iIyJYheg69zLW7HAo1+7BL9ajdsNdmjj6mTMYaNxSXVsyDt7/6w5AQXVtDRHdNxJFo3AHf8BPUaLqK6k+sCS331HAcZfuU6M3rHmD1kfNY2iPUt7w9+FqP
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:gPr0vEp0T9Acx1mAY/EP84U6mv/9ROglzKvFYOwTJWA2DeiOEpm83i/ZM7nNSFvhk7+EeEqht/CEVSKaVS0z2gKe6G0hNWdPY7JCJIph2pznaq5MMmfb4wHq+VxwgjIHKBV7IFpi6tm6erJ6nLCtkZe0OweZUniK410QGqwkEF18y2MK7J2r9DKs2Rc6GZNx/Kzxxh7yYVD56Ap9selbSfuL1ww+6GpaqaLDt58lwFTcDoqnzvwMpEWjovOoIuP+SZbPvH/W27hXwRyfVQ0KrYcpD0TAjWp71v8P+tfScfIw9d2edIGVGuyV37U8ud5he2A56W24ePZnzK6zHxU6REKPQlfR09j5s94Ih0CIkicuZc2CjbV5KVhHl8ihaCobU/bMdw8mfOVcFypQY6lXwYX1CvwN8IfPnsEsQX6f/URbBpf/NjbJpn+ffuHgcImomeh+vpCkqExC/NJfisgMdg==;5:HNFIeN+IVvkdOlymGjFc7jfJXjJIxzzoBfaR5QeUVKvJipTRH2r0f973aKDq+Z3CpPIJDMzjXOw1hksISqzE+7m1GUv0pPN7dMVgQTlJqm+Tup3wWSnGV1qrGEAxrqVRvUjO2xn1s+wOk1/33lHFYzdWgvr6AuHTpcspad4nlOw=;24:YLOUkYNWpihSf15TsEhqwVtWGjTiuUWkgyIJickCuqT5nMjjsu2i8wT3DCmhXnYNgyTfWQuqR50W+LYmjmRFu99ePFYgJWimh/Mn6jQ6a3Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:uom0ksAalsSFiP76k4eVmCTh7WAFtDmEjhOQt//Pc5nfPU21BMpLAhQlR2Wy1zAE/8FzFhVjRbQiZYjSU6BKyOFZEZUup0lSKduae/K5eGNWhejXglw8pquSdjL4+NQHpRS+rX+jisyimkQbJeNaLpgnbG11i6wEqKlTcejKhEF9YOMfsWFvhfvBsC9BgXdTxh3oJidFepbBCxxC/VOw1hGgWQ0Gfz8C7p6ZaWcG96PswZ1XlIKSa3I+Ltt8V5p/;20:xb7ZnjBYIRdkJuxfW9WnP/mxnp0cyqQr3jgCEiW+Ly65XsDbd0H/H8dY9tMWj/O9ogrQdzIAx5Oqi+mGiv3A45+Fnb0MOFYCP00mTmSLm8DVMyGEtCZq8UdHbGqwQwzBxTbBG043wNtOfxtldgMM5ecOzVYQsOXYWGc8sqjVAFk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:20:01.6400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72fea96-9ebf-438d-81e9-08d590d18c94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have separate LRU list for each memory cgroup. Memory reclaim iterates
over cgroups and calls shrink_inactive_list() every inactive LRU list.
Based on the state of a single LRU shrink_inactive_list() may flag
the whole node as dirty,congested or under writeback. This is obviously
wrong and hurtful. It's especially hurtful when we have possibly
small congested cgroup in system. Than *all* direct reclaims waste time
by sleeping in wait_iff_congested(). And the more memcgs in the system
we have the longer memory allocation stall is, because
wait_iff_congested() called on each lru-list scan.

Sum reclaim stats across all visited LRUs on node and flag node as dirty,
congested or under writeback based on that sum. Also call
congestion_wait(), wait_iff_congested() once per pgdat scan, instead of
once per lru-list scan.

This only fixes the problem for global reclaim case. Per-cgroup reclaim
may alter global pgdat flags too, which is wrong. But that is separate
issue and will be addressed in the next patch.

This change will not have any effect on a systems with all workload
concentrated in a single cgroup.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/vmscan.c | 124 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 73 insertions(+), 51 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 403f59edd53e..2134b3ac8fa0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -116,6 +116,15 @@ struct scan_control {
 
 	/* Number of pages freed so far during a call to shrink_zones() */
 	unsigned long nr_reclaimed;
+
+	struct {
+		unsigned int dirty;
+		unsigned int unqueued_dirty;
+		unsigned int congested;
+		unsigned int writeback;
+		unsigned int immediate;
+		unsigned int file_taken;
+	} nr;
 };
 
 #ifdef ARCH_HAS_PREFETCH
@@ -1754,23 +1763,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	mem_cgroup_uncharge_list(&page_list);
 	free_unref_page_list(&page_list);
 
-	/*
-	 * If reclaim is isolating dirty pages under writeback, it implies
-	 * that the long-lived page allocation rate is exceeding the page
-	 * laundering rate. Either the global limits are not being effective
-	 * at throttling processes due to the page distribution throughout
-	 * zones or there is heavy usage of a slow backing device. The
-	 * only option is to throttle from reclaim context which is not ideal
-	 * as there is no guarantee the dirtying process is throttled in the
-	 * same way balance_dirty_pages() manages.
-	 *
-	 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the number
-	 * of pages under pages flagged for immediate reclaim and stall if any
-	 * are encountered in the nr_immediate check below.
-	 */
-	if (stat.nr_writeback && stat.nr_writeback == nr_taken)
-		set_bit(PGDAT_WRITEBACK, &pgdat->flags);
-
 	/*
 	 * If dirty pages are scanned that are not queued for IO, it
 	 * implies that flushers are not doing their job. This can
@@ -1785,40 +1777,13 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (stat.nr_unqueued_dirty == nr_taken)
 		wakeup_flusher_threads(WB_REASON_VMSCAN);
 
-	/*
-	 * Legacy memcg will stall in page writeback so avoid forcibly
-	 * stalling here.
-	 */
-	if (sane_reclaim(sc)) {
-		/*
-		 * Tag a node as congested if all the dirty pages scanned were
-		 * backed by a congested BDI and wait_iff_congested will stall.
-		 */
-		if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
-			set_bit(PGDAT_CONGESTED, &pgdat->flags);
-
-		/* Allow kswapd to start writing pages during reclaim. */
-		if (stat.nr_unqueued_dirty == nr_taken)
-			set_bit(PGDAT_DIRTY, &pgdat->flags);
-
-		/*
-		 * If kswapd scans pages marked marked for immediate
-		 * reclaim and under writeback (nr_immediate), it implies
-		 * that pages are cycling through the LRU faster than
-		 * they are written so also forcibly stall.
-		 */
-		if (stat.nr_immediate)
-			congestion_wait(BLK_RW_ASYNC, HZ/10);
-	}
-
-	/*
-	 * Stall direct reclaim for IO completions if underlying BDIs and node
-	 * is congested. Allow kswapd to continue until it starts encountering
-	 * unqueued dirty pages or cycling through the LRU too quickly.
-	 */
-	if (!sc->hibernation_mode && !current_is_kswapd() &&
-	    current_may_throttle())
-		wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
+	sc->nr.dirty += stat.nr_dirty;
+	sc->nr.congested += stat.nr_congested;
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
+	sc->nr.writeback += stat.nr_writeback;
+	sc->nr.immediate += stat.nr_immediate;
+	if (file)
+		sc->nr.file_taken += nr_taken;
 
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			nr_scanned, nr_reclaimed,
@@ -2522,6 +2487,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long node_lru_pages = 0;
 		struct mem_cgroup *memcg;
 
+		memset(&sc->nr, 0, sizeof(sc->nr));
+
 		nr_reclaimed = sc->nr_reclaimed;
 		nr_scanned = sc->nr_scanned;
 
@@ -2587,6 +2554,61 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		if (sc->nr_reclaimed - nr_reclaimed)
 			reclaimable = true;
 
+		/*
+		 * If reclaim is isolating dirty pages under writeback, it
+		 * implies that the long-lived page allocation rate is exceeding
+		 * the page laundering rate. Either the global limits are not
+		 * being effective at throttling processes due to the page
+		 * distribution throughout zones or there is heavy usage of a
+		 * slow backing device. The only option is to throttle from
+		 * reclaim context which is not ideal as there is no guarantee
+		 * the dirtying process is throttled in the same way
+		 * balance_dirty_pages() manages.
+		 *
+		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the
+		 * number of pages under pages flagged for immediate reclaim and
+		 * stall if any are encountered in the nr_immediate check below.
+		 */
+		if (sc->nr.writeback && sc->nr.writeback == sc->nr.file_taken)
+			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
+
+		/*
+		 * Legacy memcg will stall in page writeback so avoid forcibly
+		 * stalling here.
+		 */
+		if (sane_reclaim(sc)) {
+			/*
+			 * Tag a node as congested if all the dirty pages
+			 * scanned were backed by a congested BDI and
+			 * wait_iff_congested will stall.
+			 */
+			if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
+				set_bit(PGDAT_CONGESTED, &pgdat->flags);
+
+			/* Allow kswapd to start writing pages during reclaim.*/
+			if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+				set_bit(PGDAT_DIRTY, &pgdat->flags);
+
+			/*
+			 * If kswapd scans pages marked marked for immediate
+			 * reclaim and under writeback (nr_immediate), it
+			 * implies that pages are cycling through the LRU
+			 * faster than they are written so also forcibly stall.
+			 */
+			if (sc->nr.immediate)
+				congestion_wait(BLK_RW_ASYNC, HZ/10);
+		}
+
+		/*
+		 * Stall direct reclaim for IO completions if underlying BDIs
+		 * and node is congested. Allow kswapd to continue until it
+		 * starts encountering unqueued dirty pages or cycling through
+		 * the LRU too quickly.
+		 */
+		if (!sc->hibernation_mode && !current_is_kswapd() &&
+		    current_may_throttle())
+			wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
+
 	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 					 sc->nr_scanned - nr_scanned, sc));
 
-- 
2.16.1
