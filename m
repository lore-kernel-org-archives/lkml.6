Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrNMXWtgwfpAG7JGivtWq848D0mVhifa2dOAlC4PGWXcvoftYiOQ792K3zM52sql5vqRhBW
ARC-Seal: i=1; a=rsa-sha256; t=1525946004; cv=none;
        d=google.com; s=arc-20160816;
        b=NWCP1rZPbKwMyxRoydEZxySZkXj/Dw/vS/HPNVMdFCIWGe3a1nLB6ZxeMjyZO9yLdT
         OGjpPBGXm4iDG2a3hFB6vq2K4VG3UN4HewBocHsrw1Yw3mCCNaii2GpOLWIZ0NfYYCXQ
         k9fPNsGuIJmq65BTKyog+XgQvOrykf0ozIs5T9yhdfPXpD14MeueA9U/QigcI8t+HS3Y
         hpTFcG7pYUdv4SKNoPEDnezFMEKOmzt22NuSjbUsaDveuDZwfd7GGnVFlLWWiDrL0Rdv
         jCFA65RdWQsuq5oYcd+Givb/Q9XVse5CsXf3F0b+gbaxaICRYNem3L/hU2kcOIvY7iAr
         bzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=nnwy0WbKaa0RduSIvlSVCWVEqCAstFFZiZwiE++xM50=;
        b=bp2/pbuHtDOsBEGbL09F4T+6KVjsPtihbR231OxMNAGOOzQCORCrdlZPWKmehyMZhn
         HqOOSWkWL8/3XPNjgXuSQCL6SdodSHbTAu3PI3TKZ6lDbGGhfjGYHZp4H9Xa/9tamFfJ
         pJsSAcdaiBH0SJ7uY1RdmaUxesvMPASCSUCE2iMzwVpf0UJ6/O+/7p6jhHsYrKNTXSmF
         WgK01sjQWAWL1fWe+DMLTVWV54EFAy6EiOFvJvrejb4tFaAGQq2Io4kEjB+YadWYKKIc
         Cy9vCYTdafgLsYHj6f4caArA/+D4zJY23MGa+x7E5T+jr4vNv/SagsJioSpec9YCFI+X
         GHQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OSXuPmLT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.103 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=OSXuPmLT;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.103 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 07/13] list_lru: Add memcg argument to
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
Date: Thu, 10 May 2018 12:53:15 +0300
Message-ID: <152594599552.22949.582222092861665393.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0502CA0006.eurprd05.prod.outlook.com
 (2603:10a6:203:91::16) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:ucSj7A+vyM3jzuJYc8MrVZyACD7HXOqqnuScTryVyM21M3kk0iMN4G8yIghcbcByUZCiVD7KEg9lOM+YqZ1Rj0I6yFfn44rUM8YINY7JCyJe7agKYW2zAAr6qFy7Myv5NadoR2jU4WefDO39vIN7lOVXCW9dc109k4Ve0XbA7ACQwugQpozKn6ZW9AXsGenIa+KJjY8CtqBUHdZpo2oWfI8mg8nQo8cYJz2I4N9J6lgMFqyn+7uE2uSKe4R3lgIL;25:CnYA3VsF4qjKLnqaC/N0vYgvalBgdswcXz/KfKTnYBooLJrASZH9/bOuWq6t8o179aI8YY298oSM5sh/yrvJ60toxnfSfruBoIvCeAkeLrDmoxZ5g537QIYQegaqNw8vqaUFUDTFrsc+pIm3yRD3Sw8A44tc3G9Qdwl6XPa0zDUZKWe7pzcGeepcsbsklCTJnrN+3Q7oI+dHCEXK1ap/W3bDfaH2kNZvijQEEmDeO0+2VsQ2tFAG83lvuKuSih+mSrHQh7B6WV0+2sioEEbaWqLzzuKiRiC/FVT3tD7Etd+dec90j7AND6pgK78/U1SCR1tIR7RcsIe22JUAyhvong==;31:/NcbLeBX96ddh4uAQIPIIzP6COYaY6nNTelNVyU+EVSLmhiWHnMF94cdIzfYyzTSrWdEQLGJE/YCf7RRGhJG7UgtWfF6qa9C3zx0vDyyxSfZbtNtP4eoAM715Wc0NqZQtmU3FbDGvf1oViPla1UF+B+PwtHQd6g6LFUNkg/hz8Qt4+Lq+iOqGfRKYeW/oYeqzLzVPnKYd6tGFPZxmMa67WujuZ4FCrBSqn0gfY60f88=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:BsaA/TjOcd4a/iG2nD659SW9qe/FVwi/NS6SzhnVt8JBfNo1pLIQf26S0KHpsvxv0XjdmdMQaEah8LKVzg80ZffVzwBPfEaJw9u2JaFWq6GHwXP/888bAdDJ6aF/CDaOzIYxEheSiz76XFiHdRWeBGx69RyPFPA3yRYDuHAaWWY/y6/aybRtclKRYmDFnY08TzLzUFVwWpENjfYuDvUGc/1iZCy5usotPU6G7Ews6S+zuIrn7rcfkd7cSVfo2FQilzh6v9S5kFaXs9Us0TDRgxBm2g+l3/9ym4kCbWDeAoKGY8NgClPPkADPOBItw7QgHIZkhRoc9EVYDIa6l4TO0UvfAhbaS65ca3xMNKd6iyPB9krlpM8WtbeSLoizBNqGQ3069UMJfDc0zVQGkAnrTaYU1ko4gBUGxKeSq8hmrF9lnsIRfmtfTufEYf10DwQYl/ojqL8l4RZHosQshLlj4sfdBJWD/0Cyg/sjrIuFns4Ejr53U78rKo33aWbAaryX;4:/QTpIVucnOoO4SBfq9TiGQUGDlv1XlCLV3JDTzAs9xwdtdAaypFVOxfGFNi/Sz3cCOLTok/LeMo6H9iOI3TUejf3fF9LePML6IkB2KxND/pRI6ciSgF3US9enyhkTp/wOs9eVKpOXOeP60rMFGJ0Uwg5qFyuSLdluhEnXG7w5G8Ur0JDYRzNm+5KEyMwLLI1snLERS6mkUH3lu42ftrQJNgCJz0dN5V29QmwqeFs3GxlMdk+J7EAj2FwPzsyuFA7KBAILt8L0Z8r7P/spyGrcg==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13339E5985B11CF017DAEBD8CD980@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(39850400004)(376002)(346002)(39380400002)(189003)(199004)(230700001)(23676004)(11346002)(2906002)(58126008)(2486003)(103116003)(6636002)(52116002)(7696005)(26005)(7736002)(16526019)(55016002)(3846002)(76176011)(186003)(305945005)(446003)(9686003)(6116002)(316002)(386003)(86362001)(486006)(6506007)(68736007)(476003)(956004)(7416002)(50466002)(5660300001)(59450400001)(33896004)(55236004)(61506002)(66066001)(106356001)(39060400002)(8936002)(8676002)(81156014)(47776003)(53936002)(97736004)(478600001)(105586002)(25786009)(81166006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6OGVEZlNXMUxtTWFwK09qeUhZWnIveExE?=
 =?utf-8?B?bUJzb281cGJab2xZMjVua0k0OGRuRXNuQ0lzVUVXZjRUUXcraTMzVVBGR05K?=
 =?utf-8?B?VjNJWmIxL0g4T1BpRkt1SElIL0tMNzg1Z0RHVVJxSHlyRWpZVzJ5Q2pOZitl?=
 =?utf-8?B?QmJyK1FPMlM4QVlHc2plVlVCc0Y0cGs0a3E3TVNVMmM5RmxzYTk1MTg1alRZ?=
 =?utf-8?B?dE9xSm11VVFyQWp6RHFQdEthclR2SVlXM3JWelcyQnNhQm51U1lMSGx0SWk2?=
 =?utf-8?B?Qlo4aG82bzhuQWpUUGtFQnNScG1XaUErRXNQRHRlMnZhalRSUU1vU3Z1c3FR?=
 =?utf-8?B?WmhDWDI5bWFWNTlXMTVZUk1SQ3JqNTVhWExuT1lQY0c5TEFKRWpNTWFxR3l4?=
 =?utf-8?B?QzJ5UEQwRlRtR3FrM1NKTnMvR215U0tFdTJ4WFpmR2g1eTB6TUxlb2o3L3F3?=
 =?utf-8?B?cmMxbkowcmVUUVpST2JEbXYxSkpESWwxRzZmcDUzelQ4dWNUS3NYOU41ei9t?=
 =?utf-8?B?dDdqUWpOcGc3THlVZ1c3MjVGQWhhM2kxaXcwSUlsQlJBTGlVYmw0RHFFZGZm?=
 =?utf-8?B?Ym5FTDFKZ1FYbm51bEY1QnlkbDBaNnB6V2xHTFJyeGwvMmJsM3N1RThQbTRx?=
 =?utf-8?B?bk1salhsUjFJWHpxSnU5YnFWQzVrTG1adWM1T2xtQW5QQXpsYVhPakdwOVlz?=
 =?utf-8?B?bXlMcjVUSkRnM0dSdjNPdDhheHdFeUtCeEdtd1hyYVhCaWlNWVFGcWtQUTZk?=
 =?utf-8?B?Y01yQmlxUTVBUXlTVXJRTmxkWTRURVVxTFFwclNOY294UTBHZkM5QWtYRjZ2?=
 =?utf-8?B?a1c5NDlUUC9YUXY5Y0VHNkhQMHdVSzc5OXVPRGdTQkQ5TG9qZXIzNXNtbzV4?=
 =?utf-8?B?bzJwYy9hSVI2MjUyUHRSaFZjbkhVdjI5RHp5b2hDSStrWTBGZjUrOXhiRUQ0?=
 =?utf-8?B?MFFyT0ZldUFpTm9ndVY3RlFZQjBFK2M0R2VxelptYVFaZWhMWGZXTTFRVCt5?=
 =?utf-8?B?eERPRmprSFZ4YzJRVXh0KzZIL0tIRm1SZnN1SSsvRUV0QmtjbEV2bG9QcGl0?=
 =?utf-8?B?bGp2dlNBdFVCQ0pKaUpteHo0ZjNOcmJmU1BzRmZITElQZXhOSXJUL2t2c1N4?=
 =?utf-8?B?WU1Za0FkRGdVOHp3dUh4NmxPMEo0OTRCTTBoR3A1WGIyRll6WTNQQ29oOTNO?=
 =?utf-8?B?Z2p0MEdiS3lpeXcrM3pLMFQ0L1dJSU9TY0R2cDBRdzdodWlWem4zdUJLVTh1?=
 =?utf-8?B?YmpWZXRBNitGR045S1JXZ0ZQRmtyT25kNW4rOU9aSjdQWWQwN1lTaE5lbU5W?=
 =?utf-8?B?TnBDWG95MFV4SmJxSjlPOFU5THRJS0c5SmZ4MzZvVngxUVl3TlE1S1dFeGQ1?=
 =?utf-8?B?dzVYZExVNkFZQXg0VDN1OXJ3aTFrcTRtbWhVUDZMVTRpZU84R1ZKVmcvUHky?=
 =?utf-8?B?V2dQenNBZ2dHamxHQXZSRDdUWU91Y0RxTkpmRkd0ZmUvcnExMWVjZ3dneFRU?=
 =?utf-8?B?WVY2bFRBM1JDTFNLUUpmWnpVK2ZjZ0VJcjFIaFM3MWhlTUc1amlkMDBIS2RU?=
 =?utf-8?B?dDkrRHU2TktWd0U4SzlDMXZ2cmxCUHRmTnZScHdreGg2UW9Iak1tOXhzNmc3?=
 =?utf-8?B?dTBiWnk1T0crMDg4RUdEK2FQY0hzaXMwbnl6U0NmeTJTT2RwUkN1RjdFN0xq?=
 =?utf-8?B?ZElVa1pPbmYrbmg3SHF3QVRpbWV0MFh0Tm9xRE0xaUZNdXkvRDhzSFRTSzJW?=
 =?utf-8?B?d3VPNFVDbXpYZVNiZ2w0V1A1UWJ0dXN1MjNnS1RiTlJlOTBlT3VXWGgrdUpK?=
 =?utf-8?Q?Jv1LEWfB6FL5Zh3?=
X-Microsoft-Antispam-Message-Info: l7RYf8NMXcIrW3FJ+Ltr2r6ItdzhLg0rEqNSe46lll93D0e/468NUDzFEDaOz48y1eUvVaJTsUNHffAqIr6o2U2ISJe5Fd1IkmS5qtUez4cFVAgft4XWHVm8bRQ2S/CUUDsdHvmq8HA8+yx6FRIWLAhwMLPLkcJEG4eF+cGc9iW35bqKRQeEzVZovkcZ0Cz7
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:1Owp5PQ4MksANWOtoyriXf5nQBlXqBUZmxTSmznukqnrk4z/CctL5JzHHHqmO2gtfBDGogr0l9Exk9g9zKMGzz9ZgZkdhzqneKA/wfM/htXL1c+xfi5oS0eg/m3LAZKtfhFYKRBaz0NLc2tjnphi3LYaTZXlXl+qhhAwmBM2HeuWXjhtt6hAswg1szex5bJksKtAql6fbymPZo+DxNa+P92USsiCGd38UytQay5XYWVwHVXblRsC7pK+si4IOYhRAZTDHBZriOOKGaih9/5GnsuKixmDCdkjk1YUNWG8KOM/f277hH30VuJxZOEpew8ybarBSvjYb9l3WYQ4oaYx7KjSFT2qIe01qWMQe5A+u7g2bes1IqdbZvPJkKtssz4bY6ZCcoHsqROI7FIRRvGLzz2FQyiS1IqhaJO/dmj2QdJa8ZzPhKhDNMUEUmmCvpCqzvH3yxgt2kCFnJh92AN5ug==;5:TrYSrWXiWSRG4S0l9WMMc+0DGWe248ZEYqCMbfgPdrd6tl0Fvi9dRPzXEVNV2EkGqamDTtKk1L/m9AJqM1vIq5E8EiNMKMZlNRwOBZgXpRAdGDdBScb/gGVk6El19Kw9KunEVkanlHcU+wMzl4H+putPLccypOolnitiobmzMY4=;24:pS+Tq17GxPq2ZuM5gLW89PJgyQufYiG8Fd57LJMUJkN9UzwrxcBmobgDme8X1LiSpDayc3snhHzYyN9phspE78zTfYRLb+6woGR+jgDe/2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:Ri+GYkOAOZna81d9eu66Ci+yFeA1mWykzrxXrutvvLl20KRm8UNqupUsD/jl74x42sqxv/EzhNPXe1NQ62AA1BVj/LilTYcM1+O1OSBQaiTVXKkt3++wpGTROaiMvYVK/Quzxrvayy9xXpkTmnOvcmhbCrYMDUolZpWDvQ8KhEYVe5q6zqt+SNFA0I71bWEVErYM45fRztmg+3EEWQ2oK/4WTHJCDoUBVU9xGD8mffs7tK2cch/CvcfMPV4eAZoT;20:2sSkfzh/hLqvseExalrd6eGKEWbMHMzHsTkOGtbmwW5SsdL4P13uHOf3lO6IW9zEES4vCnBUTNn5OX5haMbNob815g/NhSIrMQEH+0SBALsW53M0KqB2oXI9+RRG9m6ekCHHJJkc1dVVny9oyM95jQf1pCDAI+vGMRaVRVEkGTw=
X-MS-Office365-Filtering-Correlation-Id: 7865d5ca-8b61-4561-5e9c-08d5b65bdc46
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:17.8858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7865d5ca-8b61-4561-5e9c-08d5b65bdc46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070357441352435?=
X-GMAIL-MSGID: =?utf-8?q?1600070357441352435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 8dd3f181d86f..0721381b2e3d 100644
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
