Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426009AbeBOQgM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:36:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40448 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423965AbeBOQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:07 -0500
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches for
 idle_balance
To: Mike Galbraith <efault@gmx.de>, Rohit Jain <rohit.k.jain@oracle.com>,
        linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
 <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
 <1518147735.24350.26.camel@gmx.de>
 <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
 <1518244651.10229.66.camel@gmx.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
Date: Thu, 15 Feb 2018 11:35:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518244651.10229.66.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/2018 1:37 AM, Mike Galbraith wrote:
> On Fri, 2018-02-09 at 11:08 -0500, Steven Sistare wrote:
>>>> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>>>  		if (!(sd->flags & SD_LOAD_BALANCE))
>>>>  			continue;
>>>>  
>>>> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>>>> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
>>>> +		    sd->sched_migration_cost) {
>>>>  			update_next_balance(sd, &next_balance);
>>>>  			break;
>>>>  		}
>>>
>>> Ditto.
>>
>> The old code did not migrate if the expected costs exceeded the expected idle
>> time.  The new code just adds the sd-specific penalty (essentially loss of cache 
>> footprint) to the costs.  The for_each_domain loop visit smallest to largest
>> sd's, hence visiting smallest to largest migration costs (though the tunables do 
>> not enforce an ordering), and bails at the first sd where the total cost is a lose.
> 
> Hrm..
> 
> You're now adding a hypothetical cost to the measured cost of running
> the LB machinery, which implies that the measurement is insufficient,
> but you still don't say why it is insufficient.  What happens if you
> don't do that?  I ask, because when I removed the...
> 
>    this_rq->avg_idle < sysctl_sched_migration_cost
> 
> ...bits to check removal effect for Peter, the original reason for it
> being added did not re-materialize, making me wonder why you need to
> make this cutoff more aggressive.

The current code with sysctl_sched_migration_cost discourages migration
too much, per our test results.  Deleting it entirely from idle_balance()
may be the right solution, or it may allow too much migration and
cause regressions due to loss of cache warmth on some workloads.
Rohit's patch deletes it and adds the sd->sched_migration_cost term
to allow a migration rate that is somewhere in the middle, and is
logically sound.  It discourages but does not prevent migration between
nodes, and encourages but does not always allow migration between cores.
By contrast, setting relax_domain_level to disable SD_BALANCE_NEWIDLE
at the SD_NUMA level is a big hammer.

I would be perfectly happy if deleting sysctl_sched_migration_cost from
idle_balance does the trick.  Last week in a different thread you mentioned
it did not hurt tbench:

>> Mike, do you remember what comes apart when we take
>> out the sysctl_sched_migration_cost test in idle_balance()?
>
> Used to be anything scheduling cross-core heftily suffered, ie pretty
> much any localhost communication heavy load.  I just tried disabling it
> in 4.13 though (pre pti cliff), tried tbench, and it made zip squat
> difference.  I presume that's due to the meanwhile added
> this_rq->rd->overload and/or curr_cost checks.

Can you provide more details on the sysbench oltp test that motivated you
to add sysctl_sched_migration_cost to idle_balance, so Rohit can re-test it?
   1b9508f6 sched: Rate-limit newidle
   Rate limit newidle to migration_cost. It's a win for all stages of
   sysbench oltp tests.

Rohit is running more tests with a patch that deletes
sysctl_sched_migration_cost from idle_balance, and for his patch but
with the 5000 usec mistake corrected back to 500 usec.  So far both
give improvements over the baseline, but for different cases, so we
need to try more workloads before we draw any conclusions.

Rohit, can you share your data so far?

- Steve
