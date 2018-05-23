Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeEWJ6W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:58:22 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com ([40.107.2.121]:42714
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932278AbeEWJ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:58:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2 2/2] kasan: fix memory hotplug during boot
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>
References: <20180522100756.18478-1-david@redhat.com>
 <20180522100756.18478-3-david@redhat.com>
 <f4378c56-acc2-a5cf-724c-76cffee28235@virtuozzo.com>
 <ff21c6e7-cb32-60d8-abd3-dfc6be3d05f7@redhat.com>
 <09c36096-f8c8-b9e9-0bed-113e494f159a@virtuozzo.com>
 <20180522140735.71dcd92e7b013629a7f15f91@linux-foundation.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6642e0d8-671c-1c1e-3ae8-99ac34c3b667@virtuozzo.com>
Date: Wed, 23 May 2018 12:59:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522140735.71dcd92e7b013629a7f15f91@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0320.eurprd05.prod.outlook.com
 (2603:10a6:7:92::15) To VI1PR08MB3262.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;3:7ZNqFQcluApvcg6EGeSxTs8przo7+Qvvo5cAnxDOzZUttgwga2ESPPdOIGJhFzHPdumrv6I3ikrccPsv0Rc4f9qZ3DNzvpCvsvcE3iZOFRZyjBRmrlH19ta31ytqdPJFUMrwWRkkujgY8ibifQ0MYZEj9OpmqYdhQGn4m4dKAO7rxdJaii05/PdlidrDCYnNbRgPSn1JX/jsxApDJtyDs4BHXxl43LRhOWNdP8FI9RN7S+whgFxPWiaiejA0U79K;25:wCd2jzjSHfIV69EZzV2xSVdqmMVRUjvZliwdmb8/W1PoMB4LKybuEW6Zp2x9jRetzbS39oUpNV2TDWxwSENQGVEUtcZLZ74LbdN0QdTMc8nrUBNh4doyKNCMsK6Awq+Uwubmw940vW2ElpbTBm7HbmWrTb10lPoJS6BLPoM/5hq1k7ctYjbgtWH+EkFUTgpaj3lbdofvDfm5rN304T/yJmaYWrCeAmTIOnTm3PeSN4D+JU6AqptkTLt3FyMaBuvVRKqD4+U5nM2lI//TKy7zp06a+0mU0+QTDr7rJirHsszxh3t1QwLkdHuBOPQb7ODbcQ5zbSCaye7+8GUOzVAWZA==;31:raWwG/Q6EAe2N+8YxxrM393RVxNUCnprnlsxQAeKgpHrjR6bjB+9glUOrKtcoAuprbtxQDqyMcsLHWNyeAkBojhN8bd+keDEvAYA1gBbbZxXm0rUhiO/ubyox5BR15aAMvmxTCByW2eSmnGGWe8UJEWMj2un3T7F/o+pMt8U/mqLn253c4OtW+rSXbMO2StK7f4ZfJOCkFtKF0uElaZRG0DyIuw+YexNm/snHf0B4TU=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;20:UrdmwXliR9zyQIN0yhbH+XJbHOeteHKDEQyF1tn7/6hvxtVApLr+1s8HKG4AMWL4tV5Tf3wdc8FVofioEJ0ky+VWoltA0TmDzZFcj08KreSmzTjnCkhQyHzjVTnRBeVaHrDUHK9X7RYXaUYqA1id6J0cqaE2AUuKPcW/N/DartkDeBtyEy7yr5W1kSSx9ABBkhJO2VFBHjSuMvwnRg786KLz79ul9zIR/GGe6k4mdJoKjJDWoj/1v1X5d2cytDrZQ79fJSXM+8nEdj6+gFoh2pxau4BKHyAqbz0oulS+4XKFapup6AXxx9Sg8S/nTa499T2pTtrXqxG34wAiXJpH9qBWYXsgCqzbTBDQ3itspzsLxXHvzo2PtHOSLc1JSYHpUFtIffGJ62AOL/L4pQw1oc4GY8GwJkUCTIX7TeGI6yEqyy8NkEVvSnIWJwzTu2D/cdEAGXN0TkVH+lYy05tvryEGpiOSoN4wtSQHpU2ph2/qNhp1SmBk1UgGw2Tzq6R4;4:9KAD0kPrlfH5Z+Oom5jK+3uazqzez8VU2FTGh6C7Sr5gR9l/ueYUJH7N8MFn90cwvQOLNTIr6Y4yoqd9oGu88ZIDy2khqAc0aJrLhmJWIwxtP4RHfUA8c3M4L+1wiJw7rpj5LD9dt2KOwaMrXrGX1nu/YbKOQxqX4X6qk3hqhj6DE74Lm3lc9sH4MmabXQAIgnTfd5ID3o0zWWSWksT/RjFjcBb/lnUDmpw7mm82sYKaaPNrKhKepshvUvCs6jPdN86qrzJ3x7Fl8gDL4NfRz9fTBSLRZOVS+cS8lRncVNROFS+FI7Tv850IfLPMyYvXTlYAmcANXo206LtcTqCmPg67wAoSvmLC36jhAkUrQyA=
X-Microsoft-Antispam-PRVS: <VI1PR08MB326239FCF5FD4979F9BBFAE5B06B0@VI1PR08MB3262.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3262;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39850400004)(396003)(366004)(346002)(376002)(189003)(199004)(55236004)(386003)(53546011)(11346002)(446003)(76176011)(105586002)(476003)(106356001)(59450400001)(31686004)(956004)(486006)(52116002)(47776003)(66066001)(65806001)(65956001)(2616005)(52146003)(23676004)(2486003)(229853002)(6246003)(7736002)(36756003)(4326008)(8936002)(50466002)(2906002)(81166006)(53936002)(81156014)(8676002)(54906003)(316002)(5660300001)(93886005)(16576012)(6666003)(6916009)(186003)(305945005)(25786009)(26005)(77096007)(86362001)(230700001)(97736004)(31696002)(478600001)(3846002)(16526019)(58126008)(68736007)(6486002)(6116002)(65826007)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3262;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYyOzIzOkVJeXBrenIwSGNKSXJ6QytDNzV1WDkrQ0l2?=
 =?utf-8?B?eWFNcmorS0Z0RXdQbGlvTEFLdThIMzVDcmRYRlN0b0Z2RTJIZjBhOGRUV2Nl?=
 =?utf-8?B?MzZYcWczSHpySm56Y2EybEF5L3YxQWxJSVRORE16bU1oOGN2YUxCWU1IbnhZ?=
 =?utf-8?B?d29ua3lKQWdxWnNYZ1R1UmdVSWZzeVlCckR2b1l6dWFUMmZwY1pBZEVaMzZh?=
 =?utf-8?B?R0VvNkFFM010TEZVVUVaVHgzL1N4N295WEpKL2JUOTdoalREQjlsTE8zRzdl?=
 =?utf-8?B?RXFySjFJQ3hKVzFPcjFkVGJEcFdFMnlQYVByMnN2ODVDN0IxYUNiNTVhTTRD?=
 =?utf-8?B?NTZMS3BrTVRyMTZlNTR3NExOc2JJM04xc0NTL2UzazdtcGNkQUIwMjhOTzVw?=
 =?utf-8?B?d3d1WnFNbExNS040LzkzbFdEekZtbE5kaTJxcmdkd0pxSkk0UFZ5ckhQUm1H?=
 =?utf-8?B?UDRKQXIzTGdhRmF0elRQdDZyV0xZd1kxd2tjSkxsZThyR1J3TzRWbHhDTjB1?=
 =?utf-8?B?ZmxOYXRRdWRzUlFTQjVDM255UDBJZ2liR3IrWmp1ZHNtelhXMVFSYWNaSWFX?=
 =?utf-8?B?TEx0Z3NzdFFtR1cxT2hDb0hLWGl3b3dUcFBRSlp5SzVpSEZReHl4a3lpVmJ0?=
 =?utf-8?B?WGwvdUdaZ0JpNWhmOHBTbWlZMGwrdWxXd3N2M2ZMY2dyTXRmMEdDS05xckdN?=
 =?utf-8?B?eVlXcW5FRnd5NE8vZjl0RGdZQUhKSGVwUVJyeXhDVHVGeDZnTy8xVTg2UG9z?=
 =?utf-8?B?ZWEwTllXd0ZuaGpBSXhPWlJBVFl0YncxQWJLamxTNG1kdGVGUnp3YmRyL3I1?=
 =?utf-8?B?cUdKRHl1WDE4V0tMQVFhck1HQW9OaEdFRmVzQ2Q2VFMrbGRScmdSejQ0dlN6?=
 =?utf-8?B?azlGWVoxNHpBT3lyMGtiRmljUmRHVFpWN1E1cE1uMlJvWXJ2b3hUcXBSeG9l?=
 =?utf-8?B?YlZWWjhNWW1WY204U3dQOHY3U1NYNzFZY1kxcU5Bd3g4YzNqZWN6M0UxQUlt?=
 =?utf-8?B?Q1JlU0hjZGIvNEZReWhnU2Z2eHdtT2NMVENub3M5cnIvMHVYcC93UUhvbzQx?=
 =?utf-8?B?OTV3ZXZqaDMrUnBtZElSWnlvMlZjNGFKblR3eVYyZTlZUE8vbjBsbDhIY2NB?=
 =?utf-8?B?MXFEZVFDRXVBWE1mY0VGUzM4eDg3TDNNb3hiNWZwK2h0Z0NwWW1xNWpuMndT?=
 =?utf-8?B?TkFsU2gyZVRmMWJzWGhFSzRBUWNzUTVhVW02TEZDVTJwTWMxajhDRTFvYW05?=
 =?utf-8?B?bThvc1plYm91L0pCTmFmTWJhM2M4bGxPZGRwWTFEbFM0b01DQVZCTTVBbUhJ?=
 =?utf-8?B?S09OVHZWd3MrZDhYNlpPcUFKVVloWTRhYmNBUFZvVG04S1FvT1pvaElHakRh?=
 =?utf-8?B?dmMwbTVYck9QSnJ1YnJTMi9JRWJrN1lrZmNhcE5wRkRSdkNJbEZleVZHTkUv?=
 =?utf-8?B?ckVPR0Q0YVYyZzlKanEzVnFaam9idHo2dlRMKzFoVkd3V3p3ME1sSVIxaStZ?=
 =?utf-8?B?RDFleWZzYUFGYzVGWlBIcS9PdVhtcUNnTkdxaTRHQ0lBQWpPS2huZ25yK1Fj?=
 =?utf-8?B?RDdOL2U2L21XUjJCLzZ4dCtwUUVzd1JsZ203NVgwMUI5cG8rc0Nzdk9uRHZE?=
 =?utf-8?B?VnBuOThHdWlMcFhTb29FRzhoc2x1UkhlbDBKbVRSeU9ramMzMHc0K1UrNVY1?=
 =?utf-8?B?MEYyY08xUWw1T3JVNjdNdFdZRFlXY3d4WWkwWk5kaUY1RC9PMCtZV3N0YXhI?=
 =?utf-8?B?cHNoSzVNV1lEelJVZUF3R1VMcDV3cjREL0FNS0p3djduZ3ZnWUtRZy9yL1NG?=
 =?utf-8?B?WkFXcVpQOFY2RE1HRXcvUUZERlRTQkJjNHlKSlhMWm5sN1Jjamc2MU90NjZ6?=
 =?utf-8?B?aDI1S3U3Y2RlQ1lBV2MwTDNiQ3ZFelVyTzZBTVlyN1liL2ZsN0orR0ZLeG9h?=
 =?utf-8?B?anhLLyszVmw3Zm11Qk5VUU5uOWJRbVdtVzJJNVZmbXVrSlUxdkU4dlp0UFZH?=
 =?utf-8?B?V2RNZE9ZVm1CN3ZEOVg4L1BtTGxIckFOeXR3OFpkVlhrTmQ1WlNkTktxS29C?=
 =?utf-8?Q?8KO0=3D?=
X-Microsoft-Antispam-Message-Info: rlt2Kj5aajag+FrqjflxnoH3FYRrBXsvQji5lqS3S03A0jxVax33zdksoXhpCKB6NyIZXNTF8RrYXJp7hr4XvHMWTL6es0usyHCyIV1275J6wsjoBcj1BvQRQtK2Njhi9AI4YLsI6+MTWUjCcA4gQ13pr1bUOEGno3Gfq6O+/OFnQOBxS8peq8M296aQAIge
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;6:ysq9ufyKPtggb5RGofuZy5WOZ3EbPRdpbSjxbE9+5maRKXd2SdXPW9RmF4R0XUR/uSJPkvSLrYg1e1d0n/P6Cs/D6VIowFL8wuwkqcAonuTxYiC0coCYwG8+oS28t7Z95/GKIlWr0kv6/rbbDZ5VC17wcpHvIx7AI5XcG+Ctwkaysoia+/tHMpxwH4R3eORufCICSrFJ9p1mZ6QNoGtoctA5pTj6mdJKrv5lJSn94hrxJwwOcd3plheiKZy2mQ+e0vB2cdlJiiJEc6UslxAoVMk7EN/jIh/Hi5bjLWqoHtSXSx6Mo2+rtnm2XMFu9nPB5bweUFxFKgX4WhO8nYivOQnudIJvq0Bhnjfkb0h5EOn2ICxDVnGVR0g4wVEJV0UOzQV0RtrAokG4vJyP07NX7Sq1EN8Lght8v/ky00C/7S0L9VdSex52NCKGsGt5TpTmd7SDH3EJHw3ryx2yooXEsw==;5:b7lvY3fyBF/tLu6HFkzs+s5S4d9DbePVnLmmFShSozs9uetfKKoatxht4F78/BA9+zxR37cbrufKtncRrDi9B2e/KFAhl0ArpJ+ZRD9CqRZrytBQIiQlsZrsFUrT2A3CvI1W+v8IcBuNczopibF4VdL4t8PZAp5bRoLM5eQifuo=;24:IkVOMr6rfHyNG4eQS0LpouJSAgxplgq9cTLJBFwZRHZ+abab+OCIWpO1/DaceadbppT/m7cBAXpPByyANKHc91on79mgXuOGPyQrJoC9C6g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;7:+Uq/U8hh3oVGml1eah/asS+xpERfIHKopQ4dgUVLKmIiMGJF5OmbkUBsSEr8WtXnu5S7SCxdfvgGJ3/JMexMj05wE78DZfowO0NTPH7n3aFKEOS7Dovw9Fh1CapMZo8CQzxyKVnb69Q1OaRf9nd5OEHJnJJdHdNR2pEcJ6e285IhpKo1zi2AQjzxDCFViEgBVsiyVjgYautz0gnpm4FjbbKuvv+oUOpo6pmyqatxHBkn2ITPgdVBGRqn4qVCZsTn;20:e6921LrqSEg7SbXtsMlafM8vPzH5pt1gZkBAEBeDt9DAH3eIPeNcT6pIavZ0hgZ14blXTPQiEB0nqc65MOrsd0ksXchFAT42s8yQoqD14rJLaEzzU8+Dziut1k0coz+OdAf2wf99DPaf/08H916f4cv9pAsUGJ0i9zoBdtVmoqc=
X-MS-Office365-Filtering-Correlation-Id: 6e68e813-f021-4060-23eb-08d5c093b4e1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:58:16.3766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e68e813-f021-4060-23eb-08d5c093b4e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3262
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/23/2018 12:07 AM, Andrew Morton wrote:
> On Tue, 22 May 2018 22:50:12 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> 
>>
>>
>> On 05/22/2018 07:36 PM, David Hildenbrand wrote:
>>> On 22.05.2018 18:26, Andrey Ryabinin wrote:
>>>>
>>>>
>>>> On 05/22/2018 01:07 PM, David Hildenbrand wrote:
>>>>> Using module_init() is wrong. E.g. ACPI adds and onlines memory before
>>>>> our memory notifier gets registered.
>>>>>
>>>>> This makes sure that ACPI memory detected during boot up will not
>>>>> result in a kernel crash.
>>>>>
>>>>> Easily reproducable with QEMU, just specify a DIMM when starting up.
>>>>
>>>>          reproducible
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>
>>>> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
>>>> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>>> Cc: <stable@vger.kernel.org>
>>>
>>> Think this even dates back to:
>>>
>>> 786a8959912e ("kasan: disable memory hotplug")
>>>
>>
>> Indeed.
> 
> Is a backport to -stable justified for either of these patches?
> 

I don't see any reasons to not backport these.
The first one fixes failure to online memory, why it shouldn't be fixed in -stable?
The second one is fixes boot crash, it's definitely stable material IMO.
