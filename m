Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELv7Dte/UPdUmrcuEn+snJZHHVR97wa6Z82Mvl3dSkHNPWjOmZMYuh7W80aFYtRGKhwo/WDu
ARC-Seal: i=1; a=rsa-sha256; t=1521638560; cv=none;
        d=google.com; s=arc-20160816;
        b=Sk80yEGzFDqHzAJlYhvYFw2Y2Kq9YCicYgOlsIbUYCzPB4RRU+WGgXC+x5eoQ2gjHg
         Bc5x9FGtdhcHHBb5poxrRwvvmxxBbmXiIO3dsN/jcgQ/LfKr1PN9lbKVQBdMkTW7gSfg
         k/wPuz6q5X23IKNwrgeIonCM8DYmaA0V0xjepVDG0hDvomAzS2rax+S+hWFfzwZ/xlTc
         dKZyA7bLLB0p1BlWQo8hMj/3OsJcIEL/Z2wURwiUX1Q+5P929eK2JW86k1Kjea6wlOxc
         GOngrDaJpuzlbhUAsv6I9qhBlre5KWrQgZ2j2pTwC6SCFnPRdYmBccObHhJyuLVXEtjM
         ArGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=0RkbD6baNKcQnfNCGjpGeeSvgZILSkCcvdvPcqUC9CM=;
        b=v4fkfwMAxbnQkCIsclUxrMisNV8jlGMxWVXRZkX1gnXFr2gBwlf7EIxXwOf/1tAQJa
         nvgouYJu819nBQwjIyBp6WhcV11ybDhO52W9yM4Us9PLTctySLSDqSmNcP6Bo9OjBL18
         yDJp/tWNlNuvG0vgzsXBsHGRzO8HjKpe8Zme0ulsI7rX1CNPYVBSvYgy8/Vfa57+lK5j
         QZKpXQ+zXxqlZo7y4YHgcYm8UolHycXePEtW3Qlw+ifWbmEjdSSUg4i5GKbpldrUmV01
         BtruNibJi2V3+ChpP2AxvcId35FsqvBojKLvhhEobfwRJGtjWqDRC4AcE4h9NVp5/Y7w
         NCdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fNFH9COa;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fNFH9COa;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.2.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 07/10] list_lru: Pass lru argument to
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
Date: Wed, 21 Mar 2018 16:22:24 +0300
Message-ID: <152163854435.21546.1198452279434156844.stgit@localhost.localdomain>
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR0102CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::29) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab07bf4-72d9-45b6-7c0f-08d58f2ecf20
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:5r4KX17ULe5XCHP+MVfwqV6qxP++RAvjQppnzgFqlDqWbYuJEyqwcKc0U0XWWxyxBO6hvL65IZSjpbRfe3iXkblcdG8R7u9BoawhVqOhDf37CA2hIt88HxT6hnwlryLao7+v38OFNvNGgptkc964RbjxOtagACswQsuaQDnzri59wVXIOqx6e5LekP+M0j1fcpMcb3KCJlUR2z82+0xVbiqwpddnbP2fagWg0M6rTi0RtWrHUFD+XJzlndlQiA1G;25:2AuNd2Ubvsw1agVi7g9ZSuO7a+mTXNlzLqTxlZY7CbYSWF4L2c/VdtLUn6+MuuhFZtCP3mO5XJI+Ftc8cJCLxYqIuSDfZ0/NLMR7tyyr420GChrSjJ55qrRgahS7ZDkLKKsFX8ru2XEpiOJ9KwZCnHr23vHcUTJYA0V/Ef4+oZpqHh5mNFOwUYGf0TKxLjPG9TJrlPdO7qjm8RZTdYB2rJ358Be3hqdXKAfzxH3IeKeyReaJwEih4pypQHeVTyxRgN2sq9Th3VLbhZUpryT6LoRU3nn6CcVBdUFpybMoB9SV/QkKJQKWCCOTYyxsVgSRyaAdRbmtwt/34gMgnTrsxQ==;31:KPCL+4UtmFOevR3vmAjtJajPlzGIqrUkiuS4f0am9/tvDFWhhgEXo86d2I3Wz03klCxCN1oDwg9bf23yI8P+lEQUi3/rq5gIflLYxL8fru4AjPFitfpgfoiOjEdwFz3G6WIPCAT7D06vNMQZ3KLGDzB0GcNjhOb8s3HdJs5JdJDld3fc/1S1I5WA7XM0bdwQyDnFFyrAQ9pjIu6IckTOMgzDhiF7opNPKdvzfKmDcoQ=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:sLASUbG8vPz1kk+1gIgG07db/qVUQmDHK54qWezbf1AWR+i+n69uS0WRyc4VpBvE0frXEz9L2jgBGGqYhY0L+z4yzWT2LumgfAZuPiKSJ4o2m9JsLIpEg4/J7pMKr7d6yLeoLPS+CxZ4VWzX/uDqfmNUfFXr6r8uutQnyYJJF6oO6/0U02r41x40qVaCofOuWRjAcJ9dyo/myukmuOD748a41X7JZDHa3EtmdIyxU2muKQSiclG835N+3UH9LcFc8ThM1/FJnN38og/JEqL55xwvGkSM0kO+lj0g5LPG5loSB3r8vQ5dee2vx309WOorb9+9waRMwf2VtwQVhI9rowdyBR6H6eju2WdD2tYr6FqAgYQYKusWRUmCmIZ6tsO0VukFo8cQTe79F3dtrJFSJgBo++Rf/S2kJmHNgs2Pkh7biecf77o0dtD3ntvcmMqEt62nWj76OXzodonIxmOgEfk1WKOX6dY1NH7xxfvLXzH1nHnYXOn4Z6nPnHnisda8;4:Qelnq/kbjOxPwAd1Q7XPXJicuDy70grpVWjXc79RdpE9wxMbG366B8XR7M3p+1LiAwLIYqsDcc9quTVBInxHs4bHyGmp9Y5pTYAo4R//G8YtQQ6P+vJlIgxegBsLnynY/brnyc3UH9Qgu609aOouaMIPJeNXTfZY19g3G1vfR3pDnQweDRp8/zKpk89tWwvSrk+T/yE8rHXu4p57FkrCIKQDWAg6rCdJzZJOt3j1K1szPcqMEyAeWCj1P6JJPvb8cGbdd1WjuMP1ociK0jI9YA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1341DA382AAD13B63C30F82DCDAA0@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501323)(52105095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(2950100002)(6666003)(47776003)(16526019)(186003)(66066001)(26005)(97736004)(61506002)(55236004)(68736007)(59450400001)(316002)(2906002)(386003)(6506007)(33896004)(58126008)(8676002)(81156014)(81166006)(230700001)(8936002)(50466002)(86362001)(5660300001)(3846002)(39060400002)(53936002)(7416002)(25786009)(9686003)(7736002)(6116002)(103116003)(305945005)(7696005)(52116002)(76176011)(106356001)(105586002)(2486003)(23676004)(478600001)(55016002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6TUF3WGxXQXNTa05zNnVzUWZJanNENDU5?=
 =?utf-8?B?VWxoVjl3VVJTa1VlYytIZkZsQS9Cc3dybTNTNnBMemg1TEJRdHptY3lySGw5?=
 =?utf-8?B?QUhKVVhOK3djUHNsazFBdjAvWmx5Q0RBQVd4dDcyMmpGQnJ3RnhNaEF5V1I1?=
 =?utf-8?B?Vk9icDVUSFhNcUhRekJabEhBSVRZQXVpYkRMdlpmZHJyWDA4WmdwdGUyaXJh?=
 =?utf-8?B?ekdQNlRLNi9QamhVRXFIMTM0TnZyT2kyeHlEcHZoWUkxVWRsR1BqcERrOHd2?=
 =?utf-8?B?MFJ3QzZTNUhsLzVnb0ZXWGhUWU1TSVJsam96dW1YTVMrNjY0UE5yYmF4U2x0?=
 =?utf-8?B?bjl2MkdkWVFNRWdBY2VIUEdod3h0T3l2ZzlSODMwUG5MVUhXMVgrWTJWYlhE?=
 =?utf-8?B?Y1dscEJ5UlhGZDdQeUVqcEJnd0pmNTI0VVpVL3NPeFFpb1NkTzd2ZXd4Nm1r?=
 =?utf-8?B?TUZVdURxcFo5T3psOXM1WjVYSThRckEra1NucnRlN2gxU01OcWFFUFNYRlJ2?=
 =?utf-8?B?VmpUSTJnZjVrQlkxZ3grUUJyR0pCN2xZeFRySTczdE8yM1REc0F6YlpIZEtu?=
 =?utf-8?B?OUhuZE9pUmtKMFI3a0VQa0tQdGJ3MXJ6aXg1S3ppeTdWVkRHcnArN21qaGlm?=
 =?utf-8?B?MjRyT0RCNStuRjhTY1NuRWVTczFyMmtRbE5jRXJrYkJ1MElWRlFZbS9VYjNp?=
 =?utf-8?B?WmFQMnE1OWhOMlpWenQrM3FKaUozeFZvZlIzb2pPcms4SHdzUGhIaytXQTFs?=
 =?utf-8?B?ZTRkeWg1WWRyNnF1NkJhWFh3V05sQ0Fxc1pPRWtBS1FWSENTUHFHVHBubjVx?=
 =?utf-8?B?RWtCZU9FQ3ptL09uWGJqNENtcHh6NVFOZUs5RzlwNWIybHVkUzFHRWdEYktC?=
 =?utf-8?B?TGR1VmdPRHJPSFFiQWVxWXQzSFRPN0xyTjY5SUpTV2ZDaC9FNVdxNFRpTzJ6?=
 =?utf-8?B?UTB4YWRVR0FYM0JZUGNUYS9UbjVvSmZ5MmlITDQyWFdHajMrcXo5bFF6Z09E?=
 =?utf-8?B?Z3RqUjZuY25wQnhsdTczdVdFaGdza0pIWGkrSHpvaEpTdmFybkpra3ZNaDg4?=
 =?utf-8?B?b1JEcmJBTk93RXd0cjFUWEFVOHZ4T2RqZnBOVHNpQlBIM1hodytUQVFyNDRq?=
 =?utf-8?B?OXlxS1NZUUZGN0NCbVF0MVFsdHZPYTIxNHdscE5kSU82bHFLelVOWmRjZnBh?=
 =?utf-8?B?SjdqNTlGOEI4WVptM3VhOFAwa2lOMGVDR2dweFFFbG1xZmRGRmNhaXJQNUdu?=
 =?utf-8?B?d2piMll5Ry9UVXVCVE15M1N1THF1UlkxVEVKZmVHdWdvTWVyVHhySTdEVjYr?=
 =?utf-8?B?dE5ySXZPZDdBbGtZZ1ZQZ2NlZFpzYndrcTRKRlZnakNmVHNDMWJNb0dVM2xl?=
 =?utf-8?B?VHZpL2toMXJ4blFOa0tya1ZLTWNxVU5XcTVBQi8wbEdaUTZ3TEhNZ1dRM3gz?=
 =?utf-8?B?QUFEN1RBQlZCK0NKMzYrZjFycjlCMDBIcHcvazUzNU9iTE9oRjUrcHpvL3NX?=
 =?utf-8?B?bE1LcGx2dGoyckxNSDFna294eElEeDZpNGZNSVMzOGtGZDVLUGZLY1R2SjZ6?=
 =?utf-8?B?YVVRRWMzeTN5WnRlSzZDVDI2V2VqNnRiSnhFcCtLVzg5RVhnTTZtR0F6a2tw?=
 =?utf-8?B?WEQ1SVlNekNXcTlzQUZDbTJYbm8rOGp4NVFpUXhoOGJLVDlWV0FieThKOUxr?=
 =?utf-8?Q?EG0oeIEoksypIP1ZNspfw2/TZNcYt62MmyhSz1Wma?=
X-Microsoft-Antispam-Message-Info: 3dPFQmDa6scckSlBYoGacrKbOq2I4Ve7KsRocxCkicfKT9DB/dN3dthZqo7s38aFN+a5S1avVqn8T2RyL49RL1sk0N4y4npr6DwY21E0tSBdBwBlbjsBO1j0rdu4zmrwsEeXbaFnDPs2TEr/jbBq5yRtMZMqnXBHWCBFgoHarMZ0Q5ICkg6425eJj/4H/Vdd
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:S/JELENyFST7eSw6+/y06RAJUp7u3N+jnFAzNNgDAhH+nEFeAdh/Mf3SzmS7judVMp4Lcb+XhBVnXSzswqpNSxDJwnXB1P3ZmmPQUBoqzIxdn9a9BouAB/rRZwZ/UR00DY1SRrTQlfu2XQvqiExHJYumZfe/yEIo/lu7KTkrE7yxR5M0e4zjPyfO2nHugN2ZF1zZ81pTMpoQg0jyrwgsrWzinHbWNHkxJs8tvH/BgR5jvewPpfnZ+A4pmsybK9LJS5hfDJcSfn72yhRWLAb6Wj6FZ4eu/SgkyxPHlBkaKO8L5vGojEWCLxHK6I/e3LY1kt47yfvdZJbAPvy6qenW4rDh48eWz81nb09Uen5psbM=;5:MpeYAfDPlBR/w7Ef086SkVIXN6I5/cs8IIv25CF0It639zWXVS4+vEmBbCpykcYvcOeftZRLPFDivZabYH2l/kir+TN8tDCPxdBkXAlj4VzRDEW4k6KwPSGloRcl+C9n5+2Rltd55Tcub/FMVTsrItN+JrCrB4aokKci272AEDM=;24:frVSmGQoJItlsDUCol54u6LYCkNIdDmqrVG2gJaPCtT3feuQ+RZHaZnPu1zoLF7pYaEDNJATpb+THJc06lKp6SpESN4iJXnza5AwYOzBVLw=;7:fe+3DL7sAvmesCJVeV/trzH671c9wL80TwapvexUcWnaVjmMIlpeRGwU58fslQM0s4dm9n1g9bTEzP/onCM+1oJIHehHZaBO54Pe53nvx8puRZv+uwVXYjpHLXzOR+ghsbPW21WAZt0W0yR6sAmo7DghQ0kOmw567ZnZtErjIN/JuQNcqIWQO85SGkK4rmjJekkGCkO3Fyka6rKeEGIDtVN+6ncjqXo/7nHLbaW0huO2KzC8i6f/QV4fqHRhfJaa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:Ma1e9QxMPaRTrTd4boPiL9cvaMAkMuslgQEl8q+9LxeGHJzTgZWlMfOOxL5d/iXFoib9BQFk/wG3/enBeWzHainYVtRe9BHgq8Gq40rnnKTRL4cbd9ncKuCKkTt7ieJ0l2IHLZ7VVBuJiNBpyipwey9AnT32bPJjVoxsK4g7tE4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:22:33.0947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab07bf4-72d9-45b6-7c0f-08d58f2ecf20
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553674422791058?=
X-GMAIL-MSGID: =?utf-8?q?1595553674422791058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a1259b88adba..85a0988154aa 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -515,9 +515,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -546,7 +547,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
