Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeDETAl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:00:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751655AbeDETAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:00:10 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] mm: rename page_counter's count/limit into usage/max
Date: Thu, 5 Apr 2018 19:59:18 +0100
Message-ID: <20180405185921.4942-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:c820]
X-ClientProxiedBy: DB6PR0601CA0040.eurprd06.prod.outlook.com
 (2603:10a6:4:17::26) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7030f50-9f79-4020-3037-08d59b276528
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:bm8Ot8MIyAargbVzY6kQwq/RFJgomSAchwvhNt2cjdv5PWvkPR711vteSHUZRt15vq7EibUtToa939UvMiHpDx4eoxBLuPl4oimtTqo5QQIZY52mAVYRY+Fj7QPXn+D30wz3N4TSqHq9051BfQSJ/UundU+qk2EjEhq/RwWKNDKZn2ua+WyJrocf7+aedtHvBRLdJBqd271aL+vf7kURZrkPTWAAsFrZ9SufaTNlysQiTWcwzUofZqqPa8Bd/Tkq;25:DJVH/REv82Rc7v0PBlVyre+LGFCnD+TRkvUs9FwzD3L5c2bVdd8AtvfFg71COi3ImJv/LbycyLMpsfvMo2EuDZi9gWA86jNfYOR1Uxa/8rIh8HYQlDoQACMowz8ODsMyvjTjRG/qycaJv/L/twk2U++6NmoeYcK5ISYa3oHP8qmHkddiFWih6huz/JUyIx2XobDXGG7+4R9FGA8haJaRPmbxgJSnm00hxbia+2sIVfOxX1d3YwlLvzBxbL33Vn6YmN6/IRDdDV18YAd2kzXSey5UX4/ZxS1BcMshAZYRCi+FZLBmhaszHvI4Wf6kita3mM81FdG27WZcOe3sfwmHLA==;31:AGYABoyxEMaDkNG1Y1+2zMb2/FAO4yig8xlmpJJq6VYHgy2fQE57Y8WPgH2XIz62lr2zBcY4kmuPNh61TRVt3hSKkpt7htvWmfSsiCvJnyzzgsAE9o90uRfkIhpPtWR3zvfYEYJ967Li+qwJREk/i42vB9TPe4D1yfG0FfxQYnXvx5oFKGamA+2XTrknaiC4hhcsH4u0WFC5sn8JDjMl6TdvNjb9d3ysBhLsboCKahw=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:e80Q6EiId6C+IStZW8Wd9FdaldMryaT7bE6CxR7R4HRoammseKlAHtau5PSTcmRbH1JaAO4kCrpok40SthkeK3/9Rn2B2b/ITJrKNzI9VrwXloLR9UJHPvRJuVlgeG+a4FzjFCXul3W7seRKv4boiI4/G78BkbOxLmMg3G8B4MpZ5F0oqUXlT8Qq4WOGpiaPeUk4pIhpXrE2pfAVg5yzNTydcV/VRKMTleB2YvuS5dQo1BbCXiMzoDwn1vnj0AlBLjDdyn3vRuswt0EnKYqBjKe2B572NR73VfN7uJWo/az9ufrRqFhtqx6menxx0zJxabroGDbW7FAi50rRJenbuo/gptrNxWy11N7ixw6qULS8CjmtPM094ny+LqvYQRw1h451hIIsLbEM66guK9JXfr/h9u/ABwCvjZzHOrWN7e7USwF+eAm56ldW7plBXJgdVUPGvMHgYzhs1bx58NnCmtGy9ibOquxrsucZIT+5q3PcIoDx4U+NluF9ay9AYREi;4:Ega5Zz6Yd3vZDp5FFbcRXC2i6S0Rtxu5Zm8nKEILDYk6C4LIN+0mvz1bbKu4aR2M+baSQS2D9IPltYTHu0s9xPJ4g3Pm9oqbf+o2UdwQ6QajOD+swCWVPPqQ0V3RqaqvKUb5YOJhTb5YOwwXIu49aS4UX7nBIOSVwfMA5Y8CxabVR8g60Gh8FkjN2RpFhulwlaixyu3YGBzkifJXYYIFDcHE2UR6+7vmHloFdRmrkyCwHGpy7QzDJxi8VqE2gtlt/tPJpVxvZvJfpguRFcFTsNfWfdjdCki7Rs+s8po8FsT9dLhY4uqj6SIvQNOcBInj+uySlg2o37fts8VbCmxxBnPMyMXf4spUY3deK8BaD5it8WDUEpv/8BKIoaNVXi5N
X-Microsoft-Antispam-PRVS: <CO1PR15MB1078A7CC994C5DA2E977F65DBEBB0@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(2361001)(2906002)(316002)(5660300001)(69596002)(51416003)(52116002)(52396003)(106356001)(47776003)(86362001)(46003)(68736007)(305945005)(6116002)(486006)(478600001)(7736002)(16586007)(59450400001)(50466002)(39060400002)(1076002)(48376002)(36756003)(6916009)(2616005)(6506007)(53416004)(50226002)(6666003)(4326008)(8936002)(54906003)(476003)(97736004)(186003)(25786009)(6512007)(53936002)(16526019)(2351001)(81156014)(105586002)(81166006)(386003)(8676002)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:PyQSP9dTp8rG6ue8BYE4xzFBfN5aGaOoBqwP/lmjp?=
 =?us-ascii?Q?gty+UQpU5dg2omjXYz+WdIZBg1icwzFxcaQXG1TlWJxZhxmTMNJORWhldnAV?=
 =?us-ascii?Q?jKGL3vBM2lEs3iQY24VxJAp/dOw/WSZV7k1wjUnyPEwiCW2P0eS+h7WvlHIc?=
 =?us-ascii?Q?OIa5r/LsSQimx5J+JpsjG4jvbaahgbizC8P7EYACuBI349qBba+i7l4yYXtj?=
 =?us-ascii?Q?SvXBRNfSd1zh96PBj1s6YAOq1hKzDjzU/y3SFvlR72iMqnLxoPar11V/k4rU?=
 =?us-ascii?Q?inVvZzvtUI2ZW7SHdiONxgAT//SiUCfnYvYPQJdP+Kp37WmCWH3XMaZW1qjM?=
 =?us-ascii?Q?EdxYwqTmRLxoclicDMmhB5Z914KEtQ9ypBS1Z5yX1LCJby3e/4a3k9sPw9Fz?=
 =?us-ascii?Q?ZYetaJDZR8pXK6238E+RoHKHglyR2V2ixKhN8OUxnn6iirak/mTmswkSzrfj?=
 =?us-ascii?Q?0hb0Ad1cH/vcRW8X/ZY+ZXuL+vJ75iMtMwwi/N4EFTZhL+/5piCYsgPieLCj?=
 =?us-ascii?Q?gghYnH5h1sWU3duBKdv6LgAcZ8uzx8RLcJHiTC23MntVp4BY5cSZxCokMNyQ?=
 =?us-ascii?Q?SGfDpmS6CaOVnIz+AoGXGIPOVPjvslsNz1bCmfEzVUVII7JfP0rwLRKR8+2p?=
 =?us-ascii?Q?naOX9q42p+Y+U+T8LTU7lfzNV3GDZT9gvHRbNDX+mklgLeV7qphy3bWUI2tH?=
 =?us-ascii?Q?0PPkSvn5y/0nQWWIw/fkkEm7bEUimnRqwA1LOINSIWI5qFbZpRypKn0ChPdQ?=
 =?us-ascii?Q?88O1BOhVTrqA0LsHqH9FyFd3GGiY/8j2qFOOhK5pZ598SU4MGHgvNc7y8lYh?=
 =?us-ascii?Q?4wmxjlx8NwfXnL8rGN2Cgx7LmhmNO5KvEtaKRLMKzslgZxsdOr4TQ+i5e3oo?=
 =?us-ascii?Q?IQkRdY4+1zc0dLMmXwjM8kPX983VkYIJTYhTAkrfqrhI6SdliTtFdRAIK+Pt?=
 =?us-ascii?Q?EEP9WTlX+pgNudJXXIVeOmmOfLmgHMrGlGIf2dBt0+tkKmkzSIH4JeuCx4zC?=
 =?us-ascii?Q?+tSXsg6c64yMFuAYt4ZRq3Po0LCoA3U01oCFadYrXi3s8UIn/H3z6M11sR1t?=
 =?us-ascii?Q?Ire3GIAiBSeDlOxX6iY80nOPOwJgCzZ7FU0k9iPewVxI9n0KrcKMMMMPwpWb?=
 =?us-ascii?Q?Cl+astYVYZ+vc99BrFc2ZqsOzCsIUJclvkEXLQw1lB6tx2g526ntFbS+L5yv?=
 =?us-ascii?Q?kmZxTe1tVv7TwJ/oBJ0xInItCnhGuaGYIPXq8ZMOHmzbaz6p2XghQKBEOhrS?=
 =?us-ascii?Q?n5/zAobAS40aYgYT3pNMKRNlcUpRwatExNn16GG43LZAtPIFKm3cCrV2WVEu?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 6I2LMX3ei/I9dXG1v8MQNJVo3T7AHVhjk3EqT9QWHDbUH0+oNaeg9yw99BhwsC2y1JSDoi2ByL5Shxya2hStiVI6XdJIjWeeY2FdNdRDd/ln/YyEjaGRWzBPtDPcrkUboSH7rlvFxdK6/rEsiYmfNjFEUmTUZtWWR11jkkpUoJZ9s7mtTNeTBzUYuV1yxU0J
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:2jtQ26S7mQVQE/N3LfNo294FtYBEC2mFuceYiIjzr09aAIPe51An6w9s2vUVnnDxrY8lDMtFsQ59keRKhwu7Bx0nKXvG6NiVoBoPJWol4c8bh4al+wl2XEqWpHyN3HSkqGye1MI0dPJqTDTllenl5DSkWUZMNoVaAzqFzGkBCICvquC8nSK80+79jkLRvf4G/9ehgX+JSHgIaMQnkSJx7/qSZNGU4p/xn1PJsyhsA4WScK6YnWIkDnraYY8KWr3C41wNJr/7MUxGaFdwQrWxi+GF/UEXHpks84F0MMpG6sSOWspXQC534DlD7iO3Ql67jNcAf58yRK5Pm43d7YVeDxWwukokPKlXRWvacDnpDXxqjy0TMs/l0sCMtuoMGeg3muqC8k3mIFEy+sIfrNuS37QlTPs3cFrzWFyinvNQVBpGdqGkS5gRn5s1n2AmWh+JHiJ61SZwR3P6uwDG5lJjYA==;5:7mWPhZk79hgKKFlhH1U9OlJAK0VAXi1M5t/1r73exypoSrP2s/oqOOf/mNVZmltf57SEXVEWA4oo+rXoPulIIEp/ymmqeTaSIdEVSupLDp3GQs1877Aah5WyAJa1EQp/N/GuiwW+0tGr1HpD50UzScKrM7O2yeJh17giowK1UXc=;24:/2qNiXm4QwOOZG2sXa1YHuDmoxnsp9wprg4iApcmvZUmcvqnWJhiEMU+KdBI9xkflGEGoxjga6iq/e1snKCkul3IdaRkgc8dbzixMeOAHjI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:rtFeXlHEO67slrmEWM9kEPub6RCQDevH/2h6lDs0NLJzOk+S3DYg99We2w4VGCIwyNPr5QeYb8nTmJhjlCcYzPXylSiYeXmINVUMkJrox+qUPf63etBuBx87Ly3bso1aUYVgsncgNc3VLsSp9TI3iEpG1ZBrBVFIGysZe+ldy4gShO5TBZWjP3ev7Y6QVQhBoLdrVnWxOgQRDkvD5R6cl9XJK/6kjLcjDt7U2SLRSvB9IueZFaWUXeoTUzyn3CLn;20:dwTKPl/mD6k3nFf04tXHHTkpNSGT6L/fVOCdQspc2+RTPVpPi7iUALkPikhDspxXl0ZRlCK3bB+ccOGJiREqD4Bms+0WbediSAz8HYx7r9hs2MXMws0msa/931H6jsA7oqIh8lwZj5UMqsv6fzIAMqP/a1oj8HUwz5+qQmrUsw0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 18:59:42.5017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7030f50-9f79-4020-3037-08d59b276528
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames struct page_counter fields:
  count -> usage
  limit -> max

and the corresponding functions:
  page_counter_limit() -> page_counter_set_max()
  mem_cgroup_get_limit() -> mem_cgroup_get_max()
  mem_cgroup_resize_limit() -> mem_cgroup_resize_max()
  memcg_update_kmem_limit() -> memcg_update_kmem_max()
  memcg_update_tcp_limit() -> memcg_update_tcp_max()

The idea behind this renaming is to have the direct matching
between memory cgroup knobs (low, high, max) and page_counters API.

This is pure renaming, this patch doesn't bring any functional change.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h   |   4 +-
 include/linux/page_counter.h |  12 ++---
 mm/hugetlb_cgroup.c          |   6 +--
 mm/memcontrol.c              | 112 +++++++++++++++++++++----------------------
 mm/oom_kill.c                |   2 +-
 mm/page_counter.c            |  28 +++++------
 6 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44422e1d3def..caa31cc09e7e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -475,7 +475,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 
 void mem_cgroup_handle_over_high(void);
 
-unsigned long mem_cgroup_get_limit(struct mem_cgroup *memcg);
+unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
 void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
 				struct task_struct *p);
@@ -882,7 +882,7 @@ mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 	return 0;
 }
 
-static inline unsigned long mem_cgroup_get_limit(struct mem_cgroup *memcg)
+static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
 	return 0;
 }
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c15ab80ad32d..94029dad9317 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -7,8 +7,8 @@
 #include <asm/page.h>
 
 struct page_counter {
-	atomic_long_t count;
-	unsigned long limit;
+	atomic_long_t usage;
+	unsigned long max;
 	struct page_counter *parent;
 
 	/* legacy */
@@ -25,14 +25,14 @@ struct page_counter {
 static inline void page_counter_init(struct page_counter *counter,
 				     struct page_counter *parent)
 {
-	atomic_long_set(&counter->count, 0);
-	counter->limit = PAGE_COUNTER_MAX;
+	atomic_long_set(&counter->usage, 0);
+	counter->max = PAGE_COUNTER_MAX;
 	counter->parent = parent;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter)
 {
-	return atomic_long_read(&counter->count);
+	return atomic_long_read(&counter->usage);
 }
 
 void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages);
@@ -41,7 +41,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     unsigned long nr_pages,
 			     struct page_counter **fail);
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
-int page_counter_limit(struct page_counter *counter, unsigned long limit);
+int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index eec1150125b9..68c2f2f3c05b 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -84,7 +84,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 
 		limit = round_down(PAGE_COUNTER_MAX,
 				   1 << huge_page_order(&hstates[idx]));
-		ret = page_counter_limit(counter, limit);
+		ret = page_counter_set_max(counter, limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -273,7 +273,7 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 	case RES_USAGE:
 		return (u64)page_counter_read(counter) * PAGE_SIZE;
 	case RES_LIMIT:
-		return (u64)counter->limit * PAGE_SIZE;
+		return (u64)counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
 		return (u64)counter->watermark * PAGE_SIZE;
 	case RES_FAILCNT:
@@ -306,7 +306,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_limit(&h_cg->hugepage[idx], nr_pages);
+		ret = page_counter_set_max(&h_cg->hugepage[idx], nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18dda3f113bd..50d1ad6a8fdb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1033,13 +1033,13 @@ static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
 	unsigned long limit;
 
 	count = page_counter_read(&memcg->memory);
-	limit = READ_ONCE(memcg->memory.limit);
+	limit = READ_ONCE(memcg->memory.max);
 	if (count < limit)
 		margin = limit - count;
 
 	if (do_memsw_account()) {
 		count = page_counter_read(&memcg->memsw);
-		limit = READ_ONCE(memcg->memsw.limit);
+		limit = READ_ONCE(memcg->memsw.max);
 		if (count <= limit)
 			margin = min(margin, limit - count);
 		else
@@ -1147,13 +1147,13 @@ void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memory)),
-		K((u64)memcg->memory.limit), memcg->memory.failcnt);
+		K((u64)memcg->memory.max), memcg->memory.failcnt);
 	pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memsw)),
-		K((u64)memcg->memsw.limit), memcg->memsw.failcnt);
+		K((u64)memcg->memsw.max), memcg->memsw.failcnt);
 	pr_info("kmem: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->kmem)),
-		K((u64)memcg->kmem.limit), memcg->kmem.failcnt);
+		K((u64)memcg->kmem.max), memcg->kmem.failcnt);
 
 	for_each_mem_cgroup_tree(iter, memcg) {
 		pr_info("Memory cgroup stats for ");
@@ -1178,21 +1178,21 @@ void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
 /*
  * Return the memory (and swap, if configured) limit for a memcg.
  */
-unsigned long mem_cgroup_get_limit(struct mem_cgroup *memcg)
+unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
-	unsigned long limit;
+	unsigned long max;
 
-	limit = memcg->memory.limit;
+	max = memcg->memory.max;
 	if (mem_cgroup_swappiness(memcg)) {
-		unsigned long memsw_limit;
-		unsigned long swap_limit;
+		unsigned long memsw_max;
+		unsigned long swap_max;
 
-		memsw_limit = memcg->memsw.limit;
-		swap_limit = memcg->swap.limit;
-		swap_limit = min(swap_limit, (unsigned long)total_swap_pages);
-		limit = min(limit + swap_limit, memsw_limit);
+		memsw_max = memcg->memsw.max;
+		swap_max = memcg->swap.max;
+		swap_max = min(swap_max, (unsigned long)total_swap_pages);
+		max = min(max + swap_max, memsw_max);
 	}
-	return limit;
+	return max;
 }
 
 static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
@@ -2458,10 +2458,10 @@ static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
 }
 #endif
 
-static DEFINE_MUTEX(memcg_limit_mutex);
+static DEFINE_MUTEX(memcg_max_mutex);
 
-static int mem_cgroup_resize_limit(struct mem_cgroup *memcg,
-				   unsigned long limit, bool memsw)
+static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
+				 unsigned long max, bool memsw)
 {
 	bool enlarge = false;
 	int ret;
@@ -2474,22 +2474,22 @@ static int mem_cgroup_resize_limit(struct mem_cgroup *memcg,
 			break;
 		}
 
-		mutex_lock(&memcg_limit_mutex);
+		mutex_lock(&memcg_max_mutex);
 		/*
 		 * Make sure that the new limit (memsw or memory limit) doesn't
-		 * break our basic invariant rule memory.limit <= memsw.limit.
+		 * break our basic invariant rule memory.max <= memsw.max.
 		 */
-		limits_invariant = memsw ? limit >= memcg->memory.limit :
-					   limit <= memcg->memsw.limit;
+		limits_invariant = memsw ? max >= memcg->memory.max :
+					   max <= memcg->memsw.max;
 		if (!limits_invariant) {
-			mutex_unlock(&memcg_limit_mutex);
+			mutex_unlock(&memcg_max_mutex);
 			ret = -EINVAL;
 			break;
 		}
-		if (limit > counter->limit)
+		if (max > counter->max)
 			enlarge = true;
-		ret = page_counter_limit(counter, limit);
-		mutex_unlock(&memcg_limit_mutex);
+		ret = page_counter_set_max(counter, max);
+		mutex_unlock(&memcg_max_mutex);
 
 		if (!ret)
 			break;
@@ -2989,7 +2989,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 			return (u64)mem_cgroup_usage(memcg, true) * PAGE_SIZE;
 		return (u64)page_counter_read(counter) * PAGE_SIZE;
 	case RES_LIMIT:
-		return (u64)counter->limit * PAGE_SIZE;
+		return (u64)counter->max * PAGE_SIZE;
 	case RES_MAX_USAGE:
 		return (u64)counter->watermark * PAGE_SIZE;
 	case RES_FAILCNT:
@@ -3103,24 +3103,24 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
 }
 #endif /* !CONFIG_SLOB */
 
-static int memcg_update_kmem_limit(struct mem_cgroup *memcg,
-				   unsigned long limit)
+static int memcg_update_kmem_max(struct mem_cgroup *memcg,
+				 unsigned long max)
 {
 	int ret;
 
-	mutex_lock(&memcg_limit_mutex);
-	ret = page_counter_limit(&memcg->kmem, limit);
-	mutex_unlock(&memcg_limit_mutex);
+	mutex_lock(&memcg_max_mutex);
+	ret = page_counter_set_max(&memcg->kmem, max);
+	mutex_unlock(&memcg_max_mutex);
 	return ret;
 }
 
-static int memcg_update_tcp_limit(struct mem_cgroup *memcg, unsigned long limit)
+static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 {
 	int ret;
 
-	mutex_lock(&memcg_limit_mutex);
+	mutex_lock(&memcg_max_mutex);
 
-	ret = page_counter_limit(&memcg->tcpmem, limit);
+	ret = page_counter_set_max(&memcg->tcpmem, max);
 	if (ret)
 		goto out;
 
@@ -3145,7 +3145,7 @@ static int memcg_update_tcp_limit(struct mem_cgroup *memcg, unsigned long limit)
 		memcg->tcpmem_active = true;
 	}
 out:
-	mutex_unlock(&memcg_limit_mutex);
+	mutex_unlock(&memcg_max_mutex);
 	return ret;
 }
 
@@ -3173,16 +3173,16 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		}
 		switch (MEMFILE_TYPE(of_cft(of)->private)) {
 		case _MEM:
-			ret = mem_cgroup_resize_limit(memcg, nr_pages, false);
+			ret = mem_cgroup_resize_max(memcg, nr_pages, false);
 			break;
 		case _MEMSWAP:
-			ret = mem_cgroup_resize_limit(memcg, nr_pages, true);
+			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
 		case _KMEM:
-			ret = memcg_update_kmem_limit(memcg, nr_pages);
+			ret = memcg_update_kmem_max(memcg, nr_pages);
 			break;
 		case _TCP:
-			ret = memcg_update_tcp_limit(memcg, nr_pages);
+			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
 		}
 		break;
@@ -3358,8 +3358,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
 	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
-		memory = min(memory, mi->memory.limit);
-		memsw = min(memsw, mi->memsw.limit);
+		memory = min(memory, mi->memory.max);
+		memsw = min(memsw, mi->memsw.max);
 	}
 	seq_printf(m, "hierarchical_memory_limit %llu\n",
 		   (u64)memory * PAGE_SIZE);
@@ -3858,7 +3858,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(memcg->memory.limit, memcg->high);
+		unsigned long ceiling = min(memcg->memory.max, memcg->high);
 		unsigned long used = page_counter_read(&memcg->memory);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
@@ -4548,12 +4548,12 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	page_counter_limit(&memcg->memory, PAGE_COUNTER_MAX);
-	page_counter_limit(&memcg->swap, PAGE_COUNTER_MAX);
-	page_counter_limit(&memcg->memsw, PAGE_COUNTER_MAX);
-	page_counter_limit(&memcg->kmem, PAGE_COUNTER_MAX);
-	page_counter_limit(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	memcg->low = 0;
+	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	memcg->high = PAGE_COUNTER_MAX;
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
@@ -5360,7 +5360,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 static int memory_max_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long max = READ_ONCE(memcg->memory.limit);
+	unsigned long max = READ_ONCE(memcg->memory.max);
 
 	if (max == PAGE_COUNTER_MAX)
 		seq_puts(m, "max\n");
@@ -5384,7 +5384,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	xchg(&memcg->memory.limit, max);
+	xchg(&memcg->memory.max, max);
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
@@ -6331,7 +6331,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 		return nr_swap_pages;
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
-				      READ_ONCE(memcg->swap.limit) -
+				      READ_ONCE(memcg->swap.max) -
 				      page_counter_read(&memcg->swap));
 	return nr_swap_pages;
 }
@@ -6352,7 +6352,7 @@ bool mem_cgroup_swap_full(struct page *page)
 		return false;
 
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
-		if (page_counter_read(&memcg->swap) * 2 >= memcg->swap.limit)
+		if (page_counter_read(&memcg->swap) * 2 >= memcg->swap.max)
 			return true;
 
 	return false;
@@ -6386,7 +6386,7 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 static int swap_max_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
-	unsigned long max = READ_ONCE(memcg->swap.limit);
+	unsigned long max = READ_ONCE(memcg->swap.max);
 
 	if (max == PAGE_COUNTER_MAX)
 		seq_puts(m, "max\n");
@@ -6408,9 +6408,9 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	mutex_lock(&memcg_limit_mutex);
-	err = page_counter_limit(&memcg->swap, max);
-	mutex_unlock(&memcg_limit_mutex);
+	mutex_lock(&memcg_max_mutex);
+	err = page_counter_set_max(&memcg->swap, max);
+	mutex_unlock(&memcg_max_mutex);
 	if (err)
 		return err;
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index dfd370526909..a420a703b8d5 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -256,7 +256,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	int nid;
 
 	if (is_memcg_oom(oc)) {
-		oc->totalpages = mem_cgroup_get_limit(oc->memcg) ?: 1;
+		oc->totalpages = mem_cgroup_get_max(oc->memcg) ?: 1;
 		return CONSTRAINT_MEMCG;
 	}
 
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 2a8df3ad60a4..41937c9a9d11 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -22,7 +22,7 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 {
 	long new;
 
-	new = atomic_long_sub_return(nr_pages, &counter->count);
+	new = atomic_long_sub_return(nr_pages, &counter->usage);
 	/* More uncharges than charges? */
 	WARN_ON_ONCE(new < 0);
 }
@@ -41,7 +41,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 	for (c = counter; c; c = c->parent) {
 		long new;
 
-		new = atomic_long_add_return(nr_pages, &c->count);
+		new = atomic_long_add_return(nr_pages, &c->usage);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -82,9 +82,9 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * we either see the new limit or the setter sees the
 		 * counter has changed and retries.
 		 */
-		new = atomic_long_add_return(nr_pages, &c->count);
-		if (new > c->limit) {
-			atomic_long_sub(nr_pages, &c->count);
+		new = atomic_long_add_return(nr_pages, &c->usage);
+		if (new > c->max) {
+			atomic_long_sub(nr_pages, &c->usage);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
@@ -123,20 +123,20 @@ void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
 }
 
 /**
- * page_counter_limit - limit the number of pages allowed
+ * page_counter_set_max - set the maximum number of pages allowed
  * @counter: counter
- * @limit: limit to set
+ * @nr_pages: limit to set
  *
  * Returns 0 on success, -EBUSY if the current number of pages on the
  * counter already exceeds the specified limit.
  *
  * The caller must serialize invocations on the same counter.
  */
-int page_counter_limit(struct page_counter *counter, unsigned long limit)
+int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 {
 	for (;;) {
 		unsigned long old;
-		long count;
+		long usage;
 
 		/*
 		 * Update the limit while making sure that it's not
@@ -149,17 +149,17 @@ int page_counter_limit(struct page_counter *counter, unsigned long limit)
 		 * the limit, so if it sees the old limit, we see the
 		 * modified counter and retry.
 		 */
-		count = atomic_long_read(&counter->count);
+		usage = atomic_long_read(&counter->usage);
 
-		if (count > limit)
+		if (usage > nr_pages)
 			return -EBUSY;
 
-		old = xchg(&counter->limit, limit);
+		old = xchg(&counter->max, nr_pages);
 
-		if (atomic_long_read(&counter->count) <= count)
+		if (atomic_long_read(&counter->usage) <= usage)
 			return 0;
 
-		counter->limit = old;
+		counter->max = old;
 		cond_resched();
 	}
 }
-- 
2.14.3
