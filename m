Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEVKIT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:08:19 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:62176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeEVKIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:13 -0400
Subject: [PATCH v7 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 22 May 2018 13:08:05 +0300
Message-ID: <152698368548.3393.17660352117908550018.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::39) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:CLmOOanXf9tAsVKj+2dpKGrROPMRETHJfqgiGndEUIi9P6z2eCA8f4hMiMbekUAQZu+SrH49LoiysaQ5rL+4hRKdgvguckvFG/UWQC2mxK7kbv1+Zg5LqTEG/95vmwcVpMVnQqZ3mrc5Owo+QkYjS/jh+JTU0cLXCHFfzfRKlngcxf2JuehilGy8Soaz9xCJk1e/1j99zcATcJ5nJQrnDQaxF0rYW+rP8DVCC//pK+bA7JXuu6eeYffv7y0PXLZG;25:oDBCZ7PNQyvE2TlnKUXgMuXD07YW91bVnKbXTWjTlfs58/HfLu2LA9pZvKeiUtBU6HhM1n1pBTYuNHp/e8RVQHlnXqSP3fGEehQBNCGZVrUYZUt9zEo/BQ8/2QCVAogicNIOo3mBSrmLG/gMRIAd9nf5BOu0mG+m2ELpugQ6hMfBrH0MiSLxa4SJ8L9Q5ezcGJdTd3P5LRv+HwpKZh+X2VHNvdyjft+WsYHPVYVts6waGLT4LvF0p6hCTC7b5o2RVX5gRcpLUeSDvLUJTgyohXG2saEgS/11/2zVXBC4eIqXIAqqVCUHsJFI2g4SmpOCYrMPiKLQNv6djKirPZn/Gg==;31:Y3yM0NcemRXYGVoe/CwANiQ/ZcdNjRwjhm33Bv0OSf/VqjJ+/8K/799on6EHqp/wDIN+EYD8rwbktHBpET+V10BeWXM0ePubg9BtyCbiHNBGEGhvY9Eb2kAw7ZdZE/suO5Le6UKKCi9AQDEKO9r3ZYyTfdK0SEp+qSivdZ+93t14KoKsJbLS5ltTYpx/hxkpY62B1U+VImdD8lAy+7VLy7dGvMTqphS210tWJttneIA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:ZSO3fmf94Sg3rkeHEBCpdHHvWK+HhagDZXAPSOKYaoheD3deasK9PUZHKadLANfo5OWwLBtIoXcQ0gkj91sRWlckFgsaZ2hgic/ZI+u98H8K3utuUFzU9MU9Jng1eC171SEd/cI4blLmoyvfAnE2z58j8jSkErfmyzRdXRvo9Tu2m3FFzQyB5ymyqLp9+GuKHavVbuDTIFhsRs1OjZSCoNJUMV7Rt4ulxJ500C36t6Sdeil/Yj6VEIHwyX2GHyFhV/ncx7jIV9ZHoK09tJrtKIVvdNRQzASZ1Czo89f6Oemmu03yyb6qnfRQDcVebwQ2fSjgEsUY5pT9nr9eSWUxqKK084Ls4lrUqBW8hyBZtrPlXu0X+Y7Vpm75FwrbMBuNmwI3SFjfvgTefULJR6xBbRdqDzF2GeQ/TGWi2bmFvEROPZZhT3FJBvA2QJxzdntmukhfCh7ILICtnLOPaQh+Av2XO2MTR/2+Ann571zdsoqBOCiDFNJvs+WmvGz546G4;4:AcOZF8Uj14KojfYOoeujZlInVpnxUuFO7C3uuqeMsHar7ee9xAVwDc9GCOT9ZiQ+vTIyT132zZxgjvAU+yKRhmDLezT57lerIPtCUPQOJhQvPyIM2G28sPTQh53obQK132SLTxiA5vL5quJvZak2sXFK/HRkYiNf11LoPYPNErW0pg3IKoI5Bd9ZdKFAo/lo3BJN1zIjp657itwLTeuwFUXrUogpcr7wewaHcHXG0OSMe700VfxxvME3Fut/wx2aT9hwtsRLwrGn/skcgwMitpvWXcthXl+ERKrSWy1aPaP7Uz1izgTg6AvOORMQj1hPtw7pG9nAc0aEeRifLjkqdCtVShFEBWV9yGc/5ul/KSk=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332A589F5D7C357A2B3236ACD940@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(396003)(346002)(39380400002)(199004)(189003)(2906002)(33896004)(55236004)(6506007)(386003)(52116002)(7696005)(59450400001)(2486003)(23676004)(305945005)(6636002)(7736002)(3846002)(6116002)(66066001)(47776003)(26005)(230700001)(103116003)(7416002)(186003)(61506002)(16526019)(50466002)(76176011)(956004)(476003)(486006)(11346002)(446003)(39060400002)(86362001)(53936002)(9686003)(5660300001)(55016002)(8676002)(8936002)(81166006)(81156014)(68736007)(58126008)(316002)(478600001)(106356001)(105586002)(25786009)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6QUYzTjFTMmp0RS9sTnJaS3NzREdhdmlL?=
 =?utf-8?B?UTZySWpVNXE4alVKRkVUZ3FzRkdveC9maC9ldkRCc21xaUJNeHloRnc3QXMw?=
 =?utf-8?B?bGFSQ1c3dFI5bXZsS3duaGdncUVLbXdrL0tzaVhGL1hzbStPQW04WTZJbmYv?=
 =?utf-8?B?a1pyR2xSWHlzZEp5NmxGTHo4SFU0WFU3UU5oa2VkY1pidFZDNkhBYUp1QjFQ?=
 =?utf-8?B?OEFwVUp2cjg0QzZiQTVncWNiVjNEUmFadFV4MUZ6ZUdxbGh1TW1mT0l6enAv?=
 =?utf-8?B?V01iYUlxNm1GTGJTTm1sajdTdzd5YkhraHBGZVBENWtWQXpmcERMMm1oTThF?=
 =?utf-8?B?VXBoS1RDUHlwV0N1dzVITGs2WHJXL0xvN0gzZXBSOVluams4cFRNcjB4TTNq?=
 =?utf-8?B?M0RkUHVmYll5OFBDdWJuTmtuM0NNM2crRlZma2QrMWFyRXYwREVKaFFCV3hB?=
 =?utf-8?B?WHJKZU8yMFhWM09MVm9mUEU1cnNrMEhwb3U2ZWZGYm1UL3FKRzY0L0NMNU5l?=
 =?utf-8?B?Y3NpaE1DYzZ3MHliZWgzVHRMelFDVSs1c085MGZ0Z1g1d2ZHWlZtOU4zYmFp?=
 =?utf-8?B?M0lWS3RXV2JxaHRkUmE2bXVnSXZWc1UzNzBXWi9raWpibkZUV1JWRFVqNVNM?=
 =?utf-8?B?Qk83cXVUeXI3bG1EVDQzaXZ3Z01RQVRaNk4yUnk0bTVoaEFxOGt2VXRGSzRt?=
 =?utf-8?B?QnpNSHdybkF0ZW1LYWZLODlIdG5LcEZVZFVvU21GcHVCMkt4V0I1czJOZjJW?=
 =?utf-8?B?R2hhZWFNWHJLeDJtYXNKQWN1V2hxSXBFNFNnY2pLMGVFNmw3cDJrQ2orSDV1?=
 =?utf-8?B?QS9oRzhMUDRHTVgySUxkNGEwSUxuV0JUUWhXUzd4N3BoUUdEc3ZQMHgrYkVn?=
 =?utf-8?B?ZnM5cCtLZ0xMeXNGc25JN1paN0l1a2gyZDFLWUFZRkp2NjZKUk5kV2ZhUWYw?=
 =?utf-8?B?cmpVL2hBSUFrdW51UlAvQ04yMzBIQUVTUlNuRjNDMkZSYUZmU2J4MWxnYnY0?=
 =?utf-8?B?aHl2L1VBMjN6L2tzL1pHVUpYUHVwdHBPWGU5b3UzSi8rUkhGWmoxK0JHdnVt?=
 =?utf-8?B?T0hKZ2xUOHorQ2xpYndSeUt1Mnk0d0pBZTg2ZWppQi9hLzBpejhVWTNJQUQv?=
 =?utf-8?B?STErdnlhVUZzZU51RTh4bHJxdjVNTEQvd1RkTXNsMm9MZnJnZThkdjJQTW9i?=
 =?utf-8?B?c3JxcGppVTF2c1JIbWF4cTBlMzEzSXJ6K1Yzb1VMbFd5VzN3cis1SktHNStY?=
 =?utf-8?B?Y3NZSERDMkJKQkFJUWd0aklsSHZPZjJQVUtPdDhVT3RTSWs5SnBDM3RjajRu?=
 =?utf-8?B?RXBjM054UGVzOXJkLzFOUFFnQUd5akxOaGpuNGZKMU5VejJxUi9yNExwMXVN?=
 =?utf-8?B?eEMzZlBxK0dWZm91dzcxdW5STW93QUk5VHFqTmlSVU96NXZlNVNrSDBMMXpB?=
 =?utf-8?B?YnBBZHozdjkzZlNFK0lheEJkRXdwclozVTk1RFROQ0ZoVDY3YXA3cDVLUjZQ?=
 =?utf-8?B?ZWo3Y0VCNWZUWmhTWDJnQzU4b3pBbVRGY05RSlp6NnJPeENQR2NVZ1dZOUsy?=
 =?utf-8?B?eVNJWUNaRjZvZFRDZXg3QkRrRHJFeTFxTDVXMnZMM3h3YjFrWXl1RVBNNmlQ?=
 =?utf-8?B?dmNOallEeTNuenQ5WG5jSE1yQ0FEbmlpV29wQkJDbTFzZmlaL2RJdUlMdTFm?=
 =?utf-8?B?Y1U5eDRDVWZHMExBNWZBcEJ5L21qdFErWEFWK2tpcFZlQ2ZSaStxTVNtNlph?=
 =?utf-8?B?SXk3dFBXdGplNnF0bmZScmMxMWxNazlnWW1TaGJNNEluVGpIM3Z2ekt6WU9M?=
 =?utf-8?Q?Khs/0QfILS7S2r2?=
X-Microsoft-Antispam-Message-Info: 4ix5Bgebvp7wVKzwD3R2PFaVcc0aVVhxzgYFOUrgL4aIf4fPF+hmXT3xasZ3Toq5ws5FDH8vW7TH13T0OWUjVTqqbEA8Zqij5+lx0DrJUNzflKq4BOCPjBeF2eu6ogRrukZ9hXBLxu7O+oSdTmcXxEZnNVpH6iZpET8rnUdZ61A2yRd3iLuGtmQEnqdU7hxr
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:kBD8vmhMCs8hEjSuFEu9oWrLDbZviwqTE8M7nqCtWHiVGOFEEcmArjv2SmaWc50pbsrCsgmSHLX32LCYERzs/jWqjdej2+vKi3yg5O8deFl7G8p1ZNpC4mxsRvZOCw625VY5wLdiLbmMUKsASBKLxOx3xG+CPGg6gzl172uukPzi/f1MRMuejpHmWTLj7uFkSCc771sPhps8UqmqkqJuw+AoTFnlAozTCIqQNjHHf1YPvCqfzWmq3hV8aseYwulfu1zpcaS5tGoC9kQZ1ogtfrQbW+8fsAvLgpLk0ORvqmU6MhhFAZM3JsFcZVugVkVNEu53dGViViFzzDsxWu4dsMRKZYggBxGBK0OOeGIvrr/g8mSj9iaqBDH9lm4s0FwsDnoEcwtsLlqf2KxoK6CraVIoce3xpGhUh3IUQinXGZ4a6rJoqd+U2x/KOhP1cH2pVpaR8vU6rnFhxDsvUeZ7ow==;5:lecYmc9J3RDMbz0DtoEVxmIB7tA2LqQtLsteIGkL9ZK+Txrt1U3UD1ftnRX9glponr4cMLF0jMWmAwFXBVoqAiACytKupUFtrsIB3i6rMXvcKVBTDNf+jkRDRatoq73073p7W0n+zkVNopnvb5QDUhr9Lf5t2x6PlMcUeUwHMSQ=;24:tnFmI9D/j//IE0jkDhwNUILDw/U5mKLDBwHvAUf3/gwGv/hjNfSXEat381oSM9bMjqP70YiwiC+KDP9w6dOYnGmykC457uqLnWrCkjEV6jg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:+d1dHk2J6KzNqewMdNCVRo5O8RHC9LZF/MlLChwsJHo5eZNKzYVvIAz+uHThe/qDzzvbnZpKfbSjo1VK5MTcJKBzoGXf3PGE9p7TOaPtr8arOv5W72kfVqbzzyYTNYGQk8ChhZGN/bsDruIDB6OjXv0TbWALrTRWL5+nECMJHuro3TTQodZl5g/0kqdzJTCKR2+mpg0233UDiNngS6Lbm/oPVfZ7Yl5Q+IKpc3YQRE99bPHOXzL88JWd0KhvMJjw;20:MLFkhhghDU2B1j4Aczt7r+wq5qBbmXPuc1W5hdZYL64fRt8bh95E0hmDap0xG1tRLR8so6DCYkPU1Ltmu2iGTwUREMGnoEnkDD+kVxPLWQrPEPQ8vaQp/mCcp/a/OYDS5cB8WFqBtChIKCLYi6ZM7v7quA1LgheS2XrgWqoLku0=
X-MS-Office365-Filtering-Correlation-Id: c26b3adb-87fb-4763-9825-08d5bfcbebb7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:08:07.7880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26b3adb-87fb-4763-9825-08d5bfcbebb7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   14 +++++
 mm/memcontrol.c            |  120 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |    5 ++
 3 files changed, 139 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 996469bc2b82..e51c6e953d7a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -112,6 +112,15 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+/*
+ * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
+ * which have elements charged to this memcg.
+ */
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+
 /*
  * per-zone information in memory controller.
  */
@@ -125,6 +134,9 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
+#ifdef CONFIG_MEMCG_KMEM
+	struct memcg_shrinker_map __rcu	*shrinker_map;
+#endif
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
@@ -1261,6 +1273,8 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+extern int memcg_expand_shrinker_maps(int new_id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 023a1e9c900e..b454f077de44 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -320,6 +320,120 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+static int memcg_shrinker_map_size;
+static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	int nid;
+
+	lockdep_assert_held(&memcg_shrinker_map_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
+		/* Not yet online memcg */
+		if (!old)
+			return 0;
+
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		if (old)
+			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	for_each_node(nid) {
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			kvfree(map);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_map *map;
+	int nid, size, ret = 0;
+
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	size = memcg_shrinker_map_size;
+	for_each_node(nid) {
+		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		if (!map) {
+			memcg_free_shrinker_maps(memcg);
+			ret = -ENOMEM;
+			break;
+		}
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
+	}
+	mutex_unlock(&memcg_shrinker_map_mutex);
+
+	return ret;
+}
+
+int memcg_expand_shrinker_maps(int new_id)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	size = DIV_ROUND_UP(new_id + 1, BITS_PER_BYTE);
+	old_size = memcg_shrinker_map_size;
+	if (size <= old_size)
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	for_each_mem_cgroup(memcg) {
+		if (mem_cgroup_is_root(memcg))
+			continue;
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
+		if (ret)
+			goto unlock;
+	}
+unlock:
+	if (!ret)
+		memcg_shrinker_map_size = size;
+	mutex_unlock(&memcg_shrinker_map_mutex);
+	return ret;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 /**
@@ -4482,6 +4596,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		mem_cgroup_id_remove(memcg);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4534,6 +4653,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 75b00e6ff9db..d8a1ca350a58 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -182,6 +182,11 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (id < 0)
 		goto unlock;
 
+	if (memcg_expand_shrinker_maps(id)) {
+		idr_remove(&shrinker_idr, id);
+		goto unlock;
+	}
+
 	if (id >= shrinker_nr_max)
 		shrinker_nr_max = id + 1;
 	shrinker->id = id;
