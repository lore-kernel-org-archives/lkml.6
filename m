Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeEVKJz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:09:55 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:30663
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752626AbeEVKJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:09:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 13/17] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
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
Date: Tue, 22 May 2018 13:09:33 +0300
Message-ID: <152698377333.3393.10224542065681526664.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:209:15::26) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:ck6/7D5HTF3mjhAxmmJPIEumuq8+WsiR/yjwUv83A8ksELTpUILgzCjMLXzKQAP/kriwlEzQ7tG65PvcZeChRNKVEiBeFl8mJqj9gMOFsd4NQtFMm10J5dI4Yg7RxgIhZ84uXHTFOWExXYeB8rq2fI/HfHPlTCIkTpIiHU0FcJSplYdklDPOQnB83tEf2duzR/3/KfDUz1tyGAsV/wwrBpZUV052sCuowLFN5Xv92G3310t6tGl1ueh+lW6FPzsu;25:K/jpDdIRBj46om7c4arBeSglXt7By84cdowCTjWWcxAD8z+TlHlB+Zl0D80eVJEcEdggZC9haK2wyRDYTkFMGD4phEp5y5Blnab8PgSYO11yIwRgvJPyqoSplx2Ucuudy6SrJoJxyffb5jFHUR2ns91ogZQfgYytV5i/qM71mUFz4fpmfZyGEJFHJQ+IJYyk9Mxl2pAVTrY9GPLP4vnE1uO+qoIH3PO/PUvh3DLWcpo9/IG3FhWF/k6D6UWIzvImL7uNN/3JXPG8G248x8bBWLCPcLbG6Tahzvuv4F07EHvdnThpZNH0hiVTAN+lbQ8wnecu/4QrpXxnGLKRqDgldA==;31:J1PfoM6FM0X70VgqMP5g7twMbUVDeBOT3wMd/vXgvDOyVhVJmqDP9w78ni8NBmRWYoZ141SGnupSAuUYjhgU/+tRb8SMvl4kggbxkXg+i8YMq1l/754xhtOFqomqCeDkOy1MexGr4goVpVVxAS7bTBWZkpOE3q+0oPWKbKM9+UgC0/9dsDyLh5SpoSzozEj6+DyCa9IwOvhxPVZRFIg6U6csNKr+XamVvdztvMiZmGE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:1J4UbH679QJIasn7AAcYaACZahgl7NoJYDrRdByt9YXgKmHMYocWZwUnX0vRGSadLCFWwfmFV6TTqC6REGyBAGztiCs8TiwwPF9TVetxFxyQrLeWf4Ncn6A3ZfiPuGb0D5J4znqEOEM5tMrsoMa/w1QHe3f9Ll08LpnCG+25JvrNMnmJ2Z9iiHW+piInJORvkAjUHJ7V9Xc3Xfjk8Agvo0bybUWUZR+LkOwBVmImFSck5jCtPsK0Fs3Z+ogsw0CPr5I36SbvyIgWQjfBKPPEcQcJDrK1IkWQpjwFI69CWi4UJAZg+mgj/ltCZ85aEX8jJdtizqiFDHZoq84azGoUGbfq5iFwo9v7z1LFA8KY1srySJbSmQntSCB1FQO7kAKAFDeHR6ubmQAynN0qBIAun/3ovsk9xg2t2+WRD3GpDiVuLS1MfcaeRZ0dcU872nlpaznP4nZ37o9WyO57y/1nnYK7ugmaQXr66o0xlFfpZnd9+swODK6eGEGQmzDGhbqP;4:rR6HjzOekwXL9qC8EYik2l2RE9cN37FcT1oPXPeDH5pFNyUI74GFO5fxb7wn5Y81eTVmzKp14O91OqnnJwwYqCEYihw482LcrhYeQ8HN6OQE1iL0U2o5NGjOQYjCWCfwJi2BMSMEj6M5dikvj/2RvBYGJCZuj/WH0jhEvhY5XYiTfqViZkYs7syDLm2R1IOyJwF/WRrIvP48iN3vhD0Ql3PYdUpsFAdUh5XGyKYubsHg23aXeCsdARZa5/8WDmHJ+sZB1J6onCQpFW8FeQF0lw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13336C5EE18C34E9F151FAA4CD940@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39380400002)(366004)(396003)(346002)(39850400004)(189003)(199004)(446003)(956004)(476003)(486006)(11346002)(186003)(16526019)(76176011)(6506007)(386003)(55236004)(2906002)(47776003)(33896004)(7696005)(52116002)(59450400001)(66066001)(7736002)(305945005)(2486003)(23676004)(68736007)(61506002)(25786009)(6636002)(230700001)(58126008)(6116002)(3846002)(39060400002)(86362001)(575784001)(97736004)(8936002)(53936002)(8676002)(103116003)(81166006)(5660300001)(50466002)(316002)(81156014)(9686003)(26005)(7416002)(55016002)(105586002)(106356001)(478600001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6U3FyRVhNd2Z5d2ZPYXcwRXlNMGdLS2pK?=
 =?utf-8?B?ZVNTQThPOXR5NkpqT2c5TmQ1cmNHOFlwRmNQREJyWWM0T0V6ZnB2cldacW9I?=
 =?utf-8?B?c2R3UkpWUkd3WXBlUnN3dTA0ZzVoNFZWRkNiUk92V3ZKM2wxalRuRDNDTnps?=
 =?utf-8?B?ZzZSck1XV1ZBNitQNXJlK0tzVUUwS0EzaTNhMDk2Tk4vaVdDblgxYjV5NjhJ?=
 =?utf-8?B?VjYrN1IyREp0RFJiNVVTMW5ibmExL1BuYmlCNmtRTEVDS0tSNG8xbEwvWXVD?=
 =?utf-8?B?QUdjNW91SWJMYmRRa0RxN3ViRkFXM3FJZFFkRFQzUUc4SmVhcmxlRXliUnRr?=
 =?utf-8?B?aWRZbWFuRW5TWGd0bkx0YXZPREd0R055aEk2RDFEWkF3ZGdOem8za0V5RHhi?=
 =?utf-8?B?TE5lS1J0aTBFdEk0OFFBR0QwLzFXSUxqL0NhWko3SVdZeWNFc1VUVWJJc1c5?=
 =?utf-8?B?NGdTZ0s5RFVyRFdQNHJSYTZMdlpUcUg1SEl4b0thOFVTTVpsbm1PQWpJN2RT?=
 =?utf-8?B?T0FndFdLQjh4cmRJOVBoa2RlbHZtSjd4SEJ2cnY3RE9CNlRNRy9IcGV5Sk5Q?=
 =?utf-8?B?UUVIdW1sT2xoSStLS09JZnZ0UkpHSFl6WkFGOTJRdTNjaERjWHcwQjZ2aXBl?=
 =?utf-8?B?eGJDMVYwKzdnQTkrM2k5ZlRzMlM2ZTJrejdoYUplKy8zSENVdnhCTDllcW9l?=
 =?utf-8?B?MmxMRUdqS1kwNWpFKytjL01uVSszNE5pU1crTHBlWUU0VUhBdlZ2N3JpSWxD?=
 =?utf-8?B?cWxiV3RFMzNISzRCdThaMXBWZ2hoQ3Fhb0g1dXNyRzl0WHd5SXREUnFWbytN?=
 =?utf-8?B?TjBETE5jVTJINGVKWTVCbW1oc3FSRXNlejRtaWkvVVVFSFc1cXl6cmdDSklF?=
 =?utf-8?B?MUllM2tMZ3h5cUdzTGNoYWdXaldxeDBBVWV3elVIQUd3d2JyZSsrNk1vYmpI?=
 =?utf-8?B?RTdpT0pxZkt4MHlMdEREQkZxMEt4RVJhaVdISzZ4c0gzNDJFR2pCc09sZ3Vp?=
 =?utf-8?B?cURUa0s5Nm9LZW81NkJCbitKV2lBc1gxMWk0TkN6ekJmTkYyZnRDNi9vRC9V?=
 =?utf-8?B?N3J5UGpLcjZEK2pVaS9nOXRHS3J6cmJqNm54UEcrQXk2b2NQNDVweFR6YzNu?=
 =?utf-8?B?TS9Vb3lqTVZnMWxKZU5kTENsODhWeUdoNDdkb25wSzRFTFFlbVlCZW9FUzlX?=
 =?utf-8?B?SVF2MkE5Mi9DMk1IcmhvSlhDMWtGbjB1akc0eVRPQWNMcFBkME0zTEplS1R0?=
 =?utf-8?B?WmZWcGI1MUJ1cDZWckhralIzU3RxN2hRcTF3dlB0THlCV3dKY0ZtVjRWaDdU?=
 =?utf-8?B?bUE0aEpST3VWb3c5UWhETXRRTmJWSzNvN1BNdjIySmNNNDRkYStUSGxXbU9a?=
 =?utf-8?B?am9OYm9XSTdzWHBUeTh5eElzaUljWmR0c0FuWmhMRi9WNUx5ZU83UFVsUzBM?=
 =?utf-8?B?ckorR09zbW16V3pDSTh2RzFsZkZnUHd6cWt0aVBZRndhZkkwblJlLzhvL3o1?=
 =?utf-8?B?T2tBaXM3YnpxVi84UnMzY1BvR2lsODhHTlpTNXpCbCt2cFFwM0xYbG9TaDVO?=
 =?utf-8?B?a0Q1K0ZGQzBJUmFiWmp5YzV2MHZTQkZGM21pZllSUmR4V0F6VTkyTkR1amoy?=
 =?utf-8?B?eDladGxZZnNvc212RDRCT2JWYzl5TTAwU1IwOXVhNXZpaEpaQ1JLcHE0dDU0?=
 =?utf-8?B?OHNYMS84bUNoSUNWS21aM28zcktBMTdtdUxSVWdxYlBrcGVIbjJVZ2Y3K2I3?=
 =?utf-8?B?emppSG5qSEtVcjU2dUtWS2hNZEtUM0N3d0pLUDR5Nm5KdVpuN000OGgyWDJC?=
 =?utf-8?B?aEh2Nk11cExqMit1UUJ4L2xldFRjNFRRR01rbGRHdlMzSDVlUT09?=
X-Microsoft-Antispam-Message-Info: ldTJgeYDYv2ChUIoKgD5TFiq7hVkAEu4c16uFCXamdDkNxl3hzwhLipQ5DCpJdZQdC3C21BNz0ASK3l4ubXUi9E3hY3pni/+lhjIxr/NAb24GbAPkEkDQaAKepVjzz+hB+zfoYreE1rjzRv2lVEWXNBzeSl5N4IZyNdPZFDezMfU+g5ffnA0RXxgAc69UEi3
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:jdGxpCfOD2E2T+/GxPcxlPOBc8UqjsglIq8ZGET0zX9Ei7ZOGFfTbmTX04Uy9OywwTi5hEvazfW+4UjzZGGIlk5k5l2ESHGddpZVyPHRJ+6AIXTF8tgWALP5g6rYTtlnooUqPyPlIUagLQkYJr9Mkp3x1/digu8b/y3VmEkwhcgV6y2h5L9Bfz7k2aPN6I7CLuaWbmZqmCRS7tlxfNxYsaGmyOiJSrFuz2BVfTO2QiiTNkSr+eOgFhVMRjImH/mjXvPq+LVlJIs+MHR7Vql9HrhSCVBzCbTDarG46zKfiDNn4iRl7ysfaJ2KjIbHQ49Zf6hUJlhm3iymSo3aRhwnkkxv2NDdnIqd7bOgjEY9t/ZoncBmDcu5dirRrvpvUjGdI/QzYlcL5H9jR6dDK47bEzqxgvRmjCVuhv5pKO3jNJF7IDrzM5dLpaYPHDxM9Br7oiF+Hv9Sm5Nyn1m8orfGpA==;5:GIfbe3TljZniio1eBAjXYmXJREF0Y5RhvUOBCsRUtFT1/AbZ0CFB8AVMIQ6yvpwxsqQXXROXiEO9d4PI+V45VqDDQwrhAIrfr0E7ecufXkH4/4s/j17LqDtgEWjElxtrcAQ07/0e2tUVP4TXTCfXamzUmZGY9KQGCzyhThzQHjw=;24:vJ6+3QiuJ+7EO+s0jylzam3SEddTiCHf7cBjlUhq0VAj+lCyy6N9DfwWJH3Ft4WIv0qOtMemAoT8L/m7bvClgK3aTWP/baWNpNkIB+fBgkE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:illZNxmP6QQvtqSUILsFICmq4lm3lMz6mqRj/FsgM8tnMjj7NAzOKxLNNfKatOKKDq953v36H4gPpk7lA3AddRw1NvhQtNGIwU8SzRKRkCl2aec1aHRqW+QsmxIoLzaAlY8JGKGnn4mr3JaycxtezIpW8XJgCmuWUeFZIRoAS3+H6c9XCZ4xDBF/NlxVkmQsrOE2UuD24s8ecoz2RnLoHBCuaiiyPNQZIwPyYzJ/DjzlpQJIdBuEJJ7EmmObRaXX;20:D2P73JXqPYZClmNlztoMTA6P6+odpy7NAD20SCEip4vUSH4nc4k6pMhmQIzu3s70CeVIgrpoaOajsdoVOI3llUe2i5+0K21cgy8UWFdJhmsDxVVJoJMM+u6LFgc4UPvHOh/4FMUVp0xPxmSEYWPpn8wagDk5fgka9vYPb3R4snY=
X-MS-Office365-Filtering-Correlation-Id: 92f13e3e-1b31-4e6f-864e-08d5bfcc201b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:09:35.6325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f13e3e-1b31-4e6f-864e-08d5bfcc201b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce set_shrinker_bit() function to set shrinker-related
bit in memcg shrinker bitmap, and set the bit after the first
item is added and in case of reparenting destroyed memcg's items.

This will allow next patch to make shrinkers be called only,
in case of they have charged objects at the moment, and
to improve shrink_slab() performance.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   14 ++++++++++++++
 mm/list_lru.c              |   22 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 24abed028c6e..b3ae1373c99a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1285,6 +1285,18 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 extern int memcg_expand_shrinker_maps(int new_id);
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id)
+{
+	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		set_bit(shrinker_id, map->map);
+		rcu_read_unlock();
+	}
+}
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
@@ -1307,6 +1319,8 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index cab8fad7f7e2..7df71ab0de1c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -31,6 +31,11 @@ static void list_lru_unregister(struct list_lru *lru)
 	mutex_unlock(&list_lrus_mutex);
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return lru->shrinker_id;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -94,6 +99,11 @@ static void list_lru_unregister(struct list_lru *lru)
 {
 }
 
+static int lru_shrinker_id(struct list_lru *lru)
+{
+	return -1;
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;
@@ -119,13 +129,17 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
+	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(nlru, item, &memcg);
 		list_add_tail(item, &l->list);
-		l->nr_items++;
+		/* Set shrinker bit if the first element was added */
+		if (!l->nr_items++)
+			memcg_set_shrinker_bit(memcg, nid,
+					       lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -520,6 +534,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -531,7 +546,10 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
+	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
+	if (set)
+		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 
 	spin_unlock_irq(&nlru->lock);
