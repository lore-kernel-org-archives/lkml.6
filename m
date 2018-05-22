Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeEVKHm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:07:42 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:14014
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751601AbeEVKHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:07:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 01/17] list_lru: Combine code under the same define
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
Date: Tue, 22 May 2018 13:07:22 +0300
Message-ID: <152698364295.3393.17720678806516765105.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::24) To DB6PR0801MB1336.eurprd08.prod.outlook.com
 (2603:10a6:4:b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;3:IfnAKE8I/4lVWDfVMOL5sLD9v2U0IbuNfhmkQLD3oFHnBpCS4v6xMY/zaE0Y1jhCOC+djBmiHfIQnyIFo5cd6HRxlwuf6mTsfpTqf16yeT0DkunJK2t+AWvwQz3vb51vvxmPAyzVa67DMfm4h57equbQCnBzGBaDlKu3MxWINFcwZe8qfHSVHU4CCyImkz8lRy2gPTH4kxDhGrL2qLfTEgNQZZwOUB8lQ02WnbEf9WvfJ2AYdNjUnJ/lxVLra0dm;25:0Sk6y6GzUsfJq25pYEr8BIhwPKlTEdW5Cz7YpdP/VRgOxjwtKRclIEcFupFpZxMoyqRWWpWE2dhU3Cj4VFovw7mQ+YBSX4Lor6K7Xy1vk87u27YCq/AUSyQDDcZSU8c6aiCbKdMUb6jNB4exXfuEu6XgjR9DcTLhqt7scYdqQ1IvvYooiXeYUjTzCP8TBPj9FCZpJN9RmIC1Xp5wmMwhgiJzRq1I3WDb1hC0OZeG3/1ZMjIcWCCB4NESV2z3brUFPBURko8r7+91NxjiAbjuvZA2Ofe4ruQ9NX9O0MPSQcSmxbzUZU9L/s5+G/WfAil2ah72MZZVxQptO5J2QA29ZQ==;31:ZzY189i8fStVKKAOMwXkmhemGeTWe5IFeKMPhtbM0Qo5va/4b44We+Hdf5LmWEUPmZYcjb20R/ppVytWm2N/mGijPp2Jd6BgDgnjRsnPEwhlZzS6t8/yWys7Cz6zVpXKWFrDADBTmEqc1T4KsVr3OWGNGY5WQ+LqvntVKRtDQ5AYwVg9eFEiLYgElPFj+noS/VJn+g9JZTC5ZlbB9HWFxEZ7qSLHhsY05OgH48D3aeQ=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1336:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;20:DIXUYHvP5QimxtAcOxl5d4IUp4uBLP+YWWJQFfkQ+BCuxRapqN0uGzv5keSMb7QaSEdvb29+StpsBekvD+jM32NzKKUhHACNYuvWsErwNfAZLDC0Ur/YTIgB3QNeb1Rtcnh0BOF5bFO4hq8/z3oFAvP5tcGQ8oQ+8HjjVGprDlRvzOnGoWQA8pVe97LEfHHlRiADyh/2kcg7srnNF11ZB44VW2QYKQ3PM7IWUHWSDkvzaM6fWV3/Hup+i5aoKJuIcVt4abBn01HKLD0nXfCdwZxIbclvVgVo6qJcXDPFx6SuXa0GMxmcCVFq+GcvsteIWvon8Irzp07ffet3LPWI71zQIKGemlGrhMuAqODxG+LZEo8X+B2GgOB18KvIYlQClfuelDXiFEA5BnjLtvL6pLZw9yCLZVxYKFTeBjaYVL08Uypv0JrL8vu0KQ1yY2UfZ3FcYXxxx14W9er+2S67An/szac1+lWqACCShhl2wVZ0nFFy04pJ22rDjmplMnLN;4:e8R55d4zGTQuiABSvSZI9pUQBHnJ+iLTBe1sEaOVz1VEasOyXRMgut73VdWwWKdCtN4ju5h8UBXU5zIKMZlE/l2Vbv8vd1+K5RnNGYumJD+/jR0CPcffOBRG6AB0WGZYl/5yu+k1Z9fqCqM6T9Urq34d+t4XJWL7juypRHeTzSAF2qJnFr6ZIrR0hRo/WddiQYc1XmSxyYBdOMxKvJRXcf7f+Mav9QoPJyWtCPtg9zjyLMJfsLtc+uE+OsXxVZTQblyshkxOMJv10ZPtqTzYmw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1336C59B10F856B5BCDA2744CD940@DB6PR0801MB1336.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1336;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(346002)(39380400002)(366004)(396003)(39850400004)(199004)(189003)(86362001)(7696005)(6666003)(50466002)(230700001)(66066001)(8936002)(9686003)(61506002)(25786009)(55016002)(2486003)(386003)(81166006)(6506007)(8676002)(305945005)(52116002)(7416002)(186003)(26005)(68736007)(106356001)(55236004)(23676004)(16526019)(316002)(47776003)(76176011)(81156014)(7736002)(105586002)(33896004)(58126008)(39060400002)(103116003)(6636002)(2906002)(97736004)(478600001)(476003)(53936002)(3846002)(956004)(446003)(6116002)(486006)(11346002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1336;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzY7MjM6TTJuT0hHWWE0UnZQSWVUbDVneTh5VUl0?=
 =?utf-8?B?VUJrekRFbnBEeEluRTExMjFJZW5kS0JINlN4Sjg0ZVpEeUNQdEFhUzlZSGlX?=
 =?utf-8?B?UHBOb1FUZzloTC85dGZBN244L2lJaVEvdVFJUEUwTlZGc1JFZ3VhdThBTUpX?=
 =?utf-8?B?ZGhVMzNLRlFjaEdRVWdoc1U2UzBSMGRPb3kzU2U3RTlROWxrYU16Q1k2N1I0?=
 =?utf-8?B?Y2xwZlNNYmVjYk9FQ1U1OXlDT1pwc0V5ZWhjL2kveUp5dml4WndXa3BuQ3V0?=
 =?utf-8?B?aWNFYjh0b09oWnRzaTV6TTVvVmFOUGxCMFMza1dNa1dwMmFMQkVseFIvcHB4?=
 =?utf-8?B?ejFQOHkzUXZTeE1wbk5BbGV6eGR2RmJkWW1pUk9Za1Y2MERYUG14VHNxdXd0?=
 =?utf-8?B?aVBjaUllVWRNVWxLbzQ4dFptSTc5T1gzL0hKSldCRFM1K0xFTTRQNmw5ZGY2?=
 =?utf-8?B?RjBGUGxXY3AzM0x2L0ZFOTEzR0RGRjRvckJJR2cwQXhQajE3QXl4ZVpieVRx?=
 =?utf-8?B?aW9meTQ0ZU1wbWxHWStqVExzUGdVSVNuSVNZUEVmcnFwS0pTZXgyVUJrR3Rq?=
 =?utf-8?B?ZXU4VjVVOVZvT3VnMzVhUE5QSThzOXRsSXBWaUFnZ0hBL1ZwMFRiL0gvUUU3?=
 =?utf-8?B?MG5UdTFGNDlOU1BuOHZBdHNvaWlvVXpXb3E3TmlNQnlzOUU0RHpLa0RxeWMx?=
 =?utf-8?B?N2lSeG5SLyt1SCsybVkxS2o0WllPNS9BNjJNdEM1ZnY3VVFFeUNxcUk0RVov?=
 =?utf-8?B?Mzh5bHJiYk1QcmdOSTJaRWJQb1JtTTgyTmNGYkxqT1RORVU3Qy9kejVRcnBJ?=
 =?utf-8?B?NlhtZnQ2Q0s4U3BOQUYxWkQ3NHB1RUJjTHluNXRPby94TGMvOWI1cURNQ0tB?=
 =?utf-8?B?S1F3Yk01eUpYazNUUWRFNE9RcmN5eHRCcEJ2OXdiV0h3R2JGenQrSHplQ0Rv?=
 =?utf-8?B?OHh4ZDl3QjBOUzQxeHlUUnFrOTd0S2pCbGJOcXA5SjRYdzV1K3FTaFhtVTFE?=
 =?utf-8?B?MGJISHpzRWJBY3JXbTRZcjNZMExlNyt0MEpCc1Vyc0VJUlVoVmpRbEJveTNz?=
 =?utf-8?B?VDh5NDhIR1ppVEVzOHdTaGpGbmdXVGg3SmlDYjVnaDlMbDRhYlB6RGJvREJN?=
 =?utf-8?B?UU00L3JqKzc0TkZSbmVWckc4OXRkVFU0dDl1QWFSaUg3elE2Z3lXdllYeThx?=
 =?utf-8?B?WDVIbVZTbjZUSXMvaXVQWUdBMUlqRWVEL3BGQTYxMFBtaHZzZFQyWFZWMnVy?=
 =?utf-8?B?M2UxZ1d5aGNHUFVHMUpObEM5RmJUbFhJc3lCUUpkQ1ljc01CbW1IZ0xOOWw4?=
 =?utf-8?B?TmV0S25mdVpqQ0JwTk15ZTc1ckpGN2xKN0FHeEFaUHFYbHRUTDdpQlFWMUpw?=
 =?utf-8?B?dURNZXZLM2FCOThLUk9Jd0F5TjNkelQ1Z1l2WkZoRlJvSFZDNmlNSzgxVHFs?=
 =?utf-8?B?dkY1cjI1OEtjSXBtYlhwSy8za2ZidklDejFta2pGSkp4V1JzaGRzOVNhS3BH?=
 =?utf-8?B?cEZ6MUhXVHpWU3RjdFJZOWo5eDVqSDAwL1ozRm9SMzJvdjJkL1dodGlYNUpM?=
 =?utf-8?B?ckRYcFA0SjFSa2Nra3RuV2IwU2JOdTNVQklVMDhRWHY5Zll2RHV1SXJIT3ZT?=
 =?utf-8?B?anNzaEEyck1acXo2MHI4ejZvcHNpdGptWklYYmdTNnlZM012VENjRllqOXpj?=
 =?utf-8?B?ZkZwSWpOYnk4UFROWnU5WUJGU0E5NWdyYzQ3K1VYb1ZRaGYyK3Ura0s4QUk2?=
 =?utf-8?B?WkkxYlpUYktDNEh6OGR1QlQ3SUNvc2s1bXR6dzdmckJEQmlSOTd6WTdCUnFj?=
 =?utf-8?Q?NLjSESxasvMNG03?=
X-Microsoft-Antispam-Message-Info: cc9rvbJnNzdLuVhqnPzl2biINW5mgYZdq7Ee0jpGqLU3rFcj5AiFjSWIhA49L3J4kOycErc1rK5Us5UQ/7EUqjxNxEd9QXssYHTayFYLW1zNPB0qzq/Wgjj1xQ8NlfFWbhN/5Z+Yr4ITffgoPVEVYS5lQWM1NvUt3Lu31zaQrZ7j+66FdtHFrwF8iNcSRUtA
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;6:EVJXpNbJObIb0mF86ara6ziE+KtMTUanaUq4nTgrFvfl1ckSQx4VMrBwCQPsOh4ikJPhr6t2fPB46bMNG/QNwBDuyGmiIy3lF+87v/I4vKokqiNhtcSeLXhV34cxrLqIYpYUsWZCvG6AArEiQAFkl9b4mvFE1ywJbuU+Cd+TbPIgeZIMmSJjrI0/qReJ/vUYMa1mcaHRiFUadmR3geOkjUV7bWwhBMdTo8P7ENnhsvIbvJwV/usTWHazSJMt/5AVAH38SB/Pi0FS0JTthO0ycIJGXwARi39tsVLvniGdkD8iAADWZxble29HfL+jgL5VxAS+4qXWFl9NfTZdVJqV5w5Hf3pEpbHN96TRfTMG6NIZds1IXloWwoHkLKVZihm4eezAHE1qszcZiwncMkT8ExtPx3CKoB7bWKs7JyimxmNqcIy9D0NV0YZrZVG2LQ3lds2lr2uzYpwRHu0xPtYYXg==;5:3+p+nDKpcWk4K/Y7Oht0aebBGz/vL7blUxLGeCts27q9p/xRuj0IsIy3UZlq+BcaWPIRBLTxQ5iwsY7blJcb+fdrOukC2a9XiwzMMaN5tdHqvqS3a4QOBDnvESo4OQzTvyHkyudW5cAUGIdkeaE4H0YxwzoRtAw7jfw9hxpNTJw=;24:vChHIXkIPXpXY8B/t72tMd9Jauz9bzehr2JW0LlZGVEDMTnYVSor7++q6HEzUubm+7ujtyBhunjIo9CqCmRTcQi0KUupfQ/ktI8eJVwMvKI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1336;7:RUJLZifU0jbf0ENQr/h1XaZrk4v/zrgba2cNeTq0LdlxGf3fAmWly/UGGsLA6cBjAAs7jGizx7cfhVTLxkoYUkrOvaqxg5gCwDjWkpZQ5a5pCfMEMBu43d2pui8tl/2IeqGkU6xo9Ci0hHpMPwgkfHx8LkpFLBQaAxiOzhvESBlMkXskv4ldPSpDeF7YDYkMZ1xB3RlLKznE/32YMeHVWv1BzO2fZ/ISpJED5HB7ywPaJbpQ4KGPLBkiQ7W/5QHk;20:j1ho6nu8leyXtJUWUfjT/fd4E2jMYorzXs+8x5+ya1bwe+VdBIeaiSKhg7LOZZz8bdIaa5D94bc9WHDHbNKDVK5ibd5cxwp2JqyClvH1TOYfeTRgQ6NJUx82B7R0ABJqi+VP9a6+rohUxTr/RnoGN31U6FDsYijp9s89W93Q3Kg=
X-MS-Office365-Filtering-Correlation-Id: 790e6e3d-5465-4451-200c-08d5bfcbd2d4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:07:25.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e6e3d-5465-4451-200c-08d5bfcbd2d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1336
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two pairs of blocks of code are under
the same #ifdef #else #endif.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index d9c84c5bda1d..37d712924e56 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -30,17 +30,7 @@ static void list_lru_unregister(struct list_lru *lru)
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
 }
-#else
-static void list_lru_register(struct list_lru *lru)
-{
-}
-
-static void list_lru_unregister(struct list_lru *lru)
-{
-}
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	/*
@@ -90,6 +80,14 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 	return list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
 }
 #else
+static void list_lru_register(struct list_lru *lru)
+{
+}
+
+static void list_lru_unregister(struct list_lru *lru)
+{
+}
+
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
 	return false;
