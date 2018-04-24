Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqD/exryyx5WPjdfPdA+KWDRzd/nySajTVFA8zuWTx/q1ViaVCDiQmMcnE6vi+SjIz82WRR
ARC-Seal: i=1; a=rsa-sha256; t=1524572017; cv=none;
        d=google.com; s=arc-20160816;
        b=EPZrymfEpefGz1bpz/ao8QmhOEQ/NJjbPRmEDvPPpynUH8a5AWiFbtzLkQyKEGWpq/
         3lkBisgAzh87L3/kLGOE8uh7LZqtlU3iqYBdBAEKrvBTfXBzO2d/2fmKm7HPE7d6gNcg
         O+teIagECDVxjTjquPKQ0Rpnbmu/31eNOidKei1PmSG8C1yyQSM4OQE4k4GLuH43g+cx
         gV/T3EiREWVi2I2qfn87O2KcPiRKTCvfjxciwr54KAbX8RyeuvLLZhjkRu0hGv/mUuyg
         u8cvl4sZfxjySqEH28csLEiLeHthzjaVQikKnyIklKE0FXO6WQYCijr+MsYuMTwEQvUL
         87lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=hhBFLBnohMGhGb4cYbW7Sp8Rca/H6Qg3nxcF8SZ7TdM=;
        b=o0Y1LsdQwIMdLTLHQDX6FBQnqB6Y4XOG4DLQxTO0LLRCVjVUKjJ3fcBE9aybbCQ3ZB
         eDKf7TB45K7EBjXE16oeO5Mw0o+U1ckr9ctqtycttyURT2bvKTH1pP34VJw9LQ41GzKy
         j5Zv/kA93kToJUvXAJXlotzxG8X+cIJaaDsGP1xnMub4fSvPpZNpwUJK5Z0FYTRzwZTJ
         wL9c601Pn06/VdAqJcZ7aeCLfyphpi6q9j3sdOqF79yALX6PLLPym//cuOmoLhXktcG2
         8ETcoAP1n3K2hR8i54+dgbHzzBbM17AYxyLPUPyX6imY6zST1eB9JLUQD6Md0Xuyw1ih
         00rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=NXgwoxRM;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.120 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=NXgwoxRM;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.120 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v3 09/14] list_lru: Pass dst_memcg argument to
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
Date: Tue, 24 Apr 2018 15:13:28 +0300
Message-ID: <152457200853.22533.8257755183687614696.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0345.eurprd05.prod.outlook.com
 (2603:10a6:7:92::40) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:tIeHTfCy5YxbR38rHaZb+rHwsuRa/Z1wHs3UY+CfhNvuQhDRASZydUAQtwv+TSq2K1rKgc2mUrvYoO/Ve3TaCngJAwdFOiLq11N5BGiYMIRXvs1vmB9HmoLcwhS8uNUyxIGly/B2864AHshLOg9VU+9IBAzlcj4GxqJ+CpRBO6pjlA1ITVKhk6z08rTthg3NNJXIPmBWZO6Z0nS9RYoEnqLar8yCpeAxr7qiR/VDCZOqBhHlqmHLk9+uzeY9AjDQ;25:T+zjb04ZCdLZMOwDxVsAnMkzwUY39kEeo7owJA96o6w02PumCU1cmvsOxc0EPDj28Htr8h+WakqdZAjLj/kRVcy7bsN5DFPz9G7pezRtbMt7uutHUr+Rs2JZd4krBCKMpG3cVkUf0t1kwFTc+9gr154T+qi0wGk3PRrhx5Uxw1Jm6UYtsealxrGxxoBwoyeqVljKgyDD8f8YEl5rWATqR7pthD2wgkyPzUN5LQg50/zHxaKBusfTnhVi/XnTcxf9ZI2uzI8pCU9fxoBthARXEzu2kPZy60zFA68nQnjd58/pnjFbsJiZ618bfgM7vanDv7x0PDZdP4cSV7h7mgoCuQ==;31:7eDS0qcKhO+46DY9HCL7i09ivuM+QzOLgnhiZGPmsJCVAChqx9KLLwjMNRUG5OR3MV0yTN1qtqr+poZk5naa3m94/0YquONthSByRFYWbgFN/txvewfiqFMaxAVRe3DJpJnlcRl/9vlBxU898rHB7aEgQTK6XtW1mvYFctHw2Fi+cl029goQd0LXTXD9JZVOjSS928QjiPaDagLl7MyuMrXFJzMaJVEwsLi9xTrC7C0=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:JiAomJpFPs1PKwQIzYqFRuvl/X6f6+esfguPw30RpnBquuP9phmpp1MKwyBdg675USBbH1K/HD8htvbAryTYn0GiLLqZnMIkc23C2sXAnufPPZCFWlPRDpccIMl05nq/oNqsZw0Hl88hMXxAV/HstpZDzmhOttMV5G4tw/clzTvgx2sa+fa3wymIk3TlqRFpW/3LUYQoXNfsE/kpnQ7HiaIz8qwq2vjgLvZ+bSVsyNsF8UnnY8E6MH99czPRagSr3SmIzOAFCSG4yUEWTRqIqu7TXl2APKb5KG5VAIT2qZCDDqOdjACO6+eODci4aeizN/6YqeNTpOPm//MIeWlITUZ3ywRa3B0wDj+V+2RfQyqevetolchhaB3G2RPww4U5VLfKZd4jUL3ZxgiIRfB4Jhu2IYDt1F0HU+mEBI3NRDt+jxftTokwGXyvZNtzzWZgk39r+BuKcInzOOLIMq9CUeHH8VZbZCCP6gotAcJE3HSswzI3dc8MLTHLrnXzBOmZ;4:F9PN6l7sZpKAM7SDJVAblfyjqpBSH8l21vMQpFJwt81ie5PSqWSNMWjLggmmzNbvAxaeWh9WknMXNoc7fsqfxqyGdFfiVUodOXcdYSuGc3EXMNBtyDuUPf28gVcXn7BCvR9NpdhZ9fp5hdfvZ8Up0FT2nZTw1lPJN74uCnkB1C2a3mGiYk9CEymwWcgDP/Lv+h4GPbjFm8cbx/7w0YgR7exnanEjr8NjW+5u2bw3jJyjnwtnUpsT4HxzIhFndG6kYm5517e0KXEOfq5Bw9k9nQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1334BFE6EF6F299C2FE4D425CD880@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(366004)(396003)(346002)(39850400004)(376002)(189003)(199004)(76176011)(33896004)(81156014)(7696005)(52116002)(81166006)(8676002)(2486003)(8936002)(103116003)(476003)(9686003)(230700001)(53936002)(446003)(11346002)(39060400002)(23676004)(6116002)(956004)(55016002)(3846002)(97736004)(55236004)(105586002)(61506002)(6506007)(59450400001)(7416002)(386003)(25786009)(68736007)(50466002)(47776003)(106356001)(305945005)(7736002)(2906002)(58126008)(6636002)(6666003)(16526019)(26005)(86362001)(486006)(186003)(316002)(5660300001)(478600001)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6Z2NydVdQUWxVOTd6dE5PZW1kVmVmYlgx?=
 =?utf-8?B?MmFNSytEREJjVnRxY3Y5anIrVVZPNlp3Qmc2dGxxRmgzLzZ2U1RadUl6Vmg3?=
 =?utf-8?B?a3hpRkdZdlRRSVRwTmQzaVFxT0ovc3A3M0ViSWc5SU4yRnZWVytQL3lycGli?=
 =?utf-8?B?MTc0cXd1Mis5RnZ4RHN2VUE2MXJIN0ZVMjJ4WVBwbHlpL2hSM09rZmovQWUy?=
 =?utf-8?B?Z0FTNnJyU2NvL3FnakU0dnFxakVwQ0ZqRmVFQUovRmkzZkFjeTl3MkppaHJo?=
 =?utf-8?B?K3V4YytjV25mSWNhME9RN3FsUXBkMDFnTHFYb2hjZTZlNHQ0UHkzRDdHQXV6?=
 =?utf-8?B?YVd4d3huT0lJQmNQdEdnZWpWU0czTnVyaG1OcHNEYURBbkVQN3d5djc5N01L?=
 =?utf-8?B?ZTl2dU5mdjh4M3RHVy9qc2UrcU5EdWV3aEZMb0xqd2pFeXl5R2tuajQvNTR5?=
 =?utf-8?B?a0xKWWZ0UVNzdzhnVkU5VDB1NFYrZ1ZQbVh4MHRmN2ticlVNbmZrS04zU2NH?=
 =?utf-8?B?NjJqNmFZZWpUdi8vWVBPN2RFT1dkdkpDY2Y5ajhUTlFVUGJVeFMvTTIvUVJ6?=
 =?utf-8?B?RVgzRTM4Q0dPQTNnMU9HY081cW5RSm1XOWFjNTNrR05QcjRWbnBFV2JpQ3ZH?=
 =?utf-8?B?NTc2VUJYUUh1d01naGh0MnF4ZXhScnNGYXFQby84ZkRaZ2VlNzY2RXJVUEpl?=
 =?utf-8?B?TWlGUlVRcmNFTHgwNUZPVUtScmVxdWdOZkJzUjVFYzlDa3Y1cjVoMzk0OTNm?=
 =?utf-8?B?MjVadjQvYnpQanliT3M3Z2Y1cUpLUVhYUE9xL0NUWkNKdURMQ1ZqcGVyVWY0?=
 =?utf-8?B?Nlp0clU0bURvYnM3RzdGcHFFOG1ycjczZUpQQis4eW9sT2Z2RytuMlkyMTRP?=
 =?utf-8?B?YTZ4TXRpZ0VvaVM1TlRFNkd1ejVMRDBoMXZYMzBIendoeHRFb0JwSHlDS2tX?=
 =?utf-8?B?MGFqMkJYdzBCSTJiZ3JRYTJDM3FUUGRCNlg0TnordWFlYUVTb1k5cmsxcVVj?=
 =?utf-8?B?NTBFVVpHNGQ1TG9GNEdBaUhRb0dBQXpOZkFBT3MwZ08vSGVCVzB4QUhqZ1Z4?=
 =?utf-8?B?UDR2QlkybldpTGhLU2ZqZDJlVDE2OEorSzdEN3JOM29BTVhnbUZYY3pHaG83?=
 =?utf-8?B?YytoQXJtS3pnVkJoMFAwSTlLbmpVbFFaanNnQks2eEErYkNxNENXNkdEYUZG?=
 =?utf-8?B?S0M1TjFRajByOXZ0NzQzQno0KzRyUVV0L3ZrSUhzY3d2QlJqckpuWlB4Zjlv?=
 =?utf-8?B?bWNkWHA2SHFKZFhLR2tqZUdwTlJHOFlPT3J5VkJGbzlibi9uV2xoN0JiT1Bz?=
 =?utf-8?B?YXZKSnMrVTBIcnJ5QU5jN3lNRk42SE9OZUZLdVN0NFp1QnlHTTlQRlBFeWNI?=
 =?utf-8?B?eVJIZ25TTmxyaXRrYkIxT2JVN05hY2tBQyt4ZXVoTFFadm95OFE3NW9EN1FL?=
 =?utf-8?B?bWJSWE9LTDNsdkN2OXNtYU83Y2dUWDdoNEF3dUJCMko4NGdtMUlPNmZ2ZjN5?=
 =?utf-8?B?akhmVllVSkZnTmtoWm9PVDdka0RPWjhJM1hIT1VyZkFTTWQwMlFkQXVvRExC?=
 =?utf-8?B?NzBpRDdQSTVSS2pQQzMvZ1NlcFpyejR1R09iTHpTRWZxWWtOc3B4TTZPRStv?=
 =?utf-8?B?d2RNVk9FSlNaSERnTFdvd2V4OGlpenhqUG15WnZ6NnlHZU5CV0hZY1pxYTk0?=
 =?utf-8?B?S29GaG5OdG9YMHpVVklMdmVYZ2JETENsbzRUS2RRWGxUKy9JY3JPaGt3MGxx?=
 =?utf-8?B?YzhvMHBIL2FXSE5DalBDWmY3SWlxemVmVG1uSnQya3NlOUUyMk5iOTFkNVgv?=
 =?utf-8?B?dmJmanNyQU9EeGpodW1sbTh0VEljOFFYc3NlZ3JVSFNNekxXQT09?=
X-Microsoft-Antispam-Message-Info: vnnlOR9RP+9yOJSFk8JbpyrHdwnQ0SDh96FdvitC5cZbAB8qb7NqNPARuqp3f6QdkrKM6aYGApL4/h7zd4mLO5aoZUy703yq1FTqq9+kxO8bCZQsXVdSTHnmjN+KstF9cFpiBSc8fM/yOJ4u6/ff60StQK3l3Ze6SEuowmZrtVJu/slTTNpsIpXoFlCyV4EZ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:JAn024eJDFgODvnd5c1BfXfDQp0ykiWJFDTYUtY1opSDDvns18rmzSZ4OwVL60Aa67O0d2u7Js+03kgIGwde9ZRpEMGhPBGKq1qMEu448ZPy7Kp4tquZT2ZZN11N869UKAUYRjyVqkhbd6oxrW9sUOheZchCTUCDfC35F9jiyUAoRUpMX8avoGs2nUF4StIJl8CBH/PchSuxXjXFYCJnVYiyIYI0cahL7giYv/p7AFOdS+juk08cS2TLwAuVuiSW/mP9fnHdSw/bZLC0ACpv3DzjNLxqk4ZV/lc/HvILnATEKUkVLRGwm9pNCvI2TIPLBVaAjeE+c+l/jpUpby/JShmSH6Yft5NuzKyxJ4AVd5Ew/E1ELIHXZALotZED6PXY6/HfT0QArpgfH1ab0E/4yF79PGwYDcqe38K9yW7TG4aVgHcSHDAsHhrb0WvHOAaZCnRxrv/BCJHJRfs7FcowlQ==;5:FMSuGyO1ftySD4tgc9wQZdRNpwWJ6RhIqTjMwSfxvEWaIn21zoa3kuSCDzDIp9dswxaC8E3oAjLto/zp8BfLI+OfnUdy+T/W1U4XuAHE4WBSSHvO8EWR76S9uMHOej3CcjYwUjsEyFwFlJ/KSnoBJyGiOvGWRdOQaN6VFHEQbBo=;24:9oXpva2yejYdzHrce20jYnQJt2v2M7w6bNVBJkSnJCs7/0HesP369o9kPjmLxABXmpufmulcz3WV6TbbEQMrCe4grzX/v+icnMTJhFOrADs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:V1NP+1fOSCTSE2h1c7k7QZ1llQFO7aJ+2DvKFmrZWsBw3zfc6O0J3d+biJOvhiDXtNpSO4SE1m+kIJLLJ6vcKVWsJHf2AdemcGs17FdXQXYhvXGURq7ktpw4j2PVOV8PvQp8EMVqSTR+ttTmVYO9EPmHTYskp8EUC+0pNar51JmvcjU5j4N8WI7wDXO772W5ZoX7TM18tFGiQ1A93z7wzHOol1pAZd7LQDBGK71x43e2Wfb9Iwgasi4FWu5VmrIg;20:cjdQfRwhXyWJjU+jrmItNIga9koBIFg0xee7Gv4OtAPU/pcQxhfdzsbCbBEd5vbe5Y8yhu1TO/MaZ8P4Xi4Ximh572ASO0zp/d1KLxKiowSUW0qxEXi0Zdt+UGmmR7b7hP6yP0M+YXP/sxqnvNpTStzzFQCXxT6LotDfxlbnvog=
X-MS-Office365-Filtering-Correlation-Id: 4da151cc-8240-4038-79db-08d5a9dccd3b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:13:32.2512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da151cc-8240-4038-79db-08d5a9dccd3b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629627740922766?=
X-GMAIL-MSGID: =?utf-8?q?1598629627740922766?=
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
index 76fe156066ce..8b8ec7c9fbc1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3174,7 +3174,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
