Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeEVKM1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:12:27 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:57472
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751477AbeEVKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:10:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 16/17] mm: Add SHRINK_EMPTY shrinker methods return value
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
Date: Tue, 22 May 2018 13:10:01 +0300
Message-ID: <152698380141.3393.16556787145139503288.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR06CA0016.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::29) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:QH2vPWgGcWAVmr9RkHGGXRQlfWvkuKgoAIduYFDvEiZm8f4Tdx8wukeoBA7aR0MnYhct+uqseSKFSLd1Niw0QM4KqYnGCV9bsP04OG4mmySfjRErseIt7bRsR3eKDcCc7eMWCPxNqKn4HEpoQpIOy75K2fvSv9QuIc4R6iZouKY3UViH7mqPB6SldIooaDk3KH5MmEQ+7U08/uG98VtHSuDkTFXtGBwBxXAnJ2w+t0SvDCN7GDeQ0zDUG7wg5hTo;25:rIHM/5w3RiqQb8PJU+LRQf0mHfqsJra2q70vIRPPsJOGdb5mN4OPr7Ib/RTeG+TcD27lvcpft6nDrPgB7LSeZSAFN4xw9PJ8IU44rMXkXuP1BdN2kBRA70AamzblvWgFHFxA1kzum2xFEEmSyoDenmwEYqTrd3Q9YyaoVZHYM0mcZD0np0r0cEXqzSPq2zatEGyK3Pz90EGenCicR8/cvUlk1BKPAX3vJmN65in6uZYnC04HTlPzfoLUM44LIniO5H628RPQpZIbLYrlTOFxtM1/jnR56JOy/c2oMQuWJpKksx/Wzkiy0SFyx/Mq2+RjzYC1JMIq+Wnt6/FrziKMcg==;31:5HbcVIlbbU0SD2qUOHbA/yCHM4Q7jxEjlO3FiD/5gMkATRcZgf7zyHF+FIl3KCTWHorRet6mT0ey/4pgZRhq5Y6O9MpJDypILvmXZ/54xOQAZk3WWtB+BAX/bYGFYcp36opMqt1m9AUW//lI/tk40oHKNQRYM8mNANFxLPnnWRnsNSmyht+o92+QZNmCldGsFhjLwxilgUzU2l4qaS2EduM0Fbw5jIB1C3F+39sp1I8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:24VwmkN9LiZSR/iZkG0R3wURhfsvhn2uLdxUZXug2fmQZvPYM1+6U+hSSoOKcoYJJTwXCDUIjCIBxY228V9vlPdNvmStFOHmlx9i/F3YGG420DifGq7EDgFZJ9gPaFHefxFzW2BSpDc4WvF7iQKjGv/7ysckgKazNNESstV1cWVBxEKFckVQTnUN3ew+r8brnpRUotHCiuPKwlHyWPXCi96f05MUOdsh+Sc6vz2mpZOeN5DAW0mng1BRFHd8ql2pAHVg6WDDRD1vxE5adqoQekgvxJEaaQq2l3xPRz2CZO29XDBm+mYainUooO5pBZxUu92R2s5GbFUeby0b/eNuCjSfX8JNd7ZW68WEuO32NKHomEBjjStX8u0f68f3Izy8RMlofJ1Lpd8BMJNQ9jrH6fE/RDNLO9RwmPbmW06Eqf4NHzSw0hnABi6eGDtMCgfMMpZhrm+r6fALZvo5fOFNhQ1mbh5cGpcRF31ql1f01os3JQlr9IRLtLIyTnHtCmoy;4:rzJoXGrJKa74yAbDxNBCrX/gvvjDw9rjocUk2Yr5/Dc/86hgXJnQGoGfsrTVzbEFogVgP5cNcp5Y/bfvEe5lweJ7o4wktF0ZEjzIXd6qCWsMy0kJ52OOJPfFluKRzqPRWIHAzDgYqmWuN90R4zZQG/fK9LvxAP6wbyZOaNguclnNi0fErlsyN7xDXL4RIl77Yeao6ahYC3b3pz8NPgVNPhqikBoTaUIK7wo7u2wrSsZneutZPnxPONYFCDYok4Ik63PHy3vIG0v5OJdOnFM9qw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333BA56131F127D26C98A0FCD940@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(376002)(39380400002)(366004)(396003)(346002)(39850400004)(189003)(199004)(446003)(956004)(476003)(486006)(11346002)(186003)(16526019)(76176011)(6506007)(386003)(55236004)(2906002)(47776003)(33896004)(7696005)(52116002)(59450400001)(66066001)(7736002)(305945005)(2486003)(23676004)(68736007)(61506002)(25786009)(6636002)(230700001)(58126008)(6116002)(3846002)(39060400002)(86362001)(575784001)(97736004)(8936002)(53936002)(8676002)(103116003)(81166006)(5660300001)(50466002)(316002)(81156014)(9686003)(26005)(7416002)(55016002)(105586002)(106356001)(478600001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6MHZqUGdUbHpYM1VUVkdvUzYwZWgzMDN3?=
 =?utf-8?B?SVRvc05ZbTlEUFFsZkhMTG9LTkRSR1hYOUR2R2lCNnVSazNldXZWY3AxZUxt?=
 =?utf-8?B?S0dnU0R3cDNGbDh3OEoxbEowMk1tcnAxMGFJcVZOL01rVXBiUytVbWhjd1ZZ?=
 =?utf-8?B?Zk5zUlUvMU5DQ2tqc1d4eU5CYUJTTXhlRlR4OW16S1JOTkYwNXYvSHg4aTEz?=
 =?utf-8?B?R2R6ZFNwbm9CZnBkN2dJczNxK08raWgrU053VWhja1A0OWVpUDdhUWFhSkhq?=
 =?utf-8?B?bWJnZCtOcDVLSWd6UklnY3BlVGhhcUZJekxUWTFtbHZtZ2JtVk9OYUxnZFNY?=
 =?utf-8?B?SUc5d3Y0eVdoblI1NTNvV3B1V3JYdG52dDd3bmFaUjNySjdsalUvMDRiYnVZ?=
 =?utf-8?B?dXNhbUNHN1FDY1lBZFdrUFJmVTEyKzJEYU5lbHNRdHFCR2NHbHdJc3ZSb2xP?=
 =?utf-8?B?NmVybFR4QzJ2bVdxLzZhdk1MbUNWT1kxYjk2Q2RUVlUrNTFhV0RIb0tBN29m?=
 =?utf-8?B?RG9JZ3dHeWh5N0FXdWZFQjJ1VmNLRzFMR2dtQm8xVWJCRis1ZFFPZkQrS2dL?=
 =?utf-8?B?OUZZMTJxRVB6Q1JPV1h5WWc3dkdlb0srUW1jRHhqaVFxTmJtMk5RNHdGL3pV?=
 =?utf-8?B?ejZQWk00WEZNZ01LUXAxWW9hRWV3Ums5aSsyZUNpQjFmK1VPMCsyUDJVK1ZQ?=
 =?utf-8?B?cmF0Sk5XVXowd0FxQkdaanN2K3ZUVmNEVW9FNnNwRktSRUR1WHFJRlBiYmdo?=
 =?utf-8?B?ODVYWGp6ZjJaR2d5dzk0dlFOVTVkdFEwS1RBeUxNb1psZ2NrRHBLWlQ5V2Qz?=
 =?utf-8?B?dzNWMEpDYUN5Sk01VnNaTTZMR0NWc2J3bDJ2SzBmV3FzZ0dXbDhCLzhyVnEy?=
 =?utf-8?B?cjNxWStrRUduVGdYakdNRzVURUQvMVVRb0Y3VmMwZEE0bFBNRE1FeUVnUHRm?=
 =?utf-8?B?MzJlSmZYRVJvL2lNQm9FblA0eWpjTzZsWTFGTmtvdS9UaWFwMjJyN1ZuUWFN?=
 =?utf-8?B?MXkyaSszd0pHaXlDSmlZL2JiQVMzcWJSVnQ2Vi9nd296R3ZvYjQ3MndDcC9y?=
 =?utf-8?B?clZIR3lUUnpFUEFDeEY1U3dobWFaa1lHbnMvUFNJZlBLVlVBa2xWTCtXQ2tI?=
 =?utf-8?B?cFFTc0Z3clpaUHVrMjJFZjloVDBXbVhIRXpwM2FESlV1OFZlVUdBZHV1TnI0?=
 =?utf-8?B?bWFIOHRtaTAyaTdKaEtQS3RDQ3JWY1MyYTR2a0FoM2ozZEk5a1BzMGZOM3Jy?=
 =?utf-8?B?U0ZDeE5DZHE2THJlWW5oQmlaWHJkdDM4dlNWdStRb2pYc1Z4OU9QUDRBN200?=
 =?utf-8?B?VkkxeTIvcFVnZWc3OE0wanNaMGN2czNMVEQxNE0vQ1lGVGpwWnpXNUlKckcv?=
 =?utf-8?B?cmpsdDJCSi9MTFM1cE9vWmhWaERYclp6SGk1Z2dha3kxR1NmYjlFanZ5ODU2?=
 =?utf-8?B?UWV1KzN5QytQNmZ5SVVLQ1ZkM2hpeTk1Mm9pT29sWnlhRm51UUhRTXNmb0xZ?=
 =?utf-8?B?d1V3b3M2VTRjeFpTS1VTUkJBZ3pybUVoTjZqVUsrL2N2QXpsaEdqQzM3ckpn?=
 =?utf-8?B?OFp0QUllM3ZKVVFweEU1Nkc4VUlqR3hzU0VVdDRFTFhWakxYay9IWlNSbUxT?=
 =?utf-8?B?MWx0cFY4c2hpVFMxWnBjeDhpT2VIQW1hcWNiNkVzTjlYV3F4NDIrVlRWK2dj?=
 =?utf-8?B?RGgxYTdxbS8vK2RRRk04QW9RUlo2c1J3bjkwWkp0LzZ6czAveXJGSlhzd1hz?=
 =?utf-8?B?Ukx1MEZaRUk5RnNBcVg2RTNLMnFOSy9NTW5sOElSeDVUMSs0dUxYSHhZRW16?=
 =?utf-8?B?bXE3Y0t6NEdDMHA5N0c2T2pENmJyRGlmR0gybjJmR25MY0pjaVg5cVlpWkw5?=
 =?utf-8?B?eksrR2dKekZ0VkdidW55cXVXM3ZaTHNvaVVZUVk4cmRXaDA0dWdUb1ZwaThT?=
 =?utf-8?B?b3g1WUZHeFJNbkJuTTE0ZkhNWk03Z2g5dnUvN09lMjNtbm00MGRzK2o2OVdn?=
 =?utf-8?Q?vTkxvEkF?=
X-Microsoft-Antispam-Message-Info: KrGN7Y1OWyCZR+YB3djMkEaSTClBOvROEzcZu6zdW6Ty1xnvYdfxorUvQp4pwPDTUz77WybdA3JbgK+h78Y7R27dZrvWoqoSPtI8kLPm/0BTV/HntSd7t8tPZgHoYw0dV1CIKtX73VaqKmaLzZZiDEoG+QWm/XgQoCZyMcqNchKZN1Cxny0zRkporlSBevrQ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:1MN8QLJ3C96gfGqCosWfDLxiedyvmAAoZ35sUsGCN9JGp+N1GXYRBZn5NdudMR2UNGsqOaOiRDKBja7yE1jUm0CfklNdbspjP3WTfCRyOdrtg+sCKfqKQwwSVhf9vdMsCttm+rBIsYZxMpqQosEEG+q0UQ5sHsWgNXq6dGlfnQu7doT7svTq2A7huz4q8TS2mVuxK0lHmPzctOyafQuSxF9U3YSzBkF4n9w0OM8bTXc+iymuX4ArX0NGl/NPzT8moczjfS3C1WBrPgslF1bgQjm84nX3XOOJy/RDj39LVXyQ3vLSCDDHIyCU3xdDHcldbX7yX3nebsPDAIQiKzFaYUqFxy3fCPWDBuDIKL/0D9RAkKWqFn5Rv/l4OI/f2HlbqG7Li26EUBoHMU+T2qMh/wcWIhJbdahnTIBWGLIiVq+HbWc5Oh2sB2b+iWObaDG0e81wKr59N3Tct/wu12O0fQ==;5:zqsmyah+wd6+Ciq970c0rgna0VRTMHh0d1NLDuJsX/rI/njYGdOY0GqB8YtYRtNqnmdHQz5u+xtcETZK4f7sWLVHT6t/7fybl2gzt8cStBhvDGe6xm5fru6tLozbtfTtahrnYXL6zgk+L2FR+eJScFJoEwqORfSJryFwwK5TAJ8=;24:arDaMKzM4SOhetkV8uONRrp8nFldhZ5tl6NEwpLdeNlY0yaXKsFwOgQdYV7C9Xd9lknrwc0IKnehrZTJDmtnd9gh6p78BJxbi48aoLYOpeE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:n4YBybY/8+u7lkw0gax6QInl+NU3ojb9tNoBV5mThpgGd2WVmiuLbQARH6WjnIGdeaUXt0t3VS4t12W+L6VXLZy66ifEw59DJe/sTzrQSDnMNpz3T1FaZ4kzFvDhGnnB+tyFfN2mE2IcfA59XxtzYKhjDuQ00k+IvHO+h6aSEQXuHTsaAppY5VnOsolPLWYs7MIIDpfsn2+Crgf5bMClMnUb7qbgAOsCv3xfH1hkdDTHeoCRGOrIJvI6+mwAZuTY;20:xSXtWk+gMyrmQ6cHI1wraSIOLnkiKKzNozg09BTT9r8qaMTC4C0nfMkFyXc8mgJzk52iKqjRAPaogNfmB+pDsvjHg7HgOM/fc3frnWxeMU8cLXqKApmY2JBbdfyi+m47TqN4CT/lMLAEmW2fpAWl6f54RfwYogLSHPIeOZ70v7w=
X-MS-Office365-Filtering-Correlation-Id: 6cd48045-7a90-4a95-ae48-08d5bfcc3059
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:10:03.1022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd48045-7a90-4a95-ae48-08d5bfcc3059
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to differ the situations, when shrinker has
very small amount of objects (see vfs_pressure_ratio()
called from super_cache_count()), and when it has no
objects at all. Currently, in the both of these cases,
shrinker::count_objects() returns 0.

The patch introduces new SHRINK_EMPTY return value,
which will be used for "no objects at all" case.
It's is a refactoring mostly, as SHRINK_EMPTY is replaced
by 0 by all callers of do_shrink_slab() in this patch,
and all the magic will happen in further.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f5f96e52e0cd..7429588d6b49 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -144,6 +144,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 7ca9c18cf130..b154fd2b084c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,12 +34,15 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
  * @count_objects should return the number of freeable items in the cache. If
- * there are no objects to free or the number of freeable items cannot be
- * determined, it should return 0. No deadlock checks should be done during the
+ * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
+ * returned in cases of the number of freeable items cannot be determined
+ * or shrinker should skip this cache for this time (e.g., their number
+ * is below shrinkable limit). No deadlock checks should be done during the
  * count callback - the shrinker relies on aggregating scan counts that couldn't
  * be executed due to potential deadlocks to be run at a later call when the
  * deadlock condition is no longer pending.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6dbc659db120..1425907a32dd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -453,8 +453,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -597,6 +597,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -642,6 +644,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -659,7 +662,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
-		freed += do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
 		/*
 		 * Bail out if someone want to register a new shrinker to
 		 * prevent the regsitration from being stalled for long periods
diff --git a/mm/workingset.c b/mm/workingset.c
index 79099bc5c256..3bac1b2f649a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -402,6 +402,9 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	}
 	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
 
+	if (!nodes)
+		return SHRINK_EMPTY;
+
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;
