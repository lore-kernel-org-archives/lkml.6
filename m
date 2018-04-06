Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeDFSCY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:02:24 -0400
Received: from mail-ve1eur01on0115.outbound.protection.outlook.com ([104.47.1.115]:29668
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbeDFSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:02:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 1/2] mm/vmscan: don't change pgdat state on base of a single LRU list state
Date: Fri,  6 Apr 2018 21:02:53 +0300
Message-Id: <20180406180254.8970-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323152029.11084-1-aryabinin@virtuozzo.com>
References: <20180323152029.11084-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To AM0PR08MB3251.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f28e8dd7-67c5-4ad1-cc3d-08d59be88944
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3251;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;3:Pm/dGZ1oCFp2vP0RmSaB08hzZgX2o32D4y31IthFGXkr4KJ/0voHSWA0FBylxcBXxsiMKBpgR1FlXObpvryNVi1wv+H+ShbtqmoZoJAb5nd+Dm9UHHs9PRZsXPQTVlIaUMLTTbJA/xLbpgbnFzk9p+cFSQ9zVix0gtzT7b9W6sg2zQuJfgJ22ZGz7ZoHliMySTbdiiA6ItDRtt2i6Z0waKZZIyECVazCoowQE8hXnqMhdrWFnJc677aUNhgUd+bw;25:+RC1884tATRmBINM6CETyLF4PXiTE4oel9JRuWnYDoPZt0XENUrkpQpcycZpyftEiWJD0v0zu2tA6cBt9JH/YO29lXyzgfXM7CC91w8jYqDOWGdp5G3VPVDOcva7aBTD51I2H3HVFyrrxuikAXII2n5z65M/KsRzUprW2d0DAxgW8WDpRm75Twql0AibePrSCyYCAyui6cDwoYqFjLdaYbUBhgorRcF2pEQnOKRbwcwBr155p6KY4D0lx4dfPSERd+nGLtkD88hIF5GvyS2sACOzgL/woHUQTetMJxuczpJbmn2LRmnx2oSi3gdrP53+HwUsBUD2C78PST/9W5mO6Q==;31:JEwnatcroKukvZbNBy4KKPX2Ei0kTI85sWKUbA6bNCdMnuRO2rWGKanxV+n8uIr7Nxfd2jRJHlSnj8iL20jb+GOZfGnNpbslTt0trit3mCmeGGpw/elhUxvLTn9piaV5BOwNsKADZZY8FqG31ABrYDDMdzdXNunAvFh5kx1GdKu1WXOCoJ8H9P+dW8BFKoBfp6MaTzFndP0tbBPwTwATobfCXo+zj/XTtphsDCH8Ztk=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;20:iJ21DPQZmlylGG4l6L7JSqtHb+iNdzvmL0jlH4W1Rs4VuE1pJhvVZQDHncUaIPEILb2Ky08HJXh9w5/YxnnR5hpyXAf6VmNsFtwl+Uh4OJ3J17ulF8fMeimVKxnmo4i33E1Qb7ciVBepshCRpMdVEG5liyLINtlqEqHwixnHlD47+0gXT+ZGL9gFnv+VRdiH54aNF1cBf/pZsWa+k4WyQW9hxRLLx0juRlBSDk1rMPu1QeL5asBepzy9HsywIgW+yb4ih5l2gYn1PPW1Wmewpo0oGlkuYpxPbtY7xaoyS3M4PBgE1zNZECbdGqS49Ao5zx5bapY/fNiJ8r4dB/SAqz1hH1AE0NGD/RYkW6KThdgPmmwNYeU5TIXzZItld3llicXgeL/VW1Dfir+8gEsWNTkKFfeogACOPRgtrLKxAE7tgK1WhmK/7PtZ1jb6q1zWzdE9nbu8IsPyQoe65teCebGfZ3nywFUTZy/77kFjqiISDGx9G3KDYSH/19jeASMG;4:6RSQ894cv2Fk8+RSz1tBF1fh3GWIeRBg8hve/dqtfoYNw9jA/vdswh6h5fUngN5shTCVF8l5pWoZCawPY1Mt3yO2rS/OwkBeWfnDaQuDdHu3HcJqeALau2vImc8CM02Ppli8YLAjOLW/3gYVIJ3JrLxjmVVn9BsMUE07SDlec6rzD/0cnW39Z4KW/s/LQMS7xz4XY8q+Ec4rcjDyu1b5d+ZM7nzwyRygRbkTN0p5ZIVYhConbuXZiLyMCmh8Zpy8lCpntoKur+DhGvNkkdSMjI09NKgvtSR+nOgAkOhW6301CtiHj8+GnrBmEqwzBm9jvOU3Y8+tahqdC9LZ7zXn+BTum+BLokjUcnu/yD9gCmg=
X-Microsoft-Antispam-PRVS: <AM0PR08MB325128FD137DB77D1D92DE8CB0BA0@AM0PR08MB3251.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR08MB3251;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3251;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39850400004)(376002)(366004)(199004)(189003)(386003)(81166006)(86362001)(478600001)(76176011)(6116002)(53416004)(3846002)(66066001)(486006)(105586002)(956004)(2906002)(16586007)(1076002)(446003)(2616005)(11346002)(6916009)(316002)(6666003)(47776003)(16526019)(97736004)(476003)(25786009)(52116002)(4326008)(5660300001)(81156014)(8936002)(36756003)(6486002)(55236004)(51416003)(54906003)(53936002)(6512007)(7736002)(6506007)(50226002)(48376002)(68736007)(106356001)(305945005)(50466002)(26005)(186003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3251;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3251;23:zh1pdLkKg4bbhNrwlN5qtIN47wU626V/290LVLfgB?=
 =?us-ascii?Q?pE0VC9W+HWUTrcg6hka27ChVOJGUVvqQsCdQSii/BXrXc8PAcV0G1VbYKLxY?=
 =?us-ascii?Q?lfWRIWXAYETGHBy0Yqw/pHL/Aw2qWsK7IEizptOQElVtsarLS0afkNzT1rLh?=
 =?us-ascii?Q?fd0hhYZvHEjsn68+3Ts/dRYkzrR3/iodHAUTRG8s/87cchhKEzQXaRfomaQ4?=
 =?us-ascii?Q?j4ndZlK8LafkRzN2Od7ur5yimxruZi2nSUuWvYMcwocmo0lIT0HDqnEekYhw?=
 =?us-ascii?Q?c7musPtMgq3iZCDulY7OwCpEZoDnScLjsklDaRrPqrFhb+a135XAiFcTQqWq?=
 =?us-ascii?Q?lUliieUylBkWj9a6Bktp44cQ8CfEV2lpAerj251MezMGw6smBkEYHzT6oTuk?=
 =?us-ascii?Q?zOS5Syg37jTMFupUtqaUBHS3ZJ8Z+XOcKihx+iir99hv0cXFF8tzWfhGkjIt?=
 =?us-ascii?Q?Zx88WGO+YYmnl3q1vmoPXGXuswQ/Va64PLq4YSOuEVlAQ+RV0aD5eEHzckFB?=
 =?us-ascii?Q?qyalbvvC0ZBN5t3Zcq8624Jx9V3WfKsL0v6Db0rrSIhAaof8Xib3RF+UWP26?=
 =?us-ascii?Q?1Xe6YasltJ49DM+ZHvSCRzCsZWwbMrwZiWWGH+ruebKwHERG56vjmMq7j3nQ?=
 =?us-ascii?Q?tS3LOU28Seo66UQ25rS/UjehD7YqYofL34io2nRkdgkKs2jUhAUrDY2szOgr?=
 =?us-ascii?Q?z+Ll1CrNHByS19svRHEmo+CDmpwHYazLtKpI/v5xZj3jOzNSiE4o5BVv09ru?=
 =?us-ascii?Q?m/9lUyMOLhgfr0+5E8WnA2VGPLeqUj8341MqrETAmwAjOKRznqulOlfSYrTt?=
 =?us-ascii?Q?avFcYJAg7l3Hx5D5OEw4pT7Vu3CJEZbrWGPg++k+JGvYmRyNHRKIBrSi53Cq?=
 =?us-ascii?Q?kvS5ydqpPBWLQ7l16iRGA/JPuGjN8RxL28zJflRjA6dpgmmkFiJPgr8VybA/?=
 =?us-ascii?Q?hO6pw+I+pPLYS9SHx/GNZrp+VLvm1x6NlAx0xp27IFFRAHOyE97E5vkjcmU1?=
 =?us-ascii?Q?TnGz2CcOppxnzqQ3XU7CJQX37yqIKP7qcRI35xF5Nqwu6XF4AYJ/tWN+UW0O?=
 =?us-ascii?Q?7YTEUz2ITfMgBFWQF7foImQZa7UY1SjO1Hl12TVMFcKKnAUQCLGG4j1Avt2Y?=
 =?us-ascii?Q?K5lVyP6OLYfr64B1PFhvryx33eoQATnQfLY5hx11x15FSWyar0GI1kBYGPgW?=
 =?us-ascii?Q?5sgI7P2rOkBwjQ2HKsbucj11YfQgeIcg+UP2xLH7m4JdXog8Nt1F7qO2RevF?=
 =?us-ascii?Q?urFaRXTmpjSWCsSZA2l7Fbxq5kw/yQLe4Lm50Lr?=
X-Microsoft-Antispam-Message-Info: iUGpx/McWAP5tDTtViXQOjXgYSgxl+385+DhUnaBWvr9dHOAg04w8suafK3TY5l/kbnEiy9z/va4v4qViL+Mcl2R0XHYuDE78en91fWV7nDeAWY1P7nZ7QUfoOTCDGC5a9hX86hYNPE4QY63LRJxKJFIjr3Zb3DqIdYsh7eawVvEbR+OpDTTZuuB8vYO6WcN
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;6:9IF8HvLKNwYi0kfrRqp0r0oftazogoPqT+7RDg56DueUw8zqfTduXt983DhpzW22Yl/IKKROlE4zjDMFMXbXScOFdzyAa0ch3pfzFvd3W/zDnYVQ26yrXpOZ+jpiLapmdChg0NRCK4C/A34Ul/l6lxmLYLUygEnMWSGNDtHrVtgSsCTOtqocaC43m55I6mQORTTlp6Olrimps7eTxBLjH0cXs+DSFdRVXOkOV11VV2E2k/PMYQVXPNGCYHOGJIy6qxbqRffqkbS8iGH/Xyr21fzVNkfdoIC5sPusMitEXKVbJ6pcEgRPt1chlDNpd+bOnvvSC09T6mhcshe5gbeG8hAH4H1WG0u2c7w8KcNHfvTxQLvHDrBS0JLXWZZHJh3kcu+eBG5DbndTj3ZkwzipQ8xyIiOedBv/ZulGJW3NElYiGPDNfI8Wk5EFU3MQ2MwEVDM2rkQQjkK0MkJBbX28jA==;5:wzSp09/vpZRFrba0JKiC9Iu3sqSj+0CGeUzJSD87wiHtiLIVi3kDLYCJyvJqIHtTnoFxLMkcGYzQHAHC6M4o99g2wVHTEJcgum67OJJK8BQoozSz9KLxroNDlFiifGjrBQBeOBbZINJ4omky4tgd4TrFS07MRdVj2hzACYWSvMM=;24:z95svzVM2/oc5rs0ViiKOgydAqrl3N8T8/P/QkpIpTjRfhXKGXmj+A6HdWn5IrW4GgFd/X+Hm/9gak76kaULlGLLxN1sZMg7L8Ts9ifTLMo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3251;7:jQmYmN3tKFIJXn3u9TVhT/ek9jxjdD501uOAJ52hWJ8l4KtbFoMlGAaQiK//leX/qrNUeI3t3fSIijgUAHD9Q5ph8Il6KSMjMRx3z5BaeySZe06XFXaifku73O/PViklCU7O61e0dHUaSg0/+HSld7f5DeDInAaRtVuqT331LIwWPwzDB9wpiiCvCV7byH3n2Gboee3oiqY+sUu5c3Cd12ogbDqdA2vv7szTjT3YjL7WZ1FEQQ93O/DCDUYQr6l/;20:vosGmvWDo+g5kyLIuFoVzrnpKFJ56UxXCul2Q28puJnLtux8oe3VMlvvjaLKNOqivnyHRBnr0MAsPXSy4lc+U0z9Gxi75rleXFjUQz8g8NKIh5SUs+tcAaKDNnpbzXt/zKXimaKgPBXlUEVcW1x2Tg8vbGpvvrXTnswoAI4UpCI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 18:02:17.3310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28e8dd7-67c5-4ad1-cc3d-08d59be88944
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have separate LRU list for each memory cgroup.  Memory reclaim iterates
over cgroups and calls shrink_inactive_list() every inactive LRU list.
Based on the state of a single LRU shrink_inactive_list() may flag the
whole node as dirty,congested or under writeback.  This is obviously wrong
and hurtful.  It's especially hurtful when we have possibly small
congested cgroup in system.  Than *all* direct reclaims waste time by
sleeping in wait_iff_congested().  And the more memcgs in the system we
have the longer memory allocation stall is, because wait_iff_congested()
called on each lru-list scan.

Sum reclaim stats across all visited LRUs on node and flag node as dirty,
congested or under writeback based on that sum.  Also call
congestion_wait(), wait_iff_congested() once per pgdat scan, instead of
once per lru-list scan.

This only fixes the problem for global reclaim case.  Per-cgroup reclaim
may alter global pgdat flags too, which is wrong.  But that is separate
issue and will be addressed in the next patch.

This change will not have any effect on a systems with all workload
concentrated in a single cgroup.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
---

Changes since v2:
 - Reviewed-by: Shakeel Butt <shakeelb@google.com>
 - Check nr_writeback against all nr_taken, not just file (Johannes)


 mm/vmscan.c | 126 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 75 insertions(+), 51 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 403f59edd53e..1ecc648b6191 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -116,6 +116,16 @@ struct scan_control {
 
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
+		unsigned int taken;
+	} nr;
 };
 
 #ifdef ARCH_HAS_PREFETCH
@@ -1754,23 +1764,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
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
@@ -1785,40 +1778,14 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
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
+	sc->nr.taken += nr_taken;
+	if (file)
+		sc->nr.file_taken += nr_taken;
 
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			nr_scanned, nr_reclaimed,
@@ -2522,6 +2489,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long node_lru_pages = 0;
 		struct mem_cgroup *memcg;
 
+		memset(&sc->nr, 0, sizeof(sc->nr));
+
 		nr_reclaimed = sc->nr_reclaimed;
 		nr_scanned = sc->nr_scanned;
 
@@ -2587,6 +2556,61 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
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
+		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
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
