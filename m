Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C6920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Yu3M+8mG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C6920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeFTJoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:44:24 -0400
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:44672
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754101AbeFTI2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGKd9p3uc4S1dkopg6w+SvEO4u7MlyQ4uhRDMsFYDqw=;
 b=Yu3M+8mGusE+hp+KMeT1i7391k9pp5nK3YVGFvhGwVwGh8wnDQ31fQfnFz57tAgTj0HAB57P065ZE/5m4jZxcyENb16k0LokKWm5ZyupQLYCo2bmWXD2/X839RWMThrhSU6mExsaiqIGXf4Vhp87K5p2agyG77S1yu6ScI46Q5w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (95.15.33.164) by
 DM6PR07MB4379.namprd07.prod.outlook.com (2603:10b6:5:bf::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 07:34:05 +0000
Date:   Wed, 20 Jun 2018 10:33:41 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 0/5] bitmap: Introduce alloc/free helpers
Message-ID: <20180620072721.GA19364@yury-thinkpad>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [95.15.33.164]
X-ClientProxiedBy: VI1PR04CA0092.eurprd04.prod.outlook.com
 (2603:10a6:803:64::27) To DM6PR07MB4379.namprd07.prod.outlook.com
 (2603:10b6:5:bf::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe55c128-7018-4246-43f2-08d5d68038cf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4379;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;3:EGXuyadceqtvsi9YmEuX+Ql9K4iqDzEMg7hBCUw3FkT/MdJk8SQsq4yUk1LgLq8wHVw/1O5R4iZMpGowP2ay1kKRCJh2A4PV6GEZTrIVRMWcyaYMC0iG+DzVUYwQuYbDT0tpR7x+siTAQ8X6I/0mY+kib3rIDBlhpGBcty3rAiKpLe5OAYhSFTwjRXFnH4XtFlUa18B1mACtYUm01GnltfjlX1M+YSVQymzXuUlFHzbM5dU4G889MntOapGi6tGZ;25:7NmBOfaMGehtL/k1vt0r8R2ve+FvIhtZ5bbS4Cegg38U7k11Wczi5btxBZqMQoj3W69yOhG8LRdXQK1hqPhpC7FhV49uRa1Bk2Y/HQ4Az9/QEPZq7ugqMLNb0muVEOM0vC6Q0EyXfjJW0WRtrdA1BW5v0rIl3BDoTyzx2y/dDfG/WY1uITIKGP/QnB+HrXNUhnO+3IbofU98A872tTsFZ1IeYM4prLLt8lvSWLUgPCNauJpv4zky/W0uy6zM66ooUbVa8hq7GtnJk0sGmpoDXyY6G4IhBHn5JvuBuoOgyE1lTYFGbzvnGuVG4GFcNI94eRrlLqwp7/KSPJLWNopaWw==;31:QlZ2NwnBBx2w0wjyPZKLZzEHZq9e6dUt9BTaKicdw/OQskOF5i+o/4wjncbFn8cfVMk0SwT5kVSWEP5MIS91jne96nBarCtPHncM4T+vi1RuQNaxGux6Dg4/dg3QH49Mf9/5SdOZIP2lLU4Dz8QErJ/iK2+dBrpDvVnk2fnvu5ZEY138SI+4KXPzR3jojqghyCymXKF+FZUC+fnB8SJCwazxs7v/UoV/CqUozheD4gc=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4379:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;20:BU4+obit9ZFXn9oqOftZzcNOBB509TCkxM1R3ngZyAs1YbiIUd2U+xfIpd457xbPRvAbLORs5nFVCGTcBzzDyC5MoAz+dFyYjNZN8pHcfGKk8wUoXp24HxXOvF4zRDOPxud8R3ryeYhosEYcxeHlo5tQ/WsFytpmzEcjIDyXxUEUAonoRAJGQqo/p768cVEYYqPa2AQoVtkXM3j0w+zUBOEBsF6BWRdZU47FXt692RLlhU2z2DvoIuhYxHSjKhS6ns9x6MbvIQhM0I9/ITWwFBm5lrrbYF2P2s08/nw9eXniq4miLKaVoZSXi6BIpzUP7Ryo9CmXmEGUjirx/Nn8AQqVmIBgJs7nhmGD/RAZrfn+D6JbFkCOx5UyVlMK5JzhK9qpKeGysCYoJLiaBbwm23e8gQTeMWT/CRjzLvQYEsbZKjF+MHIdY0YHgOvtNEy8HmLDrJOnzAv/RYqirxzBCCSJkUrkhi67xxkA+C/i+5nzvpVX35Z76aq+IZHdhH+PCnzEJNdXwXG3xSrMD3Hgs8SWdR2Z88Qg4xNzZoASGkLZmWGk/NVAcRpyaTDHpUnkR2uJD3gJl/LtUPcxg2AjUlOGFOYW7M7y+U1Zj0vLKMs=;4:yY6z7mmXE5V6qy+kg90llDOXY288F71evUAZ7RJvOavglz2q/GuYvBtVmCwW71RtTTkeWfKI7zDS+7F/AREQHzaK8TemcCR9Fgo89mPbGVsbkSxqAFVQMX8fcqR+rZ74Z7ZaPDNjztXPeWL0EQZf22wEFiTJy3sO6VaRPWxsUagJNGOW28AEhM0nqb/VAsJKZn/0GPHpJpsZc7hFiWtyCkY9XD0LLHKy98dALbM9dgzX3KCCDdNLa/PKPp2yyMfw+DnBTyAhh1czy42JASdT+Q==
X-Microsoft-Antispam-PRVS: <DM6PR07MB4379D27633593FB216537E08E3770@DM6PR07MB4379.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4379;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4379;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39380400002)(376002)(346002)(366004)(39850400004)(396003)(189003)(199004)(229853002)(6916009)(25786009)(7416002)(105586002)(305945005)(106356001)(486006)(476003)(81166006)(8936002)(33656002)(81156014)(8676002)(76506005)(7736002)(58126008)(16586007)(316002)(54906003)(5660300001)(68736007)(6666003)(47776003)(53936002)(39060400002)(42882007)(6486002)(4326008)(66066001)(6246003)(16526019)(6496006)(478600001)(2906002)(6116002)(50466002)(52116002)(33716001)(76176011)(59450400001)(33896004)(446003)(11346002)(956004)(97736004)(186003)(386003)(9686003)(1076002)(3846002)(23726003)(26005)(72206003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4379;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4379;23:PFV3uRfgHwp/HSxF8ie0iCtlsTHZBSCEMWh9B5Sot?=
 =?us-ascii?Q?tLuYY0A9+UD6XLEd7riR6NEj1HqD6nCr4KWojgyspU7UHpynu8m1WYoA57Pt?=
 =?us-ascii?Q?8ZmJKrTc2SlqohVV82BfoX8w+CK0lBdj8+WLH2q/3ilW5uXdC/iWJLelF6RC?=
 =?us-ascii?Q?/I5et0hz70IejOZZHInxCogrR9ez8zTHpFW6AUnOFQb52T3LCkFHhppyCSQ1?=
 =?us-ascii?Q?MHmNp3Wm+XNjzR+yn33AfimEP7Ft4UMqxOiCuu2kQJap+eaiYmX6HG3nKGRN?=
 =?us-ascii?Q?3h9YIwRzAJF1dGa1WBjDmzsZZszjk/sX7jvG7Xds2NFqPUpFvWWSSEwTPCT1?=
 =?us-ascii?Q?agO2rfFVU2Vz8QD9EjsaXwV10AT4W2CXz3UORlIAmieRFDHnHOkpK7uuxJ8w?=
 =?us-ascii?Q?Uy5PahP6i9sups/0blgre2LGm6xzayn+hdI6bUPT9j7NQh7RB2yr6eRmvLz4?=
 =?us-ascii?Q?xJ66GRKGwS+WeiOwCBUekXDb8Hi10HmPILJMZLEPRy2ACeneOJK09OBnrRas?=
 =?us-ascii?Q?vrAp10z1GpE1ZHcPgj0dnz6e/DMC0rRcLwGYNbu+eOgmKONdMAfv8ewS6sJE?=
 =?us-ascii?Q?SAMimsp/pLyGYgqRe0E983e3h/iRPpRe9Ivve08bOj0mK8RT7W+egUIRxJhY?=
 =?us-ascii?Q?PNBlGWc4AHtt/W7wTWxUoeL/ak2WRDsucjd2jHGaxdp4HODrbA5kGnCUeyZ1?=
 =?us-ascii?Q?0CUz34Uw1S9iFU1Jy91U2B/S6SkAeppxMDPbwH6rVg28pJeFGh8PCnrWCPAx?=
 =?us-ascii?Q?+O1mQjJxD/XbM/FIEALMmdZBZLoaCkLFB/yvqYW3iDuW9jLh9yo6uuefj693?=
 =?us-ascii?Q?ad9VwP38s3ztx2FaNqM0MeQK1i2OwqyoxLeXv2JkxvuIjVB9yv0Q8hGjEZEI?=
 =?us-ascii?Q?RRhSy29zO2js+H4zx9izNUwexp1bewRs0Tr3AJd4Gh5rTOhcJofp4VpRaPLC?=
 =?us-ascii?Q?Ch0ecvnz+vj8MXU9bBjmZLi7hvYTxn5A7kwG0rxZRZyFeQQV1Joopu+5hqzI?=
 =?us-ascii?Q?0kdmTRdFA8j4o5Q8XG7ZrIsvRe8LUxFpKrOursZ1rOhkcZVVFC5y1ZUuArPd?=
 =?us-ascii?Q?gRO1iMHdxNN7isl0mNOvPHwktAz2l2SztYi1Tyf1GYEoKENtA3Sp2LrCtyoR?=
 =?us-ascii?Q?ZmWl82VOT33K7V9eAbLTVdjfdSk05s/5evx1uMW4JTLgHFB92Xwod5g/rwpx?=
 =?us-ascii?Q?UpSHuvB/65a9/S6wtYyKv0adwH0NW0t1CwJmDo8+oshcRep/7H7Dff4GvP/s?=
 =?us-ascii?Q?0LpxGa7GF14l3cJweyiREoAJDskB0s7fl5Zth8+Rb2/YnjIUHaeAd6uRZTYF?=
 =?us-ascii?Q?pj6oO+sFvnMLjHRRE2HmngqUvF0f/QPAVAzoAOxUkT5OUQ+lGhu1K6kaNpEG?=
 =?us-ascii?Q?dOyzwGtucERJEkP2VQlWhaVm0hkZs0gS6XkoC1bbwi9aj9Fcng+i1m66Stvh?=
 =?us-ascii?Q?tVkHzAMQ4gUPdHMjnPbA/BgvHwXaZQ=3D?=
X-Microsoft-Antispam-Message-Info: 5Xh364q6IwdnJo+xJ1EduVVBQwrHJEZNqux15gIKydBC2lpVw0QCGFsiivySxufnPTU6eixG3HjnuYYqiSyc6lk2kzJaUbOby+p1Kl3XqKArdClRh/iQpg6kXa+WYic/ta9iahqYSMGLbVYzo9/DTaiIfENUKj1xhPc24TCJnyenEh6Uy2weQz3hre9zkmZ8foQ9G4a0NuCCzv6AvAqk2Rmq8bNqIqOCHNbkkuzTyTzVuLW5qFRzmrHIUfw7AFW1TxvIPuUaBr6kFFja2fmDhtsus2CkoS3V4SqqW2fHIKDoZd7jbcSxx/4Le0OTTptltTPF+8saXVYxIn1DQ9H9fw==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;6:erNIOLp7kQf4dYJLKZzEiTipKw4/hdd1iLtSETHcKtzB9PUYyojkvBO/Gumvbv0YdIokQmCMAuz94IoNsr8AX6tHTGnWxhStSOI7a9/EK7tXClFe5CLsMGV4YKBnbw7vZ68YRWTFgReomsfMTBg2JrP54tFzkFQPA79GrFydNFXPmhPrlV3N7XJM7VGT8MsDp7Xv4mJeBd1PpWoSj01w2IZ3nrTR1gi0jaNCucsRkSJSGMEvQ73q7x4EqztlCyFnrpLm11eCNU72Ul6AdsDLbVfXD4RvgBi7XV7J/afGqJZgEDwVHm9Dfr9M4oBnq/q3/+TrXpiihC+EdPOfr2UeYqqfuvQqZsPoqSv08OtYV1cyHIdEwnJOKhtqcxHhUB4bmSz35U9Z+NBPMkkddqrJD3mpb4jUGwOwkL3QWqcvMSMRavmsJ3hRB60TVgL7RXVLuMVIpxnBhR+VO4BQ0aBWEw==;5:VVoA+NP1IbhJfbBFVwEFbSwitsITTlcTe+DAVNOeen7UpbtPUiRshpL+LdzrXsc69vUCTcVZn7FT95VWx3CHQVcKlYPsaeyjuKKAT24fw8ymztHLK26BJ1pFFAYpu4H3M1wsT1rK/ZU9pbaBs5TIUCf5YnkVIJXn1p9ItphvuZo=;24:62AgZ9OneZWM2VU9l8sKhAnz+FAtIzNPRsup2xheV8aIcvtFeY4IEUG0dokRaB9+0wCgUFRs3a3uTuF8Wxf4QV8h4fXzetNgPgjVsxbo4G8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;7:TpshTrNYL+BrgOeN9vkOfE9LmYeExZfTmPllkQDZGa5/NSLEh2yPh7QsnoLcjDusQPr73IhJ1uMo+hOnyGqbXVNu8rn7dh1b2HpedEmKc+QQhjTLvHwk/EbIq3ToYDeCARyZbp4kKhjDXHet+aL511l8B2kpnrn4xFBbAlB3TqKNhYVozaGkU7OUjpsKuAisItlNFFciXkpoPhIj6wUhH3Rj5bwDCAbt5jTc3qeKeYTkNfdg2pBM8ZvvwWIhLHaS
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 07:34:05.8230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe55c128-7018-4246-43f2-08d5d68038cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:09:58PM +0300, Andy Shevchenko wrote:
> External Email
> 
> A lot of code is using allocation of bitmaps using BITS_PER_LONG() macro and
> sizeof(unsigned long) operator. The readability suffers because of this.
> 
> The series introduces three helpers, i.e. bitmap_alloc(), bitmap_zalloc() and
> bitmap_free(), to make it more cleaner.

tools/include/linux/bitmap.h already has bitmap_alloc(),
and it corresponds to bitmap_zalloc() in this patch. It may 
cause problems in future if people will copy functions that
use bitmap_alloc between kernel code and tools. So I think
we have to propagate this API to tools and update existing
users of bitmap_alloc() in tools.

What about code that calls specific alloc functions, like
memblock_virt_alloc() and pcpu_mem_zalloc() in mm/percpu.c,
or devm_kcalloc() in drivers/dma/edma.c? If we are going to
unify bitmap allocations in kernel, we should think about
unification of that cases too. Should it be additional
flag or optional pointer to the exact allocator in
bitmap_{,z}alloc()?

Yury
 
> Patch 1 is a preparatory to avoid namespace collisions between bitmap API and
> MD bitmap. No functional changes intended.
> 
> Patch 2 is just orphaned from previous release cycle.
> 
> Patch 3 introduces new helpers.
> 
> Patches 4 and 5 is just an example how to use new helpers. Locally I have like
> dozen of them against different subsystems and drivers.
> 
> Ideally it would go through Input subsystem, thus, needs an Ack from MD maintainer(s).
> 
> Since v2:
> - fix compilation issue in MD bitmap code
> - elaborate changes in commit message of patch 5
> 
> Since v1:
> - added namespace fix patch against MD bitmap API
> - moved functions to lib/bitmap.c to avoid circular dependencies
> - appended Dmitry's tags
> 
> Andy Shevchenko (5):
>   md: Avoid namespace collision with bitmap API
>   bitmap: Drop unnecessary 0 check for u32 array operations
>   bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
>   Input: gpio-keys - Switch to bitmap_zalloc()
>   Input: evdev - Switch to bitmap API
> 
>  drivers/input/evdev.c                         |  16 +-
>  drivers/input/keyboard/gpio_keys.c            |   8 +-
>  drivers/md/dm-raid.c                          |   6 +-
>  drivers/md/md-bitmap.c                        | 301 +++++++++---------
>  drivers/md/md-bitmap.h                        |  46 +--
>  drivers/md/md-cluster.c                       |  16 +-
>  drivers/md/md.c                               |  44 +--
>  .../md/persistent-data/dm-space-map-common.c  |  12 +-
>  drivers/md/raid1.c                            |  20 +-
>  drivers/md/raid10.c                           |  26 +-
>  drivers/md/raid5-cache.c                      |   2 +-
>  drivers/md/raid5.c                            |  24 +-
>  include/linux/bitmap.h                        |   8 +
>  lib/bitmap.c                                  |  28 +-
>  14 files changed, 283 insertions(+), 274 deletions(-)
> 
> --
> 2.17.1
