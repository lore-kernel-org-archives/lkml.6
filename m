Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeCOQp7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:45:59 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:63912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752167AbeCOQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:45:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 3/6] mm/vmscan: replace mm_vmscan_lru_shrink_inactive with shrink_page_list tracepoint
Date: Thu, 15 Mar 2018 19:45:50 +0300
Message-Id: <20180315164553.17856-3-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::22)
 To DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa46326-42a4-42b7-45fb-08d58a9436be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:lIo+QUHh3D5qdjjnkGwECUTw3aWgi7sur97ia9BEc5DlvmRbnzercSU+nPItu3TfWLgaIPID1tzjvihKiqspdfnOcWxT9/i8sP8tdwdpJBhx/mzh/so/ug5ZoXG92WNo+KXQSjoOb6wJ0Nht1AS9D9KLlv2uLOh8i0Z93KScKmwn4DFH65XPGgyxL2nrsp2eWZtw3vRLVCC21dKxBRm++kBYrhDd1Utu1veI+LYmJw6HOnFXD4gH4xiVCM/1+d+8;25:06ucPN7CMo6EQDwtxMCWjSA7IfiHr83vS33CJ7txnHVk7sFFwEKifhR2oEAveda+mjvBmFe3yecNdlW5ZBaLqDUWnE2UVw7V8+3coN/lSYfQRilIcgS0Usay+nG7AhW646qXB/rf6DmukSokrUJIGjibjFlCZ/Qwf5qrEttuzUcvr3EW/M3UcGXi/rOrMQDS7RjDm3yOm8Xc4HhGvxV1+r2IZZtYx3Ulp5v3KmbUmvU7LDV5jy9YdqC+wwrP5RD9+TQFm1BY7n5IgwkB6QiAaoMlHcoAkeZDOQjzrKWpkJ+k6ODT0BIrIZyUUbhiUB0pwWRFXu4+2fSq+EN38JNSGg==;31:wMaN7mt8lL10RLrCMoPOv5gKHyBdjIYrnrVzeAv2xemQlGhg31YRvZXAHW9txiz+dqfS9lQ4mBxKABzzYefEkmzu38+PCP2cI4hbUHiozTrhNPxTl4M/WnkNq7uxxZntcc7ZEu3eaJZm/tbsZfWA8Lks2pRjSnz1SqjecM/lq5iSdKFU0lzHZPkGIziGt8Gou+I3QxKWrp1TaX/yZdv8dvTap1puTSbbX/R15Rzgl8M=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:BfDJB2jqks12kq9y8Gx/IgSQ/cqOmbZPQfi20LilqHC0fwwtlYTCUkSwOXzq0tCauc5oe2j7fT8lgTis5eLQaO2vs6+KmIUSDK+RPQrYMrsLPsAjhXMPDygEG2Zu05yw4fIVeKUwvCy5wwVO5eNVoawmQ2tBYQJjuSzWnekluy0qubXMOO0BpgQbFtkiAIB1Ja+zM44i/9Loq7xi6Gex9uewJrMLzHXDvEeQV3i+tFQl+rfZErRqMSe3HI2vUTV9LbLDmWTVy4DBniZvWkImoq7x4eMnbUPAn8w0AyFfe4Ldvn61ay7Pri0EedQ4XJQeb1UQBkZd2a3p3YRNU8sprDANMTwEaGr4/DxW/Jd0Q4ayPYnnNaAocCK/oZ045aZHVeuwbzr0XfGw7gQ5RmxThg/FZ1dlg42NHcpi/ihJ7iSznimrFb5+fDkcsxkJrDG2vP+TJQBlKH/DJmuOr7OWRdzBiPltowh5vlYrOdHDzbEOxLHgDCXAPwhmTr0+zTHz;4:XgC1ajqqAlfoHaNbRKStXj6RLLYxk18EnYHCkiAB56ZL8qrEZCbsuisAOOP6BrD8MI+hK7HqAVULQV8YersQIaDtWquW0bQEyk/dAUC0SPwitT8KpsTVrxWSg5kHwkCb/DftjocNRhdVqEmtoDL4XYNwrjgLaBwzGRvedUK2YaekCz7/yZirLs/7tuDFEhgmi7eE4ubERSmqwGZNdDS3N1b5+kU6k5VCNEvgdFD6677wzpvA1agG+RY+WbRw2UD5TZD1Uwad564Ee7gPam03lLfk46GHgRE5iWA/s9yVwNqAnYaLWHcOCXCHKg0RXy7t
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257E2D34F35B700865D1F2FB0D00@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(51416003)(106356001)(8936002)(55236004)(59450400001)(36756003)(7736002)(6116002)(1076002)(6506007)(386003)(3846002)(47776003)(6512007)(105586002)(16526019)(186003)(86362001)(54906003)(5660300001)(66066001)(305945005)(53936002)(316002)(81166006)(4326008)(6486002)(50466002)(53416004)(68736007)(16586007)(2950100002)(26005)(52116002)(478600001)(2906002)(81156014)(50226002)(76176011)(97736004)(25786009)(48376002)(8676002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3257;23:xETB2hAsfVif3S8g07GOXBArkSr6tiwwqC0/CLL5K?=
 =?us-ascii?Q?LEWbA/srpqppyCBPMjqGDhmMyVPdvWwAjWHJKYHXyh2flLj/IXwlJRJl4TC/?=
 =?us-ascii?Q?fGSDmS0Ic+7nYNYtUuPmjG1QtWU6ijjAavR7NbwpX1ortlF1cMLBwLGIaWu+?=
 =?us-ascii?Q?mnNKbMRHudygoe3x+cZ8THT9Gjw7lk1DIw/Z4qHkfvmPKHYJPzlNJRgpE1cJ?=
 =?us-ascii?Q?JHtiYEGMgQQHQN7nM+LYaIx5jO/o+9R3dJxfeRRv3nIJ3yn49bBF75RgxpqX?=
 =?us-ascii?Q?IWXLkjy5Tg776eKM5kGbdfEoEGybxLEXgm7CKnbO48vz5VirnfeL/LYhaN37?=
 =?us-ascii?Q?rInjY91EsKGDbsSisKDEoGRXTYCIDKTDpA4upw7smm2yifpYx0oZUch/k1eP?=
 =?us-ascii?Q?jtbwQVGZC14qv3hEvwaLioMg0vwk9DbZVHZHRQ5g3gKFrooRCVH8zlz3up8W?=
 =?us-ascii?Q?5f8iLwl882DBE1Kzx7yTyxl2tJOuhs88mx8N+NVvPCtxohHP0bbseAHcWyRW?=
 =?us-ascii?Q?caS95G4j/UG8gSiTtnmtPfTmFK4lqduURQzRcsnNy4f3u4vfi82lMLfIn7VW?=
 =?us-ascii?Q?XrCG8Wr9hoHFs4JhJITymbwcxTB710v9OrVCVzCxIigugODfGs/taArr6buS?=
 =?us-ascii?Q?iKOn7kFkxKvM0NYeLcZ38eIVE8Z7qQItk1kFRTpkBQ6g2tgJBfhgK/YmHRbh?=
 =?us-ascii?Q?LZhKe29wEpG9CekA5e7ydo4/azTCww8oGYkOQfOdNLyIvBfo+taVKFnKHPoz?=
 =?us-ascii?Q?C1u84vd2un2j4AY9tOsPVXs7RJleEaU6gvoed+egxBkqder1ywpIUrwK5cuo?=
 =?us-ascii?Q?qqK+8p+UHeNf504tXeNSPGSqBCdlY7oIQgnhndB8f4Ydk/R+h/VssnirjJyj?=
 =?us-ascii?Q?0r2bRQY5vhBnYCGc+r6E7YI1aXUPHkJKZdNt9XWRazioZ/pa/ItWW6zn2ptC?=
 =?us-ascii?Q?T4qbMJP2kk292UR/okK+8i/xQbqaw+X8DDzxs9Lj4hwUYsFJ5AH9dtFJLV/A?=
 =?us-ascii?Q?ONWga6TC212PuGjfh5llL5YoEEHn8bQrhuIxlYt1mPOICA0V2zacdF94WffR?=
 =?us-ascii?Q?yFfpV1gL3CE5Z7RZUkgXxc7VSTLjOzdNU7JDIlUA0cPHLM0H03uOZw0r1wMt?=
 =?us-ascii?Q?5OD/xJ5AVbTvMbJUvDepdyGMnBC6yyYOLwnephtdFGZNLX3XHICcgLF5J+jE?=
 =?us-ascii?Q?tPiJ+d06eOHnps=3D?=
X-Microsoft-Antispam-Message-Info: 92vz+z66kStspQgy0+cuIfVAjDw3ECKDLBHtcRWvg+mtDmhu1vENbOFm6gxLQj/Zz6tFUlyiSS29vErYVHhR6bMw5VTTh9q9XufLI9LcKtMRg+fkC55HpWxIEB4/igM+pLbJYwInKi+E9T9gcrmLOOe9ixu+ItnWCjrvvYg8vu4kH02KMjRo9dvMKo+zmwvF
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:+rgtu+Z+QY7a8sRGD35GFOSfUa9V2jeW+QfTJaUcLF9RbwkPeM0S1buNj2G2bYKuRBkq/rq+UaNDTN7gxyMgPz6xrLqfpCmS8GEJaFMiaQC0aPygPNCkHJve2bwHTEplM5DBcmcpCFIgMim/jptR6LlB6lSHaGSIYbvMykhNX2Zqr3ciWcVOeEEhyOYDxRJH18wBbXrXK40RDlXTIPf7ehWTL/RApf8wqLCUob1xlIwCBb+oicfVGfJIbL0/40GnJkqgPoH8BGLe5TueL3UsNEyv6TC3penXhOomgl2tUTI2EKzjl2vvECfZIG3HLvlK4Xh+AQE8+qED8JHCI6GDJlB4fV+MyIXgtr4k97U7sl0=;5:S4ZrgvCAqM1U2SoUwM39OIy34I5EzLsJWN91X5CKWRKy4L/nVKC5BTMam7xFhPD+6bWmtRgSD0Rj9ZsKjYU9X2qHHdYydBf76bWGAU9vj/w7Zi9hFGWwTx4aRXsteuRTzfxH4pZBJre1alcpkmRxH8sR2yyXq0CODYSOTCOUWEg=;24:yhKFISeVZQogUAkgEjOjL2iwmZt/OEk/IhJUzbWyGWiGffFdRoMoQTZI4ra2YcQ+vzSTjQEKTrvKz94AU9d+5rck3Hkqk0ULGTmJnG8w8xA=;7:o15d+lXJcul/1IK2rpju9j5jwQf1iplnAc3l53lmr0r6Ouj7sL0+UeiXVnnhiooCHoYGWooIu/nJwZt2sDdR3fKvJ2asHc6XGvIFDyNmqOLYV+ZOKq9AdjHDaUcb+NrHoEBc03OR2O1m3Sm3C0ytr8pQ/iRX7aKuIUo+ulR+ETyiIo+cKu7EiqE9+XGQyS6spv8ZAgS/bThSQMkewoQhy1zxxHzhgExOpjZF+9dj/qtoWbZlWsXwlrQWgyK1f1e9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:CNzN61MlRX17G+dmkmFAJ9GwUw04Uyss672cyTVKQbu8IunHIvDvwn1yoHUVJnmC9Xh9dPIiEXbTX9oVtHPwkyqj3R5ZF2qRRseRmvj5XopqbAgOdbjIkoK/wgW9D1EG1bd5/dwx7y4mJFc9Ytd6M4cNMRux9nPEkq3aIOE0n3o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:45:51.2587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa46326-42a4-42b7-45fb-08d58a9436be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With upcoming changes keeping the mm_vmscan_lru_shrink_inactive tracepoint
intact would require some additional code churn. In particular
'struct recalim_stat' will gain more wide usage, but we don't need
'nr_activate', 'nr_ref_keep', 'nr_unmap_fail' counters anywhere besides
tracepoint.

Since mm_vmscan_lru_shrink_inactive tracepoint mostly provide
information collected by shrink_page_list(), we can just replace it
by tracepoint in shrink_page_list(). We don't have 'nr_scanned'
and 'file' arguments there, but user could obtain this information
from mm_vmscan_lru_isolate tracepoint.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/trace/events/vmscan.h | 36 +++++++++++++++---------------------
 mm/vmscan.c                   | 18 +++++-------------
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 6570c5b45ba1..8743a8113b42 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -342,23 +342,21 @@ TRACE_EVENT(mm_vmscan_writepage,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
-TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
+TRACE_EVENT(mm_vmscan_shrink_page_list,
 
 	TP_PROTO(int nid,
-		unsigned long nr_scanned, unsigned long nr_reclaimed,
-		unsigned long nr_dirty, unsigned long nr_writeback,
-		unsigned long nr_congested, unsigned long nr_immediate,
-		unsigned long nr_activate, unsigned long nr_ref_keep,
-		unsigned long nr_unmap_fail,
-		int priority, int file),
-
-	TP_ARGS(nid, nr_scanned, nr_reclaimed, nr_dirty, nr_writeback,
+		unsigned long nr_reclaimed, unsigned long nr_dirty,
+		unsigned long nr_writeback, unsigned long nr_congested,
+		unsigned long nr_immediate, unsigned long nr_activate,
+		unsigned long nr_ref_keep, unsigned long nr_unmap_fail,
+		int priority),
+
+	TP_ARGS(nid, nr_reclaimed, nr_dirty, nr_writeback,
 		nr_congested, nr_immediate, nr_activate, nr_ref_keep,
-		nr_unmap_fail, priority, file),
+		nr_unmap_fail, priority),
 
 	TP_STRUCT__entry(
 		__field(int, nid)
-		__field(unsigned long, nr_scanned)
 		__field(unsigned long, nr_reclaimed)
 		__field(unsigned long, nr_dirty)
 		__field(unsigned long, nr_writeback)
@@ -368,12 +366,10 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
 		__field(int, priority)
-		__field(int, reclaim_flags)
 	),
 
 	TP_fast_assign(
 		__entry->nid = nid;
-		__entry->nr_scanned = nr_scanned;
 		__entry->nr_reclaimed = nr_reclaimed;
 		__entry->nr_dirty = nr_dirty;
 		__entry->nr_writeback = nr_writeback;
@@ -383,17 +379,15 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_ref_keep = nr_ref_keep;
 		__entry->nr_unmap_fail = nr_unmap_fail;
 		__entry->priority = priority;
-		__entry->reclaim_flags = trace_shrink_flags(file);
 	),
 
-	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate=%ld nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+	TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate=%ld nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d",
 		__entry->nid,
-		__entry->nr_scanned, __entry->nr_reclaimed,
-		__entry->nr_dirty, __entry->nr_writeback,
-		__entry->nr_congested, __entry->nr_immediate,
-		__entry->nr_activate, __entry->nr_ref_keep,
-		__entry->nr_unmap_fail, __entry->priority,
-		show_reclaim_flags(__entry->reclaim_flags))
+		__entry->nr_reclaimed, __entry->nr_dirty,
+		__entry->nr_writeback, __entry->nr_congested,
+		__entry->nr_immediate, __entry->nr_activate,
+		__entry->nr_ref_keep, __entry->nr_unmap_fail,
+		__entry->priority)
 );
 
 TRACE_EVENT(mm_vmscan_lru_shrink_active,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d74b12099bd..0d5ab312a7f4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -863,9 +863,6 @@ struct reclaim_stat {
 	unsigned nr_congested;
 	unsigned nr_writeback;
 	unsigned nr_immediate;
-	unsigned nr_activate;
-	unsigned nr_ref_keep;
-	unsigned nr_unmap_fail;
 };
 
 /*
@@ -1271,15 +1268,17 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 	list_splice(&ret_pages, page_list);
 	count_vm_events(PGACTIVATE, pgactivate);
 
+	trace_mm_vmscan_shrink_page_list(pgdat->node_id,
+			nr_reclaimed, nr_dirty, nr_writeback, nr_congested,
+			nr_immediate, pgactivate, nr_ref_keep, nr_unmap_fail,
+			sc->priority);
+
 	if (stat) {
 		stat->nr_dirty = nr_dirty;
 		stat->nr_congested = nr_congested;
 		stat->nr_unqueued_dirty = nr_unqueued_dirty;
 		stat->nr_writeback = nr_writeback;
 		stat->nr_immediate = nr_immediate;
-		stat->nr_activate = pgactivate;
-		stat->nr_ref_keep = nr_ref_keep;
-		stat->nr_unmap_fail = nr_unmap_fail;
 	}
 	return nr_reclaimed;
 }
@@ -1820,13 +1819,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	    current_may_throttle())
 		wait_iff_congested(pgdat, BLK_RW_ASYNC, HZ/10);
 
-	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
-			nr_scanned, nr_reclaimed,
-			stat.nr_dirty,  stat.nr_writeback,
-			stat.nr_congested, stat.nr_immediate,
-			stat.nr_activate, stat.nr_ref_keep,
-			stat.nr_unmap_fail,
-			sc->priority, file);
 	return nr_reclaimed;
 }
 
-- 
2.16.1
