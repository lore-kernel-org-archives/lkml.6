Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZq7YU1y2fg86b1itMaaYe4ziQDl78pUmBdu8XijpkqiiqX9G/slxMcG5P48bYLTkp14PahF
ARC-Seal: i=1; a=rsa-sha256; t=1525867096; cv=none;
        d=google.com; s=arc-20160816;
        b=pjGG/jlWdoE8hVeKqfx5CaL9BDbC+RLpOOhDsFDkcZWsUaJ9wvgf/uxw2l3QIQwvbM
         6Qahs0p/40AYlnnJTKSrIeZz7j9dYlUiO0kfRSMJeI5OAmyETRHjw5yA7wrVf/D5+pa+
         SH6wmzhaTK1Rcx5cntzZ2NO7FeYiOUO1LT4j1cm8ahFLEmRdDoMtdlw+8S6NLvi3OeB8
         zBleAzmKMX7Cktd6LEcWkyFDKeelyT/ytV1GPgpQuPiobK0NFW3zc64f47fguTNBQzrk
         vMLwYAYx9udM+Ha7lE7RVIMjqpN3DWf4RQZ7idIJQmv53PWz0u7UZs/jl/DFcvA55zAR
         SJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=y4f/Z84jgesPAzDt/+MgepyFhKOeCdLWUl4AZVB3hvw=;
        b=vPh8RXmHCmddeRbwef4jBPJdUHi6G3TrAMCp4/PJbeiYOZ80eHFlN15UdPc0fRS8+q
         RQZB8odSDytKe6ngSQjzj+rtLYD+P2/5CDuv8VmaRwIW5tWH4LHuv/lIroAhUQew3h5r
         2uxwI/egRb9+M/ePxJprsYSlc26DHkl1Sdttak0skbC8QAfpVIw1YDyT2u8zXLBZt2cL
         qQDYdFRHa3gu4oE9kBGt6pgDc6kv4LIBJ+B/M3Rwc9NnKgNoTTo4KdyXBx7XRCwAEpM9
         cA0cvU9NbUBoCMi9yanSZdHkimlp78LT1xrDlOUvreefOb32+DHP7CCiCGyU97chUEdj
         +plA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DdBxG5kY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.118 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=DdBxG5kY;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.118 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 08/13] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
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
Date: Wed, 09 May 2018 14:58:08 +0300
Message-ID: <152586708816.3048.6939581936417857559.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::29) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:V2mRCtpVkf3k4LdV4mrOW9H6HK7XilOxkGtTdYCBMj/sB42IpukGtsbydDEm+CVoxY6l/AklfhziyevPJfHl0TZ80qtafQeaVQnxNlEpL79BE1onWenm+KoRwsAWAXREAoOKd3YeLNUg7JHkYQeMqcjW3UVnt2YNQt2Eu0mVngdc9AGVWqbkz3TfBBgTI36iNdFBAuvR07AzZZUVgL1V4PSqOxO2qjbDRfReYS8gLpmMD7IkLlvPKZTJx10kIcBx;25:G0y/36dGcfeGeEBNxULNnIA6IL0uXDaYZCz2ebZk2umVeYhy2pTMWJ5l7oUsF/FoT0E2W/ZhYhMlDJ7ZhPwOHFS5gOKrY/xTDO4e8WXKwnB6cJFxrqBNxDO4arUo1mQNu8O0wmGOf/odP85z3kDnfoSQGVZkAKkYDNodPVOTcC0541dmxuLDq/6ZzZ/92CR3RwWNXnj2+1L1bAHpLqiwPWYn3IbJZGh9wL6rgRatu22DBe3GD8SzM7UevCQI5jdHCG9wWsYkGSCbL1dL7JHpPdwCXaPEUZFp041uopjbvaUzrsWIL4phQ9xHrwpdPVEdWb9PxvZxQpdyiWqATslUEA==;31:7IZvNhE13+m5162gXaLjVxR2QTyKfzyhiq/hhh8jO1/8/nsMVQQdbW7DhP9Xzu9APIqMEKvVcg9duzbva4Eeb5SEKezJ7mc4CooYqHH81oSdQVlbPmrw+a7eqfuhKaxZHFbqu867+SqP/s087NBTcW5bj+Jie4s7eWoWCihfhqFlvYL6PhLpCxrtZ70Sv0RGxarWt+eCSfNQ12Vc8moJVqohAO15OjoM9JUuqDvUqGo=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:cHPzIYZIB/REt6A1ycAu37f+LKDpwvRFR27STj+jpAdNy95i9lQO0cnyokeq3k0arBrDaO+GRdkgsUbjeijPFK1hWcKjqMMzr+G40qjndxFyxjunEvnpOlkoO9zshneW+6sQNtn9kFvBEkJdoWrzezfJrFljzk0zZ2f/V8Zu6/YQ4Dr7QgjCBJg2X5zxDKsUcLiZJqkEgdSRZaHUhwakb4hOJkzmYyI7bvb5G2ftCuCaCu8h8uvQ/Q12gWiCQFCQhKmnbAsbcAl3AAB8PaeBXQas9jvdjM+TXEgFwr1xbvpuyhmRcZ3ZjFaDtsyqnzK1FAh7bgZdQP9MHl0Ka4rf8Hf6U/iavnRLT72Ax/iRkobHp3tbb2fpDxN9gZ1/N8ecWH63Y1ZiY22/ATEzPqLGiG+4R0vKkoopfXPgtLl1/trdR0oh4C4pp3A7/s+LgNiDHLmgE+Q/q1F5rXa94d/rTZR59hixb0bdsD4Xr500zBuUT563i0OmN+3snmOOlRA4;4:kay8DRgHGioQdRheITHvDFAC1QGj9gajwGdmP/IzxWRMttfrmZRkpzgfdZ8NJaImVSvS0KJ70/isujh45gQZybxWojuYoA4sIWd/5HqoyG7QYUd3G6OZj6mKQHd2GCweubtScPryJ9C2aLhqOC/m+LWa2+9Ndo0+e1/8QcsN9sZ4bSua0A21plolrDfuwEoXs1E4bfqz7aYuZHYOElFtO5Bwo5SQ2hoTBGchd9iqD8P/df/qnNH4KA+EsvDdhmg5WLtPHMUkylL5GI/0ZjOKgQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133594FA1F8C0F87E52022BBCD990@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(39850400004)(366004)(346002)(376002)(199004)(189003)(52116002)(486006)(26005)(59450400001)(55236004)(476003)(86362001)(386003)(2486003)(446003)(61506002)(7696005)(6506007)(5660300001)(58126008)(23676004)(16526019)(105586002)(316002)(11346002)(956004)(53936002)(66066001)(47776003)(7736002)(33896004)(9686003)(76176011)(55016002)(39060400002)(3846002)(8676002)(50466002)(478600001)(97736004)(6116002)(2906002)(8936002)(230700001)(186003)(103116003)(305945005)(106356001)(25786009)(7416002)(81166006)(68736007)(81156014)(6636002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6ZmNuUUZQMmY5VmszaHZ3VjU1TExqaGhw?=
 =?utf-8?B?a0Z2a05zbWxURmM1S1Y2UGo0dkRJYW1sdEt5UEJYREQ0SXIzdUlvVldWdVM5?=
 =?utf-8?B?eXovQTRZak5uSDl6Szd5Sjh5UVVjc3VvMXBLUEdTanFoUGRZSEVXZ2tiNTlD?=
 =?utf-8?B?eWpKWjRpTVJ4aU13WVJ2WnlrR1BGRGZuNkdzS1d1WCtSRENzVkNGeXQxRm1l?=
 =?utf-8?B?dHJQLzFhT0c0dDRQTStUcWdTYnFCQUVkeVhicVVMdHRNakZvSmFET2xxeVpv?=
 =?utf-8?B?Q3lqK2l0SXBQakNoRmxzU2dsYVcxSGdLM1M1d2oxUjNjWFdpMGlacFRhRnkw?=
 =?utf-8?B?NExrU1YwUVlBem5nQUpETjNTRGJFZm9XWTk3NlV2YUJBSGpPNk5SdHF0ejhk?=
 =?utf-8?B?R3Qvb3ZkSkVTMGQ1REhEZkszOERpK2h0cHUxSExDYUs3WURmOXFHM0paVG5i?=
 =?utf-8?B?alRsU3ZJZlBuU2ZuZUdOYVpLQUJoWTRSWEQvQU9PbHFJaGNuYWlna0RYT29T?=
 =?utf-8?B?K3FhVDJmaVlHYWkwRUFZcmIyUkZuTmVLbk84TG51SWY3bGFPU3AvUHJXY01Q?=
 =?utf-8?B?TUFCSW5zSVp2R0ptTEdDeFV1WEpOUHpPNW9Yazh5ZnAwL2R5UXRpRVkrY0hB?=
 =?utf-8?B?b2lhKzIrZWIyQUJybFZUdUt6MHNVOXlONFVuTnM0OElLc3FXRmhrTExyaWl3?=
 =?utf-8?B?RzZmQVc4SHBOMW4xTXprVFNZbFYwNWVxdUl5UWFpdTMvWnRpeFBCL2FBcG5O?=
 =?utf-8?B?VCsrN3ExSUVXNUI1aDQxNFRKRmF0QzJpamM3ZmRnZ0hGWXJDWVJyYVZ2ZGtK?=
 =?utf-8?B?cVhMRFdla01oeWtWNWxKczBzc2lTYVZwWVBkWnNySU94cUVkZTFSMUxYRi9N?=
 =?utf-8?B?RjQ1bjNJMy9wS2dWMHc2dytDWUNIcXBhUDYxY25Vb0x2SnZHQjVNR1VHb2lr?=
 =?utf-8?B?UUp3QUhUc25FdVFJY2JGM2NMeHpnWWZQRFNYazNsckpXYm1lQmxDR0lXSTk3?=
 =?utf-8?B?cU5WTGZoY0FkTnIwaUZmeVEzTXh0ZnZ6S09uTVk3VDZiYWZDeGdqV045OHMr?=
 =?utf-8?B?MFAwRjhrUEdLeWhQQUJEeGpNUGFIVk1ac2Y2NzlwdW00V09zOHJxdjhIaThi?=
 =?utf-8?B?MlY1ZGpURXFrbDcrQzFwT0x3VVJUQWJMdXhoRWt3WWJmRGdBekV0ZnRBTDc4?=
 =?utf-8?B?SER3bG5PbHBhNitZbmZJbWlQQlNLN1lUQVpCRGplbW4zUHRqUW5MYnlEeVhY?=
 =?utf-8?B?K01Mc2ZtdzExZ0ExYkRRR3A4K3NkeTlraXVqYVlDUndvT0ZtQkw4NGdseWw2?=
 =?utf-8?B?eSsvb2lqc25rS0t0c1hGWm9GSDRvM05BdXVnQkFVb2ZOWDNZVytRejF0UkVt?=
 =?utf-8?B?SWVmMjBSQzl1eXpWQXNsbGVtem1xRi8wSEFuVmVrUG85R0dqS2pRUWZWUVZk?=
 =?utf-8?B?a2ErTSt3OXZhN0FEcnAxR0U2eTJ6ZWwyc2o4VkZXSHN0ei9yNVJpUldGUERX?=
 =?utf-8?B?amlYT3FWLzZ5NTMzaWI2cFZYUVhOa0hxcy8zQXVHVXZDbTUwcHZlRlVnaFRk?=
 =?utf-8?B?dk5VSTVFUGRoREs1LzV6MENrWUREYTV1TWNEVTZMV1ZkWWltVnU1YXlKZ21D?=
 =?utf-8?B?VjJ4YkRLM2RsUzllRUt3bExHd05yWDh6OTZzdTVucElPek00RUt3S1pFRCs4?=
 =?utf-8?B?dS9yQXlzN2ZONnRPUVlaSE1UdXdOc1FZQnlONUx3bmFwS0YxNzBhWlE0SGI5?=
 =?utf-8?B?WEQwUWt6Um1mQk16Y1BBWTR1TmxicE1TK3hwKzNoSzA0WE9Gd0xTN2ZVM1dF?=
 =?utf-8?Q?RcLMHQ5EyPw0FRB?=
X-Microsoft-Antispam-Message-Info: 9MlKecd7imyY5VOGg9BBhVHshNNXMNl5p2dOTrXIhDH5uGgnHxm9M5LkeuWzM6dySg8/jkF6mDmDGQo6xep+5wbiCnOfk1mVoZ3RfjOsOBqX01IOfA5nuJJIZBDOYDfutO8TmfWPa/7UGs36j2J+GH39k9mv1XV/Uat6YxW/zvRXPPsQd2T8AEvnxGSUMU/Z
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:aSdKgSFHezlY5qa1GrsYnBtZ05c1rtxzJKzeInoNWNSJezH4EP4VaJzhIe4mDvPN1ntr/kS3KGEkf35YiabvV50AkI1VvnYgZm9kRRMukFiYr4XEJXNJCbtDMna52G2u+7q8glX/Qq+wVgo/K0TwSZMNkVgzBPgYRFQml6IhCAiaUMZMDqVt7t9jif/iZUctl+XpiQFTwU0mThE0QMaspoyNInEMMjXA75+KzSFK7+ysTdf5qtwY7Y+SwJVS2dcPs0fHq1I6uNU4eNTP5BJMWE4h2dDDdqruQ46cIVhF1YKqGyig9XdH/ytGjoG2xYV+U/Lqz+Gp2fcHmlikWR5IeJINJPXbXkVVNh1pAU+Dv6CjD0G01/sIpX3paEFrRrr19JXTljBRWegZa97v1+dLzSO7qGh3JXHqPoI6btP7/ncydLMApONI3HF1Vz6ImjlO76wIh4BH/B8pc1mYNLw5sw==;5:gyPAeb03u3fWrEPqHsww5svcPTpGYcUVaWAP49Hvm03pba4yMe08E0khuC6gyeSpwPDLiyXsWq10RHpuPLHEsb1nQXGMA6mhQgB86trOKMv45pZAPolRLHLcgUvs5vqVn9yZ9aIXGC3jse/jyN2X0c5vJ57TdJTwnSg303aNmMo=;24:SKDdLn+QN4Pb+CPXwjR9pDUPfhlZfvVJZeAwnWUpsVR6miUsScZlVqXAHAVQER2t8YicTEX0YyVP/Tx6F+B8v7vLUalMTvlse/ZVtr3aEc0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:v8cAz4HfVkoajPL+Rb44bdxb8YpB4rGcXzed/q4MAmJLDaYO3zVB7o8rbcZYk70wahmRB/i/FcRUyEJEty1SVzJTz6vWXNPu6lktHwnW+iEiV6cLVNWTPHE4E7CSw8Vkye44CByMITnXMC7kGg0AS5rTk7BVbrPL4r7ywGz0zDjfSUbd/9TtJlLb8TBJabHi4Z6t7+fGLb5KYcj5np45ViOB+V2sz/cG8sfJuSdbadaYOXR7lKRLZKIf/clGts24;20:78oFqEzUjj+tfbNPSmHXmDDHGcg+JTnUL6K5saU23EbHUr5610NbXmrRvI4BdaFsgL+hdSjtzXDdTnVpJFGCTlR6Q3jd6UCWDUtCl3rHWiy8OOGQ6dy57kb85PDjfU1mggGgZXUzqXiBCschFcxY2LR74pGc6TEAGZMrk+76Q44=
X-MS-Office365-Filtering-Correlation-Id: d4bb0f61-a2ee-4a49-ffc9-08d5b5a423e7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:10.3994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bb0f61-a2ee-4a49-ffc9-08d5b5a423e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987615941125984?=
X-GMAIL-MSGID: =?utf-8?q?1599987615941125984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
dst_memcg pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h |    2 +-
 mm/list_lru.c            |   11 ++++++-----
 mm/memcontrol.c          |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index f5b6bb7a8670..5c7db0022ce6 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -66,7 +66,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
+void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 437f854eac44..a92850bc209f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -517,8 +517,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -538,7 +539,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -546,16 +547,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
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
index 7b224a76ac68..494cefd29590 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3171,7 +3171,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
