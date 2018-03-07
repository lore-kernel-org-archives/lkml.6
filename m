Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeCGMoR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:44:17 -0500
Received: from mail-he1eur01on0116.outbound.protection.outlook.com ([104.47.0.116]:51168
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751067AbeCGMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:44:16 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] kasan, slub: fix handling of kasan_slab_free hook
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kostya Serebryany <kcc@google.com>
References: <083f58501e54731203801d899632d76175868e97.1519400992.git.andreyknvl@google.com>
 <26dd94c5-19ca-dca6-07b8-7103f53c0130@virtuozzo.com>
 <CAAeHK+y4hze8CUDMJ_G6W+diBO88+WYu892SK9QAt36y8nbZYQ@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c7249bc3-8488-00c9-666a-8d31fb3feb83@virtuozzo.com>
Date: Wed, 7 Mar 2018 15:43:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y4hze8CUDMJ_G6W+diBO88+WYu892SK9QAt36y8nbZYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0005.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::15) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 865f9680-b212-4d3d-638e-08d584291ed9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:R55W4zBAbK/ZuMh8YVoF+VaBy2GlQNx2q2EUD6itYC2FJWIuRL1JI7j8tVAZGAmnsBlbfIRdOk3vbOj9UdJc1x50AML+H20H7Ff/g9SGAaB0uJuqQ7ZZYNa5hUXQjnXTJGXoMLsUKvWKQO5OtsGSTJIH9oIdxDigB3DMt9B1CZ5+RDygWVYo2xE5H3oaDv/8GmVIFiVQTOTT8JvqcmLu0UmeC6xSFpATpAKbjf35TEowKQ9GEVpZ94FStUPWO7IH;25:yYIax6+ciHv4fmf2UJrwAP6plOlPZv/B6c43GlpdZyc1H1x8QxM2NMTwayAWbuZ3LRgCqOXyaTkXWLF+Wvs4VmtDMkzgNpO3GzONbHqxAI0pAC3ARehk1+qt1FWaqzpwsKVrAvB4FuXgA/HPHzQl/JSgdVj57IeAnoVBR1hc4M3aGUffI7DggJ67C3UdlbGcb6Z0Wb4Hc1VhM3xlvoyRZgc5uUKYOUlENKZbNAfuzn2PN7aeEXVOTMoODSDhm8edUhdKWwFJK9QnsrmRVqhRmL2HQB3pHSBTJq6YUKphBUcX/1frwhNw/bOev6+p7fyPjeUGeV50yRMtLNuV4k8LJA==;31:Kg58LSbJHQEhGGH7LdIHyGyyGU1nQXk9dQYMgEuJKJxsScDsZOkeOOWTwXMJ9ZZMaEWOXdDxcundm9efX3ROkJL1tIHYcxmnsEvir4arHWVdCPkKzYfhkfdZdr2VFXIxSoOz+wQEw6hlRKA685QfUdoYj3KBxyPK4kryHTOMg3EvsICIeGdVI2vGtLLyUX0IZL7XFBXsA2zP/31KIfbhOZr0Z/r4oC8hFUuNin+nvXs=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:HLE3pm7tLBEdJ3mP/d786A0XQrCOKdLyPeMySWNZaEzc8Qq3RfgK/qFO1E9vXr0Oz/0+T7Y/4B+wh5CA+wwMrVzo1J//AkFxZgSle39it0Pi9YmynJq2OCxT/Db8YPkVF+qVBGdYo7E1CJelyZJX/O3FgtAPQr7sx4qFTKCcYmj148hCmT2CyDVhTGd3KesT96LVN2ws3DG8G/OWG4JXbzrGlG5W+8d4brIQVNauzmLVMQ0yWEwqg5SCOIvkqmk1adpB2X5p3YFNti29jgeLVel/fPuKCEfsanB0yxOrJRLg8EDj+5Q7LwHm3xob1QpWGubh68WkZcJq/JFlaGhCZAKQOzhh2ECURddmj0IWDLgpkA0rPHcGlI6bOmgucEHXJzifdD3IYEShSuWi39wRwcA61OF9mM7/n0dsIGQasB3rj3pZY6+8TlTTGeYgAh1M7KitkNpg8v6XSTpLsJbGs0mMvdvmn4Lsb0pZL6Cq6Myzo7VUvgPs6LaRHHatpQLM;4:Rpf0mDW8x7X5czB2Egvo9fu0qDYLPxEUnEmy0LDYDbDEBjneZXSRV6ZSJIYJWQhfK4PfL1oiFod4avAPQ1uzGo+VHlk+s0YKIPmvC/mqqZFwrXvJ/radFXk90CIIs4cSgqEGio6KowJUgWQ8DauvdzWp97/8IZ2hZJysynIC4lXXOlV60AFUJ24ZIb4cgKGPQZJE2rj7NoeKeqnU4Gtcf/837Hd5Miv/Pszzutowsi5P9SRLL2IldEQ9uOA4lwbIGJHgRTwEct3PKWnh+XI6+w==
X-Microsoft-Antispam-PRVS: <AM6PR08MB325444B2FAC8340632B65D45B0D80@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(346002)(396003)(366004)(39840400004)(189003)(199004)(106356001)(8676002)(5660300001)(81156014)(6916009)(64126003)(2906002)(81166006)(8936002)(50466002)(478600001)(230700001)(53546011)(66066001)(55236004)(6486002)(386003)(2950100002)(7736002)(31686004)(4326008)(305945005)(6666003)(36756003)(53936002)(47776003)(25786009)(77096007)(316002)(52116002)(3846002)(65806001)(229853002)(6116002)(65956001)(6246003)(54906003)(52146003)(2486003)(76176011)(16526019)(186003)(86362001)(23676004)(31696002)(105586002)(58126008)(16576012)(7416002)(68736007)(97736004)(26005)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.45.171];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOjlqOXovU3BSYmozY1ArUFk2NE0rMytkc0to?=
 =?utf-8?B?YTN4d2F1cExxZHl5LzVUTE5heDhyNjQ4Ulc5U2htTHNaaHdrVHR4OXdzbmJX?=
 =?utf-8?B?TmFNNHAzRTNjQnJoQ0FWaWJIMStPVk15QWRTNXNBa0t3bm5NM2tpM0hKcjJH?=
 =?utf-8?B?UnZTalM1RkxXeGg3ejRFdzk1aG41ZUJ4V2NzOGJzcy84bUM3QWdaaVdPeUl6?=
 =?utf-8?B?cXJVLys4djN6K1lOVURucmJEb2crUnRvU1BseURWdTQ1aXA5a0QwWjZ2aEM0?=
 =?utf-8?B?b29EZkpaNUtYUGJ4NGlhemRuMUlNenVld2JYaERwSGF2TXlCdHB5YSs3ODl0?=
 =?utf-8?B?K05WcUJPd0hPQ05nSWJSSWV3eFh4ZlhSUFZQeGZSRHk1VTQwdHpUN0ZicXFu?=
 =?utf-8?B?Y3F3QVdVbUR1bGt5dmZaL2ozdGpJbjRwd3BpemZhbm1yWDh4M3JJYzQ4K0xO?=
 =?utf-8?B?dFJvdHJaQVlEUm9BNmhBYWdueXlNNWRHK2JiWHp6enB4ZEcvaThYYkxZN1kx?=
 =?utf-8?B?VmIvRzRSd0tTM1dUS0NlZTdkTkJqWUdNRVRZM3RQS2RQa1NJWWFpZGhaaE5U?=
 =?utf-8?B?N3pjUDBpNDAvRzhiejVJVlFyN0QveldBajZxU0JoY0pqRWdxdENscFlzWFBt?=
 =?utf-8?B?R21rdlhpWmhKWGJ1WVh1eHdGMGFoaFBXUC8yMTJRVFo2akRGa1NIcldEd2wr?=
 =?utf-8?B?RjlZT2xidHN0WlNwenVDejZKZi9GdmpiUERtSDNqUzlBcUh3K2taSk8wK3FX?=
 =?utf-8?B?SGd0OVBaclNtUTF2WExGbnZ3b3dKQVl3cnBsOVpEV2xUU3pYRy9USlZvbFlx?=
 =?utf-8?B?VGxSNEZNZmMvakVlSEltc1JhZkNDUWRNelFpR2UvY29iVnVuNVpQRnM5MjJB?=
 =?utf-8?B?MFRZRW9UMUhrVFBhMTBJV3c2NnZTSmROcklieisrdG1wVHpERGZMeEJjZWZy?=
 =?utf-8?B?a0wvL09yanBGQzRxc2txQitNYXd0d1ZaemV1aHc5S2tabVV1anR4L1dHS0hI?=
 =?utf-8?B?WUJvS3ZxSXh1SkMzSTI4YlBySzIvSjNKVnZJUVZNQnlycURESDFLektoeU5Y?=
 =?utf-8?B?S1VWVTBRMURYckR3bGpDS0FScGoyOVlueHVpenYxQ3dDVzI3d2RGZVJoTzFP?=
 =?utf-8?B?L1dJSFBRUlU4VjJkUVRJMVA2aTczNFZ1TmFHclFlb2hFQ3BLZi9ZSDlJOTZp?=
 =?utf-8?B?cTRqZ3A2eGlNTmorem53Vzc5MVEzVG5RdUNiMkR5YzJ2SVhhei9lQWdyQjVx?=
 =?utf-8?B?eDNFT2NOQXI4MHRTaDJWMmkrSDRUL1hwSmd2eDRPMHg0eXVxSHdUblNxNG5y?=
 =?utf-8?B?VlJyKzdYa0U0RVJ2Y3VVYStSR29nWTZzVVlsZ0VFRFJ1OTY5YlhxOEF2TUx3?=
 =?utf-8?B?RlFEdHA1MWRuYWgyaWNEVU0wblNMYm5rRDNrQ1VudUhMb2ROYUZ3bDhBRWZN?=
 =?utf-8?B?OCtPNkZFQmhXWmhKNEFJckE5bFlVSHhST1l4bmtIRE1CRTFsV0RnWTZEV1RE?=
 =?utf-8?B?THdVVDIwNFd5V2hCbUJjVWh3QU1SZmxWYzVHakZVKzFhVWVkcGttRTBadHpG?=
 =?utf-8?B?c21xSmJCUVMraTFla3dSRzFwRmFJRnc1Ymt1cWpoemJPWVgyTGZDdlJXYUsr?=
 =?utf-8?B?dXR0bzMwTVlyem5XdzdJakRweHdLSytwN2RRQWRMZDN0b3Y1NWg0YUl5VC9I?=
 =?utf-8?B?Mm5raUIzb1MxM3pPZWRHZFF5Sis4ZjhxVnBvUUNQT080TGVGRlkwNHVHVFJH?=
 =?utf-8?B?RlFWMUdjbmphMjhpaWJ2MG1oamN0OWlRNTk0Q2p1ZUx6VlM5NnhwSVlrR2dO?=
 =?utf-8?B?anc3VFh5bzJRL3IzWkJhRjFkcTNqYUwxbko1NzNjeE8wVTUyWkNKd1NWRlQ3?=
 =?utf-8?Q?/l+Cl+rT7WGHjDvA/LMEif3SBdw4O+kE?=
X-Microsoft-Antispam-Message-Info: 9EJtuUjJ8Y5wrxVBBaRrmQrlxmypleqtzm/VZA/EEIHpkRcgy6MJmduis5DOmiTVaeryKFuYPq7zwIPwpmP8QOrjKCiDvGRPyP2sSMcLonh74WmZxW2uh4foxquZC0bWV64nBCI7iuzhbNyHelO3U3dQ4tntOGX+bDfgODcrbk1BRw+Dex3tlCCqOjaLYKsC
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:Zd33q9OpuiP6G+4h8hfxH0lHdrlHi7KMmVK5SqcIzWnWpFYlXQaBlbVdpV12hCQphxg5Szzb+1uv+rfN/1JNCd9Wq5ZJB8Z7WGvQij7hhtuWFnhEYrUmJfzWQ8+TUfHZ5wFkRSstayAVlnd4J23+EVQCOBB5EMA1gEzh2Ewd30VbjZrWs5EhFkXmEfvDXPxFGOX2TlK61wEyyvISWq6VTaOAysK3yw1GSVuAbB5b7tVLDZXlEIZsDfFONfYrvMcKepx1s38J/1pNbNrlvJGVm1dWYyAi8DQ0lg23kXAjfk/b1lO/VvPcLbKU6Gklh3IgDsl8raP3Gbt7NiD4eC5YT0oFcz2tR0JlsfGC1O0lS/8=;5:f5qJyntOodx2yvCSv7eEbS9I0Pe8mTO6l2oWVRQrYo5twO5Q3Eu//w7YrARqAnrexaKEIAHrxIyEWv2gmuG6ygLAp5WpX4MkIOTZo6KjqKoh3LyhEBrMjWUy57CSvig2iExQ3wy3PxG4/UvEhy0e01q9SvXWfwZg2NdK9QJHM/g=;24:fs/dj32gTC4LWlXfQAYIdM7beUidH8qgWOQKghhOd+TR6JCqJnG8JPOGzofhyw19C1QmaHQElOHiJ1nLCGF0Qh2de9cjVhlXIuNkeevb7oc=;7:esGTgYmLz4HO0rFLgpe8f/cq10425hyAFSKsCBNsNV2CdQpBQcjVkoHqgTNEC0oeJzO5GOlfxu1tFsDOhAyN2RDqjbrlCODFuyFegYziPW36GchOk7qHv2v+DWpUTEXTpQOacH6Ogz3roNMMCVyV5SD2HL6S2I4i5EDPpkL8JuQU4tUwK3DfnBoy6mICrd1cV06mGtIy3Jg/x8mllVsFao6cgW532/D32XFNUIDVvWeLJnoLnEXjqwgB5Ice5p/j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:JzZizPzpuCxkGSWgoSSHfPY0k51rdGaGEM47JOlJG+uzhcX5Ip3FOwTQqBP/SdTqhAKsO1QAgoCLwV5GfkQxT7a9mwfwqSVHdA9Gih2m5TKtcUI5pRvY1zLN0WJAN9s7DjWQi6sq6VuslYXGfVrRjKX0PmJQADr13WuWnuFAQUE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 12:44:07.9507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865f9680-b212-4d3d-638e-08d584291ed9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2018 08:42 PM, Andrey Konovalov wrote:

>>> -     if (s->flags & SLAB_KASAN && !(s->flags & SLAB_TYPESAFE_BY_RCU))
>>> -             return;
>>> -     do_slab_free(s, page, head, tail, cnt, addr);
>>> +     slab_free_freelist_hook(s, &head, &tail);
>>> +     if (head != NULL)
>>
>> That's an additional branch in non-debug fast-path. Find a way to avoid this.
> 
> Hm, there supposed to be a branch here. We either have objects that we
> need to free, or we don't, and we need to do different things in those
> cases. Previously this was done with a hardcoded "if (s->flags &
> SLAB_KASAN && ..." statement, not it's a different "if (head !=
> NULL)".
> 

They are different. "if (s->flags & SLAB_KASAN && ..." can be optimized away by compiler when CONFIG_KASAN=n,
"if (head != NULL)" - can not.
