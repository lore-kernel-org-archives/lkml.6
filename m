Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZo91XhDvyGfODAT58thMLVuL/pTb2bG//QLG2KM/vvCcKzD7izt8U+92N71dkbyTqJOieNV
ARC-Seal: i=1; a=rsa-sha256; t=1525867088; cv=none;
        d=google.com; s=arc-20160816;
        b=kMkja+HETs5jfLafkB2Lvt+kMFuTgnWyQM1xHa0ylig40Av73k0XlrvRWqJJHFj2NR
         HxpSyIxr7CyTLpcGzHZWbGBW555qqDIdvpPiHGsPQjSzIZroX4p9OEuMWHhufLp1550p
         qwVyeSSMkagTjxb7wFXGjBQPkdb3S+D3+OwMUHZulse4gPRDv81R3qyO+bYUIrUO+tdX
         mYr81C3B1Kgs+rRWyBuzx0yXI28uWguHAlv0BXsI1LNXVlJuRoJ6ud+MyuJEG+tPns2D
         iOoOdYXMqcX7b/gKq4XNV1WrW54zVBw7S6cQk6HrMkZqXTV30SEnF5tytI2+SB55SWx/
         Q7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=TtLpdzodt4Axq3H+Vm1SDOprH0akPoNa42kKtMwjpL4=;
        b=Nga4C5NfCX0jtos+Zjc3RRA5BwHYVDHRGCA1uiBSCSG/UC4jfoWAmsXYtYfyIllQO7
         OH34c9rQBfXso8OxD7k6IUtP6m1rbN6rrMtmapPTRmnF9AGFgEJSMaoxO25ylLWwvsuA
         s3aQoOLP3KomqSldHMMnBI0VpXGI6ON/bKe0sm3EmBkn6womFge74brOia8ssy16S81s
         2OoBfEuW4LMFtAppoCq5k96SlLyTPU/S2cvQI+iiNHCE7NmYX2n28D+brkbMpTjUcklA
         I1kqqoU+5IihWFfbb0h7weoW3V3i2cGCnoh0/GGG/zt4M+EV/PLTXylNW3zhd6iBlrch
         7rQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OLVU6TLe;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OLVU6TLe;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v4 07/13] list_lru: Add memcg argument to
 list_lru_from_kmem()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Wed, 09 May 2018 14:57:59 +0300
Message-ID: <152586707901.3048.10773401016856276682.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::32) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:BM5L/U24onXjSKmiJosivXzi9I22vrRQKD+O74Fx7l7cE91fD/r6pCBqQsLOeDcysVZHE3lzy31yXGXLKRHxBLbN8nuomw5UVoskWGbNbBsjavZYIW/q8FrbZQnZC+ci9dpg+CrPFfNIGvKEn4bBfUCRaBr28xIIfhPxQdrdWFoHm6iPiZqv96o0upW1fnXVhs5BBT/B93sDCcegKlhZ4u9RsNQeYuWxbUVU3T6A0Qhwo7pRpx37ExywnuLVmYdT;25:D/j8bKHvj5YOtQV0WENllNuG3A7/pbfB5FIVG00GCMiOXlIXbyX51YQf1FhAQfWvwiFSX1uCAtKjFx9D8HrQZ0Yu2p7wbz65nq0W/5TNB3BgaQGdq5Px6QPMIOEETuKo0sDbTmYP4YZoKLpoFT3f7i0qfM1JAYJkti43x+nsn7sNvOgdM4Gv4PgEH+0iEXuVkObERjt+Za5UULZY06osmt22UXW5Z1M2f4HzGez3Mj4F63/4bXDAWl2V2gcUt+XL3LyxN2Leu11V2TcUt2x0r3CPhiFKMqF+2/SJNrPfxEcnSLwMgZSYrc8uXRA3SrVdGsi/kwtznxln/6f4kLT+bA==;31:L96hNILZDWcfNaewr8JD1qwuNzHeN1VcX6wj3hagEkHmheHOc52oH3quR8ARzMQP1FLhsLpWpiAx2fALbdVg9hko1tfe1QDK/zYSj0BgjS5jlRJieJmI5KLOrOHXaJaYeeWHLNqcZ73Vt/VWoP+IrN77wws1pWzbiOzA0R/FdzfVdCpPW9+5tkGzQffoxFvh+R3sNhI06k0e2vhfytEX6dJFSfpD5joVol3pjXChmaM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:VoULpIKR5uNZIUUbnJuu/8fKloLy9k/ntC2ePjL4uyVyYPbuQMwjD46OmVHBhe68XuHJ7IRevzVrO19cwpGt/3Vd8rT2nlqtjS0ObxeezIm1caihj83cjDqF5DdPdCxZ3mOlBjBqOOs479mLeX7Pb7dCsO7FsMqGSfqm5IDFC78fBMi6bNuiyQeNE7BMH4vczfQzdq7T0vxOgzHgiLbJaI6uORNTSjlKoibOsD6FPQw9cK6os+e8we2cwKwuQm2ijkCXi0U5FBf2SLUlg+Hy8iGzRahH4Hop2oaUImo0LPuDY1bfXFV2tRotgz16zHTw06+9UBs1xw0c4G3fk0KFdoWM4101kaQ+aizucYliQbSzSTChPE54LhMh02IF00scHJ32kG1VNjdPopyJ7Bi3Y4yPGAS04olTB6WN48/yrOWZH7l1Z0Ez+6EylmW+XfudRNBj7KSbttLjmpWIrTM7D+wdYHwfJEu1IEx6nBPK1Tw6YoA3JQ4KjAEopy7wqGht;4:ZJLzthk3cN3c3Ua091HT4u1p47mhEqfXcj5hRRcj4rl/MeawMsMDuvElN+NFeMQXy7F55aCUI4tExjoGA1B0JpgDzSTZJhve3CrE9xLoQKcLXpLS7sYtUoYR0EI25vZuxkYr4GZrSMPLV3VllboOpwQZ4DWizUqRBIoyPSRGNsCn70xLAE8wyy+oRqQRax6SE0tJz7Cqgba/eh6qEObwABLHCNcPomzmI5zzN1kaocw4dO6lyA2YWh7x+eedar3A09BRYTAqeHL/Qw3fShOGHw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339DB2E6961978046D4756FCD990@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(39850400004)(366004)(346002)(396003)(189003)(199004)(230700001)(316002)(386003)(3846002)(59450400001)(6116002)(7416002)(2906002)(47776003)(33896004)(6636002)(305945005)(58126008)(106356001)(5660300001)(26005)(103116003)(55236004)(50466002)(6506007)(97736004)(76176011)(55016002)(53936002)(16526019)(68736007)(956004)(86362001)(186003)(7696005)(8676002)(478600001)(446003)(8936002)(81156014)(476003)(9686003)(39060400002)(25786009)(486006)(52116002)(23676004)(105586002)(61506002)(81166006)(2486003)(7736002)(66066001)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6Q1dtT0M0Tnlna0kzckpWWVdWRktXRkdZ?=
 =?utf-8?B?clR3TVlTb1JZZkJHUkpieFBvOEFMVGVzd05mcjZFeW1sS2ZkREdCb2Z5dzls?=
 =?utf-8?B?N3VrdWIvWkUrUjFaTkpSMnBJdHE2VmxkVUJVU1ZmTmtVelpKekl2NUFBYjMw?=
 =?utf-8?B?dUJBekwyTEpDOXNwMVg1ekJobTk4L0Zvb3RMZjNMbEdEV1VXekFJaWRxME1s?=
 =?utf-8?B?aGN1WHY5WFZ1RWJNRmY5dnlTeUd2aEhLWVU5NnA2RlZZR3RBZlpIVkJ5M2o5?=
 =?utf-8?B?SGlMWHJTQTlQMmJzQThWalZYWVVSODI0TnFsdVhubnBJK2tGWEs2ZzAzbi8v?=
 =?utf-8?B?WVQ5M0tqSDZ3MTUxc0w4NFZmN2ozUzdhbHRHQnhvWXVmZ2pnV0o5NTg0MFlv?=
 =?utf-8?B?UVBtUk8vOFEzZ3BxeXhKUStiRW9UN3NZbm12UVhtK3FTSFpxYWh1dUwzK3Zr?=
 =?utf-8?B?ZTZ2VTU4KzNOWjN3c3VjWGRQZ0grdFQyenZ0aXFGeTg2WGhRRkVsWmVZZ09u?=
 =?utf-8?B?ZzlJdGg0b2ZNUDFtYytpanFjWDNmRnd3T0xFNlhYWUJpK2lCYlhXcHN6ZXJh?=
 =?utf-8?B?T2ZBZUd4ZzBVS3I1bWp2WGh0anNqTVZFQ2VJaU1HQzY2a01RT0hBWHVpVmp5?=
 =?utf-8?B?ZWtvTURRaU10ODZjS3BTRHdtZFZtUzE3MWhRTXIyMTZEZDQrZWNjSUVjaUp6?=
 =?utf-8?B?dnJ3RklZd2gxU2VIaFE1MnIwRzlTNGZIb0lZUlVaNnpvdXpXNEU0Q2JSa0s4?=
 =?utf-8?B?WVV3aWRKd0lNSCtaTSs3WXdHWkZOV2RETjhoM1liUWNPN01wVWNnZ0thQUlj?=
 =?utf-8?B?a2tjeHNTVm5vVmgxT3RhbzF6c3F5Y2U1RXM1S2g0czRFeW93TkpJNDhiN2Ro?=
 =?utf-8?B?dGxCV2N6eHZqYUpoMmRTWXJNS1lGemoxUmdabVg3c0tCclVrMlM5cjFYYXl6?=
 =?utf-8?B?SUxUSi85TkUyNFNQMUd2L090NlZqM09PaDZGMUp2TzhmYUdaUGE4TkF2MXho?=
 =?utf-8?B?VmpRZzFVV2Q1Z1J3cTlIUzNEMU9aWWw2ZTFKOHRHeWRJQjFGSmJ3VnI5Z0Nw?=
 =?utf-8?B?bTA5VmhXVDRnWFpNUFg3NWdGU1hlU1dFckREYWNmb1NDYXBHTWhKVXJ6QVpi?=
 =?utf-8?B?a1JhQjkxYUgxU3NLc3pJQUNuTnhQblBNQWJkSTRQVGd6ZzFydXoyMTdoaDlH?=
 =?utf-8?B?TUtDOG9lWDFCUGpQVGw4TThXbm9Hd3ZSa0xzV1ZmeEx2ck8wdjJlbHErTUN4?=
 =?utf-8?B?TEU0Y0ZXQ25xbzJ6NFdteDgwaEo0TytGcE9wbG5tWmNkckhrV0hLRXEySnI2?=
 =?utf-8?B?eUVlaUFHOVJRY1V2citlK21zR1B1RmZwTjVwSFZEb2VFZ3RybHVNRXBHVUhm?=
 =?utf-8?B?Q2xPYVoyS0x0b1VITkRmaXFVOTQwVjdFSTc3anQyV1liQnZSbEdhcDdsdk9h?=
 =?utf-8?B?MnF0aDZEYnRhRWF6NVl5U0MvWFozd0h4YUtWZlRFWktxLzNzSkxJV0sxaHg4?=
 =?utf-8?B?R3lEUGVNejF2aDEya0dmdktITDNrYVZUMFNuS2hEeGVsZTNnUE1Td3R4YnVs?=
 =?utf-8?B?bGl4SVVMUlhUMmZRZjNDYUkvSmdESUVRVFpmRTdRaHVhbFJzM0lmeU5uUHNC?=
 =?utf-8?B?SUhxRW9KR2JoMGpSSlN0Y3pTK2NxSHQxbnY4SnhMaDFvNW1URE8zdHFQQjBQ?=
 =?utf-8?B?ZW15ZEV5eGE5Y2xDeEpXY0NhWDEyYXZBWHdaODlJMTB6elZRVE8rU1hoZ3gx?=
 =?utf-8?B?K0lNWVhMVFRnMFRXSEdJcnZkRlpMWWU4dy9mRVJLUnFLRUJSZWNucmNKM013?=
 =?utf-8?Q?P9JhFKA/Df9Imrs?=
X-Microsoft-Antispam-Message-Info: 1g1I6hadoyEEiy1gr8K7Z3KDbv/Hvubh7Due+4XCvaX/c62izACmBJn2u9FPvm9NJGdljbL78sf9VW34Q9eRjv0sjLPqI9o+G1RcDnCBBA+zSsEAt+oeekMBYQCUKdtGfiFPwTnq9qc1RLYauybdraQRmH6jGG7NQWWnmJlONXAdUWDY/2Ilx5g0Z6GJdOAi
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:8E0y/L+z8IyLqWsVXKYDYltjJZxEgVDRH5wUCXL9OqekKakoxd/VxsVR6050M3qKjr7RivKS/94UcGf37jkNI+QAmRcwPPCvhR1cjO4SZEpNdgxkyJS6RJqFKWV613bGRoLsmSOjIxPU5bMmQSkcpZWRI/lUfbtY3pSKdHonk8mSilUeEyVsjVRc3O//LCzvctouZJP8Lo5OgZGFo8ib0Y8Bhc0eElnPMDlZZQnhbsTyVJIPwHZnH2HvUrYA3l7qPxVHBGwFfBjaKPJp16UDrFdD1Z5Fp5BzUWU/rgCMj/qVrTORu8jB3JkyaMZpbecCqpF6zofSR9QW9DZ6UlS6gkNfR9FyioZ3UuopyP3C9fz8kgvRBMWgWH/W6vcVaPstTkAciGekPPSzl1q3XF45HB7h9q9C+tgotTtXoyQhRwXGwMea+o+CxaPOTi/gJyN9JVAWOlhPYy2eJOToehWHJA==;5:C+ai6xI7qTBPALy+BV4P7IMeI709oQioXPDsGmaicKuq1X5dVwRVXdckb43BU8+8K++2WVnaoL0l+bkDyPH8Z3NTyZnUe0v5OV5jjpygq0BXpMYMyNf4vJ2t1fBCYbxL0pUPQVqI5i+Da+Xd5H8rKdkB10k7/08p+CGXvwL3a1U=;24:XeDQxRzuPxgFhNwOUG+4MvWKnwUuOcQPuswVjU/q0S+zQvLV0m5CV1U66wAQmrutW0yELDEWgtsud7kJYWRjuA67dLOsJbQIqUCF0MsA2Qg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:pMXtRs12oXYvK3TwozTpS7BiBMUmHvoYY7k0BYwFmAasWVh7+cNpPY94OMXO5m2/UC9BCNHc9RVHfNYT190s8CSm0rXmlISo17K9k2/PSPlBd8bOTSzYZ131LFiqk8Y5AdjF2/jPss6QCbWjReyBj6HhFVjR0Fos3XWpw8RpVFcEWmioKyRJwCiPPmM1bhjDthZReTztGTK3DnHOLLIvnXLAtBs/GM8/gnsaP+VXm6/71yADQPIacfOIwOW3XGKI;20:/aWxJFH/EgF9Q8B5T9Oz/BdggOjK07AsIO/l+VL+bL1O/L6zin6YSlU7V7+PZ8Nelp3W643ieMGwlnzwSE0rUP/SpW7r7hAtiWLisj6edzDIRr0gfQG21tf97zsd88oPjHmsGpNQNf3LTiztOwesBnBUf476ZFO86+2fcNrrnXU=
X-MS-Office365-Filtering-Correlation-Id: 2ff74eb7-a2aa-4b68-e2a3-08d5b5a41e1c
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:01.8985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff74eb7-a2aa-4b68-e2a3-08d5b5a41e1c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987608315738496?=
X-GMAIL-MSGID: =?utf-8?q?1599987608315738496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 2a4d29491947..437f854eac44 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -76,18 +76,24 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
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
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
@@ -102,8 +108,11 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
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
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
@@ -116,7 +125,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -142,7 +151,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
