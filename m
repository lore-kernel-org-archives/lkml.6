Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrahZL8ObvNo9Q7OAuXLAs5YXC5Q9Yom/hwY1kZeGcg1cKohe6CKSTmrJKQOx114ovvJpVV
ARC-Seal: i=1; a=rsa-sha256; t=1526632992; cv=none;
        d=google.com; s=arc-20160816;
        b=XyczPiCtE2h7uoyz3Y+SKEEid9OXfOcIOb4/x+uHnQ14sf4SZQ0rcWr/TiGMFmC4Jr
         t+DifEiCJCkS5FVnanM931/ks6nH5UAtrJ1TSL5y3RiYK9B1SQ5DENerUwJ4DtDePJa+
         gbws3TMECI9/tTBP/bVYpNgdylBoCzokujjcbDUX8JCuJ6vEc8W8Zepwe8WvrUqrxvB3
         FaiwZj0IL+LfNmHiIub5QW4q/i42hZy5ZmdN17L3nt2YC3nHeAOknQhbtuuFiI+YiQVL
         W4AZOkjslvdVvxxQcPHvYFdLs9R9Sx5Xy9SCpyFqmN85i15VxH1JcNklL2AhGe2VmoKZ
         xGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=UcpA1xVHpPC6m0bhf9K0FnDA1027lFi/MU2HK9ZMr9U=;
        b=aLf/p7W7ENXZHMsFIo3x4kSlGxoHbbahpzy9B1wP2MxPTg40xkHCOXcBFqVOZY0ExQ
         E1ln/KZiMKIgk1DGpX+Rzbofbcp52hVxZQpgEMV0OCPqQ2aeKOJgkPWyiCymGofI1Pa7
         KWrNIwUwFwLlJAULO0DPD3FAkW1Xp9B5R8rJAzyScgNCKU9y6NzJzF6BBdGeLJIsOMTS
         eWNQNzb8CX87O/kOicF/8I0EIY6ovT1kU5dltbZRj03QiFr7oyuIwHNQmIYbS1jRw1N9
         3sis9Qw/8ryowbSjDQxfV/grmqkXtX97fUsmsdTEiE/nCm4bBK3wo6cFkXXAiwkytRCo
         UzGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=NfaNzP0x;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=NfaNzP0x;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.112 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v6 08/17] fs: Propagate shrinker::id to list_lru
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
Date: Fri, 18 May 2018 11:43:07 +0300
Message-ID: <152663298709.5308.15783920940060927762.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::14) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:1gVFvbXYGpFTsAAi2hk+54AHnhlc0JK8JHhRsbiahw/ElEQykCMRL9QP2NSmUSwJ4Guwscsnjxn8LZ/nbDcRb9nB5nXFZwRrHXvIVkPHFg0tOWfVaWKe1vaixk1mWjo0edNkn/vXcFv8DmaN4uhzmiAWhldhAg56FC9byS9HyfPhAlN97gOOL3TnCjr0+iy2IjGvfAR/zZ4/+1x73PsyDZ7naeacFqBiMA75/F2kYx7vfcsKwq6YRNA4WZ+4unTv;25:mqNhWfBINOazJdhWh5nnyRkpoIViaYYQutUc9wIMNKxiZhGm3Ipvr/6I6CyO8KZKD3zN0kHnMCyQ6i5dBbznvoxxmUTwQrW9VM54QMcg2XekQ3zBmLIae/wevJJUTlTVSWp6lEPFHkKUrr81li7YkCKH3xfMp+824k+oA5+ZGZNLas1nKdhAvqzqpAbo9BRK2FCKpJP0ITLakXRoTeHv9lB+lVY264zS2MzNSAKNFbk3N39RqAJ5FTfjS+8X//oUlgMvVFyDSjUbLJg7HF14ZbxwUvlKTx1ZRF7JQlFrVaH0Ko1DKhpbqT2H1TL3OYc/pzbJUpcv0THJrzGkvv2Ovw==;31:LgBd8l/w7gfK4gYWtfCiNTIkkCzTO7733RWIavXJ0oVxAfjZ9FYvCGs7WYPJZz5TysIlJkSG2fXHW340CFD31LxVGAyC3o+pR3jYv3fkN+fUlVllDGui3J/fXgzwkZn5JqltnVyfAzBIilNodcriHmRyoGcstmhIvhkZQMSuFjRxWhN2qKGX78IVV9b0WQdNmFF6ikeGkuC2lCUyR+QIz9MEvSdrttQvhVpWiF3Eu3Y=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:ToHx8BNjTpuXjzOPrGhT4fO8Me0+cYqP+0gj6bROUJH4ua2/bMtw/pYlIYNuP3bsEAOOxVdR0koaAn5mzEO7+lxCSgyvMSXgRTP7KIAvgxLvl1R03BtPQ2RSl+iOswcVR9Dl78lScUO1C6I7/ihjUpitSqsACjjLdKLT0MAY8pmMf/2mA32odVcS+w6AJ8oehUvyWrspjLk+46hAtZlNg+QJHYHEb/lHzd6aiUfo7KyNuwUB7/IB5nsryEtY3FJ8AQwbIx00eCuGBuHkDli63mRfcNFTf6ajbeBufDue8+WnzeuUpH3NDIxdgEd1BfF3VRSNRh4rSKnrPWA6sIAlq9J9C4DlgqiYCPObTS1jLK+/P+cKMnnKf9mbwD+gl+Ea41Wuro4BaDleQMuJSAtxMmtwiNR7QbmdXEm4vpclQCJFzu6NUmsQop5sN4fK0RW9BMSTAMw1Usb2CjCuqk77WAz1pM2MQ2/pQGzxgB7gTF6OjQrTQDU6t4e0rWrw/DQ7;4:3EkWb1zNrJKB1eEOGAl+kjPawWBMzhFMeC/f1Mz3M+DBg7JJT2hq4fe4NCuG6p/l09shIIst8e/TkMlh7Kvqtlr2275EkJmok1WaQC4QoNLq2vXgmUrHJgQE95R8yz3gWGh2e3XtQGata6l/JubA4dDxt1c+lVVRE4M56xgPQtflBRCM9IZF4cqqzOXbmW0qzYh7uq9PugV+DCSQnIhADWLkVZnQNSzn9ebzbs7AdKVeP486RkfBpNYy3P2yqgMCggONOb9dZVR+LsI9rU9KZQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339436215A6D2D8FEDE7D27CD900@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39850400004)(396003)(39380400002)(189003)(199004)(230700001)(97736004)(386003)(6636002)(6506007)(316002)(58126008)(16526019)(103116003)(7416002)(5660300001)(186003)(105586002)(106356001)(52116002)(7696005)(2906002)(55236004)(8676002)(81166006)(81156014)(68736007)(47776003)(575784001)(53936002)(8936002)(86362001)(76176011)(59450400001)(39060400002)(25786009)(23676004)(33896004)(7736002)(26005)(478600001)(66066001)(2486003)(956004)(446003)(476003)(50466002)(486006)(55016002)(305945005)(61506002)(3846002)(6116002)(9686003)(11346002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6QkRCb01MZWVrVHBUNmI1UmIvRW1PMzhD?=
 =?utf-8?B?Wkt0bFlGK1d2enltd1FSSzhheWx5bVUyaTRabjlYeVF3VGNGM2NXSkhLZnVh?=
 =?utf-8?B?c3Z5SnpnZlNLR2xRRHJjZzRvdGU0TjZLSml6S0pFdWFmUHBQR0V3bHVqNkU0?=
 =?utf-8?B?MUxCMTNXTi90SXlURFN6ZEcyckx2aWpqbmc5OEtKcXhwOGtnMHlKeDBsVXhu?=
 =?utf-8?B?OExVWHdJd0ZQODVOYVMvMk9UQ3dDNGd2TlZ2K0ZmbWcvWmtoRm13bHZPSFp1?=
 =?utf-8?B?TzFJek5HaTNSVmxqVnliVDVBbFRQOEtBU0kxcXpzY0xRaTlaMHI3NlAzRHJS?=
 =?utf-8?B?eVNaUXpsTjl4Y0RuN2RTb2dFeG9kTFF5T1Y4cElQeWptemxvbEE5M0EwUURS?=
 =?utf-8?B?enA1UjVKV2pJc1pabGNkYXk0MzRtUklwOFhEeXdHL3BGeEkrS1hjdWUvbXNH?=
 =?utf-8?B?T1QwdlZacjlDc0hkV3QrcTYvdHhjRmxxUEl4N0tTZHU0d3NxWUxUVXdJenk2?=
 =?utf-8?B?Mml2T3YwRzJFdFhzWUQ5UXk3aEVYb3VKdEFSN0hPYnNHUDhTTWhhOFJkM2F1?=
 =?utf-8?B?R1NydHFHdTBzcTNhU3o0bm5LRFVobTQyWFlMd3RyQ3RqZTJSRXJWT2N4U1ZX?=
 =?utf-8?B?MFBNUUhLbS9JRzJoUm1FM3RWTE9vVk5WaTd4aVkyL3Q3TDJaclpHMkd2Qm4r?=
 =?utf-8?B?Ymh6S3ViMld5RUpVZW9XN1BvZ1hvdkZOaXdyWHlVOUxCQ25xMU5LQ3hwbElK?=
 =?utf-8?B?M0FIZkxSdjlqZHJHcmpIaTFaL0tpSzE1UHpMYUpWdU5Wa284bC91M2ZjbGRK?=
 =?utf-8?B?amkxb1I2MFpFaGwwYmZVTUNPN2NEOE9rM1NvUmJFcXRQdjV4MzlTQmE5L01y?=
 =?utf-8?B?clhRT1RVL2R5WXY1blBmZ1NqNWw0VXc1L0lzSjFSUU9oZUtGcndrbFZweGtr?=
 =?utf-8?B?SmNDU1pVSVlSalhzUVRDZmQxNFJoNllkTE1uaFVXY2xwZmxWUkZGekhmS1VU?=
 =?utf-8?B?ZWo1UlNjbnRmWGdDOVBjSnpLeXlKRUQ5clhOMGQ1S25hMGZxdnNRenhTLzNP?=
 =?utf-8?B?anAxRmhsK1hpWTBiRjMvcXg3Wm1sQy9YR2pWU3N6NFNvOWJDdTJsR3FjU0g5?=
 =?utf-8?B?M1hWUFhtQVFoWXNUTFNYa3BOZTNRcHZEVzJ6ZWdMY0Y2N1ZySExsaXBTS1Iy?=
 =?utf-8?B?OFBqaFBWY3JLOWNBY0tsY3RGbEVKcEdoSWszYldsSk04aGg5NTZjaTlCb2hn?=
 =?utf-8?B?cytSV2hJVnBQM1d2bEFZblMyZzR3OTQrYjBHemJxTGdJa1ZWUndJb0s3ZGpM?=
 =?utf-8?B?aXBWK2FoenJZQ0tzSUZkRVlQdS9xYUNqa1UvaFdncS9TV0tOQXhGcWtMSVBR?=
 =?utf-8?B?RmRmZnJieXI0V09TWk1uczNSakhBNjc3a2c4Vlp4c1NFbEdIeURSb1Ara25s?=
 =?utf-8?B?YTBFR0ozaldITFd3NmdQNHN3RjRheWpPcHI1aGFnd3IvRkYrbng5YnFnSDYw?=
 =?utf-8?B?VXRYeGRScjRWMGhZeEFhL2N1MUt4NFJPMkJONlFucUNJeDVINEVqWkZjM2E3?=
 =?utf-8?B?T0xLVW9DdGFBYlVpTFU0bDd3RE9HRUlVSDR3UHpLcE5ibzYyT0hLSkhsUjdh?=
 =?utf-8?B?K0V2aVBSMGRQbTNnU0tQbHUzYVVJUmJkTVFNZTN6dTJLQ3p1UEloZnVnTDc2?=
 =?utf-8?B?Zlh1dmV4OXVWaHc3RjJlNysvUDRvTjl6WHN4SUtlL2hUZTc5SFdvWlFOak9x?=
 =?utf-8?B?SFltR29KTEt0SXdCYzg1Y0FOR3NhbW80TFVobng5TXdsUnpSK1FHa2I5NXN0?=
 =?utf-8?B?S0R5MjVLR1RpS2ZOSzNCajQ2WG1mcjJXS0txZFpWS01OMGpKQT09?=
X-Microsoft-Antispam-Message-Info: ea5Ql7d7rWVS7VJKBTSiovJl6RsfSiEptxe7Kw2tfjXisgbXx+qAlP9c+nCKqYmiPAznkuiBuvqlpCRc5PJtMRCmxb064cEOAYSW6YOWC8sC/F5622vjJbPAXnOHVABfE9UmlVtjswrBBcCuqcMYrgvNWkRVPR7oVkU0lASid4Vif0eRoGZr26oEy3oXQDHa
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:oxB9xiEM9iKyTUEO5s7Vwm83RRUNLSBwYq8Gr1LiE0TbgZ6izRKfHafzktz5S51HB9lEFkH78SrFFU6UgNfEoV7pVKxItbUfDGa3xo2qLEvqX/URgiKxad3KPdnFrsW7Wospc48zlp12sAR9d4cUYXXcWo8GVgvB5cxUq+1talju5+/KdAUxdZYiD3Ibg8B5nWyVNOlyB3vG20HC/yUwcBFa/9CWUO7HlW/1cyjWHDlqcvyUitKt/ySm+zN9fSywPBHWK4RnojvypsEU92s3q1bxqFpTRiVwRgM2XHbH27cbyld+zcr63fXA7gVV2byzhJrUgSIwHh92ty5Nv0zMva3tTvc0j8aUgw3o+P0O30N3AGmrprsQOp/csi8Jk5iggxTLhwvko5ENZiLR97mPQ0W0yPom96Qr436KLlu3jP7KHW+aqavJxk4jiASjqdoG29uJj/uDQht1IIatY74+mQ==;5:+3p0kpEpCylIbeNyOTEi1JPoz6xx1VRXqrcY6HSi1MeKxcAEGYGUUmoc1GCkib4+kSnXfLH5wYCiP7Xmc2ZCz3vPlWm8Oc2IH6pQMZsuogSTjHp2GZiGnHeQKTlMLvbMaldJ62aQzow7ZajCiN1haaPYAG22yYa/hL+zuNxrxu4=;24:wbFFew/TzrbBJAvfQ7/AvEh2jlfwTPlF1ZiExzrPU+HXNsuOWT/Y9IYBlLzp9CjR8XItUFIO5fYBJ0E5ymo1UCxzcgVzfF7mMRKAQqhhB+M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:g8eI8gZz6CRTnEdRLSvG2/AL6iA7+UEIdvlZYU31EFZ5ojMGaD5fdpEVsAZlYwGelIrlxCSN64ENK0RvF+LJ+ldbgBJKKXRFiY3VoEeEf4a0Y1NLfWNgnApRN+fXHR8W/JgM6DwpFyB1T/XNf49XH1rgx4Veirj/cx4Oq9J4sFfXnt0/FEdXLjW4l5hp8BL45X/HYp2I3sI3zboFEHmgZEkKmh+v6Ut14+Fzaqe1/NM62rhCL72PDahYjq3HiDUT;20:DqmNCa6AL/brOZlVS24xk11l2Tbh674xQlf81kD7F2ZPaJJ8gIcQlmcxOr6N2fLrt91pyU0dAr60noRp8C5PI/FucMY11gqhVusSU+GOLNbfPmPcq7PmYUJ1BopDnvA50IybN4qNkts4OFd29vNO9iEPhdJWUDAIMOipdilHt1E=
X-MS-Office365-Filtering-Correlation-Id: 61500837-62e5-4263-186b-08d5bc9b626a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:43:09.1584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61500837-62e5-4263-186b-08d5bc9b626a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790716900261615?=
X-GMAIL-MSGID: =?utf-8?q?1600790716900261615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    4 ++--
 include/linux/list_lru.h |   14 +++++++++-----
 mm/list_lru.c            |   11 ++++++++++-
 mm/workingset.c          |    3 ++-
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 78227c4ddb21..f5f96e52e0cd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -261,9 +261,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru))
+	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
+	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
 	return s;
 
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 2d23b5b745be..9e75bb33766b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,16 +53,20 @@ struct list_lru {
 	struct list_lru_node	*node;
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key);
-
-#define list_lru_init(lru)		__list_lru_init((lru), false, NULL)
-#define list_lru_init_key(lru, key)	__list_lru_init((lru), false, (key))
-#define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
+		    struct lock_class_key *key, struct shrinker *shrinker);
+
+#define list_lru_init(lru)				\
+	__list_lru_init((lru), false, NULL, NULL)
+#define list_lru_init_key(lru, key)			\
+	__list_lru_init((lru), false, (key), NULL)
+#define list_lru_init_memcg(lru, shrinker)		\
+	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 232bb637cf02..dde9ecae7cb5 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -559,12 +559,18 @@ static void memcg_destroy_list_lru(struct list_lru *lru)
 #endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key)
+		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (shrinker)
+		lru->shrinker_id = shrinker->id;
+	else
+		lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -607,6 +613,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#ifdef CONFIG_MEMCG_KMEM
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index c3a4fe145bb7..79099bc5c256 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -531,7 +531,8 @@ static int __init workingset_init(void)
 	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
+			      &workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
 	register_shrinker_prepared(&workingset_shadow_shrinker);
