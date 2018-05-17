Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEQLjw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:39:52 -0400
Received: from mail-eopbgr50099.outbound.protection.outlook.com ([40.107.5.99]:25129
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751280AbeEQLju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:39:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v5 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
 <20180515054445.nhe4zigtelkois4p@esperanza>
 <fa35589b-0696-e029-4440-d91dc4c9ab2d@virtuozzo.com>
 <20180517043340.wmm43ynodqa3zefq@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6ee5447f-d689-8930-3459-cfd343915aa4@virtuozzo.com>
Date: Thu, 17 May 2018 14:39:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517043340.wmm43ynodqa3zefq@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0317.eurprd05.prod.outlook.com
 (2603:10a6:7:93::48) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:nZfi6nqRboncNHPHe5jWp53MXsKyj0IFoXiMqYjYI0/n6Ybg5GziWkS/U/zMX6FYbhG6IsDOp7Yza+l8asyeUx0Ev9jAAZjyv+fz4dOg3BgMxbnKjfhg2Mhs9F0BC4iaaVHFejxJV9qJWfzkSlrgFW7ofh7HCPJxyOFe1k2iTRBkO6v2AI1Z1s6bNTFrPHKozXngAGSBNvND8Ov2/4o4bB6mk0zrjLYLyeHzXlr8H0MQiXIrrTfcuxW4MmFN0XPR;25:k+jiRhUtgI/EqFzFPtapakGu85eSkbGH5CpNJpRp1UZnNV+AsQef5tSNTGQJ1upDy/blNjdeJ5qoHkfTFHQMJYj8FRbi4Ud402Z+fy/uM30X+jDajH+P8P1vtfDxR7FpNrlaZBQLyZu2l8WYSmkZg/ku0YLvTdN0coayjTY3YS0HeG6V0/Y49rwkX47IsHSBqxyBO2OpTdil+e9NiwD74BClmVeqdl94ivTPrSJnDmYy3FNal+ZrCTGYtuGD/gHchEPRwq1k+ydFJ+UjfnUvF+t+9xu6gzvBMfI0HxodN8Y/w7HeNEWbBlkt+8fZXSe0NLTaE22X0M+FAXmGbrjOiQ==;31:kMfr8oWnjLScyvdJeS/0zIFnaH3lahUJ+f28kc+NmtYJnp0k7j3AbwFmr7TIRP5fzAKtV8rNgxtFWtmB2VPtQSKLf50CGgptjocDr9Etk3EQ7kd5yfO4BsKuUDpUIPvXpg0HYz4OuFi9yiN+6Xv/7mvLHHermOfY5cHrxlNpqUCKVDuaFPizRJ9+d84KJlKfdxugQ9NM8k8YQwrkffSPrK47M40XsPMwHJxRlv10uqk=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:OW1Ih6UifwrM2eoYbtsBj7xGG+iKzYS9NsXrUIh/BJgOKzKAkdZf02Ezz3AAkZx2k431ETKYeYRoA5LirYKL5okgBfmXDDYa8GVLLZA6En70Axdr+C57fm3HhVR3fuc+eBPkN8JPT5u2ZB919izvctkEebG7NKN2YrG3iPm5WXu9lIhba4ckYj3/Fa3JwTPW5iHK0a8oDmDj73L2KrnF+pJIKIFWq1CIwo9UkdxE+Z5q6R2eEQAMzT+QFHnw3kO8pTnPiMlgUPYSnURKQYX9wWZ9doPmkTXVufAn2qnsVJEYylPLbMKAL69x7QJol2C829M4aU5d+FErtOQ5/acTuZa1FSTrZYsu7eGSUVrfSH69dFnElAJ+g/NNCTXAw0NGqOmS5e7HgJq+mqFLbU4mvga7sD6SMmefI+GKSzUSrgv1h8++YcZInNxEqxCI3Su6XfqKnh+uCuiwSKsvL4LBagb1dxpLpKv58tyqjjWfiXGZ6qtCZMicx0mxW/sf9RX1;4:f0I2piR1rSDDMIa1P5RPqKbSOMVKpeC9aSes+YGo1TKfaTwiADOiUcMgqDkNwLM1bxo0XIx92vED8b6wb3eCYBCfSWw/pCzqRAbzzHZT9DKyDTxT7WacpMrRfx3sFUXBFLFsYKc1qg9LFF291utr6xLpPfBCBVtGrdbh0IwIi8NqtPSH0A/ztVQJXK8J82W9FjQVu9OA8pfYJ3MtZh0O8w9AyL8EeR3gTlgxqv5yWA4SGmTiBKs/PdUk+2E65nogGYmFRCOJAP7Z4BeEWjeRIw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133003B708630BDB208D3326CD910@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(39380400002)(376002)(366004)(346002)(396003)(199004)(189003)(5660300001)(65826007)(6916009)(68736007)(229853002)(6666003)(230700001)(25786009)(6116002)(3846002)(486006)(31696002)(7416002)(86362001)(8936002)(93886005)(107886003)(316002)(58126008)(81166006)(16576012)(81156014)(8676002)(305945005)(478600001)(4326008)(6246003)(39060400002)(7736002)(2906002)(97736004)(76176011)(52116002)(64126003)(53936002)(16526019)(59450400001)(6486002)(50466002)(11346002)(66066001)(31686004)(53546011)(65956001)(386003)(36756003)(446003)(2486003)(23676004)(52146003)(105586002)(77096007)(2616005)(47776003)(65806001)(26005)(106356001)(476003)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6WlpGUy9EdUFOZXBieVlBYlNsK09mbzR5?=
 =?utf-8?B?MmxoYWR2enVhM2Zwd1cyMnJDeXd5THgwclhIMkNway9ZNTFPK1RnSUplbWZ2?=
 =?utf-8?B?VldZTkZFbktrSldXT2l1S2drRUVaRVlHSk5FTkdvbjNGcHhRNWpuMnJUVVFN?=
 =?utf-8?B?TWh4b1VBV29jdURUZitUcHJKN1pLRnFlV3JYQnkvVDh2WVVUVnV6d1lpMFl6?=
 =?utf-8?B?YzlhQVpkTjVBMFRta2VqOXBYWTlQSzVDMmJIdXNxMW1GVkFuWVRZcnNieHBv?=
 =?utf-8?B?djVlV1hZaTMwNVhSWDk1L1hWV2tyY2hCSG9sSXR6V1hYNElXWEI4MFVIa0Fn?=
 =?utf-8?B?cGpzSkVVQWhsbjBJL2ZoVmhuNDRxZTg3MFQvRVdHN1ZtOXlkbzU4RlROUERJ?=
 =?utf-8?B?aGpkelMxLzhQMDJBM3NqS3lzWDE2RUI5OTFhTnU3ckduVHcrNzVIV1JUSUlM?=
 =?utf-8?B?bHgydXdvYThMazBGV1RSRFZWS3RiM2RYdjRUUk9Sc1RBZ1ZLakVkRHBaeGFN?=
 =?utf-8?B?UkxLM2czbWpRdlZUamVqbG9GaWJ3eHFpVlFoejZjc2tTWXFoWHV3YU9IQURJ?=
 =?utf-8?B?VVYvQ3UyOXVaYk1LVFB1QjYvV1o4alFGbWwrR2NuOWxIMHdjLzNid1d4VzVm?=
 =?utf-8?B?aW9xNGZ5bWx6VEsydVpWMFE2dWxJVy90UUVIbUJldmxXVVA3THNCL0J1aE9t?=
 =?utf-8?B?aTR0cEVqR1JhMGNuSFFsUnAvMTR0SHNYTXZ6bDhCbVpuMTVkbk1WRXNOOFRV?=
 =?utf-8?B?cURvOWNjUjVBYVJzWW1NWkxqc1RKOU8xOTBaZ1VkOTd1dDAxSTVOUTd1aXd6?=
 =?utf-8?B?TFBIRmliMzFqMlFoN0hNR1B4TXBKcFkxTHF4YnB6UGUzVFFoZnlGaTVyWjlw?=
 =?utf-8?B?Y1RuOHpPeHlydURUK2RXaDR0SnRhNlBmOWc5OTg3VGpNUFVjZWdsdXlQaGF4?=
 =?utf-8?B?dldzNE1VcnVJUHEvMEp1WUM3SU03aTVwT1dPZVRkME9sNnRzb0JyeHM4NUZv?=
 =?utf-8?B?SDdTamFWaitnMld6ZTRFQzBzU0txRXJCd2lKY3NiZmE1N2xlVW1WNHFLY25w?=
 =?utf-8?B?bTJxV0ZSZ3lnMVh3bjVrQzVDcDNOZWQ1eThCSEdXRGxveDE4VTBPZTVpdkpH?=
 =?utf-8?B?RGR4OEhQMEZiZ09idGZoLzV0cVRESUszV0diSEl1dk56VkFBcS9JZFd5a0Rp?=
 =?utf-8?B?KzVhSXZnS0xZSE83T0pIa0FBZXp4dzVRR2puMVh5Z0JjU3dDOHdnOVdoczZq?=
 =?utf-8?B?a01EUXIydk1qNm56T1VVN2NxSmpLcmVnL1hyNUtJNEoyN0RZN0REUWNOOU9H?=
 =?utf-8?B?Tm54c1Q4WVB6ZTZOSkYwWklaSUM2d0poSkpwMm9va2xvMFJqMWVXdm1rMWlR?=
 =?utf-8?B?eXpTSmp4Y1dWNFN4YTAzTVZYajNVUGY3bTkzNW04RUNPVjQzR0NSNm1xU2pa?=
 =?utf-8?B?N1VuYWZpZGgxVmYyZmRIRXNZeVF4amJyMmgxRThGSU90WVpqblJDa09ZL3Fj?=
 =?utf-8?B?Q1JTalYvUktEZDNMa2tXN1kwblVucnpiVDhFRlV0MDFXaHNtVTNXdEdaeUtu?=
 =?utf-8?B?VTZxSElkWWxIWHFGVW1oQThkcHROVjNmYmg4VWhKVnVpMC8xMWdEMVNmOFR5?=
 =?utf-8?B?VU5TVlY2dzNZTVJUU3ZnTU1BSFZJUE5GU0k0dEg0NXVvUlRqaWViSWIrRGNt?=
 =?utf-8?B?UlFRK1VlQXo3VVFjRUF2R3N0dFZrVHR0Mkt0R2NNQXRqRGdIMHZueU01b1Zj?=
 =?utf-8?B?ZThOTnRrK2dBeEUyOEROU1pOOW1NQjVJSG9rSGN6R0JDNGFEc0Yzb3FTbWxK?=
 =?utf-8?B?T1I2WTliWW1lWFAySjFNMXVXcGdGcHo5TDRZdHhqQ3hvMDd0dHk1T3VhZWxD?=
 =?utf-8?B?TzdORGdneWtpQ3RsU3U3T2FCNDVVdzJXK2YrSFZ4Q0ZKdHJpdnY5aWRESS9S?=
 =?utf-8?B?SS85d1BBYlF4Z2RqMG0zZ1I0T01CdmxkTlcrRlhuejdNSVZ6VnNDVGx1RUhH?=
 =?utf-8?B?b21BMk1vS25pb29tMDA0OTZMUnpRcThwUnRNV0lTVjZuSDBXVTNtTDZXNVpl?=
 =?utf-8?Q?mpTLw4=3D?=
X-Microsoft-Antispam-Message-Info: xrye7ty9QW1324QpN3ADEM7XBiiGGz44RizF+45HGr3gAOjBxElQVjPtj0fXyZt1TS8erus2MqdQflBHqAFOPyA5dTED4h84+xYCjRU7iVcM/3RuyyD2hS24s2hyTgphBi8Js1knMPyZ+U1dAZAJq6A8kLykxK5Sajj+t8aeeTUoUF8Jun96m/V1+lSeDJ5W
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:ynTRIj1ycmpaOciLuWYncDwZ7KZC0nrzXNSNCYxQ9bAnK11OYsUGmlgR/Utxsj2ELS3DVlVEK2U/LDFvM5xvxvqKWvI+9IaR8nZQI7mmLL5NKAreAnzXG6an5+3JJ8Qa71664CfVVcZr2k/4J9fya5dEIrde66lKy9XoKHHPF8OXtCbg+8HaffCV+UkdkXavAcHkVXBOUWukfOTuReIDXUuXj4hJTp8LWmBslAy0reUvYPxvQjeFLK4G8/gWIKDaN+IXuDuox9X8+8T9W1Uhwvo1qY13IphvP3453NNri5TCwqrApNP1R/a9Lf88kT2Bwhd+L7+b4jZd3/KTnhy+1ekgIIM5c9hDwISN/Ik4Ik8de6ql11219nshTFiLLNNHSVWIdi4Ul0QxteDrIim/V38dc+X0wjyBV/4QPZ02zr4dqpkqTqAt0x3cqDxV0pUC03WgkT5fQeOOg7WA9UUa1w==;5:2SNdwijhdIgm9ljidzVcGvd6FuTgELL5KN8zrzRzTRlKAvEghGILEe4zVCchi/nT4zGMUardOFt/ndN174p5lohVcZSqbVNqZkSmgJGRE2IMwrfSfhyMruNFX8Tnb4B+7nozQxKaPexef8hN/DJc6wv6kI1/cUsBk8fWjagjPTk=;24:4KvR5q6DCOWfPsKxgHtop8iST1HTaymqmX3MkRRFfluo8YtC6i5p9o2lLJQvAU17/OVZ6MmUtZipaMyjBkscagwZuOObj1WkAXNSrQ5fUCg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:XVu18WvRJX39rweKS9EZi/EprNj5D6jmzX3ogMIUa+GQfBYievLIMFJ6KP/Q7uKNFMoLHq8FyCleYjCWXgPsadexZKL0HE8GI6xucPkpx+COXd5pL3llb8YTw+R3R3K7NQOfzibIbqqtc+CfUoqM6i9bMrBbvde/Ou+6TG5PmsqisLZMwMr0puVm1Qg6UELIdBp3J+7tDGg5Oanj8zOEp8LP4sHlCxqueSlK6yuaWEUl8TI9wQIZsuK2XIt3S3x4;20:qOCLUYo1LHeYGYQXpanHlYNkRo5LrUt47nXOBQ18t7d6h03EK8UvZvjEceGZPo5broAdU0OV4k2jGvOMWOBvRAYa4zsfZewWLXdG8mxEK7nh0OquK/ZaxaMfugGA4d62hcKdD21lL7dtP0XZEnD0A5ysoElHPZ2hQRFKrOmjZzA=
X-MS-Office365-Filtering-Correlation-Id: fb6a6890-0013-4b3b-beb5-08d5bbeae276
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 11:39:42.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a6890-0013-4b3b-beb5-08d5bbeae276
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2018 07:33, Vladimir Davydov wrote:
> On Tue, May 15, 2018 at 01:12:20PM +0300, Kirill Tkhai wrote:
>>>> +#define root_mem_cgroup NULL
>>>
>>> Let's instead export mem_cgroup_is_root(). In case if MEMCG is disabled
>>> it will always return false.
>>
>> export == move to header file
> 
> That and adding a stub function in case !MEMCG.
> 
>>>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>> +			struct mem_cgroup *memcg, int priority)
>>>> +{
>>>> +	struct memcg_shrinker_map *map;
>>>> +	unsigned long freed = 0;
>>>> +	int ret, i;
>>>> +
>>>> +	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
>>>> +		return 0;
>>>> +
>>>> +	if (!down_read_trylock(&shrinker_rwsem))
>>>> +		return 0;
>>>> +
>>>> +	/*
>>>> +	 * 1)Caller passes only alive memcg, so map can't be NULL.
>>>> +	 * 2)shrinker_rwsem protects from maps expanding.
>>>
>>>             ^^
>>> Nit: space missing here :-)
>>
>> I don't understand what you mean here. Please, clarify...
> 
> This is just a trivial remark regarding comment formatting. They usually
> put a space between the number and the first word in the sentence, i.e.
> between '1)' and 'Caller' in your case.
> 
>>
>>>> +	 */
>>>> +	map = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
>>>> +	BUG_ON(!map);
>>>> +
>>>> +	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
>>>> +		struct shrink_control sc = {
>>>> +			.gfp_mask = gfp_mask,
>>>> +			.nid = nid,
>>>> +			.memcg = memcg,
>>>> +		};
>>>> +		struct shrinker *shrinker;
>>>> +
>>>> +		shrinker = idr_find(&shrinker_idr, i);
>>>> +		if (!shrinker) {
>>>> +			clear_bit(i, map->map);
>>>> +			continue;
>>>> +		}
>>>> +		if (list_empty(&shrinker->list))
>>>> +			continue;
>>>
>>> I don't like using shrinker->list as an indicator that the shrinker has
>>> been initialized. IMO if you do need such a check, you should split
>>> shrinker_idr registration in two steps - allocate a slot in 'prealloc'
>>> and set the pointer in 'register'. However, can we really encounter an
>>> unregistered shrinker here? AFAIU a bit can be set in the shrinker map
>>> only after the corresponding shrinker has been initialized, no?
>>
>> 1)No, it's not so. Here is a race:
>> cpu#0                        cpu#1                                   cpu#2
>> prealloc_shrinker()
>>                              prealloc_shrinker()
>>                                memcg_expand_shrinker_maps()
>>                                  memcg_expand_one_shrinker_map()
>>                                    memset(&new->map, 0xff);          
>>                                                                      do_shrink_slab() (on uninitialized LRUs)
>> init LRUs
>> register_shrinker_prepared()
>>
>> So, the check is needed.
> 
> OK, I see.
> 
>>
>> 2)Assigning NULL pointer can't be used here, since NULL pointer is already used
>> to clear unregistered shrinkers from the map. See the check right after idr_find().
> 
> But it won't break anything if we clear bit for prealloc-ed, but not yet
> registered shrinkers, will it?

This imposes restrictions on the code, which register a shrinker, because
there is no a rule or a guarantee in kernel, that list LRU can't be populated
before shrinker is completely registered. The separate subsystems of kernel
have to be modular, while clearing the bit will break the modularity and
imposes the restrictions on the users of this interface.

Also, if go another way and we delegete this to users, and they follow this rule,
this may require non-trivial locking scheme for them. So, let's keep the modularity.

Also, we can't move memset(0xff) to register_shrinker_preallocated(), since
then we would have to keep in memory the state of the fact the maps were expanded
in prealloc_shrinker().

>>
>> list_empty() is used since it's the already existing indicator, which does not
>> require additional member in struct shrinker.
> 
> It just looks rather counter-intuitive to me to use shrinker->list to
> differentiate between registered and unregistered shrinkers. May be, I'm
> wrong. If you are sure that this is OK, I'm fine with it, but then
> please add a comment here explaining what this check is needed for.

We may introduce new flag in shrinker::flags to indicate this fact instead,
but for me it seems the same.

Thanks,
Kirill
