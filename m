Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D00C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8C20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FJEMn3mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE8C20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeGIIhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:25 -0400
Received: from mail-eopbgr70135.outbound.protection.outlook.com ([40.107.7.135]:59568
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754492AbeGIIhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqVv87PGi3o8ACu51x9s+JbiDovG/hIovx0zbcUI4dI=;
 b=FJEMn3mo9oWob3Ddhn6WoEQIesPOVVD8SV9k3FJ740COERPDuVQ78qk+IpAkvtbP3M+9nTiBUqX8pLmxKmbSe10BriIx0qz8v/uDUxcbQhPfQIQD0f0ozEYT+ERCMxVeMnYvc56bBB0zQKZ8kmYRJ5ObUwdA+vS2Pxbal1NkGfo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 08:37:14 +0000
Subject: [PATCH v9 00/17] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
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
Date:   Mon, 09 Jul 2018 11:37:11 +0300
Message-ID: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P18901CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::33) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc5af85-aa4b-4a84-4ec9-08d5e5772df8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:QlvpA4zHNslkdhqWW6AsjCAQUM21BjSaO/ruyGmRc6hwMsfIlLdT6hzQjEM+BVOLHHwlfARYwzTcsQMZ5pe38q4xSENhCAQUPmHEhpCPk57MG3AgLav/0Lt2dQ+HT/WHwwnwG8V4432nUxuqEolc3DEbjsbOZClbpGIjvfOCYQzDqizDF6LiWjeSOJba/oabZR1eScpDlOCAUkvu0NaYPepEfYTjGGQWJSIKDVIlBMIwopN8zbc7hK8efHycIsv+;25:OgTUe7B2KXu5fd5LyMA3qP1JYxyY3RtVb9fikuQ3Dz1DeDyh8vQGLjJ3FZMx4NXnVmktKht+C9TkIHBe3ou2B3DdTU3eklxImDCCnP7nwJF5i0HcEoHxOxfYzYSHLKVk1n27JVtXeTAyJQh68QCNpHKayrIDRvJ1b6gge1g4qM75Rs7VqQi4aQ0BGrNyBx+KmvjhirNbl5lKt6CldDpycWj94XG928kLys87EKiX+RJWw3beGA3zJhfgEw0M2oYpBSil2TrEuZPb8zl1o2qz/R+ENfLI6N/OjMPHSVM/DiDfx373jCMcvVQ3IRoONw2PsxGiBmEzSe8cwKh7bsZ0jw==;31:01EuvRLT+RdebZ94/27KEQ6dgqMwmWboz/hVL6dIjRT6jPZOtT1XT0UvgYuNVy8uHG6ov82e5a4IXLSGCxAxbclQXC70iipXXSkdin15moekG85Rubut+c9zvh5mmU2+lxTkEVQ0SIjg5ZeyajgRHyUOE+z45torOiYrLvjiE1Q7LefbPDQAESSv7bu2kWMovhTMEsh7DruBL9IAEy2OfuDgfswv2WhMxMtVZ79JRn0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:ysxHuO9bRIziZFQjwaU3iYbycc9aJE5yjmhQQsuA/zaPLT6tv3udVTSwdbQHdlvBecmVO291Gsmwznbi9sbmtLjLCmqCmtn0iynhMVR6qppXe3as2SicTqas7uMPZVQaVcmcXxOyLsVv5+f0VWrupI1OA/DXT6IcBl7mlH0n6Bp13gemxPjz9wdZHLD5T2zFW777jfFsprVPFOC3xgI0yuc4mlmlDKS/OrA6TqQXvwRYKvzfo698lJDznJwgMUhPaLXuQTDtPaL2ebqWb4USELuo2mYvzJmllcU82zmu0HONOV9VbJaBuszTivB6zJg+s7Mvm7/po1zUQOV0SOEXiDTL4mQ9fFQZfpf7/dqKP9e8lKP+ELrmmcSwvqW+IdE3SgW9hC6qMBFKz8v2eyyh0SCgkBGRtY9ATYp3HQ0cDd/WMYpjayI3g76hilbaeOfBCD9sdAcpy5MX1jyZdg5QRNPaUTPm+BifIvwkuTVNdTe5ZtmUXaKcM7MB/vIDwM5w;4:emovIBPndzGuLBeK1Zvk3iUpX42L7UJ8KWt2sGjzdSK+VhbF/nWt/d/zX0RQ3XRamXfXpgLwnk7FuMJEComBMdlW3FOcNKw4YCPrILdPKt6YUsEraZN71GIZKJ70+IXlt8aZQGkJXDNMu7Af0fu3CjeHZvlnjRM1NqWNgXo31PODAR1Z+C9ZbOQV8w1BJgwfC8NkUdqjO5Q3NfAiW2A+DRO+MSPOBsrQ1aW21oSN303wTYn3Nsyl3dGeEesS55BqFFjmSqXrMPnBk9IG6PhlvrRFPZuj6QQjvBUUT8YHU7yYM4mWSv9aEVHLE52tIeAOqrBA+RTqAUfOb/0dguLtRRMLKa/gGloOJ5i3VBMAZpkKdcJXJk0uaByNHoZ1zIRqeE/D4bmaWwYXAE1DxMk3WuiUyLGGH2A2Z3sTrKqI0vQ=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344B9CB2B97A17AD5142DDACD440@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(136003)(346002)(39840400004)(376002)(189003)(199004)(2486003)(7416002)(5660300001)(52116002)(7696005)(106356001)(105586002)(7736002)(305945005)(2906002)(23676004)(68736007)(25786009)(86362001)(14444005)(58126008)(16526019)(186003)(97736004)(53936002)(6666003)(486006)(50466002)(39060400002)(386003)(6506007)(476003)(61506002)(26005)(956004)(33896004)(47776003)(66066001)(316002)(103116003)(9686003)(55016002)(230700001)(8936002)(81166006)(8676002)(81156014)(478600001)(3846002)(6116002)(921003)(81973001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6TnVUTEluS2hZRmJ2VWd3cXMxWWUrRHhC?=
 =?utf-8?B?bHNRYTdpOUZoSGRaY0dXSnNvRlI4SVR6REZjSW03KzNpWGVvaTNDQVlQY29P?=
 =?utf-8?B?WFhBdXN0WUcxTjdGSjV5NExhR0J6MDMwWVZoWUZrVURIeGtKbThxSTBQUTZw?=
 =?utf-8?B?eVhHekQxNnQxVFI4UjY0N05SRVN4N0xlQXBwLy9LMjVabzVWQ05ZbEFRMzhB?=
 =?utf-8?B?eXdjS2tUb2ZGYXlDcUIvclAyaGJkT1JEdmQzaFhiak9IYVpoS0tpU2Fhc000?=
 =?utf-8?B?QUh5YUNoR1g1QnBVVHMvYmV3aEduZWJHLzNyZlpheWg5Q1ZEcUl4MzN1ME9W?=
 =?utf-8?B?anA5cm5wRTh6NERIZ0dsaXJYcHV3UUlJSVVvSWR0QjlmRU9JZEg3MWIwN0JE?=
 =?utf-8?B?T0EyTjRoSWhIRWRhN0Zob1RQRE43dTI3bkJ0dHNXVmxnM20vL1Q4L0ZqK0Jt?=
 =?utf-8?B?L2JnU0J5K0NWMHU2WHZXMjZ5SGZKeEcyeWtKUDBpQW8xTXd5QVQ2eUhMUU9K?=
 =?utf-8?B?T0RJSlNvLzh2OG9MY2hYWlN6MjcyWmNuUmprUDFZL0dYYjkyanQ0MjloY2oy?=
 =?utf-8?B?b3pXaTVzWTRJek85TnFnQVgxZzQwRm5XTjdsT3N5U1Z2L0QxVmtOdVNmekhl?=
 =?utf-8?B?UC9XcWlUT2NVRmxza2s5cHpBZGFOckFsSFJBMzlaVnFMd1VaMXZjR2tVVW1I?=
 =?utf-8?B?RU1GdkZ3Sk5GNUozckc3b1lzVkVBQ244VVZ2d0FmQlVsRmluTlVNMjViMk9X?=
 =?utf-8?B?eStoMUwrVFdGUnFzdHY3UGY5WVNwWDBVWDRKZ2pTd0xuY1Ztdm1peFpqcHVm?=
 =?utf-8?B?aHpOd1cxMzVTenltTHRmWWVjS21yNTYxQlQ5dlkwdEU2QXpkNndOeEdVMVQ0?=
 =?utf-8?B?RXU5SHpCaHptYW9HK3VjTlUvVUk1VWFJYTdmbkVWTzhXQm9OeHlVYUhYdzFE?=
 =?utf-8?B?ZXdnWlNTVzhvc0Q4VUljZVF0NkRCQ1FmWUo5ZllzbGNIRGE3QkF0WUtjSjEy?=
 =?utf-8?B?NjhFdUdzVncrcTBkNytpTjk0YzJVMTJlNktGRWxVMU1aWDd0QlRyWVBMdlpl?=
 =?utf-8?B?cTdFMkR3Y0lYYlpHUFA4d2kxUzhYdmEzdWt1Nzh1MHJvQm1TKzNCQlZNc1FW?=
 =?utf-8?B?NnNPaks1d2lCTTJScjRBaWZ6RWVUd2Y1Ukozbmh2dllwKzFHMGo0QkI0YkN2?=
 =?utf-8?B?b2J3M1VValowSXZrMVpYU0VKZjJHak1CYWV5dXBNcUw5THhOc1BudGp4ZFRs?=
 =?utf-8?B?K291dlcwMVVTc0xVWkV6MzZMMDNRSEFscVhSUW04V1IwVU1ab2tNdXZWaEtp?=
 =?utf-8?B?N3pMejJHODI1T0w3T2xyK0ExbGF4RlRRY0pPU3o5UUcxMmdLR09RdGg3VmFE?=
 =?utf-8?B?MnFkZlpjNnlaLzdDOS9obXZwdzc1L09vdG5VSGFSczJHbHhPdDlmMDk2cmw2?=
 =?utf-8?B?bHdkVUcraW9VZWlLVUxOVFBTL1VTcjVWMkhWZEJRYTVnb0pHeGhSb21xWjA3?=
 =?utf-8?B?UXROc0pEZUtIUXpNYnZNdmlnd2JaQ0ZPQ1grUVRnWjFIQUFlY0ZXYUJhVTc4?=
 =?utf-8?B?NFd3Sy9hVXB3OERnbjBDM01YRnoxWmhISUlzdDkvdkszU094VUZabGVIMWk1?=
 =?utf-8?B?N1p6VHNKeUxiSzQxU3ozK2FYZFFISEg2ZW9QR3RvZjBUOEJodmVZdTZNNVJi?=
 =?utf-8?Q?La8dLZUhkBwkTxVh7m/c=3D?=
X-Microsoft-Antispam-Message-Info: K4fmznmj8VeIGmLzwyYczppOqp8kYamjnFgywoJJERnOolbSx6o+2chKq5atN3klG5TQ7mRt2KnV0+LIMyXkea2ItNoF+8PFAOP5a+PV9F5W7gPDZDYWpHlpL99YZS6wYfm/qdsGyQVd1oayuzahugX/zEYuxzt9kZT955OYk7TQO7PTrYJ6cDEoCQHvEVFc40MX7a9A29q56fpf3JiEsgz195BIzTcFnk4MnxxXVOqUru2m+L1rbTXNRqt2SfQo8Pbdf90LGqeNJWYMnEanlKWHxGdkAan+5FquEmb+U284XU1QfPKiBiu9sIGH+vSEXCK2TQirLj45/XX+fazms5+h4ioCkDAQjk3QzPWtNe8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:xsaXBY72oLFiFZ6eVkBw1ZqY7efuQNdqkbc2sZ/HXpv/k+3RFPMeF/LYzrLLblEVrokj6yZ+25+U41slYc0eToPYAq4u2NwxSE7etobABK55l8y3Rqh0ilitYcDGdkXRnwc00vj/+Kw1BZFev787JWBePF7ryiTw4yTAih8QcK2tt5IBErAX3ko4HmtvtTkCFGMtRXBUXKQKfIg6srw5xKMdx6DJRranWM4eDCyt5gJgIKs47im0jHEfDQtx4Yk+F44H302EFtBCwBM8sqxbhCatcAKIT/3d9cVV+qI+BgDPr78Lbyvp2aoEQQWhnkiRdl3pAWgt6+a3SsJ/zEtsd/rEomdKd+yjHJqte5jBdPWIWy50epCEO5zV/V3ZzJVif+BtRaPbRCLuQvSB/MhQA8xC61nCUhd1bBD7p+VukQ6LkgfB5YOTQ3YG2gBlOk6xpnRpdL2xjUslG5s3oHN81g==;5:k76fWkdyQBk2uH78re+6IVaJvSkK8NlZu/tqVAGAxtbePUWv1C0FpkydNQGSTgbQK8LOpFFX3aVt6zqyoHvI9dteTT8qlX/5/r8MmcyivQWhcRQbzjBA2KbmV34UX3+Ygz3KmagGp6HNulukwqLyV2Z4a8z2k+LmlY6P941wHvI=;24:1apsLVJONBA2fKmHxrmXSCEkVV4sAkG7Gu+4DJqpW6ktFm1q6BKJQY4ej1K+0ok95/1C4KsxCqTTTfTEcdjqjXjeuSuzI5hEoeYx6hPD0IA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:zTRC+Gwv13lBiRblZY3eaDg6uiBfL2XlSsGKSi6hfVsD3ewT6NQZVWEXsedE/B2uDrH9usJgsUShpKLtcQeWowvblP+m3yQA/Ust1deWRTuuyYExEyk0V9Vu3+CceCTu5YzQrnA/RE/Uff9yVYH/vF1rqKxj2IS3MYtb/maiUABU1L+pyEAJyL8pMIYRXj6DBXyMxnmKGNu45laul1JZ+v2DJTo3OyUacjjn7EBR2KXa1LNSpKrEflxZpQO9iIfE;20:wryKGUtX7kcbDycjiwQFd3h86BPSLxIcDR/bu5X30X4uPxjWY+PzDBbzeQJjlcdqN/l3Rs7CC1vVNI9vuIioqPBSascqgolT4FHC+O/wvdh3uc+iM2RHYteK3GDTyvYMqEq0f3DhzgRo79HetBlT6m6UfQDyBwlrreOgHnMG+nE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:37:14.9806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc5af85-aa4b-4a84-4ec9-08d5e5772df8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Vladimir, Shakeel, I didn't removed your signs since changes ]
[ are not signigicant. Please, say if they should not be here. ]

Hi,

this patches solves the problem with slow shrink_slab() occuring
on the machines having many shrinkers and memory cgroups (i.e.,
with many containers). The problem is complexity of shrink_slab()
is O(n^2) and it grows too fast with the growth of containers
numbers.

Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks are isolated, and they don't
touch foreign containers mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. The writer
consumes pages fast, but it's need to shrink_slab() before the reclaimer
reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`;
        do mkdir /sys/fs/cgroup/memory/ct/$i;
        echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
        mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
done

Then, let's see drop caches time (5 sequential calls):
$time echo 3 > /proc/sys/vm/drop_caches

0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU

Last four calls don't actually shrink something. So, the iterations
over slab shrinkers take 5.48 seconds. Not so good for scalability.

The patchset solves the problem by making shrink_slab() of O(n)
complexity. There are following functional actions:

1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap.
  (Also, there is a functionality to clear the bit, after
  last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

$time echo 3 > /proc/sys/vm/drop_caches

0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less
do_shrink_slab() calls.

v9: Uninline memcg_set_shrinker_bit().
    Add comment to prealloc_memcg_shrinker().
    Make memcg_expand_shrinker_maps() be called only
    in case of id >= shrinker_max.
    Allocate maps unsigned long aligned as found by KASAN.
    Reorder two hunks in prealloc_shrinker() and two hunks
    in free_prealloced_shrinker(), which may be related
    to KASAN-found use-after-free.

v8: REBASED on akpm tree of 20180703

v7: Refactorings and readability improvements.
    REBASED on 4.18-rc1

v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
    Use different functions for allocation and expanding map.
    Use new memcg_shrinker_map_size variable in memcontrol.c.
    Refactorings.

v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB

v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups

v3: Many changes requested in commentaries to v2:

1)rebase on prealloc_shrinker() code base
2)root_mem_cgroup is made out of memcg maps
3)rwsem replaced with shrinkers_nr_max_mutex
4)changes around assignment of shrinker id to list lru
5)everything renamed

v2: Many changes requested in commentaries to v1:

1)the code mostly moved to mm/memcontrol.c;
2)using IDR instead of array of shrinkers;
3)added a possibility to assign list_lru shrinker id
  at the time of shrinker registering;
4)reorginized locking and renamed functions and variables.

---

Kirill Tkhai (16):
      list_lru: Combine code under the same define
      mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
      mm: Assign id to every memcg-aware shrinker
      memcg: Move up for_each_mem_cgroup{,_tree} defines
      mm: Assign memcg-aware shrinkers bitmap to memcg
      mm: Refactoring in workingset_init()
      fs: Refactoring in alloc_super()
      From: Kirill Tkhai <ktkhai@virtuozzo.com>
      list_lru: Add memcg argument to list_lru_from_kmem()
      From: Kirill Tkhai <ktkhai@virtuozzo.com>
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Export mem_cgroup_is_root()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      From: Kirill Tkhai <ktkhai@virtuozzo.com>
      mm: Clear shrinker bit if there are no objects related to memcg

Vladimir Davydov (1):
      mm: Generalize shrink_slab() calls in shrink_node()


 fs/super.c                 |   11 ++
 include/linux/list_lru.h   |   18 ++--
 include/linux/memcontrol.h |   34 +++++++
 include/linux/sched.h      |    2 
 include/linux/shrinker.h   |   11 ++
 include/linux/slab.h       |    2 
 init/Kconfig               |    5 +
 mm/list_lru.c              |   90 ++++++++++++++-----
 mm/memcontrol.c            |  187 ++++++++++++++++++++++++++++++++++------
 mm/slab.h                  |    6 +
 mm/slab_common.c           |    8 +-
 mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |   11 ++
 13 files changed, 480 insertions(+), 109 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
