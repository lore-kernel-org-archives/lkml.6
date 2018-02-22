Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933030AbeBVPht (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:37:49 -0500
Received: from mail-eopbgr00135.outbound.protection.outlook.com ([40.107.0.135]:34528
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932902AbeBVPho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:37:44 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v5 2/2] mm/memcontrol.c: Reduce reclaim retries in
 mem_cgroup_resize_limit()
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20171220102429.31601-1-aryabinin@virtuozzo.com>
 <20180119132544.19569-1-aryabinin@virtuozzo.com>
 <20180119132544.19569-2-aryabinin@virtuozzo.com>
 <20180119133510.GD6584@dhcp22.suse.cz>
 <CALvZod7HS6P0OU6Rps8JeMJycaPd4dF5NjxV8k1y2-yosF2bdA@mail.gmail.com>
 <20180119151118.GE6584@dhcp22.suse.cz>
 <20180221121715.0233d34dda330c56e1a9db5f@linux-foundation.org>
 <f3893181-67a4-aec2-9514-f141fa78a6c0@virtuozzo.com>
 <20180222140932.GL30681@dhcp22.suse.cz>
 <e0705720-0909-e224-4bdd-481660e516f2@virtuozzo.com>
 <20180222153343.GN30681@dhcp22.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <0927bcab-7e2c-c6f9-d16a-315ac436ba98@virtuozzo.com>
Date: Thu, 22 Feb 2018 18:38:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222153343.GN30681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:4:29::24) To VI1PR08MB2829.eurprd08.prod.outlook.com
 (2603:10a6:802:19::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063dc68c-5d54-482a-8efb-08d57a0a356c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2829;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2829;3:FXh33p3nWQN9F7unqpKZ5BrKk3LOMvG8dKA2mridt6jAuJz0CMNmE/LA2+/h8EqjcuS3K2NYQtvPu9oInUmPn1HegX9/gaWQmGMPM4ZIueBjltugA06f4ocwc5eAPJDpFF0mTsFhH7YynuWhSfZS6raLR/5nRQ5Po4h4YiGuaxLD6bNVDEi1ZlEJZFnk7NEzeK5TKGikhjqiE/URXyufHoDxRiTpHAPGJviSyLbf1X+KBrwrIBmChskjVlxuDugU;25:BcZG/aMa0zostkZEwD4UlHuJOoMUBL92JMJivTRd2GlcE8nw+HuWXACvQuEu9mUigTVq2FwBaCRqJcqYR2QxqHDrMhAwI0jBLthiwJJN45NNDks7cVzg2Gk8xhzE2KNWZ+MWd+rauIg8UHCZv3kR7rnlTBaCqrLejXkFllSaalRoc7Wg50N7jQx9PMOK4GXjPmCcqo3l4hpjIqnc8sAYcrZ8HwaEFdCGgBU7T/hrIzv8xFopEZwfVa27x1wO2QVXB/w5EkjAJmJdX9NJ8a4vkiKbr/pw9OV8RKeP1Ny5GtdCkcVk9Q/qWKMsFTUIqPlvuRKb8HHLYTYjaej7NltRhw==;31:+oImrhwy2LSOCS2b4hc3OUR0kekM7qDkR+Sb25R0fzCXJ9TzX83DlW4jw0cuzL+Z3mLVE2daR4182bpth3OC2t9q+ThVfK4Ag4cFDljFR5czvqBdNf+5k08ZFx+lG/rFR2nSY1PFEYaEevpyhWB3fWir/EgDmB8my6uw0eRQyN1KSraNjL4bgrHVQGnBN7HnChtrs3D3slp5sy19aatxENNxl6/Mv9btQuPaLfuJFW8=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2829:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2829;20:71CL1V/Hzt64F2Il9y5YF6laK8wk0esn5ozcqg7encEiZ5gR1ilBAW3FXch/RvZOZRKCl0vMYtF5Ry/OcjmUgtX9tZF2tlmZ9TE70CaQx9LUj7maEKLnckyPI/4rMFpMl9NZNHcHSuVhvFnDicGtJcv16MgQ81I6e4Aih3GvyAEnRoCzjYZ59YjtPRSvLIYbVC8aOZ2ZdZxQ6kBdufBNCx3uPWzK7IhkUHtZBbkPBk97VUzrcLPwUHqPS1ejImsKBtcmPuypZTusP3mgf/pb73lgf+xHOLy9OfF27FQDkVBvg7Y+c6drJSQDCnzqf/it2hMc+1IX81IPbgMiYWQDm166uZ0xV7MBAed/3bDCD6JYSTrO9ZN+WDo2UNoGmkHv5PmKzYsR4UnKPspe2iPZNdbDfoy2+tE5rmVUmVkI/wY++VaYcJeNBVixFYvFsCMyP6GslH8+zBYz2jCeER1FKrSyNJWnpGXRPefGoC54B5E6nQs9szz3wKfB6F/mENYA;4:exxnxLCWwwuJMXsFpSvpb4QGIuDlscwMVJa+I1gMpCG5TmmmZikkJrrwV9iY4wALqLzL4NIBpTvcxThCvKtmpGb9QVp0JiqLQ0jGKNr20IBCFj4VkC6Kqq5tQ/8bM/nCn/nHBST8fc4mnZCnIeoRYD9SV5q8Y0Kx0kB8Uq56RBeRyQ3164vblI1T5MQiJtyMH631nXbAaIQAg/SrpbhiG6H9XCSREj/FEqWtf7IJLxF0htnWbI+GeKPZx8YXCLpnlsgyhfB43BAm/nhRXZo5vkA9/MfvZZXMAk5mCQOKDn0O8kxQ4ILGgqjdse//yiRD
X-Microsoft-Antispam-PRVS: <VI1PR08MB2829E7E542260B07B8F9BF10B0CD0@VI1PR08MB2829.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR08MB2829;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2829;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(346002)(39380400002)(39840400004)(396003)(377424004)(199004)(189003)(39060400002)(8936002)(25786009)(76176011)(106356001)(86362001)(8676002)(105586002)(81166006)(81156014)(59450400001)(52146003)(23676004)(31686004)(478600001)(97736004)(2486003)(93886005)(52116002)(68736007)(31696002)(6116002)(3846002)(77096007)(26005)(186003)(36756003)(6916009)(2950100002)(6666003)(47776003)(16526019)(53936002)(6246003)(230700001)(54906003)(58126008)(229853002)(316002)(386003)(4326008)(2906002)(16576012)(53546011)(65826007)(50466002)(64126003)(5660300001)(7736002)(65956001)(65806001)(6486002)(305945005)(55236004)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2829;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODI5OzIzOnYvK1pTUWhlQ2tacHdKOU1MQUdqb2JyV0V2?=
 =?utf-8?B?RndZb1Axc2xTeUdNTFdqdFAyczJBQlZYU1BYNzJrRzg0M1l5eVZlYW1kTkR3?=
 =?utf-8?B?UTVueWF5TG42OXhRek8zL1dERGN5TXFFQTlYdERXeFdBeklJN2tnVU1DMnBD?=
 =?utf-8?B?UlNUUjRjNnovaWpYM0dYbDI1R0JLbXFOeTJBTjhFNXk5Mkw3V041UHhTeVBx?=
 =?utf-8?B?ZmR3N1ZLOE9JQ3BtQW9ZOTBRVVg1NkVyd3ZjYnl2RlY0cnp4WXhrUytOQU5R?=
 =?utf-8?B?UXJQVGtrR0hpSUw2V3VFTEk1Vk9OWkViZ2MzQnlvRlJiNGZybjNTUklRc2tM?=
 =?utf-8?B?SWtaVmlEdWVFVUpacnQrVTFRR3lKNlkvTVZCRjBZbDlyK2VqMWxhVEwxelRP?=
 =?utf-8?B?dXBuSDFENWdDSjNQTE1aZ0l5K0xyTHVDUlN1cTM2VnFueGI3bXVGOFFETHhi?=
 =?utf-8?B?R2kybkdjUExYOUdRRzZRZkpGSE51RUR1dlNhd0VPRGYzZ2MwbEJZMHZJazYy?=
 =?utf-8?B?dmxUSmhlcUIzWjVhRUZhZEg4SUV1aVdnTGp3bnFnSVZka2RJYUhid1B6aXJN?=
 =?utf-8?B?RC9jRXVidlpNRm0rdDR0TkZVYlJ6S0pGa25oU2VjbW5HMVNJUjJoVHc0ZUVB?=
 =?utf-8?B?ZjBiRFkwMWQ1K2RtTExtS1VkNFltQUJwTk9SRWJ1dXpqa2hRcUR3cTBSTjJj?=
 =?utf-8?B?bjhrNzhodS9zcUNxYklrRWQ0a1Fpc3pRUDNnRkVMaEhwZFprY0JxZExZWkEv?=
 =?utf-8?B?MjdzNUhWNEVjb245UnFVRDlKaldaaENmclF0Ulk4SjFtNmZ4WkFQQWU0RnU5?=
 =?utf-8?B?ZlA3WTQ0MzV1WER1b1RVT1doSXZVTFpBazZMYWJ3S211bTV2a3k2TnR4WWF3?=
 =?utf-8?B?MXlyaFZIdnVMK3lPVVJmL2Fvb0hRb2JQbWtCYWIxdmxZNDhJQ3ExV0lRa0dR?=
 =?utf-8?B?cXltODFScHNOU2I2TXg2TnVndGlHYU56MjdWb3Z6T05LQWtka20zejVJUXk5?=
 =?utf-8?B?NWpWd1BraTAyODF6eGFqbGIzN2t0L2kwempmOXZ5eURsTTF0L1pPcHA1a3F5?=
 =?utf-8?B?TjVWUUZSRW0vcU5PV21xdXQrOTV5dnpoc1VKc0pPWjJZbElQZU1KRmhSdGV6?=
 =?utf-8?B?V2h2VHNSRUFjbWdXaTdsK0JyQlJ2TzZLT0RRUU5mQ2FqOUVvclVST1pEQks1?=
 =?utf-8?B?YlV4OW5TVkY5TjFDY0wrNkhkSzNOOXczV3dHVTlvVEw3Z2pEZ3FrbU4rdlJO?=
 =?utf-8?B?QlExZ3JFNFlwVGI0RVF0N3F0Vlp0b2hTTm5QSTNyOGlzVGcwVDVaTC9Bektv?=
 =?utf-8?B?Mlhnc2N2dXREVkEzeXBSWEJTZW5QMFI1ank5V0RPR1lLWjR0Q3lGRGxRb0Jh?=
 =?utf-8?B?MjRnbktTYWxwZTE5UXQreXpGNkZpVit1cHJTaWxUNkhZYmRsZmNlTVlMZ1dQ?=
 =?utf-8?B?dVhVNE9VQjJManpsMmN5U1E3YzB1V0JwQkQvZFZ1SHRzYnd5eWdhWmVEMGdy?=
 =?utf-8?B?T0NSWGd0YndNK3hiY2xUV0hMbTZ5MDNvcTR6MytJcWRRNHpIUVlVUmpTUnAv?=
 =?utf-8?B?MWVmUXZqU1NneElpV0J5ZytrRCt5YzhSOEwxQ3lLbkx6VGdOYVErWGhyMXIv?=
 =?utf-8?B?ekRRbHZsYVhSbVNGS3RJMVFXTDNKamx5cTlJYUdJQzFYazlVSmthTmxtMjNo?=
 =?utf-8?B?SGM5amwyLytjNUFReFVxMXdMNGsxaXl1R3djRXhvcHNuT0dZTDVaT2V4NVAz?=
 =?utf-8?B?NDVBa1cwQm9VdFdJbjBDMXE5OXpBcW5KUXNJOFljVmNmYm1ncGhPbWNhRWdH?=
 =?utf-8?B?d1dkZW5vdTNZSVR0MnJXeXExUm5ENFlTMDd1OTIrYUh5MzFpdGRWbmtGUURJ?=
 =?utf-8?B?dzlzcUdyUXpyVUR6aTZzOHZuS29JcjMzdU5RZ0tGT3l2RXY2ZkhQaVZabThN?=
 =?utf-8?B?WkxiUm5QS2tCSCszNFZZanFrY09PRXlkYzlETkhaSXYya2hwWmpVRFB0V3dm?=
 =?utf-8?B?cVMyU0pRWWhZb1lzRnZVNmVzQmNINlNLRWJmZz09?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2829;6:B9r2afQalsbBYqgtL/Dkj2TSCTPiu2+GekoG76cbJGrTRheQ3TjiYs3BS4kSlVjgyWZ0RxjnH/lgIVDzYwq6deGLg8Aqf6yDYSRODOIep4IslwVBcvu1IU1XTnf80r0hgvKAWrMv7wsVVfpJym+EVhhtmMglJHwtpn4dASBFTfYY9W5S0uJoKWq9cRJ1VvteMywoz16izO6cIBoBftUK/MYGCiEQAUHp2UFKP5O5r5MCUMk3OOa28D+BxKhpN8Fh1AoPlTfVs2jTA7ir6Pds2Dhf5jRCp84+ZB88Yaar97bkfhe8a3juOqI32Ii+2cj+yFqEd4QEi/ZcHqtEOZBU2Kk/mOlluMjAes/g525Y8nY=;5:EQkcMVUyIQhD+0o7NPulaPcpvxDWhomVe672m9iymnAvDr7aOgPHDoPKcmnaHiqL+2C8FA+8ywGU+5vKmhXZ1tgay4YwKEYGsOMKnNT/VSnpZg7paZP1Y8jkmkDx2V5E8Kl8JCG8mAtAYS+3XKlB+MCdmk5LG1+EdiCBhy1TsmI=;24:cAJziarUzJVEejhAATh0DqD2MUxjw3hTOBwwETekDOAM7nUxv8U1gmHsVSVOUYjB++1dTj0agafaYQ5vZAIGuTInsHNk001MJdYtHAQDdY4=;7:GjbXufFv2bJ0HQCw9UOn3AZGWtsKM/w0sGVEpkvHfIrm/7BVdekZVluiQEdYcEuRCtyJ/HHSUCsE9G5xafjyUt5lnBiP99En0t4EZELIZ4MSpgiin3fBbuZxX+J+fbAZi2HAmTzjZ49QZkCfYEVuLpfF6chU0UQfLMq7QyGBk2G/If3UBOH3135M4H7l6SlO6ootKxdVn5VQiPAwMkQWe0dqcrv/FwJyOWc3OLRCVFgLlC1s2o73qMif/uPjLKmr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2829;20:E5aWUnaKFnllCOeUHk5asvR2D+Wu1cQx4dI00hk9n06f8TQELJGAoAR/F4di7LKCBE/YwI86ZDGDFCIcJ2iwjb0Uupq8qOgJUI9zgJr3A62rWH6tl5FQQAxCl3wEgO1NMqfDUJ0KoEYDzo4Yo5yFnkW1h3J+Hwd7Vnbxl77tLhA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 15:37:39.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063dc68c-5d54-482a-8efb-08d57a0a356c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2829
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2018 06:33 PM, Michal Hocko wrote:
> On Thu 22-02-18 18:13:11, Andrey Ryabinin wrote:
>>
>>
>> On 02/22/2018 05:09 PM, Michal Hocko wrote:
>>> On Thu 22-02-18 16:50:33, Andrey Ryabinin wrote:
>>>> On 02/21/2018 11:17 PM, Andrew Morton wrote:
>>>>> On Fri, 19 Jan 2018 16:11:18 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>>>>>
>>>>>> And to be honest, I do not really see why keeping retrying from
>>>>>> mem_cgroup_resize_limit should be so much faster than keep retrying from
>>>>>> the direct reclaim path. We are doing SWAP_CLUSTER_MAX batches anyway.
>>>>>> mem_cgroup_resize_limit loop adds _some_ overhead but I am not really
>>>>>> sure why it should be that large.
>>>>>
>>>>> Maybe restarting the scan lots of times results in rescanning lots of
>>>>> ineligible pages at the start of the list before doing useful work?
>>>>>
>>>>> Andrey, are you able to determine where all that CPU time is being spent?
>>>>>
>>>>
>>>> I should have been more specific about the test I did. The full script looks like this:
>>>>
>>>> mkdir -p /sys/fs/cgroup/memory/test
>>>> echo $$ > /sys/fs/cgroup/memory/test/tasks
>>>> cat 4G_file > /dev/null
>>>> while true; do cat 4G_file > /dev/null; done &
>>>> loop_pid=$!
>>>> perf stat echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>>>> echo -1 > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>>>> kill $loop_pid
>>>>
>>>>
>>>> I think the additional loops add some overhead and it's not that big by itself, but
>>>> this small overhead allows task to refill slightly more pages, increasing
>>>> the total amount of pages that mem_cgroup_resize_limit() need to reclaim.
>>>>
>>>> By using the following commands to show the the amount of reclaimed pages:
>>>> perf record -e vmscan:mm_vmscan_memcg_reclaim_end echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>>>> perf script|cut -d '=' -f 2| paste -sd+ |bc
>>>>
>>>> I've got 1259841 pages (4.9G) with the patch vs 1394312 pages (5.4G) without it.
>>>
>>> So how does the picture changes if you have multiple producers?
>>>
>>
>> Drastically, in favor of the patch. But numbers *very* fickle from run to run.
>>
>> Inside 5G vm with  4 cpus (qemu -m 5G -smp 4) and 4 processes in cgroup reading 1G files:
>> "while true; do cat /1g_f$i > /dev/null; done &"
>>
>> with the patch:
>> best: 1.04  secs, 9.7G reclaimed
>> worst: 2.2 secs, 16G reclaimed.
>>
>> without:
>> best: 5.4 sec, 35G reclaimed
>> worst: 22.2 sec, 136G reclaimed
> 
> Could you also compare how much memory do we reclaim with/without the
> patch?
> 

I did and I wrote the results. Please look again.
