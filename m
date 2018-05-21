Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeEUJRU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:17:20 -0400
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com ([104.47.1.127]:35653
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751072AbeEUJRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:17:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v6 14/17] mm: Iterate only over charged shrinkers during
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
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
 <152663304128.5308.12840831728812876902.stgit@localhost.localdomain>
 <20180520080003.gfygtb6rloqpjaol@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9eae0da6-5981-1ab2-af86-0a62ee31ba17@virtuozzo.com>
Date: Mon, 21 May 2018 12:17:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180520080003.gfygtb6rloqpjaol@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:7:16::27) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:hsise9qZymYYJZxfH7j7UFHRTbSTJAumbHB0CNQpTUpncaN+4JERoTXy+OvPyUDUNl4KXz1n6CYoSaRYoAT2kyfDQMB7PCq99QjmQoWEDWySl3JGOyH81DXkCf8KkBZ1cXmY8UnAI6gYYwNWvtDpbOMxXeXIFKHyD88GXbU63+O5TivNYpwlNmdr7rNJ6leJEU45L270F0sOIggQMMZSy01sh7usl3nI0tg91/NFuZzvJOAwG/nEtj0QkDqK2WJL;25:Sylfjm0DlncfOV6Zn2G4WGUC5Z4erHx1BuL/rvCAqw7WUiECS+XY1CxxpuJVHiup8khXF5jmYmWtWHsYMrWwqLzLxEBL+qEIqJy4jeUf6g8/3icccGBe1R5ehwteWZipWIKcKsUokKrbyz4M8eoNGWuzDgmARatVaI6QZ2P4JVz98LBMWa73FII8M+mZv+1LSZBVS0i3ijdaY9NukLOhgQfoS0iTqFFoCZopg6n5PsL+iPqaDYz/Z5Qz2TBU2Bu/TJUIqf8nOY9XK8Z6Ynlcog+U3YNaC1oS0jTQ5h3bLSeIUVvC4+Aq4V+btsgU87sQRUcvL4S8gc0mbe9wn0JKBA==;31:OpAnl+QRyyiQ8KpEIxpPA/ItM85E5BHG0Beqm6yFkn75B0U4LRMzHwPtpdW6debb6/5ZE9LkVQaUZ46X/1Zd/iJAabDfFv4iljPVQ9Cz5hkG44ip6nbdGBKHg8d2K0eM+nViE0FUnOKxzd+JvMFEd6Ea8H+BDH6A+M3Cz5FC4ETKhsSlk+4p0KzNb95uk7i05iqPDYsG811mQXabQYC65lr713STHDpJWycL0h9M5kA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:gsbUIPKP5+OS6lXYQ2QHfnOGF4nqH+m6/sO/M0PnlaSUjo3PCLbk9s4ZYMjodCWyonC7q5sMK4Mo89Kue2kOQfCgWiFXEiRbFerqv4f7FKD02QWJh2lcYIBddUc9M1FbH/X/ngXpc2teMYNnXoDCP1INSJ+51X6jeRCxrjLoeMNcPA9dgMJ98EcyexwgUkSU8M/COaWj+xTTbDGJPNxlzAISwu2V+aFPgNm/CzikKoypb348wIOqn1AxnyAepVAX+Q4dB0JngTd73YBzX8PQ5TuIrIhKYLg4ylzNF4PRVdZXFBIiN7cplSJM5M+IyLMMayvGjAXsUNqLTBiCH/gcd6yyGFsohqUwtMxnxJbzNm+lM5P3fu/bcLm7DgjYZl8GRrU8v2KPlG4W7uswzUvF6o8LQnYbN2ZP8OFaQ6b+cp6AT2reF89PmdEIp8akGdkp2DVg6IW9vSMZ0lTHqlcv+J7abMWsxlgk2jnFv53aMICg0z/rczwzMnKp2pyLBS6v;4:ahXaQXdFwxaRV/agNP2i/q9vkgDFjEBe7IVmsBrQ9Ck1qIUVfLE5nPcBL6lYUxLySmpFU4jzf5pOiNn1DtEJCvVGS20eAdEeRpAVnzX9e5yin4r/T4npk1Y/JH9nII0ptJznKOCzyO3yj8CGDxw7dtq1TLR3qvrD2PMhKiqwgSl+LZT97l8Nucf6N6l21ULIQj0GzcZRGubGfZlx1ZrS8EnBgFF3KdCH+uYLiUYy0hkb6c2/uWXzRztX+egLM1GwFI+65e4xZ7YIvt+9Ul/YIw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337450754E93401BC286857CD950@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39840400004)(39380400002)(376002)(346002)(199004)(189003)(50466002)(446003)(478600001)(97736004)(86362001)(52116002)(2486003)(8676002)(26005)(4326008)(2906002)(7416002)(316002)(81156014)(81166006)(486006)(23676004)(6116002)(476003)(52146003)(230700001)(3846002)(8936002)(31696002)(7736002)(25786009)(36756003)(305945005)(31686004)(956004)(47776003)(5660300001)(65806001)(59450400001)(58126008)(65826007)(16526019)(65956001)(106356001)(105586002)(2616005)(53546011)(107886003)(6916009)(39060400002)(68736007)(11346002)(6666003)(77096007)(16576012)(386003)(229853002)(6486002)(76176011)(64126003)(53936002)(66066001)(6246003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6SS9WL08zMDBUaXF0akJ3TkZUeDBObStE?=
 =?utf-8?B?aFlVdkxCY25GVjFvZkl2SWYrSlRsVWo4dVd5VHJ4c2J2SU1hTkVsZG9mZy9k?=
 =?utf-8?B?QjdFRzVtSm9QVHdpUXNXbm1GVVFCMFU0bU5IcVAxZEdYSngwaHNMc2tSTUhl?=
 =?utf-8?B?c2JPeS9jOXMrd1B0WEpjQW5Zb3pwWFE5blJqTmYxOXFnMGwyWGw0L3E2Z2sv?=
 =?utf-8?B?K005eHpxeVNmNDZIK3NYb3NZNVJ4OVNTTWNYRjViaDhVUkgweWRJQ0VRS2pR?=
 =?utf-8?B?bm81VitydWlUQnZmMlVEcVJlMmJBWHlKeFRGM0Z3dHNoS2hHb1pJLzEyRnFZ?=
 =?utf-8?B?UDVwa0Z4M041VDRlL3kzOUY3bDVCRHU1LzQyZmNMc3ordDk4WDdlK3BZK2w0?=
 =?utf-8?B?OHE1c3UwaEpyS2wvNEtZdnR6MkQ5bzlUdVoyc05zUTB0M1Z5ZUM3cGdETzZk?=
 =?utf-8?B?S3gybG5ZbHd5N1gyT3hVdjRzK1BUa2JpWjZIOGViZDhXRnFCeVhrVzMvOUh4?=
 =?utf-8?B?bHhiL0JpOHdVRmI0eGF2SUNaRVZ4T3RnUkE5dFUzYmROY3dtMGVva3U4TzIv?=
 =?utf-8?B?YUhwUnhBZ2JoQXMyc05KZVk3bUhmL3dvVnNhZnBnQnE1T1JmVEJzemdiZjhX?=
 =?utf-8?B?NHFZYUQrK2lsN0NrclpUb2NZbThOQmxkazYydjk0RGhGOFM3YXVLNDg1OEdn?=
 =?utf-8?B?RHgzOXVsSzZ4SjJLRkZzU09pSHJxUm1FcTJmTmFETkl4QlJWVU9YSUQrZ21W?=
 =?utf-8?B?NG9CZmdMWjgzN3MxdWdMUzRHekdxMi9jSkptaDlXOXF2eERSMlVBNVIzRlRM?=
 =?utf-8?B?bWdHenVKWnMvUmZyMy9hak1PYUtmNm1MUDhXSGRyOTFWS3AyQXZzNm9iMU1I?=
 =?utf-8?B?VkpUbngxczhYQmV4blBDdHo0dDVydjFSNFdXODd0a05jWGp5bWo4NVhUWEs1?=
 =?utf-8?B?ak1QWlB2a0lGMHlHR0lNTXQvaWpJcE8wTEZRblcrQld4dDF1NmNka3FaWThy?=
 =?utf-8?B?Sm8rbnVwampKNXczU1ltSVVqV0RxdnhGa1BlYThBVWRQcEEweTRaUm9Fakx3?=
 =?utf-8?B?UVMyUjVHYlBQOTRaVC9NNmIxbksxWlZrbG5ydkhVN09kQ3g1Wkd6VmU4aTJH?=
 =?utf-8?B?UTBjWlh2ZzJUZ2IzenBJL0ExM0JOQ3pvNkYyeldLUy9aeDJ4dWxuVTBIMWN3?=
 =?utf-8?B?TFZ5SjJyTFhDS1R1R2puME9sNm0rZkJlUjZmWG5NYVJQVTdUN2xjMEtoQWRC?=
 =?utf-8?B?bWlvUFE3SXJCSkpsbnZreWs1NmlZRUlYNjhhd0FDTTBka01WVWZRSUN6MWha?=
 =?utf-8?B?R0F6QzRPUmprMDZjMjMxZGtCdnVsV3BDUWVWaDhMeXpYOHFhbWhRZXJQd2F2?=
 =?utf-8?B?RVluaC9vZE9OSVhzQUVpNjhQVk9XZHJKbFM5TGdGcmFCNnZPTS85a1ZPb2Y0?=
 =?utf-8?B?WW9wV1EyRXZoWS9XanpTSTBHRVpqZGRKR2NYR1hDTy9OaWt2d3o4NmttN0Nq?=
 =?utf-8?B?Y2hpS3RWVGRqZjhZY3Z5RkxxMjFqelBiY1V6N0VsNWpwZUlTd0xHY3J3aG5X?=
 =?utf-8?B?cXZSTlFKUDFlcFZwZTh6WFpkVkhMVllKNjFpTEF0U2JQRWlLeGpWTkNHbUlN?=
 =?utf-8?B?VGFIVjlmeVIvRk5EMEhaM0RoOXFhaURFQnZ3T3BRa3BnVlZjS0s2Y3FjZnJG?=
 =?utf-8?B?Qlo0SDAxeFU3SVh1VFROS1h2NnA1Tlp2NzhwZ2NTM2tZQlRiYnNYVlpwTmVx?=
 =?utf-8?B?VU9UeUNCT01IQVpJU3pJUnNPY2d4UThjdXZzVExVc0RUekYzTHVjWWNCaGxW?=
 =?utf-8?B?ZVhWMHduUzhqLzY5UU1NQ0VwTkZRL2F5WnFkcVlmcXpCam1DVURFdVpzTlVE?=
 =?utf-8?B?bTJUYkxxWlVLREw1UlpsNzJtT1h1bE9CeFh0VmhXZEplbWdzeEtNak01MGZu?=
 =?utf-8?B?ZDVqcm1TaFhNb1VUZUpITVRydzQ1a1FCK2NDd2NFODhlRS90VjBsQzdJdjhU?=
 =?utf-8?B?TGpiemNjeWhVdVBDL0JHVFIwaHQzd0Vta1duVkhuL0tZWitlY3BYRTBGZGw3?=
 =?utf-8?Q?BhEYzE=3D?=
X-Microsoft-Antispam-Message-Info: C3P+ozId2U4mrR3O34eyRUf/mGM3rdVrAuW44pSFY2Ev2enixD+LkCJNnnyL29hKsaUbuh+j784+Sn/Luxkhh28NBbS5T3pLBkWGrWWlnuH2A+2GYLcDO2kD4GAXPin7LtFdMYjTtH+x6ciWps8oc5dZrg7jG9OkbM5TcOn5LmGe5ijAd2QdPU2xbw8YKdNI
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:/FKGO42MoUIWUsZ+yQIYXZK3i4BvDMv3nQQNEMcppCscdfEShFC+WkY9WuexD8brse5vHyqhEsdbesHPuE6QyEtuyMJ4gCzXyitSanHo/lrM8zlhjwcj1YSPMDiybVI/UbhhK+VSL1bP+jPGgp/QQXOhAXyrTHKf5F+SlBJy5qMOUnNdJDNVMVKX4MTTc9hSegatnI0jYd0MdrN9YsQX7wW2K54P7Dxy+iJqj4xUJKfksSakwVx/SRCDHeUJz3PQXB67WPPy/NVNQWO8x1hsSdTsmuz3tTBsPYWH0xQv1x7qlBkgmyARe0jj2c9CP/Yg2R8BQILJznuKm0+vmEmftjtwKm5Ap4FKKVJtn0H12w+MMl0iz3OomGao0dcNB0j6urObJRI3iYrUvNMu4A0VBZm0/1Wul3rYDFTb0hVASCD+yUr7mlCBmruwGfr1lxaLpgkYba0iAEdGImJQB8n+Dw==;5:3Bd/6fCmyA1YekO/YYWjt7Sakc4gv7+dCDW8LWhBwO+i9valII6SgmzpXi2XatPoTkdNnkAokaq+q2Iy51k/kdG/xBLWC+R57y0uKhBxMj+7kIyk5ADUg0t2AftsjNQvjpi1jZY2EoMyoKJlfatc3rD3hwABiIGBNQ+OzpE5y/c=;24:TzVmduvyc25gN34vUe07EnpP2mq9ipb+BrrU80rmTuZczyW+cV9k2NOyAdSI4k/dZhWT0lzxJy7OksY6836w115uvjAE+dGvuStbaoKrDus=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:8TSYrALa7f1EmCw+h6qVrGvwl3OoXN2Yk0ZgODtFG2QECCmtK06KHeNoOmlnN4kY+MPLWaieBVIf/JjROfKD9LvL7xAC051qMaZAvWUOc7qahl4SnsuqEj8pYDVA3z3u41z33HZT/kligq2Ar1DZuOuz999+86NgtxPXNVh+5L1H010B7+CvQLT58pOcWfABaH7LvshFfzm+ifyqJR8bXuRh6Sou10cVaIOuKXhr3m7OsAo4MmTHPup8vmaaSXVy;20:7Cfxiv6f2V/WVT9/Aq3Z6HaqSr2GkZa1Smxr76dZTQXaTFPuq+8/0k176xB8+OA4I5E1vp7DA9Om6jYooe/quxeuAjuhX+s1kUcVSg97HhocuGvexAg1xaW9Ds7yH4lOw5Iq9cSB0U1tbdTSYnB3BjXveqdS9BioSSIX7BNxo1A=
X-MS-Office365-Filtering-Correlation-Id: afcdceb4-9b59-43c2-cdb7-08d5befba253
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 09:17:10.3200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afcdceb4-9b59-43c2-cdb7-08d5befba253
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.2018 11:00, Vladimir Davydov wrote:
> On Fri, May 18, 2018 at 11:44:01AM +0300, Kirill Tkhai wrote:
>> Using the preparations made in previous patches, in case of memcg
>> shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
>> bitmap. To do that, we separate iterations over memcg-aware and
>> !memcg-aware shrinkers, and memcg-aware shrinkers are chosen
>> via for_each_set_bit() from the bitmap. In case of big nodes,
>> having many isolated environments, this gives significant
>> performance growth. See next patches for the details.
>>
>> Note, that the patch does not respect to empty memcg shrinkers,
>> since we never clear the bitmap bits after we set it once.
>> Their shrinkers will be called again, with no shrinked objects
>> as result. This functionality is provided by next patches.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  mm/vmscan.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 78 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f09ea20d7270..2fbf3b476601 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -373,6 +373,20 @@ int prealloc_shrinker(struct shrinker *shrinker)
>>  			goto free_deferred;
>>  	}
>>  
>> +	/*
>> +	 * There is a window between prealloc_shrinker()
>> +	 * and register_shrinker_prepared(). We don't want
>> +	 * to clear bit of a shrinker in such the state
>> +	 * in shrink_slab_memcg(), since this will impose
>> +	 * restrictions on a code registering a shrinker
>> +	 * (they would have to guarantee, their LRU lists
>> +	 * are empty till shrinker is completely registered).
>> +	 * So, we differ the situation, when 1)a shrinker
>> +	 * is semi-registered (id is assigned, but it has
>> +	 * not yet linked to shrinker_list) and 2)shrinker
>> +	 * is not registered (id is not assigned).
>> +	 */
>> +	INIT_LIST_HEAD(&shrinker->list);
>>  	return 0;
>>  
>>  free_deferred:
>> @@ -544,6 +558,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>  	return freed;
>>  }
>>  
>> +#ifdef CONFIG_MEMCG_KMEM
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +	unsigned long freed = 0;
>> +	int ret, i;
>> +
>> +	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
>> +		return 0;
>> +
>> +	if (!down_read_trylock(&shrinker_rwsem))
>> +		return 0;
>> +
>> +	/*
>> +	 * 1) Caller passes only alive memcg, so map can't be NULL.
>> +	 * 2) shrinker_rwsem protects from maps expanding.
>> +	 */
>> +	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
>> +					true);
>> +	BUG_ON(!map);
>> +
>> +	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
>> +		struct shrink_control sc = {
>> +			.gfp_mask = gfp_mask,
>> +			.nid = nid,
>> +			.memcg = memcg,
>> +		};
>> +		struct shrinker *shrinker;
>> +
>> +		shrinker = idr_find(&shrinker_idr, i);
>> +		if (unlikely(!shrinker)) {
> 
> Nit: I don't think 'unlikely' is required here as this is definitely not
> a hot path.

In case of big machines with many containers and overcommit, shrink_slab()
in general is very hot path. See the patchset description. There are configurations,
when only shrink_slab() is executing and occupies cpu for 100%, it's the reason
of this patchset is made for.

Here is the place we are absolutely sure shrinker is NULL in case if race with parallel
registering, so I don't see anything wrong to give compiler some information about branch
prediction.

>> +			clear_bit(i, map->map);
>> +			continue;
>> +		}
>> +		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
>> +
>> +		/* See comment in prealloc_shrinker() */
>> +		if (unlikely(list_empty(&shrinker->list)))
> 
> Ditto.
> 
>> +			continue;
>> +
>> +		ret = do_shrink_slab(&sc, shrinker, priority);
>> +		freed += ret;
>> +
>> +		if (rwsem_is_contended(&shrinker_rwsem)) {
>> +			freed = freed ? : 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	up_read(&shrinker_rwsem);
>> +	return freed;
>> +}
>> +#else /* CONFIG_MEMCG_KMEM */
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_MEMCG_KMEM */
>> +
>>  /**
>>   * shrink_slab - shrink slab caches
>>   * @gfp_mask: allocation context
>> @@ -573,8 +648,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  	struct shrinker *shrinker;
>>  	unsigned long freed = 0;
>>  
>> -	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
>> -		return 0;
>> +	if (memcg && !mem_cgroup_is_root(memcg))
>> +		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>  
>>  	if (!down_read_trylock(&shrinker_rwsem))
>>  		goto out;
>> @@ -586,13 +661,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  			.memcg = memcg,
>>  		};
>>  
>> -		/*
>> -		 * If kernel memory accounting is disabled, we ignore
>> -		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>> -		 * passing NULL for memcg.
>> -		 */
>> -		if (memcg_kmem_enabled() &&
>> -		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>> +		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>  			continue;
>>  
>>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>>
