Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrGY1BAFl7UW+E63CovmuXDPW4VfW4mci6Nj3kSpZ24Bz8ezM3t3FVGvWwSSAjMgaOE17Kf
ARC-Seal: i=1; a=rsa-sha256; t=1526632916; cv=none;
        d=google.com; s=arc-20160816;
        b=fwFvffucQZ+odcliztjwckfC4z/8VT5u5dtrcNUgHqWmGIVTdBUGXfw3d5m6eF7HGS
         bJlZ+bfKaIbyjvYA6GKFx5HzaGDKAff5WLIKxlbOxGTdYelul9KZ1/i5S90izFDfzUvV
         A7f3Zh+4gExn5IQD0HrX3l15fX9t23+OtSJjQJ08FF+alWcpSDGRJj0srb0n0od4sWq/
         bHeEVtfz96gypRTM3bPuYyj9FtvrK9Oh0zMZ3ns88gkkhA8smGnzkReIwNN+mfpL/5/Y
         dhOK+R4p1zz6ZJ+aD4SO+ug/HWYwpVwJtYXkAnzL7xhEG+jYoVoqZ2AHSFbyuaXLvSVQ
         1XiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=oW11i30zBrKa96sU5BVO6oG7fycJJIVLB7zRwT+/oyo=;
        b=yiv52iDopAekkkUt4cADkqdZpcZOmm+1jVxyiEwLvU6P9Jc+F3y+jA4G3+8l0RDm5A
         ESmLJdHMhiVnZwMLAbpeX5j4KjjfU0GIXjlkzpLEm0Ny68Y3SdgAczTi6gsk4IGmt9Fj
         nYYey3l8En39RC89s1pcHfwg4zY97y3yT2ecBIay+MUSS/iGFIsOpasqH2hFchn1ol4d
         BhChOxSRwcZm5YtC1YFEjp9Ao52s1qXj1clUBBQJyeiN99vsbx6s94Ke+P1XPRULj1p6
         ReHB1wunYE22LxQafjr3JKwGi+olV/yHCzvVZlkoDCH9P8c1eLR79rV59nfeRB/ku42O
         SWyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=g452Jfh0;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.134 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=g452Jfh0;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.134 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 01/17] list_lru: Combine code under the same define
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
Date: Fri, 18 May 2018 11:41:47 +0300
Message-ID: <152663290733.5308.16296237702670050699.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:7:28::15) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:V4EF+s4z18HRiq9syr54QRXGP1QNk1VCBIaHqCFEdZ0zoz1IkFQGTmpqSpEe26Ry9sL14xWQyujHNjQTpzcKmSWswiEyYJrScRsvVglSyoZu0dNjrYwQH2IimKabEIp86NAvsNPw4m/u/e/RlM3QGjk2Z1UWcJe9VD6fLiHLg37ZlukM4fqnjdAti/mqJ5AZqeLbsXwrGBHVxDve3oy4sIkWZcYTZJ7YqDAFGrDdTVOiCyG4+nM7mdFOSrJVfHtQ;25:eZKyv/VYQwaAwhtQW/PLD59ndSBNIJKhQ8Pnb2j6ChUp9LoI8oXCDCdqwiHtrz+Cva3Fe1hDvL4lC527LBwxK2R3+cwm44DpAXCkFotRcwRqivodtM8J+7w+lCbB5lF58qpqSzk9UEpBEh6KQ/9CJkgLie39wbL32lxZaeaaZah7IH1Js8AT7G9QY9ypywG2QQgw0kfa5qH42Z+1WJ9CxINWuADm9bCzzV43ppkNY0rUNH8MELxFo6zzejVrFPZ4zo3R2HRHtfbOPUdb+RpQve4EbNdvn2VoPfviF8fdJdM7AWlnzhI9UsYlm3zOXHHwF8SFiS6nAjd+0kXEFpg7Dg==;31:ihoOViVt68JNvKgTg3CpWeF7BcY6mg0k0tRc1+72gByv+LDjBobnjxUJW4qxr9Nj4Op7D0sfic051nAgBH3qrv2u7D8lIz92ov9+IrrXf17p/FpD9kpVv8AVQxtRogfVmpignOwNh23RoohN8CjzmvAX9IM8CcUenJsaOYvUXkJ96gjhOdNIsVEW0TC1q7vSvVRzFnYJPhWPMwjqjXXMvIHyLELUgom3b8t9mn2AMDI=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:WGH+n7t9/pHsU9QMnfokkV0/3mRm4XmGLSMxy0hpf2Dcazx8ohiH+zzpJU+OY3k5ClUlor08sEZp3ACmH+6+Hlgg+XnlcmVw0IWznP+6vO1TFusi5sIbc4KPjAG4rONppezS+nOPCYGJ/FboCgy5o0qE3EiKgUuRNdBDFOGddR3AbcZPXSv6/c3Kmwe072yaDCMoUkDZls5gdiQpw5/TRXKUjLpUOr7osqvqaMGZr2LrtJPK/JpIOUA1xx0Arvgad5J+wieSEInmwSG0bfpNSr2+HdzdBau+71/W/3otH0UX94fGcSki/vQcYSSffwsLro+0nDkIA4W2Uq1ShU6ErelQfAdsX0PTS4GZaMpHU3E6JDPyaLxIZzCeMTSk3cNQRmCY/DSOWbnBDSzCS2zyHZripnHvGB0ffewg+732dLzMmsLBIm2ymclVgZk+LM6oFspl9+0p4UGjQyv/HrFXoubX4FMrLM3tCwdZtu/RwgjRTQgVA4mL3TD8mjLXfmdE;4:fbu1gTfj1mG6sI/rTQvW6g1ycPyLxRM92bfHILXWHxAYkh5ttDxgoh4FpCNMxKh+1G42A+5NB3VHPXVH2lz91sxPKGQ3BUB+7KfIXfWy2KBu9+Jut6+aiEIPF/F8dTdq2d89ERm/CP27uSLwDYEZtMZDMG1hBTGzUn2hClZ6Ct9cB6Zj02AAnKvjqNiHUFZ4JLJl6YNvslWi67KWLe+p6WpaXyK7btqUEMYqFDMYlYPrGkoik9WT+AWvthBvkyjNhH8k7fnwvkZquJOLEtBUJQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB134440499C31851F7FF701E2CD900@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(346002)(396003)(39850400004)(39380400002)(189003)(199004)(6636002)(3846002)(6116002)(9686003)(6666003)(97736004)(58126008)(53936002)(8676002)(446003)(486006)(81166006)(81156014)(476003)(47776003)(66066001)(956004)(230700001)(86362001)(8936002)(11346002)(55016002)(478600001)(103116003)(50466002)(26005)(25786009)(68736007)(316002)(2486003)(7696005)(23676004)(7736002)(39060400002)(52116002)(305945005)(105586002)(55236004)(106356001)(5660300001)(7416002)(6506007)(16526019)(186003)(61506002)(2906002)(33896004)(76176011)(386003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6d3RoS1J4RDdVclJsSW5lK0hyU0NiWWtN?=
 =?utf-8?B?UlhZTWNBNVp1MUZ2K2trM0xualRaZTBQdUpmNzRPS1FNaWFIVzRreHFGYlZN?=
 =?utf-8?B?bjdIcFhMU25VRVNiOHVYUXBTZkpFSnQ3VlE2TWpOazVVVVE1bW8wSGFNNUpp?=
 =?utf-8?B?OFI5bjhHcXl4R21vNnBDelFIcjlSM3ZkcTd5WkFqeHphR3hWYi9vMXJEeFZH?=
 =?utf-8?B?YXU1MDZsem1qWmRjMlB5MUk5ZGFKaFdKQWsxZE1nbnZiZHJQamloY3FLVDJa?=
 =?utf-8?B?UDU3WEYyUklJQSt0RUJSby81MTZNSElxdkxiakZOR2xYVzBuZk5XY1g0MVBF?=
 =?utf-8?B?eFJteGRUbmt2RERlK3JmUWZVaDJTY3ZjaFM4dy9JUFhNL3A3SG5jOWVaQmpl?=
 =?utf-8?B?b3Q1bnE3TUV5ZEpRd1lNQXBNSG0wWFFxL29WVGJveU1ONEwzdzJjaWhUNWpN?=
 =?utf-8?B?QVBiVzJmVHhOTWVhQmFnNjJTR2Vnckcza2h3bUxXUUZ4eFcwNXlVSWlXZ1F6?=
 =?utf-8?B?Tm1oVzdRdTYvMExXYlZxRGRnMURhL211dHJOMXJsSzV3eUx5SUN5ZXpEMk42?=
 =?utf-8?B?cmZUZmVFYzhESUZvK2p6QVVTRmpZUVVYSUsrVExoZ0JTZXl1YjRyWTZmeEo2?=
 =?utf-8?B?YUk4OXRObmUrb2dsaG5NR2JIYldTa1lWNmk3K2ZWRjNpcDJrUEJCalROSHZR?=
 =?utf-8?B?Umd0WDVEVlNUaWVFcWVHTER3amRKcXZIWVllNjF5dFV4N1Q1L09sNjZaaVBW?=
 =?utf-8?B?ZG9ieWJwOU5oSmU1VFdDdHNCRXhmZHFmdmw1N2NGYThOdjhrZ2pPUXNsNDBo?=
 =?utf-8?B?R3dsa0ROMVNYUXFwWE5hTVFyOVprNEZXOXc4am1uazNaaS9YOUNLa2c0Wm9v?=
 =?utf-8?B?TVhFQTRBS0ZrQ0pOaTd1NlVVZW40WmhnKzZNc0t6TktwUVNFVDhtTUxCSmZI?=
 =?utf-8?B?dDNCaC9ZNzZBVTI2MFVpNXBnVnBpVXhNeDF0VFVqY1JLMFBLb25OMlEwWjZ3?=
 =?utf-8?B?U1BvTlh4M0dBMmNzZmtRZVhvZFZrd1d1dWN2Ykdzd2dnZDRHNHc3UEwwQWVl?=
 =?utf-8?B?MWQ2RVBOV2w3OXg4am0ySXMrWEtqRlNzSHIwYTBNZTF0SlByQWdSSno0S21Y?=
 =?utf-8?B?eDUybytQalh3dm8wcFhrd0g1UEdYTEszYWVpYmNlMkVuQkJWRnJ3Q3piUUQx?=
 =?utf-8?B?NGdFTUZMRHN3bnd6S3lhOXVlYkhXaGRkY09zVzRGMnZRZzdWVHhGVDJiMkoz?=
 =?utf-8?B?YkhaelVmRmZuN2dTczNWNldDMTFhVHhwZ2s3MldwemlQK2M5enVUNHRYK1ZE?=
 =?utf-8?B?M3lkbzVOWFlMU0xHR3R1eC8yT0pSTU5tKzhPVk1DZXVIbzkxSGxvclBxdXJ2?=
 =?utf-8?B?SWF6Z3BMTmtWWXN2VnFKeTZVYkNYaUhPTVlIOEY2YlNnbWFVNW44dlRBbHBR?=
 =?utf-8?B?YVJGY0JTeWdqUm1IcTE4NUdEQmFGTDB5RmhQaXZlVjh6THpKMzFKNlQ3aENU?=
 =?utf-8?B?WEJXVGt6cVRFNHVnZGttdFh3WUpETFhCNzBXWlJZNVpQdzFmUGd3cmRKaUpB?=
 =?utf-8?B?UFA2d0c3SkFzdkVwcG9XYWt2Y1d4Vy94ajhKTHpJdWRYVEtBK0JLTGJQOUhE?=
 =?utf-8?B?SE9yWkJZS1Jha3NwMkp5aGZLYXBRTUszYi9kQjZvd0VNbFBkVDFNMG0vYS9D?=
 =?utf-8?B?MVdxSUZqdGVTMU1tTHJNTWUxSlpFTXczOEltOHFVOTQydUhpekxDTm1LY3ZX?=
 =?utf-8?B?TDZCaWs5bFprQjJmZm5sL0xnUG1leEtFaVRoTXZJWXB6QTVRc1dERjlZWGk2?=
 =?utf-8?Q?wPld0g8qUtAt5/x?=
X-Microsoft-Antispam-Message-Info: Xwn7/M4UyNoz1oAh5p22mRwnoBlumqQDSg5alhOxnxNiJe7+yLU0SlTpWHf998FJcfAg/LljqPZydGfhaG3UOKGYgSR8hJv6q/fBGEA6pXUddCAbQsFHQm3sE9VtAaZikC2JMNn5+IxrQMuEO883NC6Afxgz+lUAp7QfJfJ75juU6VnH99A+t193AP4K3uN1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:ZgHRkxbWcqh/7eJyi0p3Gsu0GADfanDHkITWUGrrkt17qv2eaS1DBdThdcwGP6ZmBoS93vLhL6qPZbPxijsMi3PDR32+kQqMWun7N/PZGpQQ/DKyAcJ7+Y79IMGf0rkq1jU+RYDYDboBAj9JTeuC8z60dQBbtQl+geSMp+TKkuVHai49GGQHT/mlMFlJso48MyM07YCfAQs5EmfF2D6aSE/ULyjnz3QNyy5Sl8PusVvZIKp/gPEYsmnK14zwdsdRBSiILHbNwIJJMyzCZQV4LXSwwTriW7F4pCJ53R/i3y7cjog1MQ3EZqJJcIRDLyq9VFXoX7NJ7NY8IQ0erfe9cUJIKFz+QM8T5kVBvQGP1kEthWUkYl9i5faZCubIFZK0DZOMqUekQrnf7KDimAdx5dyS+NBczQXwRbIwuhvHK90mPdmRG/zB4dnoPccUSoSIMyxk5A8kyfI6/HUmIWzv+A==;5:aUTS7TllX/wGLX30ht3u+dcBxa3yjLhmwbhxkXtEU5/VqHRfBRh7FCDkKzEY9APMs0IufF7c9Kc1+AfgEWB+3ZFkFOjhwvk4LDJ1EFFg+fr/gbSGKXJiqqhcqvVSzZg7Btum19XupiYKhkWj58EnalDI9CQFfb7cr91FMmbdIec=;24:PxKDFb/5T8FI2Lud0spAV7IpEiSlW+BRBbwClP38GN8838PPZZUy5quUK82UkJuVNJcXnPCtY8afT0KJPA3IDWYL7FDARWIoWkyfYvHM1Ws=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:3lYCNRtZsJD9nJBKlycd8iKPSWyUwkcYs6+nvwZhJI6qzZE+Cd9SOFFc+M6uUezsuzioj8TH0vDByNiSxVl2m92KNMuX8r7JcwChjD8OeoWcuvO4ejaInz3/k8WsfRqsyi5LHuDSqFKYaC231WyfzbKdbeILxwx9ZVOErvDXvcKiBKYD/zDFbWT1ho4B3Pe6JLf3PWcbMtMHMTw9Hs/DzZO/9zUiMEGv+FmLrJEb7p0xGxwP/CpeF/64ETjyRbcn;20:258c3sVkSkFex+Rl7tZ8M6mJ+RmoqXw3rlMYN+lkOngp8C7VVjPpW9r1tjok9C56N+BKBI8NWLoc8oUvaidnju6xTYK2wbW+/Jual309MbRpWEl/SU4hz669Sc6jN1OzVg55Wbt4IMrCb3CX3PFKDQxa4lC4JhELXeP/clBFQko=
X-MS-Office365-Filtering-Correlation-Id: 4a817e13-4f4d-43b4-5096-08d5bc9b3434
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:41:50.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a817e13-4f4d-43b4-5096-08d5bc9b3434
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790637106627986?=
X-GMAIL-MSGID: =?utf-8?q?1600790637106627986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
