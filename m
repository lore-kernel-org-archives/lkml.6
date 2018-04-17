Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49EOpXWGmRsQnOXpE7Vj6wYPddl29mJG4619u3dEiiLXGrVivAZXWdIz97YfX5w90LZwH/3
ARC-Seal: i=1; a=rsa-sha256; t=1523980390; cv=none;
        d=google.com; s=arc-20160816;
        b=vhdrDUx5rnQKk7g3k7139SGVNR/X5dMej6TOhtLfD10SqDsHWUqVQ2Ko+lxINpw386
         ZA/nLMHjAjCutEsoq4cRR0btln0gr1/p/LrTqs3OtouQSRex26P34gb4ufwWhj4I1dXQ
         ni+/7AYh1jndg9BnhPQ3Yk90Uck1tEAlouWEDyeKEGzaGUFwf75yUONJgbSgVXCErhqo
         jMBm7Hi3/Ccw8+4NvNSO+/p9i0U4JlVT0Iko+ogXN1iRcUI7DyMION3T6u4TxqtIFCAH
         mtaJNeYxPfzGZ4ueiX8BtnqWckf1/S//rMqDAbBUq51Xo8q+AAuGgZe6by6Wprl3c4Br
         GBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:dkim-signature:arc-authentication-results;
        bh=rZzcLxeGEsxHZh8yN1df3EyPLDFmprqgUg1JREeh9X4=;
        b=NScGJnGVswputTCCuVOQfux+w/gU/XZrBAFO204EDSTU4v3piKOjs4S7HeaQGcx81U
         FKCuoeb/+FbCOY6LTx8mesbABthgX7M8W9Q0voKEXuSjjEc/rrAYXrOZFOb+/P0NCxLd
         iiVhYEjGc8P5zWNKK6TLFn+1i+bnFRPBUP87J9nf67yziZ64Ya6mQZa19NqjFEqV5GN+
         3aJ3zRaj4R4S4fbC/i1cRmXsg9tgusv7N7t0qa6pHjzDGx7I+MNrTseNr1ZKA20+O2Kq
         GtU74t9+0EF6tBdJYP/8dbyrXCRA3OZ0vPDbhr7pndEDf8vBTZLmXpFyJVNjdyokBTl0
         kOMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MKIoQqAN;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MKIoQqAN;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.1.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 00/12] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:52:53 +0300
Message-ID: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:7:67::23) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:wyEGNE2IR3BjKzM8on6dbNSqp7aqyt6R/7YKvAOcKqgtkTwLcYFdEJSbGZg2tHuWJzi5nSVnkiT7vzet/Nie8oI1zLm/N8jtsqzlvQKP0TuIJizAsGosDmtlwMK/eUohrkic8sjLMTKHzjQVyLYTo0XhT6Ow9yS8PBbb/3T2ooHduTpOFv0OGxQogL/5r+9ijGa2Ik9FPJAcSjknQk1f+9K3cjnVUyCEV0YSntp+0Od/degXvlVO9U9qWxbriBA1;25:thGIMgCi1Rtlxuq8CKjx8ZmtNe+h6ctL/yUWod6kLStWrQ4H0RgMJiqxVUSJUE5fpweSffSQXk+eoEB3fzTlL31L19ZJk/gvnb/8hsgE1k4Xwg6QbQkWzuHs40IYMt1HD6eRiMRO55o6lX/5jRrPneKVw75sgDJboZZjpeTz2an1CcEPH2Rf70ZwOpFnTAE438iVCH8B+Q0pQ7rOrekCBzfvQDtQPljAA1PZ4D1O1TaC7WrzTPzHRYHkzWoQbZ8+WkVaLZjVYrZl+cl5/xdoqFlqJRsuXSBjLW1jdghhNOUTGo+vZuMugw3YZkYmXdzWLDbbis2JzytUnFFbJkYSLA==;31:KFpRtLYwlHaiGQtgkn7/OuNUyvwolSejlAut9DyNNghDaz7o19mYDzLCropeUy0kUVNJMRktwccBUevxX7eaXG1Md6fm+eq3Vm0xr2jE9Ud1uX9UlCzsOYa07qehvWd2QlKVHUszQr6qWLAf7U+iwpegx0ZSq7qlHF09V3l+gZuBqYnhM68Jbm3vFsIq7jgB7c4kob1FD1G8a38cb6AKInzu0fsLJ98hJEYdj/cyc+4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:3sLuXZv7HZY8v4FqSqJflTGP7SltNHGWDhFgGkd9/BLQKXraifLmjjSGdBa3L3ReNDalLmeiyO/THnnAdqMwS5gXNt5r0Vm+QhdsKSCXdjLzy6Al6mU2etMwDiHkjJTMyFAqb0qiJzLSbF/H0KPwlOjoqxTUl8BT/2QwT1tmZmy667dl3DJyAv+JYo7BHfknFQ2KEG7m/0rVISNORLaYbBt/Z6mNyFPd1QCJrGtH1P/hWkyt7CI++pZpjZJVaqcSFZ62mo/x617P+d30fNFVg9xF0RLnS2YhIfOz2NFu7ZQJqf6VfjpQv1O0q1ZCpmdkmgkm6G+bBzQrpg3X5+QXVochLzdOLnGn4xv2vYrsTfvDZ2LrLWdmGwBJMKp41f/femT9O5GRrA9eh29S1YtwFQ/c7oGGufdDWn5Obj2WGSOyiUlbIn+jdua62nhlI3E7+R1aZTA4pKLmJqBKJROR7BA9+kCu/1E/TqHtWNxCcHwFzLJ2MLLQxiyXasduH1eR;4:su7ccJht8/Dlyqb82CfcEByT9/hFf5y0/dFdWWlKkMfmcaqIWTRClNcfS/HNHhaJ1ZXqaJLLbNKq6BZuHum68Zyp4sBQhugfVpAMcm1vwm607vkbt9/sojMrMnrwED7SGCsch9QyFSIwAPmVDe2+tSwGfzvle17POc8/ZJlE7TTZKIZAoS1LUU5KZ9RhhWs3qNBeNAACED7M7zRna/xRpdk4rajcLJF+EeQFVHUDE3xZN4+PFUII2dIL4yxWxX08qSDP4xJXsInn9G2QnxaKrVN5dDoasMjjhB+45A66a9dVZ1DkIC+RNCboTG6sZ30S
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339F3315E179A0EDF416E64CDB70@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(396003)(39380400002)(366004)(376002)(346002)(189003)(199004)(81156014)(81166006)(5660300001)(61506002)(105586002)(486006)(66066001)(8936002)(106356001)(58126008)(39060400002)(68736007)(59450400001)(23676004)(52116002)(6506007)(2486003)(7696005)(55236004)(33896004)(8676002)(86362001)(386003)(47776003)(25786009)(2906002)(26005)(55016002)(956004)(7416002)(476003)(230700001)(97736004)(50466002)(3846002)(6116002)(6636002)(6666003)(186003)(305945005)(7736002)(53936002)(103116003)(478600001)(16526019)(9686003)(316002)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6VU5zc0dPdmtMMkdGMXptY0paV2dJbTMr?=
 =?utf-8?B?RFN4UjR5aDh4bWxvbFJEcSt1UjNOTWhTdUtaU0pqVS9tZ2tVYzJtd1lXaDlu?=
 =?utf-8?B?VWFOZERWeTY4N2txdFA3R3BVbnEyOXFXYVU3cmdGOWdjYy9qUTkzekE4WDQ0?=
 =?utf-8?B?QzJTL0hwK29uazU4V1Q2ZWZBOE5NSkZlcmlxUXhhc0drc0UyNFRrU2lsOVRD?=
 =?utf-8?B?L0xSZHJSM2lxM1FOeC9aTklHUFFsVU1JOEEyZEpqQ2haM29QUkI1ZHZ0MUVW?=
 =?utf-8?B?VzRkZHgwdERBYTFYc2xvU0ZWbThRbUt2STl5T3ZiU0JoWnk2Z0ZZRW5ISTFQ?=
 =?utf-8?B?YWkrMkdVMHlvNUc5SkJvTVhkaHdJUHNnQVJnc0M4Z2lGZzBtQ1VIRmJFSUlu?=
 =?utf-8?B?Wm51U0UzaTNyUTMyZzZBMmw3SS80cXJnOE81OFV5VTFYZTVQNFUxQjVZUGVo?=
 =?utf-8?B?ZEN5dUV2MUpzaFNhM0p3RnNqVVVia0tBVnlxdjNKaVhUMHNkRW5JcC9KYzBy?=
 =?utf-8?B?VWFxY1dxaVJmcVVOZ3MzVUt2dG1mWGhSN3FuR3QrU1p3M1k3bzZYeS9nZmQy?=
 =?utf-8?B?T2E0L2MyaGQwUlVVdkpnUU9PWGE2amN2bnAxcDdzeVNxdHd0WnlZZXZtekRo?=
 =?utf-8?B?SlNlMUJwQ290Yjc3VTAydGJ4NUdoRDZJc21wSmo0Z1Rra1VOcWlXQnNaU3Bq?=
 =?utf-8?B?SUFqK3BvekFsdWZCNk54ZEFhQVpCNVJyaDBBbmNjbUdpN2o1Qk9zTWtyL3Rx?=
 =?utf-8?B?NFlwU2JJdUx5RUtyL1FvdlRGVW1PMlllMU5IbnZZVFFtYkg5c21nYkdZejVj?=
 =?utf-8?B?Nm9FOVhGZWFHVXFVbWtIaWZqbW5JTXd5cWc5dGRweUhZNVNnREdrclNqNndG?=
 =?utf-8?B?aFdaSXBIMVFXcU9PeDVIMWNJZ1dTc2s4TDFjQmhINERRTzFNRlIwelo2SUxm?=
 =?utf-8?B?R3FIUkdvNXNYbjVsQm95YjhkaU1oSGtOOWw5eXkxcVErSk5DK1FORWhvUVZx?=
 =?utf-8?B?UVIwVTRwVEtmUS9xZDJRUzVTYUNTWGIya3J6cndTa0VBQ0c3djhFbjQ4Nmt4?=
 =?utf-8?B?QVcra2ZyY0cyajhjanpaU2lUSEtOV2V5eWlLcUhOd2FUS0FZV1BheVBIRGhV?=
 =?utf-8?B?VjBqWUhiZmVkS0FuM1l6eXFoZkgyR0c3alAxZWZwRkVMb3FSeWtERG1ZMEJq?=
 =?utf-8?B?WnltYW40TjNDOTRIdDc2ZldGSjVROHhrSkZiVGFZNUt5L2xQNnFqYysraFhD?=
 =?utf-8?B?djVQUDRrWEhrZGVsKzlMQW9QN3FGUFc5L3grQUNjN3lmMEhyN011Mml4d3Yx?=
 =?utf-8?B?dU9lOURoazczQ3ErUE5ZZjFqRSs0RlhzTW1LUGJCYno5SDl5ZjdTYlBScjVz?=
 =?utf-8?B?VUZFb2p1WmJTSTBWYytISEt6SUVKVE9vWER4S2taM1RMWVNaSGdQTS91aHAv?=
 =?utf-8?B?Y0c3bitFTDZUdmRqRDVxZjlCaGhSM1hQWllObDIvT3RRQnNlY2lWeXR6S1la?=
 =?utf-8?B?UXh5KzlUbUxNLzNtYVhKemxSSG1xWUYxanBZMTQ4WkptUDZldUE0M050aEJF?=
 =?utf-8?B?ZVI3Zlduc2RCUm1EKzl2SjltejJKWDV2RlNnelpmWkJjTWNlenZMNFIyNEhy?=
 =?utf-8?B?U3o3MWpaa3VXM1hnSUVnZnE4R3RGQ1lCRS9ZVTFVdGpjVjJiWnRxMFlvUlhN?=
 =?utf-8?B?ckw0aFhudGlqczNNZGdGNVM2c2toWm9aeWtDeVBVTkl5WVhnZkRNUTA2V09j?=
 =?utf-8?Q?ZHmeWDjQsN1XG/ee0iH9NBw54zNt0/u4I0WUlIE=3D?=
X-Microsoft-Antispam-Message-Info: 7BztE75RBoxBa5ftpPMAbhF744mLZFvblWDeyuuVrE26N+tvSCk5EjU2Dbl0KQHl9WWw69D/pUB3DtjXoeXx3np6HK+ODIwfFpy8dHReH4nIY0db19gT3kFc6Q5zxGt50s/AriXe1LCgvrO3EIkLxemOLD414GIPIuoZrzwNGmAE6FPAUrkpNAJzCduDa0+y
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:ye1pNiJpjDv7DOVXOzRM5j9OJ9Qgjw7byrZVOMni0ztTLvUgRjp/r7TkVdfpN6aOKcQPLhc1h2vtjziYNcD3iO3tcCM+1gHjOkxzwo6lL5DcxgVVPWxB48eS2vZ8kA2Q69d9jqZyErJnGlYXEBtrH7c8Y19DNjtTMGddoNggl3Zo2S6P0jcAN528rQ7OYvHyRLQ9svyDKZ1RJ9d4Yf0/+oGFPHjGBaZ82RrYOKgYh3cuvpyul5p0WR2fQuEZU4tePtHO3s1uywUA4ukrPv2h6tWUQAv3m/R3Rz6OjxQJX8suhCHjs/VFLFAZp7w1Ho3m+t+6NNbPCwWBVXa7enCaboD2G2j3if97Of0/OAuekwWwelQRcqlOeIj1lRsz+pItUr16Czo3QyK389vcSejSezRElZkqT+WdIkpIrkcxUCDMsqZTmDQDTSTYrCg6t6vP6Gp5FAYVQJT8wtVgDDhA/A==;5:ouBv+bDnH7BJ22gcY80Oa1r0dRgy2eI1FogXlyoiznJz4cMKq57oSr2XurTZ9El3ymgdv7Oxbzk7Md38prv9FmlrzDz5+1QkN9d0ijLAG44cb6IS7koq1JT3bnimHVA1crQDqWomaWnC4hkDw0qi0H9+UtmW8KoFHCQqNH5vwuE=;24:yyv2M3ZSRhhTz7Q/7AwY4PcrimhN3USVywv5RelQpOB35Qs8wVpgooK0/bGJsgpbeX/DtZ1z05Y4ENIqB8Ok8drET62DwYuhizHFwVhMf/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:E3l08JavF4ZOT8ofTvm54bfQmUkzAjkYzshGfUHj+7lVlDeCg9qn4rxRd0/RephX+xWWSt9ync7WjyfUyZqhYcCpTUsrunJyg941WkWGNFh4V2zKW+tS0BGDnV3zk6BWdHHbc8O/amZF/m/5V/9/NuHn+vMfuGzJRqTEpwUUKcGFRKTCaiFMvIQ4R6o3weon3czNWS3m/Y/GPYD9JJ4AhfALn2dwOAcZ4J+MG9NmuO1IyXb/QVsjxtDZOyaGSe7u;20:C4L1EbSmpbuNY+9yb/n44Dm0LsQBSTaYkE+t5P1Jrw+Elf8zQm3vtoK0PL8cZVBzSg9jfWbhxoRQe/sZlQcFpBzGv6bykPz+Ba0bWEyW2PEIsp5oNv6adS4vnDsWKGL9Xry3J6dxGo4HlL41OgDgu2LBeHYVRwZ28Nm25nBcYuQ=
X-MS-Office365-Filtering-Correlation-Id: 4a804fd8-f8cc-4ed0-93a3-08d5a47b4df6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:53:03.0137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a804fd8-f8cc-4ed0-93a3-08d5a47b4df6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009262059172512?=
X-GMAIL-MSGID: =?utf-8?q?1598009262059172512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

this patches solves the problem with slow shrink_slab() occuring
on the machines having many shrinkers and memory cgroups (i.e.,
with many containers). The problem is complexity of shrink_slab()
is O(n^2) and it grows too fast with the growth of containers
numbers.

Let we have 200 containers, and every container has 10 mounts
and 10 cgroups. All container tasks are isolated, and they don't
touch foreign containers mounts.

In case of global reclaim, a task has to iterate all over the memcgs
and to call all the memcg-aware shrinkers for all of them. This means,
the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
and since there are 2000 memcgs, the total calls of do_shrink_slab()
are 2000 * 2000 = 4000000.

4 million calls are not a number operations, which can takes 1 cpu cycle.
E.g., super_cache_count() accesses at least two lists, and makes arifmetical
calculations. Even, if there are no charged objects, we do these calculations,
and replaces cpu caches by read memory. I observed nodes spending almost 100%
time in kernel, in case of intensive writing and global reclaim. The writer
consumes pages fast, but it's need to shrink_slab() before the reclaimer
reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
there is no writing, the iterations just waste the time, and slows reclaim down.

Let's see the small test below:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
$for i in `seq 0 4000`;
	do mkdir /sys/fs/cgroup/memory/ct/$i;
	echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
	mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
done

Then, let's see drop caches time (4 sequential calls):
$time echo 3 > /proc/sys/vm/drop_caches

0.00user 8.99system 0:08.99elapsed 99%CPU
0.00user 5.97system 0:05.97elapsed 100%CPU
0.00user 5.97system 0:05.97elapsed 100%CPU
0.00user 5.85system 0:05.85elapsed 100%CPU

Last three calls don't actually shrink something. So, the iterations
over slab shrinkers take 5.85 seconds. Not so good for scalability.

The patchset solves the problem by making shrink_slab() of O(n)
complexity. There are following functional actions:

1)Assign id to every registered memcg-aware shrinker.
2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
  and set a shrinker-related bit after the first element
  is added to lru list (also, when removed child memcg
  elements are reparanted).
3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
  and call a shrinker if its bit is set in memcg's shrinker
  bitmap.
  (Also, there is a functionality to clear the bit, after
  last element is shrinked).

This gives signify performance increase. The result after patchset is applied:

$time echo 3 > /proc/sys/vm/drop_caches
0.00user 1.11system 0:01.12elapsed 99%CPU
0.00user 0.00system 0:00.00elapsed 100%CPU
0.00user 0.00system 0:00.00elapsed 100%CPU
0.00user 0.00system 0:00.00elapsed 100%CPU

Even if we round 0:00.00 up to 0:00.01, the results shows
the performance increases at least in 585 times.

So, the patchset makes shrink_slab() of less complexity and improves
the performance in such types of load I pointed. This will give a profit
in case of !global reclaim case, since there also will be less
do_shrink_slab() calls.

This patchset is made against linux-next.git tree.

v2: Many changes requested in commentaries to v1:

1)the code mostly moved to mm/memcontrol.c;
2)using IDR instead of array of shrinkers;
3)added a possibility to assign list_lru shrinker id
  at the time of shrinker registering;
4)reorginized locking and renamed functions and variables.
---

Kirill Tkhai (12):
      mm: Assign id to every memcg-aware shrinker
      memcg: Refactoring in mem_cgroup_alloc()
      memcg: Refactoring in alloc_mem_cgroup_per_node_info()
      mm: Assign memcg-aware shrinkers bitmap to memcg
      fs: Propagate shrinker::id to list_lru
      list_lru: Add memcg argument to list_lru_from_kmem()
      list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
      list_lru: Pass lru argument to memcg_drain_list_lru_node()
      mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
      mm: Iterate only over charged shrinkers during memcg shrink_slab()
      mm: Add SHRINK_EMPTY shrinker methods return value
      mm: Clear shrinker bit if there are no objects related to memcg


 fs/super.c                 |    7 +-
 include/linux/list_lru.h   |    3 -
 include/linux/memcontrol.h |   30 +++++++
 include/linux/shrinker.h   |   17 +++-
 mm/list_lru.c              |   64 +++++++++++----
 mm/memcontrol.c            |  160 ++++++++++++++++++++++++++++++++----
 mm/vmscan.c                |  194 +++++++++++++++++++++++++++++++++++++++-----
 mm/workingset.c            |    6 +
 8 files changed, 422 insertions(+), 59 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
