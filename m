Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA2CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504E220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nni3n2lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeFTMIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:08:16 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com ([40.107.3.115]:40630
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750793AbeFTMIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozvxW70fe3mU2YoXk14+Yktcp0TwXUL2Y7ui54Mknhk=;
 b=Nni3n2lGb06gCZh0hUS3NfAQMkqW5roPUTmMNfM9ooJgXx2Ie2mUfiiyAWVrWcfGKJguOLBDwA6kBD2v6zphRQKp4hCX9fx51L/rY3+YH9C3qDwoJJMXt7kXHl/2RybstjM8tXbBWA4N3eSzrKFunbRk7PJ/c3HWAf+Jd96Y7wU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (195.214.232.6) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 12:08:09 +0000
Subject: Re: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
To:     Shakeel Butt <shakeelb@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20180619213352.71740-1-shakeelb@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <3f61e143-e7b3-5517-fbaf-d663675f0e96@virtuozzo.com>
Date:   Wed, 20 Jun 2018 15:09:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619213352.71740-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0215.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::15) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 158ec211-2018-485b-a4f3-08d5d6a67dcc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:QAy6exf3YJPd0vc2t3NRDfqxXKeXN0tu1bWPbOK0lFFaT9eVVn6znnvmes9FhLkTqmAkQrXdH2NDJGb0raTV1S6xMAGhLuReDJVcXodAkJ+LORUOyIhFqAveAfu5PykI5Z/uW4omN9KhIGUC5RKs24Vl5amniNCU71ZN4OjbXaIgRcbp8qtKhdxDarewR/s1NfFZ40SrfDY9JCvxgRQ1MrZTUX2VckZmaH9L0h22tT3k4YPCwGy2jA+P8NvkB6xj;25:IkzrqhRC2fWFdLqKxvdVY+xI3mC5R4srP+p75hk1/2VLVYpSaidf2zyicp+z55gydijV4qDIj9qOsTXF17R58NLaNXd2nDX8LZ8YhBgqfhoihiH7P6T07tr7nlZ54H0hw9XK9jRCLYbWwqf4jCkS+8eKFkFaOouYUjQBXSCOXbuJmz6hCW1WfJS6wRxHVEvu59LAKZOzdVm0fEnmokTJt2aaXr/EIzP4vaJ/qwmbL8GKyJCDzI+iXhZ+Aemer3f6lGHzoh90TX7KhpGzRwJ5iS9tORDVRjH7His/q7OY8Qv6DBkhMBmH2f6QFEgSs50bClsOOKDQzD/XBq49lDzHIg==;31:HBGbBhPMyDxGv11Qt3sqUnI3f1hSZmhw5GFCLSkweuiDrC1hQH0exIHck+nAXzym8SlNwr0FmV2wCMnS4OL/XS19FWAu3Zgld3jsMtNWRpZlNGxBQJXNTC9nZxPhE4Ld6/0GoCWLx6aoZyRSXVJu/mH02M0ZdY9KUiRqqWpkGy+gA2G1ZocgoaJoZyWms7JR/trTxGIK43IkwDr0znB6uCU2CtknXQVmZOUU3oJT+0U=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:RU123dWq0LiFsMNohZiQHSs+GZvgr+zybFsQuM9vIoiHbFaY8ZUoT171vz66gGCEYIFqFXLPTMj+HlxSeuEKZ+2PRukf42EfkgRHu+f4sVoxSZ3wbg552z5f/2h1Cs/hoMh+NOYY9n7YRgXpJzW6iurrwXzN+z0zFt6OVsE6ZJoMPwNoAdO16Tx5aQ8Zn0PWa6HmW0BJ/m+6i5FCp5O8Blb/OQQsLpOSftIF33nGCYe7aY+8kMPCzGKEYAzCVf2iufKpuiBOE6s7CM8UdlHf2aQT1PPMp1+wfa3QmJ0+h+3JOQ9qxLkUP3JbXY5MmFoNAH+Ut+FNwYgR2hcLUYbOJxYpboKQW0MuPT/mCtE+oBmVi1n6TCImojDm8g/ZmpHldlMtMo42Er1DNtQ255/0UM90fh9KVrfdqPG36d7As0HuPM8gOwTUIOHDmHawMax4oRK4i7jrhDy+shM0WmWS/v0zjnpEJbLu5So84bXA5+t1dlBU55DYr2q1KqiznFQl;4:nfyMOicPJOAmJ82MuCmllspLk9bLBTa/8DiWuIcSxHXolDfWz/vScjuAGf4bIbGjgD5eqEekgwrScZAxFF7e+qXV0Tug+HQSmyN22WRRZi1goIXeginsTOQh6QSXeL0IUw3ZVdLzKaIIuqUuvTonPiZ/rmbrkc6/ERImUW4+v1ypRAQoY57o6PUAMvvHAv6SX3oBfB/dmXy6nnASFFDYr7oZdqcNp+wok0Tjzs1jPrBVQ8SlA1sAIfShm9rcCEJAcMI+e/lYqT4pRnAPs8ppYA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264EDA84096726632194D75B0770@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39850400004)(346002)(39380400002)(376002)(189003)(199004)(54906003)(6116002)(77096007)(5660300001)(956004)(47776003)(230700001)(316002)(476003)(2616005)(16526019)(110136005)(229853002)(186003)(3846002)(65826007)(58126008)(6486002)(68736007)(16576012)(7416002)(7736002)(6666003)(305945005)(26005)(486006)(52116002)(31696002)(86362001)(2486003)(36756003)(106356001)(6246003)(23676004)(25786009)(478600001)(8936002)(66066001)(386003)(53936002)(59450400001)(53546011)(50466002)(4326008)(97736004)(81166006)(446003)(81156014)(2906002)(65956001)(65806001)(31686004)(76176011)(11346002)(55236004)(8676002)(64126003)(52146003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjY0OzIzOkZoQXJoSHJFLzFwYmpBZ3NWUC9xa2RXTFk3?=
 =?utf-8?B?eVZKdkVtSDBTdDVMQlIxcVFPZFFzWnZWaUw4ZldUb0ZHd3BySG0zL2lNR1Vw?=
 =?utf-8?B?enhkSFBIWmgyeHJNdUxuUG5WNG9hVHNTZTlSYlcwYkdDVytMOGdBYjVHRThU?=
 =?utf-8?B?SUlISGNEWmRvUEZkMEYyRGdISmYrWjAyZTIrTFFjL3RieUJ0Y2xXUVVaUGg2?=
 =?utf-8?B?dTZaVEhwVndrSUJibHFDa3oyVHVZaEg4TnN5WFRWRUhhdjlEYXVZQ2dVTytK?=
 =?utf-8?B?NkZ2cTl1WElQNXRGVlNjVVliNlBpaHpaVEZxN2loRHFuU3A0aTRPVjNqNitS?=
 =?utf-8?B?Zy85T01KM3pQcGJrUE1OU1c3Ulo1eFZuc0xRSUxIOFRYQ0J2VFQzbWhnempK?=
 =?utf-8?B?UDFDdzlrdzdQbjhwOFBad3pTaVd6WnA5d2c5VUVaZ2lVODMxTzlKS3dVdUFu?=
 =?utf-8?B?SmRGaWxqNTI4aEtzT0U0Rjl5OVRGa2w0aVVNNS9jU1ZwbktzdnJOREIweTF2?=
 =?utf-8?B?SkJKVkZNZGxRQ1E1NTRidEhSN0wzeDJ0QXhOUmc3dzJ1dzlVVjBmNVFEOE9q?=
 =?utf-8?B?SEFIYUZZSnNiTTAzM2tTT0ovOTN2OTBvUmJqb2R1R2VoY3BHZU9yOW9FYnlL?=
 =?utf-8?B?eThQTCtDNFR4aUJiaWc4Wmp5NHkwT2hLY2pZdXJhbGZqRFNpRzlWL2RvLytM?=
 =?utf-8?B?TTlqUlBDVHBQMU9MWTVhblZBZm5NeEJCdlhpa1VQUytQR3ZzanZ3eE5ESnA3?=
 =?utf-8?B?bTBEQ3RYU0RZQzhTWDBuQithZzJnMlRFRlZxd0JRTDNFUFgxYTRTN25USE1G?=
 =?utf-8?B?YTdxWjE1TUlvTzJEdktKcU9WMFVuc0Njc0ZTK1FyYkRqUmVuTnAwQ1lkSzNp?=
 =?utf-8?B?NVkrZ0p1Wm5GYXZodDFWTlV4YWNydFVvLytpTzhZQkhITnpDMENDQmdRbWxx?=
 =?utf-8?B?M20xT0kzZEdHRVJNTzJpU1NUWWZxSFRZR0FOWkZXNUU0V01MVGFGbTBwb1ox?=
 =?utf-8?B?M3g5aDhGWUtjbUN6a0ZLLzZQTG4rbDU0QTZvbjUxNU1wVUp0Z2dsd2I0blVz?=
 =?utf-8?B?SG5hTGNBT0l0bUVUVE43TG4xcEZRNmszOGFzUjRWVm1WTEFSYmpWenk0QWln?=
 =?utf-8?B?M3pvSDdYRnQ5Z3c5MlN5YVhTMXlUakh5aFJ2V0lwUW5qNjBYdkZEZmQ2YVZi?=
 =?utf-8?B?bzRqMk43MGg2R0NRcXNaVE1ldUVTL1UyZWZiWlMyNkFBeC9jcGNVQVlkcG9x?=
 =?utf-8?B?dVhJRElsOHErS0N4VUtBZjQ3Z2M2SlQzay9HWnkwUmMvSm1GTW5sNC9lc3hy?=
 =?utf-8?B?K3ZsVy9UZWpMTXpNZGh3SVIrQjNHZVJvTlh0NGhwckNOcXJBMUlCdlFxQmo5?=
 =?utf-8?B?UXVzVkZIRjM4Uzhlb2FCK1Jkanp6dEpDZy9Vb0FkeHU4TFM3Z3hVNldwdWxn?=
 =?utf-8?B?UjJRQjhCSTlYL20ybkppSzlLaWR2WVpXRXBVdGdwREZCR1VJcHpkR0gweVg3?=
 =?utf-8?B?ZnZHOTJSaFZtWnp1cC91d1ZRYVFvTkQvUUxZSFlOWW9TdGR6MVdUKzNKMHMx?=
 =?utf-8?B?eTcrS2xlZDA3elpoMmthQ0JXZFQ1QkZJMEE3RnZ6Yk4xL21pbzYzRHpiVGIv?=
 =?utf-8?B?czRTemp4QW9INFBIT2NpRG1zRnExVjNxMUVyRWhnNVo0N3lraFBkdm4wREFw?=
 =?utf-8?B?c1E3WU11dHNabzZZcFp1RUZMd0JMaEFsbDJIbTQ0SCtKZ01mQ0JueTlma21I?=
 =?utf-8?B?N2ZiM3NVR2M4b2FBekxqSEw3bTR6eGpISUZKUytnZThOWXd2ZVZtZDRVY016?=
 =?utf-8?B?enMwUE1TQUJjQXdLd0czSjlVS2l5OEN0T1VWRlhEcmNpVk9nYVlwVUx6cmhL?=
 =?utf-8?B?ZG80QmxkTk5XalNYWFQrTC9rT3dWOU9tRmViSCtVL3VpdUcyL2ZON1VXWm56?=
 =?utf-8?B?akl3L2RqSDd3ejBZQlptZkp1KzVRK2k0WWY0ZzdxMzhJMmhhRUZtc21FLzB6?=
 =?utf-8?B?LzcyS2ZvTVpQSHkvSWtIdEE1ckN2MWhRS1pFRDUzTmE4WlRtaVQ4cXEvSVJE?=
 =?utf-8?Q?Rj7Q=3D?=
X-Microsoft-Antispam-Message-Info: MK9EaW/NJJsB6Z6eXxATbUXiWAl9BwwBU/Fy6BvzIbPA6lVm/RVS6VORyKL+fODwL0zeedVKuQ0gE6bdY6lvdTYb4LMAfDlyIpikJgef0zrpzc1DDMV4ARKdemrPdWQb8jWVqrSYNdsAkapFwnUQtnDwJDoEf5BW7741BPTEy13Ed2t+VmUI7VWFs0gBT0mogv9Op22dsHqnUUVCVyAq4EjlWlxaCNOc8x38Pe2syeFXFrxbJEZ+n9PDLSCpdGLUvc8QWJVozkdxUAmgAATpzuhndUAJqNpXVTWkWErhNbl/dQ1s3XXSgrikUpgD+EGi/oQ/59zYjEcBwGFAZEjE2g==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:N9qsMABuQW7JPBGsdDRwkBk71x6F4p6J2GfDQMt7IKWL8cwjkZ+TY/gEFrs7hXbExMaum8I9NHVLT7hLWx1XUyMGlLFrFELUuDQ6mH2W4HMrbqqaEc0Z/cJ9ZM9aE+Q+jrINn3dYzUVOL/4ufIU3GGWLVkIcB1ExWBZrc/79WyTlWrZdl6tHqF4rv9j7Cbr12/rEleTr/srTTSbcgFTQnt/qZ2gYDVQ/6KSgDY7+6Zz83jGa6Sh2e2sX/jKa7d4VdiRRgqclnHWG+gkdr33kxWOeMxz+IX1sx4uIaYY6tUi47P3jErlSVsarz1sGFWgZ+JxdoMik1Nl/xusz8fkfVxl1c7ZnL8/yt/B/72Jp5I/jLwou0wjW7gGpxLM2+3COORPIldZat8nd6ofb4qdZUIlzbAuxpnaEqfIs0873uXuJjAaNkgXnlmihPFkPSCLgxIMZy3R3bHMpa+S1WujjTA==;5:nKDEEbKOz0V3kKUI4z+4Ibwb9FYFX6WIV1c0QJsICqgd9u5rrXYxSsdxWy9hovHZozOTjAaDJAMSNvO8qzLiqv7hCmPCSL+7KrdqMkWP7p9n+QyPZEVaULqkL+f6KPsMjOtrpziSJT5+fwVwT5J4dRVZcXUz3ZzGenMjp4/l5fw=;24:OyGtXZslD/+2aqCDQvOD6Ykd2Xk8nOWw82268jLywHMZ9xsW296R+yeXwyoLtg7N60hz0VklS8TP3Gkr9ZbjgD+pDdJXPNBb3wT/mXjrMi0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;7:4IaAy95Icw661UMRoAkl065eTqz9mDabv7K9B1gtf4dNCkbBeLEOOrOi/eIlOPsRhfwCD2zu1xoBpYqp0zLk8AKNER+sSfAVS05bKgOpJERQ0PGcfaIdFbqrkJ81db5e13NNodeQEY6YDGsa5pD4SGxBzhg7TtzghzMusixGHct3RBC03fSLq0+tCdC0/AIQL2xpYxs0KtfzfdG3jro1+55PLYY5pLAYkvPdq4k6ioleBa5R4E7AmICRq532S2NA;20:UxxENOEF9bDn8Eek9jx5zrju0JzEwIIun8Ni3FEUxHr/BRnGIkc9ZikWhoGmQ7vWuPHmyGRoR16CT/QWg/oUcRVm5Bz1xIHnEW2c1Rq2fllAcYSFCEjz89aR4rYgQMzS0H+fTM/CE0EdK2qi1o1HfAS2hmfQDYVcLSjfsAJMnhc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 12:08:09.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ec211-2018-485b-a4f3-08d5d6a67dcc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 12:33 AM, Shakeel Butt wrote:
> For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> allocated per node for a kmem_cache. Thus, slabs_node() in
> __kmem_cache_empty() will always return 0. So, in such situation, it is
> required to check per-cpu slabs to make sure if a kmem_cache is empty or
> not.
> 
> Please note that __kmem_cache_shutdown() and __kmem_cache_shrink() are
> not affected by !CONFIG_SLUB_DEBUG as they call flush_all() to clear
> per-cpu slabs.

So what? Yes, they call flush_all() and then check if there are non-empty slabs left.
And that check doesn't work in case of disabled CONFIG_SLUB_DEBUG.
How is flush_all() or per-cpu slabs even relevant here?

