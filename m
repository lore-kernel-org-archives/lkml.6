Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F24C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9331A2174B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NhItki+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9331A2174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbeHCLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:08:08 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:53479
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729350AbeHCLII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWRklUqWay2Jeqi0Afe4rzaHITW0ZMAZeK7saY12J8Y=;
 b=NhItki+ez8joQGjf5VH//NiDCpc4Kqr9VsMVpjFiWcYHr0YCrY4BSqBV5FvmRsRhqX7VAu4ngo8rTWE+SknX7rHii9z6YHC2sNll5IbG567zsjHUM6gMbesEp/Uklmjj9lnRzToI3HVQCxPlVix4MbWOY9QUFOAGZDWhB3E2E+c=
Received: from [10.2.206.57] (217.140.106.54) by
 DB7PR08MB3289.eurprd08.prod.outlook.com (2603:10a6:5:1f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 09:12:36 +0000
Cc:     nd@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To:     Florian Weimer <fweimer@redhat.com>,
        Andrew Pinski <pinskia@gmail.com>, mpatocka@redhat.com
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <2d7cddbe-6523-f388-339b-382231514f6f@arm.com>
Date:   Fri, 3 Aug 2018 10:12:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: BM1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::21) To DB7PR08MB3289.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 069315ea-c3fa-454a-2091-08d5f921441b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3289;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3289;3:59lfw70xQy/PirAvQFayKn0BkwFQg40U8134LZPY8l6DvoLQRvWj9PPNv455FPSLWP6phItO+NKR42wIc6c5tJl4wlcYW9j5xzLPuAAHUYR/rE1jV8T/Npd4m9CAcxBrTZPQA+MbHPdRteWIJ0LLdA9u/YhxwSPsMakGfbeC40ZzMUemacPUjGwrlWmWiSJlQvoXo1ad5PL688P3r2cHGEGWh6ynKeQJYQhgkiFlxobhV5FFnZF4+eobOZnQeuaQ;25:sKGfXWJR/83h5k4xoi5jlGlrJ3HPkE30NGsaQWz0YpMVIYPJohEFPXz98Xi62VusUinu7lxA4C9v0fVDPJHBWTTIVCG1uqcnpX1boRNFKrmKnapyyPr+FVr/NPtYRoegAJgQ7R4INEc28hRa/Pr19A0/wJufIo6fH+JSH4TjiqWEQcgZA8duPJEPKBt3Rs0KD/gh/Oqm0H6b73fqzbCfdj66jL9Dox5DvePF5O4Rf/EoPJn9Y8b5MqJv5NxodaGJlI/E3eAEnsb60T+d++86qvbfrmcUQctbMe3vsBj6ITWfnfd/rfkPwhjawgWAA6OeyP09uY1wuGOogXL7r8gXiQ==;31:HN4DuQIRG4a4cf4DHJf4AzOhs+lVXO7d1/hhZkt5oYcF8RcZUTPT8XrR5ZuU/WeD2HJklXHVMhA97kWMm7mL1lsYrW9RucFA5G7krnJ+qg6Fb9HHsQlGPM0BAVQ13MDcDYzdobslzf7w1JBAx5Cv2bMNevomZQmPUUs0EM1BA3rvqqG9Azkg30mPNwx1atsGsIwTG1ZMlmip3mLstT2wGP9IR9msAYKpGGdz1ymhJGc=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3289;20:QxkJdntNIyS8SeEnZXmrclogOlyRyWUG0LwnrgZpx8s5k5cik2AdDbFJLyyvsHzzBrfO5u7ajwmSTHyq7oaA2m07+A6OmAAK+p+2ID0zBlIVifgSb0gqctaRLMfg2dfUscpultPOQQPSl8q3gzMoxft0Mg8562NbEs2osPjFyE2KQZM9LOQ3W7F35D4aOYQFEzljndkvHIUCLUglooZuIGwgyI9+urtYJMXMAV/wJOgGYA8jCXafDItGT4v0lzFKoBgx89+UbEeBDDXTR4+21uxwFT0kr6/eSiGRHi4VKUIjEm7dhm2/jTl4iTFVCNILYZNgd5lKfsXGmfgIWBgWRQ==;4:6ysXmlga9YnNOMahvNyEd+jjJ1LGtHYzBzMkYL5d1BN0BPmeO0JZfIj/81FAJjZW1SUNuW6hmhQTWxZ3XwnIEqfV9kRKQuGPXacc/sku29k6ev3iMdBuGWQHM+DkWXJuqZ3DZ4YGKOlBlO8qQgjhfq7dQModJSBa2DldoQnWgxQ/nlm53S4MM5UDWf/kmQY8e9ErmfPcAw0rtuQnuiqPb6NWZrNjnVL1WDvKj2iMd0cK+JpC332L1GA1Rsm9ZF5fRZtEj5XgXtA8//5qpDUHDejb/2oO9SoLB/waMpkXI/0NjJ3NzMb1prAcQFD7FDR3
X-Microsoft-Antispam-PRVS: <DB7PR08MB328924DF9CAAD4F0B1A3A724ED230@DB7PR08MB3289.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3289;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3289;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(386003)(31696002)(76176011)(53546011)(86362001)(2486003)(97736004)(36756003)(8936002)(68736007)(446003)(11346002)(25786009)(39060400002)(186003)(4326008)(50466002)(16526019)(66066001)(26005)(77096007)(65956001)(5660300001)(52146003)(52116002)(65826007)(65806001)(8676002)(229853002)(47776003)(23676004)(6666003)(478600001)(3846002)(7736002)(6116002)(2906002)(44832011)(67846002)(476003)(64126003)(956004)(2616005)(486006)(305945005)(316002)(53936002)(58126008)(14444005)(16576012)(105586002)(110136005)(54906003)(72206003)(2870700001)(81156014)(81166006)(106356001)(6246003)(31686004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3289;H:[10.2.206.57];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjg5OzIzOnluNTJUZkJsT0g3VVpSS0pmQmd0ZWl0bFdn?=
 =?utf-8?B?WThWQTN2bEpSUGdSUEFWNmIvQzFIb0ZsQ3ZocDQrRE9FRE9tRVdnLzlhRnZu?=
 =?utf-8?B?aUJXYVQ3QkdrM2x1NGxZb24rc1dxMzBRNG94V2tBRWZqTzNuQlZiY2pxVGFZ?=
 =?utf-8?B?bUQ0bjNPdnlUNmFFT1MvNk5ZWXhPYUJsN2U4aGt2VGgzNUtSai91alZMYVEw?=
 =?utf-8?B?ekdwb3dxeGJDNjI2dHRkbFdkRXN5M0k3Umd3WFN3Tktla0Z1NjJNNThxaTJI?=
 =?utf-8?B?UndBYVAra3lUZS9uRWRuUXgyQjAzbXJSQmVaWDB0T01KTldxSlNVVHlmaFdu?=
 =?utf-8?B?VXJDOGw4OThJQWlmZzlpSHhQT3RVaXJ0cnBXQmkyb2VJM1c3elRSSUFLUGQv?=
 =?utf-8?B?MEFTeWpTWUlxU1plSXRFZ3dnRC90Z2w3Q0Q4c0pLOHduNnpTcnRDcUQ5Y3cw?=
 =?utf-8?B?ek93dFlyTEUxdkduYUk2ZVhuclZQNVJ1ai9FemFON3V5UUV5NndIZ3dQd2pI?=
 =?utf-8?B?NWF3V09Cc2I0YSt0MGJScnlxNVlsK0c5N3NlT05oWXJZTllMRi9tK1ltVzZ4?=
 =?utf-8?B?ekZmd0FBQXlGSFFkd2lDdG1qVnhCQlpXSWNoemtJWnNuaEk0R05ySDZqaW9k?=
 =?utf-8?B?NHRpTXdHSlRLSFB0eFdwODF2YVBxVmR6dGFiUHpRemJnRGpOb2pQYTh0RlQv?=
 =?utf-8?B?MDZJcHNILzBXbFhjVnE4R2J6UnF0MnAxM3hpVk1id3k2Y1hJd0JES2JxMWlR?=
 =?utf-8?B?SkkybDVZY1VrZ2U1eTlERmpuZTJWckRCNy9nUXpqSHlwTWRSNmJ4UzhHcSt2?=
 =?utf-8?B?V09UM0RjSjJGcEZYVzhqQmFOUUlxckp2TDh0bUM1RjVaN1B3NnZOT1A2YlY5?=
 =?utf-8?B?L0F3TS9jVDNrbGsyUmo5aTdBSjUycGNZeHY5SXArNi9CMG41eXowcVBCUmVB?=
 =?utf-8?B?UVZYUHk2RnlaUFJJZ1RZOGdwUHdjMUp1WE00MG4zSk9ieWFXTzZ5VFdac3o2?=
 =?utf-8?B?ejB2V01rdEJDbkJIQU41UktRaHNrcDNTR204dm5EQmxxTDhJeFFGNkZ4dlBa?=
 =?utf-8?B?c3FlTVhIVDIzRWRUWGxYNHZ5QTZqQ3B2QXJBSlhWQnNSWk9JdmZwemNCaTc4?=
 =?utf-8?B?M0lxUWl6eCtjeC9CLzEzdEs4RlhqazZHbHlzVU1iMnEwRjlkRnFxQS8xei9X?=
 =?utf-8?B?RFZSRDFtcnRzUjc3L0xWOUxDdHA4MFhKcUg1dkNDOWd4NDBNbTI0Nm9TekZh?=
 =?utf-8?B?OHVud3Z1NWJNM2R3QTRPWUNYTWEyYW94YkgzbEhNM05UQ1RoQ3Z3LzFiUU1V?=
 =?utf-8?B?UC9wazFCdi9JeDF4a0NPY25CcUpybFIrek1QY1VJOExIc0pWN1BvUGM0U2xY?=
 =?utf-8?B?L3hoT0c4dkZPODF5WllRQncvekw2QkQ1cXlJZ1d6YW5OT0hDOTZKRWJCMUww?=
 =?utf-8?B?czg0RlNhRlRYNEw2TlRkWVdzblZUamZBRGk4VkVmTVVBVXZaTFVEUGMxNE5H?=
 =?utf-8?B?dTBIWWJhVEpZNFE2NDhkMFJjRm50cy9uZlUzUDI4b2hkLzhXektNT1BvSXM5?=
 =?utf-8?B?SXRFbkZQdXoxWlVQQ0ZZUUZlWXArZTRLNHl4QUlweExneDRRYzZ0U2tPSEdN?=
 =?utf-8?B?ZFc0WnBxSGhMQ0JDNnViWWpKM3R2ckZjalRDbVVTa1FpZjN3TmdQM3d0MDlK?=
 =?utf-8?B?WjlzUStLaGJpYVlBRWRvc1FQTXFucURMcHFSTUVuRyt6ejZ6bkV0a0sxVTF3?=
 =?utf-8?B?T1dackhpZkdZVHM5VHN3SjlxSWhqRzVvNzlHa1ZycGtTSzcvNFhrbWRlYjJk?=
 =?utf-8?B?ZUpNYjQxN2Y3blllWk1HcVZLYjVHd0E0MDR1NDBxUlFuU1hVZTdBaWJ2aEx4?=
 =?utf-8?B?dkl1WXhlclFDVlI4ZDlWMW5Kcld3SUZucDI1dnE0dlJhMnMwZTVWYWJPZGs3?=
 =?utf-8?B?cHhjQmZZRllPa0tEYU1MYm42VjBmTTNFUms0TjJXb2Fob2hwRWw1ajJoam5O?=
 =?utf-8?B?d0FOSmo1L0R6cldJR1hWSElZWUh6L3dDMkM2Q3NneXZnUDBLUkVVVSt1Y0hw?=
 =?utf-8?Q?DIZq3V/IHR/lQLoFWxyTb2DGi?=
X-Microsoft-Antispam-Message-Info: l4z7IQd7+ZCBJUdIGfzbenEDR9w4kBq/eg35qt2YJOBaQAqPj5SxbNDpQd1Zs11Tix4ANTn1E7w8BKSRznddCBN/cOPn40yjouFJlf5o1VfDqAQHhje3Qe3tWlfCVFOanpDekBf9wfjvCtFVmhM+g4lz57sMhJei8lkMO8vmV551EWEWr/RpAyPXgHwhsim40cMJVpAmCq2k0JnfxLVPHrdSvgAYktH5KjnCGEcSu0wdX1VFZewJxZ2rAngiWNrHOBZPN7AYsm57IzR03I8GhcpZKEkN682zOIcMeds+QpELKQTNUfSVkjorbjt1N3U4Oyoar8MGr15YFHfxx7EmeRwDujkI+/e4AqtQfSZwMlk=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3289;6:GkUV1vet9z6p3V17MIgzXeHw1twV8nSKSdif0LrPIPBDfnB2wQ1aZfF+7VtZ56EgIrhHDkhPvyPQmVWe/pSi2HO0igl14qz3VI0iA9W+YdUntAz8vVcCqdTYOYzkSVHTPVeRH6N/L98F1WxYxR9yx71V7U8EcSOPqifk9lPs9367eH9SewGkukUFwleCWw9PKZvT+WTWX/eiHCbfqohY34bF91D46kr9ZSdjxmMFfjw3SG18yEjjq95sT1r82VLHbrk53u7l3gOWSukYw85gv5nQAKFmbFpzoAZ/UF6Xt+QbMMCTddHwmySqLUTZ65+qCxgt6aoN2YGVPVox6sXGFMqhmGKdDfxj0kl1wI1B5ue/o6cBu/4K0YdRmoS7EEERzVpsY7Z3DkQX7G4zCBRqZSrYZ5YPX8fhXhH5kj3ZyEmARcIzevfMOo0SN+mZZvlI+DeY4bA60kbgniGHb5D9vg==;5:g3UN8HE+jqjSVoJt6lMeIuEN564Wb8E2rmjc95jFPBOyP+38lznEbIPCGLZvA67hq1l4RJJbX8kdi9xde8HJKtYsYlevfEVlyolEpQQxsYBAlM6qDpbzDURGYugcXfULKzhXcQyllc/2PFb7z9Q41aTwM6wPdFA7xPWjBAIWvkk=;7:ozQkrBSMl+dlPThv2pBMWvY8wk0MfmUHt5kwvMcy6wUJXDmG8pklZjQewow4yS17F50es0qtl/eOu3GDRfxMdYeRXhGkf6wsEsHqkhcWkAH/xp3gO4SMBjDa0p8uC5r3rKTC4dpFThuZW9U0m+jfTIy6u0/5FCOg2QmVG5OXmAm1yNBAvYamK95f/5I8ng+cdyborvdmRE1OgjC+p20tROUUOvk7KFlSQm8L6YejjoQIzinYapezjrhPzzOnaFkD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 09:12:36.4984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069315ea-c3fa-454a-2091-08d5f921441b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/18 08:53, Florian Weimer wrote:
> On 08/03/2018 09:11 AM, Andrew Pinski wrote:
>> Yes fix Links not to use memcpy on the framebuffer.
>> It is undefined behavior to use device memory with memcpy.
> 
> Some (de facto) ABIs require that it is supported, though.  For example, the POWER string functions avoid unaligned loads and stores for this 
> reason because the platform has the same issue with device memory.  And yes, GCC will expand memcpy on POWER to something that is incompatible 
> with device memory. 8-(
> 

i think it's not reasonable to require libc memcpy to work on device memory.

i think if device memory is exposed to regular userspace applications that should be fixed.

> If we don't want people to use memcpy, we probably need to provide a credible alternative.
> 
> Thanks,
> Florian

