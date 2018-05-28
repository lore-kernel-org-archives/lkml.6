Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeE1Ioj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:44:39 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:45242
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753493AbeE1Iof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:44:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v7 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
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
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
 <20180526171533.ucg27d2tnbvzt4oz@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b69c6ef2-f519-6834-ea92-9b609f583fdc@virtuozzo.com>
Date: Mon, 28 May 2018 11:44:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180526171533.ucg27d2tnbvzt4oz@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0043.eurprd07.prod.outlook.com
 (2603:10a6:7:66::29) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:wBPfRP6vwUZwuVIaohZEQUD8h2f5nAWKulh9v0MuKxs8WvJPPB6hK9CpQcTR1nc58TNvomz11E9W3MFVQnujxMGu9KZwO/X+tMS71+1e+0d44Vg4qeQ5lAtAqZygSMwKdF6qJti9NuX5siR+CsTkvLkdXV9B/+MjpBlexV3Y8Hkf+XSRlrG9Hh237E/WQelE3smXFF6ztklGhMXOmgRyNs8MpBpqxekoBFN9fVzy7yKqLQ/UIr0X+O7IuqkpIxYN;25:+jxPx8Y6/vDYlDeDwDNPPiGycmhs6LWQl/+629HYm4SW2cD9Wid1POtFOFspqmKq0HQkeI7gyIx7dl7s5jh5Yxi8GsmuISZblkhFOOr5ymO+31v8dxHNryBOgzdmqF9YFjGCm10yuhqk/pKCYE6r6swEdbRLirkscblo1RdKNW+17PnrNdl2JZLY2Uhh68quLC8phB+dks0/ToAwYgkXH9oUveTCMpe706JAcX2/vCB7jHF/RbfECT8Sr+Dv3zY0judZaVi2Hxosh2cWtdt95fnRQ/wlIVAI79UUdc8jHN5+nMJbHVwqLW99i4/pxc3B39YJiNbKIhnphKBQtDYdUA==;31:VpHFAuGDiLLn7X0xHOHxtfJenPfwAQKPGfAZgzXt6EugShy7nWFY6cqjA/jnzRzyfCrgFgQmIIZwVdyq16fcFL8pi21dvEuRxjNo9g6IiVNq8v6VYRhiECBJBdxGkvaVTBfoG60mbnzgSeguuGF0fiokBMi7kQiHOQvSSEWNyN3hDUp67AsZ4twK4OfF1iL02Mfb6qD7jBexDhcL1rAZ25IhGcJf0Ed34uTV9mPLX+A=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:h/czVp2ZLKh2UL8l5sdTc55E9lp7U6DC35aV+OJlFFolLjVICahe81VddfjAoCAsx4hwbQoojuVXY/6j6gC4cvsR2gv0fdQ0ZQocM4A1aCJWhnsQNX9XupHKQ+Zx7o5K6obL/FBmkZghg0quBZH4KwPfNtpRopOaNwZJwCoA2E1EUvs876AKIrTpyLTrYsxwFCvKqajRjMuxeFhM+hcltb4BygCuN/DIM7WapozYpbN7t97q903VTFsgaJ8Vcef2HvslomtpmDqjfelCO/LRRrfnC6aeVdeMLOX3SppyZnZFp9yhd6Kla17C38PxKPqFhWc0ILILBlf1JUmFzA2/IVA/LtUOlobU1kXVD9YUa6XtR6DAr7cZrOKS4IAFdhB0+RvQpWDFfss+sY9u9JcjEcx7AgAQoYtHjoiY+dWlfAkHJ3pnq7U77fgl+RrZ3k3NTNW+jQsM7NX10l7xN8Ke64CFuY17YabTWQ8gNsXNAX7jmX2G8lyCq44GrnJ9YVsA;4:whg+EzRT1NvPaF/EoQPKzFtRn+g+YFyrB9sGCnJRc6194TmWDbvsVxfhty+YFGQskD6tzWNcVPS8yFWbRc+HQytokq3HHXTF9kY22h3R/KpXsVHFE6juoAo9X4CDRgFNWBDxujeYVBR/cDLS1Ojp+rO6XNCktgqjIrVRnUklWp9DQN03ZpsFDgXRTREdWDmUMQZ72nI+CDRgv+oNwXW/H7xIyFSNbDHUMDfQIQGQ3idw9Kplk+I8TPzDm8dcBSUaSpmVsJ29f+d8G9WGKbyeKRFKpfOSgZ7lox5OQThxl39t4KAUOXxt9mHluMJTXWqsS3Tfys/IM9yS23xvp98u3ayXH9JRkLNeHwFQfK2HdNQ=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13292BD94F8597D20CF1D452CD6E0@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(366004)(396003)(39840400004)(51914003)(189003)(199004)(4326008)(31686004)(6916009)(6246003)(66066001)(64126003)(65806001)(65956001)(65826007)(7736002)(2616005)(486006)(956004)(229853002)(230700001)(476003)(3846002)(105586002)(97736004)(6486002)(6116002)(81156014)(81166006)(7416002)(52116002)(39060400002)(23676004)(2486003)(52146003)(106356001)(86362001)(11346002)(25786009)(8676002)(36756003)(16526019)(446003)(76176011)(8936002)(386003)(68736007)(107886003)(47776003)(478600001)(31696002)(59450400001)(26005)(53936002)(77096007)(50466002)(6666003)(58126008)(53546011)(16576012)(316002)(2906002)(305945005)(5660300001)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6ZEZORFl2VFhJcDNlQXVVTGoyeEQ3MW81?=
 =?utf-8?B?eGJHRXNuSXkrR25Gb215RjFiOUo5ZkRKNkhhQWRid1NVajQzVm03SFlBaWt0?=
 =?utf-8?B?VWZ2YnNnN1NVcGNwOHlBd05LblppS0YxQmFQWnFwZUdkT1FwUnZ3WDFQU0VS?=
 =?utf-8?B?TEc3R0p1RytiODJlUXNDeTVsSTY1U1hRR1kzTndpZ01CRXdXWTdmeVduRlZB?=
 =?utf-8?B?QnUzVk5iWUY4Y3pYYUI5K25JVmFmZWhjcjd0TlBMYlJVZUtnQ2lmM1Zjc1ZG?=
 =?utf-8?B?a01lR25tVlB5NFFnYzJldXozNG9rY1RiaHByTkVuTmNJeTY0Z0hyd2d2a3c1?=
 =?utf-8?B?RGNBMEdOV0J2Z3JxU1JKTkFVS3V0bDdkSzFJdzAzb1NNNTErVVVqSDg0TDlB?=
 =?utf-8?B?ekxEeW8zNzcwT2hBM0c4ME9DMjgrZjQwU1ExNytESCtmQ0RqU25Ea0p2UGNo?=
 =?utf-8?B?UFg4UGQwRHo1N1YzQXg5TDUrSXNDK0lGb3kwU3BweFRGVGZTb01ZekVRUFZt?=
 =?utf-8?B?VGJNVHQ1RDk1bFlHMXczY3V2OVhqMDlna2JWZlRJbEQxNUo3bXBDd3A0R2Nj?=
 =?utf-8?B?UHNPL2hvcW9TOTN3ZkkrNjh2clFZNW1mWnZxUWZ6M0NhKzJTZ2JWZDV4YndC?=
 =?utf-8?B?QVFHUlBick9HZTU1d0I4MnBVS3YwQndiS3BNTHNTdTNSQzNOMTY3RUYvT1lF?=
 =?utf-8?B?M00xRENDeDVRU1RuenhKZTRTQ0JUTERJSEZ5Z2xzZTNKZTZTZTNLdFFjS0N3?=
 =?utf-8?B?RlJUK0JkKzZQOXRwVC80eGdYSU1SMG9MQkZsdUtuUmwxVGpENHhGc3F6RWI4?=
 =?utf-8?B?UklEaDlMQ2VQeHQxSVlQMlJuVSt4N2FJV2VzQ2Ria2tqRDlEdFhaa3o0bFZz?=
 =?utf-8?B?TXJ5ZXhnNlk5R04vOGRKTmk4Nit5Q1k2TGNsOXVlQi83MjZTVHhZTnFNQTR1?=
 =?utf-8?B?a0dudDVEMWZaeUtaTFgxUHhob2ZPSnQveTdkalJUbnU4c1ZZdElsNnNSbFFD?=
 =?utf-8?B?dG5Ubit3bGJiZjhIYjYvWVU5OWxFYWRtN3NkM1RnaHpBMkMyQjRjdThpcWho?=
 =?utf-8?B?UkN5MllZdVBzUFR1aS9jV0pXYmhjR3pIQzlKVnhWaWFzNTZYL2tvZUpEWVdL?=
 =?utf-8?B?dVRWVzRBbnVhUWVIK1FwZC9KckV2K3Z3SEdKWWgrZXFpaE4ydGdQRmo2Zzhz?=
 =?utf-8?B?OUNCdGZDUlZic0NFUVJ2Q1hLbVZ3MDRTcVdzMTcrSnA5YzRpMS9TYllVQ0Fa?=
 =?utf-8?B?U3YrVTl4SmtPRWx4Sy9nN0c5YkRaSGtSVVIxVlhONm5DOUExZVhyeG94WkRU?=
 =?utf-8?B?MENNOEsvd0xUYXFYQTAxNUppUlA5MkxTU05mSktteU8rOFFyOG1qRFZuaDNK?=
 =?utf-8?B?RU1NTC9FRkJMYzFCUE4xcTJXS0tzcTJIUzZ5ZkE3aDZpalVGVUZBTGl5RENI?=
 =?utf-8?B?SUthNXNtaVhoMU9VdndQcXp2TkpnekRhZWJKNVo2dU5OcUIyQTlKbktuM1Z0?=
 =?utf-8?B?R0FULy9odEdlWUFWcjR1amhHOEFqTmFtUEJsd3pIVjNBcnpJckhsZDRxOFF1?=
 =?utf-8?B?TFFPNDNPWU9taUtuWGlTTlc2Y3pNL08rcEFHWHhGc3dMa0ZoZUJzQ2dDQXlV?=
 =?utf-8?B?S2UxalBlVU12RVdiaGNicnZ5K1VvUllIYkg3RHFja3dyUmFmWnRwekdaSzcz?=
 =?utf-8?B?R0V0alQ3TzdMd2ZoakNPRmtFM2k3U2tPUkVlSnlJR2ZaSmNBdFQ0bzJlYVlE?=
 =?utf-8?B?cFhqN1JHaGRuWVJZbU91cWEvbG9IOUd6b1g1T1cwRXFsN1NZUzJ6TU04b1JO?=
 =?utf-8?B?bkIvcUc0bFc5cHRlZW5kUitua0wrNmQwUTZLc2dic1ZQWE80bDgxbnFkUjZt?=
 =?utf-8?B?NGZLTUgvRE1HSlI0N1c4dXpOMWtiR3hDRVdXbVBPbkg5TXJwVkZvY09kQ2FB?=
 =?utf-8?B?bmVVU2NGNVVBb2xiMXYydFhoYWhjblB3SUlWYkJURnhUTDNDVDhUdU16MHli?=
 =?utf-8?B?VEFhTDJaQUZyNDA4SURyZ0RXbHlKeVpjK1M5VmVWSGl1a2FMSE1kWFpFalhU?=
 =?utf-8?Q?9Ki0tF57SpOC9bu/dFGfUPHNoLO?=
X-Microsoft-Antispam-Message-Info: xd7IZxNMKzXJuMCcu76kK6FZSiCenrQN3jmxMPwQtykkFhqDwr3QG8VH22j7Cgr9XEkqH1RjUNmxSfYcC9vW3IAEd/ZVBLtZplAP5N7CGUj4bXfWqQp6OEAQY1WeaDW+NLQMp33X934Kz219ZKVgm7TQbRBd511k6ituVCoCJYU2rHZNmEr4WuYaDAYKWwSp
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:yr5IIFEfXMJB0BsyLOmlC2id62qUDQ72PE3fM0EtKuOrcePT1JZNqCuOmGnKwuvlQRUjR4q4ytC+gxYB4aSvjGzXwaXESDv6WOM645gOR0Cp//gImn5K55tpf4yFPy1vT+Y2NmhS8g9z1fgaOB9GzoOvrrUuxOZG2a0kN9550lIgwqB424FsZoT/w0uBHT1JkZpQ9MjYoB4rsZxdMedrisfpofafNzLhF8R0LdpcGaGZPAqilkAlUjDJB6/05YFrzVMdKNKKOojskjnLkLymYMyq+ImzsZRR7WgIa1BqWLZK9vL28WQGqBoct0yGXWHtQhmpz1JBkOEoVZXtG4W5P0GOfq/GFrdZEYOtEo4hIX6LaalYPkXYYJyV0MAkH8gjDRK//ILttOIXE1d5o6IOTxVzhp5wQS/4DLDDs+hoxdJLgxAzRigFmD5b673vDtJbVAJXRO3rd4ItnWQ3o0nvIA==;5:XrISJeVdR0x0G8faSeHmuBaTbhu4Dhq3+8uVoUq3NGcBtqEmMVZMmapjbmob7eKSThs80c0jM9ncucSbYcAM7NK5mt80HV6g41umWauFZwQWZf5oQz1GHY94aZY0jNrADCgSjvxWppqVSjoxfE+AqBBoDh9ewHflpeqyUCj4KxY=;24:iKvlcACdYE0ncjLh9GxOzEUNU1bIfDL9fJUXwgbhz7MrAaAIoJvxxlNfIRcSYftHqZFdBYqCq+pqAzM5WcTumm8wTCm1CQsawNcLwa/7Qv0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:btr08nLHHDBGa3Nfog2++ZjhvtNwMFlIj7+lDa2CvZDnBt1Yic8Y7+ld3EqHOQ+fELOIFRfT+MOdgCw+MK3w+st7Wj5g9y7ExJnsRUQUSRCyXX3yE04HIN0N2r0VKH9B8UTr9SVzYZPs24CtOUqDFQyUP2d1sSIFjIYRqZudO4oAvAAiGdyHvDdoo9cswkz/NXXhizoS0EuNlW4wNYhDNPne3onYnbCtFL2xYgL8Iw4LXRFK5Ur7FJ8OC87R8t64;20:g7GAJ18aJhB5BClMF38Y6asZRlunb2iQK1oRYiI2VYYy19eOuzle1kjqmXTnR3XknWkyza+5lzmhGOgK2ksqc36B94+JVPgTTh13iPfzE9LkcH9jqFkz1q5f1w7jgLVbJFxlD0fnouAqm7AR40eofJRHiLqOaw9EjWcniqEBGwY=
X-MS-Office365-Filtering-Correlation-Id: 82ad53a6-a3d1-4e74-2116-08d5c4773aad
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 08:44:29.0256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ad53a6-a3d1-4e74-2116-08d5c4773aad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2018 20:15, Vladimir Davydov wrote:
> Hello Kirill,
> 
> The whole patch set looks good to me now.
> 
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Thanks for the review, Vova!

Kirill

> 
> On Tue, May 22, 2018 at 01:07:10PM +0300, Kirill Tkhai wrote:
>> Hi,
>>
>> this patches solves the problem with slow shrink_slab() occuring
>> on the machines having many shrinkers and memory cgroups (i.e.,
>> with many containers). The problem is complexity of shrink_slab()
>> is O(n^2) and it grows too fast with the growth of containers
>> numbers.
>>
>> Let we have 200 containers, and every container has 10 mounts
>> and 10 cgroups. All container tasks are isolated, and they don't
>> touch foreign containers mounts.
>>
>> In case of global reclaim, a task has to iterate all over the memcgs
>> and to call all the memcg-aware shrinkers for all of them. This means,
>> the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
>> and since there are 2000 memcgs, the total calls of do_shrink_slab()
>> are 2000 * 2000 = 4000000.
>>
>> 4 million calls are not a number operations, which can takes 1 cpu cycle.
>> E.g., super_cache_count() accesses at least two lists, and makes arifmetical
>> calculations. Even, if there are no charged objects, we do these calculations,
>> and replaces cpu caches by read memory. I observed nodes spending almost 100%
>> time in kernel, in case of intensive writing and global reclaim. The writer
>> consumes pages fast, but it's need to shrink_slab() before the reclaimer
>> reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
>> there is no writing, the iterations just waste the time, and slows reclaim down.
>>
>> Let's see the small test below:
>>
>> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
>> $mkdir /sys/fs/cgroup/memory/ct
>> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
>> $for i in `seq 0 4000`;
>> 	do mkdir /sys/fs/cgroup/memory/ct/$i;
>> 	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
>> 	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
>> done
>>
>> Then, let's see drop caches time (5 sequential calls):
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> 0.00user 13.78system 0:13.78elapsed 99%CPU
>> 0.00user 5.59system 0:05.60elapsed 99%CPU
>> 0.00user 5.48system 0:05.48elapsed 99%CPU
>> 0.00user 8.35system 0:08.35elapsed 99%CPU
>> 0.00user 8.34system 0:08.35elapsed 99%CPU
>>
>>
>> Last four calls don't actually shrink something. So, the iterations
>> over slab shrinkers take 5.48 seconds. Not so good for scalability.
>>
>> The patchset solves the problem by making shrink_slab() of O(n)
>> complexity. There are following functional actions:
>>
>> 1)Assign id to every registered memcg-aware shrinker.
>> 2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
>>   and set a shrinker-related bit after the first element
>>   is added to lru list (also, when removed child memcg
>>   elements are reparanted).
>> 3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
>>   and call a shrinker if its bit is set in memcg's shrinker
>>   bitmap.
>>   (Also, there is a functionality to clear the bit, after
>>   last element is shrinked).
>>
>> This gives signify performance increase. The result after patchset is applied:
>>
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> 0.00user 1.10system 0:01.10elapsed 99%CPU
>> 0.00user 0.00system 0:00.01elapsed 64%CPU
>> 0.00user 0.01system 0:00.01elapsed 82%CPU
>> 0.00user 0.00system 0:00.01elapsed 64%CPU
>> 0.00user 0.01system 0:00.01elapsed 82%CPU
>>
>> The results show the performance increases at least in 548 times.
>>
>> So, the patchset makes shrink_slab() of less complexity and improves
>> the performance in such types of load I pointed. This will give a profit
>> in case of !global reclaim case, since there also will be less
>> do_shrink_slab() calls.
>>
>> This patchset is made against linux-next.git tree.
>>
>> v7: Refactorings and readability improvements.
>>
>> v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
>>     Use different functions for allocation and expanding map.
>>     Use new memcg_shrinker_map_size variable in memcontrol.c.
>>     Refactorings.
>>
>> v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB
>>
>> v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups
>>
>> v3: Many changes requested in commentaries to v2:
>>
>> 1)rebase on prealloc_shrinker() code base
>> 2)root_mem_cgroup is made out of memcg maps
>> 3)rwsem replaced with shrinkers_nr_max_mutex
>> 4)changes around assignment of shrinker id to list lru
>> 5)everything renamed
>>
>> v2: Many changes requested in commentaries to v1:
>>
>> 1)the code mostly moved to mm/memcontrol.c;
>> 2)using IDR instead of array of shrinkers;
>> 3)added a possibility to assign list_lru shrinker id
>>   at the time of shrinker registering;
>> 4)reorginized locking and renamed functions and variables.
>>
>> ---
>>
>> Kirill Tkhai (16):
>>       list_lru: Combine code under the same define
>>       mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
>>       mm: Assign id to every memcg-aware shrinker
>>       memcg: Move up for_each_mem_cgroup{,_tree} defines
>>       mm: Assign memcg-aware shrinkers bitmap to memcg
>>       mm: Refactoring in workingset_init()
>>       fs: Refactoring in alloc_super()
>>       fs: Propagate shrinker::id to list_lru
>>       list_lru: Add memcg argument to list_lru_from_kmem()
>>       list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
>>       list_lru: Pass lru argument to memcg_drain_list_lru_node()
>>       mm: Export mem_cgroup_is_root()
>>       mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
>>       mm: Iterate only over charged shrinkers during memcg shrink_slab()
>>       mm: Add SHRINK_EMPTY shrinker methods return value
>>       mm: Clear shrinker bit if there are no objects related to memcg
>>
>> Vladimir Davydov (1):
>>       mm: Generalize shrink_slab() calls in shrink_node()
>>
>>
>>  fs/super.c                 |   11 ++
>>  include/linux/list_lru.h   |   18 ++--
>>  include/linux/memcontrol.h |   46 +++++++++-
>>  include/linux/sched.h      |    2 
>>  include/linux/shrinker.h   |   11 ++
>>  include/linux/slab.h       |    2 
>>  init/Kconfig               |    5 +
>>  mm/list_lru.c              |   90 ++++++++++++++-----
>>  mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
>>  mm/slab.h                  |    6 +
>>  mm/slab_common.c           |    8 +-
>>  mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
>>  mm/workingset.c            |   11 ++
>>  13 files changed, 478 insertions(+), 109 deletions(-)
>>
>> --
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
