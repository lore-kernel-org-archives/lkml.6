Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEDStt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:49:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeEDStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:49:47 -0400
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
 <20180425174909.GB4043@hirez.programming.kicks-ass.net>
 <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
 <20180501180348.GI12217@hirez.programming.kicks-ass.net>
 <1ea04602-041a-5b90-eba9-c20c7e98c92e@oracle.com>
Message-ID: <403e8277-65b9-e51e-ec67-03c92eadc9ad@oracle.com>
Date: Fri, 4 May 2018 11:51:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1ea04602-041a-5b90-eba9-c20c7e98c92e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8883 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/02/2018 02:58 PM, Subhra Mazumdar wrote:
>
>
> On 05/01/2018 11:03 AM, Peter Zijlstra wrote:
>> On Mon, Apr 30, 2018 at 04:38:42PM -0700, Subhra Mazumdar wrote:
>>> I also noticed a possible bug later in the merge code. Shouldn't it be:
>>>
>>> if (busy < best_busy) {
>>>          best_busy = busy;
>>>          best_cpu = first_idle;
>>> }
>> Uhh, quite. I did say it was completely untested, but yes.. /me dons the
>> brown paper bag.
> I re-ran the test after fixing that bug but still get similar regressions
> for hackbench, while similar improvements on Uperf. I didn't re-run the
> Oracle DB tests but my guess is it will show similar improvement.
>
> merge:
>
> Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
> (lower is better):
> groups  baseline       %stdev  patch %stdev
> 1       0.5742         21.13   0.5131 (10.64%) 4.11
> 2       0.5776         7.87    0.5387 (6.73%) 2.39
> 4       0.9578         1.12    1.0549 (-10.14%) 0.85
> 8       1.7018         1.35    1.8516 (-8.8%) 1.56
> 16      2.9955         1.36    3.2466 (-8.38%) 0.42
> 32      5.4354         0.59    5.7738 (-6.23%) 0.38
>
> Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
> message size = 8k (higher is better):
> threads baseline        %stdev  patch %stdev
> 8       49.47           0.35    51.1 (3.29%) 0.13
> 16      95.28           0.77    98.45 (3.33%) 0.61
> 32      156.77          1.17    170.97 (9.06%) 5.62
> 48      193.24          0.22    245.89 (27.25%) 7.26
> 64      216.21          9.33    316.43 (46.35%) 0.37
> 128     379.62          10.29   337.85 (-11%) 3.68
>
> I tried using the next_cpu technique with the merge but didn't help. I am
> open to suggestions.
>
> merge + next_cpu:
>
> Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
> (lower is better):
> groups  baseline       %stdev  patch %stdev
> 1       0.5742         21.13   0.5107 (11.06%) 6.35
> 2       0.5776         7.87    0.5917 (-2.44%) 11.16
> 4       0.9578         1.12    1.0761 (-12.35%) 1.1
> 8       1.7018         1.35    1.8748 (-10.17%) 0.8
> 16      2.9955         1.36    3.2419 (-8.23%) 0.43
> 32      5.4354         0.59    5.6958 (-4.79%) 0.58
>
> Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
> message size = 8k (higher is better):
> threads baseline        %stdev  patch %stdev
> 8       49.47           0.35    51.65 (4.41%) 0.26
> 16      95.28           0.77    99.8 (4.75%) 1.1
> 32      156.77          1.17    168.37 (7.4%) 0.6
> 48      193.24          0.22    228.8 (18.4%) 1.75
> 64      216.21          9.33    287.11 (32.79%) 10.82
> 128     379.62          10.29   346.22 (-8.8%) 4.7
>
> Finally there was earlier suggestion by Peter in select_task_rq_fair to
> transpose the cpu offset that I had tried earlier but also regressed on
> hackbench. Just wanted to mention that so we have closure on that.
>
> transpose cpu offset in select_task_rq_fair:
>
> Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
> (lower is better):
> groups  baseline       %stdev  patch %stdev
> 1       0.5742         21.13   0.5251 (8.55%) 2.57
> 2       0.5776         7.87    0.5471 (5.28%) 11
> 4       0.9578         1.12    1.0148 (-5.95%) 1.97
> 8       1.7018         1.35    1.798 (-5.65%) 0.97
> 16      2.9955         1.36    3.088 (-3.09%) 2.7
> 32      5.4354         0.59    5.2815 (2.8%) 1.26
I tried a few other combinations including setting nr=2 exactly with the
folding of select_idle_cpu and select_idle_core but still get regressions
with hackbench. Also tried adding select_idle_smt (just for the sake of it
since my patch retained it) but still see regressions with hackbench. In
all these tests Uperf and Oracle DB tests gave similar improvements as my
orignal patch. This kind of indicates that sequential cpu ids hopping cores
(x86) being important for hackbench. In that case can we consciously hop
core for all archs and search limited nr cpus? We can get the diff of
cpu id of target cpu and first cpu in the smt core and apply the diff to
the cpu id of each smt core to get the cpu we want to check. But we need a
O(1) way of zeroing out all the cpus of smt core from the parent mask.
This will work in both kind of enumeration, whether contiguous or
interleaved. Thoughts?
