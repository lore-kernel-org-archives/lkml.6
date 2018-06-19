Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2AD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R1M/RJMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2AD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967094AbeFSRdA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:33:00 -0400
Received: from mail-ve1eur01on0118.outbound.protection.outlook.com ([104.47.1.118]:62471
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966368AbeFSRc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqJt9mfdtwh5JT2AFKAVqLfV6oWz9HsA1WCys0GG27U=;
 b=R1M/RJMeHwy6MUzstzEIntjpFCovgZlNPcwVXw5mcjHjR65t8Ifc5KPO1hh/V/9M9/8UCiFxRAS333D+OWUvxE9HNrfTD3Y7UeNiYoLSZCypliSGN51qSvYq/4w9AL0qA19O1hNJkUz10LeUKiSo2IhXeAQjJx2f4GHwWCpQx2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (195.214.232.6) by
 AM0PR08MB3252.eurprd08.prod.outlook.com (2603:10a6:208:5e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Tue, 19 Jun 2018 17:32:54 +0000
Subject: Re: Possible regression in "slab, slub: skip unnecessary
 kasan_cache_shutdown()"
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <46ca5661-4bd1-6733-0140-d6e6dea1ab33@virtuozzo.com>
Date:   Tue, 19 Jun 2018 20:34:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::44)
 To AM0PR08MB3252.eurprd08.prod.outlook.com (2603:10a6:208:5e::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39fd56f5-28ce-43b9-047c-08d5d60ab130
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;3:lEVJZhV8WJq9yQBMXwKyrp13cvdPjAffN8/WqjUKyvlc8K0+4pSom2YWebiLu8WkSH8BE42UL8Bv5KyNme2jIi0q3UR+sE5vouuQhRS+DFB8HTpjWZ5Q86O073Z5xKAPoV4NjM89gv+bQhuthEgT1ejtjvJuwspYjQM8ejqZ97SrZPRbKs1dvF2ZmvvPJeWyygHi1tWwEkxz1PRpbiG7ExgCGBqn92Z+CZNMjGeuyAOMykpN5Kf+Sk4e2hLJZUa5;25:oPfCBcGXzRYioBNxXghX/upGvI/a4TT2pAxePb0Y5KUmlei0ryYLu0HFfvHkeen6E8WdpWaj4TFW8QKbwf/1e5tg+6M2DDqggyrYJFUW5Gd5pelvWrI0GZuY1MGsll9QXMYA3G8/hRyFQm+GHKvfBEkqqTJHG9zLCoPlA4MYuLVvpXGlah9ln/iFESf8y3kgCLb0GeYxmrd7dOUyU2imXrn2Cw6sNQM0lr66bxMBkEbcIdVh0KzB2iBLb1maxo/VEG+Q0c7PyWG9K+sGEEVYA1C2Rud54y9MgM7fmZmkB8pfXHDuvZBuKcFUBby5ZwfFqkWs86Co1jcoRDKHQZHzBw==;31:pMIvWC0/G+dkGkJZucw06Pf4jEGIGiL5RWhOskfrNixBSJk8p4pZKnZUXHeZblAR3pmj1gEnGWrhU/+WfNvSXXZ1ffHpXC9RCEM+Hra9odGHZQ+DOxuBCCFkyq7YmyUi6VX6YZ8PVn14ttZr0rN0qrTgjFboJgswALZHFK5lQb6wjvuvMdmq4YfRh1CvmFQp7C30t6Tw8fgqwbT2DVFnBN6cjLbYjLv5a0H+X9gGHXE=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;20:eJdoGdwjOea7spAp/pKREtONcWqIRvhY2CMes2zhtfKM43ekJjhqFfF1gw0FWjyQk05i+F5USV2FsPCnnCNJNqN/Tu9fHJ9VTN+lHEfVsanMV6ThGJg8vz0Z96scfF1VB/RQn2LA7KSmXUCDUbeUNUqOXxOzPB2qRASC5SH/Wah7093OaEGUkGuJBx92RE9YqN5jJJFzo7Zv1PrcB1tA1XEkQ8G4zHWw1AvpN+Cuh845P2V7vGMRuM8/XVv3h1UMMliWSN39RnaV2xs3owXroE3ub0U8fn/5juCdaGZ5+298WCKnDzPrFe9yl4F9i0GuObKd3MPaDMfApd9X8McEi3UKF5mx8CkqnwhHLWIurZKE1rq9/1PQPCGciuCf3x9KB6jONMegYUzAE5ILm4WSBNUdyWGNjbgx6h5k3Iuyi0Q3I778XnY8FYKjwd/vF2vd6nDDodrNXRJoT0XJ2zOzkjngtwhXmHaPhY4W+WghFRW3KBh4aK98uGtrWhV6DsFm;4:HsSoQiWnsCBvpvxy3ReFmD1IlQAglRSpg6AhyEGHWzYVwbhrFMvctTupDwOv904uGyWjmh7LyiaRq5HtDoht+09jmhAMxEH1Q/gT0f8ZPaUvE7+HFMl/T7wExbWwvmQvw6LErvqPxDb41JHe+ORDGFTm0X1Q3MVRPS2iyoZ77OkUNp/VQ1FNAMdPeIkMxz3+gjiOYKDvO6fmcGctePphO95KGnkpmyFvgrhg41GIulpTdUJtJo2Lx76e4OthSGZMQPbdFBV9bgXHeTkSRkYCSA==
X-Microsoft-Antispam-PRVS: <AM0PR08MB325233D4B8AF2AD9D204D954B0700@AM0PR08MB3252.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3252;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(6246003)(7416002)(186003)(486006)(68736007)(16526019)(66066001)(47776003)(77096007)(65806001)(65956001)(86362001)(6116002)(575784001)(476003)(230700001)(2616005)(53936002)(956004)(97736004)(5660300001)(6666003)(65826007)(31696002)(478600001)(26005)(3846002)(16576012)(7736002)(53546011)(76176011)(55236004)(305945005)(52116002)(105586002)(2486003)(23676004)(31686004)(52146003)(59450400001)(386003)(64126003)(81166006)(81156014)(2906002)(316002)(36756003)(8676002)(11346002)(6486002)(50466002)(25786009)(446003)(58126008)(8936002)(110136005)(106356001)(229853002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3252;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUyOzIzOklMYVI3MWJiNytHbkE5aVp4VWhrYjJsVzVH?=
 =?utf-8?B?M2JocjBMM3hqOTFwUGFtcGVBMW1rZjUwOGxKdGtuNGxUOFROMGp5SXM1clVU?=
 =?utf-8?B?enZYNzZNVEU4Z0ZZdzBQZ3B3TnBvSUpPUzd1aW5sNlN6a2NTRkdldkNNVkZM?=
 =?utf-8?B?TEt2aFNidFVOUkpRSmo0UURvQkt0Y3FPNkJ3QkJNQUREOHJoUlpUWHplTHAw?=
 =?utf-8?B?RVdvQ3JEdDlXNWJoL1V4amNmWkpyWlUwTFIzN3FIYmQrdmR3R3o5Qi8vUDJl?=
 =?utf-8?B?aVVFcHpieGZmQlhIQkVtcXB3NVo2di95UEV5Z3RuQ1FBRHRiekdHRWNQVzQ1?=
 =?utf-8?B?NkRpSVgrQkdaR2I4dy9FTzZJYWVCQVc4VlIyelVoR3hYc2RJaVB5KzNpaW1C?=
 =?utf-8?B?SUZBRXZMdFF0elVnaEJyNDlyNzBPRC9QYWJxaG1TUCtHZXI3dTZBTXdYaTJa?=
 =?utf-8?B?SXU5d0IrSUhicGIrUVRaNU1yVVJhTnJKQkk5LzlzY0poNTVNZWcrb0RVa1Js?=
 =?utf-8?B?T1pLM1hsTWFGNDZGWTcrSzdKMzJ1WjJiOGp3eDhFOWUrSDB5U3V2UFlTY29z?=
 =?utf-8?B?bkllQWN4cm54Q3F3SDJWUmtaUURWVXZ1QkovSldvZVhGVnhVK2JSRU43bWJq?=
 =?utf-8?B?NEt0dmRBdExwblpvdmdsbm9OMjZRV3RTajYxK2poVlhhYWswNWFESzh5YU0w?=
 =?utf-8?B?MUxYYzl0RnpwQldUcVF5WHY1NW9OTjdpNkN3YzJMRHY4b2F6VEpjTGdCQ1py?=
 =?utf-8?B?KzB6NDAvaXNSTzB6QWg1V0FBOE8vZTZSeSswbXJZNEZvU3BSK3JKOVgzckJS?=
 =?utf-8?B?aEd5dUJBOUY1bFlDQUg0ZGViVkxhUDRrV1V4Q25seG01MkR1SUlrRHRJQTdz?=
 =?utf-8?B?SFE1VVNacG83Q1lPY0VRdFliK1BydGFXQnZmWVAzLzVYaW96QkdmTFN5a1pa?=
 =?utf-8?B?TWRKcUhsTHlPWFkzZlk5anE0Vy9MMmNVYisvNHB5R3UrZm1HVmw5RE5SNzlY?=
 =?utf-8?B?YnMzN05va2I5UjZSUnFtRDJnZUlXL1JkenV4allYWnFINTV0bkV4am45WFI1?=
 =?utf-8?B?b2VKMlRxejJTZ1N0aTVrTkowVllDRk9XdWJ1Q3E4R1VPNjhsdXluTEk5OXdG?=
 =?utf-8?B?RGtvZjFGWHFHQTJkaTBKam5UQmNhVVE5SS9uUEJNWkhiNzdpVWMvalA1amoz?=
 =?utf-8?B?YkRmaDhyQW9WcnpUdTNIcHFrVk1JVnhndXA2WjdnT1d1dlVoZWZZRDhGaSsy?=
 =?utf-8?B?ejhSS08xYjN3MDRhR2dUckpTcXlBcnNxZHY0UFlSTGF2STFEU09TejN5eEx5?=
 =?utf-8?B?TzNtSlhhTTBNTGs4bGhZbUxaUTNjVU9pOEtLMkd0L1ZVU3lrQWNkSVpqVmdx?=
 =?utf-8?B?SU9zUUV0VFhGK3dNeUxvNFJKY202VzBkWTU0ZGZ1SndreXdwYnlsRFZMakxu?=
 =?utf-8?B?dkpTSzlxelhVUnhuRnJWd1JaM2xBblZGSjRmS1B0M2plcVA2VWdMZ1d0b0VL?=
 =?utf-8?B?SlFvdy9zMFEreU1vbWZzbWFJdzllejlCYzA4Z1lLL2pEWVpOeUpkY2dRTVhh?=
 =?utf-8?B?K0hvQ25jNlhGSXFUQWllZFlZa3VtOXpHdEZVZzdHVXlVdVFBYVBwU2U3UXVX?=
 =?utf-8?B?SU1pUGk0dzFqQXVsUUVhaUlybXlmSzZPWUdlOXZ5a0EwQUJ0VmNaaURkV2x0?=
 =?utf-8?B?YlhwRDJ3THBGKy9PU1UyYU9yTDZBb1VQd080QU1pSUxSY1gxUHRYSWx5cjZO?=
 =?utf-8?B?MEs1SERydWdRaWlrMXRzSGVuNFBCN3gwYWFRU3NnZzZPTkxMdVFQRFhJYTdx?=
 =?utf-8?B?VHdWR3hqaHh5aVpEREhMYStuSmZrTGk1Q3dlS2JaR2hBbVA2blZvQXJ0NnlU?=
 =?utf-8?B?QlY5YkIzajdxTnRpSjk4a1pWQTJ2ald0QWU1UTg2UTlwY1BrM3piY3FacVFQ?=
 =?utf-8?B?RlVYUzdUeS85Zm5ETlBaeUxod1BJSzhUZWN1amVSV3JEM2ZYU1plWldJZEtJ?=
 =?utf-8?B?MWkyQUpEUVpITWVzeGtibkdWODdsNGxhb1A3Z0hCSmx0LzRkNElTSm5xWC82?=
 =?utf-8?Q?TZ3Hy8e0e3OLcM9OZd0Q49hnZ?=
X-Microsoft-Antispam-Message-Info: sPT1LTj8+aE50mb5Cfv+oUrM8l4GdQqlnJC/6L/jdD0Zn2dSUZBtAv1J6fYormsJYxUsP8glUP+uckLR361uhwA1uNV/QTWKh+exI2G0m+52KEprPPErdG9q2GmmUHFxwpmoZuxuKOgmY7YmpZLZlZH0FbdtEF/0YyzenqJF6lTYgwlhLHwO4fUCanOVvioNT1VRYrjmUzfuurhdK/LLEyWWbCDa7lkTy7PQTMptwP8JIDVWCqRoMpmYKk9BfPAhXPl380gnKBs5P3aNsfum0Yw/cbrfOhdZ7bMfuHctCtzWL/9HO2kU3rPcydVSnzBK
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;6:tkXVRc9QIvYMzd3izeHyw5stJK2zzF8pRMjf0UPrJIuiIuuoQjjTyBTlvRIe1Q6ysG4BUqKGFwLgB7kI+e+o8A6DYnIhLnLb88htHmTY93dqh1sCHbgxqeaqfRg1q9CKpMo+wAMaePlidI53hW3sF70Ca7asa8ViLwdybiC2EjJJkW/yZt8s23vfpinyZU/Cux0EpixF+y2ZAIDgSWKghyjTo7KKewA0cAdnYNtI/0p3KxHjx5hnt8/ebOeL4R1vQS1t9VtwdBA21hPT7HS4Bpg+GATrmmCXLns7PdgT82UwVjBVITuUmh09sv5dYNh6QGm7xdxfkOPLiZP4t7dAZvNPUF6+tH/fAnlE2ZUtChhYF3/XOy0ZrTA4gmfbmN3Yv7hKB1TjWwhaS6ISiIuSBAG2I6dtVX29/6K73Nt9v/8vNd+bTmMhyS/nuXiJgvQEuFHEnthB5JoN/tnFfK0jpg==;5:kPh8qbieUyGwoxErp9otVMdyvKuqJzSEtlkJgbvar4wD5OVtLq2PbSZmpwgrm3c5hCOicEiDfApk/TFJH/Z77m3MrUpJ3eivJ8VONfKfrgG/0mdPmHIq6Lba0lbGU9E8RvnnIrLnl4i4DK7XJ7VHzWn6dniorkRccWsFfWZ/2yM=;24:aU70pCSm2hpAJRhzVJRBgZTcX0T7JtCGTLxGiXtG1k5HsyH/Wausl803Gam5j5c6wFKOfF2J46HeDvauI+vOWRFQqEOO9S70SiSC7BvFlgw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3252;7:7/x7+VyWyxq92rjuDvqvEiDaNojCazHHq2AHrDK5qSXo6imOX7Ik5ucU0BVxY7od7FhWWl3iG+uI7pvKIydheV0OjLfur+Fkz/d8of5JtClUlcR/0qRyvAr/3VReZgvikmMXMCjjcDveceIjtXMHXfOLDGnETVU7pbJ6K74gMPDJ/C01/rHj7fvzmVvo/vY/cor87h6+3XAmJAl9jHXcSwurUMpmJPYwwz4X4n9ykQzabs7kLHENQbclXcJ6yzBi;20:KO3lBQsU63LnODIAjEb/b5sgtoJQmljgPT65GySRmKVn6iDQuGWF+ipZZ+LGHSoj71YdPhn1isjinWVrRd7W/ZLyXcRqhLU77MhDKR/oPHDz58Uk5u3qsafdaAXJH63/6KGcbpiiOWCE7pINRxDhI2qRBlVAJgl+ZB9KWIxTo14=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 17:32:54.4930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fd56f5-28ce-43b9-047c-08d5d60ab130
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/19/2018 05:51 AM, Jason A. Donenfeld wrote:
> Hello Shakeel,
> 
> It may be the case that f9e13c0a5a33d1eaec374d6d4dab53a4f72756a0 has
> introduced a regression. I've bisected a failing test to this commit,
> and after staring at the my code for a long time, I'm unable to find a
> bug that this commit might have unearthed. Rather, it looks like this
> commit introduces a performance optimization, rather than a
> correctness fix, so it seems that whatever test case is failing is
> likely an incorrect failure. Does that seem like an accurate
> possibility to you?
> 
> Below is a stack trace when things go south. Let me know if you'd like
> to run my test suite, and I can send additional information.
> 
> Regards,
> Jason
> 
> 

What's the status of CONFIG_SLUB_DEBUG in your config?

AFAICS __kmem_cache_empty() is broken for CONFIG_SLUB_DEBUG=n. We use slabs_node() there
which is always 0 for CONFIG_SLUB_DEBUG=n.

The problem seems not limited to __kmem_cache_empty(), __kmem_cache_shutdown() and __kmem_cache_shrink()
are also rely on correctness of the slabs_node(). Presumably this might cause some problems while
destroying memcg kmem caches.
