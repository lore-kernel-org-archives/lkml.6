Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBTOfd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:35:33 -0500
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:29616
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750934AbeBTOfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:35:31 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
 v3
To: Peter Zijlstra <peterz@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
 <8fd80334-4d0e-8ed0-8a09-02a7e36a0eae@gmail.com>
 <20180220135709.GD25201@hirez.programming.kicks-ass.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b625cbca-c05a-afd1-fe97-a7a0760383c1@amd.com>
Date: Tue, 20 Feb 2018 15:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220135709.GD25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR06CA0146.eurprd06.prod.outlook.com
 (2603:10a6:7:16::33) To MWHPR12MB1309.namprd12.prod.outlook.com
 (2603:10b6:300:10::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e79e2616-1fd5-4cfe-4e36-08d5786f3037
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1309;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;3:T4Obs8ZINMa1r/PYdWw6hYos1eIVjV84A7gxNvLMAiBCuLeX5FkzcCnBe7JoXID+jmAG48w9Nls09y8R9E7FkO+eYyp6f/QFWbEdfTahm9TgDYbggcQZgdya34Vix9u7Dx2Yd3fJ3MVHx4Awump2UCw/A878OlGBIOEui0VfIiz1IQ9A3iDOGVk7pEN+LmMLaavf1SjqhM5BnmJ2YGIey8rMyUXjHrTai17LLWsnICO6RHpVYaOKxWbVSjZhIEFx;25:xkvA7IHB88XG/RucqtCuSjL9AycI/AKH2JIGnkVrjnvy6Fp/XaP3VZfa6ntpaee6b01C9pVOqoS7qNUAerWIEtUYh7Kh2Qb0mrpWfSQEhHuuWO+6ups0q15mxi3NVbyxJIanE6oaAd2fpxaaTqKAORv0ylgQWaMd78OWIXqipzFSVDpVRvI5RAUMDsWDer9qNb3lpyVGGLp0WnhfudlNegNldnTrAJcb64DTKiAgtTfAQdwzY6P0YTebT432KRrWrl4Nem/s6ThUw6RKNcbcQnVNExjwNkJ+Ff0sy3jcBWhhDOXhYVmneATYlsD2p3Vzg+DV5y2RDbJYSM0CpR/5dA==;31:c6F4RCxDw4p3StIMxorCDQb9+mpGuS8bpWxg10wL52bt79fHZuDBnVasCON+SgiJ7NlqUuJfPJ15TMW/vZ26IWT0BaGJDtu0jJj1ksOXnf2BxHcHgq+gn3XJLHkGvgtwvdQ8b8TAMQXEykdo4Xu4lAE5hFjgVXLljDz/60Dlb3S11fbbxEsvAMlFw4oaUgtH7dsYeIj4S9pf6ID/REw3o9CUUzy0294XJzVxCve8y7M=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;20:y9O6MmjIXzV6kgcE/pRiveobpKLSSdbKK5YI0TD8j9AOFuz5dmTRJfB2IdSEcvoDk6eRxP5sxjfMEsmmIg4CmPihnGmJGZcpsud98e1sy0cWAbpiiCM9VHHPaZegf6rGtBq94BKMyhIinlU5wLLOP0NNSMqDZbkOfkAxTU5M9Nl6FbURsnGOF307g0YV5KnFSHr1tMd2KY8PfVFYwpUGtrBJ9cobCnD6IDmI0sHuLO+WqQKys6eYvBqQjaYM8hrIeXpc/UZE1U0sxtroKknCh1XAhY3doWZ5BegrqKK3hkVApuY6DOREffrS9bg5+Yl5QVJJFTJEuZtUiu8kGYNUAYkpT0ta5Qxzs1sWA98FK3MVpf6U4OxCx8rwIxsK+pVmrUqCiD+9iHZnI8fCW/+WtHL4Ux05qnPDDeIv68Wu8ieuyo3tzV8FtfSsIUwFwxKU34l1q4c/fn5gdTRpa8bwdIds3ZC2KNA8syCL0WcT9UxzWf9kHGPaE88Jiwy6b6fm;4:cZeZKo8zOamPcWQV51EeWmbLIeAsxayd6FdWO80wxzmCGeKvwErRKiVOFYd6DTCZJ6gTGbzcPeRtqBZ01tUXamKkG7NhKENf62DNk5Msp1/89hpLI0SOjkHUOI1z+2AMAmIAwSV13LF/4nnwU0w4LOaHIhgTcomVIFqOhq3nXIvRlyoxPDPsaq1PU58XCkyC2H8rpt1qfANIHEN9rzBOFDwlpuLpaS44iyh8I90GVuib5G7/w1bDj1aFPG2XGWqKMzATH/pp2hTL5A6amZJypg==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1309522E3C1B475CB4415BAA83CF0@MWHPR12MB1309.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR12MB1309;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1309;
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(346002)(39380400002)(51914003)(189003)(199004)(6116002)(5660300001)(25786009)(53936002)(1706002)(2870700001)(31696002)(52116002)(6666003)(106356001)(52396003)(229853002)(23676004)(2486003)(52146003)(2950100002)(4326008)(47776003)(6916009)(64126003)(81166006)(81156014)(97736004)(65956001)(67846002)(72206003)(8936002)(7736002)(65806001)(83506002)(8676002)(6246003)(305945005)(93886005)(7520500002)(36756003)(86362001)(186003)(478600001)(6486002)(16526019)(59450400001)(50466002)(65826007)(386003)(76176011)(105586002)(58126008)(316002)(68736007)(2906002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1309;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMzA5OzIzOlNqamxZemhrMHJtZmpwSTVoRTFlaEI5UEhN?=
 =?utf-8?B?ZkVZSEpGUXIzWUlYMEIyOFl5SlJUMnR2TkozNmpQSXF4bFUyTWUwVkJVT2lz?=
 =?utf-8?B?YytsSkI3bDhTbmVhRHU2cEJya1RYZFpyMzRsWkxobXVwemZ4a2UwM21hdjBz?=
 =?utf-8?B?UEVTZ0s5T3VUSTJGUHZTQWlnaTBRZVRWSjlVNDc5L1M2TWdnb3J4VytSSDhr?=
 =?utf-8?B?SC92NlFSZUlhTFY4SGkrUStmUW8xVjJRTUwrOWhlTFU1bk9vT3J2WXBEaXJ0?=
 =?utf-8?B?ZHM3d0xSYkRQZVc3Wmh6RjJQOUljSHVrU0JZdUhOOVJiamFnUGtMc1ZVdzY1?=
 =?utf-8?B?MjhFWE1Rd2hmN2l1bjlyN1RRYmRXclBHL0g3RWVoNk1XSmVpV1g0aXRqTHFn?=
 =?utf-8?B?a0lTbnhEZEhZbG8wVVpPcjlrS3JLenZrck9MSWp2R0VzSW1QaVRqdmNrbnlz?=
 =?utf-8?B?eWZRTE5DL3VVOGdNOS90dUJGaWR5YWxNUmM4MlFEeEJrd3kzSWNGemc4bVBa?=
 =?utf-8?B?K1pKQThTVEFsaVhVMDRiQks2ZUFsaEI3d29OdXM1K2Y1ZGw3SlhCcW1sWWEw?=
 =?utf-8?B?dnFXaitXdzcrajMwdGNVK0tzRE1oWmVpRnk4QVYzRzBKelFOanpDekNTaitX?=
 =?utf-8?B?a1NhSGUrUHphS3JJRStQM1U1Yi9UM0lHbG5lWVBCWDdyNnFEaUJ1alBnSUwx?=
 =?utf-8?B?WGQ0RnplRXhFV1FaSk1OdS9hWGJzamgrWWNXMjlkQ2hwRi9xY21YMDcrcWU5?=
 =?utf-8?B?UTRiWnV0eXJ0WUhwYUlHaUY5YzVqQUJ3cGV1U0s0Wk1LUEdTUlNjU3o2QjJV?=
 =?utf-8?B?TEljcy9wNEFwbC9ZYzVtTGRraGVVQUpGQ0l1MGtiVGJsRm9UWit2WFBZeTZ6?=
 =?utf-8?B?UnRUdWZ6NW40Q3I5V0tLVThXSGFWc0RXYmI1dHk5TkNWZVRmQjc2Ym9WNEVm?=
 =?utf-8?B?dVFoK1JqOXlEWUVNQ0xnc3c5YlE1Rm8vTnVUems4Y2pjVkw4L3BWc2VmaERy?=
 =?utf-8?B?eVJjS0tnKzZMT0JmV2NPRjhYbGI0WU5EOUxKSVl6eVAwL2R5N1NHeXIyUEU2?=
 =?utf-8?B?RWFhb2FweHBueStkUGZLekVqZ1BFR2VHRFB6eW5vcXA0aWZyUzg3WjlzUlM0?=
 =?utf-8?B?T1hVazNFTVVEYWs5WGh1eVYzRGY3aGVod05rZFdBYVkzZWdPbm9Ka0Z5N2oz?=
 =?utf-8?B?VXV3MmFrVGdWVDVNMXJCOFljV2Z2TUpUdmxrTWRXOUNXOGNHYlA1bmlXZ00v?=
 =?utf-8?B?T2w1YUlMazlPMEFjVXFxYkZ4MXd1LzBYUERjZ2FCNUlVMGlrbDYyZ25RZitC?=
 =?utf-8?B?UVFqU3NUTXpNbTkyVTRDNjBQc2laMlZOdkV4K1c3VEZGQVhDZ3dWTnVBTkd6?=
 =?utf-8?B?eFlISUV0V1pJR0pEN3o1eEdMOTMzbG5SMi9wQlp0ZE1jTlpMWFZpUFA5UmtR?=
 =?utf-8?B?dDhBVWtJM0hORUU5U3RPNHNVSndSZTJzMk5zM0Z0TStWL1hYNndra3RkQkZI?=
 =?utf-8?B?ajUzMTRQdkw2WmhhbG1xb29aamVicnVYa0x6dEVDTjVMUUpGc3A5cnh3cW9J?=
 =?utf-8?B?QTM4Q3ZIcWNZWTFVa0I1SnFhQS9ZMHgxY3lHNm1LMG9KM3A3bUtFQ1V6aG96?=
 =?utf-8?B?dzF5YlNpMEhDcmV4cGdZZnRaeE5HTnAxZXpUOUlPVHF3eHYrZmVrRFcyRWJz?=
 =?utf-8?B?YnQ0THlJVjhnaXdWTDNEYU1DVi8zQmRkRnlad000cDhKQVFQU21iNXk1cWJW?=
 =?utf-8?B?TUgweGVHaklQV3FzVnZZMW55T2c1cEo4dFo4aldJVll6UlFTN0djaHJSUWUy?=
 =?utf-8?B?Zzh3ZGZGSWY2QnMzdmVyekdRaWxlZG5UYXA1ZVBZL1VGcUNGYXd3K1lGcjlo?=
 =?utf-8?Q?SQo6TfChuY11ERgVweJny21DmZxXqNE6?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;6:Wd+/e2uOA950PgXlHb5GfVneUPtDBEA8I3NqEt6O+/vN7aa2jmIDID6eKPuqe5/UJhDRncELKAokmJM5jhqwhDYr9mMs0+H78qv6RX6dfZQCcJEV15QzQo3z9q2RtWcYT1aEPauLzOtbUV7JvMnpjc1/omWpQacXyDliV+jD9Q4ssqXckm1ox0+fnGDkAbtUyqlPJimtzCwQ1MUE+3RUWViPbAVXl6xqv7T0JoH00KVUpxAO3hnIQLSxzxy9g8fvG4mBolgtbq/EpeHDE212votwM+T/78NnlyrHitY77FmjqIi7hPWMoOnxe5EQGIsm0jym58Bq7iGufDqqUYiBlgRoG7vHuS7h8DaE44/4TJs=;5:egXrevchPjBFKy0b+Zc5thj3Cqz56GYl8gAOhWVIvlxs7PpU5u98TgeeGto5ScIzOKVdnngadgfrTd8aeuHPrFRQhoBaHhq8Q8MaKxzDXNh35wDW95BRo3bnh5s3puD85C3gnV1yd3PbtVsWvqI7t/PIK0RcufImB4uzqDL+V1w=;24:3sJHTsNCQhqIQtUPc6g8MHSVTuPF5370oB7/TRhcgHSsECNSi5PPPkVPmC94BG47zOR0xia86f/IUcb6RX78K7nA/2dC4VZUydEWKfNI9pw=;7:cxNb7aysnLtBUMPT5e1YkI0gN9Nsbp9mFmf2qH518c+1m10DMNEzdlSekH5fkDMZDcE0CQChlCAIZPG6mPpc6q24BfVTXoDffwsdoQOnKcmUOGHi5MmfZJx5JymOHUu8JyYZXOF4Au3fJVakUALYzFojqkwjXMAaxiASX0pbKK3DMLqd1N0fvtdwvZanmhAwvQHXsyAww7agVUFVu6PVE5zMb5L8FJ3iassp00R/OhTOj3x+iEhaxudcai7d17AE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1309;20:GwH+B+VYMdIoF/qe2LHHRqohn4Z2QO4ea4rtv8rjzH7hmlRi4RWdFXZT9WRkONSDRpWIY9DA7xYXeAZPJTDoQKRB7ZGyrufhOL8wEBtE9cfEWYKlSlB5j3wzCH7IkpJt423/hCNxzSMGYBga37vm2sYwYWzNYLphpo681kF8no1wrS7h5y/AkDuLTi1h1imSoP0HD9zo3A8g3eb8lSnR6bankykLR+ysC+fWoq3OpMBajFpJoE/CAd+z5xfxNcbB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 14:35:27.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79e2616-1fd5-4cfe-4e36-08d5786f3037
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.2018 um 14:57 schrieb Peter Zijlstra:
> On Tue, Feb 20, 2018 at 02:26:55PM +0100, Christian König wrote:
>>>> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
>>>> +					struct ww_acquire_ctx *ctx)
>>>> +{
>>>> +	if (ctx)
>>>> +		return likely(READ_ONCE(lock->ctx) == ctx);
>>>> +	else
>>>> +		return likely(__mutex_owner(&lock->base) == current);
>>>> +}
>>> Much better than the previous version. If you want to bike-shed, you can
>>> leave out the 'else' and unindent the last line.
>> Thanks for the suggestion, going to do this.
> You might also want likely(ctx), since ww_mutex without ctx is
> a-typical I would think.
>
>>> I do worry about potential users of .ctx = NULL, though. It makes it far
>>> too easy to do recursive locking, which is something we should strongly
>>> discourage.
>> Well, one of the addressed use cases is indeed checking for recursive
>> locking. But recursive locking is something rather normal for ww_mutex and
>> we are just exercising an existing code path.
> But that would be the ctx case, right? I'm not sure there is a lot of
> !ctx use out there, and in that case it really is rather like a normal
> mutex.
>
>> E.g. the most common use case for the ww_mutex is in the graphics drivers
>> where usespace sends us a list of buffer objects to work with.
>>
>> Now when userspace sends us duplicates in that buffer list the expectation
>> is to get -EALREADY from ww_mutex_lock when we try to lock the same ww_mutex
>> twice.
> Right, I remember that much.. :-)
>
>> The intention behind this function is now to a) be able to extend those
>> checks to make sure user space doesn't sends us potentially harmful nonsense
>> and b) allow to check for recursion in TTM during buffer object eviction
>> which uses ww_mutex_trylock instead of ww_mutex_lock.
> OK, but neither case would in fact need the !ctx case right? That's just
> there for completeness sake?

Unfortunately not. TTM uses trylock to lock BOs which are about to be 
evicted to make room for all the BOs locked with a ctx.

I need to be able to distinct between the BOs which are trylocked and 
those which are locked with a ctx.

Writing this I actually noticed the current version is buggy, cause even 
when we check the mutex owner we still need to make sure that the ctx in 
the lock is NULL.

Time for v4 of the patch,
Christian.

>
> But yes, I cannot think of a better fallback there either.
>
