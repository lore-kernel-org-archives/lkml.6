Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpY8vJ/Gfe/bSKE3SHqzopbCxe4rgjuG6fQXvgELux9OYX7QZneIfIvUiJBDK0+18zKT4Ff
ARC-Seal: i=1; a=rsa-sha256; t=1526633079; cv=none;
        d=google.com; s=arc-20160816;
        b=barHQ/gv8QwzH07LZnWtJXQ+2OezQ16DiMJbxfLMpb80s/DnO3inyoHbv1lr9QPoqC
         gqOigne67jJTOX3hm1KD0Ky2Ify4X8ooCIb6lojDc1t2tILPZKEcDDxpPuigJ166igNl
         GB2Jihz0dOKyIHrT+OlYCM4KdpqHAYXEtWYZMHWZ90jDs3zoDShjC3LNXh3RnPrT2vlZ
         2jjyXO/L37bjQpJADcR6fgkBz9CNo5c4azm+ore+ugmsz/WBno2anWRQTqdYIZYaIjdi
         Mer3b1XBJU6icGpj+3LLJZutJOMIpL1ry24RubbNX4rgpzBn40PNKnU5ek7qXiLli2iF
         SNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=xBG50qor4sebUdQJguVjMVdx4z4CT8BlDEp8BmOf7rc=;
        b=FTXylXLv3WMaLfTzn1w2eDJPHcuq0NaqdUp96yXU+St8yLyf2vw0Rr4F3Y1ED/UXPp
         Yt+fm9hZMJcwWruYZ8HjlUU2HMpMOGWjrvL80+4mWs357GCUvWN7FAL3E3mWr6A6fS6+
         FGgaS/sA6F5hFqbbfHHndP6lI4QqbWx7Ap92ttA2vJBrgWNj+J2CcdH0yYIDXGBM0v/I
         dNqJcZyO2tI1VgU8LFbs419m4K4KaonbJFcWL0LxhzbJrfsrWte3EjhNoIGHbnLLz0T0
         JAAieG5SlllPsdZ2Vh8FXWA5OjuZt6nqDrs89Uu3KxRfhBXtp+O+ZO1ul1SkMQw3BZv4
         Dsmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JrFWHRnb;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JrFWHRnb;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 17/17] mm: Clear shrinker bit if there are no objects
 related to memcg
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
Date: Fri, 18 May 2018 11:44:30 +0300
Message-ID: <152663307060.5308.7860175207287376342.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0037.eurprd07.prod.outlook.com
 (2603:10a6:7:66::23) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:zJp6F9CENqhudgaYw7jkAP3Nh55FQOVX+PWLTFzf1jPXkMduKYbD55TpTKXXyIBfQUP/s+2pBTpz8vbHTvt2lI4Wm5NpguBaSdo5+RwpNai3pL0A2EzlEZ8jynnhUUEvRSUYUW6qb+LGWPt+QUIW1SfY/U+tKzF6nB8zXEURie56rih5gjmEYfkGTJ26HPbeVygFWpjEs9P8cdUk9NUBWS3jfXezgL1SWhIz1MC0mjaxB9qlslMFj/h7ztQ+W+Xx;25:UE9D/m95MKjGy+5qB6b1tbPJqXAwDqTC10llKWalXp5PLgnPbFRmKFvTRy665zQObn6hikEm1lolvO0Gv5ZjR4LzTF6DSH/H9gTCiHHKfYGGuVS7QzME6vHKnraTTTh+q7q5UdXKsNPi4Myr54fGMOHihphDuNEkfzos1QXLj8APJHoU4L98y/ckeLohY9eB1MPihKcnhMipyHK6LLWL03DlIkoprvXGq/PpiP7OB3gBpJQ1vhfaA9MTrTmFqBdOVJaA0XqEOxHC5BKRSsvhH6wS/kpPWLKpPeN+8SimJj9jlfL1L4gA3bq5ftAuB8TAtom6buV3G/mzH218hw1a/A==;31:U07ise+8l53bOU9/Kshiq8sv3c/nscehp2+t7LlJkp2Rwtz0iHkhb9eM50OFAPfx2WJ+Aw9LzyoghVYOi1Y+d7xHvxWf8HTtKYhIDKJ2kJ1b7TNVh6pmrhVYMqu4fcZcZ/DOTjQ7/E1SvpL/So5lvGm46XvjK32LJwnrf9OsFxkrnA/dUy6IXMOy7jKT31ClQta8/bVdPqen3sjlEYUEIjT4WFHw/dn5tttpc9jCyTs=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:I2SwtkXqBnZxQJdAp4Gxb6xC9ZL8VliDrB2Y31KZQ4k96XlC6KaSErE5J7Qp8kLbpauVgxvyIx8dK7y6vsQanH9LWgXyH5/UaQbOdFHMUKZm4rMUJ8BAwOkLZLutF9IcTjDN88L+33v79+b994pRJR+JQYZdPEHACBx3kigNcSHjCOU/rY/CatVmvrVyvfjmoAa1cRUC16aUK+lmMKNS1YmEwyBryOrKabhPeweOZ8e/auwg2rwXBbKWdwF1sj8fGehWR5YMUNzA7dfuw+GrbUI/HwdzlTMCEFxexk+no16/JmI+edht+pCQYEfvFJKDooN3hmuz0swvFONAY1yGAFgiwExB4y/MNMLypcCH5FFctLtti12RrRmPsiKOHASbIcsC5dPrGDqPkRWNJtGoFJO5WnjANdxTJDCz4dBHY9ppOhLXBAqJ3I2FmuEWcqRd8GwoFDljdqIIp7iM/p26AwIMqcDU3GeTq+34VnzEKVy7AMR7NDc5NiurXPRY5ZAD;4:y344r3ww5pfA6ijQyb/nPfiMnaAKQVtvD09K/HZoYy/uB5x+tFe0gWJWyYKeeV6XVt1Z+hA+zdfmxj7sTNt6qXJDjpyUxq14v+BbcETHeyAz8BMgxjiOhX9kRWMiJPKRdn7QU6dU3NsEt7oH1Y8mq2Ty1Q7vFk6mjRERnNdBxpJqqACH5y0LffecH8z9kkWQe1mGja3gfmDpaxAjh8SZWYnWUARyUy5e4idla+gEo5FPt4r+1RSTl4dlnd2SELaj2h99UBAGmk90nMuDCl2BicIZUb9CC7dKVIkFH/VQrmE4OcdEn+8PpuNPPDhtVdcC
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133796D4586C919608CB181BCD900@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(396003)(376002)(39850400004)(39380400002)(189003)(199004)(105586002)(106356001)(58126008)(305945005)(55016002)(26005)(53936002)(6636002)(9686003)(6666003)(47776003)(103116003)(7696005)(33896004)(66066001)(76176011)(6506007)(68736007)(50466002)(386003)(55236004)(23676004)(2486003)(478600001)(6116002)(7736002)(52116002)(7416002)(3846002)(61506002)(59450400001)(956004)(97736004)(476003)(486006)(316002)(81166006)(81156014)(8676002)(446003)(2906002)(8936002)(11346002)(5660300001)(230700001)(25786009)(39060400002)(86362001)(186003)(16526019)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6aGNGaVNkZ1E1dUliUnUyenJPV2U3S2VZ?=
 =?utf-8?B?bDVZcDYrVmdWZG5TejJ5b2xNTHQ1VHlXSStOckdUQlo2VGdEc2VwSG9Wc0tC?=
 =?utf-8?B?WThORFdRdDYrZjArc0s1WklBaWhxdml3ekRCZkZiK2hBdG5Nb2hZUUdoeFJp?=
 =?utf-8?B?SVBURHVzRko1RGhKbSs1d3QrM0ZjRGs5Y280UlM5b2V0YXpHaklGUHY5Z0dj?=
 =?utf-8?B?dmNSTUt2V0Fac01Ca3FtRi8xSklnZEM4QmMvSXlnQzYwM0NjblZucmt2TC9N?=
 =?utf-8?B?dm9kQ2NMRHIwczZQc2R5aTBjcGFLVG41Y1JlOEJrTXhhenpGbUdEZ2UyQlND?=
 =?utf-8?B?R09lSERjVXpDRnJia1RDeVNBQlMzbk5BMm1BZTFiekRIKzhQNjZtUUdZYnVR?=
 =?utf-8?B?M0lFUktCNVlYc2JEVGZOdC9WNG43TFdRaXNoTFQyNzBaY2ZiUWJ0eFBGQkQr?=
 =?utf-8?B?RXJIWDc0R3R1SW5NRUFibmxiOHpjUktzR1dkRklqdHlCVnRlL3FQWjltVWZP?=
 =?utf-8?B?SUtkODJpNDBBZ1VhVTlUcGszdFF6VnFDRUJYTGIxZFVUOW4rSGlQNXBSRzZT?=
 =?utf-8?B?MnZiRWxRd1pVNjc1ZVJxUzZPUThWT2VZeUljZS9kTzJ2M25iaW1STmVKekU4?=
 =?utf-8?B?ZURaRjlzejdSYXRsclpyUHp3VjlsdEY2U09MTjh1QkVIeVV6ek1NTXVYeEFa?=
 =?utf-8?B?aFVwNDduZ2lzVm9tRWRxVlhqdStLZVpsZmFOcUVhb0wxUmxUMVAyRGhsWFdu?=
 =?utf-8?B?aG5hU3FnWGI5VWNYUC9OMDAwSHVKSEYwUWlucmEvTktxbU05WHpIOTBXaXky?=
 =?utf-8?B?bWNsZ0lYQUFaS2dIL2dsSHV0VDQvVjNVU0ZGcEZRaHJaTzJBM2xMaWF5U3hD?=
 =?utf-8?B?SDVTaEx6dmpiS0VhMjRRcHZRL3d2Z3FsMjJrQUh3YlVKUklyNE1RSEs4ZTcy?=
 =?utf-8?B?SGJWTGEzTVVMdUZqNTZUYm1Qd0gyczZWV0gvRVlmaUEyeDRYWDhnRnFUQWN1?=
 =?utf-8?B?emJKSHU4QlJuOUYvL2JjR01tN1JBc0YxOGt3bWlsNGxCRlFRWHlONGFhNFhm?=
 =?utf-8?B?OFVjK1VRZEFkTHhvdnU2dkMrRXIva0N4aGkyWFgxWmhybFlZc1NjZEVmczZW?=
 =?utf-8?B?YTcxWTlkZXQ5SGtiQWF2M2I5bnFPUlVFc2czN2dzS0JWRHFzMXA2cjZYWFlT?=
 =?utf-8?B?djJEaWZKMTNnMGd6cWE4SUx2WGdSb0dYc09sUXo4SG5NaXpKT01uMW0yUlBP?=
 =?utf-8?B?QnJ4V1ZxRHV1a1AyODZ0amUxQXJjaHBGMHNCVkc3QU5qUnlISVhDSlJHV2M1?=
 =?utf-8?B?NThnTjMrYmFOZVdyNVpHN2NReHBickV2MGhLaHpBWkJKM2hBSUZkZTU0cDBs?=
 =?utf-8?B?cGk5TDFMdzgvYUJhZFFSSSt2cGYyVkFLb3F2b0NsTi9ON1VrNyszcm1RK3dz?=
 =?utf-8?B?K2k2TVZPT3dSb2duR2dWTVZuVm1tSmpMZDdpTEtVaER2cFZvV25vRkVkS253?=
 =?utf-8?B?dWU5aWdIdUtLd0ZrY2M3dTNSelhZZGg2b0hRVVdheUVnd1NaQlAwcFd5TTI3?=
 =?utf-8?B?d0JHVXNJQVBlNVF6Vm4rVmVpTy9iWnBPWkhaS0tDR3BueXExT0RSeWN2S3F0?=
 =?utf-8?B?ZHgxR2ZLVm9WYVFwdy9IZXZ3YW5BdWV6S0w0VG5jS05aTDNacDREU3E3RWxr?=
 =?utf-8?B?eHo0dXZrTk9pVWNYT0JROWh5Q1lmSFluOUFQdU1PcTBjdnluVkdwQ2Z1S3Q5?=
 =?utf-8?B?TW9tSU1JemVMSzBidmhUWGxBcThoQlNDVjB5dTh5aDRKMGd5dHAva1NNUGhK?=
 =?utf-8?B?NS9IVnRiQlRVd1JpNzU4clBtS2tnd2VCbHJzbzhEeFF3K052UT09?=
X-Microsoft-Antispam-Message-Info: swYlQLUMiieQat+0hqLmUzWQE40wjq/Hpf57it+BsnTIL4g87wweiMLhBNpcS2DqQyav96UA9n7BvqbDWniiwgyeHPIsOD3/j5zRMvbY6UgHSidvJFbOYvN14X954izyGCQ00XR3R0MqblKRZbdp27dmfg1s6Y4LsZTYgiNohABhpBx4HtYt3RmL2TPEKVzm
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:Og0UpPVKpfP4B57mn9V6CwQthYvJUcl8QwK6q61AiZDfbO90YZQsK9IbLKLTzmiGO33GjMA2k6dsfitDVD/Mw4pOyND0D0m6t3z+LxvCNJPi10hgManGnVtOVabQ9ZHn6lIwvZthhJuCzsiHUa1dfvMa0tgrxsKhxBZsk9obDOC+Lb1gMyjfftfpYWSQ2BqG6QGXVum0vG+PRwAl14U26CtuvfpvrvlEwlZZJmFmkZ1UD2NoBqTl0LdTor8MLdhN65V7fCLNPZHpTcTbUEOpBNDl5SDFtQe8RWbtEB97c0X2xc3jC6eRYZcx4EgNNdF2Y/yjxlxt4EpPgq9boQXzg7rHWsnpTh+IjwAIsiW4ex0SyPEr6/x7L6yTSGS1ADJkAGAuUUgh6icKwQXnjfYsnXfQcTq7RguJVO3xh2UNZfODGzm5AHU/3gdU8X0fua3u7wIRjWdkr9XPp0tiynDuIg==;5:svITGuoBXLk0sQZKvv5jflqtNI9jT2NdvsJBykk14DqBkugrp4fVm8N6FMi6znrNmFcgTgpraOwFYarm873taMqPLNxdtj5sEb518mbXxw8bobFMvZI3CDjUevvf3fYsAQGCwG+XpqDDNtYIFhjgkK5jnBRaS2pYB45rO7Ks1ZU=;24:r5fLqtYJ3hhyjWZ3JCCCZ5yLI4DKibG/3MEbCn/PpdNXMLRtNOxPAH793yyAm63lbKROpnWOTzoGk9M6nghLshl/kzZJODmC0j8CBUv6vTY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:vRdEOhLUp50T20WkdHdafUirwKdwKSwoeEnq0l3UG/in+uVwE9iqcwZVPBCmZ4P28ol5Cnmof+3a3YqJovwsfOzVwqUlpox24BURxTXwmxIBY4kJsYaWZi0qF7vzeliAkH1PViVr7cpVMZoHzeptQNkim8ubELrkXGirk7Ac2fAWUOuMlkXO2fC7EnasPBAsWKr7elxKemGZomJWwP3k8iyj2xDuKurEor+8VMJAll5UmML0tIeD2Ckg2xAthUyB;20:l6ArnhNPTaTi2dKBQnCse7iF0h7fFfz2DJtdGXsWeDArA7XhhWPSFUn70FBdObwdsEbGZLnEZUzYeULdde/LFJWZXO4+BoZj4fKiJxG/DDXbD2Zr7/viUhg+OgqrmYsgSC8grXtNC7m/1IrSrVpCjhbAGK/m1K8qS9O1/r23NNA=
X-MS-Office365-Filtering-Correlation-Id: 672ac99f-8cc9-4976-2df3-08d5bc9b9514
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:44:34.1592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672ac99f-8cc9-4976-2df3-08d5bc9b9514
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790807790199520?=
X-GMAIL-MSGID: =?utf-8?q?1600790807790199520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To avoid further unneed calls of do_shrink_slab()
for shrinkers, which already do not have any charged
objects in a memcg, their bits have to be cleared.

This patch introduces a lockless mechanism to do that
without races without parallel list lru add. After
do_shrink_slab() returns SHRINK_EMPTY the first time,
we clear the bit and call it once again. Then we restore
the bit, if the new return value is different.

Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
covers two situations:

1)list_lru_add()     shrink_slab_memcg
    list_add_tail()    for_each_set_bit() <--- read bit
                         do_shrink_slab() <--- missed list update (no barrier)
    <MB>                 <MB>
    set_bit()            do_shrink_slab() <--- seen list update

This situation, when the first do_shrink_slab() sees set bit,
but it doesn't see list update (i.e., race with the first element
queueing), is rare. So we don't add <MB> before the first call
of do_shrink_slab() instead of this to do not slow down generic
case. Also, it's need the second call as seen in below in (2).

2)list_lru_add()      shrink_slab_memcg()
    list_add_tail()     ...
    set_bit()           ...
  ...                   for_each_set_bit()
  do_shrink_slab()        do_shrink_slab()
    clear_bit()           ...
  ...                     ...
  list_lru_add()          ...
    list_add_tail()       clear_bit()
    <MB>                  <MB>
    set_bit()             do_shrink_slab()

The barriers guarantees, the second do_shrink_slab()
in the right side task sees list update if really
cleared the bit. This case is drawn in the code comment.

[Results/performance of the patchset]

After the whole patchset applied the below test shows signify
increase of performance:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i;
			    echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
			    mkdir -p s/$i; mount -t tmpfs $i s/$i;
			    touch s/$i/file; done

Then, 5 sequential calls of drop caches:
$time echo 3 > /proc/sys/vm/drop_caches

1)Before:
0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU

2)After
0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |    2 ++
 mm/vmscan.c                |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cd44c1fac22b..dcbb7e03501d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1293,6 +1293,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 
 		rcu_read_lock();
 		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(shrinker_id, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6639d1e7b6a6..c99c248cdfcd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -600,8 +600,29 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * After the shrinker reported that it had no objects to free,
+			 * but before we cleared the corresponding bit in the memcg
+			 * shrinker map, a new object might have been added. To make
+			 * sure, we have the bit set in this case, we invoke the
+			 * shrinker one more time and re-set the bit if it reports that
+			 * it is not empty anymore. The memory barrier here pairs with
+			 * the barrier in memcg_set_shrinker_bit():
+			 *
+			 * list_lru_add()     shrink_slab_memcg()
+			 *   list_add_tail()    clear_bit()
+			 *   <MB>               <MB>
+			 *   set_bit()          do_shrink_slab()
+			 */
+			smp_mb__after_atomic();
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY)
+				ret = 0;
+			else
+				memcg_set_shrinker_bit(memcg, nid, i);
+		}
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
