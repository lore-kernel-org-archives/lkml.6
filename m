Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71B4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC2E21A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G6nRZhsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC2E21A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeGCPKX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:10:23 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com ([40.107.4.94]:16468
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932520AbeGCPKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu9B15txEFQWygGPR2dvHAEIHPzPVk93OAcbqCw/1Rg=;
 b=G6nRZhsKdDM5qk9aeJ344nMaYUb4c6/gVrKxBhcybHMuT+w6At8WmyHwSugMLSnI3OGcJdELYbAT7E/qjUm9h0VfG2Y/h0F3kuQy+pDvXCxI5PylajA0UDD5B5f4QOWxjfsSC+n0YJZFLKXOynAm42R5aM3ecCIpWz6t46CjTJU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 15:10:10 +0000
Subject: [PATCH v8 09/17] list_lru: Add memcg argument to
 list_lru_from_kmem()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Tue, 03 Jul 2018 18:10:06 +0300
Message-ID: <153063060664.1818.9541345386733498582.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0010.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::20)
 To VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1bd7428-50b5-4e09-947a-08d5e0f71409
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:YHY5MCXCoeV+IU+6jJ8PRHCr83lND+hN3jMOizMWnw8wijBibf+HFtkF8gmSBHr3zlPCP2vHrdNu7ZS6DWl0AhXsUeShB3RPY2D17YvvDhF5RlfDNbNvAzYFL0VTy83z9sf5vDZ5vckntyWegVtQPyYKzW6d31HE6Hs7xb7nWDQd+Lltn51vAcU59NxJGeW12NzNdxYLKl9XSi0PK+zUTUTFO6171x27jiiZ/m9oCewlVU5i5GfV9fS0/oBOGZzB;25:kGYNetBT0fZCss/74WKlBKiLM2EdA/or6SgWwrKYLtw0Yfx00H8FjL0FGfHm4vuTcMRXRsytOoXvb2sj4LqSh+f7/8/JqUONi7emk6LNIx4GL1fKs74dZXbMyyJDQ/bTnd3wDUcti/pWJdBDkrWdu4fjnxLq+M4JejU2BUo9g21cS1XIo18Xx6A8uLB9u3Tc7Qvp9p91LjQgwi1Rk+VPVpCzRGcBK0MOE87fIadNCmrV4LO1G7qWn2pNIvLLS+F7wsYyCvfixxhdLBwzfrZ3FSG1LcA4bnP5ZxRV49YtDlj2EHNUauO0GaJ3cmrqALyTOOcHbvY5A/Yj2KtYFkMY2g==;31:/zsAwKrNPRpbEgo5irDwT6ai1bjb53XZ3x4MSQxVxnb/ASRk7OsK4BODwBr91MxXv2NlnjQm7c+CzRKxVjZg8cZhJUopiPoP6+pZFgrGtPvtr526Q522zI82/5cq4k0Eu+uwAZjVjtVlFx021YIAb3kTEF37WzpnksIK+axQIrslSZnZjtLesov2cMsQ9DQDubU7kGmdQY2OOQdVd58iidgndscPCNGoy8/DiwPS6v0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:hX87/CtZgCXuG6xhe08gBHlEc6wRUKdr6SbWWQJwmpqiRPcE2qFAkfuI1UozQj0/ZlhqDC5Xc5SsO7nZ8HnBxbZmWJzDnarHFN/NuTk3W37Fqb1FJTXM1r/H1g8y3hUh9qZUcb83YQ2w6gY1wjAXuvnIenqGIKWmb04si0ZjJqDCP87uSk9vczAbpMLInhxD5cKMRZxuOA05CphP7sTYn/K5JQQObLpQL0fwNh+r6dgwalxouZONtQAF3OmrTadRjCopHwbFVBP3R4QlP/9h3aeeaosiLyonNzgAGqiCwBmyBgHxC+AUM/+J08yUKLOvrqolfK+nTjBX87vfi/28sW1DKrdFxUH3RMxSLsM1fGR4j293n1lmyaTXyC8b+hXSO5xl86tJPKlg73XSAFCvqT3BXqNtkS88P5I3Q5C74rtPZr/sCyV+Rrm8+BSmh8o8pdkofQ9TkFAofxVNFxV04ACXAzz5rZO/+T4akaKWai15H+wAGWcvTRMPqhAfMlYQ;4:in4M5VzTBuVK6OL+ttfAPvRSMbkVRyoyDWoSDOjqD5Ru+yRyIYZeCIHj/cIA1KRjR3POImKlUWGTix+2Gv6mScB0we7TVQTqbT6MH2Mpk8EQDfFpOrM2d/jIvIZtImtOaJQQy9rI+irjRqLycjDmpSotXpCwwBM4A22+HcGHp6b0q3UYzRWCcCP3tKqwQ2ssHi3359VpuQPzM57iDyhyT7OVaUJv+UhJkIebh5+yNTBQgfKoWyAKsKFzL9CnyBs6u7UfnpE0K34oay9ZEyjQ/53dMGN8boGHLnAVyWHIPwoPIkon6utR0ZZjI15TwmNEJHSr5vyqzn/8yiGcsBPHTr0lrlx/JD3JIEYxjEg6IFs2dAyYU5HH7VdNSofe5P/0
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134476935CCF5204FFB1528FCD420@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(136003)(346002)(39850400004)(396003)(189003)(199004)(476003)(7416002)(11346002)(446003)(486006)(316002)(47776003)(186003)(386003)(66066001)(68736007)(956004)(53936002)(6506007)(103116003)(6666003)(25786009)(97736004)(14444005)(5660300001)(26005)(86362001)(58126008)(16526019)(6116002)(105586002)(39060400002)(76176011)(52116002)(9686003)(61506002)(7696005)(106356001)(23676004)(2486003)(55016002)(478600001)(7736002)(33896004)(230700001)(81166006)(81156014)(8676002)(2906002)(3846002)(50466002)(8936002)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6cVFYTzdScjdpYjAvQloxMHZVOEpqS3lK?=
 =?utf-8?B?amppRVRWU3lzUUZFWGZYTWVJNDNoemtHeHFsdVIzdE1PVi9KZDJsc2FMSWJZ?=
 =?utf-8?B?enB1aC8vRlBmVkN3UHl5aHNTMFVYRTRycEQvdVpQSmlOS285S2NuUS82bkZs?=
 =?utf-8?B?ZG03SmFVUGk2Mk81djNiQ0c2RWFOeEtMZG1rSkxCSlBmVWs3OWE0Nkp1NjE0?=
 =?utf-8?B?aGl3ZTBTazRvenJ3eHBXRmJXQkpzSHN4OWltNVo4RXgvUlRRL3J5WEt4ekly?=
 =?utf-8?B?QzJEb2tFOG1XVkh3Z3Z4NllkWXd3ajFGL3ZoR3k2SGhwazQ1TTh6c0lJYkc0?=
 =?utf-8?B?ZVRlbTFPUlhQeWJVUExxMkgyMzVqc1VXNDdKQ1FCZ3BxMUhPOU00S3h2ZVlq?=
 =?utf-8?B?SEVWNy8vbGpMRnd2SFRsbm9rYkJmVmNOMEdzUUJQME8vWmhkNnFiZHd3RTdl?=
 =?utf-8?B?aU9SaHh6TjVZNDdEVFk0ZXFEYjMzWmM1dHBsUnhCc1l5cUF5M1NiZmV5aDdI?=
 =?utf-8?B?TTJXUCthemZ5WGl3ajlDNFhibno2MUZnbTA0TlVmY2RuUVNSNi9yRjNCVlBt?=
 =?utf-8?B?SVRXSEcySDA2cG5GYzZ0ZFllYXFUM1kvTFZsTnZNMlZoL3F0T1laNUMzQnJu?=
 =?utf-8?B?Ky9WSU82UFZiaEwzckVUazk4WmZMN1hneGNsZVJ5YjEyQmFXaGpTbTVLQWI3?=
 =?utf-8?B?WjJGOGc5YytxWnMvSkwxdFJPeVhYVXlxM1dRQkVQa1VoT0JKOVJUVFJ4VnZt?=
 =?utf-8?B?SlNGNXdlNTZjSG1iN0ZZWXlCUllnTHdiWUd4TXpDWVFVTkRKdS9CSU5TN28v?=
 =?utf-8?B?eWF5YzN2anBQVFFkWnZjTkJKb3FBcWpET1BpbkluWmRuOElmcElxVHJLMkFW?=
 =?utf-8?B?UnZ6Q2IvR0w5TVIzTkdVZjBhaXVrR1lXa1IzQTllb3hBOEdTcXB6dElLbDZQ?=
 =?utf-8?B?ZTBLWm0yMkxLak9lVW90OCtFbWJ4QlJ4N1dzL2ZDUmJWVmJHeGdUZ0RJekFX?=
 =?utf-8?B?VnpJdTBSU3hraVNzYUdaT1BOaGlsYlRZajRYc2FCTllMa3pyZUpnckFRTGlR?=
 =?utf-8?B?S1Jtem5ERW1UVHJ1Y3lRbFFUaWRjOVFSeTdrUHVpZVVpNkU2d3paeitYKzlU?=
 =?utf-8?B?c1BWWGNBWlBOYXJUSjBiYnFFbXdvYXFTYWtHdjBiWGVUcW9oeTExelZWcVVG?=
 =?utf-8?B?RzFCM0hER0NwTGRFZ1RMQmYvZ2tVTkpINTdGYTdUMG1JdnF3cFdzNXdEMVVQ?=
 =?utf-8?B?eG1UN1Foam43R2NoTk1rWXRBT3VkWnlmWnl6MHdFVjBXRVNQZmFkcTlNcVpa?=
 =?utf-8?B?dnpIRjR5cDVvYmIrY2dnQWJDMEpTYnhhcHY3OWtGcVE3STg4eUZ0OCtGOU1w?=
 =?utf-8?B?cUJjN2VNWm5SM2VIYlE0NHJ2RjB1VDlRNlBoeUZrRFBTQlVKZzlqejhYNUNQ?=
 =?utf-8?B?S09QY1JNNStyZjBweSsxZnF4NzdkT3V0RzFMZk9SVk5wZ3ZOOU9JWmpEbW9x?=
 =?utf-8?B?Wkt0QXliUkZ6L0w1Q01pZW5adnVHeFNKWTJvUXVJWDMzR2RMejlHalp3UFlY?=
 =?utf-8?B?N3k5a0tzZ0pYOGpsS01CVGV5MWJGc0xEell1cXdMQVdoN01ZcWtWTkRQOXBF?=
 =?utf-8?B?cFh3YzRiWXhudTVtKzhNSnkyYmpmcThtV29lLzhnRWw5aUtqWFY3K0tadFZV?=
 =?utf-8?B?S3Ryb0drd0pnbXZ3WnBHcjZ4VnBwRHVpalNSRGpmeFZaYStoTmUwL2RJZE9K?=
 =?utf-8?B?SkdyYkx5eWljNEJEelM0NnBnPT0=?=
X-Microsoft-Antispam-Message-Info: Jb1L02YsrLsMTpeK/g9UPP3m4plddf1EVnCb5UxhPlTC55c0BVOTdGfev2Q78Dq7A6qjhv6UfYW2GpudZKnm+LOfaz4l0lL1ziWbyBqVQQizfezdu8ybEYQsKjyyhmU61n8pg3oCWAoWGaJeMLcGLdaRuPfWOJEjmWDgLOUnGLIF963lzSorG3nFizyx9//zwp555rg8qGKBCB/RsamdMjnuWY9y3LwChUH3qGdxVdnPYmSZ4XY6zE4f/SBkc7BK+aCc/IokhPJZI+qlYhoRKIBn+zqMlDsLGCwplS7pJlrjlfJwo6W7M93a09bHrQA8sdc23y1toNmolGB3ma3Y0SPJpFhETeVnnZtx4zZPkkk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:63UKbqYA8VZpsD6DsLeAOJHsU77PNdmAivsb6OQdhrAxdWQgrrItx8GGkWfSzipT0fAzzberTYLhpyRYzPnq/FTPItvOVOsy1hYfjHmwe27e6U2or6DJ5sDyW7v1FJHNzbHjTl5dcWJ5lLGXiH9Eqp/7d4yvblf4rCXPrC6cdWyWghgQSQ1mm3Jy7BSStW6EIIIKyrXf68pww9KT74MASkjTHaC4oKXOHiCkV4geWDMgtraT0vtwhd+ms1OYuc/XAeJOT6XjwSRWJKjObd8f9xJgJLZkq+eL34XfxfHCRhAP1iAHZIu2im+tjGv5mVH/O6LC2r9G6HhB4H6jbxFJdbCsXs3/k92Uz/OZ6dgCsqNvfinby7Npr5Nhe97IkjSl/jC+yRghkLFNfoA8aT2qUu/4Rq9YUvuESn9BKYpQ/A6xvYhJML+GBlBi83w6DV4CEPt4582sWg+AtGIObJc2Og==;5:b+z7RGCXZUmSYw5QcwEJ+GaXVudz8S9YD0Muyo9SjcFGlSSfavmMevxPuM9JhimckUcGpQFNJjEnyed0a38sARQfpF8kIzRF8frjNmN0sDGf7x5IztXJNCjZXJ81HvlPYOGMAMzP5tIhojzGgYr2Joah6zjm3I3XwvrrebRiPiA=;24:SR87t3jiZd6WbYia7epHjWLCjSFDtHES9J4+SZGH7pBvYwY3JXbVjQJ3G4kuF7+0VbS6bnxyxfhCVFl22pPZbCcnP0cjw/hoe6PSgjsP7VU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:6We+DI0Z68xtbIFC4tJE0uVdQmF6LyBvuwIIquhFpWBuAIK8/XJbId+Q3+nS+aQ5FirbMIei/oNkZThZZPQIMjgg6XxRhofe/en3VcyDLIL+448O0YHQsheeOvwFlYt3rwvQhHp0Mq0KM4KyccnqBznX27GmpQOHkHuBZXk/e6RCbzNr1IVVhVfo4cDZY7WrQ4tX+bxVbGvuI1Ga+AhufdHL8pmhzhyyFG2UvB0fF33E31SwpIwvX8vyP8hOzkdl;20:k721ttnDUPgND++mf4TX1i5RV32/w+MTSFAMME1UiLuyVMrouDgSYf2EYbbL+O8h/T+4/0T40mYtmA1X7seND0+MoFpEBP/ZXBG7T4TAroanewpjc6TpEmJUJ3X9KrC/wLZacwN4/0zz7sQSQAtJ2x427CYpFnwNFNn7p5yK7cQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:10:10.9882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd7428-50b5-4e09-947a-08d5e0f71409
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/list_lru.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index f8ae4a04ef36..016c7d3924e4 100644
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

