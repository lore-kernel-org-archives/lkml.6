Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBIQOR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:14:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52692 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeBIQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:14:16 -0500
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
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <e773350b-dd8c-ab1a-5dae-8f62cea225de@oracle.com>
Date: Fri, 9 Feb 2018 11:08:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518147735.24350.26.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2018 10:42 PM, Mike Galbraith wrote:
> On Thu, 2018-02-08 at 14:19 -0800, Rohit Jain wrote:
>> This patch makes idle_balance more dynamic as the sched_migration_cost
>> is now accounted on a sched_domain level. This in turn is done in
>> sd_init when we know what the topology relationships are.
>>
>> For introduction sakes cost of migration within the same core is set as
>> 0, across cores is 50 usec and across sockets is 500 usec. sysctl for
>> these variables are introduced in patch 2.
>>
>> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
>> ---
>>  include/linux/sched/topology.h | 1 +
>>  kernel/sched/fair.c            | 6 +++---
>>  kernel/sched/topology.c        | 5 +++++
>>  3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index cf257c2..bcb4db2 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -104,6 +104,7 @@ struct sched_domain {
>>  	u64 max_newidle_lb_cost;
>>  	unsigned long next_decay_max_lb_cost;
>>  
>> +	u64 sched_migration_cost;
>>  	u64 avg_scan_cost;		/* select_idle_sibling */
>>  
>>  #ifdef CONFIG_SCHEDSTATS
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2fe3aa8..61d3508 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8782,8 +8782,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  	 */
>>  	rq_unpin_lock(this_rq, rf);
>>  
>> -	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>> -	    !this_rq->rd->overload) {
>> +	if (!this_rq->rd->overload) {
>>  		rcu_read_lock();
>>  		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>  		if (sd)
> 
> Unexplained/unrelated change.

This could be explained better in the cover letter, but it is related; this and the
change below are the meat of the patch.  The deleted test "this_rq->avg_idle <
sysctl_sched_migration_cost" formerly bailed based on a single global notion of 
migration cost, independent of sd.  Now the cost is per-sd, evaluated in the sd loop 
below.  The other condition to bail early, "!this_rq->rd->overload" is still relevant 
and remains.
 
>> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>  		if (!(sd->flags & SD_LOAD_BALANCE))
>>  			continue;
>>  
>> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
>> +		    sd->sched_migration_cost) {
>>  			update_next_balance(sd, &next_balance);
>>  			break;
>>  		}
> 
> Ditto.

The old code did not migrate if the expected costs exceeded the expected idle
time.  The new code just adds the sd-specific penalty (essentially loss of cache 
footprint) to the costs.  The for_each_domain loop visit smallest to largest
sd's, hence visiting smallest to largest migration costs (though the tunables do 
not enforce an ordering), and bails at the first sd where the total cost is a lose.

>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 034cbed..bcd8c64 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1148,12 +1148,14 @@ sd_init(struct sched_domain_topology_level *tl,
>>  		sd->flags |= SD_PREFER_SIBLING;
>>  		sd->imbalance_pct = 110;
>>  		sd->smt_gain = 1178; /* ~15% */
>> +		sd->sched_migration_cost = 0;
>>  
>>  	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
>>  		sd->flags |= SD_PREFER_SIBLING;
>>  		sd->imbalance_pct = 117;
>>  		sd->cache_nice_tries = 1;
>>  		sd->busy_idx = 2;
>> +		sd->sched_migration_cost = 500000UL;
>>  
>>  #ifdef CONFIG_NUMA
>>  	} else if (sd->flags & SD_NUMA) {
>> @@ -1162,6 +1164,7 @@ sd_init(struct sched_domain_topology_level *tl,
>>  		sd->idle_idx = 2;
>>  
>>  		sd->flags |= SD_SERIALIZE;
>> +		sd->sched_migration_cost = 5000000UL;
> 
> That's not 500us.

Good catch, thanks.  It's 5000us but should be 500. The latest version of Rohit's patch 
lost a little performance vs the previous version, and this might explain why. 
Re-testing may bring good news.

- Steve
