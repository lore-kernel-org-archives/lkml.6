Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeEVKJV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:09:21 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:26896
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752044AbeEVKJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:09:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 10/17] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
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
Date: Tue, 22 May 2018 13:08:59 +0300
Message-ID: <152698373951.3393.7015045580434123801.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:20b::31)
 To AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:BGMvzZF6KFCMWbUZpcXIEb63cYEnHSb9f/egWJhOPI89KpvkZI++CUGpos0HFQp6avqXVkCUGXKYpyHUv+Y10t69z6dfQlV9vWrB+z0Z7s1eIFoHcssK+aerGYR2G1f4GDGDAzZhY6DfJzmFbUVeOiSt4Yy4LnqCeCwH3+iWUY0zP/aK56qZ4cH0HSoZRglCPM0xvHhB2Nh1BN4r3vS4H6nqYpNrgIOer0HaVZTb2pV+29hDKWhX6PqEcFWMEXba;25:muJNYYfbAV9PGAuqmCqol9OwRL94GC5E3jf/Vx4PW4+9ynQaZZ+PlPmqHslUFabAx41BwLBEI79gRmRgKOK662dG2+dSeJhDCTE18vOLCcFBxLuUSj3N6zZORO4ac+/OUmELn4eDMNQlCJpfRgj+BGRqTNNeghs1Lnakr+BhtmtVHeK+W9JP6vzeBnaMEmJmeGsMUmKnpnXuEtLkmjpjFxyPpGZ3BVUQ821T6TNIgNI9bslSkEYYPOScKzvmB7Js85Z1s/ptPObnqzkMg6OdPV45sJHWflzE7BlJKCzVvVvIxqLLp+MPCHw76uZufOG//V04+/zBSAo0eWNrH4AnDA==;31:IF2umOwtx0x68vFOxGAYNGsiy30XJT7cX3jllvYc/ldzQ+3qmtUVm7vCNj3NN/7sNO+1fr/GoLzTlgDS0QeoQFNcyx/5ThH2tg7aBd541/5ZCZ7lYQzD3iQU2f9Laf8HwA0fJzajdidXb0/VHhC/SB1sAXSiSSNFDKcUeTT4LEUZ1EycFF6h/jNGFA5j7aECvSZuDhMpqT6LxrYYgspsuEtsl4yIef0bjzELUlYOBlc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:rL6hrbrmu1AoM2OjY5umVa2SnXgvw1f3H285qaF5mzxs78PoMPP/DZOxibdXObZwRSr8WBP7zjDztfwczWPlYi19X9WCmbVPDfoa92LSjbYxTsl6AHyUVzKA3ePcokY5ZdLddjH+6QbtObj16WrGV0irEc+EQgXX3dm/S/muZIEIIsIgUNSRXbxKeJx+7kc5Vn/QQ8Cr2lfyePGlzSOdd3d5+5U1TyVuIWJ+mbq7SLamZgX8H9K+JGOLcXYRSrLVhm6Fe3yErHjd+4lcTT5sV+9qi1wpQStlE3GIUygyzUMDx+aOX/09/coykuScGNp/ghE/wF+7QW5RhoS9YFU9x9/QJsVPDu16IpLRJj/C5fI3679A2ZNysz7WLwnhRgujzXJjTfKqMdrBVVmUNWi8NSE6Ye1U6+vLA4x4ZPeC0sO9R04TpQRanghvTSMIebmV9KikNbmeTdmk/qzheQ+UIZSz7R5l7WIFe7f7HFSws+hxy+geEFbcM1PUTZWiZ8Nc;4:JWYwUg4eYCEVBx22LQHdKS/lBFuAGQRzKsERrQrHHH318OTvg2r+p4LmgMiM6BXFLPSUVzBv67eiyG1SPA8lU2OUs97zb+Yn5tLE0Dez7IOInr9ECG2eyJ+dx+tTLqd9nXA5yOfRXMSWb0Y4ZPth0Aetbdttmt7XCvvL6WlmxFQc6cuajguxbxO0q4dMDNeFqrf17mz9Hp8IyhU0Io98/Itd5+svcN+s/jTpJSJaCbKRSvCgcVFRF8NhIivMRdHczwJNxy2JmzfLVsgSHer2HQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331516ACC91FC6687039D6FCD940@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(346002)(39380400002)(396003)(39850400004)(199004)(189003)(97736004)(186003)(106356001)(9686003)(2486003)(52116002)(7696005)(68736007)(23676004)(2906002)(33896004)(5660300001)(486006)(50466002)(386003)(6506007)(76176011)(59450400001)(61506002)(16526019)(47776003)(7416002)(55236004)(26005)(66066001)(86362001)(55016002)(6116002)(8676002)(81166006)(81156014)(39060400002)(476003)(11346002)(53936002)(316002)(25786009)(3846002)(6636002)(103116003)(6666003)(956004)(8936002)(7736002)(446003)(105586002)(305945005)(478600001)(230700001)(58126008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6ZWNGQ0k4QU8zVGZUVk56aUJkRjlZeVhh?=
 =?utf-8?B?aU1qa0sxV3dMMGxWY1BnYndxQXQxV051and0ZHNxZXJhTytTVDhsSll1ZTdl?=
 =?utf-8?B?Nis3eVRnQTdBQTB1aC9ZQUVkRWZhTkh5WFFCVzBaa0tBa04xcEhpZjJiUU9a?=
 =?utf-8?B?MloyMU5maUJzSjU5RUtFZTV0aWhRUmx1ejFGSGc2Wis2NjR2eUMyb21jV202?=
 =?utf-8?B?WUU3YVAvdDVPR0NMa1k0RXN0cGE5UGlwdFNyeXRIa2s3MzRvUlcwYTRxTWpy?=
 =?utf-8?B?dWtDMXQ1N29KY05UYjhHSUVLVnZ6c214d25wb3k2TTZxeFV1bUlLRTRZcVhJ?=
 =?utf-8?B?WHJYQ0kvRC9kTXA4cWczcnhrS3FhenFEYS9Tcy9hdmpybHAydHRncWZKRUhB?=
 =?utf-8?B?empXYU96elNqWThIM29iaEhmblNuWHlnUHNoYmxjcHExV2NrU0NxQkNaQUdi?=
 =?utf-8?B?WlpjMDI3T2N4cEJxNVdiNHEyM1hBNy9zSnc5Tk5FOGNWdU11QUtmRFhQTXE0?=
 =?utf-8?B?UHlIS2c4Y0ZabEg1dG12TU9Qb2NkM2tXYXMzZWtsUTNUQnZ2WTRoM2s1V2tC?=
 =?utf-8?B?a056U0FLQysyMHB4NElLakxiOU1oYlJPeDFKVWVTbnZ2UE5yQzh4ZDk4ZmdU?=
 =?utf-8?B?WHdXbWxPUXJyMCtMRUovTUlyZXZXNDZ6ZTZSdVlCWkJOd21URnVLbzE3dEtP?=
 =?utf-8?B?SlRXR2NxYnV1M09CMjJjM1k2V0VubnlKZW1Lc2dHdVEzU3Vycmdxd0U4TDJ4?=
 =?utf-8?B?eGx4SmFHQTUvQmpFN1VDSjJaN0ppT2J0TkRmK2cxeEx1NnhXazVNZk1kZzFC?=
 =?utf-8?B?QVovcTdDWGpYNHl5Sys2dmxnV1lQWkxWck1aVzZpQ0Uyb3czQ3JWSCtFd3Mw?=
 =?utf-8?B?QzBUQWNQbG5Bd0pHODRkZ2pBMHc5TUY0cG1oU3k0cHFST3o0THAraEFuZ29o?=
 =?utf-8?B?bDltSEtMZkZoeEZoNUI2RDJ1VUpBZnZIeU5EUVU4OC9jVDNoSStFcDhDaUpY?=
 =?utf-8?B?cGxWalEwWC9mWWtDaVkrMjdqTFAwTFN5dTdwZW13K1dNNHU2QUppVGpPQ09j?=
 =?utf-8?B?M29qQWg4cEJRVGcycHFuVlhwZTNBRUdyYXQya3o2V2crUUViUWNLMEswa0NT?=
 =?utf-8?B?MGc4bWVxRi8zS25oK3dwRHBGWC91Qy85MjA5R3FUT3ZtQ3RKTHd1ZDBocHh0?=
 =?utf-8?B?ZkE5Tm1OK1JienE4YUk2ZEMwMHZHNmh5ekJ0a0V0dEZLaVdRVENPYVBOeFJQ?=
 =?utf-8?B?NjVLTG9BOHdEaE52Ly9zcWtEL3VUc2VyV3Q4MzZ0K0tiRXhDaHZvMDlXaUVE?=
 =?utf-8?B?Q2ZzZG0yMHJqcmxKM29lOGdISll2eGxWM0JmdEZONHdSRXYzMkZjdURpaFlu?=
 =?utf-8?B?b25OVnd4VElmMkljc2c2enZmdlNNRnhxcGVUUVlabVViaGFBRGRpenJsMm13?=
 =?utf-8?B?YkU3T2NLSTVmc09ZUWlWVkg3WUdVeHBpVjQvbS9FcHZkeHFhL3ZOWHo1T1pF?=
 =?utf-8?B?L2xsR2RoSUI5NFp5blhvaVVodWxIVTVNZWpKTFAvY3dKQXNIUWJFc1pIYkRJ?=
 =?utf-8?B?emFlUGpZQU1zSEhidVovWXFiMFYzWlZWQ09lZzNZQlBwZ29XQXhORDBGY2g2?=
 =?utf-8?B?N1NsRWVoTGtOT2V3aEdOZ1hYazBDVU1EWVlkNFRVRTFnK0RFVDBiUmlta1Bi?=
 =?utf-8?B?V1htRWpxeGQwMXEvMlNnTDRZK2NMMytaeEFGa1F3S2Y3ZW1UTFBxdVNUZTN3?=
 =?utf-8?B?a0trVlFEeUVBVWhaMDUwcGc5c09LdGs0ckhjZnNiS0RwTjBEQmNIZkIyTzJX?=
 =?utf-8?B?U0xUUXdsR1RuV3V4Ky92d0g5YUp6U0hPUFV4ZUlUSXdyQU9wZz09?=
X-Microsoft-Antispam-Message-Info: uXgDoQHua9xvtXQGXlkhzZgpF2PKE+ZilDouPD4e7NNSdDgSdLZhJtsepiU1u0nLkwg0gLZFzq4HNIIrmmBgOVRbJOMK30CpcjjTyFceVTTJ8ea6nO9ewM2bo9XFQgaJO4e0Xq2vuYrgTD1obgkMJ2ZDYSc8mOhZE0Oy6MnPfV/fydcr2SH7EdO7IoYft9QZ
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:yni/dLA/HsJBF/0p+FLnzU3TI8J2Z5tTzv1yKjUZPe9iubGXIFQaeXTgOHmIvqlzVotn00Qd3h8NDJCyz9XrsKHOuWYF60MRk+l/uZp6r6XL9GmGhqTgmmEUAdCV6rmhG4Ot7tB6JITKyRRSjHnb2q7oDk3ew11etDP68yq43OieaZ66Y/Hxm+ZD9BTN2T+94wsegZX6ws6zX+bERBBBgtIqx+HkecSIN2BiUw6hkM4n76OM3WEoAfIhteksoCwF2Wd4cJExq7XbEZkaIqIghT2e4vc1xvQtlCouIX+IMxWWfxBzEEzQnxswOIiUG53+WMFJk3a1eYQ32CwrQvvEnPE9ctF1GOaZLmF2uBL6FgRo3bJoFP7uPejLibRcDfCYTIpQeWSwBNVrEgofIR8IiSwpBZ+iWVjBUswMA1otxbDNmNjhNr6mM4lJ6IGwukakCKQNVtQXd8eN58ZliR8ShA==;5:tfXZxXbSxt40TNoy6+oExdqsjF+UAF5I42WkoO0mCEAi1kVeZolXd08KWAx6kB4lb5d5dnRzS+Ct5x9vXkGmV+3B3QRPXyfXtxIwHN2BxDCWyGzoyVJx7PAbVKIgaAQ4DLVyK6rVwAf16BUJ2BU01/czTT1BO/a+8San3vxCx68=;24:YfmxkdO4KcHOkQaD1L94pNCaPqmMWNR6VTeMVbYfzsTdDQDUwxfN4Z40R9mjURhbaMebPGm3zwgcdbDZOzQkgea223GtMH7Ir0+VsBMHTHw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:uQNPd9fh308sdg4mz76/iHGLlNvghucB4Ixe052FWxxe4CXxDEVrBW3b/bCQDUOJCQ/biyPIlFQHi9acTGbMffgpHa1nhWi/UdpkQF1b7aic9EQmxWjVKazA7tqY3sSnxS1djOWuh5EU+FEAM9UlJE283vdloMkDHqAja91xsQW96+XDTeqpj3F8P1IXl7CkQQh32hlRYjNWwzyI1UOgeyhTU48Ob9IB9PrSNvgOLEoqip+gC1yb3PTHDW+Crb52;20:uka47ajntIwBxl6p3QwaY4hijTS9Bx1Q/7LXCrsQGe+D0NMaY95jlt0bs/BngQtKyV8DKv7W8wv/kvf8suWGVQAqr6jgrdcM+N6H2GyN9o9Mdint0kxoggM1thYVMj3b19fCe3QqsNtrCN+gsmFVbqznJ5LUG3oYrdz2NA8ZVFk=
X-MS-Office365-Filtering-Correlation-Id: 47c3b0f7-af3c-42e9-33b5-08d5bfcc0f00
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:09:07.6468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c3b0f7-af3c-42e9-33b5-08d5bfcc0f00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9e75bb33766b..d9c16f2f2f00 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -69,7 +69,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 151fa77eb7c9..43cbec52a48a 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -515,8 +515,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -536,7 +537,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -544,16 +545,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_idx);
+		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx)
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_idx);
+		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b454f077de44..a86dfeaa9aa1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3187,7 +3187,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
