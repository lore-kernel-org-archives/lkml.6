Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeEVKJJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:09:09 -0400
Received: from mail-ve1eur01on0136.outbound.protection.outlook.com ([104.47.1.136]:61808
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeEVKI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:57 -0400
Subject: [PATCH v7 09/17] list_lru: Add memcg argument to
 list_lru_from_kmem()
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
Date: Tue, 22 May 2018 13:08:47 +0300
Message-ID: <152698372740.3393.9918100159995644893.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6P193CA0029.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::42) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:mkuY6IDPdrEOTqBmrwy/Mb/fXKhPZXi69EauDgGZSGoA/wYMJh1eQpl7jXUiJ8+iMzdnIMaG1mUHXDhg0djeoK2WRjXH9iCKjvDnF8xJ4XfNbxNac+dE1s2TMW+zqJHjnWxJcpwS1YTxMTurWD6JKanaMoiN96+eEqzvtOsEoU6aAt8kaDLyGIUgquWom/tI37m/MF3AFBVd/VPfI7lCBa/dKUBWSqrGLf6995sNCi7pfJTkz8O3kZEf6G5DbpkV;25:BImExLMuymE6xgkQ0Iz1GWyUCtrRl4BnbWeKgu2T0A2nTxUeSVgyP9EVXtqhxpjPu/E2evQvDIMUbxG9lmtZ+1s6YBS+NT3CmdphfDdrHLPyAbz8Zw1iCpXsJMW1H3pU9TnfS2X9AkBmvimFXdJrggWv+m6S1x0wU4M8R0U3+XZ3cB1yVY8m+nDT0Pe9V07FOQZzV+pD9EF0IVRnr4dC+50JBB3xGsRdVU4TMdaXKZZ06HAVhVi2xZThoRvNCRPOI7QjO+BvVhsqPpzJ1bVBU8IRvrUCD9XYLh+qzO38nOgARX9nEIwUjiNngf5Zt4/kPBTrXtkxZ5v9oSDNH867bg==;31:2NytQyyO0PkbFNrRStandaztBPkH6BwZMTArDUJMamnHaF6mzJDEIs2ad19M8Vwt/hfmbfKid+MmADY9rHzH+NguvF0l2IKeZFh7gpX42WYTa98Gl8+2AycuA2gQJyHH1FcDZiU3yM8/rDLf46yW0JofdeACsgpIx/+SQViwEfRlGVZDnwu5ENZ3N0SbtXjuFJQ5nLG8E+eWESyZAwbRaKQvrL3Q+XZQxih/DPDrerc=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:R1arVWfOGs5bY8UE2nmkG0iqmKPGzn5+APnnrrmNL3BTJohF9uJAlEHr0ZancGbwPpl7JWoVIwtjPK81rs9oh3XUfeAoscEnjGzmiP9XnRSLsgIbSnPZS8sdsnBXtvMYMJw1aayO9Ngk0YZdiEwn2tALVshPTd7QxY0Y97Nvz0uc/XycwoA2ctkSN1sg6jq/RuMzKBiaDYLy+zvXVR6n/HqtJaDvYamvlqO67PYeQuFRNPWqkVjAP7woQ/EyGOfd0d7B+OfgtHgW5PJid/zBDpYjmY7gLmSkCZa5uau7Ep7i3UyjjEwRngvOZ1GWakK4HajuTirmpIfBz2G+QWyzqtD7hADNFkjbTk7us1gxbVS6XuLaa8gCU14wEBwMYAXw803M52ZMvm5kCJerLOexZf4EbYllN9XInx9VbRjxT5+epE440+5mIsCdjzL3wHoJruf1y15wwmSTDakKvMOowUChO22EJsFSjFRkiYLqG8nrA5niWJ6CzSVdU3teA6Y6;4:/SSvfkQSMzzZn0vID6VqMNHk41Yxa86CY6WFgj/dtt4WDCj09KYp32K6empHbNRjiATQ5SsO7INEb1m5k01SR0LnMWrTFhFjGvM6EFpesGukCfvBaC+ySPxQ7DX1s9Xgg8+EkKkZ4N6TetBjKRjyMMZlqu5rkJzzQSeSmtTF5q4Wk4LUhr69Q+RKLg3jQFZ5iBej7VuVuDgI2IIfjMV7rO4DC230XAgq8tefTFCwr4IWbR18srwT04ui9Ik5WTx44dTtmG97GM0v1APkDuwN9w==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13390531B7F7A5D83FA5E352CD940@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(7736002)(25786009)(2486003)(6116002)(6506007)(386003)(16526019)(3846002)(8936002)(186003)(61506002)(7696005)(106356001)(47776003)(486006)(39060400002)(446003)(476003)(23676004)(11346002)(86362001)(956004)(52116002)(68736007)(97736004)(478600001)(316002)(8676002)(9686003)(55016002)(103116003)(50466002)(5660300001)(81156014)(59450400001)(2906002)(66066001)(76176011)(55236004)(6636002)(105586002)(26005)(53936002)(58126008)(33896004)(81166006)(230700001)(7416002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6MUhGZDRxN29XeTdCYWVJZW1ta09EWmth?=
 =?utf-8?B?ZnhCOHI0QW1DTEVGMkVBdzBiZk5RTHhaeWxXck56dnRFZzBKVSszM25keFkz?=
 =?utf-8?B?N3JWTGIvYWNFOXJWQnJ0Z0lNWjYwS3Nha0xLdjNzU3lOaVB3Z1pjYUxNRkxk?=
 =?utf-8?B?NmNmRUc1NVlLS2tlQ3JaMGdwR1hJWThTa3RlL2ZJT3c2OHh5Q3lUVzROOXdt?=
 =?utf-8?B?b3pWMVN3Yzd2N0ZWdlc0bWl6QmZlbnV3MEZBR2JVNWRCTDFWaWJXc3FaZHhB?=
 =?utf-8?B?Sng5UWd4ejhHU3JnbTVHS0ZvdndYVmdIMHRxSzVCMTA5ajVQVjlHcWhwNUU2?=
 =?utf-8?B?UXZVUG52bDlYTkpHamZXQ0grYjhUakkvY0ROT0FsMHpRRGkxa1ZLcmVKTUsx?=
 =?utf-8?B?MU95M2lqQzZlS3JjL1pvRnBxakI2OWhIZVUzYlNVbjVvYmJJanE5WklobjdJ?=
 =?utf-8?B?R0pmd2NhcDcwRkxYM0hzSkdjdndEbjh2U0RWd0FlaWJDQWR2MjFKQ1F4OUxo?=
 =?utf-8?B?akFONWlNT3oxTWFFaUx6RVZnV3AraENQMHhQaGJCaFRub1hJS3NFQTlVajVi?=
 =?utf-8?B?NXNJQ1BtQjhFa0g0NTIydmZPMkNnN0svS0NEaERHeGwySzdoNnRLQzNzNHZ2?=
 =?utf-8?B?RkxiUFVjajgyUUp0WG1VVkF2Y1NsalJQdWJEOU1BWWlST2gvMWM0MGJKbWZr?=
 =?utf-8?B?VHQzeGg1TmVSalZQVy91dXU0YkxUQVR5aFluWWVpY2Zad0s4MTBpbDI0a2ZQ?=
 =?utf-8?B?T0MreGNDUnpkTVU0Zmh6YmNZaGxTT2ppQjZ0TDg0VldweGdWVGtGbGh0RUJK?=
 =?utf-8?B?RVZzK3U2V1dUWE1aZTRNMDFvV05tUnA2ZmFzK2l3Y2pBdGlSMURqNEU1a1or?=
 =?utf-8?B?TDJGU3czM2tNb0RiMHRTK0h5bW5kQnJmbmhMNmVQS2lMcjJwYWJ2VVhWNzVl?=
 =?utf-8?B?R3dIU3h4Q2k0TjV6K2JDSy9Bc2VTWWpmT2liOFA1QllDOUJlY2JCWWQ2NFFa?=
 =?utf-8?B?Y01OdllDRzFjR1JLc1RaT0daSHh0Yy9jU1o3ZXdJbHJOaUU1VkpJVzdPTUhv?=
 =?utf-8?B?enhjcEFYbmxET0xWa2ZPVng0WmEwZkxyZDNpa2JHUEZpamNxc1RlcTBxSVdZ?=
 =?utf-8?B?MkpCZXE0QmlxQU95T1BSeWtxVnY2QVZVbzNGMkZUL0ZHTFJicXRqaWZoK1ZK?=
 =?utf-8?B?V0psM2kxbGZjVGxoak9lSnpIMUNlM1NTNFVzNC9XUjZ0Z244Ukhmb09VTko1?=
 =?utf-8?B?NDJMZitRdGQ5ZjduZENCK1ZjRGhsclVXQ2NIT0NGa2YrY29McFJ6dHBESUU1?=
 =?utf-8?B?Zk95WkxCRWNOQitDOTYwWHN1SVNJOWRodFMzc0RBQjVoTTJlK0hZclgyUkpV?=
 =?utf-8?B?MEZYMjRNMHVQTFMzazFKQllDbmFlTXQ5ZGcvQnorS2MyLzFoZFNiak5lL2Va?=
 =?utf-8?B?MW1rV3lRN0ErazAwZnR5ZUhocTBQa2gvSFlIem4rM1JaUU5YVml2ckg1SVht?=
 =?utf-8?B?NThjSitzRSs3QWpEcUoySmdxRThtOTNPb0NyTmxGaVVaeWhCVGRtOERtdVd1?=
 =?utf-8?B?bkZXNklFLzhpZ2dzVlJPN2JzMnlDbUh2ajZIMktBZ2t2WWVwdHRwcUlXRXl1?=
 =?utf-8?B?RWQ4dUFyT1R5QUxrOVd0aVdYRlVKSUpEMXEzTkg0ZjlIdG9rUmRnbmROOTdT?=
 =?utf-8?B?SVNKU1B0S0FnNzN5dVhBUkYraHR1Y1c1VFdNZnlMN2plWCtEaVNOeGYwNW5O?=
 =?utf-8?B?aW9ZVFdpOGIxTUFCcExVWHF2WFlTdXA0M3dhZ0Y0cXJHOEZDeHl4ejNTaWtw?=
 =?utf-8?Q?KGIVCPMiHejDkKW?=
X-Microsoft-Antispam-Message-Info: 7ZmrKKqPvsbLC/pWiiwMJJ7Je1jOQXUquIl48Ugi1T/HUMgauy+ZxBnaL8WZK+XLYvigbXhbluy0IBOxpvsIUcJuWMfl7LtG41URsTY/ZxWEGqov5IxRU1/ThG2h+wQeskXRy/PPfuWuNxSWq1kpgo4vEr34MZUh3L3lQ4BbCyW9m7JbSedjAhF0B2vm8FLI
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:o4iCq7a1gM533AIfdJHI5N4Gezgs6SE+yLo9KQE+1RhCkKyUkqb3fCZyEVXewl4fuJpFJm7q4ebGvQ8mD6vafcKsJS4motglJYazE7Xm5a2ni7BT68pmlvnt8ku6Sy93JfEfliO9pRbvUj5pGF+Y8ZNNqx3h9O9WE7Awo/jPTdfdcAPl1U14lmLD7MwqBoayZEQoT6+4U5kj3yKWJktu+79YKLq+Mx0wxiO+nbNACIQ24rSGBA7nio5ar9N+HLJapsDvmSmdjtxJIOvXB0UCckl/l0vl/fl9yzqaG8CVNo5gzHloT2YA436GrAvJOT6q+F53mfcsfLMMTrL1PGesN5SVQ4AJ0Z169lHDnzArYEi5xAOUx0LzICFDGz/mFZH/iXeOmjN1NbvQ2KU/rblKa43qeu0LHFwWI4OlYIprAG/L1UFEgJY7NiL+NjTn+67G0AZksysXSNFmdEAMZ/SeLQ==;5:QblrtOB7onQgp1JiX5BiEEhCrpg5WTV0cz+B2U2fLEQEt64IbVxzHVoB9DUl5wV3mZ1tQkXCaAR1iVtk+ICOswF1whpjk5eZOL5Ijq2jjh/HnhrgDiolqRrsEgbigE6R/lbxps1EaZXu5qy0hDWZOnP/IzMDgSm/Fq8v2TyNEE0=;24:5vgZyJybzZ2wBvjXbtLBgEuYoR7zCiOLiCAh6iZ9FcawaLTzktGohiCOU2oCA5bMTho2U6FM/PLMut7cFumNtpn7/RTwoMq6w6bnG7Qhv3s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:IW1JAg52wcIyeaV2g48v2Ev7YQKXlzdIEn8HtBKx5xIwtZqEHK/lFVxqj6AqCTWVNKZrc7m0cPkeeewLKeqwqYplNKxfURPe5h8q30moiLYAW2dVFGhnB7jEv/w43iXFq6otm/h9/gjQY9JqBLnNXJIK1GdaWkjg5CG9LFYmpZa0pnEsjc3ieyoLpMs2bJNbzz+mL46BnD/wuCfM+RfBtoKEh3008wiemvFqIH9CxNwcncOa3xVrI63ef12zxX5T;20:JHdzmpoyZyKmjjgikeqhgtImsuACz3DVnpEZi2EBxq9AIRqyJ8sqsZXl68KQ6j6r6Y3vPuuVmxD2BRQzodwb+EXE9AZC8q45ot0IJaCoU0KvQu0cFztY/C4Ap6YO9snSOXY6/2Rfp7/4dxAVoEsoxhmiN82oV3VkzEoTISSrw1Q=
X-MS-Office365-Filtering-Correlation-Id: 52929bf0-17c0-47fc-e223-08d5bfcc0549
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:08:49.9504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52929bf0-17c0-47fc-e223-08d5bfcc0549
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index dde9ecae7cb5..151fa77eb7c9 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -66,18 +66,24 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
-	struct mem_cgroup *memcg;
+	struct list_lru_one *l = &nlru->lru;
+	struct mem_cgroup *memcg = NULL;
 
 	if (!nlru->memcg_lrus)
-		return &nlru->lru;
+		goto out;
 
 	memcg = mem_cgroup_from_kmem(ptr);
 	if (!memcg)
-		return &nlru->lru;
+		goto out;
 
-	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+out:
+	if (memcg_ptr)
+		*memcg_ptr = memcg;
+	return l;
 }
 #else
 static void list_lru_register(struct list_lru *lru)
@@ -100,8 +106,11 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
+	if (memcg_ptr)
+		*memcg_ptr = NULL;
 	return &nlru->lru;
 }
 #endif /* CONFIG_MEMCG_KMEM */
@@ -114,7 +123,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -140,7 +149,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
