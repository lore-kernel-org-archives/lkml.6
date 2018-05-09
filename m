Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrcr6e07HjM/p6/j8e082Kghq+j4Xiv3gcZde6mg2ld43M8z+wgqnvCv6VPKHq6cdsuMmZz
ARC-Seal: i=1; a=rsa-sha256; t=1525867134; cv=none;
        d=google.com; s=arc-20160816;
        b=bCEtFzvzoKSOVBWtsTUTSEf6IX4vjq/xGD2rwe3qIEgw8yOoLc+dF8ZMh/M+A8kayZ
         7O8QhvHFiSFSun+RUy+P+RIgIPScd3ZHvxOt6+FdNsK3MDH7PhOY7rLcvLFX9amquiTG
         3FekGI4SEJzI4f2HvfFbViwNqEba5c9Rsyjg7Iy20+Gn27qDwzi9W5k+PJ5+4mDHM0Sy
         b16rXmFn2JeLoD8oErDABrfSi4gEw/rPI6SBS0661WtlwIIds9TaNN+yL1FAyrjAIBSc
         LUTM6xclzqu6zT+OGP8xJZs/queXLgkvD1SDGr8UPn66G0zFmuKWvfayek93vT06RX/q
         8lQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=2BVaPoyhHU271CdITwsMBsYRlNgU/KGymBGpX44Oftg=;
        b=Z3+KQvPbnMSLFketaTV1+3yp1Z8UyYex0RPDFEkmTon5xxUYe7BVP358C3iIHXzahA
         yLCSKK7tgZDr0sTvm5GaKF5b9NoRw7QomT3FbDBtg+B1T3LnNv0gEja2yqWBluv1vk07
         xwCoO0yEOIFLNg35XV1zRBoA8xDxuCyq/r4YRf8Y7tM/Zhh78WFrVNq3U46QZJuilwCM
         rHKH6zwP4G1tE4u3oo1gKWLSF7IecUT1V+nBhPrmJdLyC+ROxavXLDQnYjrUHPgHIJjb
         Yi8RS8ax9v4jbjXMEZwVOM8Yw8CVnG7q/KWIwStY7/BzKlz0enkDF/4jkx3AdAxycZkj
         YZPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fG7wJhDg;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.122 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=fG7wJhDg;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.122 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 12/13] mm: Add SHRINK_EMPTY shrinker methods return value
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
Date: Wed, 09 May 2018 14:58:46 +0300
Message-ID: <152586712683.3048.16055139533907163272.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0114.eurprd02.prod.outlook.com
 (2603:10a6:7:29::43) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:x1COdh7Nq2reBvIs5KD+iIYZMY9XG2QHEKUjz2sgD9FUY/sJf1GcqBssappLz6YOLyG8gxPRNAUceO1WGqpwg4oUdle3WYG6PWAKvWVdgI4nS6B7Mvqv9DGtRJR9OfQSpSz6kY5Nknmdcf/3Jkvcds53Ns6cbyhrn0KDU6OF0w1OTt8V55QQAZU0MKUqWVp+m6s9kJ5g91/HsvOYDGrjYWPXQIYfVkwiCPNi48HUFOnqvDHppQvdKDZl+gE2p8h0;25:6jvUjFyBhI0sscpo4Y+Ezu1ByK53Ig1pdiUOnVLYlm9g+JDYbm/YVomNthiS/FOiX6HXbEW1BMvHBbKHJHTQepKQvHV9RMzVLedIw2MsrsLgbFW2+SsAXEANTpfm3SJTXyNr2Hc3B+1LVPVxTyx/HxYKNnu3wqIEhfgAup5eVbPW66rRUuZO4ShgodOIisoUCWOLe1K9cEL+EGj7KR/fuYkfmtkZwQxVGCMa6u7uZ9+De9yhgPyPJwOej6AgtMD1TxN6l78N6EhQdXcsp/L+Xv6LBFxI/Y/9dPH5m1TZ5OUnl911NEqSm/O7qXnH/SQhNgH9uJyHr8J9jWMmXOWQSw==;31:trdpNiKFnnN0bGj+tFLTMiCHm+MwTUIoGmPt5UYZ6NbX7jg8La/pIx+b9CEfI+k0NF22/EDCDVWiG4udg5vtTWxTR9TcjyErRI2BZsWYcXpVP0AaFrAW9sP4NWWvzGyQbYqK1BtVJ3FShg/b5VLO1XWDm3atRkfxJu423qogVZsVRgOK4eGEvYAShajds5/7Evw0DDTauT9lXjKA9sGE0urkx36YCYDHNfMa4vYQOGs=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:YuVHNi692waCVm1Ta3SkW2M/7fLt5ztfX9LpgdqrXbkQ2NnQEmgDT2To40CV73jz4LgQyhiGorVSXAocSMQE+gplWOBKiDRe4688PMNBYdxRyt3hBaV6aae7x9+BzF2Qv2DThM0pexTsQ9kA5/NKZLrAaWDQc9KvqHNaiIHICyVOfOR18ZAVcQnOUkcU1EFCahq8hZsAbfMxnh9DXmgFaMlqUpnCdyI6S1bc2X+ECHnXON2TPQs/swu/remK+9s2c5fDrVoovQQh9gm7czcTypGBq2NRvposQP6ueA2n6ZnaLNo08HON/4VJAYepeyFCKBRUV90Wy5G/BVYGzY/kW108rer4wlM8wzKmFAD+TWa4VLBI4QAKtmqw1teNriVtzuA1/nuiNYjECkOgh8CJXbOswkRZFU859F1jB9w/ioEK8k9sEpU1g7hBM25KadYclzE/vFsnmUrTkRDBXllLbMGEjngLkZykwnEhcTPYwyObs5oXADAa7pAanEMTGuPL;4:K4tzurn2pi9N2Rp4POkVweLxgnFk6sgoOiWYkyL3+TsJ6vr442P1Ykr5gOfnPOilKhbLnJGeKjVRE4k7ACqQyMeCaUbS56P3K6yknp30MnsBW8GoobI3KfF0wdVVzAi637d07FSpUL8KHLe6XplBSTQ70D3MEIfq79H/gfU1e92MsEZ/hs1uGySj4EysuFbF3Du/VJySvRpunQ4n2khRJ9q18zyIsj/sL4YqEq+OOmubI7Utusj9Zh1PTMihc5XGHOINcwGA4P7mgi70PskjBw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13306C3750F6C9711B1A8A6ECD990@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(2906002)(186003)(230700001)(575784001)(6666003)(305945005)(103116003)(86362001)(6636002)(7736002)(478600001)(11346002)(16526019)(58126008)(53936002)(476003)(6506007)(106356001)(39060400002)(956004)(105586002)(68736007)(5660300001)(7416002)(2486003)(446003)(25786009)(486006)(61506002)(316002)(97736004)(55016002)(23676004)(52116002)(7696005)(81156014)(81166006)(47776003)(8676002)(59450400001)(8936002)(50466002)(33896004)(26005)(386003)(9686003)(55236004)(6116002)(76176011)(66066001)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6RmQ0NitZTDcyVE5Qa2V1MEJZdkUwbEgv?=
 =?utf-8?B?cGtkRmR3aXZ2RWpwQm5hUXQ4MXB5N3hnUnhYdlN6VnB1WThCSUV5M2VCUlNE?=
 =?utf-8?B?c1lua3lDQm5mS05WN2JIbDNXazJzdURvbUNjcGR5MDlnZEk1eFNNQUxJZk9m?=
 =?utf-8?B?M1hpOVJZNXErOC91SFN5UmVXUllSKzJldjM0endCRWpKRE9hSVAvUm5GbEVo?=
 =?utf-8?B?QnI5MEdpZ084ZjRSTWJXdGtzTnRvUnloc2JqeW93cmMwRW92eEU2WTFrMmZx?=
 =?utf-8?B?d2JIMHkzVHNlZVN4elBQZkp5Rkl1dUV2OThUU3hSY0pCR2pHUjl3TTIyVjBO?=
 =?utf-8?B?YzdYWDlHb1hoS3ZSL05ZY0pBT2hkYWVPSCs4UGk3cEFlSklOb2FhbFp4Rldh?=
 =?utf-8?B?R3hGMlY4WkVwSUpSUkRCdDdKWHFzaFRuZzhxZVUxYzAyQWpWSWN0a1dFcDV4?=
 =?utf-8?B?dUMxcjA2V0hUdXE2TkFMWWQzU3BYWmx2ekcxV1d2UWtNMWZQT2lZWWFjT05X?=
 =?utf-8?B?ZEpzb0REbnNIbnRCRkFNZjhCM3l2dWF5eWY5azFpWThMa1libGZOVXVUWkQ4?=
 =?utf-8?B?eWpSNkFrUE9iRlkzNjNIcVN3RXZqdmgxeWM2MkpTSUwwQXZqa1lzQTkvSGhD?=
 =?utf-8?B?OHBGRnYwcHVtWUJoK3dRcmhHT2xlaHZwUUFRL0FiZllzUXhnZlNVelVXRmZW?=
 =?utf-8?B?VXh6RUNkTDNOdXl3VU5yQVpNZXFMbTUrSXJQSFdtaFU2UWVoU3hxWWo3RlpF?=
 =?utf-8?B?ZG5LUkpKcmh0K2VMNlpiYmxPWjZyaGdvTHdsMGdLQVlyb0Vidy9ZSE5uL0Vn?=
 =?utf-8?B?b1hKd2tiKysyVFdlN3lncFZSS29YQVJhTmFqZGkxQmlSeDVwVDhDUEpXelN0?=
 =?utf-8?B?aDZUbDN5ZHpVZU1wUmdtT1k2VmNDWjFRL0hxM2pEYndiTkNUWlhBZy8zNFRF?=
 =?utf-8?B?V21pREZQRU5nNno0dHJLSGRIR3psZXllakd5ZDJwUDl4NUh0emlyOVRrWEh1?=
 =?utf-8?B?cHBGV201emhQT2NRTW1YRGtQZ09SOUJ0bCs2cWZhbU42dHRDR2U2bUwrN0U5?=
 =?utf-8?B?b1B2dkd2WDExMkM4SUNVeVBaejhDYUpRYndzSWhjeDhwd3JTdFdwYUNtQ1ll?=
 =?utf-8?B?Vlh5NEpoSzJQeDBJQ0k4RHdxaVFySFhLODI5YzY2MHBxTjRzVUdkQVpZRDVU?=
 =?utf-8?B?ZjRRTWplYytwWW5UM29hQjlMTm1GZi9pZXg5NnR4dFpZVFB1L2pwTWFCbW5X?=
 =?utf-8?B?UkZVVWZ6Y1ZMMzRWMTlzVTVRamVUZnJySnFlSVdFT1d3WlJvRUtzUFBqUlRE?=
 =?utf-8?B?Y0xYT01ZeUJqZHdJenpleUwwSDFYWFQrUzJiaXpEbyt5aTAxTmFUTmdyV3d4?=
 =?utf-8?B?T29uMXB3anlLNDZ0QjlpVEkwM1lMU05RQUl4NWs1bWQ2S0lLNDNpb2owam5E?=
 =?utf-8?B?VUVabWlqc3BpL0ozelFSWnVqaEErSSttZll1RTZmaDA5YjRqd24yclA5RjBr?=
 =?utf-8?B?YzY5dE56OGN1Q2lRdGl1dUU0TVpqZUZkVGJSMS9WaFdkNHc5YXhqZmUxc1ht?=
 =?utf-8?B?Mi9pdW9GVnFpMGpjNGFySkpXM0dNSlNraUlYM0dyTkt1K2E3UFZKU242eTZp?=
 =?utf-8?B?aVArVHgxVTduUHlLRjkyV3U0WkR6VUxpRzhLS0l1QVczRXlHR1N3alJEaEp0?=
 =?utf-8?B?S0loWGg0RE90K2FPekNSZkRjclVXRW1odk5ybXRERGZMdkVFdWw3V0FZZ0ZI?=
 =?utf-8?B?aWRMV0ZNSUFIY1NPTkYyYW11QytnN25HTWZVTStETGp3VkhYcVdsazVkYVc5?=
 =?utf-8?B?R0V6QTJEQnZWT25PYVFQaHZVeWdsQjVleFU2dHgrbDJSWEo5VThXTm5sTFZa?=
 =?utf-8?Q?/EewGZH3N8Ijs=3D?=
X-Microsoft-Antispam-Message-Info: 7N6wLYUWmTcDyRQ2emkhmqJfqDkS3bEFDKyeRXJ8YLoWNB1yUwbPSPCZYWD12lcZtgHJIoxvW66OcZqlxvqsh48MwJhj2F88eMXa7QCWsZQoUkyb9ASHZl80mdWG3QuyJ/tdyQQSFKJe+BR0Dn9h6zEc6k+WrivcX7zKTlQtdEv94E1mMhNH8lPvcwFPDpQ5
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:wkCbz00Tx+9oNwktTlmziW93fRkRpU13fYocNy+9Us9iRFZGQjm7yD4xduu7RizTi/WGyJ5OBRep6eo7QIh6yayUkXw2V1QvmF56s3f+0Te2+8IjNTcSxFtL+3CCuaM1hDFvHEUUGKt6PDXTUNl94jL8x+uN0PzstvCJqVy/ehXqFRQSKY/2Bcp5Q1Med4vWnfdcJAvcz+4z32r2KizUh1/ts4CazVA60DGz7XPBdbOdm+qXXi2aNEnQYOE0Urpof0R/VTEHQ04aBCo4XJtwrQGAAc+DdV19h6IHtVoEcI0CLOtLQVzHZF0nmg5FTN6WB0D0JR8GtSN1Y+YEpiYf01MPR0mY5WRhvn0iT7XYL/JXvmYzqWqWm6a84Qk+56iUNO9MnPhilVydgm8wKB+/XfAr1C1QAxaYcs0XS7KkzUhfqDK9h4TOTHdStF1gBtcEJdlWgorZEh+wadVMy+8sDg==;5:SeJG+JB63e68kwM+MZ73oOk3xGWF19lGrWv7MisOER3nVOSubofTMrV2i5g+WnBqIkUx0f0Yr2ubz51q/MGBZOr4sDYG0Ibyz31L3lqfbAhOVol+EiDCPyzfk8uwOYradCSr5ru9EXV4OFFBKgMZkGBlX8A6XSMSidUXghD/evo=;24:asrJSy772EDV9olPrXvHBUpB4AjGksaV4ZODplId1pbG77jckPqaj5JFg5RzybGoL9Jjy3TAQn/9e7DjtF+YFhTm9t0iIuFys/Cl6JNOWtw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:uK7H6G8y8oPFVIgMid8DLR6ZpEohBLy1sVSTAwhK3zwRpZjwX8dX3BKoAQ+NnCEpd+SbXMmIkJSBDc8m+qzsiC7aAvlMhb3A38MycweiQSL9ScLOxPFxdSpo079mDNatpMihltMhQs+tQw1b3yaY8wN0OBSRkqdA+6IEh0h/JIvgDYJH3T2tGIeqCNGFEcbmNpZ83fKjp3QUfA6zxSkZa8rqZB1YWKUxKcIYCRAArFFPGTcu+wWkxsN3GipM5xFd;20:F8IDhf0UTQFdjStsB+ooODAE3orUDNqHxOe8RRtVi7l18nEs9bbRg33XRPoimVAwCcjrcODfypNHIElz3p5JENLOzLILi0J09ZkyrrTJkk2C2KI64ckHKYSOH4ZzIips0yOBcAJFYuJbgQzrrpNwtn0I0kNmVDWeLNJJ5jp3AkU=
X-MS-Office365-Filtering-Correlation-Id: fffcb9b3-fbc9-4cfb-42de-08d5b5a43ae1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:49.2864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffcb9b3-fbc9-4cfb-42de-08d5b5a43ae1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987656584763304?=
X-GMAIL-MSGID: =?utf-8?q?1599987656584763304?=
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
index 648b08621334..80743878576c 100644
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
