Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07683C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1A42087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gaF1sxxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1A42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeGISax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:30:53 -0400
Received: from mail-he1eur04hn0222.outbound.protection.outlook.com ([104.47.13.222]:47008
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754558AbeGISav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdQmJKd3k57WqGxK3nzeA5RofD/US4/mEBtK4bWmINM=;
 b=gaF1sxxwdMbSCXTuDPagK8/8tZZImBtwVZSq1RBy5Kbv4NzQgHngKU0sOi5LIeeYeCRIUNuNBhrn34UTwA+z9Qzovq4kJC2yv6aO2eG11S0ClIWFza2Cr9bboXM5fYERX6+pIdFSnJZ4/1klxJqFkfFxrE6j4j4py7k68WJB2Fk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 AM5PR0801MB1969.eurprd08.prod.outlook.com (2603:10a6:203:4b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Mon, 9 Jul
 2018 18:30:40 +0000
Date:   Mon, 9 Jul 2018 21:30:34 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx() in
 kvm_hv_flush_tlb()
Message-ID: <20180709183034.GC3017@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180703134206.27240-1-vkuznets@redhat.com>
 <20180703134206.27240-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703134206.27240-4-vkuznets@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM5PR0801MB1969.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c981fbf-6c25-4379-8e0f-08d5e5ca1353
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1969;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1969;3:g5Df4Ij9jCel2vb2AtQlSL7GYbyHXKZFDJrqwMun8L3c6FehSVI0kwW1Lb9byghsjK4kbtY1lPceYDwrxRY1OLa1TLkPar91m6G3CI1zlKRzSJje2xYUrTEHFlr4wAC5QCKksTcokWxrnshqX4dOeC0rFebm6WwI7lvbhVQlF4NAyaHoyTI1ZHhz/sGaQJohhfvQsek/QSyWLqkpFLh0DiviJ3VYjINrThquKK2S2s7oDjecXlXvGdg9zdq01Uev;25:aAiAdskdSXGpzKeA2RplmGCisAsdVGYWVRSZZXG+/+HyrOeanVOq8wqiTCJeXEVSvv9TXrC14qt7XNywZN7dIM05qyM1GCEojtj971M5ZQ6+VC7YyPsZjgn5Djc1EhIMNfONBBmj5R7IYDNbkiXElzkPXBbEa8uMwsOpeARAgphEIkbukwe/tecXb/1BNgWwjS7yBtVwRxJZ+YFnizhkXYuZ4jN91VOpGhcRCxXC8ByleS61cDK/ZeSHjLPaHHMoDWbmTQI4varP7MMT4NXQ8Fn7FTxRPIZ9cszxN8L6rLTPFP1kK3dsax8yA0fy+VtP75J1xlLqHWPm6RwvS+1Rdg==;31:mNq20XyiH0AlSDGwL5qB8GtXyMUtV+CdIQwxKMPo56vE6dIuhnnCVa8rdady26E4CpUsKoNJhWKXOGkAjyDv9vbGY2j3R/r/zpVXmxXweWMZGg23vNkM2LBthlG6Y8K2zX3Zsic4sjWEQxOPwZaXMGhtOsmSrtHi4i5ZDTYqOuEDCsjM/irCbcIkDjj5JEKPHAsoP0/0au8rpR7arrg9bTYVKvtco1iBj1kyDpuWGDM=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1969:|AM5PR0801MB1969:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1969;20:RmKzkmP0NTVNhntOQ372UN5IQGnn5NIqnXYkN+JnAgHLd3GoyflJfN04JadHiXnT+4t/npWNJoOJrTPEs1etl9RqpvL6eC/WU/xFDZhFn3Xw9k2felNp6ckUpU3xld5QZj8aS8B/9Qlp5UK78w5n4Vfidn9jcyeWC6nv1RGhP/Wh6d01VMpN72bpaKx8LOLsxbDbCuTamfM0pQa7SeOwsQPrfslBZEHtQItau7sQvO2+gl/kERbm7wgm4m+WxYMA8ikdXU4M4eMQoPgSmbs49O7CsBS3kQXJFnNG1Oulllou8tb3Nd6SrclNSY4Ni7y/m+/Py7BQJbT5+OQqO3lQn2Ofl4zdcWD0LRQGcrw3/Z5mCaA+U0XeUsaZYAeFz7qju3rRHWZkyZ9pu0Ab258UQp6u8qFRA1+O1yCNk3EJLau1fQsOhXkoJPmN4hSQdGHVoqRBIDFo/lc7rgMfc7l9dRc65a6+o7L4OOJ0RXfGZM4qbkdCibRVWH3kvpMGi/ts;4:TY+72B9I5Yl8IsO/el0FDf7zpXPcBOIBGNPRavUiFAIey6NwHViexQ6jahlToiFvH1+mfP3+hggvi+LeFOD4NKjWKvJeD8poyAxMEKnsRJF8PiMoFN7HWOmQ3R5ma2fxcrYZC0Yi/u76A2knbMXIDjJ8myo0CqZRsc1o6NtBwH4I5qXVu4o6UWpbf84CI3E70Jrs7MeQo0MaRhG7rK+zXVmbwr0CdK4uG7ayl/ce68vnQ59r9jhW5v6lg8ELU3pVv0QX5tiLQ0ukNteK53mL/Q==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1969B1B96A79BF1C4A4FEBFDC9440@AM5PR0801MB1969.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1969;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1969;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(6246003)(97736004)(66066001)(11346002)(956004)(47776003)(446003)(476003)(26005)(86362001)(486006)(53936002)(9686003)(76176011)(68736007)(6506007)(2906002)(52116002)(7696005)(55016002)(478600001)(36756003)(54906003)(58126008)(16586007)(316002)(386003)(39060400002)(50466002)(3846002)(81156014)(81166006)(53416004)(6116002)(106356001)(105586002)(305945005)(7416002)(4326008)(8676002)(16526019)(229853002)(69596002)(5660300001)(1076002)(6916009)(33656002)(186003)(8936002)(7736002)(6666003)(25786009)(23726003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM5PR0801MB1969;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1969;23:rcrpBS34e+9TyVqt2XROwBoEdBTWy2SaK3LzyOi?=
 =?us-ascii?Q?dezXZWNAZsp+JfRw8mFYqDafbA9QV407q/MKTnC7v/pWls7MpfkQCD8GO6Na?=
 =?us-ascii?Q?l/s0Q+vXSf9m9mhRg/mEq07t815aEOE4hlbrEKUlSEuYlGs28Qy9TR00MVmm?=
 =?us-ascii?Q?WAex+pa18OpttbXN4h4eFm6NrZeXDnS2+7wdxnrvYpny0QN2O0nsS0fHj3oj?=
 =?us-ascii?Q?75/H1hRLNxuq6hDnOyN1u0htLZjw4skgiob5gf3REuwMoJuKTnvZNbfkwnaj?=
 =?us-ascii?Q?ys8hVFCcUX9rAVb3KS1JU8oLVcQxyyWFcJJ9fFrNV2nrGeNz+6tAvxvijUGZ?=
 =?us-ascii?Q?2YHKlEzWqHmvTjO4nUperom+xH/Zr8Lo/K+9WJLWzH+8bRPg1dmscsA3hdkl?=
 =?us-ascii?Q?5xvjLV1yXHUCgjyjAjmV8rlN0lNCvqC5HV5Eh0P305J8Fh0qXkFWksHzryJX?=
 =?us-ascii?Q?1aMvtwbNKHzh4b3M2wUGaA8juM/aoJUWSk2+wy1av+c6Z06f5U1y63R/Ep+f?=
 =?us-ascii?Q?zHz89o9Kgc61F6ZR/GHUx/X3JZ7GTNY6l6tBTTwG0GkGEYgbPI3sh0MmAkUC?=
 =?us-ascii?Q?DjbmphREDyoD5RsF2tEmXQZEazhvtdtKxNRIlrouToKpvCvfyQuEW2t89VKX?=
 =?us-ascii?Q?9LG1U62Ki/AbGa09UvqClBdvsDGKV8Z62VCO0H7xrZwk3qnxRrt4TeegpgbW?=
 =?us-ascii?Q?mphzZXPjvSWQYWq2u+fH6PAam6tcUIQ5ftApfITl+Zol28exXdOzLcekfXmd?=
 =?us-ascii?Q?6yPBSZZkK+epSvLXohAES5akocR94wlPODW9C+O3uRHnNDrWMpPq6BaCjRS8?=
 =?us-ascii?Q?VDV8mkJ/iGbE3sbfRZx+Hd8u+3mmcBVb8K3KFHl2sMemwAmcJWkS96EGcnAe?=
 =?us-ascii?Q?x4adrgjALtINO0lHHTme/NxlcYzhc99h6dqaJD2aAMk0z8LbRg9K+2U0V9Ry?=
 =?us-ascii?Q?JULPCYO64ssPs44VSu0uOcdgkhbQ9iPJakX3+3WoC9LvN2sYSbLZJVi/Nftu?=
 =?us-ascii?Q?wTFtH3AkUTbtG59SFu7OdLqOWp8QC6rMfyhPbG7vfYXXvgeqqfJ/atXVzgCT?=
 =?us-ascii?Q?cDwZNXEhSz2NPEu2G+ELuBl4F+dIl+YrP2sfr8piCONDSpLpXDuPLgvy4Da6?=
 =?us-ascii?Q?isHmfQ0duUCDFD+97vYiDqvnxvXzuDbdZOxVcXwMJoMMdV1USMlW9rt0FNko?=
 =?us-ascii?Q?/PusXnGxSysTUtOOQ8iS9TH4DuBvsanfd/+WGyWGNHgtHGbaM4crJ4+MBFOc?=
 =?us-ascii?Q?Mr/D+Q4DcZ9sd9C7V4OVR82nHHmqdQgLHfSc77rl9ZHIBhNrqFVqs2/kfqlL?=
 =?us-ascii?Q?Nl80MQUMU71YK9SDdzedMwUUhTO1HCXMZ/AxQrhBZPEEEPMEry+SgKbiwU75?=
 =?us-ascii?Q?FgfkK7FScP9Oo5jMglFJfBYlKwOykWurzhu5mYLkzkaHk6oYG?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1969;23:zQ1fopOBC5kUqRT1clKHH8JytWUm7Kz3OhY4/tDPiQ7pbkEI5mRRgKQtf5R786frMDvaQdnuPOWZ6DldIdKrqL8gLuJhIYUCuLdMdWekr6VzPHjrP1Gt7BGWBBsATDIZlDTaNV01MUa6YumJ0umZWw==;6:VvYkaCk3Xn5uv6tsW5c3/bMg0OLR0hjxtL/imnw7sfnrjm1ZR8WBYvu4Q7dFOu2uvc2ElYqCGjwqPAvY1j5S9XNuFoL1x7kWsuEDWDfBDCmaiQEv1szyS1nbk3HWOdRErYpFEJy6ni6Q1pHFGWXVIju3C5/mqml9iXcys7PhbSnKerzd+UoJC1JPcSPW2re4WmShi6doRnYcj6L2ZwOdMqBwXbrQ61GF5XHUme0UOObC4FIgDMwxX1oI04MufuKmvzCZnjeqENSQXqjpamciq+cZqqVuKZxcR7Ow3dpYCfYdGMuwHgwwNXcquiyZClBKsu0G1j86XIyIme3UYr9+2Oe+SI0xON209B7ZHk6h5ieQTcN54nYsoQ+UAjOQMMo+VQTDvGVbS737+nJMU3fLFoEdDOg2pN/q31CDffI93SjtW9lw0Pmp0D+jafZK/JYs+RHosHQrYf1c6dRLiuG9kG3CogLXH8M9J6CykhEdERSoRLgIlSVA6LiM/zqNcpot;5:4P9a8pUF2NB1HnxGwQQWzudnY4CMbttRQUbJwe1WekkKU/Q5IrWI5JMkyeNHZ2CJ84Ikx5CF8AKTaxIYrW/nxSS0/pedizZi87j3rjMZyPaGGWTY70/XodTnJapDmGoycFLyosHFtPGIZ0oUbX0opPgVv1zcMUyLaJ/MaeASP9Y=
X-Microsoft-Antispam-Message-Info: WGGjz244DXyH7/tCekvgQZ2hqkIw7duqrvsMAofQUIBUF78/AyIFlc67nldi1QHyjo6U+Qf9sfzOi/za046I64kLfGni5uIpeQ5xuhkGGBxxhmxy0U4v1xTdMWYQ3beiIc+pt8nKgN2NvNLoh/5q6ljwPdAcTdf3PIdBIP6MyNSk9SSCMCofJPWTChQ1hbemDBgQpqH12etiH2VkgXMh4QRZcbTGHKsX8/2B8pifeGI/jQvCVJegz9nyRcayNLJorb5ResP/8/850K1Y67I9dIHrx3qLKQG9ggW+WR0ir49Rpw4u08Q/RmaodAD8B8781RXPj5eheZIJHTc3TMbIiFahUTZkWKLt7+uqYVND6iNrLdmyj14vbHt57+moyIgVsD8stDJ05alc50jtDF8IIApPYzV4PSSI8h5WWUJ0smf2PLQqgTGxSLklLzMtgRqq5qHZyHWJmMcP3+ikpYDNMbEM4h0me6S/TSsaP/ea6vBHPKIISKYjPKma8hDQ6unqyh0oNt0/PuOniOzXo+Ln35mqo7aZj1Ojk2dfDh+RSgPPDdZOOtaORsSpdo9hgZZP0m2x8f2uxGYbi0kcbpjx9w==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1969;7:1m4IQ8qRY5aY4jIrAssIVOHrJ2wrPHdG9n1YjsPZ7NBazrOhiYbwf9acCMLer3+rLTiFvv7ZWRX6/cDI1irDodr06ifvt/a8jRmiixOSu2aCsx+8f7GkOj1dJMjXk8Kkzn818SKXVYeN07Gg5u4vWAjXlEUQeEAiMaydiKjgMmGrnvlFQBXSv4rj8+3tEOjMZGd0OSsvVdgqz9JuZoCmgKKizltt7CK1PygaAr+mIEEPK+PBKgopXvkjseeWFXIY;20:yWNHZfsRi3Mpgc8Sm8bB7yGqc6XdognTLtW6Iodh3pOJEHr0B1r9tv31EeMT0JMMLLUprBFVmq1tvgiqtGunMxpD2CBGAhcUocdwM2VYsO8b8EvMThqlA2/gMXf1810qHn3tBBNki65CU3YLeo8/OKWJ0ph0xbwegytM/EUlFnc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 18:30:40.0689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c981fbf-6c25-4379-8e0f-08d5e5ca1353
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:42:04PM +0200, Vitaly Kuznetsov wrote:
> VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
> use it instead of traversing full vCPU list every time.
> 
> To support the change split off get_vcpu_idx_by_vpidx() from
> get_vcpu_by_vpidx().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 78 ++++++++++++++++++++-------------------------------
>  1 file changed, 31 insertions(+), 47 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
