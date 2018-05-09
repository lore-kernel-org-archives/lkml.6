Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrWgkhN+o3eC6SWeUdSjn4/s6wf0om01KsleS6oqEDYwn1bcODJ6w4HJfzu2jKo72OfVug6
ARC-Seal: i=1; a=rsa-sha256; t=1525867058; cv=none;
        d=google.com; s=arc-20160816;
        b=kTH9emYJ5USuM8JtkEBobJ/6SL9p80vy2DIGXyjC8H9DfQKRwWCNR+Ba/5PfuU/EWM
         MuOUJE2tDcnViG5jFpwHUgVzuGh9iqdpCfbzaE36gBJnQ8ec6jl/hmkGhAXfrLO6J6r4
         WGPw1iBHCV7sMt2RXM+XJ5uJlf4TT1/4PYWcw5FxsvOZlvTGD5gfGFyGEMIvf4I4elM7
         4RVcZibUxtHwwgQbjB0M9WuIKVaG4rPyK2KmuC/iXrX1Lzr4cL6PW3O7oS9MwKMLIA55
         hl5KXIkt+UYmKnGiSdE0xl1/2jt2dCd3inu2Pb/DdIqTRaa4sWK4S02XvoCER3PzA+W4
         kSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=6Lv+JfRhmpiB11xmNRi/HUFuAWVUELXj+iX52Hpqp+Q=;
        b=vD67N7YgW7gUszjccrdKz2qoLWHm7LiZHgDbhkr3lZse8eg+8LdvrBko8QEG2Z74Hx
         8yFcyAQyjZ9If02Kb1eSdTJ+sBQmeDziPVFEle6DslrMFr+TxAo6IENPnpfp6gjhb2d0
         je9WVFgMnWn/kwcDcd0/+dGiMx/HCE04bbAKH33PezVwR462et73XO8sUeEOmrY1WWD7
         XKgAAs0RTH9y8Zy7NyUUjQvOywskmwqwyJgSm1/e9v8kv8oiHQg/BnULabEoesczd9Ts
         rn5iyvC5/zSSam4txWFqeJMpGeLC4XlOVh5I1I9AVjgYNlEsfPPjaihEjr6DUHomJ62o
         Bp1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gI+WUoAk;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.99 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=gI+WUoAk;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.99 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 04/13] mm: Refactoring in workingset_init()
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
Date: Wed, 09 May 2018 14:57:27 +0300
Message-ID: <152586704715.3048.16683522879894119893.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0020.eurprd03.prod.outlook.com
 (2603:10a6:3:76::30) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:9KuOCjPZ97su6CkLnW/V5+O//xKjc5MZMsZjU1kAWJa2AZ+gZQhdNIS1CIz1K9aPq1840sHfgMrP34uLxZc4vvKJTuNZYuBvkHwRsADq1xXR6dW6XQ+/i3K73Zv+xUsXWcefK8FAl52ti3SgNp7SFbYIwYpCgCSoNlYrWFE/RAN2xiJgxdGOCPbIca2CrhC7A7gBZqqSLs7EtViKI3OrbhHo4gCk1+76cwYoHHaRvDFoBD9DClzwY9cutqoEo4KG;25:mx6GzE9/vyju/iVaBA5gKbmMeiuFG12KUb8/XjS7Wwj0ra0ay5olDaMnDY3KfAsSBkFlzc8eVDV1wBVSyDvDd8o1D8Vj7zfj2pHRyfyLJUBDxkVLK7n6HJd30nl4wqF8C5H/D1aNPwDzC/DbpJ2O3GBJp+6TYAEkXArLRWrrMsr6ycSCylmvUA6ptR9kZOXQLEDWi54eth8QlNkLBmYemJx5ya995ArrmvnnSQ/h2sWAagvUVrsg6FzbdL9LRQu5w919uCshsjj4B/Ofg72Woc6DpoqQ/kSpRb39WWEBhG5DKJFV9RJzqb1RqO1vau+VcMtrRJK18U6ZG46EEJVyQQ==;31:zoDk7z4n1Z+snzh21zfqp4A3R3sL+h3WVc/zM3rf3UxKNzcRETSspKr3fpG+7ptu2asnVahO7mdHjV/eKg21Lv8oukxnXQcblZCa8R9CQcP1jAYQzOmQ+T3Z7XMqX4wNzxPHv5mISDxD7Yp7wIB92/7/ViJlSbvsiv7qmiUBoKgibQafGrDbnZU2pWjceUzDHw1YsAf1zQ/PANxBTzFbW/E74mtF316cEtFhzrQHH14=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:Yn2ckbBhR2iY036d1AGb9idfScFmjh7XD+TaeIlXuacuhg8vOrcnhnBbL64eb4DQA9DH3sdhjz7YuSt3xpOegAUzjkBmCwSGf3J+4MkR7sAtEmhyy+yKp97VwWuGuVBSkNQp67u21YEbeTjAL2jJLH1rWJ+Z1b2b5GXaq0rcqna2SvAuEoKI4bwX7vzfc2gEBmZliSRwS3vPQ1/PDJcNjKNqa+FeoPKF6s7wxWihzaGfEYcj9qPfs29yku8PULXD8/Zwb/HkX7BI4KTiTSib0Azm/SPuby3DjEldbAS6nlJHASFxzUhoqLYz7DnGBcn60BTrcezftuKAOTzbqnwORRoLGRBPttmM0lLv3UWWh3Den8oypLLLoGH0iL5diQN+DhyrTDkfRzWNs89DbJnuU7X6jXJ6R8O/rDHPXJedx00RVzkSyIoLL65DQN+9LblKHpIrV45JcrPwSoROaj+bao6Acat778ozGBN99Dj3o4BrAP3E+ciBuAf3jOA3/3ZT;4:zOwsP+MWq4SwZ3tPCmAB8NpIBOLZN939B7UoMexmxfSspKW0kJ95azLHZjaxhl0NT4EUbCwgq/9jw+tf58ZSWzrySDie5DIwMIjk2gfRczB1vq+ziWD3N4TvIccWcdJ5KYcdsAAb/n7MBalh6LxmtRpuH66HEGUdwrMJ1rfjSPAmb6i6usxpeinlcBwc8rcAQm4SN7It9R0eaX6sohYn0rD+JUrGpJmkeEivE2nz7aC6bV6LtJYfiruMNs5/idzdeJ4/BzDXWfwEPmAPPxDtRQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB133369AD422F7BDC50D66691CD990@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(376002)(366004)(39850400004)(396003)(189003)(199004)(61506002)(66066001)(39060400002)(106356001)(8936002)(97736004)(81166006)(25786009)(81156014)(105586002)(478600001)(53936002)(8676002)(47776003)(55016002)(6666003)(186003)(3846002)(9686003)(305945005)(6116002)(446003)(23676004)(230700001)(2486003)(2906002)(76176011)(11346002)(86362001)(6636002)(103116003)(26005)(7736002)(16526019)(7696005)(52116002)(476003)(7416002)(956004)(50466002)(59450400001)(33896004)(58126008)(5660300001)(486006)(386003)(68736007)(6506007)(55236004)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6QXB2SVRKcmhXWUdET3FwMEE4YUprVXJ3?=
 =?utf-8?B?Z2JaQzRUUENkU01SNlRyQm55amFjY2Y0T0NWVExYOVlxenJRZ3hJYzQ4enpZ?=
 =?utf-8?B?bUg3MnRhcy9FRm9jdlpnV0dkQ211aVRIK2E4L0plajRhYUM0S2Y5c1ZSYUQx?=
 =?utf-8?B?bm1FUzdrMGZoMHdjUkhLbUQyalRkMkNOb3BCcFFKZnBnTkV4eHhuVERMcTcr?=
 =?utf-8?B?eVRFdVc1aEdZb0RTeDM1blF0em5xZjBlaW4wcThQYXgzTXltRFlrRU1hZkc2?=
 =?utf-8?B?QzA2Nm9WSlcvbTJXdnBldVd6MTE1N09iVk4zazVqdG16WkJjTWE2WFYwR2Ny?=
 =?utf-8?B?a2wwUTBiNndvRzJoK1dLNzZOekcvSlJjVExETzdWeWJYMVJSNFZsT0g2RmRt?=
 =?utf-8?B?YlZkenRobE1taENudnhMTzZKVmNuZWZyRTZ2bGpzN3RibDFTcVlDUDJ6N2Fo?=
 =?utf-8?B?MXJRK1lPRDZJYkN2TGJqYXdQQUJ5bG0yYjcrNFJ1dTczYUo2aEJ3bEdzSGRX?=
 =?utf-8?B?ZkdwQitkQzkzNlNNV2sxRXFhemZNQVNZY2F3elpTN0lCaDkvdXBEK2tkektC?=
 =?utf-8?B?Y2V3d0pLNDk5eUN1dVQxV0YvZEtQY3p4TldHMjJZSnN6N2xXTGVMSkZMVjdN?=
 =?utf-8?B?TnM3aVJiUFA0UzY1NXh0Y3pyZzgvVFp5Y09MQUV1S2ZwN3FhVlNXQXprV1RL?=
 =?utf-8?B?T3ZJYWQ0cEZMM1hsQWhERW9ER1pMTzY1OGNxVzJ6Q0NMK28xVzJlU0UrTCtQ?=
 =?utf-8?B?cDc2Wkh1Tkl1S3FIWGFXM0V5aVh2WmpjN2x6Mm9iNkNhcGVFNnpZU244ZXc5?=
 =?utf-8?B?R2JVYjl4T0x0UnJGS2VYVFBwNjZlQ0l5VGtIclJ1dTQ4QjNJdXBlL0k0ckpX?=
 =?utf-8?B?dkNueG9NR3kzME9NdHpHQndVN1VCVCtLdmk0U0dNNS9VWlRPbVZuRVVLU1dU?=
 =?utf-8?B?YmZyQncvTjdpaW11T0tOZDVoeVE3SDhOeDNaSzVvS3lDWHkrUWRDUTVONEda?=
 =?utf-8?B?cEp6YjVTTlhId2ZNekE0RVd1MFdrTDVsY2c0NW05V1lKZ0diMlhVZTZ1NDFR?=
 =?utf-8?B?Q0tRaVBJWHU0NTdNQVVRSDk5VWFHeFpJWnJlVDFWZCs5VW9ucC9LSXZaWm0v?=
 =?utf-8?B?cFpFSUliandzQ0FRbG1FZkYzZWluTTdraW1oYUlxajlpU1lTWHlXc0U2eDVC?=
 =?utf-8?B?MWtYcnpUUDhZMHlCM3luUFhqYjIvK0tNa0JEVXl0dUdLYW9VKzltSnpCVVI3?=
 =?utf-8?B?TFFtZU83b0h2MDQ4dEtwSWYxQ2FtRFZkWTlBV3RjMWlFWU5UOUpxcm9YZktw?=
 =?utf-8?B?MStEVXZJMmtwNFlIS0NYWW5rekJDSXRhenArMGRUUnpzT0d2c3NIOGEvT0NJ?=
 =?utf-8?B?Q2t6ZG9ZUXFldDYxTkRkNGRPTEs3cHQ2UklHSm9sWWtXK01EUmlDY1VXMERS?=
 =?utf-8?B?RkJiNGZwWDFkaHgwdlZONng1SlF1Wm1yN1NaWERycTV1V052U2dQUE5BTDF5?=
 =?utf-8?B?OFZ1cXQyVkNOeXRISkRKNTVrRWN0ektkYzB5dkJja3V2djZwYm14b1NSYUtR?=
 =?utf-8?B?SHRURmtFTGhsaUk0ZDJ5c21yc3hMd2lmTVZSQ3RNRm1DK1RueVdoQWVablNG?=
 =?utf-8?B?YyswRExFM3lXL3JYL1BJcGpFMFlNQy9qeHEzSXpTQ0s5WEhhLzVVVnZaOTZG?=
 =?utf-8?B?SVQ0bTZKNXVSd0I4eDkxZTRRbld0bzNYWmZEQmZyVEVIQXJ0RTk5QXZJczFh?=
 =?utf-8?B?TUx2WkZ5VVozdlJPUklFVEFXMXRvZ1JtYnFKbFAzMkpaREJPMktkdE5aSXky?=
 =?utf-8?B?eVJJTC9vSDladng1WmQ3eVI4Y1M1YWxGWkNpbzRYV2x5SW1GZz09?=
X-Microsoft-Antispam-Message-Info: lGhleGYeWpPr2asnkn/HrFJ7fBP6Ylma314GMZwmcShGBnhoj4sSaKRKC2rr8mKp9SdDM4fi3frSLrtDIsT2ExsjUw8jpYMEhG6sPfI/6wtAVUItD1MjjGV0s86UNO1YhMrt59LSP+Ro4pMR01Z0oRVw1i3SKCeqdhQlRS6wdFDsQyiukF48arGTGcwHZkyP
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:wTGd672+bJyP40f3BF3z1jwMIj+y+U74MAWNNK/IJSe755WR50LyRDR+k0LOvGBE6Jkhrz7ZcrTkxIVDecDYilRjI5F9nuatotLExfFIN/d+uIxJeH8cPOcJzYHvGtW3WPSCDIp4F/l5f7O7dUcwNR+seo2NcvL/7i+cAxIEbuJAyNjffQZl578mfxFF584AylzaG2or2zDG8D9pPdJ22xZ7Z+iUrh8EiNVxE9oo8+UDnoTCXEgHPQVdTeUdWr8z32tg7F/HpBPzjyNyQWeuKGlnxNsdDId7N9RyKc5dGBGG0u1vd4vt7ja4Xej0XxsxgDuQirQPAnlJW6zeq79twYj3JUDHfTpsngLNZN8IOC/i+tfx6njjGhvcCRVMvLa1i1pQaPDNg1NRz8iEJ8Eniew6LJ91jhhamagzE4MDySQCsGdSmlTZa6LCzLnpsHx3IAByYVFcxVEj5q+Yd2h0xA==;5:AjK6xRi8lYShu72Qe5iM83Hu0eRoCFpIkU5Cd8izqAv/6FnfkntZrxvfByN41mPPBUVhHCa6aG8ACESzQzUF5VRZSrBqj+bTcN2JXzRmVhhR4HyxBtA3dNoOm5jZzMznTq0OSNBrh5f9tjYdW16Zh8UbP4vuLiCiKqppI7fp2EU=;24:BgWohOFNvF7GFTKhvBh25U3gJJL1DQ3qM8AjCH/33GjhHLuPvx1wiK5O9iZsnMBODK7vqWXZPHwMg6veY0hhLeVwV1dWyoVSoANafaGryzo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:E0RPUDE8rcYtq+BaKyC+gcgpDr5WWH6F3k9cyeN8jJHgm3EBUwPI6mw2f0Qw6e9PuSaxElEZRXGDAJzqO8AmD8b6dyjhdkWsR0+1u72F773XQ7ZdIukebdVBWpmxPUz70gjBOxLSmJoMKUjtpS7BQ+sGNvh8qEDK7Y5vy1Ha0K59OudxopQitylufCL8UpGAmz78V/DDQ/2uayycYaZbQpjH7k8XkyJpVZyNqJknE+jBXYB7+8edc1n7lfpE9FCC;20:VAoLuRV0gAoQPH3C0Z1219CzSybrtA2aKN/n7/noXrlsnAucNBCoGk/Gp2QBiJw4UQRoRBcC0/eeTo/5NXKPxc2Yu1VaveizbS9NKHdbYKM57YH0uTgarzYWwRWKJvjMrl+xT+AvPBQQbEQb3CClPLQ3w/Y/cJWmXC70//G7Q74=
X-MS-Office365-Filtering-Correlation-Id: 374a670a-12c4-486c-1d11-08d5b5a40ced
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:57:30.6422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374a670a-12c4-486c-1d11-08d5b5a40ced
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987576438598213?=
X-GMAIL-MSGID: =?utf-8?q?1599987576438598213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/workingset.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..c3a4fe145bb7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -528,15 +528,16 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	list_lru_destroy(&shadow_nodes);
+	free_prealloced_shrinker(&workingset_shadow_shrinker);
 err:
 	return ret;
 }
