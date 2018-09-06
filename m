Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85573C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB962083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EaK0KpiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB962083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeIFVnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:43:03 -0400
Received: from mail-eopbgr00117.outbound.protection.outlook.com ([40.107.0.117]:18399
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728178AbeIFVnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHOgSiBl06ux3Vyuj2DaOPZgP472avntxqxmK1nlIuU=;
 b=EaK0KpiCL/8HoMwAOpViOgDZffZ9CkEKuGunyLeGA/VIYAy95h8CPhI/iJ6gUJ4/kNol6Y1ZBc5N2w9cyuSwQE2DiKEWlLCv5V6c42s4JOJqUP8+UUbkeVULYtNUGJbf2Dg5uPllaPuL2nyDE0/2dEUxPYTMRJHiY2Ouis+DeMA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3259.eurprd08.prod.outlook.com (2603:10a6:5:1f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 6 Sep 2018 17:06:32 +0000
Subject: Re: [PATCH v2] arm64: kasan: add interceptors for strcmp/strncmp
 functions
To:     Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, glider@google.com,
        dvyukov@google.com, Jason@zx2c4.com, robh@kernel.org,
        ard.biesheuvel@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <1535014606-176525-1-git-send-email-kyeongdon.kim@lge.com>
 <12d4e435-e229-b4af-4286-a53fa77cb09d@virtuozzo.com>
 <0bde837e-2804-c6d6-4bda-8b166bdcfc6b@lge.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <4301317d-74a1-963c-e423-781808de215a@virtuozzo.com>
Date:   Thu, 6 Sep 2018 20:06:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0bde837e-2804-c6d6-4bda-8b166bdcfc6b@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To DB7PR08MB3259.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cacb401d-444b-4d9a-7218-08d6141b190a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3259;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;3:P8266I6Tj1V5CzqBGLVN709EV0aZRppeNCrkJFwpc/e8GEd5GQqvWA2gBY8vVFzrFol54l30t+sA8NNgZYc/pkyKGbb+uhKR9ri0Ih18+LOGwrMFZZeQMUgm8133AunVED8dqugrwX7tgFflAu2FX6OA5Cd51+FJGJbcihMgrcSJndYf6v3rnkaM1MhdhtnSWzeG4HWTuUaKD/87N5pYKdOYMHsJ/gRP0pikLFt5tySr68FmpeM0Q2u1bkDqx24v;25:gBGeedZXNkz77KWjE07bMI6+hFD9qpwcg/1zAORD5yXamL5iDQTf5q0jbop5hmHY6WU1iyj+zLTgIiGRKoYkgfzZF5f8CCZVDJcqLY7t7hKhY5+Xx3ndVNm5E3WFgQbFcFIRInYoSXtC8mhm7ajmugv1yKaDNb0/hZ14Zs9C0rbPtZ29LdaVx/BtfZisJViTRZ+v0kARkDzatt6i7Y73gohh2nBZzbXpotPfYIv1Gw3OJVkvV3na5hUH5XD0UkNxOnjVafsvvurD5afnAI9/SKOPMUndXY+8e0Aa72ENphTtAfMMJj8VYC/+qMkQVkwGRjiwZ1w1dKqHN3+H8Mgx3g==;31:LDba74Y1RqPKs/T9HgX2ufgjIkoWZwG/75nzLG24Bqk6qvMnEhenQbqFEQx02D+CCWfSRtzrSB7a7Sw4SHr0n+kvtAOb4AtEnwZoL4Y80VON2gTSxTXjMwTeDEyBNM/+YXE78ZgwrKBFJcjkRrINY/ndEqn9tRFnko5pFiI4ghq1Lz04cXhIkqzrCBQoYXGEoX/cUH9eeBxlccoRFtCOsFx1OQvTB/kSc/wcixyjlqE=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:E/ITgoNbfSfNkThIVXrXqkVRZvtk8xhwXrBHiHMXT2ZzEGlIlmplSbOIWsr9DE1riKYGONsMiMShY267jsjOmXnQ0/6uaJhR/xQJlpw+bHUq3PRn93HKgmE9dbknmXSYCWTvgBajl6yg1WvIKlPm+9UHhh/vWzXT3XhnyAxCRNrc1d2h3HqcTaRUB6kIonE49J1CFSaI14/z1I1Bz/nvbBZ6gaJNDxJZOnQrxfnqgx0GrenENG0V27/msO5HzraupKA5F/35mUFBixLCmRUfA9xLhHmm7unl2gx7i780PKqFD3AT2PPpD8P9TWk7Bbe5cWPiQivFYtqDD75vXXXZtHtxm/hOl8vJ+nn5vt2a6qgOttx2kxlYHmWa2d7/YwUNTVLqgGCKpHlCx8KTnXYL9wzOxQPALKZseO097iA/OJz+UPbSBzrHm+5u9WQlkRWJn9KOKfMkXfW54Y+8KgmprWHWxfAybgEnKuUG9LPMdhQXNlpKzHIp649vW6I96jvn;4:mdBXEcLunBT8mfVPwl6gYTVrve6Qc96k2ujwGXS8yLOSpuI0VfSM2t8ZWE6LTL55HIJWvQ/Ob3k/VYPzuknxVkZ3/pZ/GGvGl6OdRNBBFqPeWBdgCLATF6fsD+4z0i0EbDLaP2XFapbGazaCjDhRsWXbOdpvfx6C8165IoxBlBUHn+muOjI2QPDX76jVd6JmRAj7gxNlGAm1BukxkorTfMYqYPPB+n0mm84zwjxtfKgRbKUjAPVXI7sgtXRbmV94el2kILz8jbEED9V6B6vpr+tu1DsDNv4Dy1ED5hTL5jAX/q2orgwYgCKxje2/l8GD
X-Microsoft-Antispam-PRVS: <DB7PR08MB3259050F7AB508267095CFA3B0010@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DB7PR08MB3259;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3259;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(136003)(366004)(396003)(376002)(39850400004)(199004)(189003)(966005)(97736004)(66066001)(65806001)(68736007)(53936002)(6306002)(65956001)(50466002)(64126003)(8936002)(86362001)(16526019)(476003)(2616005)(446003)(956004)(47776003)(186003)(7736002)(305945005)(486006)(229853002)(3846002)(6116002)(316002)(5660300001)(65826007)(36756003)(386003)(53546011)(77096007)(31686004)(31696002)(106356001)(81156014)(81166006)(52146003)(58126008)(23676004)(6916009)(6666003)(16576012)(52116002)(76176011)(26005)(2486003)(8676002)(6486002)(11346002)(478600001)(105586002)(25786009)(2906002)(6246003)(4326008)(2870700001)(7416002)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU5OzIzOjJwNU1ieGlYUGhXKzhVN1p0VU0wQk1tOHZr?=
 =?utf-8?B?czU0RThLZ05jOU1NY1g0M3l1WU9zMm02SG96c0NsQXV4VlBNaE9YTE9MVE5S?=
 =?utf-8?B?WW5BR3hxMEtVU0Y5MzFMTnZFU2pSWFVwcmNyYzZ1N1YyY1cyNjlFQ2xtWEhZ?=
 =?utf-8?B?TEV6cGR1eTduMmFXUXNUNlovanlkS3RyRVBqNDd5S0l4R0owY2IzVTh0RE16?=
 =?utf-8?B?d3lOZjV3UWVsMFNMVjQ1aVVXSXVrVHB0M09yZ3VkdFE0UlBUSE85L0ZCckpo?=
 =?utf-8?B?SmF4bXJrZVFBY0puM29sajB0ZDIydGJRbXMwb3NBWGpqLzFxUHRCcGJRZTB6?=
 =?utf-8?B?d3JvdE41a1d4T01PUnFtbENBZE94dzlELzBab3ExclJjQmRLcVB4a0Q2cGhl?=
 =?utf-8?B?aUVLVFpGT3EzMzVvNXl5Q0xhOUFPRVFnTStjLzJCQ2hFVlhOczZhOUtwMENG?=
 =?utf-8?B?QldGaWVyVjlSeEU1eHRVNFZXNGV5ZmV6VHR4R2hhN0g2TnhaUzNyWGVkZlRS?=
 =?utf-8?B?RWNBRUp5OWp5ckl5QkNoSmtISjV2UzZQVEtycmQrZ1RIZkdValJnSUdoaDRi?=
 =?utf-8?B?OW41MGhXelFKWUdBUVN6QWZYT1lrUXRXcVg3T2ptVDN4aTgyVjVlMzF4aFp0?=
 =?utf-8?B?MmFZdWw5bGJuQXBhYi9sS2M2MFFiRlNTZHB6TDNPZnhZS3dMZHBuenJZRmo3?=
 =?utf-8?B?K2p5aC9BWkdNdG1mcHV2cVJnVlJ2YjFOWFFCQlNHL1lIMWlVancwblRKUWo3?=
 =?utf-8?B?RUVLL1V4Si9jRDRxWE4wVW1oM2xyTHdzb0dpUnBaaXR0TnU0Y1lqZGtCV0Z4?=
 =?utf-8?B?M2ZzMzFzUnRqd29sdXhzWFMwYU5tb0phV2pBd3JoY2tYZ2xpekJPSWNvVlYw?=
 =?utf-8?B?YnhUUGVWb3E4UVVGSmtEenIydnNXK3dtSTZXMGsvWmJodytMTC9ZWXQ3T0lH?=
 =?utf-8?B?eWhzOVhSRCt0RzBEa0JsSWpyb0ZVell1LzlWRUpXOEY0ZDZ6dTJYYmJQK0ls?=
 =?utf-8?B?cWNaa042NFh6T3BzcGdLWVNaTVhyNmwvNmhreDVOamI5cnYzUDF0L3oweUhu?=
 =?utf-8?B?ZjVQSy9hMmhhRGZFL1dNeU9xcWtOZmRwaU9MSGdWRlJaRy80L0ExQWFPMmdD?=
 =?utf-8?B?MmE0L3pUdDd5TG1ldzRETFN0bldLWVkrelhTUUlSS2p3MW8rNFREMjdtK3ZH?=
 =?utf-8?B?VlZpTEhJSkxwblR5OE03bHpwa0gzL2FzbGZWbDJLSUt4WHhiWjBNdEJ0VS9y?=
 =?utf-8?B?Y3lCNnk1WnJHZDN0TU9FZjZnMC9sNFRpeGt3NndkUlpzK2JwajkvOTdaSit4?=
 =?utf-8?B?QTAvUWxYNWswVENDM3cvU1dXK0MwTHMrNHN2aVZXZWVZWjN0N1U2VkJ3cExV?=
 =?utf-8?B?K3gvNTIrNHBxUWZVWUZsbElYRlZrTmF2eEFvTUYwd08wcXZZQmF6d0U0QWtq?=
 =?utf-8?B?MTBFQWFmZWFNZStJK3dzM25IWlRVcXhDNVcxWHVuNG1QaGVFNUhaTWRQV3VP?=
 =?utf-8?B?cHhURk8wclNRM1NvZ0phdDN6ZnRUbkdSZmhyOVoxTHowTGlTYjhDSkpaenZ3?=
 =?utf-8?B?UkJCeWdaKzRtOGMyTlExNzBmaFNpMHdoRHFTZVUzMnV5L2pBczN6djRyZmRK?=
 =?utf-8?B?dmtzTDNFMmRaN2RYQTQ2S3owdU5EaExkekpwbWZlOFdMN1IrZDRjeWZ5cGZV?=
 =?utf-8?B?ZVAzbzJFSzNYT0QrZ2NuaGhFZE02VWZoenlBV0VaTU9vTzRYMWdLaytYVDVy?=
 =?utf-8?B?NTljYmZOaDAyclEyVU1PZHAxcm1CVzVWQURIT2Y0dHZvOWhSZWtpYVhTemtu?=
 =?utf-8?B?YmtLZSt2SkNnUktiZUdxV2pMUXZpK2x4QVdDTHRQYUIvRmNZN1B5NEt4ZGdW?=
 =?utf-8?B?YlVxU05uQ1NOaFl6YlMvR0YvUjRXOHdHMFFQZWNFTnpONWNiVnZ3bi95U0N4?=
 =?utf-8?B?aTFlTkRESEZKUFdQN3VodmZzZllLV0pjKzJ1VFVyYVFQVS9xd2NEYXNHTVlw?=
 =?utf-8?B?TkFOSTd2QTQwZmQ5ZmZaalBqNVpTWE01OEpwZz09?=
X-Microsoft-Antispam-Message-Info: 7C8/o+sPqwVPd7rkLTpMy1Q2XdhJtYKYug4LJ6QBN4cxoMb1o8xO8RJ0TrUjTESCzCF+ThCiPf9HRzFhA2X3HGQF0VaFJwe3ItjNY8r0oVzG9eh632OPtGtV8S7hRfnyr1kkEEqHKDpUquvsFfaPAtXpyOHNIESWKCpp3IAssx1MnrsfZflW5EcFOnue3Buc/xj1pLR84QxkFD0/fMeZfODUZLlmwkOSFQVT2tCCKJ6M4D9C0c/bLhmvND9DhnsceHGdwUDOh7wTPJN5xLYvCEhB9UkyLz0EHosuGYBfbYouzKRneEjzrMwxW/iKdmP9ZAGYo/2cBdX9F7WfnvOzebDBo4nEUUpedoO72FOtmzQ=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;6:ogAlU6SDdkgXGbYijQjt/9ypYcv7iSh/2LxDaBNGTJ406w2vWy/yHGBZoDkXdjLCK7lZ0B+s35rQfzNx1vVhOS1hmviEzQ4Z6Psal/crt/oxkMu6vBFx2GQGXnMtKU0gWynNNsC/La+zEEAMVw4wGK1n+xcxihyv3fuXKqfiC0Hs2mAFkiqQJ+x+yGUhSDAz0/WnrwrZcoJkSjcJkUUWuawZ+P8guzc3wuYu1olVjq7ZbAG0ldieJkuVXuB0paO15thshmisBGF2uzBKZx5E6f9H25DQfsx53Cq7WRsCZB/fnFUtygrxhln+0Qj4CaozWrw8dW+AFH1hBWnCxXLwKCfxWzJrNt+HHjc5dU17bAfcJg28lSdeofcjN86w+/kDBixaGI3HGhytibcJJaqERimaGePPOsNFMCybmiToWFmzC/xVdZeWxG7CGH26aqfg9krJ3xO9pjrEzblXl4iSNw==;5:wGoOCgfYZy7yGKe6T5UFhkWkfZH+7hsSIr5qhEjAgR17Xedjkl63fY8BpvfCKc3MhvOUOmAEBAfRfDYGS5kkMuY9dNWY/ktlbYAqp23Fpf1SVvkG+WRDslLdtIM0mGm9m2Z1OAMNJ965iniUi8mIXN77zLwnIyk2sO+icwV41SI=;7:XUTw+Hfgf8ObVM/oePdd0iIF4ZYaCNQW4irMIWWldUHkcOFsR+vG7p3Hs1pFhxQLXxh5RZJD9puWIlzdw/Q3biAt0uLSKgUGnn+r5+NgVbQwAnC2GzxdBTxrVw6sEKKc7UlRN3VWJaqtCL8NfnXYibnRrIZRFXTPVFjC/qbSvd01KvLO8DCrEOVLOgZUHMPW8S/q5CFPyr5Cf7/itlXtcIoDhfpeAgz9sRT+HhBMLLS923HwfkMeYfefnx83j/+z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:eU/J6MJ9Pse8ppDUAXG3xDuQStz+XxqlCQdSj4m6J5lJkvIkILFQgkGhby7ayg1m8WS90NgY0KnJqiaJVGwrkEsJ/JSimY30eJjIEMgh29TaYI1wK3YUd69ydnSkKz4OjpggMn58pkIJblYV6fPU+e5h0mIIKnTu9il7ImS0sQc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 17:06:32.3482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cacb401d-444b-4d9a-7218-08d6141b190a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 10:44 AM, Kyeongdon Kim wrote:
> 
> 
> On 2018-09-05 오전 1:24, Andrey Ryabinin wrote:
>>
>>
>> On 09/04/2018 01:10 PM, Andrey Ryabinin wrote:
>> >
>> >
>> > On 09/04/2018 09:59 AM, Kyeongdon Kim wrote:
>> >
>> >>>> +#undef strncmp
>> >>>> +int strncmp(const char *cs, const char *ct, size_t len)
>> >>>> +{
>> >>>> + check_memory_region((unsigned long)cs, len, false, _RET_IP_);
>> >>>> + check_memory_region((unsigned long)ct, len, false, _RET_IP_);
>> >>>
>> >>> This will cause false positives. Both 'cs', and 'ct' could be less than len bytes.
>> >>>
>> >>> There is no need in these interceptors, just use the C implementations from lib/string.c
>> >>> like you did in your first patch.
>> >>> The only thing that was wrong in the first patch is that assembly implementations
>> >>> were compiled out instead of being declared week.
>> >>>
>> >> Well, at first I thought so..
>> >> I would remove diff code in /mm/kasan/kasan.c then use C implementations in lib/string.c
>> >> w/ assem implementations as weak :
>> >>
>> >> diff --git a/lib/string.c b/lib/string.c
>> >> index 2c0900a..a18b18f 100644
>> >> --- a/lib/string.c
>> >> +++ b/lib/string.c
>> >> @@ -312,7 +312,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
>> >>  EXPORT_SYMBOL(strlcat);
>> >>  #endif
>> >>
>> >> -#ifndef __HAVE_ARCH_STRCMP
>> >> +#if (defined(CONFIG_ARM64) && defined(CONFIG_KASAN)) || !defined(__HAVE_ARCH_STRCMP)
>> >
>> > No. What part of "like you did in your first patch" is unclear to you?
>>
>> Just to be absolutely clear, I meant #ifdef out __HAVE_ARCH_* defines like it has been done in this patch
>> http://lkml.kernel.org/r/<1534233322-106271-1-git-send-email-kyeongdon.kim@lge.com>
> I understood what you're saying, but I might think the wrong patch.
> 
> So, thinking about the other way as below:
> can pick up assem variant or c one, declare them as weak.


It's was much easier for me to explain with patch how this should be done in my opinion.
So I just sent the patches, take a look.


