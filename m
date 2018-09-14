Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EEAFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F82E20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="JPETZrmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F82E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nextfour.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeINNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:42:16 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:50336
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbeINNmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFXhERenWrGLVV5VlrL8tM+wmOxAcQ0kRhThjSD/wFU=;
 b=JPETZrmxu0iY4dqOZYFJWCbYNSp51IJSmD4IpFlRezBCRLoN4anOCitlhONQe8aXQsHL4rEmzvWZFKPWbPK/EXCnMrDPmIKbivBck/b+V4Ia8w3/VPGjKseiHB6wzAGIxDQf9Uk0ML3XOCplsujFOl7ern7NIrED53qVnQLzkT4=
Received: from [10.10.10.110] (194.157.170.35) by
 AM4PR07MB3330.eurprd07.prod.outlook.com (2603:10a6:205:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.10; Fri, 14 Sep 2018 08:28:47 +0000
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com>
Date:   Fri, 14 Sep 2018 11:28:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9611469.2z7W9akjOQ@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: VI1PR08CA0110.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::12) To AM4PR07MB3330.eurprd07.prod.outlook.com
 (2603:10a6:205:a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e664cc-a42b-442a-f683-08d61a1c1806
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM4PR07MB3330;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;3:VAFhAX0usuBSz1g2KdjOB+NuSA6825ABMg0D9DW7APqA9m4pqMtKWYPKBd3sWxAvXN39xPR1GBX3TYjA/jk2HMjEnkpnavNDICEQiwxC6/nAqLqQbtJykhW78v0BROIyFPEYwho229YOoTEGyFLrtT3uQwDbF5R4lhCz8q4VaGW5hU4F2mVcHhYOMrwEDxUci5JCVZ9Q3tuP5pv4FBxiFQg0oEPsXWD3ZAMIoKxNu5KKKia0MmaFhTDsBB1xN+++;25:IWaGxaf9k4T81Hq6PlrmTIUTCZTTR2NT89My1DkBUwCtGQrM9G/G3pxYtyZQ0sqYRpQ68YIcZ9p/xMxx1y15bJxoQZRPUDls7c2BbPyxTuPvH2cxh4C2+6ssYu3ZE9w26QdtMfuL4mjvdahreXJf2+wEYY6JmGo2jaSqjj+dO5YgUkeBWKl40JaOHJ6irwptmhFR/cU++T8RXQ4nAO1VOn4WVZ61yVK3KuY+4Vf3C81b4rSGaaDlZQy72TVanyUsn7dMYDcaeAaKPbHhvdkjPehiV921c9ew0fHHgi+KRGRJxMcpe2BXIElCqp1gz9EkngA5sQfvRlICqkqFZZXKHQ==;31:faZYDGrjB7Pbv/FRNR8Hf0UhiHj6qP8tRfrJ8PDWtKJt4Y4HnSXnFPcUsFqRNKQI6UIF4a6a5PlrRHwz7W6V0ASQT3PFplQS9C0Rt7dg0Vm9O2AZTl5JmBzc32lfI978bO3akwG/Mon4jiGyitdWFKaQh+3XLR14gmkV5ZKOjSalncXmxm0Qu/VZKtssBtvRU7+bz7T/CjA/O7/OtTosLpezJPVIBf5e7P3PByybgN0=
X-MS-TrafficTypeDiagnostic: AM4PR07MB3330:
X-Microsoft-Antispam-PRVS: <AM4PR07MB333065ABE0F831191F89D25483190@AM4PR07MB3330.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699050)(76991041);SRVR:AM4PR07MB3330;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB3330;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;4:Ge1y931UlR4Urru8ixjf3RzQrwrSDYUX++zDLGAgGp5HFvkK5+go/66JnutL2rAI4jELhIGdl+rJ0fRHCxFjyhfAruDCVYwZ4HCHhug/PuNJ9HBxSO3rtM19Z4VDmwwF/E+NMUKdO0LlAfAyKfyVkeRm1XiOQYHVJT4in8nQBeZsfIUxQXZnfzy89DZaK3vVY6Zckfy+euOy3FO8MO305JqQagM08nJPCAkRojDLPMyAsEm1F19//wHvLgxx/ABlRLQbBQunX6BnaJxJkIvzS+iTxgTEjLcFeR8YE4efCS8yrCBDqOv+adMp2fKQ2ila
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39830400003)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(110136005)(31686004)(4326008)(316002)(81166006)(16576012)(58126008)(81156014)(15650500001)(54906003)(105586002)(106356001)(229853002)(7736002)(6246003)(8936002)(508600001)(6346003)(305945005)(50466002)(26005)(77096007)(6486002)(14444005)(97736004)(5660300001)(16526019)(68736007)(966005)(65826007)(6666003)(6306002)(65956001)(66066001)(31696002)(53936002)(86362001)(6116002)(3846002)(25786009)(2906002)(52146003)(446003)(36756003)(65806001)(230700001)(47776003)(76176011)(2486003)(386003)(2616005)(23676004)(64126003)(53546011)(11346002)(52116002)(956004)(8676002)(486006)(186003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR07MB3330;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3TUIzMzMwOzIzOmo3Ry8rL1A3RkJKK1phRDFjUEhvRUN5R1h2?=
 =?utf-8?B?S2kzY2p6VVl2QVNYdUNoTFJwbmljOHVlRWRwSFRUNm0vcnJmaHJxVXN3cEdM?=
 =?utf-8?B?Z1JDYXgrYlpmYVVWZU9IeUhGWEtkamk2aEpoSlM3Q1lGUVlydlNwRXpJYmNL?=
 =?utf-8?B?OUQ0VFF2Ri8wZTVQdVNkU0lta1o3SUdVc1BjaDR0VmNjUXV0VHMxQzd5WjRN?=
 =?utf-8?B?eHRYbGJtYlEzMlR6MzJlZTkvaS9hWDNPMS9CWGtOb0d5QVIxSDdHNE8vU2VG?=
 =?utf-8?B?ZGkvWUpoZUdVR093WmpUaFdlMEQ0cGFnbEhHc0NpM05qajUxRndVVVoyOFN3?=
 =?utf-8?B?K0dzQkkvdzZlV1ZDV2VWbTlsTDk2NmlRU2J5N3pHZVNLeDJPaDZZQStmMWdR?=
 =?utf-8?B?eDlRenRiaDcxbmZIRlhVVHJTbHJxR0pIUFhjRUQ3alRNWGZzQXRZRmU3WGRH?=
 =?utf-8?B?OHpBcnBnWGplaEYwL0lHZ0lCbVhteVhzcFM2azNxcThMcVhlV0FhWkErdGls?=
 =?utf-8?B?S2Y5MU1aS0I3MC92eFRxZk1KZXAwcDdoVFV5MXN2YmlCSEIvekpYeWgrZnlx?=
 =?utf-8?B?TUcyZWdaMWkwcFQ5TElFcktEYUxXaXB4TXQyQitTL2M3YmpHbWdkVVR3OEJS?=
 =?utf-8?B?V1dwOG9YZGNtTEdBVUtNVnhQcXArVDlxSWhJcWVxT0NoOEg2b0ZyNzVJNC9Q?=
 =?utf-8?B?alhvZG1EQkdZOWw1Q1lYTGtVbVBVVGNtM09SOHZxUnFTeUd2VEQwWEtRMDZy?=
 =?utf-8?B?bW4vT1FoaFdiSFNNalU3eVVVRFpiV0o0b1FCZldPTUtrTzZqK2FDWkFqWFQ0?=
 =?utf-8?B?T1k3Nkh1RUZvSUgzbEtXalBBUE9yZG4zUlRWN1k3VWRVMzMzblA3Z1J5SWFZ?=
 =?utf-8?B?U1lLaWZneTBIYVJlOUhkNWgrTWQxeEtHai83dnFWbHdiSysvTVV4UmR2Umdn?=
 =?utf-8?B?STNROGs4dUtITkFyMlNONXJWY1ZqZzY4L3B2MXZlMmtzbENxNkFsdEhqUVNa?=
 =?utf-8?B?REhvYk1pV3g2UStib1lDRXRwUzFZL1hFNGdrZlR0ZjBzYzM0Zk9EdGhjcGd1?=
 =?utf-8?B?dElBSEtBdWRsd0tzNmtNZ1lQN1lZa00zZERZVnUxQ3FYYUpPanNoZ2F1TXVK?=
 =?utf-8?B?Sk11TmFPVzBmcjNRMmptM2E2NXlFQkNuQzJnYlZLeUpOOWV0QkJURVZWT1M4?=
 =?utf-8?B?amg2YjN4NmE4MTVZYmFzb2RNTHUzTGJRQUdBdmNtdEtuK2o2Q0dQNzB3RDFj?=
 =?utf-8?B?dVpCRTlDbTJ6cm9nY01TbTZJL2h0V3pxRVJ1aVgyRW5YOEZPLzF5L2Q5Q1dY?=
 =?utf-8?B?ZzZBTTE5STlMalNSOUNzUEZwRDlSTzViSDhHV28zYTd0NmtIZG9DL0o4bHJ1?=
 =?utf-8?B?Y1pwNlQ2TFpscU5xR3VYankzV0NlME44eVUySUgraDlJa0RLRlFUWlVoUUUw?=
 =?utf-8?B?OGhHNlp1cjhpNmJzajVYNUsyQUFSTVIvdTk5S1crc0dvNnNybjJKS3VLaGdQ?=
 =?utf-8?B?MGFuWmxBQWh4ZndXWFphRkN1aXhiMUJJTTVoUW1uU24ybEFDVkxtdHhQWFVJ?=
 =?utf-8?B?ZFVDUGordjdxaWFDNXFLVDR6amdBbEVZVllHbTFPTVRpS1pSanZXWVZXa0wx?=
 =?utf-8?B?M2QrRjhtR0Z1N3dPVlhWZ1N3cng4MWNXY3pQQkRpdS9ncFh6NDdTV0RQbUVT?=
 =?utf-8?B?cnFXaThVR3ZvdjVyZHFTK2dVbk5sNnZhZEx0TGFkcSt6ZmF0bVcvTTNOS3JY?=
 =?utf-8?B?YTlHOFJKQ2luaTFudWY4Tml3cjZoMGxhUUxCUXFTbGJwTWh4MStJVEsxakk3?=
 =?utf-8?B?aUFWZDhsb3lvaHg0ajRxRi96aThGamY1eUFUd2lJRDQ2c0Q4Wi9mRHZYT1d0?=
 =?utf-8?B?am5GSlJZN0VZOUdYRThsaUdJNVpuODBSVzFkc2FhbkwrMUZYTVBIZUhrNUJp?=
 =?utf-8?B?MlJ0VTMzNXRLTEM3ZkVhWDNHaFpxZEFFS3pVRjBmL0tLS0ttM2NZN1VTeHFS?=
 =?utf-8?B?ek5Nd0Z4aVlLNGRlelBsRXl1Uk42YUdaOW9xZVArcVlLQ2JZd2VZaHhsSFEx?=
 =?utf-8?Q?uBkTvQ8vSkJLgznuXegtts15T?=
X-Microsoft-Antispam-Message-Info: E+FvWCWQnouKyYEy93AJpDuligxcYrGtZXJjCL5vp+ikL43faUL+92F+wmRl20D31gkccUYTAx8aCDG86C07GpDmNzlIDK43UwuxL6Mp6er6PncOIGjzCqYKh3ZPBynBackIp2uda3XAbivfcywSHcNEhPS3Qdf3sOQUMcxA2SpYZpY2bVZBamJSi+XfATbB/DTFiwhc+dP/j+4IiOX2SNVW0tcklgRRnjYa3ugn5EiBaAqnYOfZy5+4nfQoLI53VsuJYfuwG9VibhaWCJMSKkHEZg0WGyw1te2lisaSvkWeugaXN9Q/gaO/XPvdvmcT+lheSO7KOFHwRCXUQRdP+/wx6bowAPaQOx4nBzVRQOg=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB3330;6:lOK2Sk1+Sv0r8Q1HwsGniofiPHuJ31rgZxCT2yYPQDZ4o2hXuYGk9Au2cMx5hlwQXcJJFyGNWWge2KnwoWkQCbD/NWWRxrPTzpwMxYSWvGzyVEXqx53goAi3x3dBvgxwiv8576ITkp2TvtcUXQLtLq+S2H9J9XvyNZuWtugs0zyk2CDByw3s8XwkUeAdl0A1D2c+U6bEHxOMs0ZXmDOimJNCVRxEf6jDSofhwIuJ2oIEtyQj1hcNnmbdmJHpnJF3pn5Cy3hl75M3bFfGYNSi4HN3iukhTm9hK7QRlimrqk35mSlnrbKQQwnK9uy0enHdYBVzrjUYuuiL8gVQl9JsvryOcnPB/LSUzlJPgYQlEMjRBBi+fruWhWR3e48MIpg2H8YZS0fv9F+OK53J+1D5lE6Ocqn6Z+jFQCI6oOTjygg374X+tXWLOqS5ntTEIBbLEdlsNPvawah8phhZ9wadyA==;5:o3/3u60Tv3nyRnwUbpfzRcis2tMYNEPKLSEooRc6zzedxzhdJbnuXeygqBafPiCyazhvTM+Rh9nGvxxHW2RNrMAIeTvlzAYLLmqqswa7QJtwDUWE9ivOwqw0dns7Uij1+PJ5yCFpTy1L4LJSJsiVMAMsE4Ojq790mf+4ODs/dm4=;7:yyXcxReMbPEM7dgXl5V+Hn12HgqQFH3Iv6x105jff3qtvi7bjewVppphg6kAe3BqJXvcz/42jTLKdKCIKjS9nffK4tuAF8Qn/+F/aEExIoBbT36wTpBz3u0nOkHVbW5sSYi/DSDy5TfnXwGV5vDXKhDC0hQUU4490/szQB32sJSQARUT5e57Cz0ySYMpy5KTuvsO4Ud1qEBgsh9fKSYMaInoIwWzRhEqzwlVIidjzLiiE+CpAPql2LLlo4sutNIX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 08:28:47.2862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e664cc-a42b-442a-f683-08d61a1c1806
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


On 09/14/2018 09:59 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a difference in behavior between suspend-to-idle and
> suspend-to-RAM in the timekeeping handling that leads to functional
> issues.  Namely, every iteration of the loop in s2idle_loop()
> increases the monotinic clock somewhat, even if timekeeping_suspend()
> and timekeeping_resume() are invoked from s2idle_enter(), and if
> many of them are carried out in a row, the monotonic clock can grow
> significantly while the system is regarded as suspended, which
> doesn't happen during suspend-to-RAM and so it is unexpected and
> leads to confusion and misbehavior in user space (similar to what
> ensued when we tried to combine the boottime and monotonic clocks).
> 
> To avoid that, count all iterations of the loop in s2idle_loop()
> as "sleep time" and adjust the clock for that on exit from
> suspend-to-idle.
> 
> [That also covers systems on which timekeeping is not suspended
>  by by s2idle_enter().]
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a replacement for https://patchwork.kernel.org/patch/10599209/
> 
> I decided to count the entire loop in s2idle_loop() as "sleep time" as the
> patch is then simpler and it also covers systems where timekeeping is not
> suspended in the final step of suspend-to-idle.
> 
> I dropped the "Fixes:" tag, because the monotonic clock delta problem
> has been present on the latter since the very introduction of "freeze"
> (as suspend-to-idle was referred to previously) and so this doesn't fix
> any particular later commits.
> 
> ---
>  kernel/power/suspend.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -109,8 +109,12 @@ static void s2idle_enter(void)
>  
>  static void s2idle_loop(void)
>  {
> +	ktime_t start, delta;
> +
>  	pm_pr_dbg("suspend-to-idle\n");
>  
> +	start = ktime_get();
> +
>  	for (;;) {
>  		int error;
>  
> @@ -150,6 +154,20 @@ static void s2idle_loop(void)
>  		pm_wakeup_clear(false);
>  	}
>  
> +	/*
> +	 * If the monotonic clock difference between the start of the loop and
> +	 * this point is too large, user space may get confused about whether or
> +	 * not the system has been suspended and tasks may get killed by
> +	 * watchdogs etc., so count the loop as "sleep time" to compensate for
> +	 * that.
> +	 */
> +	delta = ktime_sub(ktime_get(), start);
> +	if (ktime_to_ns(delta) > 0) {
> +		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
> +
> +		timekeeping_inject_sleeptime64(&timespec64_delta);
> +	}

But doesn't injecting sleep time here make monotonic clock too large by the amount of sleeptime? 
tick_freeze() / tick_unfreeze() already injects the sleeptime (otherwise delta would be 0).

> +
>  	pm_pr_dbg("resume from suspend-to-idle\n");
>  }
>  
> 

