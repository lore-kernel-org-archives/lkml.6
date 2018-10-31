Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049E6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC70D2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q5grfofk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC70D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeKAAm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:42:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33058 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeKAAm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:42:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9VFhjlW016175;
        Wed, 31 Oct 2018 15:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=QkdlQLxI/69quCWZhNOhAuX7UeTZjVfWi4PmqiC54cY=;
 b=q5grfofkYgXre/FfJIsDY9q2PA0z+QInUyxsQh+9VdgFw8FybwddDmJA9AZvygYxxfYG
 15s+mIG7prIoryNebVvhWaS2OvoUqnSoLoiCwcgOfqWNNCQhyAhtvHhBuQkmHlLRG7OE
 jxnnXXxZa4L25NKxcVeOVnyGplDyl/sW7JK+fvNXgbF0vsPFuLVlvzw1gP+sJyuvRxRp
 Z4r+Jf2z+vpcXcvCl11m5XEEYG4SkrORyW0aHfqozykkxMIwxn/dHz/QoJwN9M9iA6wb
 vKqmsdoYkjvQkvRPLx9c2LRBdy9BBe9/z6WNWODHgz1doTs1Wryav2d3nFeBCBS7zd/U gA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nducm8jrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 15:43:57 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9VFhumO010996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 15:43:56 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9VFhtEP032360;
        Wed, 31 Oct 2018 15:43:55 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Oct 2018 08:43:55 -0700
Subject: Re: [PATCH 07/10] sched/fair: Provide can_migrate_task_llc
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-8-git-send-email-steven.sistare@oracle.com>
 <f75ddcd5-f9a0-30c5-94e4-c4077e17ffb0@arm.com>
 <b9915490-661b-0d0e-ae60-d5803357e1ec@oracle.com>
 <b7d91b1d-5da1-5d70-f266-93b108379b64@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <7c503b58-6370-df65-51c3-2591bb1cf621@oracle.com>
Date:   Wed, 31 Oct 2018 11:43:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b7d91b1d-5da1-5d70-f266-93b108379b64@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2018 3:34 PM, Valentin Schneider wrote:
> On 26/10/2018 19:28, Steven Sistare wrote:
>> On 10/26/2018 2:04 PM, Valentin Schneider wrote:
> [...]
>>>
>>> I was thinking that perhaps we could have scenarios where some rq's
>>> keep stealing tasks off of each other and we end up circulating tasks 
>>> between CPUs. Now, that would only happen if we had a handful of tasks
>>> with a very tiny period, and I'm not familiar with (real) such hyperactive
>>> workloads similar to those generated by hackbench where that could happen.
>>
>> That will not happen with the current code, as it only steals if nr_running > 1.
>> The src loses a task, the dst gains it and has nr_running == 1, so it will not
>> be re-stolen.
> 
> That's indeed fine, I was thinking of something like this:
> 
> Suppose you have 2 rq's sharing a workload of 3 tasks. You get one rq with
> nr_running == 1 (r_1) and one rq with nr_running == 2 (r_2).
> 
> As soon as the task on r_1 ends/blocks, we'll go through idle balancing and
> can potentially steal the non-running task from r_2. Sometime later the task
> that was running on r_1 wakes up, and we end up with r_1->nr_running == 2
> and r_2->nr_running == 1.
> 
> IOW we've swapped their role in that example, and the whole thing can
> repeat.
> 
> The shorter the period of those tasks, the more we'll migrate them
> between rq's, hence why I wonder if we shouldn't have some sort of
> throttling.

Stealing is still the right move in this scenario.  Idle cycles become useful
cycles.  The only cost is the CPU time to dequeue from a remote rq and
enqueue on the local rq.  Earlier we discussed skipping try_steal() if avg_idle
is very small, on the order of 10 usec.  I think that type of throttling would 
cover your scenario.  I will add it in my next version.

>> If we modify the code to handle misfits, we may steal when src nr_running == 1,
>> but a fast CPU will only steal the lone task from a slow one, never fast from fast, 
>> and never slow from fast, so no tug of war.
>>
>>> In short, I wonder if we should have task_hot() in there. Drawing a
>>> parallel with load_balance(), even if load-balancing is happening between
>>> rqs of the same LLC, we do go check task_hot(). Have you already experimented
>>> with adding a task_hot() check in here?
>>
>> I tried task_hot, to see if L1/L2 cache warmth matters much on L1/L2/L3 systems, 
>> and it reduced steals and overall performance.
> 
> Mmm so task_hot() mainly implements two mechanisms - the CACHE_HOT_BUDDY
> sched feature and the exec_start threshold.
> 
> The first one should be sidestepped in the stealing case since we won't
> pass (if env->dst_rq->nr_running), that leaves us with the threshold.
> 
> We might want to sidestep it when we are doing balancing within an LLC
> domain (env->sd->flags & SD_SHARE_PKG_RESOURCES) - or use a lower threshold
> in such cases.
> 
> In any case, I think it would make sense to add some LLC conditions to
> task_hot() so that
> - regular load_balance() can also benefit from them

This is probably a good idea (lower threshold for task_hot within LLC).
I would rather see it done as a separate patch, with a separate performance
evaluation, as it will affect all workloads, even those that do not steal.
A load balancing migration when !task_hot() may be performed even when
the dst CPU already has a task to run, so the migration may or may not
improve utilization.  By contrast, a newly idle CPU that does not find
work goes idle and definitely wastes cycles.  Note how
migrate_degrades_locality() chooses migration regardless of preferred node
when the dst is idle:

        /* Leaving a core idle is often worse than degrading locality. */
        if (env->idle != CPU_NOT_IDLE)
                return -1;

I apply the same principle in can_migrate_task_llc().

> - task stealing has at least some sort of throttling
> 
> 
> On a sidenote, I find it a bit odd that the exec_start threshold depends on
> sysctl_sched_migration_cost, which to me is more about idle_balance() cost
> than "how long does it take for a previously run task to go cache cold".

Agreed, but these are all magic numbers anyway :)

>>> I've run some iterations of hackbench (hackbench 2 process 100000) to
>>> investigate this task bouncing, but I didn't really see any of it. That was
>>> just a 4+4 big.LITTLE system though, I'll try to get numbers on a system
>>> with more CPUs.
>>>
>>> ----->8-----
>>>
>>> activations: # of task activations (task starts running)
>>> cpu_migrations: # of activations where cpu != prev_cpu
>>> % stats are percentiles
>>>
>>> - STEAL:
>>>
>>>   | stat  | cpu_migrations | activations |
>>>   |-------+----------------+-------------|
>>>   | count |    2005.000000 | 2005.000000 |
>>>   | mean  |      16.244888 |  290.608479 |
>>>   | std   |      38.963138 |  253.003528 |
>>>   | min   |       0.000000 |    3.000000 |
>>>   | 50%   |       3.000000 |  239.000000 |
>>>   | 75%   |       8.000000 |  436.000000 |
>>>   | 90%   |      45.000000 |  626.000000 |
>>>   | 99%   |     188.960000 | 1073.000000 |
>>>   | max   |     369.000000 | 1417.000000 |
>>>
>>> - NO_STEAL:
>>>
>>>   | stat  | cpu_migrations | activations |
>>>   |-------+----------------+-------------|
>>>   | count |    2005.000000 | 2005.000000 |
>>>   | mean  |      15.260848 |  297.860848 |
>>>   | std   |      46.331890 |  253.210813 |
>>>   | min   |       0.000000 |    3.000000 |
>>>   | 50%   |       3.000000 |  252.000000 |
>>>   | 75%   |       7.000000 |  444.000000 |
>>>   | 90%   |      32.600000 |  643.600000 |
>>>   | 99%   |     214.880000 | 1127.520000 |
>>>   | max   |     467.000000 | 1547.000000 |
>>>
>>> ----->8-----
>>>
>>> Otherwise, my only other concern at the moment is that since stealing
>>> doesn't care about load, we could steal a task that would cause a big
>>> imbalance, which wouldn't have happened with a call to load_balance().
>>>
>>> I don't think this can be triggered with a symmetrical workload like
>>> hackbench, so I'll go explore something else.
>>
>> The dst is about to go idle with zero load, so stealing can only improve the
>> instantaneous balance between src and dst.  For longer term average load, we
>> still rely on periodic load_balance to make adjustments.
> 
> Right, so my line of thinking was that by not doing a load_balance() and
> taking a shortcut (stealing a task), we may end up just postponing a
> load_balance() to after we've stolen a task. I guess in those cases
> there's no magic trick to be found and we just have to deal with it.

In the current code I call idle_balance/load_balance first and then try_steal.
If idle_balance fails because of cost, then it has effectively postponed itself,
independently of stealing.  The next successful call to load_balance will
correct any imbalance caused by stealing.

> And then there's some of the logic like we have in update_sd_pick_busiest()
> where we e.g. try to prevent misfit tasks from running on LITTLEs, but
> then if such tasks are waiting to be run and a LITTLE frees itself up,
> I *think* it's okay to steal it.

Should be OK to steal.  If a BIG subsequently goes idle, load_balance will move
the task to the BIG, or the BIG may steal it when we support misfit stealing.

Questions for you, Valentin:

  - Should misfit stealing be a separate patch, after my series?  I prefer that,
    so we get stealing in peoples hands as soon as possible.  I think separating 
    it is OK because stealing should not cause any regression for misfits, as 
    my code still calls idle_balance/load_balance, which handles misfits.

  - Who should implement misfit stealing -- you, me, someone else?  I have no 
    preference.

- Steve
