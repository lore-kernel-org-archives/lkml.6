Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166342AbeBOSWT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:22:19 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48320 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163372AbeBOSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:22:15 -0500
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
 <dd972024-b3d6-fa53-7cc5-9e71a01c1837@oracle.com>
 <1518718056.13961.23.camel@gmx.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <e9591680-4278-5344-6876-d16e8f9c53c4@oracle.com>
Date: Thu, 15 Feb 2018 13:21:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518718056.13961.23.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/2018 1:07 PM, Mike Galbraith wrote:
> On Thu, 2018-02-15 at 11:35 -0500, Steven Sistare wrote:
>> On 2/10/2018 1:37 AM, Mike Galbraith wrote:
>>> On Fri, 2018-02-09 at 11:08 -0500, Steven Sistare wrote:
>>>>>> @@ -8804,7 +8803,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>>>>>  		if (!(sd->flags & SD_LOAD_BALANCE))
>>>>>>  			continue;
>>>>>>  
>>>>>> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>>>>>> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost +
>>>>>> +		    sd->sched_migration_cost) {
>>>>>>  			update_next_balance(sd, &next_balance);
>>>>>>  			break;
>>>>>>  		}
>>>>>
>>>>> Ditto.
>>>>
>>>> The old code did not migrate if the expected costs exceeded the expected idle
>>>> time.  The new code just adds the sd-specific penalty (essentially loss of cache 
>>>> footprint) to the costs.  The for_each_domain loop visit smallest to largest
>>>> sd's, hence visiting smallest to largest migration costs (though the tunables do 
>>>> not enforce an ordering), and bails at the first sd where the total cost is a lose.
>>>
>>> Hrm..
>>>
>>> You're now adding a hypothetical cost to the measured cost of running
>>> the LB machinery, which implies that the measurement is insufficient,
>>> but you still don't say why it is insufficient.  What happens if you
>>> don't do that?  I ask, because when I removed the...
>>>
>>>    this_rq->avg_idle < sysctl_sched_migration_cost
>>>
>>> ...bits to check removal effect for Peter, the original reason for it
>>> being added did not re-materialize, making me wonder why you need to
>>> make this cutoff more aggressive.
>>
>> The current code with sysctl_sched_migration_cost discourages migration
>> too much, per our test results.
> 
> That's why I asked you what happens if you only whack the _apparently_
> (but maybe not) obsolete old throttle, it appeared likely that your win
> came from allowing a bit more migration than the simple throttle
> allowed, which if true, would obviate the need for anything more.
> 
>> Can you provide more details on the sysbench oltp test that motivated you
>> to add sysctl_sched_migration_cost to idle_balance, so Rohit can re-test it?
> 
> The problem at that time was the cycle overhead of entering that LB
> path at high frequency.  Dirt simple.

I get that. I meant please provide details on test parameters and config if
you remember them.

- Steve
