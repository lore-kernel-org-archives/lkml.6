Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeDXVn1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:43:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46030 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeDXVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:43:26 -0400
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
 <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <df8f4982-908a-23e6-5148-4d4e91d38be4@oracle.com>
Date: Tue, 24 Apr 2018 14:45:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:46 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 05:41:14PM -0700, subhra mazumdar wrote:
>> select_idle_core() can potentially search all cpus to find the fully idle
>> core even if there is one such core. Removing this is necessary to achieve
>> scalability in the fast path.
> So this removes the whole core awareness from the wakeup path; this
> needs far more justification.
>
> In general running on pure cores is much faster than running on threads.
> If you plot performance numbers there's almost always a fairly
> significant drop in slope at the moment when we run out of cores and
> start using threads.
The only justification I have is the benchmarks I ran all most all
improved, most importantly our internal Oracle DB tests which we care about
a lot. So what you said makes sense in theory but is not borne out by real
world results. This indicates that threads of these benchmarks care more
about running immediately on any idle cpu rather than spending time to find
fully idle core to run on.
> Also, depending on cpu enumeration, your next patch might not even leave
> the core scanning for idle CPUs.
>
> Now, typically on Intel systems, we first enumerate cores and then
> siblings, but I've seen Intel systems that don't do this and enumerate
> all threads together. Also other architectures are known to iterate full
> cores together, both s390 and Power for example do this.
>
> So by only doing a linear scan on CPU number you will actually fill
> cores instead of equally spreading across cores. Worse still, by
> limiting the scan to _4_ you only barely even get onto a next core for
> SMT4 hardware, never mind SMT8.
Again this doesn't matter for the benchmarks I ran. Most are happy to make
the tradeoff on x86 (SMT2). Limiting the scan is mitigated by the fact that
the scan window is rotated over all cpus, so idle cpus will be found soon.
There is also stealing by idle cpus. Also this was an RFT so I request this
to be tested on other architectrues like SMT4/SMT8.
>
> So while I'm not adverse to limiting the empty core search; I do feel it
> is important to have. Overloading cores when you don't have to is not
> good.
Can we have a config or a way for enabling/disabling select_idle_core?
