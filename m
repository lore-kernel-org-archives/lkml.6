Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeEVKKT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:10:19 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:9578
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751443AbeEVKJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:09:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 14/17] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
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
Date: Tue, 22 May 2018 13:09:43 +0300
Message-ID: <152698378300.3393.14754283083814172297.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6P193CA0013.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::26) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:FIao7FOzdzGiKAoF+arv6ubYmD3i0UtpLQg0D/O/+dpcxLuQzwgFhGVh+rPhMAre5IY6pLYT6LJlLXpnZcEPtu3X9Z0TF4bHbNWYoC8BLvClH5PrRYO0UK7/rAdI8qLjRdSqFGzcYHI59JD1DI67Em/AibVFaovQl0HRJyDG/crVpuGa0zpG7l3PDVaB//PQL3AVZrwd3jtfXqxdfo2E0J42xlxtyTjbWixDJfPEc1s5oX/kcpVu2gDuNsJAg/Au;25:d/c/6IV57TA2fek9U/cflM+x4KLdshWLXc2SlvoH/GiUBAo1v2wb1URc0zADL7lfFnvEj3gqi7kXMpq7QCxi8dHFI55vfRyJ5z9Vyync/IQ2GtapfDDKrn1DiDw2U3Ul/K8aH72tS90rBpR10+RVoktPNjyqLxBTXnFlnuxsvnK8HCXcah2EyNrnfO0ApJr/Fj/o0cpfO5b3i6VI6o3Mp6/nOJGwKfgZ3vlTFYwnI3t4vJQ5ju2qepRkIbm3rjGg8yHRltaUCUVu9FsfHD4c9gwBFbur1KgYQne97tSpNn/j3RvxGNQNv6IHQxFadl53YYcXkpj4/TOulDnrnyFPBA==;31:k3T+g2AXVZrn9JzQwcDnzyCgj2Mcwm5jW8NgYiJAvDUke0Ap24s+mLNn4AH8BxJcCY3Nz0de881JCwm+mMGaTpHUToXtGSvEF2Z82A1ubWVMVVdiVE97yBYN6xUPNUudSJ0RiQsO+3/tdcAxl9aSFN2rpnYf7eqW40tl5cScmgWjTpanRJZDYcSXibyf8C5kmMBHmTYVeD3w6331qaPNozZNlveDVLSbPeC9f6kNwZI=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:AzvgOlTV2j+/5+8g2Mwng00XQzdcM7yVcDbIPH6RMINLuHnlAOA37kOlWDL9DPNUyJK9aEURngLStFWppb5eyanbddDppLfwxdozB+SemdCyUajtY8+4gpPQLGvLT6tQPkRMkp6v6+ebcfvZh6pnEgpRj7nPL1p8jNbuWrG4h3MTrLJAl2NbYr3GAlNKXqOSAHcWqp2+ITY0hMdQoL0dqIhq5VXX2ZUHj7OsHCmOyxJm1museCgeVgExyjJmSdcS2wi4eCldSIvCOtMSJZ0CKkBelfQuh1+/jdLIWi9krjmy69OlrKAZEn+zVuIBb4f50MyfDWoDCyyGTVWk3mF4L01gWwvOqzmmKKr3vQM4wJYLfygTmELyWYkU5trGVxYWq77MYVZRvhi72+0aPcqvTxTJEvFuQ810fuO96WpqbNGKad2kjAHSVJZiF8P2Fw7dhjOAk5oHDDPHhRVmtfzSrMuqNKpxkgSYi3lYE6LC9CDK8oz0/RD1AmSj8Ws7BbeH;4:01P3fehXqvm0pXWVOiP24v7VnMnz74Ewsk5zFB2nQA73soghFEH5Mbq6hRU3sIrtghPzbpusiiZRvVkwtwmons9/gUHNOYIQgSRSASvSY8sFMUMvF3SGpfr+WoxgiYfaGVDqhKWC6hHHHLOLBhgvhqf6eljoVm4jXgxnyONE2R9LaffwvhoaIepnpLO9JWbDEK2bnnSHU2L8pLfyQnYhT7zfTlhIabRDT6bGVzni7r6DCx6jPenin6K/wAOJt/7ulvY4m3yLvN3xtMhvn6SOlg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342F8EBCB67A5F7001AE77ECD940@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(396003)(366004)(39380400002)(376002)(189003)(199004)(39060400002)(50466002)(81166006)(61506002)(55016002)(53936002)(103116003)(478600001)(6636002)(7736002)(316002)(305945005)(8676002)(81156014)(66066001)(47776003)(8936002)(105586002)(58126008)(106356001)(230700001)(476003)(97736004)(11346002)(956004)(68736007)(446003)(486006)(25786009)(7416002)(26005)(52116002)(23676004)(386003)(6506007)(9686003)(59450400001)(33896004)(55236004)(86362001)(2486003)(76176011)(6116002)(7696005)(5660300001)(186003)(16526019)(2906002)(3846002)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6WlFmYmpsbWowellDK2ozWmFIbnlLaTFY?=
 =?utf-8?B?WDRTZFlUOGRZSndGK1Mxd0thTmNpbW9reVcwcXhGM2JRVlVkY2k4ZndHVEdE?=
 =?utf-8?B?MllzbmlzK2VWOWVaa1hvNkRLR2JTaGdsOGFwbFBsRzZYZVZYN2hFb2RyTjJX?=
 =?utf-8?B?ZnlabFM3SVpHN3Y2bFZ6VXBLMnl3eThjVFFXTGhnQk84UjlsR1lRNExSc1Er?=
 =?utf-8?B?U0x5T0VCRk5wYXVHaGJQSFZmS1lZSVViUjNhU3FVL2N6bzJtUjVIc2huWk1M?=
 =?utf-8?B?cFpYQTVsRC9kam8yVExrbDJSYWdXU05WS3lQN29XYmgxaTJlbStaeC82dDZ5?=
 =?utf-8?B?M0VvbElBalhvUmR0VXlkZzM3RlZHMC9lWFJOQjlMdVNuRWV3WTRjc2Zna21z?=
 =?utf-8?B?Nkx4djZ0WWdtKzA1Wmh2ek5hbXRYSi9VeGNHZ1UxNHpyaEE5dGRaR2swdU41?=
 =?utf-8?B?dys0TWpwS2psWHNSZWxEbSt4N0NMSmN6Z3A1VGdUdVVyQjZFdkxvb005WE1C?=
 =?utf-8?B?ZkxoK0dzRzBiVzlrMVM1YlA2eEU5RnhERmo5WnJUQi9CODlHbGhWSkwzZ0ZL?=
 =?utf-8?B?MDJBY25LZGpCUy9xQndldTV4R0c2N2ZTVnJNZWJZcGZoT1pmYzRld0VPT0hQ?=
 =?utf-8?B?M1hKOVc5Q2hZdlIzYVRkaWZMQmZTV1NMNFg1MUJZUUFlTkdJMTV4UmFFbVlH?=
 =?utf-8?B?Nk13NW15a05xYklDNjVlby90TFcrNjJNc0J2TGZrdUN0akRyZzZDaC9rbzlU?=
 =?utf-8?B?WkhMeUVuVDdaWE5vVUFVVXRYeHd6N0VtS0YvbTdDb3Bwc3VaVmpOdnk1cU1h?=
 =?utf-8?B?N0VjdVNyTlMzckpZWnBHN3pSbWpyVlVkTHlTRnVVb291aVJEY3BZRk83ZGNl?=
 =?utf-8?B?SmJKV0Y2NEV6bnpHa3hIMEMzeHdtWXE4UVBRaFhjMjI5ODhFQVphWmZ0VlZw?=
 =?utf-8?B?TS8zeVR6cW1QZHJOSytrTDNuRi9jOHIrMWVqYVlXTElJYzhkMVZvWmJQYmFn?=
 =?utf-8?B?VUdEdjN5aE11cVZIUFBRYXk3Y1dWWUFLNGZqT21TVzJtLzc0RWlITUNPT3Fh?=
 =?utf-8?B?ZmNHakZzeFZiaVFDL29LZythRlMzVDJub0ZHRlB5ZlZmQVplYXU5clpDb3dQ?=
 =?utf-8?B?dENRc1BTQlBDbGQ5Q0lqQTZsM1pOYytHOFI1NUhSNW5qSnhpdzFPM2FPWnNQ?=
 =?utf-8?B?dVFZbFEya0JSSVRvRjNrWmdWbjdna3NzdnlxUmRHMlUySWFobHREMk9sUEFq?=
 =?utf-8?B?clRzNVNUQUNBbnNmY3kwSlFINlFJMGt2b3YwQnhCYUN4a29wVUNBYkJMcVkr?=
 =?utf-8?B?M0I4aVNNbjF2b2dmYjFSRi9XVzdBcHR4SEUwTkR0Z21rYVNSaENGVjdDcUdU?=
 =?utf-8?B?NEZrT0doaXhnMjY1YXhGUUlSRnRDbHIzYURvdjczTnF0eGdkWXhUQ1Y3OE9O?=
 =?utf-8?B?SDdyaVJMdlhOa1dJZGVMRjNxK0IxZEkxK2FzR2UvbkVqSWRDV1pKZkhaK1J1?=
 =?utf-8?B?WVlVN0ltVC9BUTQ3amQzVitHUDd4aUxjQW9qQ1FMbVVob21HR2ZJVmoyQTJy?=
 =?utf-8?B?M3lWdUVmendqVGdVOU8xalJzQ2hqdVduUVBqaTlRejQyZEpsVHdpYnlaV01L?=
 =?utf-8?B?UVFlYmtWckYvRTNrWVAzRDJGaXFKSDMyTEhBTzh5amIrangrTEpwdHdrdWNH?=
 =?utf-8?B?Q1B3UmxLNWJsUUJsZGYvWEtWeEZVeTV6RHZITmY4ZHoxR2hITm51dEpGVnVw?=
 =?utf-8?B?Sm00azBTejl1NGtYMjlydDgwWXhGUUJNTmRNeGQyUjhhOGRweGorZGlOeFVn?=
 =?utf-8?B?bFNiU3R4b3VrMThvZlZsdCtOb0hTVklYMTFOL2hmQ3c4NVE3dz09?=
X-Microsoft-Antispam-Message-Info: e5M/02CbFPZ8Zu9YbQoKw5VYNzgzDtZU3+ObKviXYCmftgDBhCL1A4iW6SgUeBVR+nh53wHMRZ4zJlxNa2FeX1g5Cz5yvtIf9u2qTIUVrKi4hiebGBweUCWCGXw1564Wh8Wif5Tcon9OphQ6F9KBoPfkOCRY8s6gIJx7XQFyVyDHF6h5GTi/sCLSg5RaKpyE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:r3DXbQ6aJ54kKjXWE4mE23x19qhMta7YXP9/yfNyP+6b9QvjVh2ybK3XWbnHYdKamw8TsVMMqcdCjXnIPe80jgI8M+mM/0cP0IZTFS9qv9R0RJ7wcNB/tKeFK6TlM+QLlxOG8Q6vv5J5dfXquPzs1t9FJ5HKXKBGkSPjpJIBiqqonT8QC7XjhCugvFMIrH10WzN4Fwn44A9M+C2qsDDVg8m2fK+r6re4QsnwKv45C+cQuAcMijsu0g1Ys7GU1gZ4DXd1ZrU/F+6wgj9X3M3bnAB4FoZ/9zrDQWeRtL03DBMiVlw/u5RZ3H0/4PauQSteYZwCEqbtfJ/43Zl0Yg1f44Y0+5Jej0x3Jj2L39RTHUM9N1XaAuYOiB0xPCMY7QR4uTofIDgm4nQ7Dk00uQ7G4Eq7fH8/0mvll4Fow3ot+TUJE7RFyky4lTqXR6G9dzzEbjmjOdtD20ZiL55wetUlIg==;5:iM1ks/X4a55sbqAVk+zQPd7rWlcOJcICy6zjRNkX7yELW0nS+llnxZ+z6qf+KOlQ8RERcIFl+wQ2CtJAvcUDfEaJhNj8GkvZd2MQiCc1PjTVZIclm5KwX826r6ayttB8YEuVLvSQrzfTyFPol3KmT28RgInHRWUrz4gI71pI+Xs=;24:nHOvBjk20fguY97Nj8nV1k6TxW9gCn2P1VO+qReX4ytJ/6PBCprtWN3kdq+vwr9wbvVLQrzoDa3cxnP4m2IpfD2E564hSm27lmXyYKBB4gs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:nw/XocK7Myc1nokt6bhYjmKA4Qleo95XuJNygSXX0qT9pWwuwLBnO+TJxUPkOMKNmqZbSgqWuTas6vhpjvY85ka3+GHmsm+/4Oxu7HXIaj0ncKA9iayKwIdMfuTYCHF0gp0mHmexprSGgGWE/6vQa8QHfw334CbBjgY+gdmsa0uSUF5MtJN9g24awpPf09sf6/GAPyJnkBJflkWlb0oSF+cA3OT8RZG8mUREje7SJftjs6Qbg29rpseKfUA5O/nx;20:ebpZNr0QYg37E07oRWFwxlxTtXFnQajQeH2nWMd3YLWlPae5glqBdRbSn+DuJOW6XfvjN8Of/e8W6a6fLC4kdELFXbcDZdddOMp37fyW9V0dIkuiqXsUhVAvVL15IN08QEpKGjkCtvgB4GBZUS9DofmTFvPHCM9jX4c6yOnm0ZM=
X-MS-Office365-Filtering-Correlation-Id: 8a5f9f1b-f042-47e4-b3f0-08d5bfcc25ff
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:09:45.5476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5f9f1b-f042-47e4-b3f0-08d5bfcc25ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patches for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8a1ca350a58..f26ca1e00efb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -367,6 +367,20 @@ int prealloc_shrinker(struct shrinker *shrinker)
 			goto free_deferred;
 	}
 
+	/*
+	 * There is a window between prealloc_shrinker()
+	 * and register_shrinker_prepared(). We don't want
+	 * to clear bit of a shrinker in such the state
+	 * in shrink_slab_memcg(), since this will impose
+	 * restrictions on a code registering a shrinker
+	 * (they would have to guarantee, their LRU lists
+	 * are empty till shrinker is completely registered).
+	 * So, we differ the situation, when 1)a shrinker
+	 * is semi-registered (id is assigned, but it has
+	 * not yet linked to shrinker_list) and 2)shrinker
+	 * is not registered (id is not assigned).
+	 */
+	INIT_LIST_HEAD(&shrinker->list);
 	return 0;
 
 free_deferred:
@@ -541,6 +555,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+		return 0;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	/*
+	 * 1) Caller passes only alive memcg, so map can't be NULL.
+	 * 2) shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
+					true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, map->map);
+			continue;
+		}
+		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
+
+		/* See comment in prealloc_shrinker() */
+		if (unlikely(list_empty(&shrinker->list)))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
+	}
+
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -570,8 +645,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && !mem_cgroup_is_root(memcg))
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -583,13 +658,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 			continue;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
