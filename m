Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0064B2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0064B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeJYUDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:03:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeJYUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46827A78;
        Thu, 25 Oct 2018 04:31:16 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 331803F5D3;
        Thu, 25 Oct 2018 04:31:14 -0700 (PDT)
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Steven Sistare <steven.sistare@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <20181022170421.GF3117@worktop.programming.kicks-ass.net>
 <8e38ce84-ec1a-aef7-4784-462ef754f62a@oracle.com>
 <a43db228-ddd0-c30f-6ba0-8d54f17f57c7@arm.com>
 <abf3ae2a-a7f4-2524-0da6-09599928b47a@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <09b10abc-8357-2db3-3d30-8aa9e95e8655@arm.com>
Date:   Thu, 25 Oct 2018 12:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <abf3ae2a-a7f4-2524-0da6-09599928b47a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/10/2018 20:27, Steven Sistare wrote:
[...]
> Hi Valentin,
> 
> Asymmetric systems could maintain a separate bitmap for misfits; set a bit 
> when a CPU goes on CPU, clear it going off.  When a fast CPU goes new idle,
> it would first search the misfits mask, then search cfs_overload_cpus.
> The misfits logic would be conditionalized with CONFIG or sched feat static 
> branches so symmetric systems do not incur extra overhead.
> 

That sounds reasonable - besides, misfit already introduces a
sched_asym_cpucapacity static key. I'll try to play around with that.

>> We'd also lose the NOHZ update done in idle_balance(), though I think it's
>> not such a big deal - were were piggy-backing this on idle_balance() just
>> because it happened to be convenient, and we still have NOHZ_STATS_KICK
>> anyway.
> 
> Agreed.
>  
>> Another thing - in your test cases, what is the most prevalent cause of
>> failure to pull a task in idle_balance()? Is it the load_balance() itself
>> that fails to find a task (e.g. because the imbalance is not deemed big
>> enough), or is it the idle migration cost logic that prevents
>> load_balance() from running to completion?
> 
> The latter.  Eg, for the test "X6-2, 40 CPUs, hackbench 3 process 50000",
> CPU avg_idle is 355566 nsec, and sched_migration_cost_ns = 500000,
> so idle_balance bails at the top:
>           if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>             ...
>             goto out
> 
> For other tests, we get past that clause but bail from a domain:
>       if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>            ...
>            break;
> 
>> In the first case, try_steal() makes perfect sense to me. In the second
>> case, I'm not sure if we really want to pull something if we know (well,
>> we *think*) we're about to resume the execution of some other task.
> 
> 355.566 microsec is enough time to steal, go on CPU, do useful work, and go 
> off CPU, particularly for chatty workloads like hackbench.  The performance
> data bear this out.  For the higher loads, the average timeslice for 
> hackbench 
> 

Thanks for the explanation. AIUI the big difference here is that try_steal()
is considerably cheaper than load_balance(), so the rq->avg_idle concerns
matter less (or at least, on a considerably smaller scale).

> Perhaps I could skip try_steal() if avg_idle is very small, although with
> hackbench I have seen average time slice as small as 10 microsec under 
> high load and preemptions.  I'll run some experiments.
> 

That might be a safe thing to do. In the same department, maybe we could
skip try_steal() if we bail out of idle_balance() because
!(this_rq->rd->overload). Although rq->rd->overload and cfs_overload_cpus
are decoupled, they should express the same thing here.

>>> We could merge the stealing code into the idle_balance() code to get a
>>> union of the two, but IMO that would be less readable.
>>>
>>> We could remove the core and socket levels from idle_balance()
>>
>> I understand that as only doing load_balance() at DIE level in
>> idle_balance(), as that is what makes most sense to me (with big.LITTLE
>> those misfit migrations are done at DIE level), is that correct?
> 
> Correct. 
>> Also, with DynamIQ (next gen big.LITTLE) we could have asymmetry at MC
>> level, which could cause issues there.
> 
> We could keep idle_balance for this level and fall back to stealing as in
> my patch, or you could extend the misfits bitmap to also include CPUs 
> with reduced memory bandwidth and active tasks. (if I understand the asymmetry 
> correctly).
> 

It's mostly µarch asymmetry, so by "asymmetry at MC level" I meant "we'll
see the SD_ASYM_CPUCAPACITY flag at MC level". But if we tweak stealing
to take misfit tasks into account (so we'd rely on SD_ASYM_CPUCAPACITY
in some way or another), that could work.

>>> and let
>>> stealing handle those levels.  I think that makes sense after stealing
>>> performance is validated on more architectures, but we would still have
>>> two different mechanisms.
>>>
>>> - Steve
>>
>> I'll try out those patches on top of the misfit series to see how the
>> whole thing behaves.
> 
> Very good, thanks.
> 
> - Steve
> 
