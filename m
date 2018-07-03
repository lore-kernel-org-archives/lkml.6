Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8DAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC62084A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a38HH/J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FC62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeGCPrL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:47:11 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com ([40.107.5.123]:8418
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932209AbeGCPrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vAVe0nddIy8boS5zbCULa30hz2k/BxB40IOaXyxnYA=;
 b=a38HH/J5n6i4jC+1DhwUNsYHMfrEK/iX9HerRBT2sIUuGrNSpBma7Ir3M7OK4ax960ijAUg4PGE2gPuycPWJBUjU13pfIMHxoLZ3B3KEZyRT+iyAcDjhJgz5rp//wR8jmIVGrR8HVeg2dj6oGhXxYXLF7pCUXkA1LqBIVRfccnM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 15:47:00 +0000
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
To:     Matthew Wilcox <willy@infradead.org>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lirongqing@baidu.com, aryabinin@virtuozzo.com,
        akpm@linux-foundation.org
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
Date:   Tue, 3 Jul 2018 18:46:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703152723.GB21590@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0375.eurprd05.prod.outlook.com
 (2603:10a6:7:94::34) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f43e2d-df54-4016-a93b-08d5e0fc37f0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:pVPgN7u6kErpwG9PAqu8oLNEkabejWLd+8l52fel58SB9UfrNqztdhYa+Xs7dqNI+jmi2pXx2ApQGJqJ1r3IYebojBMdZgygYCf4oRd63bUqwL8rZZKSmBFS4UoEuVqfuMkQ/+5ZxQHdjrvrWIfyMAoIM9e6ugjhUSsYLCRCxH8GyzF5nDgHb1gGWNGy9WAS3kBckT8RU0N1uw0cnuezsv1u6VpuxD810mTJBMzqHc4photXKFSB91qK8o/QbSpU;25:rKKA4DblX6dVJpF9Sl4nSNZ0/zVcopgK990b/Jb1IbY2RkHSTngCALtyGPzzrXIZofmLZWKNaVr9oOScRL0WBUxrf9vYM26fnaHhljigdqbMa4In1SNdHUcMRMaV4GtfZvkAjzg31VKRpYlJ8u0NO/JiOGs58Tzc+XV5pNZ8TzLmZrqGCPOAAhVFj5Uk4RySK+y8nAGUNtJ/sw0YhWvPHGmmAsIrBBiQhM45YOxfR02JQxFfTh5ZQVlH/BI7xMPagG0eyJt1TW1GqDhqxW6hoLGD9VtexwOvvtPa2OFEwNf0hh6tPXwtDb0XegztBL9hrTN/K59XCguA1rFX5joJrw==;31:Io1XY92U2KznJU4zg/s1dQIn1JCPjDEj0KA8rlvz2TvBQfQ/mSqfiLQkULbRFre+j4wq+dZamtIPAIvJBAT+cvnV1iEdf0hVqRxHEgtB+JdwrzM+m2OvBdOO1Eoho9REIi74LrxNN9cRIms+BODZd1c96+o/iicfaYLQ/UM8DOnhmgjLvMPgzERmpnm0Rc/1Y5pxmsnAga3jUvLOnoWLJGL5/Ja6joVVurbfpqti2u0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:nwrzlO9nRVe2k+eFzNUJVQr+cvgkN787XRM0heydG8/NVrdVEeHugMXO0r4Mjjqu4B7zAvQ1RNiUmsV+48u0FrDLgi+zZrTvDS5MB670CsjtmEIhzE/Mullb6UrlK77nzKORbM7IJIeCYg9vjHLu/7R1baN1qOkmZ9KttmhRSjQPj1FDHRs7LzIT5sMn9/i5EYZjeZXHsY5sYK5LgUcUI+2Xtc9cI0cHqI+f16lSd7Y+y3f6wkAcdjMFzaj/aL3/2QiY64ou3hKDPRqDIq/tDEeAzVx4/z9HW+KBMNt0XmRm7fQMDPZFBWofK+tj99mAfIRp1DaUsJKO3pCV+vShe548i6KSJqtXaBDdoi3o4N7SUvWTWKSgT4Plzjx7mGS8xcbshLRI+aX1kUKK0ppOYHa4vbahw0uHR1iFHhNfanFVFAzDHxV3ZHDKrdXBQ3WV1uSWbetFhctMM4vMayd7iQNsTSV9vU+5d+H092K3EumOSLeQee03tl6Da3t+SKo6;4:Z/qKL4/qW4Vw6xogIGiHKEuJF7jpOumZpQcAvTH7n8lsacPqAiWIYhg7lgdXIijs5jS0OxCLfTMY/SxatfPMFkWKPY2XiakkNn6wzCYNmnscJHV471ikDapT7Mz7llHA3IAl4TSQG2exkNukEswBXkYrOIBFYxd2s6I9avKyQr9uj3EdLuK72/kmqOMGDiys7pk1YFPSnNj2nZdwU8HmZo0YMDtjdGvDTCACU3IVKUsCf02ZkkYZ4fO4bOst93P530Ku+AQLYnsE3i2ol1Bdyb5Z3FO6IaGhTUl1YWgTrOeyrz8A8JbLN0UYVXGwypgf
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338B8805ED9BE1F71777CB3CD420@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(136003)(39850400004)(396003)(376002)(346002)(199004)(189003)(7416002)(53936002)(2486003)(52146003)(52116002)(23676004)(478600001)(76176011)(77096007)(186003)(25786009)(26005)(2616005)(36756003)(86362001)(446003)(64126003)(11346002)(6246003)(58126008)(956004)(31696002)(476003)(316002)(486006)(66066001)(16526019)(6916009)(3846002)(6116002)(47776003)(16576012)(2906002)(68736007)(97736004)(65806001)(4326008)(65956001)(39060400002)(8676002)(106356001)(386003)(53546011)(230700001)(81156014)(81166006)(6486002)(8936002)(6666003)(305945005)(7736002)(65826007)(105586002)(229853002)(5660300001)(50466002)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6d200aWllNHNrcTFDOTV3WUZPb3ZQL2dQ?=
 =?utf-8?B?YUJyelNYTktRZDliQXBOVVExWDI4WnhnV3grSHFNYWxNRTU4U0hxR1VVYkxI?=
 =?utf-8?B?RjhGWXVFaEs4emVXTEZlbHZwRkZDS2hRYTM5eVNLMFgzTFVETGk2b2lwUWls?=
 =?utf-8?B?Q01HeVBldzZhbHZvdnZkWWk1SUxOVGN2cDJvK3l3azRNNWJJMzBxSFpuOEdH?=
 =?utf-8?B?akxRVGpRWE4xbmZTYzZkYmcwaUtQRXpoU05LR1hzMnA3eEEvQU9mUDR6L0pI?=
 =?utf-8?B?T1YyaSswOTNWQlR6S2ZuZ2RFSVJya0taVlVwRVIxUWYzVFphT21JS2c4RDIw?=
 =?utf-8?B?UmhzS2FtTExPL0JMK2lQYlVzdVJvdUFqdFJIY05TSGlFWGx2N3c4SklMNmV6?=
 =?utf-8?B?MWhyQ1UzbDRwanNMMEZ4R2ZLSS9tTXFXV2M0NVRWcC9WSy83ZXNLOEh1b2x3?=
 =?utf-8?B?YXEwUVo4K212YXdCY2p1elBnSFptU2pzVnhrYndWRU1iRm5rbnBnZ01DRlJL?=
 =?utf-8?B?M3BJZDFRa0JWK3pnS3FpeWYzRDBncitqRVZmbGI5QUhvbTg3Q2RmWGNtcjdR?=
 =?utf-8?B?Q0tPSE5ScDcvb3Y3SUtjSzVNTDIrVHhqOEZza05pZy9aNUVVdTBFNVA3RlFv?=
 =?utf-8?B?c2NTYWZLcVRjN053R2ErQWhjYWdaTktZOGNUU2NzTnRYdlM5TEZLa3VOOExL?=
 =?utf-8?B?QTJyNUhWNC8vWERwTm5PZENMWndsQjQwbGRkZ0VlRzRSbGYrV0puOXo2Tmt5?=
 =?utf-8?B?dnlSYTJKeTlaMlZjdFUyMWFuSk51TlJCZE5jM0Z1YTk1UHVUdGwzWGdDN0Y1?=
 =?utf-8?B?ZDAzWGJqdE9pcjg2RW5CMldEZnBXaXJIWjNWQkFBV0pjSXhDaWY5K2lDTGxx?=
 =?utf-8?B?VVJaRy9mcDNVcHZYcTFNUDE2eUIzRm5CdUFwZHFvbU1PUE9WcVRCcldlN2dR?=
 =?utf-8?B?cTBUNnNCR0RhVjZuZlhLQlhGMjIrY2o4aDJqUlZORlJka1J2UEJSeUZYYWhW?=
 =?utf-8?B?NXRrNnIyV1krUTFYRDBySG1HaVl4WnY3TlFhTDMxdFNVa3lWczlCRWxPUmxq?=
 =?utf-8?B?VFhvQ0g2Nmg2enczSHk4eDFQZExJMmltUTJhRzlINkdyYnk2NnpBaFZGNXpN?=
 =?utf-8?B?b21iRXBLOFVmNVQyaHlGSld2M0xrVlJJN1AzdGgrTzN0MTM3RGRQWEdTQUNN?=
 =?utf-8?B?dTJrTnNIajdEMWhjUEJGWnNiWU4vRmNOTGNlWC9RZllQN1BkZ1BNaFJkM2ZO?=
 =?utf-8?B?cmdzcHppN2pxNHlkU21tMVd4TDVCaHdLdE5ZcEFCSnppOWYzK0FERUNndHgy?=
 =?utf-8?B?UkNuek5wbkVIK0hwd1JwNEgvdUdaWTdENFRVR2U3ZTFKSS9RUzN5UDZuNVRU?=
 =?utf-8?B?ZDBrdVBMYytrVTdCMHp4Q245cmE3U1dMb1h0K0ZPNDI1eE1WVWhkSk80cEZJ?=
 =?utf-8?B?c3VQRTl1cHBNYklNWUpLaFRkOXVHR1hLak53OFJVa1oxcTZYeUltT2hyV1dp?=
 =?utf-8?B?WmlEYUFaN1RES0c0NnJldmdvK0hoWjJPcGhjZ051VEFiajZrOFQ2aStmQXJt?=
 =?utf-8?B?N1V6WlB2SjVlMGhYSWhUODVOWjgxZE9OOWFzcWxyeXU4b3ZWUmFmbFhINlJW?=
 =?utf-8?B?MUJvUDM0TWlyMm90ZjNLMFczYlFjRy81Y2ROWGdHdGZ6eStXSXhoMitUeVhJ?=
 =?utf-8?B?cWgxUWw3a1BOdGx1akc0TzRGdXl4TWVMQXoxMWZlV2VjYmhESkNxQ1haczFU?=
 =?utf-8?B?b2Z6NXdxRkN3RGxzVWJpYzk5RitjbnJCTjV6YXN6QnpxaFc3YjQ5M3hHd0M4?=
 =?utf-8?B?b1lzcmxQekdTakdkSW9iUVhFd1dienE0TU9tNVNxODFUNlVwSWZDdDIwNis2?=
 =?utf-8?B?Q0VGaFNLOGZFUHpJdW1tblZidEFUYUZBWk5sN1N0VmhGeUhBbUtHWEZVdmNN?=
 =?utf-8?Q?+qVbnrMC21iIdvUYYszz+bK/12Ze5J00=3D?=
X-Microsoft-Antispam-Message-Info: qlcCvxLbHDk+hfWDpeOsYSGT1miPH5VdTLeXqqiokDqfmxL8/J0Rka3suGiUHUDauc7treUtM9l0sDXUQ+XF8n47MrNUjaWNTcoLZfUEsVHZCeMkuna4t6wMRCHIOEZcfSXoEVpGNel1/qGUqAd0P/K49sKHmGje1j/kY8rAFJDzuO6D+DnzQxtxHX2xSGM2Qtl94M2nvUA1Z+yEn2EJNOlFTWkR7zXcFlIXGo8yscTbUQRJxOIrvOpJett/VYK8jgWHuPKdthe7kRNpVEyAn4uv/knzGMmRHtODWRzXRbafpgZ2vK0hmjvZvwzUIOBUbBPoKhQLMVOHzoeOSXa0miZdJa0x4rgc6qRUTfBSc2Q=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:AvYeqtL74Yp3Kc3XzP5pSfzItW0UTYBdCjJ3WBIzNEqnT0elF9eswxpSKhHYIwJ4BJNAnmr2+0FZisZbEXtYs1w4oseF5gKsaDzRTBrZQRH7n6Y0vN1Yu1M0dD7zT6EOWH/tuUWSsivYln2jm3YwqnwVViUA7k5Ndu8nVXw74PFGTIRCoTm28QFlY/yLzxut9wNLTMwrY2EYRnzabuwUKyPP78TOqs/bSXNMqDREJ5KvWMrAe1MgDjc7HFMt5JklcrEAjjW4eQK/pQ6qcBnoyBFetpHOlCb1sZttmYek5C5UIlBRxizXiY1MoPnaG0AXPhsF9OzcR0uDTRVWk1rQBCVu4AdqIObdd4lsRtQNs4qnhORrZezhh7X0cchue1Ofyvvb4bJE5sliJ5d82g4zGfHBnaZ9vI62g15Pzm4LMbBAZv7tknOiT3xxg6lPG631wZ+Iv5Y1QK3VPCKKvbSEDg==;5:EyPgk1kfOf8wa8LvLgbncLTt4Jax8E0okF027zc2s1jkqrMHU6XTlpovJ5EOgtQb8riw7hO19vkUIL8fl1i1z7nd3t8o1ZMOKqw1fXfPBl1fogQLzrN2esFZhYW+/GYV5bt4b2NXGKUC4H2T+0lYED/uU1KNy6QaTn4lUkAostk=;24:eO6e3Vku9FC4jOzaF6vYVUk1Fm6zArGLS+uM8ftHNMP2J7dCaThP7o4Kekvyp6JywBt1YkGlXYp2YawuhbMcL1tzYXUTsnqEk43Epxt/tMY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:8pt5g3astqVlQJTa2iuudL8B5KEvHAiXtq3Wto3h25gSE/6Y5rlyTtNNBIhFGQ8igIJUp+XoGUFEjtuYDNd8D76A67lLd0b/u6fcIBIs1KO/Bac2dxptVUhqhLeRAjezi0pOJ4EWiw7Ppa+zr75KqJmizvrruRr5MYMID62gj093q68usVCjK9nk4kwtUc3OUzOvbF5zI1R4EaHmYFusbgFpnd623KHqIymK14Sfp3cfZSbJJjxrAPBaSMILnqwj;20:K1/SJjl29hEqp9nyQvRS4xx4yKIztkeFyTzAFkyQPwCLFZXGjcFgOmzEns8QzcbA/efwBJp2zY3U4v0GDxg4aafc4V0eHU8ArXVQCf8RKVHy1xjQhL3mYY9SM/A3WB8rHjDHNXJLhJJSdUq9HkpYBYD659/6awFocfEmzHZKERI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:47:00.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f43e2d-df54-4016-a93b-08d5e0fc37f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 18:27, Matthew Wilcox wrote:
> On Tue, Jul 03, 2018 at 06:09:05PM +0300, Kirill Tkhai wrote:
>> +++ b/mm/vmscan.c
>> @@ -169,6 +169,49 @@ unsigned long vm_total_pages;
>>  static LIST_HEAD(shrinker_list);
>>  static DECLARE_RWSEM(shrinker_rwsem);
>>  
>> +#ifdef CONFIG_MEMCG_KMEM
>> +static DEFINE_IDR(shrinker_idr);
>> +static int shrinker_nr_max;
> 
> So ... we've now got a list_head (shrinker_list) which contains all of
> the shrinkers, plus a shrinker_idr which contains the memcg-aware shrinkers?
> 
> Why not replace the shrinker_list with the shrinker_idr?  It's only used
> twice in vmscan.c:
> 
> void register_shrinker_prepared(struct shrinker *shrinker)
> {
>         down_write(&shrinker_rwsem);
>         list_add_tail(&shrinker->list, &shrinker_list);
>         up_write(&shrinker_rwsem);
> }
> 
>         list_for_each_entry(shrinker, &shrinker_list, list) {
> ...
> 
> The first is simply idr_alloc() and the second is
> 
> 	idr_for_each_entry(&shrinker_idr, shrinker, id) {
> 
> I understand there's a difference between allocating the shrinker's ID and
> adding it to the list.  You can do this by calling idr_alloc with NULL
> as the pointer, and then using idr_replace() when you want to add the
> shrinker to the list.  idr_for_each_entry() skips over NULL entries.

shrinker_idr now contains only memcg-aware shrinkers, so all bits from memcg map
may be potentially populated. In case of memcg-aware shrinkers and !memcg-aware
shrinkers share the same numbers like you suggest, this will lead to increasing
size of memcg maps, which is bad for memory consumption. So, memcg-aware shrinkers
should to have its own IDR and its own numbers. The tricks like allocation big
IDs for !memcg-aware shrinkers seem bad for me, since they make the code more
complicated.

> This will actually reduce the size of each shrinker and be more
> cache-efficient when calling the shrinkers.  I think we can also get
> rid of the shrinker_rwsem eventually, but let's leave it for now.

This patchset does not make the cache-efficient bad, since without the patchset the situation
is so bad, that it's just impossible to talk about the cache efficiently,
so let's leave lockless iteration/etc for the future works.

Kirill
