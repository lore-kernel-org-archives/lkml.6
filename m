Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvbQmin12TAmrH4K1RQmbnNudKsnSPg0fiSI84AiOrBqiaI1yqmzsHiGp2Xrkw2auvg+glu
ARC-Seal: i=1; a=rsa-sha256; t=1521638527; cv=none;
        d=google.com; s=arc-20160816;
        b=eKme2efH3QN2bm1gbCJ/ELbH+pZW89gNZPfGE4WM8tu5wANNtRF26EfXB0vt3JXSx0
         XKOVdov7Kmou5tk8BpybgK0OfgByRTKf/JpXuIsSR/8GZoPM9CXJON23uq4SrbAXfIv+
         RDlJyJY9t6wJQ/U2dQxhePokceh+aZsmJXbUCMdyPuVgQMnXUVCJDY7SVWYdHBnifpXu
         aHZ3Cdn9LNeqjxtjHlKe9dTjH8EvgPQHOCd5glivZjv67lXaWQpq0JwuViJ5SX1rw/Xr
         VIFNekpx5kBJc5x65jspgyOPGtpKdNwn/Em/OFql/KC3KVGdzhnuueQUE8881SmkFE9q
         evOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=oM+vIC5GtByFU/VV6lwHevz/DFq4QRG6OI64eDkVDh0=;
        b=HPT/nPIWBR3Fz7AodUmIL0UZZN5fOkwDBpP17X9bXyii2lFvQEnV3OIU0HlKPzEKfM
         LhobKnY585sKxTZKr5Ea5Cyr1YR4OOQkJgWB2SwYuwjH0hDgUBBOXC8gbH4E+E+Ys2Hb
         Z+zcnawkEJiGsFMjdQiYXnFl5IgDR/MULQDydH8I+572K+04C4PavgvnTwVDaZuqaqZf
         v3Ptm11fwEDuQ+s8HY1FAg1Bj6jTx4BxVwoSfCtFlBtgoyaNaInwz0yV+3/+P5gwBVwY
         amfOLsTwA0ciNoXFKZVeF7wK78IuusC6DBClRF7sAazADrP0RuSeI/eKYDfoNxUZgK9t
         ZLYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gV+HLfy0;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.109 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gV+HLfy0;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.109 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH 05/10] list_lru: Add memcg argument to list_lru_from_kmem()
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
Date: Wed, 21 Mar 2018 16:22:02 +0300
Message-ID: <152163852218.21546.1527059404040591309.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::45) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe223793-7f9b-4258-8e86-08d58f2ebd6f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:ySkVh6UoXmFylNfHuXUfogLNdE+FcBqSGB6No1Eyj+P38uu8OogFqz9FelsZXj1m9S1OeBi3EYMWPhzJA9ndUulX5WY3jyL6jWS9b8Nu1q2js+3vgMwtchw1s3g/l+fpytsmUYeKoYjF+k99MBoO5jCjdLV50ITmoWK5sLKDAwm66E5uIHIB34CXrZ93gDlR8mBLF9voWaA8LW9q69r8zFWL0KcNH69B1cfAK+jFmyeev9mw4LDvUnu66OxddsxP;25:bfnV8V8RdsOBXs1PagGgWWcTXjO5bxDlF3tnr2nteKKZ/FGe26bW+gP38r9vcR0gPOaoevNilAcRWPBFhm0z231CHelO9J8Duxn6pDVeMCfJCVe0FMsWIpQvCcmYsuEHKmM9o4azEJ5eLKuDSwKlkfeTbPelIZIuDDs5YBR3Q0f893shhGBzkQftF9nePAoHYiZxIBPf05OD9lWc8xqnK2NGiHZbY8qS976KebpZFgR0EUmnrhqkGC/D+42wC3VCS37eSO11UPL+Gmc7SMAOro3jZYKSG2sign3GNmsDJanYi91ZP9aAXu15+aKqoQ2/IfD5b/sukjUfwc2GtqyTeg==;31:v213ggAZXBRielgNNkxyMdeFkznCgYxyP/QWkva1YX9xnvA5q7ub9xHnx55Gb6m2yx41uhkB8jTSmh6alGXT72Bvxx0XhprQeOdqhMJic6jRZHCQa3yuwNEeZn3322dsLGCLdSJmm7xffUFNq39LNkHwRXuhCKYbn/vKb6HHik2ErC2SuRMP3bf66uXAlsUVS+8LtPK5rsPmolITbBdRE9lzBw9Rqj93rkOxwMFxuZ4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:Lt9+E8oNNismHiCvaG9jym/mCP7LUITZeyakArVVrIobGJS9pUCncxXm7jAYd0McXX2dNbD/Xdyqehd8tajQweD6wYAnZESTPjRz+GrPiNTD04U/ls9X4/HaXHY1M/UoEojuVh5FKPLLAcR+7SiMpSSLV+V13SYrJL3hhyba3a84FKvkf3ofiUq2ULRPaRBGsHhAiYXi+sp4Ov/+5sEFJbrBIjwd/2DiDPXn5/fSgLqDeuRTD/spkeIiiKGo5UD4XA0b7OzaAXLqrRR/90lGqbvG9uiD1GEmxV/74GqWp3c5JRu/FhC/ZLABb+ml0pvxgo+wZcvJX8UvJhBXU9mlqMT/WkP6PkdSG2lwMcE0E95bZELQHLjfdBkqDaWp7m4BNWJFNiGU06bPBHRR6bzGwn7Iy+b98LyV5hu/fvTdJuqcEYn7J/xMs9srzpUjZx4yxJw4MeElopr3L71vcUYTiCWoTjT985A72HPmyiXhhGBacT7EY5o1vbs/ETjRgGP5;4:/O4Lbh98bB+uSNMBcs+5yCEivOq/3OHk+zw8PS8V+bOV8ndYqh9slexMfp1BLP4LnxTohEHxLRHydvmE5o6+P84Br7zZXKKT7DMNTJlclQwSw8q2FnSokFcYGXQBZQSqMG1Dxl35HwuXUwPgwSr43RXioX6EV7qA7X25r8JoStmD7F2i6G9lXeMeQxzTQEVaxKb45DtTiZ/a/Iha4O7JHyLH/NBJ1UHJXxCpZdDlCZkc7uPbDOv+zBJOHIFZ/pSB6Q+h3b8J5Y8icbLBLxxRmA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340651F9B1A84B09BAF13BFCDAA0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501323)(52105095)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(366004)(376002)(189003)(199004)(105586002)(39060400002)(8936002)(81166006)(316002)(86362001)(230700001)(103116003)(8676002)(2906002)(58126008)(106356001)(55236004)(50466002)(61506002)(386003)(25786009)(186003)(66066001)(6506007)(47776003)(52116002)(53936002)(33896004)(23676004)(55016002)(2486003)(7416002)(9686003)(5660300001)(16526019)(26005)(81156014)(2950100002)(7696005)(305945005)(59450400001)(6116002)(76176011)(478600001)(68736007)(7736002)(3846002)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6ajZSdDdSb1JvOUQwLzlNTVJIY1N5aHRt?=
 =?utf-8?B?TDhFVjV2V2Z5cjROdjVEQUpTZDJvc29XSDMwK1JvYVBPMDJZc2RXSW84Q3A0?=
 =?utf-8?B?N1Ntam5qejBRRkdSeGxRbHBBQ1FIWTJKMTBVekhFRlBIWWZPTDd4T3YxMVFF?=
 =?utf-8?B?TC9VRk1kR3ZoU0g0LzFkMkdrK01ZbTlCaGJxYmRnY3RVdmk4TmpmYU90aUFm?=
 =?utf-8?B?OHMxVjVjTHZRNitSV0Uwck9vQnY1a2RVbEVLczB1VGg0T3ZzV1Y3cUtaUHdW?=
 =?utf-8?B?bklEZDF4Lzg0cHV4RVNOall5SVRDYVBRT1RxZEZKekh0NXZ4QklHVHZ0ZHQ5?=
 =?utf-8?B?bXNBNXJ5bGErVXpNWWZxV1JURS96WVVhdUdtdWhzaUcvTzBxTklSN1RNTzMy?=
 =?utf-8?B?OEY5SElXZksyKzZXbWpDMFBvRGI4NnJBM2RIR0dOTmxRclYydld0M1g1Ulgz?=
 =?utf-8?B?MDJUUGJKM1Y3K0kyZThiM29nV3JEV1FuUjlqK3pSVXVtMzgrYjRUZVlIcko1?=
 =?utf-8?B?YUQ2SzlMelhKaW9CcDdpTmV4eUVBRnVhWjJHb29TL1Viejlqc2UvWTA2OCt0?=
 =?utf-8?B?eWNqdENGNG15SHBKbXAwbG4yQmRaaElsOU5KWkk4ZlovdjFSWnlZOW5uK2hn?=
 =?utf-8?B?WHpFVUIxb1B1dEpLV3lVOExhMWtnK00zb0FUTTRCQTRrL0tNVlpydS9IeE9l?=
 =?utf-8?B?bkpoMUFrb2tTVi9sS3NDYnl5dWdjeG9sNkVCU25EdlRjMmZNVzF5OGJwaitu?=
 =?utf-8?B?VmdrSWtYMS9yTVVHSCtVRkxQVE96NkkwK3k4aXZER2ZSc2RrYXI0cVdDSGZv?=
 =?utf-8?B?cUl3V3NJR0N5YzhpU1ZDNlFNRTBkQy9HWHZZQ0NLbU13T0N0c1N4QjJyTlN4?=
 =?utf-8?B?bDcxOENUVDNiZytEK0lraTkzOUJETFhUZUI1UmgzRjlnbGlNekFGNDBqb1Fu?=
 =?utf-8?B?V0FPM0R3MEdFNjRmdEpTbjB4cjdFbU1jcCtHTmFSRy9sbnNYV08rWmFURnBx?=
 =?utf-8?B?OFVSWjVHamljaHNUSSsxT3B2RWlGcEtFUG5lUUZhVDhlTVlXOU4yTXRtNWlr?=
 =?utf-8?B?UXV0V1VlcEJYaHJGZXJDZk0vRjJvcUNTQmhvTFl3ZWlkSk52ZFJBSklnZnFE?=
 =?utf-8?B?Z0lWR0RpWUZ1V3BOQkIrUlF0a0RJUytVT0cvYURMY0FyUWNUQVFuWm9ZV2d3?=
 =?utf-8?B?NSsrT3BYSGRLTU1lZlZsSW1SOGVWaHhnY2xVdkQ2VFZhWTlGZVBSZDlHUEFp?=
 =?utf-8?B?NlJrS2tWZ1RBdVNCUFJEb0JmZkN6OU5GSHMzSCtiZTcwWUlBVU44SG5BeFUr?=
 =?utf-8?B?V3A0bStLb2RONEs4YytMVmErYlBrbEQxM1BXeTg2L2RscnZCRHRSbm1mTUxO?=
 =?utf-8?B?WDJoMUtJMmVKMVl4OU43NVJISHptMGVxeGdqMnZMem8waUhoNU03SGNxREJI?=
 =?utf-8?B?ZzNMcWc0SlBId09seERMcXQxRTZDQy9zdUFFVUFEbnc2cnVWZzk3N1p1c1hW?=
 =?utf-8?B?aWE5ZzdRdmhDZEE1UW9RbCs4NEF4SG9Xd3JpTGtCSGs2ZVVidXl2eFdrQ1gx?=
 =?utf-8?B?ZG5ERk53RWlMS2labTlnM2ltRUZRL0RCNTA3K1piZW9EUnFmaUZ6SVc0dXBa?=
 =?utf-8?B?TXRHbjFXY0J4TmF3allXNXdPdy9sTmhPRHJSS0VvVCttTFBLMmxGSXBPVmFF?=
 =?utf-8?Q?BN/hgQzXocNxYEL5nolk=3D?=
X-Microsoft-Antispam-Message-Info: nD1p9jIayCPT7JSTppT/nn67XrcoTCroMVyGCumDej9wvBA+r3js7yzomZ7+fvSziQV5CjQAdXGnFP0K+msS2DSZ7kmvpkEDacswuKrumbzNGTA+vylQGuQSeLckACcqCbomAJtUw0mFLUAzvUeSJ9j2DcVgozJlrq3DUGde1nC0w+8p+CfO5wh0SkwOncLT
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:VbTZGHZ8xtLgVNtyFIfFAvm/fmkdb7pUR65ef1DO6sC4t7cvsyvKMf1cMMuUUL1egiqB+fTgtv6YscjVJcykKTl5YPUIQVUSNLN2rek1Gz+0qzgcM3UyQcCy5awrLSkXwmrwbgqMisvyCH4wKQJ1v6ZTmr3PsehWf9SiJckktqhFdarcF9ljZGa2l894tHdo+sPbexJMJK8RiOE0fB75fCa9nxOepoI/4zx7sQcxhKLfCVIVl4QfJtcs2LlqQ+WLT79c90nPSFURUaS4e2j0KI++5x8b6YwzHYtbbmzi90dUxe9omQIHdBRzIRkpMznMyKKK8mxeSTX2/Dfhp2AjxlpYLAlCl0N4nl/bHqeKZC0=;5:ZQ++9mw7gC8gETIxxj3FjsXre8LaU+Y4GQ2AlK59TNiY4ba9A5Q9/lYxB5Z171QGrk6nbXHE6ZuUOP/SOWPfqo8q7AmpuvJ/FiU43NjqvDDmwGNwjKoK8/NH/wOw9gq6u8laRyKa0VZnNDm0VvCP8p+NBNE9dHpx5nFEEuuyhBg=;24:JYio0/v6xuxT3youY7XoqKCcOSwoGmjti0BXnz4ar3BxfoEWM1pa6DOy5TDynld3QQkCSyb792jW2a4/cyczThwGVGcZtQBRXH/+zuLKpM0=;7:vma2PjwhdBTCa/7QL99BrmUxKsN3dMh6P3b78u4LmO4WdHz8OgWp0aUicHQQqrYx5sxprNwjqzwX3XR1FlWqo2VVFqqeQwPlGngMxT5a8YzUXM4DBkxN/i4TGx6KSXmv/8LPsxNg8ga55OZIo68H5oVqEXZbRtvrZdPQssOMlX+Rz+aLqLqR83cfES0WD5eePyoAqe68C5cokX/rm+TVN2QHixoiYNwsl3TmIziQUevs8IApKgoue6PPIDGyM6QV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:yn0UaSxThcBuyuDKOlv+0ng+Ieem977zqR2vcPnKvAWVeOp9Y6CmWvcTK/+AuumxiW48UEbi084y7iHAx35hYvq1LavGpmK2tT71c+yeFmaQLTlaVBifhwmxJ9ZzPkxg9uKyvYLBlhWhOsQaU/yyFCi34heIYRDMRaubSCD4+oA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:22:04.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe223793-7f9b-4258-8e86-08d58f2ebd6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553640668984215?=
X-GMAIL-MSGID: =?utf-8?q?1595553640668984215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
memcg pointer in list_lru_from_kmem().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 013bf04a9eb9..78a3943190d4 100644
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
@@ -102,8 +108,10 @@ list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
+list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+		   struct mem_cgroup **memcg_ptr)
 {
+	*memcg_ptr = NULL;
 	return &nlru->lru;
 }
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
@@ -116,7 +124,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_add_tail(item, &l->list);
 		l->nr_items++;
 		nlru->nr_items++;
@@ -142,7 +150,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item);
+		l = list_lru_from_kmem(nlru, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
