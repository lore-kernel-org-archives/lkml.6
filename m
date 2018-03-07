Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeCGMh0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:37:26 -0500
Received: from mail-he1eur01on0122.outbound.protection.outlook.com ([104.47.0.122]:63952
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751067AbeCGMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:37:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2] kasan, slub: fix handling of kasan_slab_free hook
To: Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <a62759a2545fddf69b0c034547212ca1eb1b3ce2.1520359686.git.andreyknvl@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <4e0eb106-1b1e-93ba-af4f-6714413422c3@virtuozzo.com>
Date: Wed, 7 Mar 2018 15:36:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a62759a2545fddf69b0c034547212ca1eb1b3ce2.1520359686.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::18) To DB7PR08MB3259.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38672d80-46c2-43ba-06f3-08d584282a5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3259;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;3:QMemRcobIeOAl03tsHzlOeOYpFqNhXQTZbl4wLLUeimYnSTP5aBF4WG+tOFFj6eT6xAixHjE34C0ilNytucLdbA73FlqcmRJn+Du6X5Q2U2CzXL3V8sGThJL2rOVrjpdr6Kl5+dS6CXHojq6/spsDShLbyPBdVgoVRUN/FYHsx2JA5HK/KKR+rzXrk3LYk/3P7zlocwHYE5a17Ei6uzI4LawZmBvagEyvcY8dmvmmbecimUKRSOBhnWZUaEi0nit;25:n+GV9p5xazWL2THQuy9GHvpp9mVucCMr9jL/+8+PxeHphihBSk36AxJQ8DDzh/1J8saP/sA+wZqqmun/IqjGyoJuVZR0bqyOpjV3l2hTT3liBQjlVq3WuzLZgCMiXK325aX+JwNi1CL5hThlmNEzt4i47X5XK7rumekLQcVM204RU4lXxLL/YWcJEMzPLGncaBuyAgd/buS+se8bhZfEAVwoleV9B2qTkyhCLGM46I/0nbghJoqO8Or6srEHNjUJgUjaP5xmoZQ6BsBpRMDEOJVK8Md2LlG86BwCNmj+Na34aOmsr7FBdskPJqXGFwHw7QJTDA3eyqNPSAkHy/K+kw==;31:mdreKZZR9hz9OnFZvfgSXUrNLUT2C5GrL2tqGJiGdKc4YL4F5EVD1POUS9tfNJSgSfLeNynH57gbKepnTVXFtwtaXgpQ4Wo3GejS1IYM3o4YGLEIrPVogFRMse0APj2lp8LgmkGWi+YJcGFdqSlss5jDpJnS8b8ssAUilUUsFtdwu93oXya3oWdqkukyFmph2eAXfZyl7rcrssHkEwa6kS5Uv7JKZuxVvM523MjIKiQ=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:n5si4PCNYo4t8tNXd+nal8yaNZJP0BAcn0pjt35vsGllFZ2UQ8Apq7nt5ScLzWqedEV9EfGWgu6LqClHCiKvVZt8HIbLipZ5O39VCb4yANX565rYVraqvWkP0/nCcEv5fJu2g56sx4NQkNHIi95wingAv/pw8S1bdhZKKkGF6KfRFw9LAWK2SZDLFTK9xrqEqZQIcA/kQHM6RmglvtSFZl6+R+jjpc8OCcxfenn0f4EKfznQRj1g0pMfARoptiqxnp30xJx0RUTGOLMkhfpvRTgjHnOU8aftCBQsVFz7+4kbXWnF9jap0tT+aYrs+Rbud2HYE5D2+sEYd2iG/eGZf/YmFahaBxz6AFYwYUqp/k86SvZV5FraBZWcSLnBjoNYRoQKRAYBerakzc8KyDf7NaVHLNkjSyF6MOaBoeCzlLPUpkB9lxRNwJKVAkgOV6WLcBjpodNTmOFrSKWmTVHaNzhf9QZ/TNOBZizVuH83L7BlG1Z7aAz5RY1VvTVWGnIk;4:cG2hQIMvwbuEo6pAok7b/B6eOi3kCqNVPhUvv8/QekNS0l92p7q9YsD5W/3kXxkXN6Vb8whqkZn0NzW6dKkB0XXcHJwNs00QbKTFc05Ki0/eW89gqR4D3cF0Y0bxqCVxN5u8RZDv3XSokhTZ9Xno58peo+/L+a4eAmKu3Q3Pu5pq5/L05TFbxp8jMZCylasUfSJeW0C6TajSHyC55Q8Xop2N8Ij8LJNwIxMn+rzDRf/vRIxWfIgIIP195WTPOhNaKhlla5P4Ekvs9Py07uzA5Yvc4x8V9Lay7Mv8/iJWOu1KM6oD6M7Q4OvoiR0J1uKH5pmow72H5n9cCKuVgVh6uhmDcSq0gLgfBwDRecZXf8A=
X-Microsoft-Antispam-PRVS: <DB7PR08MB3259F1F79B6AF76005C9CFE3B0D80@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB7PR08MB3259;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3259;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(376002)(39380400002)(366004)(39840400004)(199004)(189003)(25786009)(86362001)(59450400001)(6486002)(47776003)(52146003)(68736007)(52116002)(5660300001)(2906002)(76176011)(23676004)(2486003)(53936002)(8936002)(16526019)(186003)(478600001)(7736002)(6246003)(386003)(55236004)(26005)(53546011)(6116002)(316002)(58126008)(3846002)(229853002)(230700001)(64126003)(36756003)(31696002)(305945005)(66066001)(65806001)(16576012)(106356001)(81156014)(65956001)(110136005)(2950100002)(6666003)(77096007)(50466002)(8676002)(97736004)(31686004)(81166006)(65826007)(105586002)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:[172.16.45.171];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU5OzIzOmVIZXFyU1V0d3RWdGNySWhBdmw5U3JBZzF3?=
 =?utf-8?B?TUE1eHo1Qm9acVJCc1ZHeFJTZG9yanpUbmp2U0puQWhoR3B0elVrOFJMOTN1?=
 =?utf-8?B?d3hmZElNUk9jaTBvcVE5RjFkQVJLT0RCRENzRkQzRkxpU1lPamZCSkppYUU3?=
 =?utf-8?B?aU83YXpVeEdzWHErQ3BqVXhsY3RRRTJlYXFkWGQ0TWJmYXJTYUUrU2pKSEJT?=
 =?utf-8?B?UkNYZVNiQ2R3KzhoTTRHU1IzNGpTSkJPRU5Gc1kzSmV4Zm90ODJMZnBhaU5P?=
 =?utf-8?B?VE5BSG5rSUwrOUUza2FiZ0dXZmRkMlRMbE1jdjRLa0tRRittNGs3ZE03NlFq?=
 =?utf-8?B?QWNsOGtDN2Y1L2ViUUI4a1NXV3h6YWUwU1FHTXdhdkhwc2F6dGVFMTkyWk45?=
 =?utf-8?B?MkpRUGhMZG5iZWwxczFoZS9sWGZWT1NBREExMXdUa0Z2Ry82amJhdmVWKytR?=
 =?utf-8?B?MEQ3VG5HaU5rd2dYd2ZFVnRSbm4zcUc0eUo2djRUbjljWEF0b2R6SU9rNWU0?=
 =?utf-8?B?bXFuL09ZODMvby9FV05GV0dmcDMvR0NQQlNpV1JaQXU1NmkzU1lGRlpPRlVa?=
 =?utf-8?B?bjd5d3ZBRWh4eUd3K1dxZmpIN1o5RDFIS0EySmRBd1h4N2FKOGVVQ0tudStB?=
 =?utf-8?B?d0dyNlJ3SGQ4dk1yZFk0Zmp1Y0lnWXlHV0tzQnpSRVp1MTArQzJ4bG5EUm9P?=
 =?utf-8?B?T1E2bjBUTmZzOG9qUmplcDVGSE04NjhJMkxIaU0welc1a0wxc214QURVdmdV?=
 =?utf-8?B?d2g1Q0t0a3BtamYyY3VRQ1J6aDBCSGk2bG9LMEl6K1hndkRTMjdBN2IxZmEx?=
 =?utf-8?B?OVhwV0Ixa3hYN05DaUI0V3BKRkg4dzYwMGc3RS9reTBTenFZeVhjcGV4MkEy?=
 =?utf-8?B?UVVqUjFsR2hMejUrL1VLd0hRMktDNU9FRG5wTmNJZVZXTTh2TGgyNW85bnhK?=
 =?utf-8?B?cXVNUFlqWlRnSTBVOHUzNjB3L3hRRll2YWtjdzMyUWpWN2RwbzllSVNaTVkv?=
 =?utf-8?B?Sk5IZmdSQ2ZYb2h2OXF2ZnRJZ2JsMTV1amw3bWJRWHMydmJ0dHplc2toa2p4?=
 =?utf-8?B?SXNxSzhjT3Rnc2libTBNN2xMUTVwMGVKT0M1UzhxKzZXTGtKZHZEVmNkanZw?=
 =?utf-8?B?WGMvTklKSFpMTXhFTU5taW1DT3BtQzdtc0NSUTBZZnZLMnF3T1pNai92ekV2?=
 =?utf-8?B?S2VyYi8yVWtNNENreUlxbCtPK0lBRG1PRmNPN1JKaDNBMWJpd1NGRlhzVFZP?=
 =?utf-8?B?MkQ3d29WS2Uwd3lZcVpyMDJwUGRaOFdaeEJlV2tzWkNMRDdQelBNSGd1V2RD?=
 =?utf-8?B?T25GSG40SWpEZWNQL05iNkpDZ2dTYVQxRXBYNEZ0cUdXbGVFbHk0eEdBcjRB?=
 =?utf-8?B?aEJicFNwc3ZlWlZqaHFPQmo2MUF1V3Z0d01rZk52TGpTTlhSV0hDQ213M2tt?=
 =?utf-8?B?VnEwNVFaemIxSFo5V054OTkzeUJjajJ4anY5Q3h4aEpsN2JRcVJBTXduUSt5?=
 =?utf-8?B?S1lSWkc5cm5pdTFBbWUvaDIyMENNZzJxbFBSS2twYVQ3c0tpUkYrai9TLzlw?=
 =?utf-8?B?aldwZmJla1phWlpiU3VKZGdnVjZUbXZMTG51Mlplb1ZQY2g2d2lRaWY4TVZ3?=
 =?utf-8?B?OGZGUG84VFFnT2F4L3pXWFZRTEwzWG0zU2ZNMlpGRlk2SnFQYjBJR3Vhbi93?=
 =?utf-8?B?NXFaTnZKdGVhVitEd2tLQ3hseWhsbU1QblIrVzRTbjE5aDdiRlplV3l0TlBQ?=
 =?utf-8?B?TDh1YWwzZXlwalFhclgvN0VCQTh3Wi83VFpaQndNYVJGMGRqSzVRWnJ0OFRy?=
 =?utf-8?B?Smh1aUJaUXRvVVNxL3dPZkFsQUFhWjBvbStSOU16RXNEZjVxU3VOZEg0aWxW?=
 =?utf-8?B?dVp2QTA0Vk5LbG1wZVl6QlM1ODUwMlNkSWdVcHhSSmprOUFzb2dmSVJGcW9x?=
 =?utf-8?B?L2RienlqWXBnPT0=?=
X-Microsoft-Antispam-Message-Info: +A4st9vg1J1SBtfGLTzcKOzVr3Tzs+IBC+lFT5QXf1cIjvDIrCQ5FucvDqRCDKPspBuNeYpKZvxcpkaLKyWYixOJ9EoTcLpL5KVyC4lMwhioK7iM/bk9O41PAlzbXIuNUxy0++UlRVUXNKhYnD1W0ZDQMU+aJwp8q6JRghe5aoYlldj/uhdHfG+9dbVOkPBW
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;6:EHt3+K/3aHg5X5txwzLEdJWnrLBTnKHelkEs7mG5mAcjuaslplUm3zWxqc8kxsywCYSzFM1RSJgYQwJEtqkBlxQNm0oPRaRApUTAAxBw2KFPKD0yRWpKTdkpoIRGxqgeGraZgl58vGgA8Yj37nuoGdERLYtK6hSZ9AJGi8RZxJT4K4Gu92rHfjLt8M/6YDKEI+vL8fDSTwMFh9HtrbtzJaPZZiGqx04CP4BRjomTirBSQYyZBX6N6D2K+0K0VxWBQq6qvPHTnqvHShWOHeJjhBAQGdOhlqOhAehlu2cgFAbfBdXGKErzQZyg8HXQlHn20dCa38fFuXf/50z0s2LRdppv1eCPVu2xsy+z/9xi2UQ=;5:HcuKt+Xy/SHF3ckZjONy24aJLrADJtOEU2gCfUOvL+IDOCDLuUHfcLrqCkl52erME0N69YiJm9ulcv2DQ1PCuhXLY1X5wp3SvF8HGn26RQRMixRNnsIxqLVcwc3l5XoJ6mUMiPmQm8emXD4HgC2d9NLbJi9fV3jFxzyucjZ2R+c=;24:n9v4sKGMDjwb5lH8DSBldZ9qNC4kU+lzGzI+Mi/CVYbaH6BpFKhu+auQIptUW72j4r21MbB/4hQZdyL0862L3CAqzuR/GthmkQiDLkrDxgg=;7:l0j8HZOS6UakolmZngdjB8kykuQ323cV1NcnigaFRC5rkz3jeZL5meP8qMpHB8rzMpQ4p8u2QhzqtJljx6/s2UYFTvD33Ft9kOo6nQv4IEOyUZKIuWOS3xEUbuAkEmsnTwMAdhHlzMGlxJb+ABiq//d8hYtXPFRyl/2+NqII6sSQQmALr7ur3+HLPOClhYite/kO49+CLfSch6azQU3I6vWULO3UiiMo9kzSDaZ1F+JRqtz/GW72WVMkc6rY/zHu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:OAuM7hd7tBMAttlVlBZrYtCAUKpB7I02UVEvOa2/WB2NvL0aDKlyX866PzKeGDUIy1HPn9ui0w2Mn6hbD/RtRzT7JVFMJhl+tvgxeIm7DhCN1dw6hMQKWQqXsPW4SySGiKKkM2PG+BoKr1q/dp7NLeHin2suo/kImPAKU3H1g6Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 12:37:17.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38672d80-46c2-43ba-06f3-08d584282a5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2018 09:18 PM, Andrey Konovalov wrote:
> The kasan_slab_free hook's return value denotes whether the reuse of a
> slab object must be delayed (e.g. when the object is put into memory
> qurantine).
> 
> The current way SLUB handles this hook is by ignoring its return value
> and hardcoding checks similar (but not exactly the same) to the ones
> performed in kasan_slab_free, which is prone to making mistakes.
> 
> The main difference between the hardcoded checks and the ones in
> kasan_slab_free is whether we want to perform a free in case when an
> invalid-free or a double-free was detected (we don't).
> 
> This patch changes the way SLUB handles this by:
> 1. taking into account the return value of kasan_slab_free for each of
>    the objects, that are being freed;
> 2. reconstructing the freelist of objects to exclude the ones, whose
>    reuse must be delayed.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
