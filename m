Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeBBVHC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:07:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37092 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeBBVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:06:55 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202195943.GR2269@hirez.programming.kicks-ass.net>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <25d67bd2-cbe7-2c2a-e89a-13a7ca5adc10@oracle.com>
Date: Fri, 2 Feb 2018 16:06:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202195943.GR2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2018 2:59 PM, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
>> On 2/1/2018 7:33 AM, Peter Zijlstra wrote:
>>> On Mon, Jan 29, 2018 at 03:31:02PM -0800, subhra mazumdar wrote:
>>>> +	rcu_read_lock();
>>>> +	sd = rcu_dereference(per_cpu(sd_llc, this_cpu));
>>>> +	if (util) {
>>>> +		for_each_lower_domain(sd) {
>>>> +			if (sd->level == 0)
>>>> +				break;
>>>
>>> afaict you really only need this for the core, and here you're assuming
>>> everything below the LLC is cores. Would it not be much clearer if you
>>> introduce sd_core.
>>>
>>> As is, for_each_lower_domain includes the starting domain, sd->group
>>> then is the first core group for this cpu. But then you continue to the
>>> smt domain (on Intel, on other architectures there could be a cluster
>>> domain in between) and then you bail using that sd->level == 0 hack
>>> because otherwise things would go *bang*.
>>
>> Hi Peter,
>>
>> The code here and in smt_balance intentionally visits each level between
>> the llc and smt, including core-cluster on architectures that define it.
>> smt_balance thus has the chance to randomly pick a better cluster,
>> and then within that cluster randomly pick a better core.  It makes sense,
>> as resources are shared within a cluster, and choosing a less loaded cluster
>> should give better performance.  As you suggest in a few other places,
>> it would be nice to see performance results for this case.  We have
>> SPARC processors with core clusters.
>>
> 
> But then you get that atomic crud to contend on the cluster level, which
> is even worse than it contending on the core level.

True, but it can still be a net win if we make better scheduling decisions.
A saving grace is that the atomic counter is only updated if the cpu
makes a transition from idle to busy or vice versa.

We need data for this type of system, showing improvements for normal
workloads, and showing little downside for a high context switch rate
torture test.  

- Steve
