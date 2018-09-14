Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA11ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584ED21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="YMJXJ72z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584ED21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nextfour.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeINPHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:07:06 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:50928
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbeINPHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwLRGmiR91rhTqsq/apHc58WE0Ql5KRtaGnF8WnEqfA=;
 b=YMJXJ72zpeNyOsr/73AlDj4/FQZFKGJvJxSLsS2iOOafKPF59a6DbL8LFtSy0G7UHIhhtUN6EiJTgaqd9wsWWdZ7D8MleSmrQA7Q5xyfGPY3aa755xZFC1mEpTX9p33vQOlqvomvnzW4ByoKrcWdvPI673ZlRGDEfrtALumniyE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from [10.10.10.110] (194.157.170.35) by
 VI1PR07MB3344.eurprd07.prod.outlook.com (2603:10a6:802:23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.11; Fri, 14 Sep 2018 09:53:16 +0000
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
 <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com>
 <1831106.CYv9dyYV15@aspire.rjw.lan>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <e028742e-cd42-24a7-0da1-4fa12d8c9d7c@nextfour.com>
Date:   Fri, 14 Sep 2018 12:53:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1831106.CYv9dyYV15@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To VI1PR07MB3344.eurprd07.prod.outlook.com
 (2603:10a6:802:23::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c7bfef2-35fc-4a49-0dd3-08d61a27e529
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;3:+P5dnlteJekUs9+VVv2F6L+VuVF6Mn8PhWvtLQVOQtNxRfd+8636fQh/0ASiJJEKUtWpxBQddsRONWthFYL4YkOeiqmhEUYyAgLwQmuI0OGSKb/z+eXPbue5RSGoaGVtl8SROBSPVIzK8SfEheBHk32K5VDvXq4U2wnURoiaPCSH1dw4GTXltwX4fSoEmdO3KPyuMApMsWOoDQnlCCjD3BWvrvfLeeip2t7lrWQVi0hYMjTc1am47IJh7wNidb1g;25:HEhb8cVhDdjYDsQ3ZyStwS+ry8Ssaabw2oyGkLYxPGAdpm4aaGYLG7Zq8L/HB24fKdH3kPyLSwRN/h2/m+3/yIsEcQoeOHjSwAHapCoHZ1ZbJlDJaSjshWXCVO/9hgZZJYJBz3nNGd3QARkOku58cKwmmilYzKPepUMPswIE6m0gD9/Kq27dzTs/Su7lSzP5xpkLN+KTrQiqfmrppSDhJdKKpKKSF5uOsZWhXyQXpIDamoCcP4XUpKv8j6znGDwmu4rcVSCvp7jR6U3PGlqZiN98Yzb+d2m/9RKdP43MQndtGca/KteG7/gsCOod8IrQ5Eq45d01j4xeeFCmRZaFQA==;31:1k6D4gSTHcQKh/drSOR21RXLi8dRA0LpwdqHUbPYA2tlbZ+tC86PpDr621UtmicriUKLilLUZ5yiQO+Ha58qnMkmZNpdi9/8uZt1XOCginn3VTzAwNkdLFO1nWrWI93lQ0f4VzExmMfcsDSXjfzBVb6mfALBECqBCcTjgKILOvT49mcDnYdyRb9nSrT9gBeREx0rR24Y+kb513sKD61df04l/KXxrQyqCa70bGqIhrM=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3344:
X-Microsoft-Antispam-PRVS: <VI1PR07MB334431EA3B81D2A34D1D1AF283190@VI1PR07MB3344.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699050);SRVR:VI1PR07MB3344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;4:IvFZ7cdrWdzJU5iBPIyifECy7f6F/IMnw4ow3gVa5vQLZvg/A2Y6spmQUN49QARvD08YL7gS+saOgtVw6Ip6+c8j6rQrzA4x4prAJneA4+nzabzxytG70bXTfZnfc/cL9PGw7Iho/qqzxjfhTnjKT+WZB+3zrYvdg/x05X6AwNDZCvLRECderTzEb30eWdHIJL0eSz6zACPlHh3Kd5YMj44WFWbvSgzhndioI4Y6lvxwJ94k2EiNZIkf7m7mEmxgUECiJXur5NBRM6ZD/yA1K+zdW/kBcJKGbdoVxMc8selze9feVJk2SPvWkiB3Uroo
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(39830400003)(376002)(346002)(136003)(199004)(189003)(486006)(3846002)(36756003)(105586002)(23676004)(16576012)(52146003)(7736002)(2486003)(956004)(446003)(476003)(2616005)(54906003)(58126008)(316002)(86362001)(52116002)(5660300001)(76176011)(50466002)(65826007)(6116002)(65806001)(6916009)(31696002)(66066001)(106356001)(65956001)(6666003)(305945005)(11346002)(47776003)(186003)(16526019)(53546011)(26005)(77096007)(508600001)(386003)(6486002)(966005)(15650500001)(2870700001)(6306002)(6246003)(14444005)(8676002)(53936002)(2906002)(4326008)(97736004)(8936002)(68736007)(229853002)(25786009)(81166006)(31686004)(64126003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR07MB3344;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMzQ0OzIzOlNTbXRqUWcwQTEwR21jSC9lNU9MRkFiZ2Jk?=
 =?utf-8?B?eGZNUnpNc0xmY1VMUlJZQ0RKOXZtRlVaelZUOGsycXpaV216WHdZL29WOGYy?=
 =?utf-8?B?dGtxblFWSnRDV2pSYWdyeGxOVDFMTGNWTjNvVVNJMzF2VXBjaUZNMUNsMEY4?=
 =?utf-8?B?cjF6L09CY2g1ekoxOWV5SElpbWpYczZKT0tmeHNNVHpSSGxvSHRNZUZOZzha?=
 =?utf-8?B?elIyc0hsYndTVWtQUHRpSVpGaWZrcW1maDdCZllFeUE4Z0tleEYvb3MxTEdE?=
 =?utf-8?B?anc5RnIrSGRDUUg1QkREK292UkxxTHpCci8vQVIyVzRFQ0tYSXQxSStqUjZi?=
 =?utf-8?B?cnRmeTA3THVQZnhWaXVKR0grdVpuc1hJeFBFSFpiZXozU2xaaWpXSVgwc01S?=
 =?utf-8?B?SDZOdEEwVS94eWhVRzVuR1RicHdHSGF2ZnpUTkhBYkxWNjE3L1JXK1ZkRXBS?=
 =?utf-8?B?d2JOb0hIdWEyUlphUG1OYXdoWUJ4cjJZMitPUVZ2dTY5Q2x4QWlKV2o5R0k3?=
 =?utf-8?B?RmtEODE4RGhhT20zV0RWaExwdHI5Z1VCdmxJK1lIY2s2K29qeGNabmpNcnhy?=
 =?utf-8?B?MTJFckFGeFFKZ2FYY2txSHg4a250NVRTOGFlWUR6ZDNaY3JJRk5KL0JXMVhG?=
 =?utf-8?B?OTNkMGJtVUN3M042a1VBNUlhTFg0bVk2d3FvQXl0bXY4aUJEcmpwbHZKVFBx?=
 =?utf-8?B?ekV5QzZuS2pCNG1qYWcrMGZpTENxYmt3OHY0Zk5vRngvTUZXa0V4N3NTR0wy?=
 =?utf-8?B?STRHYUhvVk05aHJFZndXTUkxZzVNNFk1Mzg2NmZ6bDN4VmIxb1U5MGN4Yll0?=
 =?utf-8?B?cXljSjFWOEVWN21DWnNGb2l3QUdDanZCQkV5bU5WNUhqR0xXN2Z6dmFidVlY?=
 =?utf-8?B?cHY1M05wbzVHL0xQR2tpNDlYSGFLNTcwMzB4S0RTVDRwSUxoUFBLWWtTaVV3?=
 =?utf-8?B?YlJEY2lzNEU5VFEyOWgvYkY5YXl3QnVWZ2t6UnlXQ1hUcWZMaDFhdkxZaW1z?=
 =?utf-8?B?NktVcGYycHFBVVJDSHlFTzJHUWxjMkphd2VmdWtBVlpsWW1Db2RFYjQxeC9p?=
 =?utf-8?B?TXpySmM2ZmR1THNlaGpxQjVOWkJIckNhWjFVZkF6T1h1NmpBeXo0dXREdzVt?=
 =?utf-8?B?LzBWS0ViQzVQM1NzSkxlTWNja1NrcThaNW5QSENpSUlhNDh2RUljVGlaVWxK?=
 =?utf-8?B?WnVuMzJwUUZxWTBkNXlQSWI1Qk5YUDQ3ZEk3SEZKbUVjQ2xDZEFxZ3phQmtp?=
 =?utf-8?B?OXVKbmdmNm1SSXJpZW8xYTZQaG1kS3Z6QkkzVSt5cTZ4T3pQUkFpQzZROTlo?=
 =?utf-8?B?SlRCUjdweHorUkt2dkN6UmM2T24ybWp0NGs3UU8yODEzWTBlTWFpcGFIaVpl?=
 =?utf-8?B?Y2RNLzIveU9OL1RMTVhZNTJhRllmNFlhTnlLK3ZJTVpRWFl6S0o4cFFQWVNR?=
 =?utf-8?B?SDZRWWlPTERmVTFrbXpTNUpreU1xckl0Wk9URFRUVmpNVWZHYXBwWlNlQ0VN?=
 =?utf-8?B?ZVhSb2tjMVZ1ZXJOdEhZZm5DNS9vN3FNRSt3SEVJeEVhUVRrRE9BM3l5a3hN?=
 =?utf-8?B?dUFJLys3a1paYkRpelNGbmlLOWxVNmlaTE9DVUVKS2NuNU5LL1UxTmdDeHdv?=
 =?utf-8?B?VWNxT1ZWdHNadzVVQnZjcGF2S0ZJYlJOeG5SVW80a09zaGFOekxQZW52NVhX?=
 =?utf-8?B?NnQ3MWp2aW5yNEcrRGVxT1BBSTcrdHdZSHlFVEVJRW53dVlwczNkcnNDeFUr?=
 =?utf-8?B?dG01OERLZThVTThoSzNiTXNFWUkwNVE5WWtLV3gvWCtWSUFEZFlUUTFtT08z?=
 =?utf-8?B?WENUa0ZybDZiRHBTaityUXZRQXoreFRwRmlsRk9adDJ5b005ZlZJMGhyQVl1?=
 =?utf-8?B?K0RzMklXS2NkNEZsVkVDbmxsYVFuRFJDakZHU2pqaEFsNjloU1ZsUkhWdm01?=
 =?utf-8?B?VVpWL093Tm1kc2tpYmNORWZFRGgwZDFzWE94VGJkaGZlMVp1LzdxYS9jYTly?=
 =?utf-8?B?Kzh3SE5oMUp4N01Hc1JCaWdIZHE3YjZnVHdoR3hpWFJpK0FaR1h1cWRFQXQz?=
 =?utf-8?Q?BMV4=3D?=
X-Microsoft-Antispam-Message-Info: r+Zv4pU8R8DtvJiwuKDTVISiekdZRwubdWMAx5k0OQyLRhtJBIhL/3FiAQk5AkyOzLMYxq2Yq2sNQFQUExN7yFxTZU+rY87wygwdoyeJKv6EjQztaw/ZFUt6yOBdB4o0SKdk0Azh43UVQrGW2vJyeieeGv6Uvuk3xgAVQhT/KXmtWyHCQAGMVoFjij/y9sJGuPL/7fokGCSzgtHCwkUNFGJfURkAp/HSxm16Apq5SSiZkYiLaJVmcsTXezkSpb5l6womXIy55PZm5b0XccKXlWohn+R9BWZx3jldkM4HoWoH9CfQWi5ROG5VRL1/hKAs1PAsBVmwkt9Z4xewit5ZehkE+38DL+LgGWPCJ4gtrZ0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;6:C+vthgjeZX7QilBuC70xizRdGgeT6TGHCoDz/MXsq2eVFIv3A7P+QQOvFjHlls07QbYDxMMAer571pvrQKqihrB+HgmoOBI+N5ewHMRTQvum8y6pC7KWT0viU1gst09oQ/qdgyKZ+vujP5GHrQvvEQTAQZEHDtLO3OV4T//gemyKOIqf25Oi7HYcR7KsvaPDVCEeBZfLoJg+YltQhqzit9Pfv8x5Nc4tO0yFb6PpgAATrzwHqVbrr7YcHEBxmvihP2QR/Hp5URtmdZvtw63lDF+XnND5JwILpgqvnBMqpT7EUbwVlWUROB6J3cPenfB7pzk21RHj6pSZqacpalLDQwVaP50I8eRnxOyHNPIvuKwjMAotbOrmV3Oygde0Z6eh0Zr1FYrWj0/vjB/IP+Qd/xZoJRmRQVA5AcEljv3USmQfOYhC3kss0AbA/pcz1JnBXoDrrITSArJDVtgPIzW3bg==;5:pMa+Gg4Mm0WS5I1zU9YLgi8hGYXlSqRoXU8QEmH9cJWk0oSjX05hwu4FTBpZ2m4SKQC1Gt6Q7i5x8HtFEFsOcdhK7yZOfGTG9HL1FB7A4IBUvWW+7CMIbNX/i95snBjxmvl7ytKRMXiFqnGbQDW5/m8+DRD8b9/OYSGaWfyEjSs=;7:1E9OHGD6QfYDlKw5VyDieM7xFn/at91XilKwuceBpgpBCR5p8HlmTxPhlEmIB7BE6JoaRjJWsssRCDhZRzJucC6wSc2H8jyV8hz395ybDDFgpffyKfq30yIciy67JVeS5wHq2vKnVUPq2kno13IiN1Rm42WEX59IdXkT5R2SRICCEPCB/PrWMtUx2FlmMDMR3M6Hd6Z/hWXdkgSahQB8IpMQLYL5wyzjw6EK5Ob0u9dd3XCZ3nVzyB5pw9DAUoLl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 09:53:16.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7bfef2-35fc-4a49-0dd3-08d61a27e529
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 11:46 AM, Rafael J. Wysocki wrote:
> On Friday, September 14, 2018 10:28:44 AM CEST Mika Penttilä wrote:
>> Hi!
>>
>>
>> On 09/14/2018 09:59 AM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> There is a difference in behavior between suspend-to-idle and
>>> suspend-to-RAM in the timekeeping handling that leads to functional
>>> issues.  Namely, every iteration of the loop in s2idle_loop()
>>> increases the monotinic clock somewhat, even if timekeeping_suspend()
>>> and timekeeping_resume() are invoked from s2idle_enter(), and if
>>> many of them are carried out in a row, the monotonic clock can grow
>>> significantly while the system is regarded as suspended, which
>>> doesn't happen during suspend-to-RAM and so it is unexpected and
>>> leads to confusion and misbehavior in user space (similar to what
>>> ensued when we tried to combine the boottime and monotonic clocks).
>>>
>>> To avoid that, count all iterations of the loop in s2idle_loop()
>>> as "sleep time" and adjust the clock for that on exit from
>>> suspend-to-idle.
>>>
>>> [That also covers systems on which timekeeping is not suspended
>>>  by by s2idle_enter().]
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is a replacement for https://patchwork.kernel.org/patch/10599209/
>>>
>>> I decided to count the entire loop in s2idle_loop() as "sleep time" as the
>>> patch is then simpler and it also covers systems where timekeeping is not
>>> suspended in the final step of suspend-to-idle.
>>>
>>> I dropped the "Fixes:" tag, because the monotonic clock delta problem
>>> has been present on the latter since the very introduction of "freeze"
>>> (as suspend-to-idle was referred to previously) and so this doesn't fix
>>> any particular later commits.
>>>
>>> ---
>>>  kernel/power/suspend.c |   18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> Index: linux-pm/kernel/power/suspend.c
>>> ===================================================================
>>> --- linux-pm.orig/kernel/power/suspend.c
>>> +++ linux-pm/kernel/power/suspend.c
>>> @@ -109,8 +109,12 @@ static void s2idle_enter(void)
>>>  
>>>  static void s2idle_loop(void)
>>>  {
>>> +	ktime_t start, delta;
>>> +
>>>  	pm_pr_dbg("suspend-to-idle\n");
>>>  
>>> +	start = ktime_get();
>>> +
>>>  	for (;;) {
>>>  		int error;
>>>  
>>> @@ -150,6 +154,20 @@ static void s2idle_loop(void)
>>>  		pm_wakeup_clear(false);
>>>  	}
>>>  
>>> +	/*
>>> +	 * If the monotonic clock difference between the start of the loop and
>>> +	 * this point is too large, user space may get confused about whether or
>>> +	 * not the system has been suspended and tasks may get killed by
>>> +	 * watchdogs etc., so count the loop as "sleep time" to compensate for
>>> +	 * that.
>>> +	 */
>>> +	delta = ktime_sub(ktime_get(), start);
>>> +	if (ktime_to_ns(delta) > 0) {
>>> +		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
>>> +
>>> +		timekeeping_inject_sleeptime64(&timespec64_delta);
>>> +	}
>>
>> But doesn't injecting sleep time here make monotonic clock too large by the amount of sleeptime? 
>> tick_freeze() / tick_unfreeze() already injects the sleeptime (otherwise delta would be 0).
> 
> No, it doesn't.
> 
> The delta here is the extra time taken by the loop which hasn't been counted
> as sleep time yet.

I said incorrectly monotonic clock, but timekeeping_inject_sleeptime64() forwards the wall time, by the amount of delta.
Why wouldn't some other cpu update xtime when one cpu is in the loop? And if all cpus enter s2idle, tick_unfreeze()
injects sleeptime. My point is that this extra injection makes wall time wrong, no?

> 
> Thanks,
> Rafael
> 

