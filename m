Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CD20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NzwnUuGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6CD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIDOek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:34:40 -0400
Received: from mail-he1eur01on0123.outbound.protection.outlook.com ([104.47.0.123]:53480
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbeIDOej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+XATW4KvItEiSMxPzy0B/9q1yXzzdz8/eWkfNhzqBg=;
 b=NzwnUuGUE60i6UVNuoXOwABc6IwPvn1ftmRRqrJK8QpeohGY1nUFqO7f1wNl0JUcM2eAc9yLggQtJ16RRqmKRshR7nQNrCwcFEFgVFmZFwIdZVq5gKoBQE0G9VWYU/qdUUThbmxkagsaEHQrAZ26B3YYNFfMRAiSXlFI/Pw3GUw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3253.eurprd08.prod.outlook.com (2603:10a6:209:47::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 10:10:07 +0000
Subject: Re: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
To:     Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, glider@google.com,
        dvyukov@google.com, Jason@zx2c4.com, robh@kernel.org,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <dff9a2f3-7db5-9e60-072a-312b6cfbe0f0@virtuozzo.com>
 <ad334e64-28d1-4b91-aeba-8352934a9c46@lge.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6954711c-6441-04df-62a9-a83c867e06ad@virtuozzo.com>
Date:   Tue, 4 Sep 2018 13:10:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ad334e64-28d1-4b91-aeba-8352934a9c46@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0361.eurprd05.prod.outlook.com
 (2603:10a6:7:94::20) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90eacc20-6bbf-4b5e-90a8-08d6124e9822
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:zCg9qsfVR/rV08WpE0ZDETv12VuaPEnfmDlW/C2f+ZjbrAPs/4r5EA7eWG/eM0Hv87iqLpuGZe8wZc14oE9p108KLHYEUk4VGzR3P9ZrghKdttijvAb8BROqAvX0QyOqUN6LjFJp0xA221yWe2ibLo+BMDZbo4EIjMwV+tcUem58d6VQ3MR6FLZtE4WEQJXuiMx78qrXT5ZShmukVAft6csp/aXNlwGWFY62sV6m7xWh0oDZBisniYRs50vlMaV+;25:lsEC11MilRgS2O+sPd6lQWPGqF/HaI1t23fbM0ToUp3IENf6PKRou4ef42eVNJxUhVm9WWonYcAxuvohl6CM2yJbEDivwHOOnEwHFBICdceK0rMSRTffHnUdhUG2XpRQdFeb4fjLZOMjDqrpFnttH+/+o7nTJF7xS0XAu8x+I7WrWJqW4jObvQ6P/LAL9aXs6oDCf9JIfuci/lXXuumCXtpfoj/L61s9+v+qtZ3sdO7jOzX/Unv8BDr/uj6sku3CoN6giQUCYb3o1gvRCKJk0fPtSf3PYSAMnxP/DsU4FEu5m5K7GeHgJWYcSTdo7rF4pFQ/ch6Z+DREcnLM62wpYQ==;31:9BltP4YChKmTVC1dK98rKDViIN4JU1K7QrGQ+5busvk7uoKDuWaRCY29JNFeBr7PsLJh1nwbEVCmCo+NLGI1mw72X8WIECT08BZQc2iobHp7D9kBm7EauCw5ZSzngwlUrGPZtHmgDKwBadDhBSa2d5A2oo5vqqlfW46AmBFpnAoUz7SzjvUob7gWuNQb1bgdPjKzxD5V7U449Da1KiFqUSEY7XUUjQBcbmM1ioOJX2Q=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:vs1OpUMCHpIGydQSyE9r+KYEg+DsX/RdGkR9DoZ1Z56DouxsUkiza7DERVme7WEsevUFJ1VtrQC8l3bvOGmft+z+tcbNep5jFtWc2UwHsShLK3XomAE/w+IAhn1FYBK5gpU9Ym3lQdlXNWsVGRgPoBm6Vcl1iHwO+egrFpOQhXTa2XiptretklUx7BNb/EwWOqX7S78mLq6mPnlDuQdTg3mhBaDNcJVnEvEOrI9tCbBttEthk/6/dVHlHfQxUlgmtEWBP7uY2k635kvRVbeWZ7POQOLFeegF6pLM2Y5Vd5d70I3GbJZHYMFXIy69idMzPXCtHYZQ4oz9GxoLAA+9kg/DXnedBZJ3lQodmo9J44eriO9Qf6WQC98S+ZdCpNyp5p54dGnNrZ3bVRyYxxPsvSM8CXZGDZolli4YYFy3Dlk0XZRGA8IthmjhUD7H1nFxwwUnDw7zFb/kYc8l/vualBhKC8TnTwMgJaZAJuHkihD8lYkdgpJjIxyGVnb4s/d5;4:ywKAdb3Q4NdXynkf9vKftJdcUX4uiPANxvN8TjamcU8sispewfzKmIYhw12pKH/EQC3L/yKtqJh6DTOgzO+w8gK4NzeqPRKjll0yRAloQJIbfEHT6wbUubINuIs1tOiV5HCuPE8UZFFHuw9EPLrJ1bWhhq1M8lWoYk5/iuwC1T/rm75wPeeLlkeXyK/GgVRPYPEU9hlP5rVwWkPBIccXrEyhwHLe+WK+fuLdp7oAj1IMGd3OCXhfM1H7zwQ66KkO+rlTwpFxcJ5l3bLUY7BU+w==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253B63B7EC8AD616DA57439B0030@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(58126008)(16576012)(53936002)(97736004)(52116002)(6486002)(8676002)(2486003)(76176011)(305945005)(23676004)(52146003)(5660300001)(2870700001)(65826007)(106356001)(105586002)(229853002)(31686004)(7736002)(2906002)(7416002)(86362001)(6666003)(31696002)(50466002)(316002)(478600001)(6916009)(53546011)(6246003)(4326008)(77096007)(47776003)(26005)(16526019)(386003)(8936002)(66066001)(186003)(65806001)(65956001)(6116002)(486006)(476003)(956004)(2616005)(3846002)(64126003)(81156014)(11346002)(81166006)(25786009)(68736007)(36756003)(446003)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjUzOzIzOjNvNXB6WVRGdWd1SkUxc1p0ZlA2SjZMTXhk?=
 =?utf-8?B?eWVvYkg0end5eGpLVUJLeW5wSVpqc1kzd1kwYTd5WlFqa2NkVUErcFNtOCs3?=
 =?utf-8?B?T25leTVSK294WVhrWUkrbWUyVkZnVWZHQ1VFdjV6SENFU2dVUmU0RVdmcnVH?=
 =?utf-8?B?OHB1NUhEc2xjcHJQYjVWMmd0OXR6bmpRZ3BCczZSajlVRnU3dXlDZSt0S0Rq?=
 =?utf-8?B?RS9nb0RiYWp6WlBMQVlUR1Y4V21Ta0FTUUlTN1pXaGhNNlBMN0dyZUpzYXN1?=
 =?utf-8?B?TmxPNEZDMGJKV1JhNko2ck5DVCtqUlY3ek9SbUpwUkgwcEk5SWhOSy9pbzha?=
 =?utf-8?B?R1JJVkpPV2tWckNzYldObDZ5WnpiR3R6ckhuOUdqNmY5QTdVSnpkSWg1N2Rr?=
 =?utf-8?B?bEozZGdSTEFVaThnc0R1UUJDd29sNm1ENVI3YTl1c2FDdFlEK1JVUzQrb3gx?=
 =?utf-8?B?QXp4ZlI5aXJMNDl5L3hYN1dZenZsTEl1UDFhdlN4OEg3QkQvNlpSaUpJZWpQ?=
 =?utf-8?B?N3dpbWloaFA5RUFWcUNaZ0JrNW84VTBpNC9IVzJZUmxlNSs0RVpIUEorT3lC?=
 =?utf-8?B?ZFB4RUN2V2JKUzRFMTF4TTN5U0VrVGl1S29UeXRVSXl2NWh6cWpBd3lPa3Jw?=
 =?utf-8?B?TkNtcEgxVWZJUERZVk1iYldrUXZhaHN5QnRHS0t3eW5HdTJ3RStDK2xyKzla?=
 =?utf-8?B?YVU0Szc3Ti9WaTJZNGsvZURqblVPZDB2SXBoRzA3TFRGQUZQM1Z3aUNnWjgw?=
 =?utf-8?B?cjRiZkMzSDVSSzVuTUdmanRoN2pEM3NxRVdGSHU3aHQrcGY5RWY1aWZtZUd5?=
 =?utf-8?B?SXBBVWRJeThSZ3BxdkRER25HTWJRK1hrbTdiUUZ4MFIyOTc3ZUlGcUJrRGxp?=
 =?utf-8?B?TlNzTDJ3WXNYSCtBZVZxV0Q5enlBWHRNVGxPNnkxYXptZlFHcGRCNGp5MDlI?=
 =?utf-8?B?ZlR5dVY1UlNiSkxpVTlWMDNRSjBnd2dYamcvQ3RseWVvR0JkV1JTT1ZmQTdr?=
 =?utf-8?B?UVpjZ2NsL2FXeGd4SGxldUFwL25Fd0hNUi9vb291bU1rZTBTdHo1VEhmSmhY?=
 =?utf-8?B?T0VyNk1mQ01zMzNka1FzRnJGdXJrcmdXK2xQZlZ6ZHpzRTZ3Unkvc211RUZ6?=
 =?utf-8?B?RHhFT1REaUN0cUlUT1VFaVY5Q1FKOW1nVTJyS2NzQUo4NFQySzN2QzVKWld0?=
 =?utf-8?B?bUNHSFNHTTRrM2dtaXJKbW9keXljL1dJZXRWeFVRZS84Sm9mQXI1MXFMbWxJ?=
 =?utf-8?B?bWxSa0NYWTVkazQzbk05bVd4QlJyVllxdjFGTFgyWGVOc2cxZjY1ckNPVGpP?=
 =?utf-8?B?MnQ1VTF5ZEFDQzNUQ3Y3VEhNS29aNXc2clVZbFg3TTdqdHdLeHRFNWJJQkFa?=
 =?utf-8?B?ZEMxbTdHcjVNUUh6c3puaXo4U0tyWXFxTDhDeWkyb0NTbXV5S3ZBOUNKb1Vq?=
 =?utf-8?B?Q2lpK2ZheGZGS29vR3ZvV2p4Mk0yMHI1LzJ1Sm5XL3VsUkZJQWlhUjBVWVRY?=
 =?utf-8?B?bVJQeHAyUUx2NWxEcy9PWi9sZS8reFZBTzJHcHhxS1ppSld6cVk0bW1WVVRh?=
 =?utf-8?B?R3lRZitleXh1c2lmZC9GaG9RZjExa0ZEbXRWTWZhZHJqVlZ2MGpWRi9razA0?=
 =?utf-8?B?VG9GZE5xcnBtMUhWek1uNlc2TWcwS0pjdml1ZGVzVUE1bGdJKzRQMDJGL252?=
 =?utf-8?B?b3RpRURLMFAwWFk3U2Izbm1OdXFtSlJUVC91cjlCSzBqVlRWUjBON25Ib0JL?=
 =?utf-8?B?MWZUZExDNDBwcHJScHQvS3JEZ2VXbmN6b3A1cGs4dUNFc0VVeTZRSFpveGV6?=
 =?utf-8?B?cWpoQUJpR3FQQnA2dy91aUpmVEIzZzh2RTBzN05kSGl1Tmh0NVFZcUcvUkh0?=
 =?utf-8?B?aHI0YTd0L0o1K2RTZGt5ZkMraVZBdFhIZlVXMUpxMS9tUTcxQThOMEUzbzhL?=
 =?utf-8?Q?3J4DdWMVB7D6mbL1YCONyYZo27Av5I=3D?=
X-Microsoft-Antispam-Message-Info: hXD6080oY4cuH9GZfMf790H1vK9PxkuQcSy7iaOAyftMVKeL4CjIZ4T1/mgBG8NS9cXwugvdGQ8IOQGPsLz3ZlZtpxXEpjUoPuWoga+55O9VBE2F11YbijfwjNzT4V1wMDOXeu29EZ9VLOeeCKt77Q4gtabHjYR1b38gKqL0948KUFhsplZ+O2yKOd4gKORawtcc8/hLH23HOINLl/RFLlt8SM/qPeO/SF/FLeb1R3WRjjyO4RyH7Ghp4Wr0JzrimoLqKjaQkzC3RD0rI/Q4d0PMM/sQgxUuVyJ9V9j2VqBABDunV8Uwv6D2RQWKgPRPrmOMQGf2/OCsKoQgaY9t+9R0OHTH1iMJ7nKAebKT6eE=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:tPgOdL6mCWTT5TBc/OD8SBH7+nACARFhRMzI7WL2DEQX4A0friXzgdjCYc3ZVms3b71GjixYsE0A4Dmi/iGUHn+i8w+NmP9xksFW8xX2Zcg0FakM+hTf45MXAsmv7Q4biog/ediabjOkNXkF9G0/mbxguXYQRoTkrWxMfL8lxGqC7ZAdmGptyMOZ2+DAiJszSgSK7nWcX2llbQYS3TrqyQVvmNxHClGdqaeXFfWBg6Ltynw54ROgJ3PJVYmHMR+C8ulhmmh2W+YBFM1g9qF6SRnbn+dixrPVK0byucU1lmCt9i9y5dUefTlPMd8keCF6Apnt1NvyaBqDqXbPpeET+SfmkrwzO6lTlCR6qgg9vWHNqjUDAvGYorw015DjMM4YBXTlQmJruPg96XN53F224e5bMYCXx7m3lN76yKO1VH/yKW/AopT7fWmHy5EjgwpDSlVaHpUY0Lf7mbQZEso7nw==;5:1tMYDJp765buyHAVJ+9d8pLnrD9Yau8I62gpvqsOZM+lW9FPPZvGp9QhKzD/oLdwJcY0i2fea70+rfD6Cc9NvebPbRYyltnNuR44BKwGnbv+33Ht3CCXkn4Am6gK9ouMCaN1UWqCrYycFH8QQyTBvBPBEouJqZwV0eT4yOnBx7U=;7:3hjRB1iXCiGHVcbM1rZ/RL9IJ098UbLqVKKyqEIIFxfIzn0srtalGoyj8UYlu36lwBQUvD6i6Uyd/rAej1CTlz+e6hQWNQFWvwG97wKSyVbDpW+fAOXqBlEHGbp21zBoxr4r7mv4Pitn/qqzq+cFYw8JlWn1DgfoOoglhGoh0ZGGAuk+7VwC2MrkBBYorMjdofBPL1GklUOeRKMv1P3ymThpxblOywgpDfja3lwqsW31MCBypgHW7GJh5/Du7CHr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:7hsClMXI1aPozAP1E3BTPPx+pM3DiU4Y3HR40zam3yZ0Wi221I6XDfQgXhJrWT+YqAR2TRnCsJJUL9kpwW3RgY/GZv7K66mXnFd7mwDoj1DGThGB/j+Ss/3AvwrEhaXlUgqLAxr0I/HGvadCrnw0F1C0Ppbpxe/tXdmh6IslanQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 10:10:07.7404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eacc20-6bbf-4b5e-90a8-08d6124e9822
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2018 09:59 AM, Kyeongdon Kim wrote:

>> > +#undef strncmp
>> > +int strncmp(const char *cs, const char *ct, size_t len)
>> > +{
>> > + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
>> > + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>>
>> This will cause false positives. Both 'cs', and 'ct' could be less than len bytes.
>>
>> There is no need in these interceptors, just use the C implementations from lib/string.c
>> like you did in your first patch.
>> The only thing that was wrong in the first patch is that assembly implementations
>> were compiled out instead of being declared week.
>>
> Well, at first I thought so..
> I would remove diff code in /mm/kasan/kasan.c then use C implementations in lib/string.c
> w/ assem implementations as weak :
> 
> diff --git a/lib/string.c b/lib/string.c
> index 2c0900a..a18b18f 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
>  EXPORT_SYMBOL(strlcat);
>  #endif
> 
> -#ifndef __HAVE_ARCH_STRCMP
> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || !defined(__HAVE_ARCH_STRCMP)

No. What part of "like you did in your first patch" is unclear to you?

>  /**
>   * strcmp - Compare two strings
>   * @cs: One string
> @@ -336,7 +336,7 @@ int strcmp(const char *cs, const char *ct)
>  EXPORT_SYMBOL(strcmp);
>  #endif
> 
> -#ifndef __HAVE_ARCH_STRNCMP
> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || !defined(__HAVE_ARCH_STRNCMP)
>  /**
>   * strncmp - Compare two length-limited strings
> 
> Can I get your opinion wrt this ?
> 
> Thanks,
> 
