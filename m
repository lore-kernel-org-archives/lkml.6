Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCOQqV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:46:21 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:63912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752295AbeCOQp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:45:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 5/6] mm/vmscan: Don't change pgdat state on base of a single LRU list state.
Date: Thu, 15 Mar 2018 19:45:52 +0300
Message-Id: <20180315164553.17856-5-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::22)
 To DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d0d8d9b-733f-40a1-96eb-08d58a943853
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:RTclPEC1wLwO2NxgTJLFz4T1JZSUeAyjIgdvFmdOBCBFHIK0mxIh5Q9cOckHhGDwoHXYxq0y2WwVvczmWOiKUrfqm9CxJIQmsDq2qszxx+lsYGCpRkBPim5iFYOzVoPkweL1BKP1qBn0T7hm6L+BcipMNxURQlF+PJmgB/r3cNrOWlWd39pjDvmwsGG9aqtWrW0aB2WYViengB9nLLrCpi4a97Rsb0dDcZduRoJLkAlfOSEtwOS+cFTF4VdQ6RZW;25:SYsWvm6OQ5hLa+ix3E0G6WCrWDIMBPBRq94kvqTCH7OnsqSObCx9srmdIYS+NWCpnVcjS6YNdv5J/Acszdua10XhrpTh8FhJqItHLkR15oXVOv1E0jm2ozw4fVwuSQKdZawui1bm+suwOpNfXchsEX6Il/zmAchugR54hiWt3J/KCazC+DyWZvy3zNDio1WDEOMEda8vY0/Q3U8vX5Z3SUFIBtHPV0ha/nVloUQFrtyvrmLLQMDrLJurprmvklmEOmWpEZcgcnVwP9K7XzDO4tYv+vl3CYY+0kWTkPFRmq27ehhF+g4Fd9BDZs356tpFFqhKSEOXYHnpuFjLQihWyQ==;31:bKwtPUPXW+N/MG+F0HXDpNl+YzuuRR6DlWNlmGIyzbSEbOdvBbMiK7z6xAxVykIzLDqnfU6sZnTIMT6VppJ9zv4Nhgy/qLfko7TE3KRKgY1hL8JGRSv59AKzUuQVL4UngtiGNevPnARjgEvnSH1PdrwaTwxDTZ15o+td0kno867iTKj7XkbfRpM40dzGwZWmraCH7Ko12AB436noMck5FU7Zmtc8IrQj0VL4G+KDoLE=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:DytDNoMFydXQWCYD/PwgwXnGrqgpzUI8g8dfCSuYpnS5SUxHy7Tqq5Qvoq3H1OoU4UByJgZBmZnIEhM9I5Lg7g39vdNHZzKA7ADs/Hl6aMNTej+BRm/uGL2CffRRrIOG/1BDqUOP12sAQKXbt651p7MnaiKmXkgK4RCpQeuh8TJVuQ7/6GiEIvfnIiNDKF42rD1U6jIp3+iCwG2rDxpOia7WYTQD13i1FFdi931MdTHzFxE9djsm04IEBt83wb4T3HZXhpRdC6/CvwFn/uJSagtJkO7boBlns6FKPdzP6x5n/wkK/6xfpGm/H6tFUH9bExwmLp0/rjg12OHWqdU22uaXBVaQeM+xFIh+FBbXCeN3VxjU6cSoPl1l+Q+SLWznGS1r0ul4Z+Qb2MBgCQbMnGH8YK/qDkiYi0PwjlKZY8zgXYh8ih55wne+oP+N12ImktQ0e0gauE19af5HI5zaeupruUVEoVowg0df5S4AbGATpJmOtcJGWy0sRBj+6iWM;4:Jn8DrFBZCymZ/q6DfetxyElWPttCTbnMd6qC4VYFmDlY171ib+QkauTBCUbLl7lgBLdHACQjbaeoecW/vUuzZqvIw2V187cJf1eEm46qal4UyYZNueK4Wq4H7V/paMi6hBltsQREhFtpeml5qOKvFGiW6U91LIEew1zQPaiIKG358ZHkMihMK3fUamjSO3q0f3oU86rFVyemWOliWOOfubxBqC33nr3+jD450adG0KzxooGJsgKJ3V3w5QGbcMxVKGz1xmgEPtylQ8x/VVlfVg==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257D6A610E2F5ADDFFB2187B0D00@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(51416003)(106356001)(8936002)(55236004)(36756003)(7736002)(6116002)(1076002)(6506007)(386003)(3846002)(47776003)(6512007)(105586002)(16526019)(186003)(86362001)(54906003)(5660300001)(66066001)(305945005)(53936002)(316002)(81166006)(4326008)(6486002)(50466002)(53416004)(68736007)(16586007)(2950100002)(26005)(52116002)(478600001)(2906002)(81156014)(50226002)(76176011)(97736004)(25786009)(48376002)(8676002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3257;23:yfS8gHcFa6aFMWKno4Sl+4ORPJpVcTzllw1kl8FM/?=
 =?us-ascii?Q?bSsWUqB5t+Vz7PVmo045a9v/jFBx0iTLAu1H2Q1m6p5Mtzq338sSebZFIhAq?=
 =?us-ascii?Q?3QyCvrOn+6C3a5PxWbYFIVUJ/9XSDWJI1t0yfJkd2uF2h6B/JVh/+yJbaVb2?=
 =?us-ascii?Q?w2pmUm7OHXnZZ2qHhX2XnWuqw2KnHxJYSbvwNxBjjuhCL4V+JBrA1gxbQ40L?=
 =?us-ascii?Q?59OTmaHGO0coKmL9vZ9WO+1qJA0AHg9s5VhO+ZpX0Ivg1cgJ3AVCCIoodKy9?=
 =?us-ascii?Q?ylOaEzYFi1y2dt6r0Gv5W1UI8gNJ8nsNIOyBV3GQaQOm0GnXhBNlhQAzJApx?=
 =?us-ascii?Q?hhpY/uG3H40oxRpHfOZjOFfE7i3kQH0a35uxcl+uRitGcOAUigyHYqSED5du?=
 =?us-ascii?Q?4tpWg/zNAM7+jWRX8jXiH8BSLq08stX+R09/J0p18Jo0cmkirBxBY8SS3Tqf?=
 =?us-ascii?Q?GhutCH04Ph6m0h1itacfUESvU3rysYqYbrGzzMXY0fo3raQbNzpMlX4BcmM+?=
 =?us-ascii?Q?kceeA7OeFs+ReMOQymkBbtj+i3Jo8/0582orfK2DBCnhHly3X2Of+/19jh11?=
 =?us-ascii?Q?VlqlanHNoRJaD46YjCvZsGBxhIhEropUPYqPH7AVp6PnsN/3XfuOK02Iw25j?=
 =?us-ascii?Q?QZmv5hde9g84wJLFPsj1m5CcfygpIazbLGlEKda77ZIvjKIEDzLO9DZ+cFab?=
 =?us-ascii?Q?aWPKvEidxFKW5u0DXI6479hQ5tL6nui0N9M4pVLO6eFL2lbpcD/Yr9dwo3Fs?=
 =?us-ascii?Q?2ysjystLFLmmoZ4GLO4YrrAyvPZrAA6x3WnLlinePdZiRc/05DGQNECF4Shk?=
 =?us-ascii?Q?7mX/oC9Pmg5pUILxvpMBm/KuGYe0bPx62WAMwxgV9dTqWITszhJu0sMhq0QZ?=
 =?us-ascii?Q?gNPPEOHT+Iop7FdWf43GF+mVsXkI8bvXHEZu0PnJ4bjRpHJ0FFrn65YVxph4?=
 =?us-ascii?Q?SMwlLLQnQYKPZyHPxJd5oK7tBInpHnSidz0VBRHxapgiSDcD2KTdT/WeELQ3?=
 =?us-ascii?Q?sN++kP9ajCVZMtaYR7kKFwNOqK0KWEOiluqf+MhBCfUozGeGCDuKJ+4payZ3?=
 =?us-ascii?Q?gGuStj1cPrd1kvQbvzyUo18I0WrsZJKQvju73DtV/8BA3cr/xn8OFZ2pW4Iu?=
 =?us-ascii?Q?K/uNjk7hgdTHi9Yn6JUylLw0mKkEdWQrebfuX9vK2yi1CVzdXOMFQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: vawetzW/FDeyqVRZNEFE+bnMTojUbF2QYv5lMXg7ieYEK/Ft27nRLHNw3MIi5Whm7+zvWZweUNj4OlDBczpld1tat/FVrCw2FiluESFFtuWcTAbU3Z/Yz7uV97YYH6LC41UYnST5J/Z3G9FpMtKTxWhZ3ajoCcqdUs+BtD0009B52JvA7stMB849mzTbNbwi
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:ZvnWQGQ/BJkhuhxKCJP4aU+eKhhVOM6z2yWsubgX9wsPFyxRsnIi2+9Ks1yh08xaMEYusu/gTI4igUL2JKtXkPYo3RCuy+aBxiIwSA5CJ11zhJ67NtRJcivYL7JH08sceLgk3fAHPkjQCMGRxIV2uBMYyDif94/3tQ6D2YDheKvvIO5Pbq9pA2q21B0z7fYZ18aC2BsZQqGgQ3NVrhWCi4JQKpd6pPEQTV9Bf4NLiOoIs/WLJUQWc3xY4y6FIFgIFR2IVOY8ThkOR0DtbUqbkd9VSZvWTjKyCDxanwwx4iWYMqb/inMcS7TtbMKCJ/XtLrZYWT+fQFqmPfoXPwahiQTbkdool87H0g489KADKAk=;5:mlxSlxkvURAyDvpi/R5OgGxTs/B+RFiPU2sNXloMgLhjd8t2UJA3eFLr0VvdNKnmzQO5/7uYk9l0y8A8YZsOcbcYScZWPyViBiAnvFsIVMTlmzFQPvs4m6rVS3kFtAd5NEztZSskibVseH4s8OvCK3pow2R7+AkGmCwG1ju42sY=;24:tybkD6nqZhLS9CKlamUKAAA7Ln9uYSnnsuIDBRIb9ama59DlvwRdU7j4UOpaS4o0JyXClFF4Fiq+Sa3lnDVKCRmhBNDDgZZ/ZheL+XwDitg=;7:u66LWd+gUZXKJFevsA8DgeGDQIZEjiHBgEG4PRAE/sghF3Dch2JU4NfHLUghMKBaEaNMCOH6OMyEpRs8DxEEfsh1ClNiOuKKyhs2orSLmRaoUHdVEmIIkl4+2exiI9oYlcLhGALQFQPp9Cxf/HuiPnljS9Sza8OwYuIgTMpnaQHy9fW1YFgaY/fXdLWocTveO+7Vi20f+EUViE5TYPNr2mhqt2CgwhkGlJgHxnLPSWxEK6L8yVLpBD661VHyGB8L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:LJQg5zUWgqNKlZgSzswMGBF34H9G6aJ3BtBwYXp6bVBthiFsJmpCWnS69MUoj2yTgT4XNHEYorB6WCquKoBDN73qsMI2Ilfl7/d9M1uzIAtbLFOr6H7gkryQQ3fQdFzHu/I5wNH5dJcVQvIhnJtj3A12d3Ik9Hvxg3TH5B63pOo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:45:53.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0d8d9b-733f-40a1-96eb-08d58a943853
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have separate LRU list for each memory cgroup. Memory reclaim iterates
over cgroups and calls shrink_inactive_list() every inactive LRU list.
Based on the state of a single LRU shrink_inactive_list() may flag
the whole node as dirty,congested or under writeback. This is obviously
wrong and hurtful. It's especially hurtful when we have possibly
small congested cgroup in system. Than *all* direct reclaims waste time
by sleeping in wait_iff_congested().

Sum reclaim stats across all visited LRUs on node and flag node as dirty,
congested or under writeback based on that sum. This only fixes the
problem for global reclaim case. Per-cgroup reclaim will be addressed
separately by the next patch.

This change will also affect systems with no memory cgroups. Reclaimer
now makes decision based on reclaim stats of the both anon and file LRU
lists. E.g. if the file list is in congested state and get_scan_count()
decided to reclaim some anon pages, reclaimer will start shrinking
anon without delay in wait_iff_congested() like it was before. It seems
to be a reasonable thing to do. Why waste time sleeping, before reclaiming
anon given that we going to try to reclaim it anyway?

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/vmscan.c | 131 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 73 insertions(+), 58 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a8f6e4882e00..522b480caeb2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -61,6 +61,15 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>
 
+struct reclaim_stat {
+	unsigned int nr_dirty;
+	unsigned int nr_unqueued_dirty;
+	unsigned int nr_congested;
+	unsigned int nr_writeback;
+	unsigned int nr_immediate;
+	unsigned int nr_taken;
+};
+
 struct scan_control {
 	/* How many pages shrink_list() should reclaim */
 	unsigned long nr_to_reclaim;
@@ -116,6 +125,8 @@ struct scan_control {
 
 	/* Number of pages freed so far during a call to shrink_zones() */
 	unsigned long nr_reclaimed;
+
+	struct reclaim_stat *stat;
 };
 
 #ifdef ARCH_HAS_PREFETCH
@@ -857,14 +868,6 @@ static void page_check_dirty_writeback(struct page *page,
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
-struct reclaim_stat {
-	unsigned nr_dirty;
-	unsigned nr_unqueued_dirty;
-	unsigned nr_congested;
-	unsigned nr_writeback;
-	unsigned nr_immediate;
-};
-
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1753,23 +1756,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
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
@@ -1784,41 +1770,15 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
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
+	if (sc->stat) {
+		sc->stat->nr_dirty += stat.nr_dirty;
+		sc->stat->nr_congested += stat.nr_congested;
+		sc->stat->nr_unqueued_dirty += stat.nr_unqueued_dirty;
+		sc->stat->nr_writeback += stat.nr_writeback;
+		sc->stat->nr_immediate += stat.nr_immediate;
+		sc->stat->nr_taken += stat.nr_taken;
 	}
 
-	/*
-	 * Stall direct reclaim for IO completions if underlying BDIs and node
-	 * is congested. Allow kswapd to continue until it starts encountering
-	 * unqueued dirty pages or cycling through the LRU too quickly.
-	 */
-	if (!sc->hibernation_mode && !current_is_kswapd() &&
-	    current_may_throttle())
-		wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
-
 	return nr_reclaimed;
 }
 
@@ -2513,6 +2473,9 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		};
 		unsigned long node_lru_pages = 0;
 		struct mem_cgroup *memcg;
+		struct reclaim_stat stat = {};
+
+		sc->stat = &stat;
 
 		nr_reclaimed = sc->nr_reclaimed;
 		nr_scanned = sc->nr_scanned;
@@ -2579,6 +2542,58 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		if (sc->nr_reclaimed - nr_reclaimed)
 			reclaimable = true;
 
+		/*
+		 * If reclaim is isolating dirty pages under writeback, it implies
+		 * that the long-lived page allocation rate is exceeding the page
+		 * laundering rate. Either the global limits are not being effective
+		 * at throttling processes due to the page distribution throughout
+		 * zones or there is heavy usage of a slow backing device. The
+		 * only option is to throttle from reclaim context which is not ideal
+		 * as there is no guarantee the dirtying process is throttled in the
+		 * same way balance_dirty_pages() manages.
+		 *
+		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will count the number
+		 * of pages under pages flagged for immediate reclaim and stall if any
+		 * are encountered in the nr_immediate check below.
+		 */
+		if (stat.nr_writeback && stat.nr_writeback == stat.nr_taken)
+			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
+
+		/*
+		 * Legacy memcg will stall in page writeback so avoid forcibly
+		 * stalling here.
+		 */
+		if (sane_reclaim(sc)) {
+			/*
+			 * Tag a node as congested if all the dirty pages scanned were
+			 * backed by a congested BDI and wait_iff_congested will stall.
+			 */
+			if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
+				set_bit(PGDAT_CONGESTED, &pgdat->flags);
+
+			/* Allow kswapd to start writing pages during reclaim. */
+			if (stat.nr_unqueued_dirty == stat.nr_taken)
+				set_bit(PGDAT_DIRTY, &pgdat->flags);
+
+			/*
+			 * If kswapd scans pages marked marked for immediate
+			 * reclaim and under writeback (nr_immediate), it implies
+			 * that pages are cycling through the LRU faster than
+			 * they are written so also forcibly stall.
+			 */
+			if (stat.nr_immediate)
+				congestion_wait(BLK_RW_ASYNC, HZ/10);
+		}
+
+		/*
+		 * Stall direct reclaim for IO completions if underlying BDIs and node
+		 * is congested. Allow kswapd to continue until it starts encountering
+		 * unqueued dirty pages or cycling through the LRU too quickly.
+		 */
+		if (!sc->hibernation_mode && !current_is_kswapd() &&
+		    current_may_throttle())
+			wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
+
 	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 					 sc->nr_scanned - nr_scanned, sc));
 
-- 
2.16.1
