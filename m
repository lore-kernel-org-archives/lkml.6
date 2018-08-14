Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C63C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0192083D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d5dMlNp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0192083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbeHNMEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:04:52 -0400
Received: from mail-eopbgr50119.outbound.protection.outlook.com ([40.107.5.119]:32576
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbeHNMEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5TIbTueCe7RhGzKCFbSLeYUkznaUJKDMTMVjsiszWw=;
 b=d5dMlNp6s2tldAKXgfeavFzJx/u80F6t7OLTQB7nDoK+JpH1LNvQ81Djz3wsVFYWprBe9RQl9hD7ZNVqVwqhszoNwvKjoH59JJHP5YF2z+rWhcCddyAMgrngvwU4jVjuJv/tOxWtbseFCmer0pLDkGuh5e++qF7q1iwtXhCwQ7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM0PR08MB3249.eurprd08.prod.outlook.com (2603:10a6:208:5e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Tue, 14 Aug 2018 09:18:26 +0000
Subject: Re: [PATCH] arm64: lib: use c string functions for KASAN support
To:     Kyeongdon Kim <kyeongdon.kim@lge.com>, catalin.marinas@arm.com,
        glider@google.com, dvyukov@google.com
Cc:     will.deacon@arm.com, Jason@zx2c4.com, gregkh@linuxfoundation.org,
        mingo@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ab25474a-7a49-f70b-3da6-188a71eddc34@virtuozzo.com>
Date:   Tue, 14 Aug 2018 12:18:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To AM0PR08MB3249.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2075d4-ec0d-418a-775f-08d601c6e51c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3249;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;3:BLSwe5EGGpnzvsVWzBcjgNtawRo0+V7GQDPeqz556fTqt45ELBOnODSkhmmmwxid6UamQy/zfK4IrguKWq+C+Bn2SC27G97gNJ62d7eUeiSR/6r/Kp2HlscH0BzmEBCobe8RNYN25+XSrmkliXQcprv38iwW5d9EZ+ns6oSxHsJ7hnxF+BsbrFknmfWxeljooOSXPgqi0KzGxv91vkcJ5v5/lrebw5LbdZNEpVuwOuRHTz9WUdb9P/KcsX/Wc0wW;25:IJ/o6A3azeV3gfmzMAnQENiJaZIKmsUQ03oF6w0UQWe0cvUNqW2RoHnVdtTxqsVZk/Ei23MOkgPBSuMTMGLGXRuo9kwYRmSHrPiFCvuv2pQn8Ipu+Ce2QEyN1I20Jzynl+lt6rOOjkHh6m+BFK8j1C7PG3uEM/sdz2YFXAH0E62Hknp7HpzPEQjwV38ujRnCO7U0c3UH3EYc00hJcF+xJSpfHF2SuQd8n/1tqrCrm839sHWLWQOygxqTuMStKsMrdTxvXuPVn8d4X5pk9+QgSknCy3AoFovJTkgdvdVF7UwgxT6j+/25LA9P3D+4lCaSxERlUMe19KAoQ9X1kZ5VJg==;31:Q6qbX9gDNV8HSXC0BvVNwXCS/C50m/Y8+FD6N0Th8nyXyJmwdbpMVv3ajt8SNb1SDEy6mQBTBDkR1rbCdQxMtji5M4V+XHReAUYcQT0UBLSSV5mxzGYbDNd2LYeWPiik5lN4iToKp2UeftFOIaEj72EGSfzPpDSZVkW+PszVe2xpM5Eg+c2lYh0LAVqNhB4b+pUANtMnwVkFvdWtYpRrhIuIK/DueTfpjs7C6EqVsjI=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3249:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:Gi2xID5TNVpc1KNUhmRYna8De6HXwNwSjy3dEU7gcZePUOLgAeFCrS6H6LsPABFs+h546mDl/iD84KLljsWyaPkLMBoNBvDa0JY8dhh3IKEQ8XTDFz6bnhpQ1/nldmUb/0Cs30qHFSlHBo4StNyD8nykw6TWpbGM3SskK03kZtcPlzUj3+68y5s4xA54ewJJfKnWy0a5KGE6Y0f2apjZFdx1XcTL8g0iPfSCxN4jf8qH7lq592GqHBM3zcqs1NVKa1PjAFpyS1q5fvonko9CzRLiXSKoPxIGKDI9lI4/Zb3rwiqYLSNaOzN2ItubLurmQM4o7D2HB8Q3KR3sal/pngX73Xerm5513aI8YncB0tZ6FIB/V+ujau1LLdc/lDwpboaOQfTf/hT4xL5IdrNEaofGl2ALoDx6onDCvNsZkmjKNdAUPy1zDxjn+Oiaglui2gVH6RI/lv08X88W0Nohdq0qj8H4o7EzZfzH0VEuSW7N6jP+PYaShBkzQknRgnBb;4:iI0VbzScdmUbteW6iPuTbiiKiGrrW3w22apfjGEsU5P9XsfWBftROJXCQUragewIPttjSFcwqRtmJBsc5QxyxMpXQVkGafMi2VKaNE02DGxDgUKUihz2e9G8ZC+XwTQsFb6Yd9dW3u97WXk02SjJa1OhaYEyy0omLmswck35o0kDvZVTgCqBnNh1Jg4DBGyGKZ6IrITsVYSWi9L01VH2Eu/nNDgwgCZ+RVK0GbDkb5atOMjP21UmMzwQvicw+oHY6nDCMbyWGb9/gltVE9hdew==
X-Microsoft-Antispam-PRVS: <AM0PR08MB324917C3F4F0B6BDB8B5452AB0380@AM0PR08MB3249.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3249;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3249;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(77096007)(476003)(2616005)(5660300001)(11346002)(6666003)(65826007)(26005)(16526019)(186003)(7416002)(53546011)(386003)(446003)(956004)(47776003)(229853002)(486006)(31686004)(65956001)(65806001)(66066001)(106356001)(81166006)(81156014)(305945005)(105586002)(6116002)(3846002)(6486002)(8676002)(8936002)(97736004)(230700001)(7736002)(36756003)(6246003)(52146003)(2486003)(76176011)(14444005)(68736007)(16576012)(316002)(31696002)(58126008)(52116002)(4326008)(23676004)(50466002)(25786009)(64126003)(86362001)(2906002)(478600001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3249;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjQ5OzIzOjkyZVg1U3VvMm83WHdhcXZPL2FXSVN5VGRi?=
 =?utf-8?B?SkJsck1QS21KMmM2MWJBam1qVDFsMm9jbFJVbGJZdUQ1TXVrdVlSZzB1bGU1?=
 =?utf-8?B?MDIwTUQ2ZXdZYWcwbDJHS3E4Vy9mSFFnaE5QQjFIOGFPd0V6QVFrWjYyTlJJ?=
 =?utf-8?B?RnN0bUtrVWRETGF3N20rSWpVU2JDekxJckRzeGRJc080MWttb3QwVU1JOFQv?=
 =?utf-8?B?ZW1rM0diWVE0aVF0RHNiL2VMLzgvVlhmZ24zZlZYdmoxNm5XVU9CNVRPS21S?=
 =?utf-8?B?V2RpSHdaRE1Sa2xKR3ZTbFg3bzVodEprWEt0YVF5bXhOZG52MWY1R0YwSGRK?=
 =?utf-8?B?NDgxSnViRUxSZXFGT1lZNHRQOEhFaWxLZ2ZJSXZqUWhWZGxnWFYrMXhyaFkw?=
 =?utf-8?B?MlFVMlN2WDZiNnNocUtSc2xIRDloemhGczZ4K3hKRGFnRUdDOGdYYlFIWFdq?=
 =?utf-8?B?RE5nUnl6TU4zOFZaOGIwWm1qVzZEaGI5bjcwL29LSkJnL1NZQ2c3aTZkcnN1?=
 =?utf-8?B?bHdkRE5reFVHSnVNOHlZR1dxaWxhSDQ0RDlCd2lxbjdnUkRNZHNnT0JHems4?=
 =?utf-8?B?VVlEV1hoRld2Q2FJOG1SM1owdDgySENiYkxRRUI4Q2dCcUxUVXlXampISFdk?=
 =?utf-8?B?R0sxZCtKV25FMXR2NW95VkZDOGVQNXljODdwOUw5YVI3dVRKL3haUzFZNW95?=
 =?utf-8?B?RFRvbGlxaUgzUk5wbjFhNlc2Q2JGYkVDaWIvajJQMjgxWTVKTU5DQW5FTzdv?=
 =?utf-8?B?MGh1K2hhUjVYTHZMOXM2U1hEZlFpNnVGL0MzSHdxVFhSN1Y2Q3l3RXNuRlVu?=
 =?utf-8?B?TGkyNm55L0kvRS90RXlJeFROSFFRK1dSSk5IZXZGRURYOE1hdmp5VTJHL0Ev?=
 =?utf-8?B?VzJuVWxYTENJbExBdkYwcmZQMFNzNzBBcitNNFpBZ0xTc2Y2T2sxcnBFZkN4?=
 =?utf-8?B?STJlNXg1V042cHA0aWVIN2h2SyswRGppUU1xZ0F2Q2FBak1FWUVwd3l1VHpy?=
 =?utf-8?B?RENONE0vNGJkejdIZk1qS0tpbXVJM3NBTTVWTjh5RmFiZ1QvUHdualBDZjd3?=
 =?utf-8?B?WTRxWjVKTnpBWnQ0c1M5SE42SHY2ckdHTlh2QnZNMElBWHNCVGdELzVoaFN3?=
 =?utf-8?B?N2VaZGU1bnNQSlZWaGtYR3VLbXIwVXl0TTU2YWhjVGJrcEtZNzhkQzNROThE?=
 =?utf-8?B?anYwUTNiMUttK3hWNzUyUGVFY1RTNzU1c0s0Qjdzam1UUk9tdWI3eWhFSGQw?=
 =?utf-8?B?TDNtenNVSnZjRFY2MStBNkJxTFlGUGNHaExuaU5ZaG44NDdKc0cwV1N2VXRL?=
 =?utf-8?B?VkNwellaVlZIWlQ4bHg1amw5aG1vdHVid3NIazJYWXNGU0pONTU5THhkeWxW?=
 =?utf-8?B?anRseEZwZ1ZvSXRDK1gya2Q4amdORmc5aDQrdGF3SE5YYWRMR0JSRXc0SFZx?=
 =?utf-8?B?Q2lVWE9jM3d1NEtqY2FVOElqbXFiVTJhNnhvMExJTjFaQmlFZ1dQb21RbjBi?=
 =?utf-8?B?OFBucmREclR2STBvWFJFbTJHdEVvNm91NnFYMUY4UWQzMDBINEpHNlpLNzFv?=
 =?utf-8?B?N2Y5OGxxbnQwVGZ5RjJMUzk2Q3I2VHEwQThxdVNYZWRVeTJaTllOUnNIWGhE?=
 =?utf-8?B?RW1LaktRWTdTbFMwZ1hhSEdOUTJvbkprN1hRNjUwVGV0bEptUTRKSFB3Rks1?=
 =?utf-8?B?SVVpZ2lnNzh4SkNqVGRETGVzdTJQRUdPSDNYMk5JYTZGRmNtTzdhQ09xZktN?=
 =?utf-8?B?ZFhSSFNHOGRuL0tCQ0p2aDVWZjMyVjhCOU5ja2h6WVE2ck9VQlo1c0lHYTB0?=
 =?utf-8?B?OVFTT1NjM2ozaXZUSlprUHRJSHk1OXNMSUQ0OGtwcUtKWWR5N2hJbHA3TUJv?=
 =?utf-8?B?cFVKZytkRndQUGFLNHhiRTE2UCtqWDU1UGx5NDl1UG44QXZMeHJNTFNsRGpG?=
 =?utf-8?B?bmVXMnJHSVBRPT0=?=
X-Microsoft-Antispam-Message-Info: KN00z5AVQaV8MUFdz4MUEUBgPtnlTVfGKa+OCu6ETDThNDmF2Fr5eyOYXwVm31R2cSThuu8DkIhJpd3s+elBFyLro/xSTkldiquP9J/wPFNjEil1RL5hVocW0yCZpCkQxl4G2F6sV6cVcKfgLbfqLW0/q4BMY7yhOBf8keIuxFL996xoz/W0U3AMP7VC8y4shy6+4g4p00tsY8zcCmYQEUi7Qrvbzoh9UTs74j0Hk6Jref4/n4hJ6brAio0g2eIkwdnwQPd9Jtcei5oc9s7oeKNKl32gM/Xr5NItbq1JkB1Ik1UZmv7p34QX8KpXS0ayjyVVjaopiW0K8lAj6oaf+LgniGLk2VbdxcZo8ykzUlQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;6:V46L/rCAkyQtA+nHTchbT2NBWRHaSKes4ecf3/P0plwjdfd+ETq1F+z429GyHI6BNtMBCXeqU7caytT3iwdOjwRHxLLw0sZ7lOpZEqXGpM/Vi5MUHL979DgQZyvbfUi+mrbUWSF/Q8MTeTuXLFLn9CyP3Awhfa6Ql7Q7kPZviFYapQHXC3UZ6ttY7wmtrAGmy69OKNpM0QdLpQsIfrFoar3Knj98Y53CHZp2eq2oHzsjmIUyxkl9mC7BdkwlYZjkqlMscrvuf/zYOLiC2kgxSprNVPt9mfvhYaqMTJDz55MA78avK6M4tNAVnIA9tssB5uNu3viv3Ap1Y4Jx5IOKRayeeqYC3Y5J38o3RKLe8F/8dwoh592O7UYIzyx0C4S+7QcmXsoXPeYVypoztE88fqUoCxb43NQyBd5w7uanYm593CfMEoOD3zIJPZFrEucRM7pTIDidmC7X35R4YMOw6A==;5:BdmCOXISkarWZFRGOIzM5cCCryyRu1n9RMZgwUzMHHfIb79J9sP4VJnfIAx9HUGbQUhrQXFCr5FMpZFSDxoQRBsvDp2RFwwVnkIAdQsbwFRRohkWq19QTZ9Vi7PI9br9N13UUsCFTfVpTMbRwC6EthvBr/d3x4ky7yQ5/YDIRHQ=;7:yPg5F7qMQlhDoMIIOjuYHEP+UGjpC6p6owfvHA6aGP+4NcYfBJphtTKJdOYoEfAq2EtEJhs/ZLCVEdRwcOIOeuIs10tMnc819l7JuFJsXaxMol5qmDZSWdw2eJeCFE+hMXgSVqvTiV+jUCMtmQe99KARpztSf/umv4jRQ1V7LVqPWmm7uGn2vic49sE5cyVK1e4SMynAJPpITqz2Wr7uvSopsPhkLmiahfwMDdyR6BGFA4w3W2URR/ObpIn9UmHX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3249;20:HcYBr6y3gnTYkfHTWy9BDlQQNLTL3Ucie5Xe32dvXYhEIxtVCnGf4yUvvUnS0tgAJScv87kZynLyAUF7Td56ecjxw0QcObEY6ty/6w/tubHwlx4vv/OGXC1RX02uovxorzmsgpNU7RNpWgRw+wvaGCgO90F4o9ah9hXoM8QDas0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 09:18:26.6941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2075d4-ec0d-418a-775f-08d601c6e51c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/2018 10:55 AM, Kyeongdon Kim wrote:
> Assembly optimized string functions cannot detect KASan bug.
> This might have been the intention of the original author.
> (not too much important to catch)
> 
> But, I found the obvious uaf problem in strcmp() function.
>  - in this case, using 32bit KASan patchset helps
> 
> Since I used c string function, I believe I could find this bug.
> After using the patch, can see the report & backtrace the below:
> 
..
> 
> Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> ---
>  arch/arm64/include/asm/string.h | 2 ++
>  arch/arm64/kernel/arm64ksyms.c  | 2 ++
>  arch/arm64/lib/Makefile         | 8 +++++---
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
> index dd95d33..5c5219a 100644
> --- a/arch/arm64/include/asm/string.h
> +++ b/arch/arm64/include/asm/string.h
> @@ -16,6 +16,7 @@
>  #ifndef __ASM_STRING_H
>  #define __ASM_STRING_H
>  
> +#if !defined(CONFIG_KASAN)
>  #define __HAVE_ARCH_STRRCHR
>  extern char *strrchr(const char *, int c);
>  
> @@ -33,6 +34,7 @@ extern __kernel_size_t strlen(const char *);
>  
>  #define __HAVE_ARCH_STRNLEN
>  extern __kernel_size_t strnlen(const char *, __kernel_size_t);
> +#endif
>  
>  #define __HAVE_ARCH_MEMCPY
>  extern void *memcpy(void *, const void *, __kernel_size_t);
> diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
> index d894a20..eb9bf20 100644
> --- a/arch/arm64/kernel/arm64ksyms.c
> +++ b/arch/arm64/kernel/arm64ksyms.c
> @@ -44,12 +44,14 @@ EXPORT_SYMBOL(__arch_copy_in_user);
>  EXPORT_SYMBOL(memstart_addr);
>  
>  	/* string / mem functions */
> +#if !defined(CONFIG_KASAN)
>  EXPORT_SYMBOL(strchr);
>  EXPORT_SYMBOL(strrchr);
>  EXPORT_SYMBOL(strcmp);
>  EXPORT_SYMBOL(strncmp);
>  EXPORT_SYMBOL(strlen);
>  EXPORT_SYMBOL(strnlen);
> +#endif
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memmove);
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 68755fd..aa2d457 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -2,9 +2,11 @@
>  lib-y		:= clear_user.o delay.o copy_from_user.o		\
>  		   copy_to_user.o copy_in_user.o copy_page.o		\
>  		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
> -		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
> -		   strchr.o strrchr.o tishift.o
> -
> +		   memcmp.o tishift.o
> +ifndef CONFIG_KASAN
> +lib-y		:= strcmp.o strncmp.o strlen.o strnlen.o	\
> +		   strchr.o strrchr.o
> +endif

I think, this won't even compile. EFI needs some of these functions, and it can't use
instrumented and not position independent variants.

The easiest solution I see, is to not exclude these sting functions, but declare them as weak.
In that case, EFI stub should pick up assembly variant and the kernel will use the C one.
