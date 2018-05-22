Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEVKKH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:10:07 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com ([40.107.3.106]:28343
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751354AbeEVKJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:09:59 -0400
Subject: [PATCH v7 15/17] mm: Generalize shrink_slab() calls in shrink_node()
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
Date: Tue, 22 May 2018 13:09:53 +0300
Message-ID: <152698379298.3393.3040399931339145602.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0502CA0027.eurprd05.prod.outlook.com
 (2603:10a6:209:1::40) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:VdWHoSrNpHFEZR0tT5Ix5f/QJ9+U4ObtNy0yjIYn+mYoTM03h6C6PWvI/HYX7g+QP8z2rJmH/ZnaToE8Acr523lDeF81u/HXhJLK2LGRJwM5jWq76KauX3thoEro3WJ1N+vZWZhCYRwvlUo7mLrdkKe2rrzXDCWZhtj/T3pf6LqIZ73yXdaW69T09C0hV2m8/IpQL+twV5/QhPAEQZfMgBj47eeHnIZzL/qol+mN8fgxI0ljk+ZnfuYeI5inDTTg;25:3Qc/9kfCo+wGJ/VQ9Sr55dvQf3FaMitXC3Ln4nxK13BmfQ7hdwv1WIcu/I29qz/KRb//XLEjeqieGN7dSQ/obdBqNpfMUlI0fMbrbKaulm3WURwU6pOa1YO9D8ltPNgk2nSmpnvrolDBmWH/AU+ba5Li5mIlSq+P3VkCHtpAiFlwbIpS1LA3KrXDrjus9MLJKbf5utbeAV93WRMHVc7U5wEcW6duGR2Y9/pnvWxLR4THxxSQPplGE7Z11l4hF3pF4vEJAjrgZIiuL5zLJL/YHBmVU693Eag80qSfZ+Tf1FZlAm5Z1pzQc0CpWoPH9u9hrbTgbEJA3Qe4pRI/m8fSIQ==;31:CPuyL7gCgxxxQWzfE54S2ff20j8/wwiAj0dnZrS8Y+pjnC3yeRKSe8FcC3pnjwHQHnmi/x14cyyx6ayFmT9CmN1VgNpjDuoNJN8ToYt+YSxFRXK3JesDQUL8h56PrFBjzYzzNV4iW+5wlh1LltmFIQEoTiQwLe/MIIRB+cGCCYeN0ZLNJyvmm+3tAy0QH+gXgCwZYq6Q1CS7KYe9rN5fwMHP8ncH+ALvqtBPPz4gGOo=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:Gdrq1/c4ZnzC+pgwRyZYyHFV0GI2nno52dOpxpf2CNJILT0V2wwVAVBog0Md4lF20dz+n25CQAD/oMX6keqZb2ecySpcqIIW5SXJ7vjPD2vHFtlVaG5ArtjqKXDI5Yl9H8iA7MOEAE2oTdqNo/mdT2osKlm7X4C3PbJsCBIEprtKk9xMorAH+GWs1NierjtSjU5XWRMJg0+iRfwtikhaQwiKUfgrJneZzGtY3tj/jHoJSmEDT+xMt75zwiMBNDHnpfCzklbMmo17V1suFrXV/tAw6Z3rTuF1ImM3OAZ3EHOE9QH903uZUYmviiiCQD+vYgcEmLggrPlazlX4RxLtdMRLjbY9NF8ncpPmSYYLm4n/eWnaRP2hTtrDnrs4zNyDbPyIZz9RsJrPKFnJTI27Mv4MBcqZNIxLQcdHnxgvXWTpXP9H+hZ7rzXXsllV9tE7t5WHHGa2uJW4LqR3WzkUZMjXBlbQOIrkHwvfvViWzg479fEbyjqZ58wNO0qC9Ncu;4:1vaWDgnhVXxAF9e0ZbzvU1+OjEiKkFHW8U90d2hN8fQPV+nzqLmgykgGSyYe3wT52noPXFID4tLnzvhXsQNHpr6rhyC6qBnIsoibk+qi66XA34n4E5C3+HgOFsSdHEKTipvACCnroUTgdn8h0RVzfrFGjITtd+6ItUk6NsObso4jw4OlQ9+0VUeVZit4hfXB2FwXUlk4f9a+JRmGVMOwIG/6oipB1QM1yOYUuDTYx7xYAFdUYW8PCmjnNqR6TBL5TSdbZA6v477teR30NQCa0204OAfM4WNyri3UEAJFmbt/iOSUin2ltUnFpUHkqvI1
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332015A540F319326F3F83CCD940@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(396003)(346002)(39380400002)(199004)(189003)(2906002)(33896004)(55236004)(6506007)(386003)(52116002)(7696005)(59450400001)(2486003)(23676004)(305945005)(6636002)(7736002)(3846002)(6116002)(66066001)(47776003)(26005)(230700001)(103116003)(7416002)(186003)(61506002)(16526019)(50466002)(76176011)(956004)(476003)(486006)(11346002)(446003)(39060400002)(86362001)(53936002)(9686003)(5660300001)(55016002)(8676002)(8936002)(81166006)(81156014)(68736007)(58126008)(316002)(478600001)(106356001)(105586002)(25786009)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6TFFTYXYwWFFqM016eFRVQ0NSTWJDQjF0?=
 =?utf-8?B?N0tZaDlBZTVvQkdaYTYwRkxnSE02ZExPZCs5bHcyeFhOTlZZYUN0TkRieXBq?=
 =?utf-8?B?RE44SXFhQkJjT2RGOUpZcEx4YkNPdkpYTGpxbFM0Yk5SMHZoMFhKOURvSnNW?=
 =?utf-8?B?c3Vxa3NnMXhwTUYwaWpGT0Qvck83UUR3MFl3UnZaTWFrSFlDL0thMHJzaHhW?=
 =?utf-8?B?TkVHWEJsTmc2UzVDZkFXQ04rTUFqS0F1cWFSb1Y4ZEVLRis3SWphSlRvMGtu?=
 =?utf-8?B?U0JLWWZnbFJvVzVVTGNIc2tRUWZhSGxna2xsb1dpQStuVkRNbERRblpIQzFC?=
 =?utf-8?B?Z2U0ei9XQ1krMUl4Z1Z4SmQ0NW1Sb3Jkd1pRUFgyY2ZUSGJDVHlMQ3BuV0dK?=
 =?utf-8?B?USttVGl1NzlRVkljdWp2bE5iVmVZWGVIRW13V3VHeXc5ZDNsVGxGa0RSdjFm?=
 =?utf-8?B?alNNbytSSVFNcUFlMDNOZFUxL25rS2p2SFgvODFvb0U3S0cvcTI2RkpqYitI?=
 =?utf-8?B?b2FMMHp0elNTeWdqSzlhZFl3Y1hpM3h4WnNzL25MZy95ek1aL2dtb2s0NVk5?=
 =?utf-8?B?dmwwUno1Um5tRit0ZTB2RWtTTGU2YnJuK3I5VTJSM29nTTNFc0xmUStIVVEv?=
 =?utf-8?B?VE5CSHkvcnRmN3ExVnBTdjV0OGRuWnh5dHE0TTB6bnhpcUxQSkNmZ3dLNUt3?=
 =?utf-8?B?WUtXNmVPbkFQS3V4enk5WkJIZEJmbFpKZUVqT1hrd2NlYlhPQjJUSFA4eGlC?=
 =?utf-8?B?Vmp4dksxTWZReWFCYS9RLzBPaUxuWDhPS1lDVGtUY00wWlUrSStZYy9SY2JW?=
 =?utf-8?B?eDJxZW1KRVZ6a0s1eTV6bndqM0dlYkp6SnhXQkoxYjRtSnNjSlROalZZV2Er?=
 =?utf-8?B?ZVN5OFJoMEowQVlSYlh4eUNmcU5HaFRjbzJNSGhoalptNzMybzlYOFpRd0RI?=
 =?utf-8?B?OHJTNXJ6SFpVM0hQYWNjUTE4cHgvVWtzQXA5dkxzRWwxMS9ua3g3STdGVXY4?=
 =?utf-8?B?RGFKR2RyMjkzQVp0WUtwN2J5UTh0dzZPNUorNmtGZ1VvcUh0ZDYxUndzS2tK?=
 =?utf-8?B?UGpzYTN6dDlmbklJNVZnNlJiTG05YzVERCtDN0REVlBleExndjlINHpMbHdy?=
 =?utf-8?B?SVZYK1h5dVpHQ2puRHA0NFZFa2JXSzNkWlhlazN1ZHlaSTVhYnkyalVacGRI?=
 =?utf-8?B?V2U3THVzSWhSK1BmL1RBL1ZKUUV1ZTRkSXgzRUhIR0UrNExhd1c5Rkc5Sm8w?=
 =?utf-8?B?bnJwektlUzIrNEJLQWd0WFdoOVdvODdFaXNRVjlLVzJQRmFDdjhUVUVoRmFl?=
 =?utf-8?B?NzUrRUdSbmp0YmRQT1h4S0RudXYxUmFoWWpZNkg4cVdsVnE0Uk8yN0cvY1da?=
 =?utf-8?B?RGoyQU94WmNhS2V6dWhTV2xVRUZ2dW1NdzhZZ2t4U1h4TXdXNDBMa1U1Rkdo?=
 =?utf-8?B?QmdpZW4wTVlKbzJIelZaVjh4d3lKZWcxNDdrMUtkS3ZHeWFZRkNvL1NhNkRG?=
 =?utf-8?B?Mm1lRml2V0hqcEgrS2xjWGFicUQ0NlJXTzJYWVRNK3RUVEFRcEpVblVaZHUw?=
 =?utf-8?B?d2lnNXBKTXNhVCtqMEROcUdvV3l3cmJGTzRkbHVYTzFhdkx4ZlpzMklDU3Fi?=
 =?utf-8?B?eW9jLzlsTjZOZDQvbFNGaGZReDNRbTlWMENucU9pREg4ckpiN0VWY0lQR0lG?=
 =?utf-8?B?ZGFGTCtQaU9OTGVRWjI3L0EzUGM4WE5GSEJwTUd1YnRVeExWWk53Vm1kN3FZ?=
 =?utf-8?B?UXpBWGZYZUNCcGdDTFliSE1kU0dlR0lIWHMxdVRJMmJyZWdnM1Nnamd6enY2?=
 =?utf-8?Q?V5KpwlHvjFYYksi?=
X-Microsoft-Antispam-Message-Info: 7aXZenZqATnPekVPxNpGeFTdGeJ05sL+L60i3f2OKH6ZrPB8mhROS3/c9sa76KAb+JPSSkBVel7/eZCXJMpCwzFLWlCv2TDk1yCJ+iPVsS+HXG9iagR7qxjWSftzlTmAHS7/39xSe7yZUyXVeCy1DA2ZP2kfIAkgYlkfamUu2+oTXaWQGmoibreE9M0ANIwm
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:ShoAuFZIGSYhgpL9tOXzxjqGClPigoBTi3yxvZREJKDMrNPdFrkWEuzPJAFuwnekfyMaeWjIB0MTzXvb/SUw8iDSLJkr0T//mHumkG2OHwVlq3NEFulZaGsjxy3SkwNPxpZtBEJ3JOETI2G7vtRrR/oJYNfIfrKZ9kLjGB3lHjf/BC2+rL5sJzW8jVcta3c0elmNkdQXL8+OZLLHX/zvRZHVgatwQelLfoXvgN7qMsnRicF8vYwkD1ZLdma4MTQChkrm/yOEtIXdajiZSN4n4XN9L3mB43vCJpMQl9/qedrA+or2QcSLNVth85aKDQ9SanJZ/fdo5NQS/Z5oaOqUm2yyXbeVyBLzjoeWu9P87OKXd0sy9J6wQ9kUUwE4QrFlbJox1n1IrFB5oOX6GqzNd+EPVvM6HxMxtwb+P0qtoSn3oJwNOZTf09d37yVRuz14UNHpiZsatckHCNgXO32tgA==;5:V+OyP74UiXKpUGz8yRfudZjgh2PWitPcDdespoE2NleekWCuVlrx4rwi/WFIxbcI4HPmgtJY0NuVw4ZhcMxEYm9JbQUmQ6RwEfTy0650gZSujXgDXQ8fE/IUrhVWtRTtUOCHozcNM4Uvmcu4ySLv9yvWtRVewS48B6ErIlWial0=;24:xlnibw0giXenANBHZeSQzUxZ9gWzRTu8QXSbmOFCmuY2K/fZsoggCz1LAcbrTWT0bj9QIHPy417x0w10fFlDVaVHQ773dYtv/pNiLR75gXo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:1oCmtbKMVsHNQRdk+u5YTiH0adD2qWl0aMtae1atY5BnmsiqqrOq7KLXrkTsp4PA9vPjVm8o9Od0Dzb+xvsA1Xvp5rwiPWYFBRaNZkAaZpcILLpC9dZcgPexhAaBEhs+ZL0c3M7m8L7QppGm+M3/m1fJJDSOK02Aoxhmg42MK2AZ1j3+fHvpjj8LAWEiY1Z+NHMzb+wcsmvkXiGp68TbosUJCeNsfFY4enfLZ+b9EfqQUpqq+amAHp57fk6jwmLK;20:WCKuHI7PmNGisJsopF3AvYlsL8GUc56TdMB647kI9HWWA/SngCQVY9/vO1NxC3c3quhEzFCQpTKrCkEUGpfeyshr63srOfi26fT7yEP9G2RId08W8KMuMLbmKsFDvYsZ/8YyBz26xFuNVRRUdtK3SEHH1uN39KBuB1w87OTNXCA=
X-MS-Office365-Filtering-Correlation-Id: 48d9509e-e574-4a68-a2fb-08d5bfcc2b26
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:09:54.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d9509e-e574-4a68-a2fb-08d5bfcc2b26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Davydov <vdavydov.dev@gmail.com>

The patch makes shrink_slab() be called for root_mem_cgroup
in the same way as it's called for the rest of cgroups.
This simplifies the logic and improves the readability.

Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
ktkhai: Description written.
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f26ca1e00efb..6dbc659db120 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -628,10 +628,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
  * unaware shrinkers will receive a node id of 0 instead.
  *
- * @memcg specifies the memory cgroup to target. If it is not NULL,
- * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
- * objects from the memory cgroup specified. Otherwise, only unaware
- * shrinkers are called.
+ * @memcg specifies the memory cgroup to target. Unaware shrinkers
+ * are called only if it is the root cgroup.
  *
  * @priority is sc->priority, we take the number of objects and >> by priority
  * in order to get the scan target.
@@ -645,7 +643,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && !mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -658,9 +656,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
@@ -690,6 +685,7 @@ void drop_slab_node(int nid)
 		struct mem_cgroup *memcg = NULL;
 
 		freed = 0;
+		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
@@ -2709,9 +2705,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
 			node_lru_pages += lru_pages;
 
-			if (memcg)
-				shrink_slab(sc->gfp_mask, pgdat->node_id,
-					    memcg, sc->priority);
+			shrink_slab(sc->gfp_mask, pgdat->node_id,
+				    memcg, sc->priority);
 
 			/* Record the group's reclaim efficiency */
 			vmpressure(sc->gfp_mask, memcg, false,
@@ -2735,10 +2730,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			}
 		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
 
-		if (global_reclaim(sc))
-			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
-				    sc->priority);
-
 		if (reclaim_state) {
 			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
