Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEQLte (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:49:34 -0400
Received: from mail-ve1eur01on0126.outbound.protection.outlook.com ([104.47.1.126]:15168
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbeEQLtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:49:32 -0400
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
 <5c0dbd12-8100-61a2-34fd-8878c57195a3@virtuozzo.com>
 <20180517041634.lgkym6gdctya3oq6@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f2dec4fb-6107-5d6c-62b3-8b680895c5c1@virtuozzo.com>
Date: Thu, 17 May 2018 14:49:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517041634.lgkym6gdctya3oq6@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0111.eurprd02.prod.outlook.com
 (2603:10a6:7:29::40) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:Xxbic8UmkPk4kVEj2G2BF40KiCoQvr/m6tYcEiNLJcaYl2C2pAGA++kmSrQXQ7bELZwMCjlTYLXfkHzzIsA4aWOdIAa7U9CvKmpYezRCtZi9wLSE/jTSEArUTMRfk9vujPb7gZ0yjbK9luTNIMVNuJag8UUG87qzvoBKQG1luTT2m+hasTaJo89vCq/JXroihiaLsCiDj3wClDaZ5j+Yavw+V0c+GjTEA4HnW0C3EMuoJHRRcDJuoWcfYKTHVnEA;25:BOtDN9MWsGqcBfFQG8uEgS/4sYelGXhy9GazwTWcfBAkN9+ODx3Kee2hUTXVACf9/F8rQKv/5+YKp2GRlKvyB3uwO/Cf9lkVdeNoCvUfbP+bi4ZUU/nWqs/vSbChMZcYs/jh8AdmnKmfXY2/kfd9BSFvlv3dsN6SiavygzsxOBhjRVrnHCpf5iPOR2rwkfGvhLQLn6g+6EKgT/0jXCMr3LitP9Bjm0DwjkQvtbIFhtomdTVYH4T0VyCB9jWyc3oa3WJy3nsEDDWp8O9Dy9LMrcFvrfcRR/UNT/BetcexuBwLjXXj4/7KFVDOBhNiKPgJupXaXin6RVLIWgwMMqR1ew==;31:tRm5g2244oC9OoEctkbvRVlTHMvFGxU4k1LlpveP5HirtMcizuQJRac3zrnOY/Y+g8c0pk+4qsFeG/V2Z9i1QM6HzXEr72VIEAW+4OeMCbvvUIY3Dbyyk5dJewZNXXj4luIPuPetWSs5nweb7uJyRfNgx2Kp6kpWFu6sFOOiRRnttH1wb2dqZVmrqVnlHbORk9FzPAoC9R3ROAXJwaNB33MkzG2/si/S+GmK0jpYbPU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:c+/GTeuuF7AG/VrzCs6qUujgE3SZwu3lEgrOae+m3ZnweUlmdKKBk7pwIT/UEKJ3z5xyzfOsIcxxzYAGJPfas6l54yIEYdOo/t4vOyfK4cRKxLR3Hyby9HO1Hn7fV8fnTAo9dGvMPrK6LxhsuLuMQT5McX4v4KDeeHJgC3n+Hg7BPcaqUBuHP5nhMdfttrCUAjEF/tycFYFN68myXnsBizyhVNW3UZyNrVTYgw3jJ+ErClLUDcUdb7O1gRK9htcenPTTCUMh74hlTl8tQuVpm9iAMSCwr/3Wf+/REzc+8qgmKShzi3SpfYo3tKfdYtPzKqClauzMpBl9JMkh9hDJ5ZZjNbn88WWtwO/uya0phN6kP01oBL6wMvMNsZ4FmsKUhDFCGugJmaoGdEQDjaVmNxIYAIF/dNk39f94cN399DNL2piPlYjkFXdLy9RULOCV5pI2+RBvb7cX8AvFta+zz+2m4kv7a7Aj+lvl/tEt79vWQiX4PSdt62wI3PQcUHPg;4:OLRNvt1XuElxTBW8FpzGxJHmGtumYcHdXtTjMhkhSBYlEujigOi/kokayTQIOun1cUcfFBHO6p2MEh4K2sGoGnl4mwIQx5Y+q/WqAF8qmBu/vRV4egUMBPAvCnVKGOusmDkBIMoeZUheVEoylUKB6ShWCwkO9SZgQglTvFQ3lYFkGjeY93upGGR5zZyMA6/PkV7E+EFpT2Z7WwTd8jGHzznlxdjPAgFy/Bya+SeKQOAaKQDezJf1cmnSrJTLeLNm3piC+IFFH3QTmuWAAENiyg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13384C646ECFCA5B9C69C1BBCD910@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39850400004)(39380400002)(376002)(189003)(199004)(7736002)(52116002)(478600001)(23676004)(2486003)(52146003)(47776003)(305945005)(2906002)(16526019)(76176011)(77096007)(66066001)(65956001)(65806001)(26005)(50466002)(64126003)(36756003)(86362001)(6116002)(2616005)(956004)(31696002)(476003)(386003)(446003)(11346002)(3846002)(53546011)(230700001)(59450400001)(229853002)(486006)(6486002)(6916009)(58126008)(16576012)(97736004)(93886005)(5660300001)(316002)(7416002)(53936002)(65826007)(107886003)(106356001)(31686004)(6246003)(4326008)(39060400002)(25786009)(8936002)(81156014)(8676002)(105586002)(81166006)(68736007)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6S3ZXcmUwd3NlUUo2Z1dkZ0tnQjdtYzVU?=
 =?utf-8?B?ZENHZDJrZUZ3K0VKdldoOFhtbXUzbGIvWnVmVUNNN3NWYTlaYWZTemM2cWYx?=
 =?utf-8?B?YXlKZHRnV25kUGhVVWJ1aHBtYkkwM0RHT3dPUXBhOEd1UnVaaWhxUUdsWXlH?=
 =?utf-8?B?MHlwMklNR2xlaFllMkRva0txU09OdHFSZjlCUjlMbUJFUisweFdCUkphTXpB?=
 =?utf-8?B?aVI2WTR0RDhORVFaUzVVVVJUZ2J1cFM3MElYVFBYbzBvWVR6VzRsMTdJWlQ0?=
 =?utf-8?B?NGNNS3dzTkV0RXE4MENNSTVLSUZ6V2lGL2l2WmtmVWdlcFlXczAzUFFsVE9T?=
 =?utf-8?B?bG9NMFNpajdZNyt0bjBsWFBWU3RPb3dXc0o2a01DOVJmOXN2cU1tYmFzN1Ni?=
 =?utf-8?B?SEpqVDQ5TnFTaWZLMHcrdmN0VzJDRUZyYmdGS3ludG03Mmhvby9VYnhWenBk?=
 =?utf-8?B?Q0V0UTJibTI1Yy8yK2c2Q1pmekRGOWlCR3pOOW9vUVhLY0l3SnE0YmRzV0s4?=
 =?utf-8?B?MjdyZGNZcGRiT1ZidTZleE9VRVFLTTFVNEdMYlNGM3p3WU9aL2VRR2RHS0t5?=
 =?utf-8?B?eFU5aGtYRWpJM0s4TXpvK2hXSzcxN00rSHNNTzJTTTZnVld2UWVzZDYxcWFx?=
 =?utf-8?B?WDVlMzdRUmtjaVhlM21WZXdtWGI1K3NRZHd4L1F1aG1MWGRmazhFTDUvQldi?=
 =?utf-8?B?MUFOTisyK3VrNkZyQ09VTWxIYWI5Z0tCMitOZ25FMWgyQ3BxaXlmUmtWZDUv?=
 =?utf-8?B?NVduMmh6YXE2YVZwZ2hsWUV2ejluU3o5NzJZYzcwZUlkN3EwSUt1ZjVYRStv?=
 =?utf-8?B?VUR0UURQTm5hZ1cwZkEybWNJVWpCOEwyT2M4dnNZMHF3bVZrazRuQXFJYjFZ?=
 =?utf-8?B?OS8yMW4zM1hqSHRUZzZZSTF5YW0wSTZMRkpocjBsT0lYKy9wUU85QlpWV05x?=
 =?utf-8?B?dzRZOEVuTGFlZjNsWlZwMnZFMkQ4L2Fxdk9aQURvTVpuSkF4VU5KY3V3eG82?=
 =?utf-8?B?dGhScmZIZEdNaExJcldWU2R6V1paQzROSEpJcUxmVEZjeW5aaVl6ZCtKMkFY?=
 =?utf-8?B?a21pZGh3M1Z2cmRFUTgyWU83MFkzZ085UVdVWXJSSTJBVE5pZGs3MHkwTjNa?=
 =?utf-8?B?YzJDOU4xMGora3hEbERISzduUEtIT2ZKaVBrL0hrMXNnN05VSmlsQmNFWXl5?=
 =?utf-8?B?ZFdQY1JIeVU5U1YxRHZxK3JPVFJMQVJqMkFLeUR6RllkSUlGMDRnay83QTQw?=
 =?utf-8?B?WjkwbWhwRWp2ekpCWVQ5UHU3U0JPVlRpaEZiTDd4SUhBN3Njbk15NG1uTk1q?=
 =?utf-8?B?d2ZEQTQvQytkU1BmZFYrNVdHVkNGdCtvNVNtdzNDZVV2U3g3eWNUMENaRVRY?=
 =?utf-8?B?cDFOQ01uWTdSZUF3YURxRW9oMWpSc2w1dTRrdkpYOXdQL0k1aGorSmt1Q2t4?=
 =?utf-8?B?VWdOcG1meERtbUVHMnZPaHAyUnlYKy9vcEtDSFZnbytESENXVWgwcnJhdEly?=
 =?utf-8?B?emRyNzZBUklzSHdGbHlUczY0bVNPU1NBNXVqa1dCb0tIdFllWnpFTkRmUysx?=
 =?utf-8?B?ZDkrWWhXVkdnOGQvdWk3MGh5dkZlNkdSTnp6Vm5uMG5NYVFtdmRheTZhK0ZI?=
 =?utf-8?B?eWVzR0d5MFBZOVZsRTRxZGl0OXBhR1g5RXpNSWtOSnhjeU45VklCanpXaldB?=
 =?utf-8?B?VW9tWGZMOUNsb21PaEcrazBrNnlQS0hlcWJnblNQWmF5T2lLeXc3Z3ZyRVRM?=
 =?utf-8?B?U2xFYmtscWFGdlpqaGx6MWR6L2xNb01wNGhXQm11K2NCVzNNeVVGL1hkaVlV?=
 =?utf-8?B?OVByZEVUcmdpV3JMbTM5SGtTMEZpVHBMd3BvdzlGZW93OThNNWJFMkVoOXlY?=
 =?utf-8?B?STdMTGgyMG1tbzdpazJpK3NKLzdma083ZWczYlNCY1Q5NzFNU0ltVTZxbitE?=
 =?utf-8?B?NWxMVzRHeWlpTERTU3c0QWVzaE5ONnM1V3lOV1JvN3J0TFRUZyt3dW1mblZH?=
 =?utf-8?B?QlY3Rlp6bzBuZytvTTQ5bTMyU3ZCOGNwMXltbjZQWUZCM1l2YU1wZDloaGox?=
 =?utf-8?Q?L4/8SI=3D?=
X-Microsoft-Antispam-Message-Info: Qy5zhOc+d5z9v7w7pAxunmVKIwQodm6qcoChZzYDDA/9xsHPbv1benZsqDyKQo4VNn818Yi1ZNyxr6atiiVYsVnq5GGFFvTZpCvcTYehmXZt71T3jsuoM5yr/goGfINWo8vrlMZTwLUfS/jsYnhDIH/O1NlWLpmATAkghVFc5t031vWUJoT96ddUno+f2/Qw
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:NvBrMrT3vhNs+mVedm9pjz+LnpvhnSU29kjLibJ5zhRWw+u5FNcF1HniAnwdmXts1XhQIUDBoDNJ5MlRU1RJhQXrokrLnZyjGFN1QvZgVCWg/7jZ0aCn18cFN8ytMY2GFl3ysR+zz3RAOmbt11S/F+Wr211Q5Cmc/XxY2jSiSCWnDuZoocnArZ5JsxefKFds6C44K5+fsAAW8NCFWyO5UQTJM6NhyyaA4SB0Xvbg6kYBah/NlklyPwxPJt6XzgLyUl5plAnhq/74UhQJYXPPfQ7sZibvf3RhjfEM2E5eiy1eg6UwNU398y2AIOimsFxhogwC0Xjc8Neodr4jqf4rOBHDfzssJheiOT9QRp19A1Q2eOir3gXxHHq8WyM35cNF8JUmDhWa2/ste55Bw5IfHJmRPTy2rUQxJXBj/OjkiXo+kM6ryxmBDT/9IKsVMn0/90IW8cgMWRTzvylFCZ9YdQ==;5:vFbRMTir9meA36+wg6CrsiU51v/6WyW5wVYiNXJfJ4fbIvBKLuqDD8nnyJcIl72vUtXAGOV/rCTq1Zagsox+DHRroLCmZteS4X5Cqjcw3sRmWyca0v+gt+LrxzqYPRD20OGNuoHI1wmPOSHf33RclU/S8EJhjopcY0Z4a+WyTWs=;24:z+JYPUa8HSL9PM3Nz6D3sWPFvn/Fi6oDE6rBrnuiTJ0Dl8LGcMu/etP04/XpbOO0hmshZRCMHhVUi/yrbvM9pdn4/PKIFcLlqNg3UyczMoM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:hZ5WQgOaS5OsMaANXT7OoUvnJWsLhVxIQ2cRbHqTbceM0iChY0qF0v/k2acurODvsZzS4GnlHlbD0mnduH7C+zysHsMAmjUTf3qL+63pUc2CBA82Ut0qMcru8z81TIk1b/fiiUsCtFe1e5i10OK+0vt18slYi7VcfMF9PAjKhVxRwZvfJJI5Ib4p44cn1p73oyaSpBc8cePV3ujYAsJb7OWjUhgExCNuTt4AxwmS3x5OFFTuLbU9QhFaCbPephtH;20:BoR9hqutWTnvPrAbhWuWpQO94BdPudKgUmov3jfElLtzKoiZ95goK8yFk/ougH/lbxehQX/l83iVJZxgdv/zDPtzKq2f8sBcni/ucpLeeBfV1BX/uD+MzDRTWhK8I3PpQb3Lx2wORol2PilZMlJno68NN7z07NgmpbTu+nzeXrs=
X-MS-Office365-Filtering-Correlation-Id: 32c7e0d7-deb0-4e5d-2aa6-08d5bbec3fa3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 11:49:28.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c7e0d7-deb0-4e5d-2aa6-08d5bbec3fa3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2018 07:16, Vladimir Davydov wrote:
> On Tue, May 15, 2018 at 05:49:59PM +0300, Kirill Tkhai wrote:
>>>> @@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>  			.memcg = memcg,
>>>>  		};
>>>>  
>>>> -		/*
>>>> -		 * If kernel memory accounting is disabled, we ignore
>>>> -		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>>>> -		 * passing NULL for memcg.
>>>> -		 */
>>>> -		if (memcg_kmem_enabled() &&
>>>> -		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>>> +		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>>>  			continue;
>>>
>>> I want this check gone. It's easy to achieve, actually - just remove the
>>> following lines from shrink_node()
>>>
>>> 		if (global_reclaim(sc))
>>> 			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
>>> 				    sc->priority);
>>
>> This check is not related to the patchset.
> 
> Yes, it is. This patch modifies shrink_slab which is used only by
> shrink_node. Simplifying shrink_node along the way looks right to me.

shrink_slab() is used not only in this place. I does not seem a trivial
change for me.

>> Let's don't mix everything in the single series of patches, because
>> after your last remarks it will grow at least up to 15 patches.
> 
> Most of which are trivial so I don't see any problem here.
> 
>> This patchset can't be responsible for everything.
> 
> I don't understand why you balk at simplifying the code a bit while you
> are patching related functions anyway.

Because this function is used in several places, and we have some particulars
on root_mem_cgroup initialization, and this function called from these places
with different states of root_mem_cgroup. It does not seem trivial fix for me.

Let's do it on top of the series later, what is the problem? It does not seem
critical problem.

Kirill
