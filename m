Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF84ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A78620821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A78620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeKADrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:47:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbeKADrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:47:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F4C880D;
        Wed, 31 Oct 2018 11:48:24 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF163F6A8;
        Wed, 31 Oct 2018 11:48:21 -0700 (PDT)
Subject: Re: [PATCH 07/10] sched/fair: Provide can_migrate_task_llc
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        Quentin Perret <quentin.perret@arm.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-8-git-send-email-steven.sistare@oracle.com>
 <f75ddcd5-f9a0-30c5-94e4-c4077e17ffb0@arm.com>
 <b9915490-661b-0d0e-ae60-d5803357e1ec@oracle.com>
 <b7d91b1d-5da1-5d70-f266-93b108379b64@arm.com>
 <7c503b58-6370-df65-51c3-2591bb1cf621@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d018a2d4-815a-9731-63e4-ba61c8259435@arm.com>
Date:   Wed, 31 Oct 2018 18:48:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7c503b58-6370-df65-51c3-2591bb1cf621@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2018 15:43, Steven Sistare wrote:
> On 10/29/2018 3:34 PM, Valentin Schneider wrote:
[...]
>> Suppose you have 2 rq's sharing a workload of 3 tasks. You get one rq with
>> nr_running == 1 (r_1) and one rq with nr_running == 2 (r_2).
>>
>> As soon as the task on r_1 ends/blocks, we'll go through idle balancing and
>> can potentially steal the non-running task from r_2. Sometime later the task
>> that was running on r_1 wakes up, and we end up with r_1->nr_running == 2
>> and r_2->nr_running == 1.
>>
>> IOW we've swapped their role in that example, and the whole thing can
>> repeat.
>>
>> The shorter the period of those tasks, the more we'll migrate them
>> between rq's, hence why I wonder if we shouldn't have some sort of
>> throttling.
> 
> Stealing is still the right move in this scenario.  Idle cycles become useful
> cycles.  The only cost is the CPU time to dequeue from a remote rq and
> enqueue on the local rq.  Earlier we discussed skipping try_steal() if avg_idle
> is very small, on the order of 10 usec.  I think that type of throttling would 
> cover your scenario.  I will add it in my next version.
> 

Sounds good to me. Out of curiosity, how did you establish this 10 µsec
threshold? I guess we just want something very tiny but still big enough
to broadly cover try_steal() worst case exec times.

[...]
>> Mmm so task_hot() mainly implements two mechanisms - the CACHE_HOT_BUDDY
>> sched feature and the exec_start threshold.
>>
>> The first one should be sidestepped in the stealing case since we won't
>> pass (if env->dst_rq->nr_running), that leaves us with the threshold.
>>
>> We might want to sidestep it when we are doing balancing within an LLC
>> domain (env->sd->flags & SD_SHARE_PKG_RESOURCES) - or use a lower threshold
>> in such cases.
>>
>> In any case, I think it would make sense to add some LLC conditions to
>> task_hot() so that
>> - regular load_balance() can also benefit from them
> 
> This is probably a good idea (lower threshold for task_hot within LLC).
> I would rather see it done as a separate patch, with a separate performance
> evaluation, as it will affect all workloads, even those that do not steal.

Agreed.

> A load balancing migration when !task_hot() may be performed even when
> the dst CPU already has a task to run, so the migration may or may not
> improve utilization.  By contrast, a newly idle CPU that does not find
> work goes idle and definitely wastes cycles.  Note how
> migrate_degrades_locality() chooses migration regardless of preferred node
> when the dst is idle:
> 
>         /* Leaving a core idle is often worse than degrading locality. */
>         if (env->idle != CPU_NOT_IDLE)
>                 return -1;
> 
> I apply the same principle in can_migrate_task_llc().
> 
[...]
>> Right, so my line of thinking was that by not doing a load_balance() and
>> taking a shortcut (stealing a task), we may end up just postponing a
>> load_balance() to after we've stolen a task. I guess in those cases
>> there's no magic trick to be found and we just have to deal with it.
> 
> In the current code I call idle_balance/load_balance first and then try_steal.
> If idle_balance fails because of cost, then it has effectively postponed itself,
> independently of stealing.  The next successful call to load_balance will
> correct any imbalance caused by stealing.
> 
>> And then there's some of the logic like we have in update_sd_pick_busiest()
>> where we e.g. try to prevent misfit tasks from running on LITTLEs, but
>> then if such tasks are waiting to be run and a LITTLE frees itself up,
>> I *think* it's okay to steal it.
> 
> Should be OK to steal.  If a BIG subsequently goes idle, load_balance will move
> the task to the BIG, or the BIG may steal it when we support misfit stealing.
> 
> Questions for you, Valentin:
> 
>   - Should misfit stealing be a separate patch, after my series?  I prefer that,
>     so we get stealing in peoples hands as soon as possible.  I think separating 
>     it is OK because stealing should not cause any regression for misfits, as 
>     my code still calls idle_balance/load_balance, which handles misfits.
> 

I don't have any objections, Quentin (added on cc) might want to disable
stealing when !overutilized for Energy Aware Scheduling, but then that
also depends on what gets in first :)

>   - Who should implement misfit stealing -- you, me, someone else?  I have no 
>     preference.

It would make more sense if I did that, as it's easy for me to test it -
unless you're really curious about Arm stuff and want to have some fun :)

> 
> - Steve
> 
