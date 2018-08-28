Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5BBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72702087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bBC1AA4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72702087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH1PYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:24:55 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com ([40.107.6.132]:62679
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeH1PYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/fAxAGNq01ZPU5/FYyTMDZU5zUIJ+ukT0nZhaCSKrw=;
 b=bBC1AA4OAPWI6rB2HM4NheTqPVxd2+W4uLjpxI8A6w9tlNIccIEK01ENQhkZTZfvoPgIh/NAKDFuLFZAT6Q478Ywk1JPYJ9qbr2leMea3/HH0U0oENajCT2NT8vLvgkNQnFwDDkVSp0juokEA4ok7jHQxiQwfml5TKul+cib2TA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 11:33:36 +0000
Subject: Re: [PATCH] x86/entry/64: wipe KASAN stack shadow in
 rewind_stack_do_exit()
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
References: <20180824235826.62741-1-jannh@google.com>
 <0897d173-6a30-09df-f16a-76322384fe0d@virtuozzo.com>
 <CAG48ez1zYqx8-1We3JkDBmYREksUMoUe7VBeAOv2JH98gVWcKw@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <daba9c5b-b5c6-beaa-ca96-81cf6af760b9@virtuozzo.com>
Date:   Tue, 28 Aug 2018 14:33:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1zYqx8-1We3JkDBmYREksUMoUe7VBeAOv2JH98gVWcKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P18901CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::32) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a2ec422-4149-421f-5881-08d60cda18e8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:IrsfndJHK3puyuYPVsV2LWoRS957lKq8Z+Poj73SsCL9S7yfEkHhDK+hlFru36irXojtLK0yyFGtRyBy++s/L1fOVtajT0USi5MWGSluWA8DXEH/1nEVjlMWec/gO48tcJIM9L6nIpAoFcHDbMnWZs93Yd8iv7w1ms6GJvVPWBjMqaIKhdMYovx/v5kcIfwJRmKPRNVinRPdf8fiOikWDXZgI4mG/K+nD+STLo0NbruIH8Kyp9NaXlfSw0RCMtOf;25:opIkEVqyo7ymhqaxGI5i+4ZxGOngc0DGFyIMCl6NHZv97jpVbnE0LG5kM9Sx3sfsnf2vN79exd2z+VL9VVZe+hKbKe/j2+zvLbnhSj2Yd72Hu3KAduw7/kb5TLSRQRhewGoPQc6X22vZ7mXOu4k0KOPkGjdaUGaXv1wLyfFBxu/oytDFbSp6gZW9YToWEwNOt1WQyteE8Qs5V6IYgpF0YPQtq1Fm9nRA+YNd1D6fiVQsFLZ/2xTnP6/D1yfOpndxkD4RzDe/dQnZI9sUqLuCDd3DuTQOk6WKL8LDRjPdLByOJmRYRU3R9fZTSIwErreTu6lr4kAVj0nPxiYF9shJow==;31:WKpy6qeTqSYwo/5uPZUZcUi972GKTUWp1PNBeU0qCm9X9kR58ZHPuHy97Iuoz4Mse+/v0mC6RGBzNHtgezZwemB8X5XdhNewInhr1r7UjR3OfDBU9eIJ8q/gZ4HiOjHPCsMjrfSA+rSgovHhCF4I5DXsJvNx7JJ2VstayQ1f0pSo0LLiEhcfAO9yDXOqYb6GpEKWoBiwiDnB15ITFET+IFWY5A6uxmLUJ0FlL8bLLlI=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:nicGd52CBdiJTk3wjGxsGIFx90veFhAZvCpnADttsqCyfB2CaRMiQnW0RU3tdhEMs2NYDITKlMItPylnjamrxpkuR+BVGdLZjwpH57p4/S3xnfadXlY8AfyNIomjm1qcjNr5cYaL/HUk0qZMgHW2rRRBiecFEvvpfsnX2QbMPR5ccZsM5TLfVxFK7/0nxLT2HEWN6KWGRcmnkh64niDeHP3jLwB88CQm+cufM8Q6toTYJf5WM5+WeyPcGoC17SLAzrweoDeac9PtC0UBk06x12dgzB9D30ym+xvYjbcOmfamnmGS0XUZzpM1Qj811e62y8OhnSVLcDUCVtgWpw3g8VnkbwcRm7rC99cmqe/MxLtP/iNauze0E3nU72g/28Cgtwpk6735LEo73r1OodII0BaKNs/8TAdNRS0xuA/8jtFQbhf7T4PvlYSAHJ1FBS5obhleZrSsw03XhDWPfBIOZJ4pDOJ06cjxiL+wBIZv3U9IJ+U9fD1tQDNrja+musL/;4:MMoApP7jOq0cb26vcPdrVl7Gx1rt3HurpHqS5wfVU6N8w4K/+SWieUe5K0ZAj/MaJ1YzYnpva3TD1eAcZAToETgkruxonii2pqbzQ9B/Zcp1axmxRqxsgErqrXB8+RDAAAFitnWzJJQf2vOHDU/fQsmsBB1t2nn3vqPvlfJXI1x2Xq6F8lTk9mWDv+7jPl7G5t9vxYL9zPtnF1P1VVEeZtenw79BuTdc8sVaUJqOEY+JBxHwK+WsWqS0hMzItElR5QAC4IYD0kTARPUzczzJ/g==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264817FDD896C85D13B1FB3B00A0@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39850400004)(136003)(366004)(396003)(346002)(199004)(189003)(76176011)(52116002)(26005)(3846002)(31696002)(50466002)(229853002)(23676004)(4326008)(25786009)(478600001)(77096007)(52146003)(2486003)(64126003)(97736004)(2906002)(956004)(476003)(230700001)(6246003)(14444005)(31686004)(8676002)(305945005)(2616005)(65826007)(6916009)(6666003)(5660300001)(47776003)(65956001)(65806001)(7736002)(486006)(81156014)(105586002)(81166006)(446003)(106356001)(11346002)(36756003)(86362001)(186003)(16526019)(6486002)(68736007)(53546011)(6116002)(386003)(316002)(53936002)(66066001)(16576012)(54906003)(8936002)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjY0OzIzOndMa2hEejVBeHZZODFkUDRGM1c2dnZISHRk?=
 =?utf-8?B?bEJFWTEyOWhuemU2SHM1MWdKRWhUYlliZWNhRk1jU1FienZkMW91SjJiT0c0?=
 =?utf-8?B?dkYrZzk5TXJHOUFub01UMUdIa0Rka0dFWFBhQXp1eUtHV21JTTEwSW1FSkF2?=
 =?utf-8?B?Z2NtMmJHRHRJTHh3d3Z6cHFiWmUybkNGQVY3dHZRQnliNkZJUTNVelNWNlBS?=
 =?utf-8?B?Nkk3eGw2THNTTXpSRGE2cE5ibkE2VTlRcVplYkRuQWxHQlhFN3RXS2U1RFY4?=
 =?utf-8?B?UWh4R3l6SHVMZ1VqeGY5VW5YOFdPSFVWMVRFLzVxV2hwbm5JOTk4MGxJOVZQ?=
 =?utf-8?B?c2hDaFdac09qUnVlQUt2UVlVWUpUNmt4Z2srT3lZOU0xWnkzc3grY2VwOHR3?=
 =?utf-8?B?RkJuMm5TelNnV1Z3MjM5K2NjTFIyTkdmdG8xeFErZmx1STJ1NC9nSVA0cjdZ?=
 =?utf-8?B?RWF0VFdibkNQMnRmT0JoYlV6Mkc1cktHSXl0QmpBbGNCdlZLN0xQRkdxVWh5?=
 =?utf-8?B?RnRzUHhkbXhKSlI2VzFpOWV2aGtTaThVaTFtVEIzTXZ6RUllbGhKVkRlV2pE?=
 =?utf-8?B?MkdSNGJ5N1crY0NWRUVLeDFMeFc0RGw2dHJmRU5URVp1cEgvNmY3WFc4OE5B?=
 =?utf-8?B?d3ZnWUVhaWFGRFo1NVBrZGd4WlVhY0hTU3VyMlV2MFRoQzNLVnpCdkdQcUhp?=
 =?utf-8?B?dlNqd24xVUU0YnVveFd5bktoY2VXTVd0QTJvSGpLU2xURXdjZFgzbDJtUDdM?=
 =?utf-8?B?TnRuY0RFQ2xPallQNzd2ZHdadDk2ajFoL0ZaZjNYN3JwNHdUU3VzTHFhZTZX?=
 =?utf-8?B?VE5PYVlIVS84dkxROW5JWUdmb28rV3BQTVVqTGZWbFg1VzI0MEtkaUpLREpj?=
 =?utf-8?B?aWVKckZyN3NqMnFuV0RpUStNeGJoWGI2TEVjY1htQ3RtMGM5RWNEMlZDYjdR?=
 =?utf-8?B?UmFmUi9vaGJkVGJPZGNyTGFuU0hjVi9RY2ptNWVaM0FsdmE0WVpScnZsZUpZ?=
 =?utf-8?B?MktRV25hdFZBN3F0cXhyZVprVVdxYnJobXdXZVh5NmRmMml0aUpuQkNYai9Q?=
 =?utf-8?B?dkVZZXdYUmJPRjd1QmxEQjh5eWw4RnQ0S0hEc3NxVGtMYXFVUFh6NVVlYmNY?=
 =?utf-8?B?Z2VWNFNvUjl5TzFBY1ZZendkZ3Q3b25aUWxoVEJRdEdoT2xsVHRqSFRGa3lG?=
 =?utf-8?B?cUttdk9mN1owc2dDZGNidm1rdHU3VVVvV2FVR01ST0FHZjUzV1daREZrZ2dS?=
 =?utf-8?B?c0tVRnBlRHJ2aDQwKzhScUE1b3JvdWozWnpLd1pXNXQ2K0RHUDhrTkttVzIy?=
 =?utf-8?B?N21mM2JjbTdjUENiM01UaVRobDZkZzAvdGE5bHMvVTJjaUp5UlV6Rmg2ajZ5?=
 =?utf-8?B?V0dBUXdXZjRIUExmcG42SjZVSUVud2NPb0E5SU5RcmlHL0FZd3VlcGlJREEy?=
 =?utf-8?B?NVNnNGlVZDhzVDhMbUpHbldKVUxJQnpkSkV6V2NONERTNUJ6QU9EYXRaM1No?=
 =?utf-8?B?aC9RVVpRQnJZUGt1VUt5L2FMaS9oNFVGSWxGTFlvdVFCY3Y4UHREdGpKQVZC?=
 =?utf-8?B?NEFIUm15ZTd4cWEzcFM3MjM4NmxGS0RvcEtlVzQzOWszQnBJUWdWRFlsclda?=
 =?utf-8?B?REhMQ1M0K0JlNlRPaXZkV29oMi9MNjRwUTRVWFVCaWROMTV5TERONzhVZW95?=
 =?utf-8?B?cnhpSFl5RG01NGhROG1zWGlPMG80NG1yQWFaUXJIMTFwYlA2TWZseTlqajgx?=
 =?utf-8?B?SllydnM3S3dkMExwOFlpYi9NTFhNVE9jQ2xhMGErLzJ6QWtqck54N2FlakYz?=
 =?utf-8?B?UHFERU9VVGJqYUhkN3dMaHUyU1JiY21Xek5qOXRGamVCUTdIUjJxeEZTeDhS?=
 =?utf-8?B?WW9KcjVYNklCYURlMHVZcDFKRHR1RHMvSjRSSDJWRzloSWMvUjQvbW1NR2ZO?=
 =?utf-8?Q?p2TPo3lWPTjII+8GIr1VOq8NbXAs1c=3D?=
X-Microsoft-Antispam-Message-Info: BBHeLOk9G8fNurlYEkowXg3HddRHQtR/LMWmbBTAKwoiFxKB6wMaFfIeywjH7tB7lntxNydWGcv/Wx13GS63AcACkrODJ+VkNS9Xsl3huBaWFWtFTpljVaLtoVDyoqlAgKyVOKBh+h/WNcN/yRan2o9+rb5VKM8qVMQDf1DjB8l23eSs3x0CRWMnfY+d3Ik9X3HqYrxGL1+IW5ua+wSXZxvzXKBP9znaaQ1R1KVQxMBEgMm17xeWhReVVhiu7mVi+lOdhl71r2+vNXkNt1MA7eqmmjr570tpNA2ugdry2s3FYQrEDWIMra6DmrxtoknbsSjvrwN1kINGgAxGan7+RiK0FjYpVYozKpYiqxVuF0Y=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:s2TQRXq4X9gS3/iGLzZATp69u4OEBEdT2M2zW1EfGU3YHQ45u95C9bj8fwZ0GVj0QVeHPHQZFCzXuOtZArNVlaQW1vN3/pDsxgle6WFAUX4HfembkJs2r/Ramu3HuMjKPaWGBl8a7ktBXVBEpyP8HCLwEPf0y5M5UWR+0jI0mt3LihIZtgvT2ulQi76doXJ6arLVHatjx7GbdT7yiNSjVZV4K6mzMTervhJ01Cd7GeSgEwrw0Zisf3029YCDACte7e5Tz3veGasdgz4E0uloDvVPRofLohUGEYhjssvajFJeMkQZ9GE9Ze0cIj1u3KDQqyjfnGDmQBFYs+GojSnfgXIM3/rMxk7kAHPbcD9i6CPbXWO9vz566jw2iiojWPpUdAaZEwexuyhNaGe76eofa01bLQkLnZtPDZSSwj3oFFpvG4+Ab97SbRXh6mYdrpF1kJOVNTspSoCx6SP3IJSblQ==;5:CH5V8wzpTllcYSAeOipwhUcEiz0Bl93fZ3sAzmoZIsPM+O0yqJdUuCOsixGgjq0MDlU3vW2wylsCYtFLGIptAg5vJJwW62wEPMpD/FbbtT1d9VpAhTAQLkhO1mi5YoLf/ZdvL4cJIuYSnxVJfzlSrQC+1cBvm8I9BPea8vkYnos=;7:FFwqRt2v8YmA7YYZ7isb1Sa3jqVwco7gnWIOuOMO4EkFPyWEyBJ5K2nD7jy98EkO7RK+m1SuyDYrEMUzrvIz2QRdBEmwuJspB3HpWg7ly5yXg4mPSY7FoxyG6Ccvj2iF0nyYc1fqD6SUtF8ToCZs+hqTWdxm/woOV0D0BBURPsuYY9Mj2iRvwKmEd1ZnDe4HJoyP0cZg46cblpZ8Or6Y/i0CJeHx1wmY7kCrq2ygT3CqME+ss426zWGck45jK+53
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:ziU1YmqxpMFukvBDBNc3Ud0pOuvnBXbi5ZWLU8FS01b4Pvj+LA9Ie5dFSBwrSq75LxVRCxeSJXmRQtF4IJCVyyTl2BhoRJ55U1NzEYQsp3geXnsWv9sGB/Cvbd84KODEItOVp76xKlNFTyAPiLbAUCL0bFic7DuqPUkkX+ZzBxI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 11:33:36.1335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2ec422-4149-421f-5881-08d60cda18e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/28/2018 01:38 PM, Jann Horn wrote:

>>
>>
>> Why this has to be done in the rewind_stack_do_exit()?
>> Are there any problems with calling the kasan_unpoison_task_stack(current) from oops_end(), before the rewind_stack_do_exit()?
> 
> Ooh, good point! I didn't see that KASAN instrumentation is disabled
> for dumpstack.c. 

It doesn't really matter. This would work with instrumented oops_end() as well.
kasan_unpoison_task_stack() will unpoison everything including oops_end's stack.
It would be also ok if kasan_unpoison_task_stack() instrumented, or calling any number of instrumented functions
in between kasan_unpoison_task_stack() and rewind_stack_do_exit(). As long as we return from these functions before
the rewind_stack_do_exit(), the stack will be unpoisoned on return.


