Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeEVKNF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:13:05 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:13824
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752420AbeEVKJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:09:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 11/17] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
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
Date: Tue, 22 May 2018 13:09:14 +0300
Message-ID: <152698375421.3393.10030992972653234848.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:209:15::21) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:k5G5APMV9HC8sDr+Qu38sY55RC9WjTYoHjIebaUSCpAL40+nqyvv8Db3PE1nPhu3QsdxQP5cab8koxgyY3wSHA6HsV8iJlqw+/UiKZvrHLIZQCggTwPOFLI7xSNSey5lCj8m5WHMIxV0r+jelEJPIsb2aiNJPIjQO/FUDzA3O4oYew0u+GU8nCgFIJJq3APBUeCbRY+hUpQ/bre643vgIv6D9c5LXdhOr2I1qnJ/wwlfKUBPg6zjR4zPv6CQoq59;25:+uerYGswRTOrk7vedGXNLtdD75cHlib9+BX68b2l1aHDQBb1QCYAYcMQDAGvJWwoNc7+AZ8Okr7qLTz+hHYOb9qucfswWHB3icIYaKAyr62KMdvKbEviq0VS1uIMb4hM4PPhg0+K+wCAE5F/vwabNw0v+yzJOP9ZCjLsGp5m/m+mOBiXSUAekug+Z2SKsJtkOg2yRIxmnmW9Vegl2wW1uqnEB6twWIGaPwK6nAkllJgl4knjSjD3Trw6ZB7ABm8NjOZ9sGYMoS/8p958HhdeqIIxX0cXF4eHKF/M4mlfJjWfTCtaM5vNo/2g7QMVcZRN5iMBDjhaQp5xzAcsmJ+c/g==;31:hGnGVpslIj2VzZNrZUmcREcptqGrdwzSDvMw9A8ibJ405Yo5LMx5sTLLE4CItxMJar66ZoRRIvFw2RnnkezMtCYz6I5WOb71ir/HSh1o5xEtohHy4xslP1ZnLMiy+9TNUywa+Vlb15YBg+Ad5/ZqIVZxO7s8CU46wyGQlmHBMmVnhVZe5VPL85ba99WKDa0BsZOtgWmBV/PW1N9+89VOadIGRrmNyfPnpe8dPJZ07XE=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:gqSwj46u60S31fK1lJG1yOXcUXcx/eRg0YsYId0bH7SmBZ+nK9/2t4qwvhmYKOUPXPRLZODdgXkvnnW+MJg1DF+KF4jSlvqb2k3px64F+YhW6Dk+FopAD4ARKIsa7UcnoaQAUGIREHZVGf+XVFpiw9MeInvOQsmHyA+MFqOii4hvyLpWYg7QwFJXx0kWjTU0MWriFLtcmr67bVv4KjW4SsREPJIXfjCSN9Hbmks9BQ5Qh/b3C7XryxQW7BuM/Or8vt6ZeSWzZ1s8+Ib9CTi2Gj0kxYtRk9M9Tu5iMNUpw2i23/54hw4+t1p/m37jTUFlMqryn+vgt6+2imOPIgchGUQmFctOtyu5ZA392Z3IIyFZhmFybIBKq2NeW4o0YpSz9DLs+x5+eNiozcAR8xilnDNNNmG8baI/AXSRgoY6kS5WGFIHszSr7L5YRAaO+GT9LvMja8p2gRixeyNO4Rz1lmHS3y7dOfgbTTJbDsEEbRuD030gXqnW/xtzBPHozAxV;4:58qjTH6EslMu5OmgBENyiTE7sJTqQd4dSy+OvUtmRQnQVQMdNjf61ZgwXWUgGbBdJ0WMtf+Yact0TdDKa35GD6pE7W2CUOjd6mpFktXTJxrx6+VWsqudqwELFBOmNMnYpGrdIcT9Wq0ptwwx4zxQhwjmHiUoqSDHbpJNU3sKmIXIIyZZchHFmDrACNVzIBRYUCPv++SWI8a35DZdB4ZjhJ0+f9XFZYKETwXyRC2sektXzJbSnuAOXsHnasE4fKRp7gWeW+AMpEwOHzU5Rh+o9A==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13313176F64131C2EEAD9150CD940@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(346002)(39380400002)(396003)(39850400004)(199004)(189003)(97736004)(186003)(106356001)(9686003)(2486003)(52116002)(7696005)(68736007)(23676004)(2906002)(33896004)(5660300001)(486006)(50466002)(386003)(6506007)(76176011)(59450400001)(61506002)(16526019)(47776003)(7416002)(55236004)(26005)(66066001)(86362001)(55016002)(6116002)(8676002)(81166006)(81156014)(39060400002)(476003)(11346002)(53936002)(316002)(25786009)(3846002)(6636002)(103116003)(956004)(8936002)(7736002)(446003)(105586002)(305945005)(478600001)(230700001)(58126008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6SHpwb05PM091Q21EMVJ3VTVLNDV1QzFi?=
 =?utf-8?B?NHRRTVBaWUgxVjNZTVhmZEhnWVdKaVZ3WHZmOHd5SmxsZlBYcEdpeWZnZVNU?=
 =?utf-8?B?cE9Qby9XMEI2ZDUxSUdMSUFHK3RjRSszZGNtYTFGQ2JYajg1WFRYNjBjZlN6?=
 =?utf-8?B?N3N4OWRTTWpnMnNuV2h5Y1hQZUNBVytwd01CZDlrSlIzSDZUandkYUlteDU3?=
 =?utf-8?B?LzYwOVlObmlWaFUvam1IN1A5V0Vyc1oxYzdjUTJoVk5lTEJaRjltWHN3WnhZ?=
 =?utf-8?B?UGVMVjJOV05iUCt5QVVDR0hkMzBESjlmTzk1VzhoNUhqY1p3N3VoRllLb3l3?=
 =?utf-8?B?Z3AyeC9tQnN3dTZhM3JrYXlXTEVscUZ2MEFuZXVEcWtBMUIyMGZndjRsQUo4?=
 =?utf-8?B?S3pLZFlqYnphcVY0N0tXc2ZJYmI1dnBESnZRTisyaExQOUx3Y2x3WE41Lzdh?=
 =?utf-8?B?ZVBBZENqKzRUR2VXelJqWDBxazByWUFKS051dFhxTDNWM1ZSU1RKeTdyTU9Q?=
 =?utf-8?B?Z0lsQU53cno2Uys1aEdhcXUyQzNtN2x1clo0ZkZDNVRXL2ZpaDd5RWsyTHF3?=
 =?utf-8?B?a1poZmxOY0NlcFZNRlNLV3VPMk9lK3FleTU4YnR1MEhRdVlJVWsxWGFqRkhF?=
 =?utf-8?B?NjVzeFFzZ295dHBHQnJyUTRUMXdEUExDamM5VXhyelI1TkVSdTFhL0J1WUsz?=
 =?utf-8?B?aHVNek0waGxFQ1AvVXVLRVl0QU5XRWVjaFowOVhsbnprYml6S24yK1QxV2Zz?=
 =?utf-8?B?dHVUanl2b2tDUm03MDJaTXdtS20rR0ZBc01xdzhFb1hXTURCdklQZEJUM3BD?=
 =?utf-8?B?Um42a0FHYXk1Si9aNk9nZmdqb1FaQ1RWYUM2WG4vb3VteTl1UDZRSmttL2xY?=
 =?utf-8?B?aFY0WFIyU3dHNHhxcVNCWU14VlZ0YmE2OXZlVUd4Z3BhTE82TGVUOFBISG1i?=
 =?utf-8?B?Q1lYZWFZTjRySnczZEpwRHhSSzBaTmtWMVhtNHFua2J0VHNrWC9vRi9oN2Zu?=
 =?utf-8?B?YjJrSXpmRlRvUHFpVmg2Yk1vMHZQb0dBU1JUaVhWS1gzdHUyb2M3ZlZRVW1I?=
 =?utf-8?B?eGNzSVBYNTNpRlNEZ21nY0xpaUg1anpraTIwcnBNVGJncTgwbmh0STdWZWRr?=
 =?utf-8?B?aGtoREY5WjRiWHpSZ2tobWJ4aU9xdTdYb0grSldveDdaZ1I3TkNDOWFWUjFm?=
 =?utf-8?B?clFFbjExeldRUDB6WnBkekVSYlROVEs2ZDVQU3hIbnVoVjFqejJLa1hobUEx?=
 =?utf-8?B?RnFYV0xjdTIraHc1ZG9UNkJFQVpCeDUyck9SQkNaemdJelQ2RVFvc2NGZ2pu?=
 =?utf-8?B?cTJXV0o5eHlKV2c1M3M0dzBXeWsvQ29DYW1Ib3F1WEovN0lOczhQRkVmcFU2?=
 =?utf-8?B?UlJYZXFsYTEyYVhLdkxCN2UxT3B1b0Vja2NFRUcwNEJ6a2YrMUZ6TUQzMlA3?=
 =?utf-8?B?N2FqMi9vQXlDTEM2bG0vV2ZCU3BuWlIyQ2ZqYVZ5U2w4MnBGN2FRdVFQdkk4?=
 =?utf-8?B?dHFyKytSMURIaHc1a3RPMVFxa0VoQlFuejR1VFlzejhuRGI1NUg1b0FwVUdj?=
 =?utf-8?B?K2U2SjRYUFZiTFdvaVVRREczQitVQlNlc3VLZ2FFYTR3SmxPamxoeGxHMTNw?=
 =?utf-8?B?OHF3K1VCK3dIc284eVhuLzJ5UmZYRFVNZ2VWYm00bWhKTEtMOUJyc1ZvMnEw?=
 =?utf-8?B?YzJCMXdJL2N4U2tpQU5TNDNtNkRGNDg2dlZid3BpTXd5L2RXbW01YkQwRm9J?=
 =?utf-8?B?M3psMkREKzBDM0pSa3ZpYUdDMFpmMW5TNDNXVmx5dFNsQTBKOW16eGN5YVpE?=
 =?utf-8?Q?/6O+xtu8osQVrE5?=
X-Microsoft-Antispam-Message-Info: VKRS6HDwvaxuJEeSlZYcHUBOJhY+he5DTrXuNN4+gGyeiI2QI456vcMtjamQGUGZElZXayf5jfbotO9HmkvJbAwSw99+CaM1URXgULKL3ovegD/YX2aexOGlB9c1XYkv+rLwvbFtlLL/MZxl9LyxeKifdv3wIII+BmRxDFB8NseR9JPLtXJA7+qe/czKC/SB
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:Rz6I8ePnnzvwRQ+e/87k8jDjpPMpIk7aqo+fyOtJXyDLdasES3JgXOgj7FMUUtSBhpRNqEzNRKbizGKAD/Tuvr4s83kOjyNkN1msvOCBI1uRvvBsYq/UbGEosgR4rKCp5oFNW4O4EBSYOHoiwUlgdpoelxESZibqAA8TtQ1iWdnoSB3xODQWvUXMx7FKmK+NMLdemEAAtqAMn/N8uPM8IMtCMzX16yrE3X8eeNwvtIjnGjh3ttNe2QDsnLEFIGeCcjZ+54UdBKp6YSHbPCYQnSrp4BtCHDG69NmTKB0kT9CA+PASsg45/plUyIQ1U3ANRMuvEFVS67ndPLWvfcEdMdFtyxz/nYsYm2jjVSSpgdAyhnAegZ2n0xZ/H0QLpYLeUkFNN0S3xKovCr8878CKHvZrag3S+Kh44B7agl/mXduAqOx6KmJ1c4nFZs5FgZGr/RV5K4aKfp0wy3GF+Xq79g==;5:SNrvEpdsgLy+F7LhqZu3k2eVAbt1hJ0JdBhgbNDd/ispbF4v5viHMiGFyltQfDjdmnNQm9czy8JyH9NTi+Zh+FVNOh3SLcoqwe4VxFXW4hOlap5DuA6yiPBGjD5iG8qD4fjE+B3MszkHxN9DHUssAVu/XaLEt1LP/K5kEwc0Frc=;24:hJor+K15jt1Ir90ZFrZnn4CraqG3PXhveIpTmF+uLAd9g9cFCaP4XSbyO/UaOexpyPqG4MXqab9Vic6k9Tdjr8pKa0kjTjR2KjGHvO+N9S0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:58jFfg4sg54Pc4VrMvzC+vJHTCzfZR6hBWSIHEvX2C/wweFJVMlXbpEKVn26RDyA/qlsfCD8DX3oLYIasgvkaxaE2qdJANiLLqw8PJooBZSLE5d0piEcHAjyV7MjQlGzer8AK04c+V9Io3Hj7MPhQpmIS9ChdrvUW4uYUrFMavRNJoHsvekrUQyM3xbMJ0V5q5x5Rrk9Oxa30UkVoVORRa1goIvGEM5Uau6povrMft0y0/EXUrInJeyJcbAoTHbN;20:GbLPYZz83oK2UjV0cGhnN44VXP2ZN0ggb5AS/nT7E6I5dxBT8ffg05WEV1kDAr+WJ1JNbAi3nWHunOh87SH7Q9lmeH6RW+4W7W1+kXRuthxELsskTY8osGGXC74xWQjC8ePRRhs6lZ0nqKJN7MRNXcvnLNK2kHIWkCHFPoBKVf0=
X-MS-Office365-Filtering-Correlation-Id: 19a6446a-3080-40e3-554d-08d5bfcc145d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:09:16.0242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a6446a-3080-40e3-554d-08d5bfcc145d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 43cbec52a48a..cab8fad7f7e2 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -514,9 +514,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -545,7 +546,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
