Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932946AbeBVPMt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:12:49 -0500
Received: from mail-eopbgr30107.outbound.protection.outlook.com ([40.107.3.107]:59892
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932624AbeBVPMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:12:44 -0500
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
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e0705720-0909-e224-4bdd-481660e516f2@virtuozzo.com>
Date: Thu, 22 Feb 2018 18:13:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222140932.GL30681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::25)
 To VI1PR08MB2831.eurprd08.prod.outlook.com (2603:10a6:802:19::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8cb2fea-7adc-4a0f-2b3f-08d57a06b75c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2831;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;3:1LjXjytR0zjLtqyjjGbaH8FbIiT+0x3kwKTllvlP+qp12pV4SxC/pAyYuHpqdswp9hf0XxL3Av+lY39BvQcb5wi8YJvdiwwGhL+nl1wodpIH3UCnGfS0VYSuPkMHaw6v0RO2rbp1qfDhkCkKqv6Z+8dY3wS8tEA/q8s7Q/wN5t81vlmsmpmhyHztIg8Y0E88r8N0+TwwuDeVhOXNJ5wNtmiNIt/Lfx2twENz5aK3Xv1n7Pm4JxEkmgKRRCRUz6zI;25:kr0BlTbJb2sg5PA+1yb791tX0dSI5w97DbY5hVGNyWeNCyHe6yIhyBMTGL4H3t47J4/8Jiv+iwin+sPrXzl/ja2G7dkCtNGQ4OoVGDdF2S+FGO0tlpFwWpqONK1Ew1L7FXEMhRkPmWM/eqer18/GUo0efDqhDZl2XFXvtcRPM/S8bONI/9rBSuVV4yL2UxWRuXrDd7ZeXv0xFTcaNqare1nXs0f31wGmEdIXO1DDeJmVU7QUc9eEpbXVkBCMR5CYMx5vGH+KWnxhc9OGFTOPtLRDwNiFBfowJrTbVqopdKssY6RQs4x/igpvQKAfIXBKzOuNhDq06hgrunxPjTbmXQ==;31:o/RF4PoG/JWz87XANss+SLWdZMbIYsTwCXXwGuM3cjz6MF7grJjns3rwtmCZkzjQoWmb3aHzOCw7Hk9JfLYRfiV1ShFnzlL1VoTt7PSqfieILvpSc0+Tp82mqop8XSkl7VlAonWFwdxeKzdo7WIUpg2QGMhocVGyXK9agrpdAskFmcFZHK/ugw0NZs18mYHTuoEULf4US7ggNoDfFapFV0CpSh17WcKnW2PDMxPXF6c=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2831:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;20:vs9OtG22P4NKbq7LHU6aoPh/evx1wrjF5SgcvJFpagW56aK0yPxmkB7mE/e9QspFOen9zOYXxW5ZCUtqzQNONj4yeiC0ZbtyitfN/8VqNU95UlmMBWnjkJy0NZDnZsGwkM2uyidGPrSOMo2DIo1joyhM23MzQkbXkKg1luDrM/Gg+kNS4EbNBaVBwxt/TQOQ2Zr6r5fbn6o3XdEsgbTf8aX3Rgs6DGArivhBZt+XrVtd1GjIMuFMGq7rDi9yg9sJLJweR5Hkgl/oYZDMNgc3jxReC9HNCrKiYE3XZaJD7hL+bvFzBtsfHIpa0Rb1u9EXuQohZ8YhP6HdtpdZQjM0tNxvJ2rR46YegzagVbFtwg2i/InvmBJW+yKGiqvsE960WVlYu0+G7ZDM9lXi1xoS6uv1x/21YXoFJ0PIyEvgB33PQoVLrCm1o3SRVKLoyjgigzF7x2ulkxmdLpdvmJ6t9cXtKcXSmSgrWuv4jOjSXYVD6T1aGa+TRNIALr/k1lNp;4:DnMJ1aUgDTNosZBU1UBUz6qznkHvRkb1BpQfBYpGKC3NWPCJCAEiav/UkI39zFddXHG2L1QUOfVhu0o4G1Ps69d0J1W63HThFGofdedpy6JlFyIZQCnw4wCl6UXuvvw+f/213ZCXqnpf37mYeKBRl4l+tzRrwmGKjrLinG22oU0CLbjS8m41/C2UYTKWNe1GbvSzHZRxBllDq0weLWRTvAKiYfmzVBR82Bmtw62tQCwbhKXYtg4dduh9nHQ41LTzUQPzOJxY+Kim4iDiN5rt9kDqQ5Rm/bsHbwl+aVRLEW8tzvVLtCrn28e7bXi6n6BS
X-Microsoft-Antispam-PRVS: <VI1PR08MB28319B1F0CCA1D0D533DFDE7B0CD0@VI1PR08MB2831.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB2831;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2831;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(366004)(39840400004)(346002)(39380400002)(199004)(377424004)(189003)(305945005)(65826007)(53936002)(68736007)(64126003)(2906002)(229853002)(52146003)(2486003)(23676004)(2950100002)(186003)(6116002)(6246003)(31696002)(6486002)(86362001)(36756003)(50466002)(93886005)(47776003)(58126008)(54906003)(52116002)(97736004)(65806001)(3846002)(6666003)(65956001)(81156014)(81166006)(230700001)(39060400002)(106356001)(4326008)(55236004)(53546011)(8676002)(316002)(6916009)(66066001)(105586002)(16576012)(5660300001)(386003)(478600001)(8936002)(31686004)(76176011)(7736002)(59450400001)(25786009)(26005)(77096007)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2831;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODMxOzIzOnlYWFFNaGp3U2VSdlhNL2Z5Tjl6MTlpcUNJ?=
 =?utf-8?B?SjE3SDYxalZPZkZzREliblRpOUdxSDA1QWZZS1EzQTdxc0MyZTVPam03dkto?=
 =?utf-8?B?SHJBMVlUSER2TmU0cFY4OStVc01iSDU5enRESXF0SHk3dkIzYjVkNUpxOHFo?=
 =?utf-8?B?TkJUeDdUYjJCMGdyaDJmV3hscC9wV1dVZHBPbmR2VWtkaDdUN05LUzJYM3J0?=
 =?utf-8?B?bzJtNjdrbXVtQzNRTGYyZUM5ZG5ZQTk2cUhSMHFFYXJqVkU0NkppRXplQlBs?=
 =?utf-8?B?STUxRGh6QzB3Ujk3V2ZFeEVRU3JaenBROHRPdW5zU0QzZHZjR2t3MjNKam9m?=
 =?utf-8?B?SnRDQnhKYkdCWG84dTFqemI1cGlIMFBvZjl3QSs0NGwrSEx4V3VxRWNlYW1T?=
 =?utf-8?B?SGVvY2pPSUZNNWJRQzZkZnh1YURHRUQ3bnpzVWxERXJOYnFLRVd0RURSTzJT?=
 =?utf-8?B?Q0lXeXZ5MDFoL0FiM3Nod2VEUzd4VDFnd0JPNldJSmtzU1pNMmVtdHNoZXlJ?=
 =?utf-8?B?bkIzWW9lYzMzbXNsU2F5VVorcG1LWHZYLzZIMVBHdm90UzVXZmJsU3VjNHUr?=
 =?utf-8?B?SzdoMExXcEZyNDYvcWtSVjNrbzMxb1hBQ0ZJd09oMFhKa2V0ZGROZGFldUhP?=
 =?utf-8?B?bjBkUGZ5N2lyTVNrTUt3UmZvRkVpdEQwanJxOXNqZDRhZ1duMUVjbWt2SDdP?=
 =?utf-8?B?QSs5NWs1di8zQzRjaWNDNnpxTzFCeWppZkpsWE10clZldmVBbDkyM3hLcU42?=
 =?utf-8?B?UzhkNzBXTjNibzRkaW1UYVZjUEd1YXZWOWM0RmVRTEVoRWhhNDdzeVZRNW51?=
 =?utf-8?B?SlJkdE5lN2g3MzBTMnB6dEZsYkFRWEl1Ly9SeXFVaWpVMEZKVDluV21QaWkz?=
 =?utf-8?B?d0hGV2p1Z0t4RUs1OGNpcWNHa01rdHdvbnhMNXVWOFhHanJ4eU1nOEJkUUNa?=
 =?utf-8?B?U05FNi9nZ3pEOTFMRlBreHpMK1NxWDBOcTg2WVpDdHpmYjFZaWNjdGxuMEdJ?=
 =?utf-8?B?Vi85RzVnWDVEQmF2WWtjQkVKOURseXRxK3RienJib1plYmlvY1ExQXJpV1lw?=
 =?utf-8?B?NmNpOTRhOFptMXR4T2R3NXdzemhoQllqS25tWUQ5YllRWDR0UVR2TFdBdHpl?=
 =?utf-8?B?N0tRUk44WGM4MWJpSmp6aW1Da09qeWsvdHZMWmRjdjBwdnRZTmY5NitQUEFL?=
 =?utf-8?B?eXF4VEFYWU1ZNmIwZEJSbGNLcUplM0JmWGdHY0trYTlpY0ppSHJwQXlINk9l?=
 =?utf-8?B?Wk5pQW5jeklpdVBOMjdBV2V2L2FYdThiUUN1RjQySS9hNldlTXk1L2hKb2xT?=
 =?utf-8?B?OGwvc1haNWZxY3VNKzFCMEt5Um5TQVlreUJ3WXlVdm5nb2ZmYkN0Nk5URDZY?=
 =?utf-8?B?aGRNd1hjSnpWT3IxZHkySmNqZnd2Ym9CYkpSWGNJeTA0ZVhmeDBnbVdFdHE0?=
 =?utf-8?B?eXBNdEhjUXZTMFBldDRWT2NONllhdS95RFhSb0VUTnNjWFBNMkZZYlRkSThm?=
 =?utf-8?B?cE9qckpmTCt3RTNiczV1N3hPK3ZHYy95em9BTFhXSXlqTDd5YzhXOG5YVUF3?=
 =?utf-8?B?c1U0NEk4a1ozQkk5ZGFubXZGaW9obFRDcVVZN2pEaDE2SHQyZU4rOFB1d0sy?=
 =?utf-8?B?VUg0WFp0V2ozNHVWTjh5aHBhZkd2aUlUak1aOW5mZmlWUlhmYmRmd3hldUZi?=
 =?utf-8?B?SG9vWTBDdlhUTWhhYmVUbE1sVWNpczROaTBJL1NOdkwyNDdEd3FSUTVrUllG?=
 =?utf-8?B?NGRSOS9ESXhiMmhIV2o5NkE2a01wZ2pJTDQ2V1pxeG9xajZWeFllS0QvQzJ5?=
 =?utf-8?B?K1ZkMTFGUXVud2ZWUzRBeERraWcyZHZWb3Q2ZUNOTy8rbmlJS0wwbnNUMEdB?=
 =?utf-8?B?M051dEtGKzlhRXJWRGF6N1lHYTJMT2FtNlJxeGpaL0hZNTdKWFNjZkQ0TTBS?=
 =?utf-8?B?L01KcEIxT3FuaTdxSzRvMGVSUW41Q3RsaXJMT3gwMHpEcVlGVndMVkNWK2t6?=
 =?utf-8?B?Z3lyU1oyZnV1Umh2RUFqeVk3SjJ2SVMzL3Bxdz09?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;6:HGjgeg2KGCgM6NxBawsgdfo7HEvHt+pqm9YbOV1eBoqxYDEFCauHKe3DBP0yrClUOYPvkS4glv/gwbS6i8rhvrKGsQOsdwq1gCEQPA7aShXdHA1b+9lP/4QlvRCBHP4UXITLAsC6Qdsdk02EcNIFP3ghG2KCsjeycvOowgoel/k/l2F7d8XqbFN9kHTHNhmunCFaTSANLb7RKaYOiHeeCn7kVClq7exKm/n5NdW2X1kfLAjUktshoDj92TDdr6xQdNausXdd043D8wWdhIgSEcQoRsg4KXHMnMh23sdQf5FYfX+6dxAQeVKeRkrUehYk0ROmy6FFVHdpIa2B4kRa4fQsnzZ4VQzp09dwE5MGlRY=;5:H7C46KjDrUTuIWv/6P1MB6dTBPOwz/Sk0QVB3WlA8oZ56tz4tS/pb4SDULhAA3XdV+hpkI40w1xFSEHptrqkUulqLJOgv62eBClB2dPiiEG8Lsyy3z8fa1Yqr+QyU/8eSkHG0ctyOxQ2rD7uUd57T2aT7ZQ9EE3YRyf0Hpw+QEM=;24:3m8MGVMaPqxOwBpBjqxR4WXjplngSbRec3LOOo9ca2fv/7Vd4sxj9czmt7X5IGm3/4rY3BTpU40Ev1Y/nG/16JQqLDtQSnSUA6esy6RCXuA=;7:hIC9G5qeX4Ghud0GKjE+sZmHt/wri/lfu5HK7MNvy4EcxS9GxON3C8VC1ECxITZ7sDh6CPtzGpOkBTswOEf8lYbVng6LDFM7RijGWZ20sJ7+Tw5365saBODq8Aj0Ioe/Q9fs+AnOfsiQx9KeFF8JzSKJjJL51oJpgeKeLtcex7aj4o0kgaZRUwx2NMwGToGubJkV/f2E3Z7gIwe4oecKaXZClq2UeARBLl4fzvcEmB8xvI8sGW169N28D0kYbYPb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2831;20:K4tK914AL3S46OWNvEyw+4c75Qhf2aYEdo3dwAlmb0kK/mOUPl/SIIMEQ4peHY3Ds2egACWjaB6yzbnC12Jde7in1vwra9VocousGTGMZ4vrwYoQAxMzBHHHzTCPqdpNaFw7ODqJiCbtXm3bESHrZ3VFg0BSwWpcRrnktZ5pKuE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 15:12:40.0425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cb2fea-7adc-4a0f-2b3f-08d57a06b75c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2831
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2018 05:09 PM, Michal Hocko wrote:
> On Thu 22-02-18 16:50:33, Andrey Ryabinin wrote:
>> On 02/21/2018 11:17 PM, Andrew Morton wrote:
>>> On Fri, 19 Jan 2018 16:11:18 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>>>
>>>> And to be honest, I do not really see why keeping retrying from
>>>> mem_cgroup_resize_limit should be so much faster than keep retrying from
>>>> the direct reclaim path. We are doing SWAP_CLUSTER_MAX batches anyway.
>>>> mem_cgroup_resize_limit loop adds _some_ overhead but I am not really
>>>> sure why it should be that large.
>>>
>>> Maybe restarting the scan lots of times results in rescanning lots of
>>> ineligible pages at the start of the list before doing useful work?
>>>
>>> Andrey, are you able to determine where all that CPU time is being spent?
>>>
>>
>> I should have been more specific about the test I did. The full script looks like this:
>>
>> mkdir -p /sys/fs/cgroup/memory/test
>> echo $$ > /sys/fs/cgroup/memory/test/tasks
>> cat 4G_file > /dev/null
>> while true; do cat 4G_file > /dev/null; done &
>> loop_pid=$!
>> perf stat echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>> echo -1 > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>> kill $loop_pid
>>
>>
>> I think the additional loops add some overhead and it's not that big by itself, but
>> this small overhead allows task to refill slightly more pages, increasing
>> the total amount of pages that mem_cgroup_resize_limit() need to reclaim.
>>
>> By using the following commands to show the the amount of reclaimed pages:
>> perf record -e vmscan:mm_vmscan_memcg_reclaim_end echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>> perf script|cut -d '=' -f 2| paste -sd+ |bc
>>
>> I've got 1259841 pages (4.9G) with the patch vs 1394312 pages (5.4G) without it.
> 
> So how does the picture changes if you have multiple producers?
> 

Drastically, in favor of the patch. But numbers *very* fickle from run to run.

Inside 5G vm with  4 cpus (qemu -m 5G -smp 4) and 4 processes in cgroup reading 1G files:
"while true; do cat /1g_f$i > /dev/null; done &"

with the patch:
best: 1.04  secs, 9.7G reclaimed
worst: 2.2 secs, 16G reclaimed.

without:
best: 5.4 sec, 35G reclaimed
worst: 22.2 sec, 136G reclaimed
