Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF7620661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Gi/sX+Cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF7620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeGSRLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:11:55 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com ([40.107.1.93]:4992
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731661AbeGSRLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU9rhAM2WhdX9b3bkAslxU1oimKGwKNhHGM3mhDTM0Y=;
 b=Gi/sX+CjPMzVaF2qIS/iE9vihZHSnn7v23ZmPy4ll7Q4ygwahEtqPSb9Z+c+fLXEZtrTVoBbJwdKrqrRLO2uAxwa0QtCfIf5Q79OQk5N6qfrpAV4GQ6qB1gpHqZNdU21Vvg2MpuJaDtL/hA1YnLfPCo+fLdHLlD8SMr32KhrheI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2020.eurprd08.prod.outlook.com (2603:10a6:203:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.21; Thu, 19 Jul
 2018 16:27:52 +0000
Subject: Re: [PATCH] mm: Cleanup in do_shrink_slab()
To:     David Laight <David.Laight@ACULAB.COM>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <153201627722.12295.11034132843390627757.stgit@localhost.localdomain>
 <0f98d9b38be1466b8608d5c071aa52ed@AcuMS.aculab.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <bdfb596f-8658-3ca4-7b6f-bd749466097d@virtuozzo.com>
Date:   Thu, 19 Jul 2018 19:27:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0f98d9b38be1466b8608d5c071aa52ed@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0233.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::33) To AM5PR0801MB2020.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 493463ba-a3c7-4e94-1769-08d5ed9493a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2020;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;3:YaItFGfEtZ1pwIShGLfrctBSf7JK3dLsaubHqaiXXUNf7kIc0uBkpGYRNIOmyfG3/SSCKw0GsoVm1jtoF6gapFqFy89gMkQnR5iaxppNIuk5NTZshlfSY5p17s/8DpgtoWnCC5ys0VOTKGpUP8WmQedKafndbXWvOWwFzkQ3rD7uKGWtnF49xB90pZIbZ2nn3kz+S90jtVgnsQ1MZIYsHKTtf/NG0tY0sQRyKOv6QMFDyI2dxa40HcDvQZs5OrnB;25:q6U2z5982XrvjrV477pQ7eosRdqfofmLYnMqQpzOU3/h2SDOriJM+EgVprpg6WlKcZscUoRehQyVJlOu2P2US70h4Bhp2TrWt2ZnbExz/vy2C9qUs0EMkpNv7NnUHP7w+thtunVwCkINY8LxinMZJAQz682N+5bqWykhH3jHPPEuUwt4vwIQn1PHRGz0pDP/i8O6LnpO+A3CIVON3Pt9wQWDRqLn8fYun7YSIZ3DVdf0heJsy4QrWLDSKW5ZTBiaBxSitHjo/ovaOLuK9HJi1+F1LDg5VKkKc4YTLczhqXbCTkwduzcB5BODp7mx4vJBHrwrIeP0duRj42JvZDEyUg==;31:UhRV194ncDI7bA3lv7Cnm2jEe9QZSEnTDCJLxPHtXwx5xxHnopG2XJBHWoS5rB3dVrCn+AUBAu2wano7GaLVtO/+KxmQ5b9fy3ZEO9PneqS0zNDqVZIuIpd5owdD2b2vDxmWD6rAjKPZgQyezsuMuvUuttv02Y/s6Fjl6Rr/+WoEkNhjeClBb+Kfvvzn//P3TKV3pe9k2X+kX9pbbL3QV5aGr4guC5aDzTnYlNBrwjI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2020:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;20:AoVa2vE1R8PL+Up2IGZApdEX6NsZuzejIu0XCTAAiDdAely9EY9JytchDB6NxqnjMctTH1SZKanTXG26Ko58gRJiFos3yY7qeC9cXMAHUmJqghsZw6Xu2KV2dFDg6e+vu+lykNeDSERSg4tQdMFdo86cEL6+PV+VIR57A+PCP+iyF/lManMwkB6saF5Rh7yxWVVr390gl+d4+kqB0BVbvCXU40CopgnXcvUch2dLDM/lLwedKnBk3ASrklp+tUMfVecAlD5Qa8UIFmWZTcMFZ2UWstnBLYC7a4rFauI89esQ0Drr7MtYGquWYlUUFRUghEhdXWQ3UKQPhxkvDkC8G5H+v3SxpUP9oIO3DrAOvzp46OJGfgWoaVF/T7kqynFAkZghObOh0rJbG0OLu2s/ZjrQ+qAFCpDQJ06JEPBIk8wjAv0wJNDUnbgwG2oc2ZIVJz20BI6kPtW0TBypjUq9FxzTRG8AWi/owGCIdZXh6o7rFQv2U5xs5zxTJ9wZI9ct;4:VeLQQafgv6/817aIx1IeP+Z5z6HtaMMY4JMDbHiMLpQusOkmSzcWKenvdCVZOCSNj59Xj+1wpS7hQtWUFfo4bkFn/TNuVHOSJ79mARJmYGS9bkBNRpfwc7UC5Pqo/15KTzKaPIOk7IboUaEyzDPWqXYLVtF2O3OFiAH8VxvjiKh3Gy57WeXylNcjazg98JTtifqaJoIjSHlI8RafubQjm73/kOOGOOH65ss3OXu9y8OtieOWIHCwRyd2yvs77zXECaMcGnqT1glaR8OTaVOwjQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB20209C4114831D7B7146F1A6CD520@AM5PR0801MB2020.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2020;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2020;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(366004)(396003)(39850400004)(346002)(376002)(189003)(199004)(2501003)(81156014)(53936002)(6246003)(39060400002)(25786009)(478600001)(229853002)(50466002)(65826007)(5660300001)(6666003)(6486002)(36756003)(8676002)(8936002)(2906002)(81166006)(305945005)(66066001)(7736002)(31686004)(14444005)(105586002)(106356001)(65806001)(65956001)(47776003)(230700001)(476003)(956004)(2616005)(486006)(97736004)(16526019)(26005)(77096007)(186003)(23676004)(386003)(53546011)(76176011)(52146003)(2486003)(16576012)(64126003)(316002)(58126008)(110136005)(52116002)(446003)(31696002)(2201001)(3846002)(86362001)(6116002)(11346002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2020;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMjA7MjM6NlRMaFg3ZUk2OXhHcUY1c3Q4aGpVSXc0?=
 =?utf-8?B?OHROdzJ6TTR3dXFUdTZRTlJ3OHplQlZJSmgwRTl6SVpUWGRHbWJ3SkZHblBV?=
 =?utf-8?B?NE8yV2ZGZzRreElSR3NGYTN6U0Z5eXpEaWJvQk9uWDJKcG5zZDdPVkIrR2cw?=
 =?utf-8?B?emVPY3JPMmZ6ZXpzSzdoSEQySkM1VERydFY0V01naVRBbGNuNmlBS3ZhSXNp?=
 =?utf-8?B?c3hBR2dGZHlwU2ltdUNnWFVlMnkzZzJHK1c5T2ROVjJhVzRkUTJnSTFIbmxQ?=
 =?utf-8?B?TWo0YWJqangyNjJodnBnOUpCNmFsRTZrLzc4RTdxWVZCOFphYXlMREZKZUN1?=
 =?utf-8?B?QnhETlZ4MzdLTWpPWTNDSWQvbmN5TzJaSFhHTWs0SXY4d1QzOGFCOUdSZVRS?=
 =?utf-8?B?dnowbTZXdWxoa3oraUhwcE15aytCc0RwMUFFVzdITTRNczkrQVZaOU95ek1F?=
 =?utf-8?B?ckRTc3k3T3BLTFREaUFNWFZTOUd6cS8yQkczSEF2NzlXT09ndkFjVFM2UmZU?=
 =?utf-8?B?ODNqU0JBODJMKzl1NXJJbUoxOUNvZUlWMzVNWHM3ZExUZVhnblh5Qi8xN0Vv?=
 =?utf-8?B?ZHhzRVpEN2JsM21PWTJmVzFFVmdkSHdyL3Y2MkhMUFJmRVdwS1NMbkZpTTVx?=
 =?utf-8?B?NjF6S3VibG9qeC9XYTVmUmRlSVVpZnBiVnZoUWNMam1Xb0xKakhRRmdmSnY1?=
 =?utf-8?B?RFNiQXh1SDIybUl2RGgzdXpEUTZnc2loTUtNZ2hQSjZTckdyaVp4UVZabVZx?=
 =?utf-8?B?SlUrZVVoYkhzVVVwcHVONFBHSDJXLzhpZ2lIR0ZlSllyeDFFZWFtaUYxVmEy?=
 =?utf-8?B?V1NuQ0p6VUdaRFpyYTQ2OEtlaklxWkZPUWlpbmhhalZvTlNUb2RnNml4aFJj?=
 =?utf-8?B?VXc1Uk43b1dkUzc0K3JrakVCNVJSTmtUcTYvMHlGSi9PYXV0aGxpMHM1OFN2?=
 =?utf-8?B?UUZRanFYaVJrRFRkeXhaWUxvcnNZbSs3Y2VRcjJydENzNEFFOWRncCttSTNt?=
 =?utf-8?B?aUdrcVhhYnFBdTJoYUpzMldDT281Zjc0NCt5QTNsdFg1VnJKR2FibzIxV2hW?=
 =?utf-8?B?ZW9HRjlsNTc1cXpxQk9uT0MxbFhSenNWbks5OUwzRG1zS3dHekt6VEVjdlR3?=
 =?utf-8?B?TThDZENPUmpUVnZ5dDVnOFM1Y3FDTHQ3VXhyTnJVRnJYTUZhcDYwNEF0T1pP?=
 =?utf-8?B?N1ZaZ2taWEdKTnIvdTZKcGZwOFZJTzlnOWpwYnFNT3I1S29IcmJXTVBndEpW?=
 =?utf-8?B?TXE0OHd6TTVIbWs4N0RBd2hpMWM3TjE5d2JhTCtyL25wdkk3b0RhYkNrZmlQ?=
 =?utf-8?B?ckcvVkIvLzkvdEMvaFN3cU1uc0ZMczdnb05wWHdHcGJ5c0VVMmFFSEFjRE1D?=
 =?utf-8?B?SmZ1NlFKamRFWlFKQzdrN09mOUg4TFhnZ0poVjhhTDZFV0RzMXVOaXU4V2tN?=
 =?utf-8?B?Z2NkYXN5RFlaSk1PdXZINW1Da0U4RkFaQ2RnU1FZczU1QnpNSXRsWGpHOEZX?=
 =?utf-8?B?L3NXaFdlUmRtN0R4VWxZY3E3ekxXWk14QUxGS0VUc01EQ1FLSWlGWlB3ZGNp?=
 =?utf-8?B?Yk4ydGtENitXNFBVSmMxTUhKc2pJTmxzZGF0Nnd0WTZjTkFaK2VLYnhIUGR5?=
 =?utf-8?B?MFArMUltRklFYk4zbi83NGgxbTl0UnR5SFRVOXZMWDlBRDVHWWJ5SzhJRktF?=
 =?utf-8?B?aVJ5YUdrNlJtN25JdFYwMDdvWEF2MTZybGNlWXY3aWlPNTd3ck40QkNBRFpx?=
 =?utf-8?B?dHprZVAxRTRWOWtlR2xwV204bWtwQzhneVV5ZFFId2htTm1ZakRBNFBSOThi?=
 =?utf-8?B?T0I5SDBMRnkwTVhURWhXdWcvdm91YldvR3kxNzYzRmJtOWgrUE1uUXlzcE5U?=
 =?utf-8?B?YWNOZlRwUGJ5UG1DQ01MTnoxYmRGTGI0aS9VNE0yOGE4S0xKaVlETkJJeWV1?=
 =?utf-8?B?aGpnQytMSFBYNTFscmdlSlIrcDZhenVYV2I4S0huQndCWkhDckVsTGNtRzk4?=
 =?utf-8?Q?X3dEMNez?=
X-Microsoft-Antispam-Message-Info: LjSdxTwvp9kZFttdwedwzCDOSOPvRhing941UY8Iv24thszyAbjt8z9JvKLLU7vSiIFIcruWbD3AXv4jhP9d1z3xOF7imeX6X8X+gf2NyTNJ5CSuSuLe6Ze1va/nc2jsAslS6TxtcbD9OI/R8cglbl94K4HNECbgJ1Ye6dSvK43bA6QVYrWNKllrMkZP6QL9xeKN/h24bTy0W/i48IsTvqygRCPuJYocyby8Rlbm1K2sfe71io+IHVD0BZ5kVfiNZT7OX1mYdLmmz2Wl98SKzA0wbIeobl1KlW2ur5OkMCv/XxlPH1e7t06Q03L/khwYUn/1nih9JzGOwmJA+ZCyeFHyCKtUEsbXgqfnOmLvx98=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;6:AtncGbvPlufEAOGQJDfgNbZnPPChjDd/zV0XQSg/SFpS8FBlCNJc4WYr2ZO3UtskAIAFOldcWoTUFh7KOxP6vQp3bQtMRqq3XgTzFLY5aEIZMEuTs68xgDV1WIRKBqtaNtMz9QXWkW/RM9Do1nnj9TYE059vidOoV+5db5TOmV8V+F00P6Lz20xqjBmsGuXcSGgwn7KMSgT3ku8+2jvsdsU12zaMiryx0Q5PRNkGxHyww5f9W+Y3ipTnPFprjGW+NEy8jW3nxDpGRw7N/n3+3PJkmj66kN0TMiJ79dqVnDPWwtKX2TAdTY6o3JWnWW6pkgLO8SmpHq8fppYhUgaVBXecLfM9LsRR83JLskKpM38XCeqQ5OjDR5x+cWSMqdT9Kql+/85C+0Fhpwvfjg3VZAYUw9hAaKcDhub+SzkB1IcWdQqctsXDMPkCrb128P/DdMH9lih+ceCZVEnWpyRGEg==;5:0BB0zhHgMQ2nafspZmk0eZkfpqQjV04aRnvF1uoUy/CVPqy74sRxI11hbC0BB9F1e3bwa7/DkTWlwyND2N5JNkaDpV1eqhDetkY/F2VmzXPY+QODda3Gsk9awSTg2pgmHWR2BZ8G69iG+Abr/iWQLhtIK/mpi1vE6Ma574W1W48=;24:RaQSq3ELsYihorUpNoO58uofKAYCmekZkvkSleOubt78BWLsm9dtKpijQNnCdAF/ZgGAAZctaevEslo1MktuioMqwNBoogW6/72tFxj0EA8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;7:EGG6qwaenY9y/oRSlFVUYLBF456aLAkR9Zh0HNtN7LxJsZj2dORXG2+127zCoLAqYSBJdQYC+yoYJpTU4pR25vsFhuc/+qbfB5qbzvqJq0XTqYWKNPIUrOtW1v6J/e08mprweKgupWy2/lp9us6U9JWFNq9PDr1Gt7RraGLj+M9DUOTcRNrG87Jnw4Bnl3qNLpUjuBApjgceqEfJDRIvBTsNKT/mhfwIQKI3X5PBIg0EtYVxWDKFQj1AgUL2jJUq;20:eB6PvUW38svIhtn5iUzY4nsrOCIPzXBcxtlpzFzrUqScDkTHdigBdM2AsaPEsKz6vvgmgJpYKyT/6tkR5uHR9/5MrXK11d5oEtFOvOMLZGpFW08eilXyXay7HNfA1iXD8ObvpexbLUnw2sWh3fBcj810n3EbvYgVkp0b0Yboc6U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 16:27:52.2796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493463ba-a3c7-4e94-1769-08d5ed9493a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2018 19:21, David Laight wrote:
> From: Kirill Tkhai
>> Sent: 19 July 2018 17:05
>>
>> Group long variables together to minimize number of occupied lines
>> and place all definitions in back Christmas tree order.
> 
> Grouping together unrelated variables doesn't really make the code
> any more readable.
> IMHO One variable per line is usually best.

>> Also, simplify expression around batch_size: use all power of C language!
> 
>    foo = bar ? : baz;
> Is not part of C, it is a gcc extension.

Then, use all power of GNU extensions.
