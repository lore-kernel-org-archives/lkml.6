Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166072AbeBOSIB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:08:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53610 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164030AbeBOSH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:07:56 -0500
Subject: Re: [RFC 1/2] sched: reduce migration cost between faster caches for
 idle_balance
To: Steven Sistare <steven.sistare@oracle.com>,
        Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
 <1518128395-14606-2-git-send-email-rohit.k.jain@oracle.com>
 <1518147735.24350.26.camel@gmx.de>
 <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
 <1518244651.10229.66.camel@gmx.de>
 <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <7e6ee88e-8462-b1ab-a7bf-536a2c576c7d@oracle.com>
Date: Thu, 15 Feb 2018 10:07:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 08:35 AM, Steven Sistare wrote:
> On 2/10/2018 1:37 AM, Mike Galbraith wrote:
>> On Fri, 2018-02-09 at 11:08 -0500, Steven Sistare wrote:
>>>>> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>>>>   		if (!(sd->flags & SD_LOAD_BALANCE))
>>>>>   			continue;
>>>>>   
>>>>> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>>>>> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
>>>>> +		    sd->sched_migration_cost) {
>>>>>   			update_next_balance(sd, &next_balance);
>>>>>   			break;
>>>>>   		}
>>>> Ditto.
>>> The old code did not migrate if the expected costs exceeded the expected idle
>>> time.  The new code just adds the sd-specific penalty (essentially loss of cache
>>> footprint) to the costs.  The for_each_domain loop visit smallest to largest
>>> sd's, hence visiting smallest to largest migration costs (though the tunables do
>>> not enforce an ordering), and bails at the first sd where the total cost is a lose.
>> Hrm..
>>
>> You're now adding a hypothetical cost to the measured cost of running
>> the LB machinery, which implies that the measurement is insufficient,
>> but you still don't say why it is insufficient.  What happens if you
>> don't do that?  I ask, because when I removed the...
>>
>>     this_rq->avg_idle < sysctl_sched_migration_cost
>>
>> ...bits to check removal effect for Peter, the original reason for it
>> being added did not re-materialize, making me wonder why you need to
>> make this cutoff more aggressive.
> The current code with sysctl_sched_migration_cost discourages migration
> too much, per our test results.  Deleting it entirely from idle_balance()
> may be the right solution, or it may allow too much migration and
> cause regressions due to loss of cache warmth on some workloads.
> Rohit's patch deletes it and adds the sd->sched_migration_cost term
> to allow a migration rate that is somewhere in the middle, and is
> logically sound.  It discourages but does not prevent migration between
> nodes, and encourages but does not always allow migration between cores.
> By contrast, setting relax_domain_level to disable SD_BALANCE_NEWIDLE
> at the SD_NUMA level is a big hammer.
>
> I would be perfectly happy if deleting sysctl_sched_migration_cost from
> idle_balance does the trick.  Last week in a different thread you mentioned
> it did not hurt tbench:
>
>>> Mike, do you remember what comes apart when we take
>>> out the sysctl_sched_migration_cost test in idle_balance()?
>> Used to be anything scheduling cross-core heftily suffered, ie pretty
>> much any localhost communication heavy load.  I just tried disabling it
>> in 4.13 though (pre pti cliff), tried tbench, and it made zip squat
>> difference.  I presume that's due to the meanwhile added
>> this_rq->rd->overload and/or curr_cost checks.
> Can you provide more details on the sysbench oltp test that motivated you
> to add sysctl_sched_migration_cost to idle_balance, so Rohit can re-test it?
>     1b9508f6 sched: Rate-limit newidle
>     Rate limit newidle to migration_cost. It's a win for all stages of
>     sysbench oltp tests.
>
> Rohit is running more tests with a patch that deletes
> sysctl_sched_migration_cost from idle_balance, and for his patch but
> with the 5000 usec mistake corrected back to 500 usec.  So far both
> give improvements over the baseline, but for different cases, so we
> need to try more workloads before we draw any conclusions.
>
> Rohit, can you share your data so far?

Results:

In the following results, "Domain based" approach is as mentioned in the
RFC sent out with the values fixed (As pointed out by Mike). "No check" is
the patch where I just remove the check against sysctl_sched_migration_cost

1) Hackbench results on 2 socket, 44 core and 88 threads Intel x86 machine
(lower is better):

+--------------+-----------------+--------------------------+-------------------------+
|              | Without Patch   |Domain Based              |No Check                 |
+------+-------+--------+--------+-----------------+--------+----------------+--------+
|Loops | Groups|Average |%Std Dev|Average          |%Std Dev|Average         |%Std Dev|
+------+-------+--------+--------+-----------------+--------+----------------+--------+
|100000| 4     |9.701   |0.78    |7.971  (+17.84%) | 1.34   |8.919  (+8.07%) |1.07    |
|100000| 8     |17.186  |0.77    |16.712 (+2.76%)  | 0.87   |17.043 (+0.83%) |0.83    |
|100000| 16    |30.378  |0.55    |29.780 (+1.97%)  | 0.38   |29.565 (+2.67%) |0.29    |
|100000| 32    |54.712  |0.54    |53.001 (+3.13%)  | 0.19   |52.158 (+4.67%) |0.22    |
+------+-------+--------+--------+-----------------+--------+----------------+--------+

2) Sysbench MySQL results on 2 socket, 44 core and 88 threads Intel x86
machine (higher is better):

+-------+--------------------+----------------------------+----------------------------+
|       | Without Patch      | Domain based               | No check                   |
+-------+-----------+--------+-------------------+--------+-------------------+--------+
|Num    | Average   |        | Average           |        | Average           |        |
|Threads| throughput|%Std Dev| throughput        |%Std Dev| throughput        |%Std Dev|
+-------+-----------+--------+-------------------+--------+-------------------+--------+
|    8  | 133658.2  | 0.66   | 134909.4 (+0.94%) | 0.94   | 134232.2 (+0.43%) | 1.29   |
|   16  | 266540    | 0.48   | 268253.4 (+0.64%) | 0.64   | 268584.6 (+0.77%) | 0.37   |
|   32  | 466315.6  | 0.15   | 465903.6 (-0.09%) | 0.28   | 468594.2 (+0.49%) | 0.23   |
|   64  | 720039.4  | 0.23   | 725663.8 (+0.78%) | 0.42   | 717253.8 (-0.39%) | 0.36   |
|   72  | 757284.4  | 0.25   | 770693.4 (+1.77%) | 0.29   | 764984.0 (+1.02%) | 0.38   |
|   80  | 807955.6  | 0.22   | 818446.0 (+1.30%) | 0.24   | 831372.2 (+2.90%) | 0.10   |
|   88  | 863173.8  | 0.25   | 870520.4 (+0.85%) | 0.23   | 887049.0 (+2.77%) | 0.56   |
|   96  | 882950.8  | 0.32   | 890775.4 (+0.89%) | 0.40   | 892913.8 (+1.13%) | 0.41   |
|  128  | 895112.6  | 0.13   | 898524.2 (+0.38%) | 0.16   | 901195.0 (+0.68%) | 0.28   |
+-------+-----------+--------+-------------------+--------+-------------------+--------+

Thanks,
Rohit
