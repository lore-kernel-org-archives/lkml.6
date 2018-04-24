Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+fk0ZTQT4eA4Qy1Aay6kbfR98KwJuxWhMWx3ziicwxkG2KQ4/vEfLNCL23UvcnVOax454u
ARC-Seal: i=1; a=rsa-sha256; t=1524571997; cv=none;
        d=google.com; s=arc-20160816;
        b=V8uiCcq6Zbq7dJTdXNZ4B/u/TzsGbMrF39i/G50qEwTLZj9WiEGdcOHCHDIoAusabr
         wYnRPQvhbtWYbXBB/2j/Rva4HlKvTx5z9M7JBZwzY6gNzgEVCeFtTZJ4LGnchz8fTTic
         z2BAMikz045l7jm3z9HtvFFy1XrxdoUrNKHwEI0nPZj5q5S85GaUBLO8ZEjC7rMj7RC0
         idOCIr0/l7mZzN6i5+2XOYtxJk4fANBgwUbJYE6os7wXzSnZ+GOfXwrM/Wlsa5Z+us2J
         fw8aCuMDD4RlhSHoM20buFhXKD1eqLSwiQy5vcBlTO+Gj76MkaNRBj/t2OuLBSSGEAfF
         jW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=QcMWtAEy+0VHDZmDG6jQCfIQudxP7WG5YAbPgRBEqd0=;
        b=eXfBtstYjyaUoQ89oAGshbH/gAWh+PDolNtaaKiuiibNB30TkmHJGDNOnm5vAVY2uv
         iLCsKlnl1kRWDHaHmx6lQNcZhjoea10ggIPxtg58Pd3H04STjFketlNULVXo2fUxE+j0
         mMF925EehIjT7yk1qj/cziB5gYAwdDf92yNGXOm7L6d4Dk2wvR4CdoH5o/Nm6CEnsYZP
         7GHr4XXUFkXGxt66vCdGSPNc5AGp8wCCnbYg4TS7AUCJU+qlid1m1kdxrziDqqOmGuAK
         +U/ACIpudbUMG87T+eA2UtuFgH95DzshaBj2ByCTkB3w9O3mFKCDoOonW5dJIS7oxLwg
         Qd2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dHZWj+Ot;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.120 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=dHZWj+Ot;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.120 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v3 07/14] fs: Propagate shrinker::id to list_lru
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
Date: Tue, 24 Apr 2018 15:13:10 +0300
Message-ID: <152457199089.22533.12993688427659059890.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0047.eurprd04.prod.outlook.com
 (2603:10a6:3:19::15) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:ZUrqLhiXpOnhL6qgy6J8Vxgwj198xmR0iCoDjQJi9Mr4jRpMRf9aGfvF2K3GZ+Ax3qOjxd38bBKr851Y+fNx6CR2f+wkqQ9LNUX4WrGmONMLggXFTCXAwgbmPeq/CnwtRoLebexpAI3JnmolvGlcpfUm1p8uWjlK8u1k4SdSprzth3LSYxArtuzNo49+aPE7KXB/uA/q+RwkHxGLL6ZrvXxwy8f4IF1Tajv62bsVacyTCmI0ArB0G5DwUvQkkO+J;25:olez+is0BCpguAFiXIWYkISbT5UZzbp8Ju+o3yLHUUXyKVG1C6g0xM0e+LOaMhmfeVqeQbo8E+2Rkv5pwv4DH69VcRXaR8OZicn/JaKJZ+z9918YfFKqCXD4IDyWVKwuwGE1aSuIjo0zoOSMMp1BM/yuw5/iZkidmtFbxXoAza0eD41u6rXrlIrAmtfsEZlS3A3sB13sGZd7aaMqJOYYNsLXIcPDxc5+xWEwHYirzXlEJDaT5WczgpXnxi6xPlwgi60dXW8dKH3Nm75hW8SMpOTYQqEZknBi8QDWS2TTjLUaFCTJT9vbwPkkZjR3iDewDDZyfh84yl15tkpfRMuBMQ==;31:OYJSzhMj8wuA+nqKHZnm/zeJthxAFFz+EPp1qW5yHuBTcxCJqPCQtahBycUSAERLpau6K1qmaUqA11KGOcKkyiiyRSHtYlnYtXwXLJFQGCZwE0fTv5I216iKBkGLEgkwDJ8PVlF+cnS44T6aaTVTnBz2EmVA6n3uQDDKNe5+X/mKZQmple+b47coeeFQAsYfFscz6wyD1rTed69BJsdCkbl4DdMZjTsux+7GoJ49NlM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:npm4wU7jBg3I+sjSmANSMFSMQjVmd2QWL7T/LmgKoILEYf0BDbau3uceoZGONjOkpFw9p+o8nQ54WD1VnwTqSn81POQd2l43EUy2UoG3uIlkFKlDb4yshUGfiVHLJqIEkmEHMI9HGQUN83kEMnWdqL+VA4GbJqMRsib5y8AdhuslFM1H42UuiQDrQgqvp8OLMzBC9fsm1Ubi1APGB5OyRsfTce1L8kW8RkQsI3J4m8hQKW1qFqAWblBjT0BlqfXX11feZg8LjtxUhTSz92KwcgI5FEqAScYrI1XoeoU3CoRnUSV4hXGxqxVlNEWp0S/WL1dI5gtKG9WXuDJg/IbOYEUM7Q3pwdcRQxfH+r6mQdlUj307cYtbrthQnEoxbF/5+Bqq0WSq1d798AXTggk8MHduOGkaBQ/qXtxk/yRjo+nP59+B2Zrp6NuiwjY0ZvpxEmwglZTjS/3pWbID6KhBoYaR1o7Vw1K7uquzmH/Sdv3cwdMLtyNLNQe7gGlBsco8;4:61mlgtEDhWjJr+gd5WFT4jpVcvjJXeZ1B4xzvhxmY26edh59ALc4GLOcNonygvgFuzLgRqVXUEjqi/7KDf3X6rB46YEhEB8C89OnnPisDhULJ6i/q9XJ+J19RKv6ypu5P99np3RCWb5bi3jaV0jhkOT2jmSAUpAkbL6fmeEl2GezwwbxsXMxYOmONvrZFd+IBdC4vBkIupG/UV9+jLyqv0nwS0qihEyzz1qZPC1ymXXSCowGKaQc3Nn3bmvWrBh+eGHomWGVY3YXAU/epo4xVg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13401F433FE8CE7125E40A50CD880@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(346002)(396003)(39850400004)(39380400002)(199004)(189003)(39060400002)(66066001)(230700001)(55236004)(305945005)(8936002)(476003)(6636002)(26005)(956004)(6116002)(106356001)(105586002)(53936002)(8676002)(55016002)(446003)(76176011)(9686003)(16526019)(50466002)(486006)(186003)(81166006)(23676004)(5660300001)(2486003)(81156014)(7696005)(33896004)(52116002)(61506002)(47776003)(103116003)(478600001)(68736007)(25786009)(11346002)(7416002)(86362001)(58126008)(2906002)(3846002)(6506007)(97736004)(386003)(316002)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6MnpMN0NJQWdMeHU3UHdZekM2T2Y0MmpQ?=
 =?utf-8?B?OGVEdVBKbmdadGtxZjYvRjRScERyOFdUU3JLK0FIYURvTFRRZ013alU0OGxu?=
 =?utf-8?B?ZGY2eUh0R1BXclJIV1JYWU9UL0FjaDlnd2ZqbVZIWEI2S0czbElCWDRWN3Zj?=
 =?utf-8?B?RERzMEthdjlQeDRzUzhxUGRSeG53QU9zZ2pCUFc2d0tNUzdoSVZqYk9iZUNj?=
 =?utf-8?B?VVN6dkY4Nis0YVdmYkNQZ21FNzNENTY2YmFjN1lJd2duMXYvZHpmNWFGYnlQ?=
 =?utf-8?B?b0UxdTRlRHY0RmMwT3p3YVpQTEwzTVM2RVpmZlZ4dHpkOFFUQ1EzVDdTS3k1?=
 =?utf-8?B?Ym0yaWJNcFBxZE1KUnp3bUg2SnRNZ2dXSDV6MDhadjA1ZDFVc25HNEpSaGUx?=
 =?utf-8?B?aDZPL0Rna3cvd0tRQmh2S200eHM1VWtFWmt4cUJBZ0g1ZXR5YXJQWFllRUJm?=
 =?utf-8?B?Z2s4dEdOLzAxZmJFN09GTEt5eDdyMnVjZHBUWjVQdG5QNm13R2Nzd0RVakxs?=
 =?utf-8?B?dmZ2VjVqZmxiQ2FXZ1pmdzNuRmg1N0JxWCtSc1FmN0F4dlFPYXpPZmEzTmFX?=
 =?utf-8?B?NlQ0ZmFGcHY3c2RTZ2JBYnJrMzFyTUVQMEdES0hmMjF0VVpRaTh1SGZPc01a?=
 =?utf-8?B?R2htQjJ4OXlyUHBxd25oM3NqNU5PN2FEZVUzakZnT1lZMXh5eXgva2J2cUdi?=
 =?utf-8?B?YnpSaGVPMGZaOXZ0dkhnV0dyeFRXc2h4UU9MZmRNN0Q1c044TkNEcUI2Qjh3?=
 =?utf-8?B?QW4xL2dUOGpPME92eldCN3dvYmEvWXJDVEdrRzl2ZEt0dTlmNjBLRXl5Y3Zm?=
 =?utf-8?B?RXIzTVNyWGVRcENWUTJjQmNCN1JKMmJ5ZERiSzNjMUlHNG0zdDliRGE3d2Fw?=
 =?utf-8?B?VnBIRGRrN0V5Sng2ZkhZK1NJanpNVVZieVQvTFhBSi8yTkJnNzg0K1BVVFEy?=
 =?utf-8?B?UWVvSzFZcjlWTTY0YVd2V2RJTWF6RnpUSk9hRkJtR0xmTFJKU2tTZ0gvZHNM?=
 =?utf-8?B?bVZPMXQrWENPREpab2RoVDI4SW95TitMcENGSURJWTBXa3VGbllwYTI2ZEFv?=
 =?utf-8?B?SFFuViswQi80M29wTm8za0ZUYm0yUkVmQmJaRlAzaEUxUDU0eVZ4SlFwTHcw?=
 =?utf-8?B?UkVlYkNDVkNoVXBLQ2lGLzRHcXcyVGlvbWtjOTBLSHR6ZmI4UXFjZ3ZrQkhM?=
 =?utf-8?B?ZGpaY2VrZ2NXajdZcXRCaS9lM0ZxM2ZEOVlTZDJDSVRtQUd2MS9JUUNkT1Y5?=
 =?utf-8?B?RytpRE1sZ3FtY1R0RDYxRHE2ZTNFT3UxTXlYSDN5c1AyQXNEUXZNcWZ2SUFV?=
 =?utf-8?B?cUN1L3d0TDU4RUdNVVdyaEVhR1pVK1F0TDV1dFJpZUxMRmZXSGhURTNuUmdE?=
 =?utf-8?B?a1ZRd2JXZjZ3OUVleUxMQnVEdHFId0ZJWGJoRlRVZ0hnZTIwQkowSWcwV0JH?=
 =?utf-8?B?ZldTK1Yvdk1JRG1qakpIM1JCYWU4dVkzNGVPUXNyZjFRRnZVRU9VMStaeFlh?=
 =?utf-8?B?WURYOUIzbFcyZXN4N1dLNVR6MzBScTN6QmpsdlF3SkptWS9lSmpJeUFuT1B3?=
 =?utf-8?B?c0hqbHM1VHFLY1JkZXpLOGxIcHBFSnR6SlJ2RzdHa3BRa3JsdXdBZmZvSUdv?=
 =?utf-8?B?cE1QL2RnM2dob3p5WG1MTGpkeVErVjBYSFE3UVpiUElNSHVwYzVlNHJlZkh1?=
 =?utf-8?B?UCs3VFNtMlZVT2NxTHRmOXNta0ZvQXFjY2NtZHdpUDRsNmYvaDdIMU1IcGpC?=
 =?utf-8?Q?p6SCSpo+sCR9G/GQ2+gPa1rAFhjb5wNfmeQu4Cc=3D?=
X-Microsoft-Antispam-Message-Info: 9jQMdiVeRJlWP26sabjWU34RJCJTW+Usik73vJ5Qqh8zjgJpDvEsMcB3hxsWz6mzEnbxGz58xt+QV7lG5C9U/bYVxO50hw5G8ozgAEFRb+j7A9rBh/m3IBkjCjVamPZCOlHgQ11jdpwqVzWT9LCRiXAQSk2CZ9VXjIZN6K+MBoroUEAK+6ymRs9z4MaE3I4u
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:0zUdN5Qz3+2PObuhtidg1y1bxqL0GY58x0z/uszYzBUpTk8w+0ZKAaEOMsAPphVMLiWGoavgdDaqlh6MjqcMoa36daPrEQLUj/+xyEwH19eoIo3Dmo5LRyb1QhTa+R837dOOj8DQd3nwctfrfNNKxUwBD8QUm4DREOoGyUfXaOX+Z+0SiQh6B8jZqNMUtqflfGSF1decVPt2b8PzNjG0TMVszG20OwG6O/Mnt9ytZCJHHTm2HZ/6+ErNuRUMTxEhEltIJlW9hD7LmAMc+4pojcHJCeYxgtwbgKdY/6/7IEygWEF7fCXVjvPhrEYW2pVn/fkbdYKZDVzS+hgjYdm/sZ0cdMABBXJ3st/L77fRT9OAhg1xDxLVBfdUTmIH9ZNyPtdq8X2MNi8lMwgbOccKztdodgrGhMrIqlEgT3my9Ln9U+u2p84efmNfreuspNiDWXaRi5xyBgoXCmvAG3n6AQ==;5:MfdD6AjVDd0PZ6vQXkHui5HeAFUVgBkeM7vOD+c4SunRXjqh+mGt2ZzemdqaY2FY2yqhm6XTGePr2WdL9yjqUQWMnM8mtGm9qS7LPlRFYNqXHpJ0J7/hzOYPwQqsGmtw/kJf2azSB1utrKG8JzK6zgwLc5hiv//xFg4NWN0IoxE=;24:MaQFjEgF9Ja5jw/DODZmUwhN0jR5gLCrF+kluQ0jS/gXYYRTmToKgmhpWc8fAEiFvYNyoWMf71EL0Kg7UK8UXMozcj+dpiugGiJmjuI7TQw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:h/qEf3wcZ75dQ/By4aaWBWsMn/aYxNzyeu4oIxI9PIjzveG1FBwuNzH6WTkaCgBBUTZXlEt3D7YFN3SQQOnLgTU0SHzjZT9y8qCfDJmOwMw5sG2U/p0338S9aZua8gCopAsYi8ZlDdi0LO1ZtZb0hK+Mbs5/p7o2RG+uy/9hEjRN8EYnNI5t8e807WtLlhkCxuHMxAoQvtDEKa5sc3XGkz4tPgw5rA0yRK979cO1PmuM7Psx7PjJyns4daqezP+G;20:QvUKHUNTy0FVNfHal52/ZOdVZtgQ8/S3dafYrkqzdk2rx42LlYEkerrBPZAbakVaqrA09B37F8hilsWNq1dFaD6lYQwYMbYxBBZ7POUnxnlPyzleOOgo1pwTszdDDIavVme3colfbMWBaBO2T16VDR4bmaygiyXTAdDbYDEG8jw=
X-MS-Office365-Filtering-Correlation-Id: e5414358-3379-4d17-c208-08d5a9dcc10e
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:13:12.9818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5414358-3379-4d17-c208-08d5a9dcc10e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629606927874888?=
X-GMAIL-MSGID: =?utf-8?q?1598629606927874888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    4 ++++
 include/linux/list_lru.h |    1 +
 mm/list_lru.c            |    6 ++++++
 mm/workingset.c          |    3 +++
 4 files changed, 14 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index d95fa174edab..c9a6ef33a98b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -258,6 +258,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru))
 		goto fail;
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	s->s_dentry_lru.shrinker_id = s->s_shrink.id;
+	s->s_inode_lru.shrinker_id = s->s_shrink.id;
+#endif
 	return s;
 
 fail:
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..f5b6bb7a8670 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,6 +53,7 @@ struct list_lru {
 	struct list_lru_node	*node;
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index d9c84c5bda1d..2a4d29491947 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -567,6 +567,9 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -609,6 +612,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index c3a4fe145bb7..b8900573db25 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -534,6 +534,9 @@ static int __init workingset_init(void)
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	shadow_nodes.shrinker_id = workingset_shadow_shrinker.id;
+#endif
 	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
