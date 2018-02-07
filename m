Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754242AbeBGAes (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:34:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57532 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbeBGAer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:34:47 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202171708.GN2269@hirez.programming.kicks-ass.net>
 <93db4b69-5ec6-732f-558e-5e64d9ba0cf9@oracle.com>
 <20180205121947.GW2269@hirez.programming.kicks-ass.net>
 <930364e4-bbfe-8c8f-d095-0dd4256a5104@oracle.com>
 <20180206091239.GA2269@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <97500234-ebbb-4404-d4de-ab10d3ec79e1@oracle.com>
Date: Tue, 6 Feb 2018 16:30:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180206091239.GA2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070005
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2018 01:12 AM, Peter Zijlstra wrote:
> On Mon, Feb 05, 2018 at 02:09:11PM -0800, Subhra Mazumdar wrote:
>> The pseudo random is also used for choosing a random core to compare with,
>> how will transposing achieve that?
> Not entirely sure what your point is. Current code doesn't compare to
> just _one_ other core, and I don't think we'd ever want to do that.
>
> So currently select_idle_core() will, if there is an idle core, iterate
> the whole thing trying to find it. If it fails, it clears the
> 'have_idle_core' state.
>
> select_idle_cpu, which we'll fall back to, will limit the scanning based
> on the average idle time.
>
>
> The crucial point however, is that concurrent wakeups will not, on
> average, do the same iteration because of the target offset.
I meant the SMT balance patch. That does comparison with only one other
random core and takes the decision in O(1). Any potential scan of all cores
or cpus is O(n) and doesn't scale and will only get worse in future. That
applies to both select_idle_core() and select_idle_cpu().

Is there any reason this randomized approach is not acceptable even if
benchmarks show improvement? Are there other benchmarks I should try?

Also your suggestion to keep the SMT utilization but still do a 
traversal of cores
in select_idle_core() while remembering the least loaded core will still 
have
the problem of potentially traversing all cores. I can compare this with 
a core
level only SMT balancing, is that useful to decide? I will also test on 
SPARC
machines with higher degree of SMT.

You had also mentioned to do it for only SMT >2, not sure I understand why
as even for SMT=2 (intel) benchmarks show improvement. This clearly shows
the scalability problem.

Thanks,
Subhra
