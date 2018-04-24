Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/RRTq9T/qcmiM6RT6bIzmP1RF9EiHRuqLh9x6WwAE5GPgu2k2sOAX0KFpS+pkL7usiAUjH
ARC-Seal: i=1; a=rsa-sha256; t=1524572060; cv=none;
        d=google.com; s=arc-20160816;
        b=R1jifodKUvYTvZOufcVpapGpbVjXdLGGhwDZwJGpMxzGJAbY2QWj0LNIZ6QA0RCehF
         FzHKCU9lLsEmtjVJ0mtC5dREkQFvAXd93ZrVYazlrU8aEUvnQ5PQIf/rTzJz56UF21pn
         dVehMq7tz3v0GqUOPIJGKUQr08+g4UYDhIx2agMssKie6wi70t5FzgIWkY8zenpt4Dmg
         z5PskucFHZ1BsDcep0MPdplvZnpZQBxMOgtqtLyE3w73ZUjRYpagVohhWb3H2to1OB4T
         NZ2yZzKFcqSSQdEW7Pd2al8mFnQYYhs3TLmwCrZruQ1QgfFrfHCIfMPzIeznQeEAAeRU
         dCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=9/oy47YN9JIJ0FowC8Y1aXbCQHUTvwPVCu8uFAcDMEo=;
        b=EiH2UaUh8J/KWxV8E+drz2eXqTLcz5iKvqtlbkRhE8i3uAihXQr4EXpD+kJpw8v0mf
         P+t4DFRaanMe3738okEnOLCHkfuH6TeWjUCIn12stTJbYuMOI9ggSOrbh8DJUE+JaA/6
         eVegcb9DQCZNHpcHOz9EkFhmmWVdvvoqx3UCO4rX9hWNDyZMHuEZbvTVOXbsaTrZ5q0E
         /j86iou4NmmFbMl5HQkU5I5qKkfBEvp+sL+lwjG8q/5DPPcv+NrixDDjVYpf3ba4xL4+
         HNh9D7Jkz6A/V2XtAq6wBv9UHL2ZNuusdE4GDxp2DG2RgDnl7kYgIIU81376d2P13qrp
         HY3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Q8TW5+YX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.115 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Q8TW5+YX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.115 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v3 13/14] mm: Add SHRINK_EMPTY shrinker methods return value
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
Date: Tue, 24 Apr 2018 15:14:07 +0300
Message-ID: <152457204771.22533.18309568262632772913.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0069.eurprd04.prod.outlook.com
 (2603:10a6:3:19::37) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:KCI4sIJ2dyKTvEKUkZ5fY1yFndrMSWg7MF+4kEm3UJ4YpjL0D1wKLFsG+V001s4ArlDRoPN7EiXMyv43UHnZu6V8grgyirG8E1N07vUBNjbmmQQpYgXb5f9lVCbqmSb195BRk7fnkVob8EmsN6AdRRirWQZ/Te39OUwg+UzbUVig6Yee+UtksA2c/Ty/qg4QwXjqTZK6xW7yGOIfOKc5UOtRXNvfXWpNybCzPPnwe3jiBghYSz6QeVPHiJBjd6iv;25:7+24XSw/6aqDqikpoixKGfy1tC4HsYNVIMNRyAGRBuZLkz/mYS5pJvg+ABCo0if10/b/MPAyvXPvLaJhQjINZNRAVXOyHNtRp+BtLyPNSAqV5Lc9l1A+gDZTsqP8AqbGa5+dMfEjtambGP5AkEFsCRkZFweYH+1zs4hMdTJXBPo200hARG9MjK5nrvFlmhXjsqrOY4dfDU3iFZXeHdAcapmAgwcEfsfwuVE4xMYUwMGqkw6UwcMQv1PUquZ1Rr/TxZLkieDDJiTxhRjSqcYLnj0x6M9Xekd79XHfkQFIOo9sUqVcfSXzQUGX222GLXyp2DT/0Y6LVMDyZD256CK1/A==;31:3mJWIhlP0FGyd42n3QM7uXp8UkkKvt84wPxUKOVMCA8M68pUJ7yHYF1IFIfLRxRNg19xuUFuZ06yPfRAWiP+tJS/2PEtL9a9VCjTH3CZ1CyggtlpvN7HJEb6RHNgpAPXtr31ZXqa093bogWE+lQjiLGfGz02HvUX36W+0/X+KI+X6SibHGiZ0KbAqwGK0h5yqhbG6JK+jVIqn3Hkmrsy63YjwSFtNanD/iVgWncr5ok=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:yHK4d4nvNKSmGwhnr5uoX42UoifVCIapgLU8keEZfzJ1s+Bq20uI6o0GZS60qTLLB/Z8sptfWhFrOyRrTH8isFtDpMmgPHdSUxTgy821bu0Hd4Bn7w854TeVfis7l2mtVRD6HhbWyhWkwh7TJZVoME0wVUwlK4J5fHSnwzMtvVNk/KfK7xYtxNCAWNwk1sGogaE76iWOtLvy1ZA5ht0cYz6ofev6tqxxD/uVG52WXhQxHiF9RBaJEgl8dDxyKua9vUvKeNv6LzBAObS7u03j5pfBYrhglEmvGXgav2yQbBdKJa6wSRCrbnQGU03IicKWg0NK+spIsDwbupHhzwlx/O3z0fX+MaUaC7JFbX+8+skJZ7v3eZ4gppaY1vFjxrbAPbyY5brnkhDuUAUFMP5k4FzBKFL4eMU9H4UNsGIhHX+bsxP/EFeFTswYXsKoM6OYEJWYyYt69epXgkGOoA0geSqdZ02YCEChxyv9g4mnK3470M9BPo24wvmYAywRpsc0;4:2I5JvMhlg1RYg0Z6eoBbmNFNWrxsd6jyBX9MweKUC8wy/58iMpaEJxGq/GzZnOL7ZimNho+Eub9zzs8/cmyMng4dSvMnDZvDK0HvadjwuO+zH347+g1GygBDGipTzT/Wb6cBNNcUhPdpSEH9XSA3yVr5snzvkVHXuFZRnKeIn44y8QzlfTA8luRaBNfiQagVWRA+DtZEFnDTJ3B7RqiSUOs3R9Wg0n5eb5qXEL8gqMS7kZ4NNIPxVhH7kqERFuJH5FBSkW15pdLHgJJsLLRNQQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133238E471DD468FC5C7C9B8CD880@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39380400002)(376002)(39850400004)(396003)(366004)(199004)(189003)(106356001)(2906002)(66066001)(61506002)(50466002)(33896004)(59450400001)(26005)(575784001)(86362001)(7416002)(6116002)(8936002)(103116003)(7736002)(3846002)(9686003)(47776003)(5660300001)(478600001)(305945005)(55016002)(230700001)(486006)(8676002)(81166006)(25786009)(58126008)(476003)(81156014)(53936002)(97736004)(68736007)(186003)(6506007)(446003)(52116002)(316002)(39060400002)(76176011)(956004)(7696005)(16526019)(2486003)(23676004)(386003)(6666003)(6636002)(105586002)(55236004)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6RWhXaDB0SnFHVzNIZk1BNElGbmNLU2cv?=
 =?utf-8?B?SytabndvSFcveUJ4ZHd4dllQZU5iWXB2NTFyOW1hdU8vQWVPam5mZHBuU2M1?=
 =?utf-8?B?MHBqSk4vaTdPQU5HWXdwZFBVNDFZeHFCL1p1NXY3bnovUXVMUEhlN0w3QzZx?=
 =?utf-8?B?c0FOeUxRTWd3K1pFYk54MVBGSjBSWEpMbElpNmtqckYxak9qbUxSWFpqVEV4?=
 =?utf-8?B?Z0VmZUpJdlprcUpLaXNybCtnVFQ4NHJTVlRsNzR6d3VnSWxSY0UvSXpQcEg1?=
 =?utf-8?B?K01KeWFWV1hXM1BKanV3cVYrQTJFOGpGaXhyNHB5eU1JRWZmVEtPSDQwT3pv?=
 =?utf-8?B?Qlkrd3I5Q1lXT1V6bGgzVU40Y01HYjFXUmVCTldWUlVtSXBtL2lFMTRIVE1L?=
 =?utf-8?B?R3dtcm9xRm5sRVBwZFJsVWgweGU0WFcycktHTHEyYy90d1BDc2twYjB2SW8w?=
 =?utf-8?B?MGZGeFBMckZBZlI0SFltVjBFeUJYSk1TL1ZEbEVRbmMzUFlQNURMSjlFcXkw?=
 =?utf-8?B?MWZLTzRVc3VSL3BXM2tnSzhqYXNJUmtMSFlwZlVSMFB2TzM4TkN2K2JISmp2?=
 =?utf-8?B?K1VTTFpmWFk5TlgzZkFydTU3RXpyMWdXWEhCbG04T0Z3UFlmMGhFY1ZBMkVM?=
 =?utf-8?B?emNJVnhiVlpJSGVtU3I3ZzNIY2tXSlQzQ3pzOHEzQm9HLzBMR2draG02azh1?=
 =?utf-8?B?ZkRmWEtqRG9PVXZ1Qzk3MkRNeXQ0dmlzc3JkcWNXb01aaWZDWjQxZVozNnFE?=
 =?utf-8?B?UDZEWDhERDZnOG5wVUs2YzlHbjVtWTRmeWttMDJ5VGxJUUxqc296b1E0UUk3?=
 =?utf-8?B?eGN4R1d5enVrT0N5R0pBaWlXRW9MNU9nZ29NVzNaejVsV0J0SmxKOVFLb2Zp?=
 =?utf-8?B?UjRudW14SEhpSWJ6aWZRWk1KZFlSVVhNV2Y4L1VHamttSTJab0RZSW1DN3Vp?=
 =?utf-8?B?RENzd05UUnU0Wmc3Nm9Fam9pVDVSWDg3SjdqQUthK2h4RkpLaldIUWcrWGQx?=
 =?utf-8?B?V2FWZWpvU2R3dFNIc0FjNHVsaE13YUZEcGxVVW8xc1YrdW5wTmorMFBHSC9V?=
 =?utf-8?B?MnFWQ0IwLzVLVHFic0hYQTlDbFphYndBN3VLZDRTZ3FlVllqNExXMGFJdWlx?=
 =?utf-8?B?WUVkQ0pyT1VpTytmNDBKMGkrNFd6UW1HeTVReFBHR2NjOTRJc2JBbTM1WjlG?=
 =?utf-8?B?K2NWR1V3L3B3aEk0NjNjQTNtdDA3YUd1RGN1WXk4elZsaHFiSkd5eTVkUWpF?=
 =?utf-8?B?OWxFWHdZTjBJa25va3c3bUdlT2hOUndYWXJjaDV4UHUrZ2lJSjJ4UFB3K0tL?=
 =?utf-8?B?aTRwQkx4NG03ZWl0bDRYRWN4aHZQWFZ4eEp3VHpoSWJoS2hza21KbU9LQ0Y0?=
 =?utf-8?B?NXF1ZjB1Ui9pM05zNHpRcTI1U2FaWG9IRzZNUmZVeW8wdnkyRkl2NFYwdHZh?=
 =?utf-8?B?Nm93NU5jNGhoSkVkVFMvWVdqUUNjeW5vTWEzTXh6ZU80ZThSV1FsZEYvSVQw?=
 =?utf-8?B?QkJpa3pUMkdJY0VyQWZKOTVITkhpaHEwdkNsODJWNXdscTQ1c29ZQ2J0eUFu?=
 =?utf-8?B?aXFYeGs0d1JlSWxSSVNaVzA1Zyt3OWFZVUFyNnFDY2VOZGcyQnByNEFWYnNq?=
 =?utf-8?B?SUlmZmh2NVA5b1lDNWxOc0tiZllidjFkSEpiNUR6Y0xGQ0VrSTFPVUtTenFt?=
 =?utf-8?B?ZzNwd3lhWUZMdjdOZ3BWcER5NERHYmRHS3NraFFLak5xbCtvYTFrcGFZMFFR?=
 =?utf-8?B?S3EreVhzS0I0cXV1L2FYNGd3UmEydjJISlRsMENKMWtFT1hOU3ZicGNxM3g3?=
 =?utf-8?B?bVluVFhCQkx3cUQzYmpWMU9EVnhtVmlCUm9nZ1pRZzdHYVVYVTQ1c29XNVo1?=
 =?utf-8?Q?H+4lTAj5XrNkA=3D?=
X-Microsoft-Antispam-Message-Info: VAeCcW5SMr3/wiQn0y5kDIlrkTwwnW2lHnHCvlaNS1/oJkzJ0QP4nuMLshRR+lk9+1emJ3U0n83X2YJgDzNyd7nXE0dCeA9xmy5qsImrfb7RgSL5Uo43/VDVoIot4i/82kLJpoQPaNtrjRO0JiNjgq4x8ZolEbQfU/g530T1fQIbK52NSPydBB6Vqvxkze/N
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:iWJqiutYGfrthn8nHvc00LNG4fWpjHEKF38sv36l6rwyr/jb2CT5i/AjstaqaAH62qHc6ZNeg93HTMeDdESgqJYPJ5ZWvNBBaxWywgb6ob8O0Z+XPuv7FKOCYBH1xNSbn747i/jJDLe3Sk+GGl4AubYKjYjh7L58ooLlvzAB7wJSHNy7rztV0VhqdhRnJHEbyVZcmNFFpf/H9IKGdldtN08aAJEeRVu7UOePbLBYRu6Mo8QAOMj0T9HhSO4S+LDp+Za7dXmpsy8LWGWJ4bC4/YUd23ftSm9WFCLLHV6Y9C4re4sUGfkX9BLvk8Y/x9R/VfjdQd7cDtdg+Ht9SLkccMUAGcnUhRDNZZrCUdZuXbeW4JpQwzy0+RU2bbgsaryBnnIp0B2FR+cu0DNM3kjh8Zjo5xNKhYZMUH3PvhH9dmjWI1qnwgo1L32PC2rEs4ZsNV1FPdMW10NhKp0a0vHPwQ==;5:s4hdphALtvLSoateK75MaWSnaTVnBwHTiuUJ/ZBdl32IgsVh+WSJZtD2wxX5Kps0d0uwzivgKKNHkitprqABPAirXB6totMyj84JZMbZlqo+cMmHmU/55SAziprCJHLQN09IXpSdnsLqxD5qwb9sv2T7/7Lc2ndbpvhrRX03rS4=;24:Tav1ksvZTpKNhdM7S0cwT66VfqhhcLdVv9bhVNHymnkhDFBsq8d9MpTsRoPnAMMvlS7m7dBe1pXLc6FVm2eZYvWT+ilZqzd34gHdxtPxqP8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:PXT8GX6CkDUphyJou6qO6hZHjvcoZ6ECP3/pkiQkrnKoyzOEg5IKI8nZTETOI6IGednLI6yK9zYo1irUylBB3TUMFjfbCvNQY92i4NMn4UyaSQGWDWOsjpAHIIQ6RsnJaaURUsBMDXFQHYO/Idn0+D1m234STRKaDD9Mvx351qXHldX8rVe704vidBQvromdsgbVi/jRpKBaXgkIPmlixC3HOJg3JUoGBppkpHEHbPKt4E0XtND62JOsuppRtmpu;20:JGgyHSu1efhltP2LxuReJ40UXAWRXsUoeEopLkFlCsxgpF4wV70pQFoqwqscXQbDgDnrBGcvmphuPx4Rj5xEgm2XnGUMGc/fF1mIWIDWWKq2k+jDGfwCyLefh7C8/hA72vkCcff6Lmvervkpd958kBCNP7dMh3smrtHzt+LaETI=
X-MS-Office365-Filtering-Correlation-Id: 42b53dff-340a-4aa3-40e5-08d5a9dce3b5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:14:10.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b53dff-340a-4aa3-40e5-08d5a9dce3b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629673268134114?=
X-GMAIL-MSGID: =?utf-8?q?1598629673268134114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to differ the situations, when shrinker has
very small amount of objects (see vfs_pressure_ratio()
called from super_cache_count()), and when it has no
objects at all. Currently, in the both of these cases,
shrinker::count_objects() returns 0.

The patch introduces new SHRINK_EMPTY return value,
which will be used for "no objects at all" case.
It's is a refactoring mostly, as SHRINK_EMPTY is replaced
by 0 by all callers of do_shrink_slab() in this patch,
and all the magic will happen in further.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index c9a6ef33a98b..9a10e44d866b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -134,6 +134,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index a9ec364e1b0b..4081016540bf 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,12 +34,15 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
  * @count_objects should return the number of freeable items in the cache. If
- * there are no objects to free or the number of freeable items cannot be
- * determined, it should return 0. No deadlock checks should be done during the
+ * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
+ * returned in cases of the number of freeable items cannot be determined
+ * or shrinker should skip this cache for this time (e.g., their number
+ * is below shrinkable limit). No deadlock checks should be done during the
  * count callback - the shrinker relies on aggregating scan counts that couldn't
  * be executed due to potential deadlocks to be run at a later call when the
  * deadlock condition is no longer pending.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f09a6104b28a..f57f2893d58e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -446,8 +446,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -586,6 +586,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -633,6 +635,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (memcg && memcg != root_mem_cgroup)
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -653,7 +656,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
-		freed += do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
 		/*
 		 * Bail out if someone want to register a new shrinker to
 		 * prevent the regsitration from being stalled for long periods
diff --git a/mm/workingset.c b/mm/workingset.c
index b8900573db25..ae0555169b22 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -402,6 +402,9 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	}
 	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
 
+	if (!nodes)
+		return SHRINK_EMPTY;
+
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;
