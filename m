Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE65C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D7A20864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cBy2Q+Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D7A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeGIIhq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:46 -0400
Received: from mail-eopbgr70119.outbound.protection.outlook.com ([40.107.7.119]:22816
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752914AbeGIIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9faoK2o1DQJxnXMAB+Em1ABir7fxoYqm2LDho4cAax0=;
 b=cBy2Q+UyKI90JCs/5v44lzXF1smHH0gLJwjbZ7BMuX9NnWD5TgOwZjYusPtP0/a8xNo8564/VOPMcMyBvu0tQDETCg+/+DI+vTtSaBXXPevvpL5rPGTUtPiYZwbkpRLbqM4vZkLXMem0UuMXkvEKOOlfrGsvEu+Wlh/2fAzARlA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 08:37:37 +0000
Subject: [PATCH v9 02/17] mm: Introduce CONFIG_MEMCG_KMEM as combination of
 CONFIG_MEMCG && !CONFIG_SLOB
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:37:34 +0300
Message-ID: <153112545492.4097.5538595404798621309.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::20) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da1d2d31-aede-40b8-7913-08d5e5773aa6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:XzAS1sbz9Jaexd2k5elLxy7XPJNp991AzOSC6/5x5tAe3WIfFY6L5dy40F2XdDH6sSS54ymc9S0r0x8qkvlYgub0LX2I/Hvcfp64/MuuPtj5GrBzP4KoQ6Cz1W3KK7tQHQ+qR54Hv0axhEbGlHkThaWvWRI69ssP+6lWztLwc3U6zSB+O6Z+Erz0C2TIUKKeaBvEphd0BOxOArD51R47NpHjUbiXeiE5TAABiVfnKHkQKyabz3UTipfgnCOBMSBF;25:CuR8Z2W4LwXO5I5nSvaTBgPOjF9i4raNUlBzbWHSHE8PF0QvTlDErPpubkHxIkJJj8WWDJKk3NeFZSdbBEeYNeyZfHsBkjq3bg19x7XDttFjsxHVyPPQrNocn0X5QO4MzmXXP1u7rymtMab96iQI0gND9Mp00SpaKlZJoaGPsEvJi/h5Avb2aRhB8ck9qlPx5HfbJh6WbYPmG7PROq/wwiVXAp3h/juBex15NekVNM0EZIu8yrjbrlu7k8jY4s2TMJWDL2M8mO2txt91RQN2hMDpU51KbUJ/h0tCNd7YeO6Qd+DTZ3PUArMA5C+7ShPVg260MQy7P2Et7Z8Bg316sg==;31:cbdCg0lI3rbScv+60TZ2jQNjhYlpSZ7Gf7PCAeVuS+bxzrVRBmsmP5Vbswi35oOzHTREyNaW3HWmBIJ1NuZYUHmttqo6QOZdzy80O+fGPJtTqtz09CLEYPltkz93ofAS1SnzAYxSQ30glAcqUKsl/n5oI1kWjO8mUBKRH3ONIBzCHE8sSLdn07Ipo4Lt9oiNtr7pw+8lVB063mQoqG8Pvku7xvvM23NDLn/ecwYnfI4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:KhIHlARKMkC8/ugsC6T4PLgERSIHx2fut84Z6czyk5NgNQDYKzGk8p6JLPbDPluhjXj9gu+nhK2EHWmOxDM/rVdXfNxcClHV1GkWmGrRLXUi7drLxRiurpozThIosjVnK+ZNga7pv/d+RFyXeaWf1QC+fkFdTVEi9XNN7ah0tS+uWJkCYMg/940E4gL0VRKueN0ZUDKU1cq6lDOahdSAApUdp62h8wbjxy0TaHlvVhS2N90Q3JGN1Le6yWWSVBhPnkagn81q43yto5v4vFP+B1fIiabRfu++AXPVh8EZPjZ7MMCEB80Vv5OttFiAW7yVen8hSApyMvkCD+zqMMepsv3/yUCUB05O3TzfsBDZ+l0bkxAhgd9MUWpKGSpn39p+ZUG6OBigGiKPsGJx0lsv5Z/+YpqTDjX8GYTqJsZc7NmZszUO6PeAe+aS/lNs2kMoxGf1nomE1r7m3LSPY4zxFiwSY54NGQVLlTQiwwE5np0jacwMfzkJDUMFi0e77QaD;4:MbVYF51SEmGpOweJv2HXjizFOYGXn77Zkl5EUdeW6V+qu6va0iYCvJDwa+SClYxO3YeN72hk91SlEEWGesa/7NoroSwMkWo6zCO23ADGeYeO7ub/X5KdIF2c70TPf8j2STSNdQwEqQ+5J8+onot8X2UuNCz+s078ZpsqpbeVkbEWnerjfH1u/evtDVz1bnDD4WsgL6sB8mVL//IdqfHOdyLWgWF9J5gNjiFOiTpn8bn7jJ/gjvFnZdSqm+EDo2eWl2rUTZxkwJj/5FcJamxUbIu9oNprA8y3qvIIJfIlsQJUNS+xgKQKm7QweV/wJS2+QgEYBf7UDeFS1cvttJGHP82p7w4VTMjKHcLVP9fVnqnytoGNna09VL/UJBR0YirA3ZOGQTj+LJn5PvVFg7hlJbsiNnHLrZ6z9mYYC+JZqlc=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344C16BAB5F380619721622CD440@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(136003)(346002)(39840400004)(376002)(189003)(199004)(2486003)(7416002)(5660300001)(52116002)(7696005)(106356001)(105586002)(7736002)(305945005)(2906002)(23676004)(68736007)(25786009)(86362001)(14444005)(575784001)(58126008)(16526019)(186003)(97736004)(53936002)(6666003)(486006)(50466002)(39060400002)(386003)(6506007)(476003)(61506002)(26005)(11346002)(76176011)(956004)(33896004)(446003)(47776003)(66066001)(316002)(103116003)(9686003)(55016002)(230700001)(8936002)(81166006)(8676002)(81156014)(478600001)(3846002)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6TXFMOFVTSjd0bzBBZ1lBdzY3QTRKS1BM?=
 =?utf-8?B?NEtHblpBQnkzQUdWaHFTRzdYd29OSWo1dFdoWUVCVmJ2eW5GZjRvcVlMeDdq?=
 =?utf-8?B?cG8rMFlEV0VFeDZ1Nk1Eck5XeHVHUWZqTlBvbldSOWI1elNFVCtOY3lUZFdR?=
 =?utf-8?B?VFJlTHhYNFB1VjVvWVhvYThVNG9YWmVqemFiamFBWWZmdFl4L3BlVGZkd3Vp?=
 =?utf-8?B?aTR5dWk1a25aVHJmdENSK3Vqb28zS0p2NkR3dlM2K1FmTXNHb1dLT3F1THBi?=
 =?utf-8?B?L05hWTVZU0ZQZzVqNDNGTk5GK1JqcVJGTWp1NTFHOWMyRHNPWXk2cVNNZ3BD?=
 =?utf-8?B?YUtPWXhiNTBva3pYZEtTdkd2MHlJVUtiV1YvN0FIMmY1WnJib0NTa2MyVVZY?=
 =?utf-8?B?MUFsZ0QxVnNjMmlCQTRPZXlQcEI3RjFwMnMzU3NsTVNmZmRkbC94OXJDNGtr?=
 =?utf-8?B?OFpXbk9hUWhoOHhsOHphZzNpKzJCVm9IeWIvVTdPN2c1c1cyZ1VHSU5zZXMv?=
 =?utf-8?B?cTZ3RFhHMnhCMzBtU1Y4Q1dlWk1qc09kem9Nb0ZrR01jN21BMmZQaWtiMnZL?=
 =?utf-8?B?K1lJeWJuWW9XaUd5ZVB5WFZ5L2dub1IxaXNzNENsSzhlVGt1MU1tYXVpaTVt?=
 =?utf-8?B?TTlhSXB3akpzRjRIRUZDT1g3d0VsRlFWN0VIZ2FuNEU3V0dGenpmYU9XT1RE?=
 =?utf-8?B?c01rMmtXLzZzVnIvZHkzQzBzbkEvdFpoZjh0Vkdzd0tlUVFVYWNXZFRsK3pj?=
 =?utf-8?B?NWxMNGNTR3ljN1lQWFJzTlo2N0VjbUNJK0s3VjBCdTVvN1hBREhNVzhXaWd6?=
 =?utf-8?B?WHI2WTlyNTNBdnJVZEpNQ1p6Z2s3ZWl4bDN1NkQ5MElFamorV2lTVTJFREgx?=
 =?utf-8?B?U1FjeXk0OGJ2VTdwN2FseHptckJzTlhLQkhHVG9XMzN6T2JIRmhaWEltYXdE?=
 =?utf-8?B?bS82VEFaRzhTZXFXekZSbEF6amZGRXRjQVdIb21FUW82RXIyeEdoOXJIU29v?=
 =?utf-8?B?cmt4eTB4VG9PajZoWFVhaWhYaWlrZVowUjFiRW1kRWFCUFpyYXJjNmxSYkha?=
 =?utf-8?B?YjRJYUtQVWh5SVFadFh3V256Y09XUkYyaU5GaW1TdDhqcENSbnlBWEtYaXpt?=
 =?utf-8?B?QXlRS1VSSUdzTEwxRjY4MllsVlJ6TE9QaDFXSExrUkNUVkMya3NUR211YWlX?=
 =?utf-8?B?dE1YekkvZGJseDZHNzZsMnNqanNrbkxPbVlIeFVQbmgydlNXWkdHTERNemtt?=
 =?utf-8?B?bmE1anpETExMak5GWDBJeXNoLzE5VmVmVittOUdwalJsWlF5RXp1c2RBMlFh?=
 =?utf-8?B?QTYwZ2hwNE8wTXdiU2NLSFljNjF2eURtZTZRVm1sRWFQdGdwdmVaOW1ib0tV?=
 =?utf-8?B?WnZ3TXZlZzJjb1dYYjN3eERMVEdkNnZ4TnUwajlWTlk0cFNmSWVFNCtGVXhk?=
 =?utf-8?B?Vld2V1FocEdXWFN5ajhPbm9OMkV5S3k2WkpJU2ZLR2dvRU15aFR3Wk85TUoz?=
 =?utf-8?B?YUJ4V3ZIeGFNMVNNUVJ0N2xGc1g1aXp1U3VBdHBmYy81YTZFc1ZuMmpmQUxT?=
 =?utf-8?B?MFJWRkdVYTFFQzFJbVVsZFROaW1jZzdBbWR6YzY3RHF1M0ozdERkeWN2S1dr?=
 =?utf-8?B?TTVvVlEwSER6M3VkVmhFUy9lcFdOb1M5VkI3aW5wNEZTcE9naGZzaVZtaTVj?=
 =?utf-8?B?WWdsWG81VFpEMldLUjlYeUNZRUl3aFB5TmpnRnF5UElxV055OUxlUnRXSVYx?=
 =?utf-8?Q?YMPpZxs9LNVP/0eVdYwQECANoPVfDS59blM8uTQ=3D?=
X-Microsoft-Antispam-Message-Info: tZUIyb8VCIFEynRDiR6zQCKm1RhrdlG3DLyJ6iVFV5BP3aonBccXqIaD3MKcq0L7TBZaM8tTH4t1d/mRhEM9wX66t73tHL+NJwe7esmQMUmRIzAbyVbrwrHXqryBIMbouh7rRQKls1fsJmmgS9MLipn4kptizJb9WOZvhgiLzMlhFEBrJ2bWgsGevLCAij+G3YlcNQwHFveQTVcHMubbaULUUSDXyksIRx1nvt+aWwunMRB0bg4YlLj4rlSOaETNfZuyjiuPwOycZh+1x3iYyhQzXmuVhOYb5O/xEQOxOGxUaeats2AVibyS+RD0FXtW8/q3uS2kkRTl3CaTgduZKTbNEJJEKSI/MZSMP9jePY0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:NkAUCyrZl9aYEtvjJz0Wz2eOC0cHmkSou+/w5/utueqsp3m5r+Yxk7rikt1i2q5DPadOJXP1/YoXVL0HnuFWTu9+GcbfTi/JEb9F89rq1cMYrqOWXRwgDf09Dx6WDZxr7y3cXWGwslO5j3qVkYLQImaYHySFoIB1uZjGFYZz/ufujHK/24BWIUNUh15L9zaG7kJQzMdmfh0AJANTLy//XZ0hP9bbNL0X3s746FEE96wABntTsXGPFIpAosu9tLaXB37Et1C88ANwPAgVFJrVE9KHAd9gXlTHRHuqYxfgBxlFtn0ECLP4SOhk4YO+XlnUzoCkgwMexSub1RQH2MzeoYVBcHxPQmeVesglxF+MiU0e6icSg7eBX+egxgyl2ufIjObT0z3S5aIrxraLmSGNk+wtxJoSjeSq0kIBS6quc1rToTPngKoRhOJj2IbG3DuAQPPMnhCTUikoZKajmid6yg==;5:MEknX15qQZnDU3S7DRa04/mSVEmetvaC3Rm7RjvqmdvER+XoGBhkQ4UVi90eDQMLEu8n+92BVnyH2KxUoWul5Nti09e+qWVYKDZgIunKnrubf+6ZJNDxbCFqjngdpDRdNhfRl89ArFt/sEuOAhxflX4W656K4NW/h1JKXfmxB/4=;24:Ee5ZPXoMGIv1xdgo13NBCKrzVwHWrKIZutimX2daDIz/+dfgb9QBMEQ3m+YuX39uiko0JFjEIfuJE3Q3aIdCRJCENzYTpEBgajMOanKuR1g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:uaNif8lr4bs7xZheAfMHlYiI4ZQDoKP723j/ZVluEr0jnwEdpB2ZwJBsSxKnUZQhTao5zHqS+cwYzy+9ACAfqap0FmHpQwBIA+9nSsIs/xC9+s/Xik7Ml7pQrB0K+0siNzT40CGs0SVAOXZweZlLroUXHwssFuc4jvfFx338FTu9GRHQX4D6va4D1bgJX48vS7/F8WFYpLxy0NJFAN5RCo3UbFSymKov93XHO80SvFPUi13bcFLPuXRULSycEwkW;20:IR3SD7xX3sVERh1SbIUAEkMNrTELuRGJylEz43DJCsdX5mdK1P+FkaBochZBy9LzS6kfPphtZIcUBHtyqTlrgJGgrUkEt/b5YnB05M95gyD+5XtQH4bjppJSv5jC7MD3MDgVvNp+YvkIO8Ok9W01PdUuAke/SomHWSb4KjptZ4Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:37:37.3466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1d2d31-aede-40b8-7913-08d5e5773aa6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new config option, which is used
to replace repeating CONFIG_MEMCG && !CONFIG_SLOB pattern.
Next patches add a little more memcg+kmem related code,
so let's keep the defines more clearly.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
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
index 5a69bb4026f6..8b35b6903c85 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -271,7 +271,7 @@ struct mem_cgroup {
 	bool			tcpmem_active;
 	int			tcpmem_pressure;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
@@ -1194,7 +1194,7 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1247,6 +1247,6 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f809b7aeb11c..c0fbeefecb3a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -723,7 +723,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	unsigned			memcg_kmem_skip_account:1;
 #endif
 #endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 14e3fe4bd6a1..ed9cbddeb4a6 100644
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
index 041f3a022122..524d6d02895a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -678,6 +678,11 @@ config MEMCG_SWAP_ENABLED
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
index b65e0b9b0646..c5217d84c6e1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -12,7 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static LIST_HEAD(list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
@@ -103,7 +103,7 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 {
 	return &nlru->lru;
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
@@ -284,7 +284,7 @@ static void init_one_lru(struct list_lru_one *l)
 	l->nr_items = 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 					  int begin, int end)
 {
@@ -543,7 +543,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f59ded209975..09517a0da93a 100644
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
@@ -2164,7 +2164,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 		unlock_page_lru(page, isolated);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2429,7 +2429,7 @@ void memcg_kmem_uncharge(struct page *page, int order)
 
 	css_put_many(&memcg->css, nr_pages);
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
@@ -2824,7 +2824,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	int memcg_id;
@@ -2924,7 +2924,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
 				 unsigned long max)
@@ -4228,7 +4228,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -6055,7 +6055,7 @@ static int __init mem_cgroup_init(void)
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
index 2296caf87bfb..fea3376f9816 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -127,7 +127,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 	return i;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
 
@@ -256,7 +256,7 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
 static inline void memcg_unlink_cache(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /*
  * Figure out what the alignment of the objects will be given a set of
@@ -584,7 +584,7 @@ static int shutdown_cache(struct kmem_cache *s)
 	return 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * memcg_create_kmem_cache - Create a cache for a memory cgroup.
  * @memcg: The memory cgroup the new cache is for.
@@ -861,7 +861,7 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 static inline void flush_memcg_workqueue(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
 {

