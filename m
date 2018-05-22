Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeEVKPK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:15:10 -0400
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:19280
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751419AbeEVKH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:07:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 03/17] mm: Assign id to every memcg-aware shrinker
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
Date: Tue, 22 May 2018 13:07:43 +0300
Message-ID: <152698366374.3393.240092291013126670.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0201CA0009.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::19) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:r0HEU/+vYVxnK/taCFJBqKj5Kwz2OtF9SGleUKlyx7ETH64vgj6EET2FMsCNXVW+sJgtBeg8J+tYE7JSqH1S1Y5ycZRR7ROOKLelTcrwg3MEbF0ImyjeMBELRwTeFxiuC26+MvkcNCLehjNHIQHOM+i4+ou1b1JjT+F0EzjAg1kn0T0ZkHQWAUicUi5Y4RVagSCulFPvn/nIx2qywdGv+u2/eLwgPNQ1frN7xwiT+6s8npIvJ/PEtCkDaPXD2YaP;25:Pt33LkeU97+WHAggVAm8Nks37I3NVOCJ/3B5CWrdCi821OrV5l4j3CFZ1MAZl3UTu+wH5txZmRijYT/lGjJ6WDF3BXHwnvOaF+jdNTgpMzQ6w34FSdsLomUs0O2KPWRQyTRgcKPlkBYQKg4Ke4Fut5wQ82yRbGzOZTrn3GbGQ31KuxryCsAZhueKio3B8QlHKOU+mFACE5uHel+0ivsHBfPfHaIuGljF3OuAau0TolQJFHcpo67N30jjbczqFFi1fM8suNaOdD3POlE++qHzjLWwBRUxlgyf5LSUSyWk55ZpYkIvOXxNzdRaTXFhb4pdFpJiodyZWGJKA3GRBhd8IQ==;31:0QXLngq7eDlInstZC+QRum5Bq+2Xqns6uUW7xZJW1KAZRQ9El2et+M14UPhXIFCcOqrwXYXrv/bRio0/HIi0SKa8RbwNMLN1Y7fDsl0/1JgZ6Eq+zYok2LLzb2k/vplYJFavQXvHO/rLMBJc7AgzQsOXIFBh1xApfmI1IsHzzDMv3e2EX9IkD/iyHH6UJmTPjCGaRCXgb8BuWBQ7udgMJch9ojiNT3jT2FVpkTLWPVM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:AMsyNsrPD5Ugetma4RQL9uNUOVT7m1FpvrU/Z3hlwyjULTbRAcA0DOHyMQKQNeUB4Curkfu0Cr7o/J6R9RYTDCSVp5iBh0kaR02Y1Vwda2fSWkWy8QbpgvTlEPSELxy4XYoD954bAuSl0w/Abo/69gIIac2NzhSPMN5uft7/9TLqZqpw0d7z7skXWTeVqkIgWfPOapCGO477Cz8Y5RCio1MQDmqJBbIbhaR0rGwtQk+SymtOH8Di/gxu3Un6zowv89MLMI/6SGCrNdYjaElsnT8GBCX5itUdFQYflqq/+1f3DVZUz6x6QBKsq6ZkXWYc5lGRTfDjvZ9RGsJFTCF/I6Y8wSU60ZvN+FhXG7Il9UgU2cR1JEUT7sRCHK5BHOygqMQwgmY1d8yQhN/tx/AdO5PIWIIg28pMB4vtiKP6I33npifQqUYcigR1JE2N8erPc9CVwnXXsItXA2riq1TDRgys7ILohjb6t3lnLLHqjOw77Py76gCtYDfosqY+1EV8;4:dJZUfrSqdvKeGwbQKpmoEUbC0XJJLpwouvqGiOMttfxHkreQAL+E4Ma2HanJK2UPRP9nhT7pOZK4V2Tr80eYXWqxQpN9vovApCxGJXZ1jQdj7IYEgEbfR1ncVOBx9TvtWeRZpFW1k/PnbrccNIUJMsDWHoZbJnw0TUQUgvnrqx9+qEjZKQtNp6A0AapqG6Pz3Lzny1CGESz1wbFP9jcUWq39rMERafgOAx6Tq/aY0gA5yN8AUpFLicAF/APQTmh2kChSP9IOS1VfbOAg75cg1Q==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338C5D2B0ADF17E2C60C06CCD940@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39850400004)(396003)(366004)(346002)(39380400002)(189003)(199004)(50466002)(105586002)(6116002)(3846002)(81156014)(81166006)(106356001)(68736007)(25786009)(305945005)(6666003)(6636002)(486006)(8676002)(956004)(476003)(7696005)(23676004)(11346002)(52116002)(86362001)(2486003)(446003)(39060400002)(76176011)(9686003)(5660300001)(7736002)(53936002)(103116003)(97736004)(316002)(2906002)(58126008)(33896004)(61506002)(55236004)(7416002)(6506007)(386003)(8936002)(47776003)(478600001)(66066001)(26005)(230700001)(16526019)(55016002)(59450400001)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6UDczc05LRXB4bmJUTmE1UFR3a3hFN200?=
 =?utf-8?B?NnE5OTBTa2NONC9qcDgxWnpjTW1PZzJjZE9FbzZPNXpmalFUY2dyVGFwR1g5?=
 =?utf-8?B?cVhZSUxKYU8rVEZrTE9lazU3MlJzaDBLQmNEbUQ4cUFwWmhDcjNkSWZ5VUl3?=
 =?utf-8?B?VFpmZGFOMTVyYXMwYzl1TVZ4bnI5NzBNS242YVh3NjFONjB2aGNOY0RFK05i?=
 =?utf-8?B?WEFoK3F3M3BEeG9kREtYbWRreG1oL1R2YzVuN3crZmZ0amxsem1FQzVBcWdE?=
 =?utf-8?B?dTlCRXQrZ09CS0NqcEE4cHVNckJ5ZGhlWHZscDRPRHpkcFI3Ky83eXdxWFNm?=
 =?utf-8?B?VGxDNHdxYmJ4U09qdFdwV0ordmhoNUEwNFc2Z0ZobHFtTWRQb3czTUhXVy9I?=
 =?utf-8?B?TDJ4ejYxWUJ4RElqSUlRaUZlU2tONFNMaFFQemFoaEJTNmFPeHl1cS9oN1Bn?=
 =?utf-8?B?VUZtTlZJSmY1MHljMyt0T0FacWdSZk14RE1lL2lpbGpNWUQzbUV4N0pzZFY0?=
 =?utf-8?B?NEJxck5GNHo1cDkreTlzVU0rM2lsK0h1dStyVEd6UWpleEE0T2NRWWwrUkdE?=
 =?utf-8?B?c1VoMVQzZVpYbENUdWM5WE5vRisvSEZOeFZZOWxaQjNjNDdXTEd1Z0tLdGNT?=
 =?utf-8?B?WmVlK1pCRnlKSzVCM0tXMWlibFkyQXNJdHpTdTFLRHNPYXZ6TjI2TDZ3ZWo3?=
 =?utf-8?B?cHBPVWhMTndKeENzKzBlWEhYbEZNakR3NzQxQXFnK1JTZmx4ckxFWW5mTVlj?=
 =?utf-8?B?cFpYSkRhaHc4T1hkNFp5UTNHQ2xKZGYwZzVUT1lwRU1MaTRJVkY0blZMdzlh?=
 =?utf-8?B?cWJmOWFkeTMralhscnJGdjhPMjVsbUY1TEJDeXlsQzJJTE5ZVTVUWldMUDQ5?=
 =?utf-8?B?VWptbldQTEg5aExlODZyd2lTRVJ2Z2JEd2xrVGdRMlFSdlM3MkVuckNJVnVG?=
 =?utf-8?B?Y3F1NmNMNmUrSTNiQlVXZm90N3JaSUlFWm11M1FnaEhmZFZldm9wM21tblE5?=
 =?utf-8?B?S1U5M1VhM2dhY1poK3NwMHp2OU5ZQ3ZhSHdmNWFVM3Q5YitocTI0ZFBWWm1r?=
 =?utf-8?B?V1E2U3AvcUhnL3draEgwZy9EWkxBREIrRW4rbFdQYmo2Q3VmbzQxQ0IxVU11?=
 =?utf-8?B?clptemlPU2tmT0pEdmVNUWRyUmpQaTBBUDVuRUNDWENqNm9QaHQ1MHJWb2ht?=
 =?utf-8?B?VjFzK3FDc3dwcmRhOEJuVWFkbzZHU1pEa1hpOGlTRVJFcnBqVXd3WXp6bnl6?=
 =?utf-8?B?T1FGVHpwMGVzdTdqRFNBQ0MwRmZIcFV6eitPUytmLzRTUkd6cDlRa2Q4WnlC?=
 =?utf-8?B?SldHS3ZYbVFvRlNqazNRU2JBL0VHTm8zK2wrLzFEbGlKWkFwcEpVYWdVY21P?=
 =?utf-8?B?OWp1STgwbHhZYkRXK3FtZnorRjRTaTJldElVdVpKQnh3bDRmQmgzYktDeXFv?=
 =?utf-8?B?MmkvV0xOOG10VWJCcTB2UFRnNzdIZUYwclFUd3ZqWFVKbFFxOHBOSHNSQW9a?=
 =?utf-8?B?MXBjaVprd3FKWE45bkhHOFdzUWN3WkpVVnRJa0Y2L2dkbVB0ajBEUzh5a29l?=
 =?utf-8?B?QXBzNkNhSlNxbUpTMFFEczdWWUFpY0o0Y1Z2WUxPd3FGWVhSVHlEbWtXWURs?=
 =?utf-8?B?dnFuWkFkTm9XamE3b1JZZlN1bFhCYm9TRGNGbVN2TmtlcnVYK042V21qMUla?=
 =?utf-8?B?dWo2MXFDRmg1YUx5dUhCTG5BNDI1M2JLYlEzMnIwbTN0R01kK09HYUh4cnU3?=
 =?utf-8?B?REhGdEhrdnMzWXFPUjBkWmRaRE5nUVJTa2xxQXZoMVREcWtQL2NCemNZUkpq?=
 =?utf-8?B?MEhkLzR2MUhJelZNUGpFejhRV003dHdXbVdjSDdYY285b3dWQT09?=
X-Microsoft-Antispam-Message-Info: uMG32Hoe3II8qIN6bFeBaAciAkZpZDnYQEV9N0MMCLkHA9N+HI7Nq/fYN2u07U4kqG+zLwlUvw/kwB55X540xFRTL/tX4XpOsuGK1xADGNGCFwujpwEJ/qaDRdSHIMYCGMidl/MPsZMjbnAN6gbiHvpqCNKrhk9OKInPNsRNXi4CkfEGk55t2R+tKwGC7qah
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:DCUy92rCZwXOUmixVpCC9XwBtR6YjKtXS9KA+7hCLgW//zNLEsLm7VT5pLXTQPYN+MXtKbFszuURaXBU3mU+75+5oIKpenh0fMGWDZNlFVJboPYpvsr1cjPteGGsFW/vniaOlza4d9jCE0CzpjOfX9QryOQT9VQ8cQ/nXKX2Py7VGUzyZuxFWw5mdn3aouAJxwI7sHZkaS4DqcxVK4FZmb6/NYTk82gZHE5DTCTmPVvASTo5mOdak8/HVzwB7hcz31mQUoMTnUvvMsJZCYUfdnICESxI7fbrsxGnPWsnaxw/isfsxBg8v3S1kM8tUYUNLunTTn/biZi1iEfZki0O5N/06uia2LL+QVQfoPDHEgZ7otOqWfLighLpm0AzT9b2bP8ljG6lxq/9dQT9TgaGXQLhSK4MZS7s6tHoykKEJuX6xGiddsSSl/+sLJva7rFjr9hquslnt5zczmavWwxw3A==;5:m+aIFWvgnerN+r9TTcBGfxOVJWSV21D+On8JcB4/oCAOpI/s8CqBTc+spBSAfrVh4JejF66vLc6aPzG10HwN7Xg4caUj4xN+eoKsIiSK6bEGsbcPVhL/c+jhjqKfvxz1RCCZcH6PuFMCVCp+8I1+JhHSripv9FYnmLxQHS3w0Ts=;24:xgZdY0LG6pFqGD/pHGgNJZG8UDpMYDGPnqfvL7wQ4guzLi68PEzRaRd67JzU0RvQSacm3VAMpcfy1FPnqZOfoSeCuMjOXjrpbBgpTle+mMw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:gxCONSjjmYMMHzohc/MVS443VeKvlzAV6FsqBMTQxImy/2jd0Jzt+y+UJST/X5Uh8EeoCb1wZT+x5mKlpkMrdYlkZ/PGPU+ZCw9aENYRn0AzbouMou3SMte8skDH7v3nIcQJwwSdLcmB0redNyt3yLCWfp7WLctV8YMB0QlCU+MBmi5esiXMKiB3SHjlUOv3vW0QHE57vDfmY+JGlMzDx3HobPn+vrUoLjqE6Ley87mnCQMs1Cc64gh9r+z0mUHh;20:+f5fDqas9GKdVQTmCr4ndKTCX+rvxxAutRIka1PE7t4cpX0Kcb8PMG9dAe50DvjJCCX6WJouRNU9Rrl3M+J90wKqvZiMFwm8TWRKFMctTk3S6mzrxWcxXxykUY19bWlQyye4WfAMl4qgXh4SDgMEikhsQaGzqXcvLPOAOy3T0JE=
X-MS-Office365-Filtering-Correlation-Id: 5b7d3efb-b06f-4276-1272-08d5bfcbdfbd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:07:47.4987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7d3efb-b06f-4276-1272-08d5bfcbdfbd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
in case of !CONFIG_MEMCG_KMEM only, the new functionality will be under
this config option.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    4 +++
 mm/vmscan.c              |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6794490f25b2..7ca9c18cf130 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,10 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+#ifdef CONFIG_MEMCG_KMEM
+	/* ID in shrinker_idr */
+	int id;
+#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50055d72f294..75b00e6ff9db 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,49 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_MEMCG_KMEM
+static DEFINE_IDR(shrinker_idr);
+static int shrinker_nr_max;
+
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret = -ENOMEM;
+
+	down_write(&shrinker_rwsem);
+	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		goto unlock;
+
+	if (id >= shrinker_nr_max)
+		shrinker_nr_max = id + 1;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	BUG_ON(id < 0);
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinker_idr, id);
+	up_write(&shrinker_rwsem);
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -313,13 +356,30 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		if (prealloc_memcg_shrinker(shrinker))
+			goto free_deferred;
+	}
+
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+	if (!shrinker->nr_deferred)
+		return;
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 }
 
 void register_shrinker_prepared(struct shrinker *shrinker)
@@ -347,6 +407,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
