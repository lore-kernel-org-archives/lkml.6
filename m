Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZq0eQ5wTzX0mi0eHs4+YqftInuwtYPa0vNq4B33uWPGtvDIchCqwaO/W7IFDo23hcX6zxAn
ARC-Seal: i=1; a=rsa-sha256; t=1526632927; cv=none;
        d=google.com; s=arc-20160816;
        b=d1u6DO1W/VvKiRaOYSRaGmscclVj/M1bsIcjMuXADYeqd17vqZknwVkLyXGu691gSM
         Y/uQew8guFt40oOanyJGmLGI3iwkpf2Wj92uBuhWzhbFM23z0TSaUaWv7PAWFoU52TJF
         WO+savVEbwkEUf9UiRV+6H2XfO9jY2ypmkXPvygNvgb3GvYuchy9Y4037vcU5mircRW0
         JvKru/HWseHkUiHjVsTotHuyEUHkZZq2iLxGwGQ1czm5UF+PNk6DW8Dy4hSdDjoobUZ0
         pR9YjwMakyEehV00PuvYlbW5PtZsmx5qKNGnC54POt5GbrXYpuP9devxO6r9i7gQAQWh
         nJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=/Cz8lweXtLqi7igHma2pwduGy3hjLIf090ktx+R4Smw=;
        b=I7ab145EZ0p0IHP0SHnroGxlQM3kmBLmTeyHXaHRR4V54J8vsBjHVmS3ijWqYXj/ef
         r+rUr0abEDDPeGIQ/X2VTW2U8a78tT5nXaQwUCmmPCtPcWOGJivKFnC6Ujo5DbFmb+wR
         dIONpn1mYbCMW+5IipwzrvlBfuHDwgHYFnue83BI8//3VYDwNMtZR66q3By5Mg0bE3Jo
         /AQBAU5/LNJLrQTCe2ru3aeaC6PnZbrSGQOu+8F6wrDxsTu06K3aRIkpQEVA14GwbLGT
         vE7svkRXaCnGGUiIjcmS7pwNj4feR6DaBIqI660Se1CnEoWk79ARVnJG4uaMTpA91JG3
         T9aA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=N9/fK50A;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.92 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=N9/fK50A;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.92 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v6 02/17] mm: Introduce CONFIG_MEMCG_KMEM as combination of
 CONFIG_MEMCG && !CONFIG_SLOB
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
Date: Fri, 18 May 2018 11:41:57 +0300
Message-ID: <152663291794.5308.3508663105465589949.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::18)
 To DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:V9KlH8OTTKlj4XyX1SFzxMKWNFrenwUbrb713Jbk8M0QYjnpIRu0S9omw1ZD8KLLwRB6+YQcfnOPRwNB6cZC3YGEGDimYa/2ggvTYO+f+dsICODaOI5aKDtag8UhdEhbDcd2YsdsGqZKw3m7x4lQqVgtOql35BWUhRBbKwAk2J2fU+0nXkKp2wi1UmrNESFoJiumKvz7Ipw3siAKu5MqyT0vLbgeq4bbqJiOIa1Jx2LSGUrQ/ohMA6PrPiZjILGc;25:aPZyhcg3ZMkGt8NCYCwfnfebLxBqS/TWUaiERBHUWkxT8+U1x2NO8ywiCa8ZpQUg3QPNwdlcQcBFDMEmVxK2TisXm48gtYSWNhDImqAp5tQrM/rTghO1ctqB5QCdxs5le0ibmEKhgXvLFohZE1oNyvFtEYA6MlZwUeWtI1txZ9Dt+JlorzNluPx8JVEkRjqyWX8cXkgw4LnzvY7MorIWlFogT/jUnZ6mK15MNsY8p1uRGeNsG6pJYAIrC9Z6U6SjQvOqyj9N42wem/0ILwYg/Gm9bUa6LasjE/19avUW6h29IigY3pXUoNz7RkfmHHsZHI1HXpVEYlJsY4uLojoQrw==;31:1PAwAFtvIphsp9NhW15R//s743nOhp8aNTF7FoZ/CvWR8LP2IaMiv5l4k5sc+OqejZxSCFsECf12SMNKw1M0kHi6z+CB6Mgoltmt9cn4AFCJb2M6NnJrSWOakuZH2PJeYNxSrJ59IQEIHNZxnYkkR4DWilMjnuvw1oMppAovMV6YYcxOW/2hJmOo5hVn1FzgCzAYR3/Ji5CvAvoBZ+h41+f75BNmFFdIGpKRc/shIHE=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:Mugs2T8A1A9UqnwtjL6+FdRuE7SadhpYGQPUaN1gdg7AGOTwvmBNOzVRHIOdrEWHhAkBHV9FspkqLsgCRj8V+zxSgyvOr7yQXMLWylaKX6DSW4UOl1VV2VxFbG3Swgv6VC57IfO2VPJHcGc+87DasDwB3wv7R+0nqCNTd9oQZ5c8Au+DvjMQfgeAO9wCqv/DiBcNRK7Qo/qMPksrAzTLujcPBuhTY6IE8xxKRB3HGVi9FA/byXCRwGNqzJ7jKGVBfZRqyJDsJdanrvfuvPMQCJqHVBsrfRb/u+bVNZ4+GjrddMbdc58mVg9TyMxDNDZvXHFOwU1kbr6g/+yQFWzDiiaeHgDp08jlRaN9bNDI6mbFgzQjz+WjkgROQ4wzvtecHq95RXBfnk/Q7w4BAywwvDp1UqTBwTMG+OwZd3JNqQ67E/OIoPIJsueoqDW+RbjGUzgOHRCXNmo29ETRghbj29wPiT9/NOj0cznkLfquWePeQMz8yQ5gKjqOWIA9J3ST;4:DNpI151MFiX9Pg/97Jj4bM2UfD4AaX1rOg58AJX6Xiv4542wgIKBfjVDXbSbGwStssT+tVXNWynMcHobTvDFoj8akZ8NupAs63wsGVSBknHbFQaKNe+/c8YGEa1s1L8uM2zd3FGBCrMCgVd/zcWySXSmS62Vf4q/CkJcwEBRgYZ/aSQBBuhlHSxhzMIom2d4hUTU7O4WM/uwmCbp43yXy9ImXUswgMODSbvuEKy5L0xmRiNH4p+R4SV47ZruxuNT1EaFSX1+PVgp2c0SEhUAtq81yLbh2mRx1LrVDfmzSGvJZr22sOJNC+ODKw9c+A3D
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13348859684EB30DD1889539CD900@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(39380400002)(376002)(396003)(346002)(366004)(189003)(199004)(47776003)(3846002)(7736002)(230700001)(186003)(55016002)(52116002)(23676004)(7696005)(446003)(2486003)(6116002)(53936002)(16526019)(26005)(478600001)(575784001)(97736004)(39060400002)(50466002)(305945005)(68736007)(86362001)(9686003)(316002)(386003)(476003)(105586002)(486006)(66066001)(33896004)(25786009)(58126008)(6506007)(59450400001)(956004)(8676002)(81156014)(6666003)(81166006)(11346002)(76176011)(103116003)(106356001)(6636002)(61506002)(7416002)(2906002)(5660300001)(55236004)(8936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6OFNmckZwRlZsZHFLRUxPNTdPQk1qR3Zm?=
 =?utf-8?B?NnhhbU1sS0pWSVUybTFsMWZqQ01EQW1xSUUvVHVUTTgrZnFwQVh1cTlQL0Jp?=
 =?utf-8?B?Uzh4bUtmZHdzbkpTcnhJeEtqKzFEWWZ3Z2RKOHpOQlpoQVZVSzQ3NWpNcWty?=
 =?utf-8?B?eWZUKy90VnplRjVtR1FNMHI1S3BxMG9YVXN0c0VEbXVrWjVlMWpNR3Zpd1NI?=
 =?utf-8?B?RldtQ3ZsZ3h1WWlIS0Z5RXlqQjRwbmhTL0FldXhsS2dHUkpVMjh3dkJWWlRH?=
 =?utf-8?B?MFZEN2JjcThuaWRQV2RNMmdFYzJNR29uOEhiMVJkZWhLQ2k2WlhBdTFNbWd6?=
 =?utf-8?B?bk13b0dkcXN6NkRMcm0vaWMrUnZQcEFTM3hCanNBVTFHUGxsb1IyZUh6R1Fu?=
 =?utf-8?B?eHRnZjlzTElvQVZiSGZhajZNTXp4L3N5cjF2ZDE2dDZLNFN0V1h2aWxRUk1t?=
 =?utf-8?B?ZU43b2dtK0pNMDRJc3VQZ1l4WTljTkYzbm5VYTAyRFBudHFkMVBDeEJNbXp5?=
 =?utf-8?B?Nmd0elVqSEptLytDVHlVTUpNajZ3ZUcyeWtMK3d1N1htMEZYeDZWUURSeFhi?=
 =?utf-8?B?MDNZMjdPNHhkV1FYakRGR1BvcUVIK2NYVXI4ODhqaXRKblVHQkQ3WndNSnJw?=
 =?utf-8?B?VjUvREs5QVpGZjF0bkduc0hWNzFqeFpwdjl4c0NsRlpMYzJtMTdYOTV1dXI1?=
 =?utf-8?B?dytyUEh1RWEyUnBPQjBLTzlESFJzS05xNW52YzZGMjJqYjRFbk1QdFFlV2xo?=
 =?utf-8?B?bG1nZTFyUEJQaFRHb25hcXFOYkVvVGZkMlY3UDhveHpTejZGQWYwL25JY2JK?=
 =?utf-8?B?OHhGVWErd1NyQjBiK09JS3VuVUxVa1JONS8wY2F0SXNKL0VrK25Ya2E0QmNZ?=
 =?utf-8?B?QWJjRXNwZlpsZGthWlpEMHExRS9LVjdwajVlR1l6SDZ2WUxmMDh1MnppQWIw?=
 =?utf-8?B?bDBLNXVPQkpPbTdRK0ZvV0d4UHF4UGsxcngydFBjVFptWDM5VDBaK3NqSUZT?=
 =?utf-8?B?UzlXRElCWDF4dXQyeUF1VTlEZU5qN2oySFdKazhpR1MvNFZzVHZIVFFtNTV1?=
 =?utf-8?B?eXhOUzAyVUlTZjBENjNoTUFXUVM0VUNHZ29UTm1sUHBLa0gvMytnTGJCd0Y1?=
 =?utf-8?B?UFJoWTIxRFN2c3ZMb3BJOUJQYTZ1akdicUpFemdPTXVFMkFFeXA0V1d2S0xs?=
 =?utf-8?B?YzZjMUpiU1BoOG44M2g1cmlneDhEWnhmVG5PRllDWXVhK2pNdzRuRDErMkpp?=
 =?utf-8?B?VlM3emlOcUZOMDdsbksxSTgvT29RTU9IMk5OWkhmMGlHN0FKTUloeStCd0hs?=
 =?utf-8?B?UllxdHlOaStvclo3RGZVYlpIUDd6RCtpMkVqck1ZTGh0ZFNRd3QxWEJPZVNO?=
 =?utf-8?B?cEROaVcyYU1UZjNwVFVHb3JwdjRzbTY1cC9lWGs3bkkrSFBaTzc5Z3hBNEFI?=
 =?utf-8?B?YUJKY084OE1NRW53TmFVZVppRU9TbFFzNTZkVlZoZ3VWSWZvcDZCRUMxMzZX?=
 =?utf-8?B?VHd0eTRnQ09mcUxwQTk4bXI2YWF4NWZQYldQRWRKemxPMmdjSk9Pa0s1VDVm?=
 =?utf-8?B?U2xSSVhackRKOFJrR0VoWVZJTHRnbWtkVUR3WUZ4aUg5Zk82ZThaR3BENVB5?=
 =?utf-8?B?bnRCL2dDMkFmNlROYy9ERmxkSXVoN25xMEszTVFJSUJZQnpTUVJKUCtpbUdR?=
 =?utf-8?B?MzJBTVY0UkRKZWd4WS9XQzB1MU5iK1ZnQXFqcSsvQjMwMHgxaDdIcE8rcUlW?=
 =?utf-8?B?cGxBbDBraWtIZ0tiempmYjRTSi85YzFibDlpMDZVWnBSYnBCTG9zL2hnajRZ?=
 =?utf-8?B?Z3lGLysxTFpKaC9pdHduelBHdXVCQVZMakRwN0x6Z2lmVi9vK0Q4MjF6OGo1?=
 =?utf-8?Q?0y4UNnKLBS7TA=3D?=
X-Microsoft-Antispam-Message-Info: n8KpaTzpISsWBNcLzmPY8e30sVaxEbgz9UCszqnuWTyIlsg4Cv4s7LYRlasQkIH4qr1suizHw0LpgwhPpGhWFBXWq0LlWhUTaVpBSWSzuVLSiaxtGme6nbMx8RaC7krp7gGYCdHUd3svrFheq9HcMXHps5VjZG8irHiE9PgA5EWtbbfqEDrjVwt71aH/hpYQ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:A0m+lJaF5gK1kgBnetlfCjZM0T6Kg0QgTlxeFYHa1ftZfuTwDYxdt0Y/gN0Dn++jbm47h0StBxsCBDprjv+RDX/WJrSaCkrZgd5D81NpKu+SUli5V2sL5m5NkIFOpZhxxOdpf0vbjpcp048NbZ79KGcpgxBMf5RZqjpx0+DFqsAc1xqfG1+9P4eWpYlCqV++65AIWcvb3DBv5eA6MCoxIauWkHqKAIFeYpFIZpwOZDKpsyX/zDKhLQRGIPjJCJZZCiEBbS0KMHBkDZ/6P/m33JhSPZb91bhYj+xeDuISP+mofqwtnPHmIAX1Q1sG7Lw+etDYP0ChBqeie8d4Zt0IZgr71SUa5sb7jjF2vU02iKc0UbFsc64tiOR9OmxT3fw0imRdbChtB2+uc+MKRLTvTJNdyPkCGwnWTSroFAhBs/OuAVIPgSnyL5MRkr4BjPiv3NnlyvBsplMRfUk4lEUIkg==;5:mBcBeHQKFC3Hx8Cm+pwxsE6ldIr7tbBVh8EVkXgZUtgfl8+lSTzXf6Hmv6t9vmPlKltZAcggVGADN0G85LiHwNaoX5xsXVvaGxuyyGen83bu5h7HI/8LFgs3+HL9YYAv9C+aNJr+gcQC3YphDz5fM9A6awDMNKttEXaSvijZQNo=;24:GBbo8BcMEereKGsExrc4kpHa4u3bG1FA/+Ft3nkk/tYukmt7a4uZRlBkvhNYUIosBzRZjQNS72OonYOOJueZ4JTeTmleejYmFt1Nl4rsAGg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:Ojt4Goq5qg3cxNounTsADQN2v9Dh/mGxz96jz4RmxG5vfG57HzNAuFZdD/iQmTSiHZZ0I4u98sGW15CVae1Cm74LytcfB9XsoRstQ//6tQdkpBB3lk2ITXr7Bb1DFQdoDRZNguAf29opSxPH0JjBkG/3g9/OspbHIOKHr+yd1hThs6JXzJzTlogZSrkHcIApkGnZKgdJ/Y8AednIjtqHp7GqGR22CcKRhgidR2/gLj1TBq7nlOoho4fVB2LP7UTP;20:2/LYc+vMBFU8G03H04mMm273193Rd5ya/KPozJpCEEjyo77bcVwF3F6nVYzPFH1tbcC2wGnFN9rJbgl9MbfNEYPnqhUD+p3am4ZjlAol8xHbDGb80hxdGdKFvlpJGep+X2Boi1/SKIN5rXhSrOBkzFvKhHWC5TY16gMNHwzBPx8=
X-MS-Office365-Filtering-Correlation-Id: b1159b64-c985-4bfc-4dd7-08d5bc9b3a5b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:42:00.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1159b64-c985-4bfc-4dd7-08d5bc9b3a5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790648275301690?=
X-GMAIL-MSGID: =?utf-8?q?1600790648275301690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces new config option, which is used
to replace repeating CONFIG_MEMCG && !CONFIG_SLOB pattern.
Next patches add a little more memcg+kmem related code,
so let's keep the defines more clearly.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h   |    4 ++--
 include/linux/memcontrol.h |    6 +++---
 include/linux/sched.h      |    2 +-
 include/linux/slab.h       |    2 +-
 init/Kconfig               |    5 +++++
 mm/list_lru.c              |    8 ++++----
 mm/memcontrol.c            |   16 ++++++++--------
 mm/slab.h                  |    6 +++---
 mm/slab_common.c           |    8 ++++----
 9 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..2d23b5b745be 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -42,7 +42,7 @@ struct list_lru_node {
 	spinlock_t		lock;
 	/* global list, used for the root cgroup in cgroup aware lrus */
 	struct list_lru_one	lru;
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
@@ -51,7 +51,7 @@ struct list_lru_node {
 
 struct list_lru {
 	struct list_lru_node	*node;
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 #endif
 };
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c6d2ca859802..996469bc2b82 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -264,7 +264,7 @@ struct mem_cgroup {
 	bool			tcpmem_active;
 	int			tcpmem_pressure;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
@@ -1230,7 +1230,7 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1283,6 +1283,6 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c4e70e8481c3..0ccdbdec1e5b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -722,7 +722,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			memcg_may_oom:1;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	unsigned			memcg_kmem_skip_account:1;
 #endif
 #endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9ebe659bd4a5..5b63d08a0e43 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -97,7 +97,7 @@
 # define SLAB_FAILSLAB		0
 #endif
 /* Account to memcg */
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 # define SLAB_ACCOUNT		((slab_flags_t __force)0x04000000U)
 #else
 # define SLAB_ACCOUNT		0
diff --git a/init/Kconfig b/init/Kconfig
index 44e62e0dc51f..bcea6671a3ff 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -680,6 +680,11 @@ config MEMCG_SWAP_ENABLED
 	  select this option (if, for some reason, they need to disable it
 	  then swapaccount=0 does the trick).
 
+config MEMCG_KMEM
+	bool
+	depends on MEMCG && !SLOB
+	default y
+
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 37d712924e56..232bb637cf02 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -13,7 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static LIST_HEAD(list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
@@ -104,7 +104,7 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 {
 	return &nlru->lru;
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
@@ -297,7 +297,7 @@ static void init_one_lru(struct list_lru_one *l)
 	l->nr_items = 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 					  int begin, int end)
 {
@@ -556,7 +556,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bdb8028c806c..fc67e43849eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -251,7 +251,7 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
  * The main reason for not using cgroup id for this:
@@ -305,7 +305,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
@@ -2123,7 +2123,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 		unlock_page_lru(page, isolated);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2388,7 +2388,7 @@ void memcg_kmem_uncharge(struct page *page, int order)
 
 	css_put_many(&memcg->css, nr_pages);
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
@@ -3001,7 +3001,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	int memcg_id;
@@ -3101,7 +3101,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
 				 unsigned long max)
@@ -4405,7 +4405,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -6322,7 +6322,7 @@ static int __init mem_cgroup_init(void)
 {
 	int cpu, node;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	/*
 	 * Kmem cache creation is mostly done with the slab_mutex held,
 	 * so use a workqueue with limited concurrency to avoid stalling
diff --git a/mm/slab.h b/mm/slab.h
index 68bdf498da3b..58c6c1c2a78e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -203,7 +203,7 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 void __kmem_cache_free_bulk(struct kmem_cache *, size_t, void **);
 int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_t, size_t, void **);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 /* List of all root caches. */
 extern struct list_head		slab_root_caches;
@@ -296,7 +296,7 @@ extern void memcg_link_cache(struct kmem_cache *s);
 extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
 				void (*deact_fn)(struct kmem_cache *));
 
-#else /* CONFIG_MEMCG && !CONFIG_SLOB */
+#else /* CONFIG_MEMCG_KMEM */
 
 /* If !memcg, all caches are root. */
 #define slab_root_caches	slab_caches
@@ -351,7 +351,7 @@ static inline void memcg_link_cache(struct kmem_cache *s)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b0dd9db1eb2f..400e26697bb6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -127,7 +127,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 	return i;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
 
@@ -255,7 +255,7 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
 static inline void memcg_unlink_cache(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /*
  * Figure out what the alignment of the objects will be given a set of
@@ -579,7 +579,7 @@ static int shutdown_cache(struct kmem_cache *s)
 	return 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * memcg_create_kmem_cache - Create a cache for a memory cgroup.
  * @memcg: The memory cgroup the new cache is for.
@@ -828,7 +828,7 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 {
 	return 0;
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
