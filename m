Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeE3WGm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:06:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeE3WGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:06:41 -0400
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
 <20180425174909.GB4043@hirez.programming.kicks-ass.net>
 <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
 <20180501180348.GI12217@hirez.programming.kicks-ass.net>
 <1ea04602-041a-5b90-eba9-c20c7e98c92e@oracle.com>
 <20180529213600.GC12180@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <b2157df2-53d4-79e1-d307-7634fbc844d6@oracle.com>
Date: Wed, 30 May 2018 15:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529213600.GC12180@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 02:36 PM, Peter Zijlstra wrote:
> On Wed, May 02, 2018 at 02:58:42PM -0700, Subhra Mazumdar wrote:
>> I re-ran the test after fixing that bug but still get similar regressions
>> for hackbench
>> Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
>> (lower is better):
>> groups  baseline       %stdev  patch %stdev
>> 1       0.5742         21.13   0.5131 (10.64%) 4.11
>> 2       0.5776         7.87    0.5387 (6.73%) 2.39
>> 4       0.9578         1.12    1.0549 (-10.14%) 0.85
>> 8       1.7018         1.35    1.8516 (-8.8%) 1.56
>> 16      2.9955         1.36    3.2466 (-8.38%) 0.42
>> 32      5.4354         0.59    5.7738 (-6.23%) 0.38
> On my IVB-EP (2 socket, 10 core/socket, 2 threads/core):
>
> bench:
>
>    perf stat --null --repeat 10 -- perf bench sched messaging -g $i -t -l 10000 2>&1 | grep "seconds time elapsed"
>
> config + results:
>
> ORIG (SIS_PROP, shift=9)
>
> 1:        0.557325175 seconds time elapsed                                          ( +-  0.83% )
> 2:        0.620646551 seconds time elapsed                                          ( +-  1.46% )
> 5:        2.313514786 seconds time elapsed                                          ( +-  2.11% )
> 10:        3.796233615 seconds time elapsed                                          ( +-  1.57% )
> 20:        6.319403172 seconds time elapsed                                          ( +-  1.61% )
> 40:        9.313219134 seconds time elapsed                                          ( +-  1.03% )
>
> PROP+AGE+ONCE shift=0
>
> 1:        0.559497993 seconds time elapsed                                          ( +-  0.55% )
> 2:        0.631549599 seconds time elapsed                                          ( +-  1.73% )
> 5:        2.195464815 seconds time elapsed                                          ( +-  1.77% )
> 10:        3.703455811 seconds time elapsed                                          ( +-  1.30% )
> 20:        6.440869566 seconds time elapsed                                          ( +-  1.23% )
> 40:        9.537849253 seconds time elapsed                                          ( +-  2.00% )
>
> FOLD+AGE+ONCE+PONIES shift=0
>
> 1:        0.558893325 seconds time elapsed                                          ( +-  0.98% )
> 2:        0.617426276 seconds time elapsed                                          ( +-  1.07% )
> 5:        2.342727231 seconds time elapsed                                          ( +-  1.34% )
> 10:        3.850449091 seconds time elapsed                                          ( +-  1.07% )
> 20:        6.622412262 seconds time elapsed                                          ( +-  0.85% )
> 40:        9.487138039 seconds time elapsed                                          ( +-  2.88% )
>
> FOLD+AGE+ONCE+PONIES+PONIES2 shift=0
>
> 10:       3.695294317 seconds time elapsed                                          ( +-  1.21% )
>
>
> Which seems to not hurt anymore.. can you confirm?
>
> Also, I didn't run anything other than hackbench on it so far.
>
> (sorry, the code is a right mess, it's what I ended up with after a day
> of poking with no cleanups)
>
I tested with FOLD+AGE+ONCE+PONIES+PONIES2 shift=0 vs baseline but see some
regression for hackbench and uperf:

hackbench       BL      stdev%  test    stdev% %gain
1(40 tasks)     0.5816  8.94    0.5607  2.89 3.593535
2(80 tasks)     0.6428  10.64   0.5984  3.38 6.907280
4(160 tasks)    1.0152  1.99    1.0036  2.03 1.142631
8(320 tasks)    1.8128  1.40    1.7931  0.97 1.086716
16(640 tasks)   3.1666  0.80    3.2332  0.48 -2.103207
32(1280 tasks)  5.6084  0.83    5.8489  0.56 -4.288210

Uperf            BL      stdev%  test    stdev% %gain
8 threads       45.36   0.43    45.16   0.49 -0.433536
16 threads      87.81   0.82    88.6    0.38 0.899669
32 threads      151.18  0.01    149.98  0.04 -0.795925
48 threads      190.19  0.21    184.77  0.23 -2.849681
64 threads      190.42  0.35    183.78  0.08 -3.485217
128 threads     323.85  0.27    266.32  0.68 -17.766089

sysbench        BL              stdev%  test     stdev% %gain
8 threads       2095.44         1.82    2102.63  0.29 0.343006
16 threads      4218.44         0.06    4179.82  0.49 -0.915413
32 threads      7531.36         0.48    7744.72  0.13 2.832912
48 threads      10206.42        0.20    10144.65 0.19 -0.605163
64 threads      12053.72        0.09    11784.38 0.32 -2.234547
128 threads     14810.33        0.04    14741.78 0.16 -0.462867

I have a patch which is much smaller but seems to work well so far for both
x86 and SPARC across benchmarks I have run so far. It keeps the idle cpu
search between 1 core and 2 core amount of cpus and also puts a new
sched feature of doing idle core search or not. It can be on by default but
for workloads (like Oracle DB on x86) we can turn it off. I plan to send
that after some more testing.
