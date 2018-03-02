Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946468AbeCBMJy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:09:54 -0500
Received: from mail-ve1eur01on0123.outbound.protection.outlook.com ([104.47.1.123]:32613
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423004AbeCBMJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:09:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] kasan, slub: fix handling of kasan_slab_free hook
To: Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Cc: Kostya Serebryany <kcc@google.com>
References: <083f58501e54731203801d899632d76175868e97.1519400992.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <26dd94c5-19ca-dca6-07b8-7103f53c0130@virtuozzo.com>
Date: Fri, 2 Mar 2018 15:10:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <083f58501e54731203801d899632d76175868e97.1519400992.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM4PR08CA0056.eurprd08.prod.outlook.com
 (2603:10a6:205:2::27) To AM0PR08MB3250.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40451332-9312-4934-91ba-08d580367c83
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM0PR08MB3250;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;3:b9eiIfDDx4I4YR8QgKafBuAQA2wR9Q8CEb2jhXKFW75T5oazsO2DTBruCxBg1gOQUaRXaXArPvHfpKWNdY1jc6hC5J44lcFrLqzJlkYC6Jk71VtWJuKOWRGLOYjxIXQ1ngGuSHxRTUhR2nlGiT6lcuOJLTr91rUPi83EZhZww6p4nM1zR5Ik0ZEuVuf77GHJcHI1GLxQlRKFfOaAqsOT8q/YBfl4kE1IHRGC2vy8L0BMA94BIGKYLIfZ4fxGlxQd;25:LSlwMAAt7/rWJ0EbqzVHhJ7uC7EnHPTgs+pSMM4vn4Fw2+qIw1rBpERJjGBtoet3h+qhMLUCA9JXHq6bGkYXywii6QKXzwsZHQCJ2fkxGz0LvYJOVKuF+0KcLPQyo+tGUpyTg5ti7+/03BnQFUUKL0cd17bYoyDNOSNx0HnAXOIZMvI8bvWDopVUtgWhWYPlD7x8aST87fuG4Mt2+zrbrrQqlLrFheoqM/g8zS+/Zxvsoc3zTrPBamrXvHl5skuhDvdCSFVHEWCkJl1BnR2JyOxwRhNe2NTaDtWlBm0+QkZ2Awm8ytZDNxKilx0eOIvnpXNUY+gqcxKdDpjUxuPRMw==;31:jdLHO+CLfxaq/tbgERTb46h9hJJbctxYUfDr0byZNdpXWy2jzv6hiRFrPX5DDCxjpBg9jVpscg2wIrHoHuiypgtuTkrMtz5myJDO9igS0PSBa80dFN/al2oGQyemc9KHdqz3QBvZXhDayVzfMfzdqYAM3NN8mnvJFvblDDbc1A+udzqjvjjiRyUZXGFZ+iC/lXc4tplol+CTYMrgs6761L9BGew2mtlcamEl7Ftz4RY=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3250:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:8f1ai0FxwfQI0KsQ0JTkpsmuGaSpJwUaILGEc39DrtFIIFio0nG6387/ad/Yql13x7Pfh7F9ZHJWjkJVDQD5CFHjx769ans0ZA7m50ZdQnQV9gWZ++SUnmIb1c2tfGcq7MruMdzLhu6R1PKrY/7w39j++t8zCT3lHdSV9jLvP4oOpN9W/ED2KiZGhUYe0PbSm7E6p3/b06/8MgvOsGvptO0pDWi+QK/rIM5EptkV4IDYsUHt2BCLXFzJP9EKwWCzD/1efQd5GTK79/9zk7RdKR/N3yzYTtrEwqR5Y8nHLssBbnyPMNlrFQy5RNgsA1fPLfsbdE5V8XawbDmUbEVHaUDLPU7jpNoVJMKONwLxtzF8OC5vho9CyByiiwNYv4tafdcCIPL15qhtKq/aAdahOtVLW6/nXUg0QwA66SH7q+sMqKDTuuxUb46p/HI0yvIO920nvccDHB2MRXk6EG7wOAOgwDONgAopuc/bRvvuq0GznuaAKrJSwPkM1L5VzjX7;4:WO/E5Lryrh6rc+rEky2tZs0fpSe0epfcaoG8mnHG0ylHMRqCmU7q07VC2i6XyWQfPoBQeuVGGl82ph5OfDIJQOWPb/wG+0t2BgX11M1mLO3IGRmhNWQgn6HOwmtpdtLMx7q7GPLN10eJ1Y54ZcLwHAxpvZFNZv2LSvqKBYgygVE+SRn3+WsE3Ho95I82xgGtSic1UMBQN3shFGkNBBnOwYlUoo6c7UYLcoj1FWNcaCf31MALW4ah1awKKjcwcf7dkoXkC39B0ZBth7Gatq1Uy0gTjfr7ZGI8DnfifPCU5bYiC0vbeM2l8CjSMWZrmHO8myCfh9wN5PrjC0n3bEGekA9EpAtE+oQZiS7ZkRgZEng=
X-Microsoft-Antispam-PRVS: <AM0PR08MB32502A20189CB323E9E65294B0C50@AM0PR08MB3250.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501239)(52105095)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM0PR08MB3250;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3250;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(376002)(39380400002)(366004)(39840400004)(199004)(189003)(54534003)(25786009)(36756003)(6486002)(4326008)(305945005)(5660300001)(31686004)(3846002)(6116002)(7736002)(50466002)(110136005)(86362001)(58126008)(53546011)(77096007)(16526019)(59450400001)(186003)(2906002)(55236004)(316002)(386003)(2486003)(52146003)(52116002)(8676002)(76176011)(47776003)(31696002)(68736007)(65806001)(6246003)(81166006)(53936002)(81156014)(16576012)(26005)(66066001)(230700001)(23676004)(65956001)(106356001)(65826007)(8936002)(229853002)(64126003)(105586002)(6666003)(2950100002)(478600001)(7416002)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3250;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMjUwOzIzOmp2a21DMW1VeFJ4RFdQSHJpK0t1bEZsRGFS?=
 =?utf-8?B?VjBjeFVvWms4ZGVXYjl5VklNT1FlRDdjMFhrV3RMd0ZvR3pEcGdDT2h3eGF2?=
 =?utf-8?B?WXVKeUJQa09SRm9OWGtIU3UyRzVyWDJ0RHpqcTNDZUZucjZtVXhrbmFqYWcx?=
 =?utf-8?B?ZDQzWHdqczZaQjdMWDhvUzZSNnVvdVlNOVFpZGZGZFErSlpmREZjajZLV3B3?=
 =?utf-8?B?K2ZBYUJvNHRQZldQQjBibUZTNVBWSEkxTDZXZkk2aEVRWW04bnppMm9LTUlH?=
 =?utf-8?B?MFkzeU5raUQzazNIaUtJRnYyRm00WVRKdlFoS29nTWVJdHlRQjExbkg2M3NR?=
 =?utf-8?B?bXNzRHljNWFsUnpMMHY1c0p4SlVTRjdhbVlTVDFUdHE2Qm01NlF5bUtveTMw?=
 =?utf-8?B?WDlsSytVMlZLb1pQbTNSVkxaem50WTFNcmU2THk1ZHBiSW9DWHdNR0pocWRy?=
 =?utf-8?B?RnpKL29JUlFmQ0FPdCtZdE9UcVIyaktpTGsyQVlIL2FxcmtDeFJ1ZGN3eXRv?=
 =?utf-8?B?ak5zcG9vY0pFeDFud2c1WUVoOGNGVDJ2QlVFTkFDUnVxc0FLZ0ZFUVZHYXFr?=
 =?utf-8?B?QXlNNXhiVkdaRUpiRmp3Y1MyaGIzQW04Z3FGUDY3akVScDdiOHdPYjlHcVdP?=
 =?utf-8?B?SW9mVklxMjJ4T1I3S0VXQmE2bWUwaG1KQ0piamhZcGxUSjRUWGtVQzFHbXZh?=
 =?utf-8?B?aTJqZWlGeW9xK00wMXd4U1VnSFpKcUZYVlZkSkdlRW1xSFRONTRDcU5MYnQ5?=
 =?utf-8?B?bHgyV3ZBK1ZjYWNxVURBQzFFMUNMUTQxU0ExMmRhNm5JaDNlU1RRMndhNG8y?=
 =?utf-8?B?WkJPdnJObUozUWdUM244RmpzRHlaWWd2WGVvT3QwWE8zNU44WXNjbmxpdlA0?=
 =?utf-8?B?UlZJcnc2TklrWE9UTWZXb29WNXQ5NWMxT3BqcGt6cVhGMWdPMmhrWENjeW9w?=
 =?utf-8?B?VXlaM1kwcWdkRmlBTkxXckx5MDJsZVUzYmtLL2NrOWJCTHBtSndXcndKRTFa?=
 =?utf-8?B?cUdkZUJ2WDl6M0Jib2ROUWEyRWhIQ1Nha29KMGhCK2hqV2FOa3N2VkJSYnBE?=
 =?utf-8?B?dlh1cHYzeEZmcGxhRWJ5QU45TjlkaXlsbU5zOUlWQ0xuckJ4YldxcDRhV0pC?=
 =?utf-8?B?M0VCZXVVcXZ2ckd5a1BFMiswWVh1cUQ1Q3JpQlg3TkVuL2RqUi9sUDg4Zkk2?=
 =?utf-8?B?SUxnWnF4UTlqMDdsVkNrV1NicmVKMU8zYlZGbFg2MkR4M2h1dW56eVFNVUJz?=
 =?utf-8?B?eE1ZOGtmSmxmeGJ3SUNrNjJha1lIdXh3QlRCVE5VRUtDZi9nNjAzWjBIZ0Zh?=
 =?utf-8?B?d3R3emtJSmlTZTRiLzBsbmhwaHg2WkMrTXZGdHBEMnFWYTU2aTV0UzNVUlM0?=
 =?utf-8?B?QVBwcTB0aFM4UlE1YTJIWXF3cFBsWW1KNmJlckQvdjFmSGNRNDVodWtVWjVZ?=
 =?utf-8?B?Zmh1eHc0RE9OTnhjSzdRS2ZGSEhZMzJRSTVFQ0VHdjRKYVFWbWN6QTI3RUR5?=
 =?utf-8?B?aGtOaklTVjM5eUpEYlM5WFoyU0J3K0E4NEV5UFg3aStqSXhkQitJNTFIM2pa?=
 =?utf-8?B?SjVOVUdOcW5tZHJXOUdZRXRGcVpWYUMxZ2cvcjgyRUwrTDA2MzVsY3VaWTFB?=
 =?utf-8?B?WWhRblYvekg2S0xTT0EvZU1mWTNpaHRGYWF2UUtvaG5BeHNSRHlxM0pEamsv?=
 =?utf-8?B?ajhaQnpoSHIyakpwbGlrWiswWTIwWW14V2d3Qlk4V3BYWUFPWlZuMXo3aVRG?=
 =?utf-8?B?U2NUa2xxZXI2Y3AyWlFHLzlkSjNBNm5WT1ZxbXZ4WkFqNlptYXpVZS9RNGcw?=
 =?utf-8?B?NytLTTZmNFRlNERlSThpbXJhQWxzclZjWlppVGVXK3V4dDEycmRMM0xXSXBn?=
 =?utf-8?B?U3lHdlFIaG1zTSt4VFRBUG14K3VSK3JBWkd6UTh1UUNpbjZHV0JxUXpTY2ZL?=
 =?utf-8?B?SENia1J2a1lQWS9kZFl6OFpaL0FBb1NiZFJMaDVTeGg0RXFtbnJZYXN1dktO?=
 =?utf-8?Q?5v8tGJ?=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;6:stf5kgGHiRZ5bmqKsQ6zmCI/YnAqjp33OZyz6D8HHIXlk5yPhjxX7b47ICBv1PPF3Wd+gHI45pDeT0TWpeu+egnDXm/00KrD9og9+8u5tT1liTTRdoZFdjycnbij3BEU2eHV4QZoaQPOLf8MDXnF5TqkvOngp5XwzllrDbgrqFb0qgaJuOCYAf7tt/EpMYXXsW/pf4ckh+LLw0oyW5l+0eRRlYG2Gs3c0A5uT9tAWfJ3s+m8/DbjwrqEnQIaKDx7VPH2wbE3r2S/xC3J3CVpLFLrXWuM63MVDMYB3KJnjOqdILTJSsE70Jhbeb6mY4COm6ZiNYqTx/eHQj0ZmsajTrehJHagatiYJSwlio9waYU=;5:6Oy7ci8hQmVkRh7qOtvSIsz9qyY5wRxCFsRn1z/76w7mZjNfrqEEurjFGPcncIngK4PApDBpYoEHnVIEKnIUL/R69p/tYcAQQIeYQSq3+m6CP+FcVJfjJukESMCVzIae/HY2cF+FAXzWhCkUTp7iXZw4QWyb8TM6RS9iCO3A088=;24:qBaIFCatkD5BEP7/+ISuPpS0k0MZzAv2ElWtcnGlrg2TfMuUPZUBcMHNjUBgKrBBF12x+pFuK2q4DZarW1F1I79gswuzxqHijUMWTjvX5l0=;7:MnHk+AT/KUw6S5UYsv4fWJzVYquNhJC4f0XUkzGQUnc7VNKx/EkytLPrPsVpgSt+jxWnLZlslJ4JT8Cue85bLWbSQzM6cbjEC5g+xOjwxE0t0HgBA5tK/cJVQO9+A7LNoNIyhJkVmA36Ku5EGZvTt1tWUQvF3Ab9QyZGIGBxCJDylQVoBy5m5pArIwG9A6FCuuQGOHoUvAu0FPCXYddcHXlObSzl8HjusvVksvf+uaIlzmqYj4o/dJDfRHGZReGB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3250;20:hxyHxe6fjkuKJypACMmRF2ZMciTYmz1GfWD1Ep+rZq7JhyXCP+GN/am0wDtrms8WC+D5MmLHSamibsQs1KhGL20LBjQg3/c1aEsw6H2TfotvLJ8oVixbHCOHRwkDYecBlstbatkU156zUG/OLgweFM/Qa4hbCc4dkyTGPE5qP4A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 12:09:44.1817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40451332-9312-4934-91ba-08d580367c83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 06:53 PM, Andrey Konovalov wrote:
> The kasan_slab_free hook's return value denotes whether the reuse of a
> slab object must be delayed (e.g. when the object is put into memory
> qurantine).
> 
> The current way SLUB handles this hook is by ignoring its return value
> and hardcoding checks similar (but not exactly the same) to the ones
> performed in kasan_slab_free, which is prone to making mistakes.
> 

What are those differences exactly? And what problems do they cause?
Answers to these questions should be in the changelog.


> This patch changes the way SLUB handles this by:
> 1. taking into account the return value of kasan_slab_free for each of
>    the objects, that are being freed;
> 2. reconstructing the freelist of objects to exclude the ones, whose
>    reuse must be delayed.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---




>  
> @@ -2965,14 +2974,13 @@ static __always_inline void slab_free(struct kmem_cache *s, struct page *page,
>  				      void *head, void *tail, int cnt,
>  				      unsigned long addr)
>  {
> -	slab_free_freelist_hook(s, head, tail);
>  	/*
> -	 * slab_free_freelist_hook() could have put the items into quarantine.
> -	 * If so, no need to free them.
> +	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
> +	 * to remove objects, whose reuse must be delayed.
>  	 */
> -	if (s->flags & SLAB_KASAN && !(s->flags & SLAB_TYPESAFE_BY_RCU))
> -		return;
> -	do_slab_free(s, page, head, tail, cnt, addr);
> +	slab_free_freelist_hook(s, &head, &tail);
> +	if (head != NULL)

That's an additional branch in non-debug fast-path. Find a way to avoid this.


> +		do_slab_free(s, page, head, tail, cnt, addr);
>  }
>  
>  #ifdef CONFIG_KASAN
> 
