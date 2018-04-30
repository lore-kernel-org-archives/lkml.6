Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755512AbeD3Xg2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:36:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbeD3Xg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:36:26 -0400
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
 <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
 <20180425174909.GB4043@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e2011797-382b-0ac9-79eb-e17109ef4c96@oracle.com>
Date: Mon, 30 Apr 2018 16:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425174909.GB4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 10:49 AM, Peter Zijlstra wrote:
> On Tue, Apr 24, 2018 at 02:45:50PM -0700, Subhra Mazumdar wrote:
>> So what you said makes sense in theory but is not borne out by real
>> world results. This indicates that threads of these benchmarks care more
>> about running immediately on any idle cpu rather than spending time to find
>> fully idle core to run on.
> But you only ran on Intel which emunerates siblings far apart in the
> cpuid space. Which is not something we should rely on.
>
>>> So by only doing a linear scan on CPU number you will actually fill
>>> cores instead of equally spreading across cores. Worse still, by
>>> limiting the scan to _4_ you only barely even get onto a next core for
>>> SMT4 hardware, never mind SMT8.
>> Again this doesn't matter for the benchmarks I ran. Most are happy to make
>> the tradeoff on x86 (SMT2). Limiting the scan is mitigated by the fact that
>> the scan window is rotated over all cpus, so idle cpus will be found soon.
> You've not been reading well. The Intel machine you tested this on most
> likely doesn't suffer that problem because of the way it happens to
> iterate SMT threads.
>
> How does Sparc iterate its SMT siblings in cpuid space?
SPARC does sequential enumeration of siblings first, although this needs to
be confirmed if non-sequential enumeration on x86 is the reason of the
improvements through tests. I don't have a SPARC test system handy now.
>
> Also, your benchmarks chose an unfortunate nr of threads vs topology.
> The 2^n thing chosen never hits the 100% core case (6,22 resp.).
>
>>> So while I'm not adverse to limiting the empty core search; I do feel it
>>> is important to have. Overloading cores when you don't have to is not
>>> good.
>> Can we have a config or a way for enabling/disabling select_idle_core?
> I like Rohit's suggestion of folding select_idle_core and
> select_idle_cpu much better, then it stays SMT aware.
>
> Something like the completely untested patch below.
I tried both the patches you suggested, the first with merging of
select_idle_core and select_idle_cpu and second with the new way of
calculating avg_idle and finally both combined. I ran the following
benchmarks for each, the merge only patch seems to giving similar
improvements as my original patch for Uperf and Oracle DB tests, but it
regresses for hackbench. If we can fix this I am OK with it. I can do a run
of other benchamrks after that.

I also noticed a possible bug later in the merge code. Shouldn't it be:

if (busy < best_busy) {
         best_busy = busy;
         best_cpu = first_idle;
}

Unfortunately I noticed it after all runs.

merge:

Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):
groups  baseline       %stdev  patch %stdev
1       0.5742         21.13   0.5099 (11.2%) 2.24
2       0.5776         7.87    0.5385 (6.77%) 3.38
4       0.9578         1.12    1.0626 (-10.94%) 1.35
8       1.7018         1.35    1.8615 (-9.38%) 0.73
16      2.9955         1.36    3.2424 (-8.24%) 0.66
32      5.4354         0.59    5.749  (-5.77%) 0.55

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline        %stdev  patch %stdev
8       49.47           0.35    49.98 (1.03%) 1.36
16      95.28           0.77    97.46 (2.29%) 0.11
32      156.77          1.17    167.03 (6.54%) 1.98
48      193.24          0.22    230.96 (19.52%) 2.44
64      216.21          9.33    299.55 (38.54%) 4
128     379.62          10.29   357.87 (-5.73%) 0.85

Oracle DB on 2 socket, 44 core and 88 threads Intel x86 machine
(normalized, higher is better):
users   baseline        %stdev  patch %stdev
20      1               1.35    0.9919 (-0.81%) 0.14
40      1               0.42    0.9959 (-0.41%) 0.72
60      1               1.54    0.9872 (-1.28%) 1.27
80      1               0.58    0.9925 (-0.75%) 0.5
100     1               0.77    1.0145 (1.45%) 1.29
120     1               0.35    1.0136 (1.36%) 1.15
140     1               0.19    1.0404 (4.04%) 0.91
160     1               0.09    1.0317 (3.17%) 1.41
180     1               0.99    1.0322 (3.22%) 0.51
200     1               1.03    1.0245 (2.45%) 0.95
220     1               1.69    1.0296 (2.96%) 2.83

new avg_idle:

Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):
groups  baseline       %stdev  patch %stdev
1       0.5742         21.13   0.5241 (8.73%) 8.26
2       0.5776         7.87    0.5436 (5.89%) 8.53
4       0.9578         1.12    0.989 (-3.26%) 1.9
8       1.7018         1.35    1.7568 (-3.23%) 1.22
16      2.9955         1.36    3.1119 (-3.89%) 0.92
32      5.4354         0.59    5.5889 (-2.82%) 0.64

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline        %stdev  patch %stdev
8       49.47           0.35    48.11 (-2.75%) 0.29
16      95.28           0.77    93.67 (-1.68%) 0.68
32      156.77          1.17    158.28 (0.96%) 0.29
48      193.24          0.22    190.04 (-1.66%) 0.34
64      216.21          9.33    189.45 (-12.38%) 2.05
128     379.62          10.29   326.59 (-13.97%) 13.07

Oracle DB on 2 socket, 44 core and 88 threads Intel x86 machine
(normalized, higher is better):
users   baseline        %stdev  patch %stdev
20      1               1.35    1.0026 (0.26%) 0.25
40      1               0.42    0.9857 (-1.43%) 1.47
60      1               1.54    0.9903 (-0.97%) 0.99
80      1               0.58    0.9968 (-0.32%) 1.19
100     1               0.77    0.9933 (-0.67%) 0.53
120     1               0.35    0.9919 (-0.81%) 0.9
140     1               0.19    0.9915 (-0.85%) 0.36
160     1               0.09    0.9811 (-1.89%) 1.21
180     1               0.99    1.0002 (0.02%) 0.87
200     1               1.03    1.0037 (0.37%) 2.5
220     1               1.69    0.998 (-0.2%) 0.8

merge + new avg_idle:

Hackbench process on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):
groups  baseline       %stdev  patch %stdev
1       0.5742         21.13   0.6522 (-13.58%) 12.53
2       0.5776         7.87    0.7593 (-31.46%) 2.7
4       0.9578         1.12    1.0952 (-14.35%) 1.08
8       1.7018         1.35    1.8722 (-10.01%) 0.68
16      2.9955         1.36    3.2987 (-10.12%) 0.58
32      5.4354         0.59    5.7751 (-6.25%) 0.46

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline        %stdev  patch %stdev
8       49.47           0.35    51.29 (3.69%) 0.86
16      95.28           0.77    98.95 (3.85%) 0.41
32      156.77          1.17    165.76 (5.74%) 0.26
48      193.24          0.22    234.25 (21.22%) 0.63
64      216.21          9.33    306.87 (41.93%) 2.11
128     379.62          10.29   355.93 (-6.24%) 8.28

Oracle DB on 2 socket, 44 core and 88 threads Intel x86 machine
(normalized, higher is better):
users   baseline        %stdev  patch %stdev
20      1               1.35    1.0085 (0.85%) 0.72
40      1               0.42    1.0017 (0.17%) 0.3
60      1               1.54    0.9974 (-0.26%) 1.18
80      1               0.58    1.0115 (1.15%) 0.93
100     1               0.77    0.9959 (-0.41%) 1.21
120     1               0.35    1.0034 (0.34%) 0.72
140     1               0.19    1.0123 (1.23%) 0.93
160     1               0.09    1.0057 (0.57%) 0.65
180     1               0.99    1.0195 (1.95%) 0.99
200     1               1.03    1.0474 (4.74%) 0.55
220     1               1.69    1.0392 (3.92%) 0.36
