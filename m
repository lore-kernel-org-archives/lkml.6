Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELu/6ch94YCXPl1oO0cMmsQOLR+d8fOLaUKbQthW1Zb/VUXYyazKSUDLf8FXP+3oNbIVHpQV
ARC-Seal: i=1; a=rsa-sha256; t=1521638544; cv=none;
        d=google.com; s=arc-20160816;
        b=B/1vobILpF3GyXVosLNn9zYaUcOG9dsg59ePlxBOutDSLJXyAuwo3VDjvrFdrJqPa1
         1MtCRtOLMpTcc6VXjaZ6l290jlQ5Ay0VqxmN3KXaZ90V9rlSAQvTvg/TDbW5TRsfCFns
         FDYAXmYjdUVnqqK2pUCQX8OGmsQo+yujRtwtP1CDsF4rC2l78sjnuLrA6hBwq8FXbN8G
         IwSifzTJfyqyUSf8+e2uO3Z7olDGx2mhZeUSq3w8wxrXhQ3Ckiqw1I55QYUBHm8mjRqz
         CCsQYL2ATnUs0IMHMYmMEDlfaDssnHx9GRsHBbpFY0Ko/64dJIO7rk7cGVL3iVVvd6ys
         5dQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=I0RrTgbQG0HTbM/UuxPhcYhyU7G0ALl069DmO220hYY=;
        b=zKADK7+4QuDxZaT5cXvuBgh7D/iMFm1TPI+pcvAR5eIlRTuWiLoyzhLd9C3Y84mkBt
         lsiAdaYH+1yJKm1s2Et515PNUW5WTXS7crj35HTT/ImYI4H7kyXjQsaJFIaV5DMcYM2K
         Bna35kzbTxbBA69FQFE54huc0MpDWf6zhYo02nh1PDmz706yJmQxniblHbcZOaw4pWoE
         zdtzdFfzmo6OUZACq1RZeeP9s3QatCh1q90LkmJ5+xDeLyBYjgsjOKDPyvPhpSLKT3WS
         ZRHa45N0htvRJwgXBXYjM9Yjp1qctyvQWrM2TCj4e9bRMKf5joCc6T2SToEF5JMzasYc
         BlCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hlEceePV;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=hlEceePV;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 06/10] list_lru: Pass dst_memcg argument to
 memcg_drain_list_lru_node()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, ktkhai@virtuozzo.com, akpm@linux-foundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
Date: Wed, 21 Mar 2018 16:22:10 +0300
Message-ID: <152163853059.21546.940468208501917585.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6P193CA0007.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::17)
 To VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3098e6b8-6dc9-47ad-acbd-08d58f2ec59a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:gHbWEapbZ3T+YO14f6sPSyNeRQsppcQMrgvIRk8i2UwOYI7cYSqeu40MbZZVOgy3SOvtfeO96RSQe9PWHi2kX4EjkfqxLZ7fmrslrrvUJqugEp5KwK+klb8x5ZmyU3gqDXyL3QdXXADrjMTLBGP2WnPpVTHPb4alsxlTkxe15gEwJvLChEnil+BT4pSjuX5a+spkGkhbJU5blct0hMWeh4/qmEWbArpfyc9+WTWeEiRNSwRKSLs5lTzHIo8rCdgr;25:PuwmUUAfpUyNr3Y4e7LNLJggrZ7gLWR2emJLzLrms3bEaoSHgmKXjK4lOwOwPy6JmB+jjqcvJxZYQEq9oAZ16pX6PMHb18ac3XT622LJ+Sgp1IvXfFJoiVzdTwxsVg2I4iDaMq834K7H1iY9JuUCtvlkFa9suqqyrB6Sj4sH6sh5l5EWcFn7Q/L1rEx68kdQDYQi6+paLlNN0Hv7qGZEdQFTYTVA1Zy2ze4/9D1+UpJURAiHYWLC9JuR4tpZ/X9ZOxQBQ5C/j9Mcz8NjWOfvK9QHQtGIFjND6pFoYORSc1GRXulPunlWRzGdTKciV/ynF66mK3CYdKpCHpN/PRAiww==;31:xLbMTA79U8g+BdIu1AfEgpn7iBQPJiTgwxW0LsMdIZRU+UnGDlZA1N5Nib+++A3ZwCl7bhI+eHzeRWLdjClZdNOqVb1DJ3/BwcoOKvQKluy5ymdp5kFj/t2cQHGA9sHTvXgwbF6ihRiOTPoLAWng3C4FkiLq+1G7ST7uB84Wx1SizmUz2dS4CvoUhsyVHhIvKNMrsKqPB2nq+F/xfO8B14DgfcI7tdggxf9R6zdUoSM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:NDgTyccwvE1jGezpg0w7yvAwqJ16bTOJ+T8oqWZQza1Eb6HCxldnGMOT08/PA8e05mx44Noy+Ajnr4KCvBVI1R3N/8NZYXjPSyWkGm0gv+9YIG9wVnI19GL5fQhAFm2mwntbsYvg1li0+NgV5U56b4iN6p0BNXvgID4RXb7wgTFGTxf+7mizx5ej5/R+Y8wdRpfrFlQpy/PdGBQh00m9GZ/a+iTFXYgWtuUobTMD0WAfx6yXiRw6X/8mL+EmTqJRRF9nG5OkZgpMDaaDdD86B3WbgMgUTBzS70Ot0hkN0kww+PwifzKXRbnKHGwtjlWrunyrN2ogj4verglf7zfdnwUZfw9eZ2KLHULiwcY6R1Peup2UBOK1lRFGNpTol0bJUONhvH/rIJni4LpVGZcHTiRXiSBbWiutbT5YM6xZswmI3Nf/g8CvLoq0HUWYgWfMfObpKOcpeeWZ9TeTL6asGRDQdx3cGQtFgf5SdJAjxiCVHFjJoj+/z9XOVwl7Z1Iy;4:3CEtlljmmSjNBhHDGXQc0l47EbyGfgM+xQUf9nT5fStsZbSYMxdvB9pPEZ0Ru8M9etMi2iXM7yZeYlEbAK3CrlZwuDVnqGAE4g8cnbHJ7b7JG3ZxJarU7d0m59snYkYt9X5hzWrQSEnSroot/yABA+CKYjON4Aa3lZtnNXTcndCkDkyK9uve4dTjjlwkY+bu+/p9/yL8wZjGXR8yokmQFOoomnWFl+9OKxYjspopu01xg1aLzy0lgEzzDPO9gfFSHPTfUA3UmJgLoGSsZZqfUg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134389F630B096FF46689656CDAA0@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501323)(52105095)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(366004)(346002)(376002)(39380400002)(199004)(189003)(66066001)(316002)(6116002)(3846002)(97736004)(47776003)(25786009)(103116003)(39060400002)(105586002)(53936002)(55016002)(9686003)(61506002)(478600001)(23676004)(52116002)(106356001)(2486003)(7696005)(81166006)(33896004)(8936002)(5660300001)(7416002)(50466002)(6666003)(2950100002)(186003)(16526019)(76176011)(81156014)(26005)(386003)(55236004)(59450400001)(68736007)(8676002)(230700001)(58126008)(6506007)(7736002)(86362001)(305945005)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6WElWd3pqbGhROVBGQ0NNdmY1cGUrVC9j?=
 =?utf-8?B?NXZEOEhWYUVHQU9Sb2s2SzVKbW1tdkxVcU9TcU82K0dpVmdHRzVvVVZDVm9s?=
 =?utf-8?B?SVVFeXNRSW8wZW1lRWlNTGJ4VE94REdSTTA2cHk5YzJHcW1LcHZ2UU5SRTBK?=
 =?utf-8?B?UGdHSWNLUThobUkwSnVDSitPd2FCZnJPQUdESEw0MENJUHhuTmpjMmkxa0J4?=
 =?utf-8?B?bk1DdGErSm5SYW9LbHU5amdrN1Q3ZFBJZXZBcVp6QllWWmZobUVraGlFUTlj?=
 =?utf-8?B?T1F6V3E1WHZjL2VhMWtDV3lTSHhLU3diU2xOT0w4QmlXNjNLcExFTVRJYnl3?=
 =?utf-8?B?cm05OUlLS2xMUE5nbzRFcGoyMCtjY0taa01Ld0U3U2JjS2JnTVVmN0FGTHpI?=
 =?utf-8?B?L3VKSXBUMk4zTGlQblN5SnloSDlMSUdRbDVsMHJjVHB3bWVSM3h4YmhuOXZN?=
 =?utf-8?B?WG91MTM0Q3hyOWFkSzI0UDN1dHhKR3lXcnIvdG5qYXR0bzJNWDBCcWFibDJw?=
 =?utf-8?B?WE9GSThRV2VSOFdkVUxlMGhVbVVZNGYrM2RNWUNSRmhXTWdPc2QvRkJNMjdR?=
 =?utf-8?B?ZXdZWllPZ0NUVUJ1MkFTeENhSW9rZVlhWGxaM2lEZ2NWV1B3Ymp6blN3Nita?=
 =?utf-8?B?NGdReGJpSTNQQ2hQYmtRWHRhWlVtSnZzMkloZDBXM2Z2Q012Ty9CckNTOWx5?=
 =?utf-8?B?SkpvZ3ZMZ3NxVjFpSUpTd1gydUZETEN5eFZRZkZHNWVzalExTWJmbkE4UUNH?=
 =?utf-8?B?MEp3VGJ4cWZhU1djRUhPUTBGRHFSZGk0YzNhdlIyYTQrRGE2WFZwRkFiSkpU?=
 =?utf-8?B?RUg2NGhtY2V5N2NYT0dJQnNCeEc0VUg0NmRKTGZUN0JwVm0vNlZPRVRjWVRD?=
 =?utf-8?B?WkV6eXlwMGhaR215SFYzYjJFbHVwTVdQYUVRZkVHSWJkcklYVXR5bWZJUGZm?=
 =?utf-8?B?dm9aS0JnM1h0OWNKQlJGZ0RCRkNtRW9ZOFFFdm9xV1l0VWRlcjkyM0pFZ0Q2?=
 =?utf-8?B?UUs3Nyt3WG9rVUVLMkVhS0xpRTR1OXdodS93eHN2OG5mUG9oN1hIWmFzWnRY?=
 =?utf-8?B?NFA0VjR0VHUxcXFpemwrejg1SituN3BpMzBnSGVqUzRJZGw5NVdMT3NnT2ZF?=
 =?utf-8?B?T1RreVVFMHhPcit1WTFNaUN5UVVBcW5wWTdaUGhrYzJSdTVHMVdOZm43UXhm?=
 =?utf-8?B?Y29PRkF4OUJISG5CVTY4MDRLbHhCa283YU0wMUgyeC9lc3A5TE9qRnJ0WVds?=
 =?utf-8?B?OXdES2NHS3VvY3N0dWErZHI3TjBWZUw1THlFZys4cmFDc2VOa2tqU2tlZi8v?=
 =?utf-8?B?cDY5djQwZGs5TkhSZGlvdVFLSHVKM2E2dUF3YlVkOFlCc0t4MGwvamM4WDN3?=
 =?utf-8?B?ZXJ4cHM3TmJZalF2MWppRFcwTHFSSHBxeVRyRnZCaXdhZDdlODVVcHljVFBQ?=
 =?utf-8?B?dzZoNzV3Y2JJVUVJWnp5a1JlU2M2Skw3Y3JZbVcyWWcwci8rcmt5THRRa2J3?=
 =?utf-8?B?d2YzSHFXQ2Z5dXcvcDRWV0dQN0dpZFQvck1zWGFiRW9MLzJ2cE1JY2V0WFUy?=
 =?utf-8?B?bFlkeXdSWDFFQVgyQWdKMDRsY0FtR2JvN3lpaHBiNmVsRnVSZEJ5UExzYS9P?=
 =?utf-8?B?T3R4M1FHVG5PVWhGQjlmeXAzVzFjWk8wUGVENnRvS0gvTU93dVdHZ1FQcXdQ?=
 =?utf-8?Q?JStGI0f9M8YbwInofQ1o1vl19FLaa+Y+5ivVKRL1A?=
X-Microsoft-Antispam-Message-Info: mIsylkTMFYsMsBOiPQ/sjn7x4F/xL0uviZCWitRccGx4PyLlHbU7Xdj82t2wPUjbyDCn7QOR4Naeofhcha74QjJG/YAg0Ki5ESIJg3+EWSIca9v/AesmL2/+39BQ7emnBwjx3Uaf9rSocyF5FxDlHJbJDt1Lp2SIOULElN9XiGCbUSDEYjrbyJ4uWdZ7nPfy
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:kCu5ZFsR1CeEsZiW+wZFJs0M5YZBmeEeFC8fTkFYp68Bz53WPC5XURFb7DPPMeNAQbndSDk0wtM7H9A1jr+Njev1A3iMM40vAotiX9RChEOrxJ55tGLLfcCYiIlHelJFCJYm3QSUe/GJxcJOghQOaGk7qKUuhzy2J9Rf0sMHuLmb0G0n5qtzjTovNPot53/ijUZzXyDYr3bG1iy4r8FzdM/WPPKMcxdqx/PV6gkpygGmBYXoCRTx4ByJqu7qPNAiSdEtAw7PYk8JxwcsOV9NEQAx3NDBaDTyvqZd2rIDoVGug/0RGBn2v+sawDg0JAaP/774TPk32AzipQYq+CMXg3aw7US1U+jLg9JfK3TfKjQ=;5:NjdyCWvkCzZtAwpEwHAsgIL1CC0OG4XH083mznUgGdOGXS8iGB5NkvhDsLSoqTQ/O7UyIYxCVC/zAmCPJIB8QePIVtMQEYVphkpfyCmaoq9wwkoQOU6mGJQsilA6IZzze91V3b+ex4tQStM49yTyTMOk+B1pSl8CCum3VLTqFjE=;24:XVJ+NCUxiZUz4ZRXo/KAjHyMULdNSuhAh1Gb1KpdgiVufhM2LHEfr0WVB33Qd587EdQZCtPCedo44gc0yA3+4HuJ6mq0O2jMCq67LCWN3Vo=;7:B1+1rhMfqn6+3N3VL6+QutV6C75pxyWEqj5kHbhauzqUYq+pmEhpML2vHXb5zebhhrFJf1KScEZsJGlpUFCMdyfg70WIwTRTUZBZOhQCTPlvg9WZOoZGU9+y1wWMO3Im6nvj+WJk/T7rqBVOfmJgYsmGsKTtHdeXMn/3Yc6uVunpsEF4Y2gUBGr3re/fXDwmmB5zcEEgMixY0yteqr6016Nz6D6GPrgBMGbUDU1bzzbbK0dtrlL0fRPJfsRH3B5B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:ADNIa1/t64UhBK4iMqd/UTxsU5ihIypD1smJFnBRX6rJ4BYjojSQRdqkS3t71wEePTukAtTe5Ti2ULNmld2MRO7kQXIOkqWKtXcQ4jGfX0KzpfbAPHe/Megr/Wdr76PKTncQjzMx6eKqK+pTdZTWbe+iyo+I4PIC1XvkiDT6u5g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:22:16.2276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3098e6b8-6dc9-47ad-acbd-08d58f2ec59a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553658469578349?=
X-GMAIL-MSGID: =?utf-8?q?1595553658469578349?=
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
index ce1d010cd3fa..50cf8c61c609 100644
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
index 78a3943190d4..a1259b88adba 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -516,8 +516,9 @@ int memcg_update_all_list_lrus(int new_size)
 }
 
 static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
-				      int src_idx, int dst_idx)
+				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -537,7 +538,7 @@ static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
 }
 
 static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, int dst_idx)
+				 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
@@ -545,16 +546,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
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
index 2324577c62dc..8bd6d2a1f12b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3073,7 +3073,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	}
 	rcu_read_unlock();
 
-	memcg_drain_all_list_lrus(kmemcg_id, parent->kmemcg_id);
+	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
