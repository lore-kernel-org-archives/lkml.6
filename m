Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA00FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B0320890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZXE4RGxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B0320890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeG3Rpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:45:41 -0400
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:65128
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726812AbeG3Rpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFCeeEpYPQgrSD1LfVD85hbRLOCImuOueywDX0t0nRQ=;
 b=ZXE4RGxHDYVMbAU8pk+sjMa9SnruJwvl73svHmNkPQjWXMae2j90soacszIKqwQPMzHc7qUJfQP1k3go1zVBlQy1dviffWK2+6rmvjR/ecIPARUVFwEG+BzzMkDE+pYWvrgC/3tequUh+mzzOvzsipxRUzlDrNe/bMDPBP8lWjs=
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Mon, 30 Jul 2018 16:09:52 +0000
Subject: Re: [tip:locking/urgent] i2c/mux, locking/core: Annotate the nested
 rt_mutex usage
To:     tglx@linutronix.de, jsperbeck@google.com,
        linux-kernel@vger.kernel.org, wsa@the-dreams.de, mingo@kernel.org,
        dave@stgolabs.net, dpf@google.com, pombredanne@nexb.com,
        deepadinamani@google.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
References: <20180720083914.1950-3-peda@axentia.se>
 <tip-7b94ea50514d1a0dc94f02723b603c27bc0ea597@git.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0bb2d26f-3d1a-fcb8-8fc4-9123a2d5a30d@axentia.se>
Date:   Mon, 30 Jul 2018 18:09:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <tip-7b94ea50514d1a0dc94f02723b603c27bc0ea597@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15)
 To HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4782b550-eca7-4d91-cef9-08d5f636e231
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:Kjeh6P2keI/YGUbmNSWiaxIrPZoHVawCGhdLWdJPBKJxuhwHJ0R2i5Y6e6krPfqwdqfMnEL/XVUqFoDNznSMLKYvmB8TYw2jq9cOTChKWHtPGdOgY58fS63sf+bUDNOoho+0olst6y8iBz3qMkB1hMltdJEhabbQSVIhO3oMzxz8NH1Y5zwAxMSWwgko7nR1F1rmtwl/FZk4oxFc8Y4s/U1eVFSBI4fwJf071u4PeZR07lN9XnndenqqNF4VBx9Q;25:P9UGmn6AQ6eQhgGfzcPDJW6P4QtwH+PPIYSFZwKZqrQpNRbHM3e/6p6ASKRwZKEg5J0zHwXtR8gnoz4GD1AR/R8kKQtudQMavjQgjoMZ+uEisWZGsBrepmflS/eZlEZWe3hkRNVTlX6xvWpznGWlnfgzBMslZOS0x91ZekLyaCKnR1PjaX0n/+rKlOiAHvaVlEicOtCHj4sKdZvHgO9RdGnPnhV9f6l7ru4yl1cTnJMLXR9tO29W+Qo7YzriwVF7wi/dYwKIgAA7twcgJyw9mR9SRTTvb9OwkztQznRYRQ9i5ruvSA9SGAWKRa7fW/gpF3azaXUq2zIWkHh8KrTqTg==;31:kNp7gK9FQ9MjexnatsUbXjppfR1fMjP+9YXbe+KCCKbm4fDapytSEY8stfklVZJ5stqnzQkBMTePl9q1Xb2TY2ciz56CLVIrXJ/DsPdsfRNoDuua+7w6VqmbWWeaiZr7r3Ip/uSipPzHTPxCBsl1o/ObRigyrbr6Z0cIcDEX3U1abGpxiqZzpBqy8pzAYiPyt4g67A59Qmumw2yNvriydT8i08yb5IIPUoX0DnVpiCo=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245863E25F6DFC60802726F5BC2F0@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(166708455590820)(211936372134217)(42068640409301)(84791874153150)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:roh4SuHB5Dg4j+eae9WY1J2/q7+BHYU0EYMEFCyOWNI7RM0Z9S+kyII5JGJ2ylprf4B+tp+w3pS/RePmMeBMF2grS0Hq9xL7BnojMgYULUxWMC7/irW3/xw3SGjR9Y12uE7fk77IoCQFDyFwHwFM3/mn5PdUdYZUb7jT4WNcTKHKaA2RP2WiIqLn7EzajFDY/DguqB6xgc3dTmiVK2iFo9AqxuQY9tewjOqwHTxCcz+JGhp/NflE6C8iOyakZ5cwRq7L7fj0gixk8GEk/zutKGf0UsTuqx4pfdy2KA19vLG/Say0oyoHOto9rMp5GVfcpA8yUyQBsH2ZX6p+bBzujNURLqmgnoZB95xOfHpa5tF3MnwOkuVaC55SBWuGiCACFUArcqh/hTLtwSeBUHXBDCaM5hVUiPI98FRrKjU3bvJO6K7a1lg3TQopwKFUk5A4pC2avrdBDoyYa48nuOQK+NE2U6qOr7aKAgoS11lhjOE=
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(376002)(346002)(39830400003)(366004)(396003)(52314003)(189003)(199004)(65826007)(5660300001)(2616005)(7416002)(36756003)(3846002)(6116002)(6246003)(6666003)(74482002)(31686004)(58126008)(16576012)(316002)(8676002)(8936002)(81166006)(230700001)(64126003)(81156014)(229853002)(2906002)(47776003)(53936002)(305945005)(25786009)(3260700006)(7736002)(68736007)(66066001)(65956001)(65806001)(6306002)(50466002)(97736004)(6486002)(53546011)(478600001)(386003)(117156002)(11346002)(14444005)(218543002)(956004)(966005)(106356001)(16526019)(77096007)(446003)(36916002)(2486003)(26005)(476003)(52146003)(186003)(23676004)(486006)(52116002)(31696002)(575784001)(86362001)(105586002)(76176011)(921003)(1121003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6UnZLNTBTNkNxYUMzd3RIeWZWZmdpeW1o?=
 =?utf-8?B?b2lrbUtiSXFxdFFBaVk5ZEd5UnltbXJlQ2JLWE9FaU5xaE4wS0VPTWNkS2lo?=
 =?utf-8?B?a2FwSTgrNzVVTlpyZ3BwYmVRSWRlT3h5UVpFalY4d1hzTXgybytwa1RVRWhp?=
 =?utf-8?B?RTFJdWttei9lQWFqSXpYc25CSU8vSWVObVprN0pUcXNIK1pqUEdsSHlYd01y?=
 =?utf-8?B?MkdYbXdVcVpxK0J6MlAya0dXNDVuNDBCbGVac0k5UExQNDdGRTVINVF5NEFk?=
 =?utf-8?B?eWFTVjlOaVhOZjBHS1RkaDMvZVpMNlJVL0h5aVJHa0pIOWRvY1V6RnowbFl3?=
 =?utf-8?B?Q3RHc29vWVNRV3F6RFVycWpiSGUzTzF3YlUzc2tyYUlXSjY4dVNBdkVYWGdp?=
 =?utf-8?B?RW9UdXV0QnFqK21Oc3N6WldsVkpwL2hnTXdOQ3J6bTBhaHMwdWZ4RGlCZ25E?=
 =?utf-8?B?Z3FaeDZxMC95S1kvMDZNSWJlRkJMTHNQbzJJczdUUG1Md1M4QnJMYWtnbW1l?=
 =?utf-8?B?VnFxaU8wbURnTnY2b1RSVXFwcyt4elBkVVlBVll0bmlrOXpVclQ3NTE3K0ZP?=
 =?utf-8?B?R0gxbDdNQlplWERHRXVmS1NoZ0tjMzJ3MXZJbXFVOXdtZmM4Z3lUdWpuT09x?=
 =?utf-8?B?K3NsZFUwLzZ5aFVob0c3OVoyeUx5TnFOeW41bnJNdmFsMElob0hsek1JTGMr?=
 =?utf-8?B?cTBRU1FSSk1nSHhoSFo3dUtHclpDMEU1MkxLUHFyMmE3SFBpTVIwVlorNTBQ?=
 =?utf-8?B?Wm1OMGVJYXZ5dnlnZFZqdndmRFpnZEhDM1Vtc0JBN3dvUGF4bEdnMmpVTWVj?=
 =?utf-8?B?cmtWVzVxb1lCajZQOE5WZXpjeVQ2aGxDSlZFeG9NbjFQdU9UTHptZ0tPYTlK?=
 =?utf-8?B?VFpBYTQxdjJ5cGdvcWRtMmxnL3pWSjQ3Qk9FSVJiNXhUQXd2Y3JZWFk2RGo4?=
 =?utf-8?B?NU9NV2VMVnpHMk0zZHQ4Ylc4UmNSNUMwbGtYZFZqaUNXU2g3ZW9aYnBRTDNw?=
 =?utf-8?B?TFVsS3ovTU01MGZmeWp3YTZINktIRkVHalIxb291VnJ3VjJ2aE4vMm5GcTFJ?=
 =?utf-8?B?WFpIckVJU3M4eHFPU0REYzg2UzgyTmxReC80dW1XbVRPc1BsNkpJWGlsbmNB?=
 =?utf-8?B?djZ4bFdyc25xbW1aSG1DNXNvaVZyNHRSSTNydDRsL0VTckNESGVSUHQ4TEVS?=
 =?utf-8?B?ZGdlTkpkaHQ0eVNTY2pOSnptM3Y3YW1JL21uWUo5VHZqMVhPOVk4Vm5TZ3g2?=
 =?utf-8?B?Tmg1UjdUWTlNeVFZVEdYZ09JZGlkZXJnQTVuSjVCdW5aSVpRUHhiL05xQWdi?=
 =?utf-8?B?cVNsUU9ENGNpRE5mLyt3ZUdSYUs4bmdHazAzc005N0RCTytDTHI1eFZZeWN0?=
 =?utf-8?B?N2tuMVZmSTFwUk9JcVNpUFNQclgvYkNDYU1rSWY3TUFOZTZsQ0hlV3M1MWFv?=
 =?utf-8?B?aGZTTk55a0R3UGEvM0tGVXJvZjVFNjVtczBuUEk0bGxhN0t5UVoyaVJZVkYx?=
 =?utf-8?B?OERVU1B1emJtaC9uN3FlaFJGNHFyR1RXeTVWYkZBbVRxTGdybkZpd0dTR29y?=
 =?utf-8?B?bkMrRlRNeHVqR1B5N3ZGRUZsSy8xdDJvamttMy90eXpEczZDakI2M0xQelRw?=
 =?utf-8?B?MkN5Q0NaRkREK3RaRS95bG4rUy85dmtFVnVtK3dDS04xNkNDcjcyMWhvSS9K?=
 =?utf-8?B?M2hkWDhHOXZSempSZStZTkNIZTIzNVNOQ1hkd283TnFZQ2NaazM2UU85OW9o?=
 =?utf-8?B?YmdKdGsydHlvV3Z5aHk0L3k3K3JOSUhEYmh0WXVzYmhlS0tXK1VhL3F0eWxh?=
 =?utf-8?B?ZGdNTjdlcGUzQjVpM0NxUE4yOUV3TW9neWRHOTlOcTFVK0hTRllYS3B4UVBn?=
 =?utf-8?B?cTJ5cWFHVWJpdlRVZ3lzVHhzN0pKMkcvRTNKcnRWa0JuNmpIZnhoeFViWmpm?=
 =?utf-8?B?bHJXandCUXJ3L2VtTG51UXpLenBVQVJNaXRucG53SFBjVTVrakJBZ2Q3U2Jh?=
 =?utf-8?B?SzlFMEFiRHFYRnBzS3lyVXE2ZHJIc2ZwNXI4eFpIMktCSXV6azFVTFY5L3dy?=
 =?utf-8?B?eEpJSm1lajgzZ0piWEVGVk03K3hBa2xhTFJpd0p6YzIyUjR2VUNWRlM0bzJV?=
 =?utf-8?B?d2c4NzQ2Uk4zcjBSb1pRb1hmVTdZU0VUVDJjLzYwVU9DSjcyelErb0kvWU5j?=
 =?utf-8?B?VzdkWGI5K1c4U1NOWEJ1QVh5bTQvcGtnb2ZtaTBUZjdDWVRaRjNIR3FlT1RY?=
 =?utf-8?Q?711U58XrEFid9qfYVGh9?=
X-Microsoft-Antispam-Message-Info: 6Iq21rpsaKMIyCt/8109qaDrzzL1mVknEUoEfE9hT4/GxQICjuvKCE712u7phGdiyBkj7eTdwSc9MRJLf9pKerzxtUHFzJlwWp9pQ2TIlkjV3wcX5soVAtZFLbUGNbhGi6dADjqXVHMmz4w2lYw1X8KxJ8iVD/R8Parj2UIK6SvMnFJfmonztvWQJ8ZgVE+9hx8aR7BOJRuK4pm2vg+GfGjGq9xbvgV2mq4lFSsFtW4QI0e4OR5vAa9RgloMwU910surgd77LdRqimv1AOEOc0VK4mCSEg/tscqphsqOtg8vjvBl3J4D8QrBstMNOXF4GX18nP3bSSEvkVAB1huh7HvPwOQWscLIkULyDu6kv28=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:ye57jl4sQru9GBBpajo/+NtAzIDdr1o40ZdrQVVWo1axBlk+1OxW8XWfxyVFabXJJ0bdbt1KHN5+Oi6Bu+bI9OOYBXASd770b7voAQLW2Og2ctW2mhRJMDAINBRPUk0dT9n6fJyT5wC9hWhfrqwBq3p6lRKzWS6nu0QLc79FgSdsAm4YTqcmwKXpi2odP5mk3e/6viGOHL9aejjw36dpDFWoMUnDAkhhTd0b1afAqq+39ik6y7k0y/Pzl+bgzGC+REoepWEJmqdiBobvPvHSqlWPzzq36UWJQDGO4gvJVoLCsqis5pPjjRbSK1bwqkjkZtfrZxc0HJC4jvpY2IvQPkJKWvaha5qz8PtwsyRxjyPhfltn6oIisAGSVp+fbip6osz7H96rjZvES1b0bk8SVZC+DW6mogOVzgYDeUZJiY5CQhF+04eyHmJD146Me9WEI4E2TKM7u8ljqzkCCWIjTw==;5:QuZi1FRLxopTmK/DyeC7OxgzqkHIWpottw1ptvof0zGJG3RZ9s/xrY47/sxuK2WURI21yC6MUkordx2CR3PR5qviqGNnrW9Ct2nriLt2GlvfacUywI5m0axvn/o11wq0TUwJfHCGWrHyZ9g2BA0TrEes1xgRZaK732zNB823LdU=;7:4Yjlq8GwGdLhn/oqzJ/BGT68d2WCXn7S1uuS9MuyK2oJ7OUw4jbYnJAZScKneH6b5tOfv7J6FuZI/nDbmCSFV0TJsrho0Pw5T4I3JHbhYuN7rVQLoNEKERQThJ8rGj2cd5KYCoLl5yLxLQjC5KgxcnGiLGgL0cNU5C6Rf1GL9Ed+dm6vXtt7+JlOaoo+zQFqCKXl2m9sVW5rffS1BROtn3g3Jeel7Fimiu4jjMoPphIKJ61BH451xnaEWwPd0nx5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 16:09:52.1687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4782b550-eca7-4d91-cef9-08d5f636e231
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-25 16:19, tip-bot for Peter Rosin wrote:
> Commit-ID:  7b94ea50514d1a0dc94f02723b603c27bc0ea597
> Gitweb:     https://git.kernel.org/tip/7b94ea50514d1a0dc94f02723b603c27bc0ea597
> Author:     Peter Rosin <peda@axentia.se>
> AuthorDate: Fri, 20 Jul 2018 10:39:14 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 25 Jul 2018 11:22:20 +0200
> 
> i2c/mux, locking/core: Annotate the nested rt_mutex usage

Hi!

I'm a bit curious as to why the subject line was changed on this patch?

(it was "[PATCH v4 2/2] i2c: mux: annotate the nested rt_mutex usage")

I thought the subject as I wrote it was just perfect. Was it so bad that it
had to be edited?

The patch has no impact on "locking/core" so where is that coming from?
The "i2c/mux" prefix is not in tune with the tradition of previous commits
to drivers/i2c/i2c-mux.c ...

    i2c: mux: improve error message for failed symlink
    i2c: mux: only print failure message on error
    i2c: mux: provide more info on failure in i2c_mux_add_adapter
    i2c: add missing of_node_put in i2c_mux_del_adapters
    i2c: move locking operations to their own struct
    Merge branch 'i2c-mux-dt-3' of https://github.com/peda-r/i2c-mux into i2c/for-4.9
    i2c: mux: add support for 'i2c-mux', 'i2c-arb' and 'i2c-gate' DT subnodes
    i2c: add i2c_trylock_bus wrapper, use it
    i2c: mux: relax locking of the top i2c adapter during mux-locked muxing
    i2c: muxes always lock the parent adapter
    i2c: mux: drop old unused i2c-mux api
    i2c: mux: add common data for every i2c-mux instance
    i2c: i2c-mux: sort includes
    i2c: add ACPI support for I2C mux ports
    i2c: mux: Use __i2c_transfer() instead of calling parent's master_xfer()
    i2c: use parent adapter quirks in mux
    i2c: mux: use proper dev when removing "channel-X" symlinks
    i2c: mux: create "channel-n" symlinks for child segments in the mux device
    i2c: mux: create symlink to actual mux device
    ...

... and my subject followed the canonical subject format as described in
section 14 of Documentation/process/submitting-patches.rst ...

    Subject: [PATCH 001/123] subsystem: summary phrase

... I.e. I don't see why you insist on starting the summary phrase of the
subject with a capitalized "Annotate". As I have understood it, the summary
phrase is not a sentence (or it should end with a period).

Three "bad" decisions on one line is a bit much, I think. I don't care deeply,
though (but apparently it bugs me enough to write this, and the reason for that
is probably that one will get abundant feedback on such syntax during review
that it is a pest to then have all that hard-learned "experience" eradicated
on what seems like a whim). Anyway, as I said, the change sparked my curiosity...

And I want *answers* :-)

Cheers,
Peter

> 
> If an i2c topology has instances of nested muxes, then a lockdep splat
> is produced when when i2c_parent_lock_bus() is called.  Here is an
> example:
> 
>   ============================================
>   WARNING: possible recursive locking detected
>   --------------------------------------------
>   insmod/68159 is trying to acquire lock:
>     (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
>   but task is already holding lock:
>     (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
>   other info that might help us debug this:
>     Possible unsafe locking scenario:
> 
>           CPU0
>           ----
>      lock(i2c_register_adapter#2);
>      lock(i2c_register_adapter#2);
> 
>     *** DEADLOCK ***
> 
>     May be due to missing lock nesting notation
> 
>   1 lock held by insmod/68159:
>     #0:  (i2c_register_adapter#2){+.+.}, at: i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
> 
>   stack backtrace:
>   CPU: 13 PID: 68159 Comm: insmod Tainted: G           O
>   Call Trace:
>     dump_stack+0x67/0x98
>     __lock_acquire+0x162e/0x1780
>     lock_acquire+0xba/0x200
>     rt_mutex_lock+0x44/0x60
>     i2c_parent_lock_bus+0x32/0x50 [i2c_mux]
>     i2c_parent_lock_bus+0x3e/0x50 [i2c_mux]
>     i2c_smbus_xfer+0xf0/0x700
>     i2c_smbus_read_byte+0x42/0x70
>     my2c_init+0xa2/0x1000 [my2c]
>     do_one_initcall+0x51/0x192
>     do_init_module+0x62/0x216
>     load_module+0x20f9/0x2b50
>     SYSC_init_module+0x19a/0x1c0
>     SyS_init_module+0xe/0x10
>     do_syscall_64+0x6c/0x1a0
>     entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> Reported-by: John Sperbeck <jsperbeck@google.com>
> Tested-by: John Sperbeck <jsperbeck@google.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Deepa Dinamani <deepadinamani@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Chang <dpf@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Link: http://lkml.kernel.org/r/20180720083914.1950-3-peda@axentia.se
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/i2c/i2c-core-base.c | 2 +-
>  drivers/i2c/i2c-mux.c       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 301285c54603..15c95aaa484c 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -624,7 +624,7 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
>  static void i2c_adapter_lock_bus(struct i2c_adapter *adapter,
>  				 unsigned int flags)
>  {
> -	rt_mutex_lock(&adapter->bus_lock);
> +	rt_mutex_lock_nested(&adapter->bus_lock, i2c_adapter_depth(adapter));
>  }
>  
>  /**
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 300ab4b672e4..29646aa6132e 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -144,7 +144,7 @@ static void i2c_mux_lock_bus(struct i2c_adapter *adapter, unsigned int flags)
>  	struct i2c_mux_priv *priv = adapter->algo_data;
>  	struct i2c_adapter *parent = priv->muxc->parent;
>  
> -	rt_mutex_lock(&parent->mux_lock);
> +	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
>  	if (!(flags & I2C_LOCK_ROOT_ADAPTER))
>  		return;
>  	i2c_lock_bus(parent, flags);
> @@ -181,7 +181,7 @@ static void i2c_parent_lock_bus(struct i2c_adapter *adapter,
>  	struct i2c_mux_priv *priv = adapter->algo_data;
>  	struct i2c_adapter *parent = priv->muxc->parent;
>  
> -	rt_mutex_lock(&parent->mux_lock);
> +	rt_mutex_lock_nested(&parent->mux_lock, i2c_adapter_depth(adapter));
>  	i2c_lock_bus(parent, flags);
>  }
>  
> 

