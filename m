Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3D520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L1lXoVO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3D520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755298AbeFRJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:45:22 -0400
Received: from mail-db5eur01on0114.outbound.protection.outlook.com ([104.47.2.114]:29682
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755091AbeFRJpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1AS0rDHhCxT62oyo0eTh+vZjglhq92cQLpt3RuGN3A=;
 b=L1lXoVO/6hGlDtn2pJoMnphwM4XXTqGUpGGW1R3R2RkmR3IHi5q+Uxb+0ucmjH+UOkel8IS10QkFjE8ocBlyb0gXq58AmL14YPbFXAXyJZTNW8VUxNcdtXfUOrpt8tFrHJFToZvZKFJ5oq1XIN8KKIZKWH/B495acjxLwFTSeS0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Mon, 18 Jun
 2018 09:45:12 +0000
Subject: [PATCH v7 REBASED 02/17] mm: Introduce CONFIG_MEMCG_KMEM as
 combination of CONFIG_MEMCG && !CONFIG_SLOB
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:45:09 +0300
Message-ID: <152931510922.28457.18115445564323612603.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0009.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::19) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6684dcb-98df-4f79-36bd-08d5d500311b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:XP7vo6/GMiud+Ucpb6TmMnYyxU9zQhfdEJFGcl0KY7uL7o95uQv/2r+YGGG8MmFCd6ZDjhB4j900bd6eESv4WpR5sGSJr1g/uQORGZ5qRJPJrvQzwO38TL/GtDBncVEebh2E1rb+22UC00ZwLcvvmTYzwkoaHLXgww+X3w150nldGmA1ftnZABcOfqDOD9IK7Kt6Yr70rYhMfsA+pcGdiKfDLC7jwdtSxgAaOTdLgEw7DHxMgPrugbEe6CnERz6F;25:OwH1m7cCFukL01unCVK2/t0biDkrU2I6WWPwqnyTqv9VsiWK4AU8M0rcfzsk6a7CQNi8GGZmC0p7WeSFmmPO8bDEwRDbe+B/mSotMFYpZJk2wr5vSiBP2mIYWHk1AkCShTuZVWfYQQrJHErnND9zS0rg8VaKHdUtMkcZ55171DXoX8T2eaVIGZf9hMeaVRKo0TRUdsaAR1oiinBkPWMxHFcMgbehuHWlEU4+pyU4U8WI+gGLd1pgQGIfG65Cd6oJ+EK4gQcFwNWWSg/gfu/T//b1WnUJ5t3g8gPX0kHIm4kBPXsLR1828hozQ38MJcRmcWnLucpBaqCuztA1pgCgnA==;31:07Ks5WaWu/bhbIf88FJ20duOY0b+zoT6am7DO7rDLOPV4oY+rvygTpTsASy/LS4YmeO1fOi+dKmn0rdcQ80K2NhyXbL9J1UOVUxsEAx5irdwydVXesUr5DA8vswJbZkbcOM4Io7x4U2E/GVFMajCXVcUXr2Lss23TXh6cBHPDWN/ofJMVJ6jD1PeRrsQ6M8C2PSH7SiocH9KXjBhPaOcy9wrqTnMEZskP1L66gowcFA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:5+Doo6XJuSBLYx6sQ3orr/PV7ZkS+E6tf0teFjv+cLOrTLKqmM6l/GfxqxlnfuySq3lTM75KOP0iPjcyvg4iW3mSrQ2BiNO9gOb9ZEZGjib2iae0i4bu0G0nPia0RXF9ehvju3Ab3fNtVcIJYVfMWDkcGtaUecBF/CQuhQsXDTzpXDxsvrHfQ/8Dh1QzhMlzX9k8Bu+mVUcTan1LMv7nP/2Uo+bZciijopMy08QPtbEc0BL55e5LZNHeZu/pJiUxh3ZZPhSz3b9aroLrVeCYrXQN43w2JylwBVPhwUzrYNoqWDmlAOJD9GQHpw9vfCbBUel5mptepSwH3Bhzmsd2XoSI7beB+Ek21Jnbzh87XjGhIR28aYgoESzV6TfBdVf4bnH9itDxmQUee64voblJ88yPD9xKJZXsgML0cY+f90VVhE7fY8B5xw/xO0HnjwVfRJI5WPxY/Geq8jzVLkHRU9QB64xgNUjZ+J7D99XSZ89A0C9gdLNAQUlrB+WjZc+3;4:1wBH1fs4WWZFnfdwQKyZsbYQpf2CJbbApPQ9woX2HlrOpojHB1adtluDfq25FbofTPDdcglJOZNot7MsoetN3kMMXCuAs4q8V69i/QOIgBg8H9EHnRWM62C2CjV3gqEudlwHJwZe4RPORMuOHWrQ7h+arXBUFe6kyLn9b7AW5O/cRZrBwJlw/l19+ZM4utGQK68Dj3dq6hWB4MIlX5MIZZgQSwuQFk1b6NtJpD4XL7Px6SnbTDLKzOylTQx8Y9J9+d/N878IEXFgiRtpLoYWv6ca3fyJcBoh3ZrCYXKrOLJFEB1Btq8u8PRugxIklQA5+nBm7MROFlFQUGGQAwgjw1ZNS+nkDlpldsJtXqG/UFbq2J4OSI39Au6UQdmnGLfolKbNNX8FD+davrLY+70el1jCUnJotiNI1fueXlMFo18=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329BCEB4EA691D2CA23C676CD710@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(39380400002)(346002)(396003)(39840400004)(189003)(199004)(9686003)(26005)(52116002)(186003)(478600001)(6116002)(59450400001)(3846002)(53936002)(97736004)(956004)(11346002)(476003)(6506007)(386003)(103116003)(7696005)(76176011)(2486003)(23676004)(575784001)(16526019)(486006)(55016002)(86362001)(81156014)(8676002)(8936002)(81166006)(446003)(50466002)(25786009)(39060400002)(68736007)(58126008)(316002)(105586002)(106356001)(61506002)(6666003)(6636002)(55236004)(7416002)(33896004)(66066001)(5660300001)(230700001)(47776003)(305945005)(2906002)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6SUc1WlFTdEVDaVR3UmpObEJiVGxMakww?=
 =?utf-8?B?N3ZCN0dKbTVMY0V4SDRoa2h2WWV1VVhMTHZES3FBK0RxY1AyYVJmdENZUjhM?=
 =?utf-8?B?K3BzMWZOOFlhaWZ5SCtuL0JJbzZld0haUExKbEJkMEM3NUoyWTNoTmtzRm4z?=
 =?utf-8?B?b0oybDcveFFLTmlETUFCWElRMXl5ZFIzbktqTHROV3hyajBrZW5mWHJHZk5X?=
 =?utf-8?B?ZGRPdjEyalZFV1I2Z01NOTJUZXlJc1VSVnBPYk52LzFHeWxyV3pwR1paLzBy?=
 =?utf-8?B?M1Y4c0duT3BTQUJGL1dnWlQvVUQrMFh0WnVpVjNaU3cxK0RTekF2WktxVGgy?=
 =?utf-8?B?RGx0SVlpd3FUYjllUUlVbDBKZVlZWVB5NHNOZFB5djYvWm5GbzFINDF5SzZk?=
 =?utf-8?B?RzdnSWJ0aE1JWWtrVUFTVXpjOHhqb0lHZG91RjNQZzZFa0hiUFVXaVVVUnQ1?=
 =?utf-8?B?TVVXNlo0NmQwZTh5MnN6VVRMTlowM1FVTGRCT09kSzgzblZQR25nSElsUk1l?=
 =?utf-8?B?bUF5STM2dUNXaEo3eForWjdQV3BibVlyaXNZNS9YSnFYQ0owUGNoNFRuS1VW?=
 =?utf-8?B?QmFKeTA3N1poVnR5S0RaSkU4MkNjakNNNUlQU3YyRUhiWGhyRFB3QWRCNnBT?=
 =?utf-8?B?dXVvWWxOK3J5TGFLZjVLWXhkZlpIYlk1QkRkbmJKNldBYllpdFZYU2ZTSHhq?=
 =?utf-8?B?OC9lMVQvaVd6MXUyV2JPcUt2eHg3UHU4RW5HMDA4QXpKd0tJQUNmL1U5YitT?=
 =?utf-8?B?cG1TcEVUQW9uQnhrbmJmTDVVaEE1L3dFUDdDRFJMN3d3Vzh1bENhcWw3L0s0?=
 =?utf-8?B?dGdoREJKS2FYbE9XUlF1cXkrRy8rU1RtTThzckVrOVZidUp4VUlNcXdZdzgz?=
 =?utf-8?B?Y0dUZGkwb0VrVlMwKzk0OXNwY3BEK0pWSXVWclBFM0p1eTgwVzlQZ3V0c3NY?=
 =?utf-8?B?RTlJd1NBZThad2RwbWVaYWJtVmpWaFVvUzEyd3B4Wit2aWJFWXZvOUtxa1BV?=
 =?utf-8?B?dndYNzZNSDEvaEptT3oyZVE0d1NoZHhGV2s3R2JuT3pVNkhqb1RmWjdpbjAx?=
 =?utf-8?B?eEtleUhwb21DazNtT05RNDJabExZekd4d1F1S2pwRXlSZFlTZWVFTEpnRzFZ?=
 =?utf-8?B?L2tVVFlaY2xMUlgrbG9iREo3Z29IdDQ1ZExUQ2FuSDFQdUFEU0ZBZGdRcW1s?=
 =?utf-8?B?YnVQY1JFejJlQTNXcDVmWG1ObzM0NytzZ3ZSd2ZFdndVbjVYQXdsZ1VUR3ox?=
 =?utf-8?B?T2JyQmRpRnRtS2hwU2tzOTZ0Y2lSZnVZclRKUThDZlRCQjdPT3dBN1lFNmZ4?=
 =?utf-8?B?YmI3dW5WMzYxTDFtejljSkljYzhFUG5vbFJidXM1M1dwUFkrWmlCVlRlWU5w?=
 =?utf-8?B?N1paZnFHeG93S29sTTlQTDlRMVpHc2FtVFp3bVhWbDhRSWFLM00xMmdueFdI?=
 =?utf-8?B?Q2lNc1BLMzNYdDJsdlJKS2dzMmNoSUx5ZU0reFVZcVJZWWJ2aElRaWJteUJW?=
 =?utf-8?B?MVQ3MXd3akhPc3J5elJSRUpnZUtOalpRZXhiVFg5MEJ4VDBhazNRWkJvYVNp?=
 =?utf-8?B?cnF4a0F6YkRFNy9XaXdvd2xNaU8rZm1yOGNxUmNnbHJNMTVoVkhjVWNiTzEx?=
 =?utf-8?B?aTdPS3ZwNDRJWmpEQitoVDRiWlVla1VxbVZMWVVMTEJGTXZ3dUVhb0NhN2Zj?=
 =?utf-8?B?NGpSazZuL1BRRzRuOWJVdjBEclMxZ1hZZ1dUOXRvcnorcTE0eTRWaHRjNHpF?=
 =?utf-8?B?clkwZy9Helo2aHhzcCs4aWRQcS8xbWVHR0NpdDZGNVppdFF5alZ6R3N1a1hB?=
 =?utf-8?B?NTFkanZ0cHhwS01WdTJXYjdFTFRIZzN3WU92bGJ4d2tWTHMyM2hBdHA2L0NZ?=
 =?utf-8?Q?ly6e4WHGPSP6w=3D?=
X-Microsoft-Antispam-Message-Info: ea91DHZ0zd4YDqH3YXUlx6+f7LDFybTnSjrUsMl6/pjJ4NsP7yqreg9sbX23oelLPtp/TAi67VRh/L2Pmz1t/UGnQ6Wef4pDGVtavv9XGoDappHZMzhzqt1eTLvlAJSC+ZeDIrK1u/q7Op+d2AjbOqZtPraWSJdKIyAWGGu5dku96uvAxJjPwIlH1sR4Msgn
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:KEG8PFIDr313rchyyvZtg9OGVX2VJb+d2g1Gc/ep1++mY4kJSSDCpIT02B2raXS2JEFyY1yyuZsU83jsaDq0t5ucv7iTo2+TZpkj1pfzOses/hiBCX+UkwDDwgYfsR9Fz5PxuOMfnaqbo/j6I7mEpmX0tnyHIItPBB+P1eL8Owlqg6CWmc5mulNfPGeZzaJ3xNruUnQj0+30q6BFZrxuKKQGpNTHJJJfIoQolDePzKLeXOHs+hX1b+jrfkMCxuhn3quLC5if8ju9kWf9XYpjICqdkHoafZhwlbtsmfACnHuJYr1eyjv/m3deUC4KEFhZG8BEjOFWS0L72A/ecKccCD10QaDV8Y1kBxiz+VyO26wCSIKnY11Xo55tDLIJlfStMi9JyO5sg07g/O7ECxjZqJjwBml836phxPstBh7vtFVWxdIAMhPtgH/pAljk/s+P0wEIDzGhDlA7kBNplhwfSg==;5:7DgIdAXIONz8UlIcsDsPm2zUJBmuw3uVxxv3a63vkIe4a6jZQmBYL75XeFai9MunnBPEnojpFs2P9DxxWgqncJ5kHXn5ha564YGpPhHBD75BIYix0J3EfXHQSx72MJGufjcy0PgpFG3aB+lEYcU5MIqYMtCdFmwIMbO4DJZq0Pk=;24:4K8XXBRPvnhhZTj03tDi8D3B5I7yokX7F3a8csVp8oeG+RNFtcBFN7kRMwssqVK3GUEdJlmzQfURKV3TR1bTpyFftfYUMtrAEz32sEvRZLU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:pyuyWkwbQqTgcZZ65td7JxqWTzc2XRSk1VAkbt/4IrhCiSHt6XhZiBzJDx6IrFqOA/95mu77CY/+AyAfS2K+HD7Wc4UFuW6566omWqdNcUQl79vnAvokDohjpFpERQ5p1XsO+sttHgYVqAUrrdXxSJt2nKwj9mzYistsQ5+JJIINoVLXBkeC9Ldk4MzhHE8YTLiEQJV9ScMkf2rFXQ9z6KRNQRm+vYar7pHiaqAeXpp5vH84qgD8SzAiSfD5D44R;20:TMekNwXVsgfKiST06HU/ChdLZGIfST4tWdYh1DMGKrDHJoo5p8UIsDDUJHg97d0jsRL7MkHhYL8l6YL7oxUsZreY2G0SHgQSaQFKqGlMnRJM2gh3DDyx45RiEc7Hzv8H+HnONgiTMrEJvtoF2do0aC3+2oTGWdzqx3odW1PjOkY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:45:12.8314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6684dcb-98df-4f79-36bd-08d5d500311b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
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
index 6c6fb116e925..d9e38a7c0c05 100644
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
index 87bf02d93a27..15d79ef7e460 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -723,7 +723,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			memcg_may_oom:1;
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
index 5a52f07259a2..d9025be3063d 100644
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
index 1e3e2f3a2a64..7621084d5a7d 100644
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
@@ -290,7 +290,7 @@ static void init_one_lru(struct list_lru_one *l)
 	l->nr_items = 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 					  int begin, int end)
 {
@@ -549,7 +549,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5ef320a..fca9326fba99 100644
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
@@ -2119,7 +2119,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 		unlock_page_lru(page, isolated);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2384,7 +2384,7 @@ void memcg_kmem_uncharge(struct page *page, int order)
 
 	css_put_many(&memcg->css, nr_pages);
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
@@ -2779,7 +2779,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	int memcg_id;
@@ -2879,7 +2879,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
 				 unsigned long max)
@@ -4176,7 +4176,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -6003,7 +6003,7 @@ static int __init mem_cgroup_init(void)
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
index 890b1f04a03a..06f721ab90d3 100644
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
@@ -580,7 +580,7 @@ static int shutdown_cache(struct kmem_cache *s)
 	return 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * memcg_create_kmem_cache - Create a cache for a memory cgroup.
  * @memcg: The memory cgroup the new cache is for.
@@ -857,7 +857,7 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 static inline void flush_memcg_workqueue(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
 {

