Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB7AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827E2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m94oFgfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1827E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJYD6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:58:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43694 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYD6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:58:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OJJCqZ088670;
        Wed, 24 Oct 2018 19:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Kd7/ek7pkvb6cH2ii478mZXKpwo2qbuQeLrHV4fmqww=;
 b=m94oFgfuovREL72rJOWapt1VYJBYeC5PhH+VUBvn0Ox7mR246N/X2LnZPiLZKSFTbrQB
 jJ34Load1Q9l8vdgYYqlWPQNkhPsZJRhjwOOEwGcey8ROjtFwXlH+i68BNkyvsXt8QWI
 V2zXXGVFJnIGfEhKBDyn4if6AT+uN/ie5RcolxSONNtYr0a4FgmoWA8bD8oD/iMtsG58
 9TZMX9RtDzgMuSFFoOVnnJ+6o221ylZ0X0AHkPm8OpTsFR4FJkDlm3fmi+cQAptqE47Y
 mLZzUOI3oJpHOpXDchhI+jOCqGWvTQK+uc7CQ979GxNg5d856Wqs6Zh64pcGyKIFXidz 5g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaq5mkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 19:28:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9OJS6px008315
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 19:28:06 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9OJS5OW017589;
        Wed, 24 Oct 2018 19:28:06 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 12:28:05 -0700
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Valentin Schneider <valentin.schneider@arm.com>,
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
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <abf3ae2a-a7f4-2524-0da6-09599928b47a@oracle.com>
Date:   Wed, 24 Oct 2018 15:27:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a43db228-ddd0-c30f-6ba0-8d54f17f57c7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2018 11:34 AM, Valentin Schneider wrote:
> Hi,
> 
> On 22/10/2018 20:07, Steven Sistare wrote:
>> On 10/22/2018 1:04 PM, Peter Zijlstra wrote:
> [...]
>>
>> We could delete idle_balance() and use stealing exclusively for handling
>> new idle.  For each sd level, stealing would look for an overloaded CPU
>> in the overloaded bitmap(s) that overlap that level.  I played with that
>> a little but it is not ready for prime time, and I did not want to hold
>> the patch series for it.  Also, I would like folks to get some production
>> experience with stealing on a variety of architectures before considering
>> a radical step like replacing idle_balance().
> 
> I think this could work fine for standard symmetrical systems, but I have
> some concerns for asymmetric systems (Arm big.LITTLE & co). One thing that
> should show up in 4.20-rc1 is the misfit logic, which caters to those
> asymmetric systems.
> 
> If you look at 757ffdd705ee ("sched/fair: Set rq->rd->overload when
> misfit") on Linus' tree, we can set rq->rd->overload even if
> (rq->nr_running == 1). This is because we do want to do an idle_balance()
> when we have misfit tasks, which should lead to active balancing one of
> those CPU-hungry tasks to move it to a more powerful CPU.
> 
> With a pure try_steal() approach, we won't do any active balancing - we
> could steal some task from a cfs_overload_cpu but that's not what the
> load balancer would have done. The load balancer would only do such a thing
> if the imbalance type is group_overloaded, which means:
> 
>   sum_nr_running > group_weight &&
>   group_util * sd->imbalance_pct > group_capacity * 100
> 
> (IOW the number of tasks running on the CPU is not the sole deciding
> factor)
> 
> Otherwise, misfit tasks (group_misfit_task imbalance type) would have
> priority.
> 
> Perhaps we could decorate the cfs_overload_cpus with some more information
> (e.g. misfit task presence), but then we'd have to add some logic to decide
> when to steal what.

Hi Valentin,

Asymmetric systems could maintain a separate bitmap for misfits; set a bit 
when a CPU goes on CPU, clear it going off.  When a fast CPU goes new idle,
it would first search the misfits mask, then search cfs_overload_cpus.
The misfits logic would be conditionalized with CONFIG or sched feat static 
branches so symmetric systems do not incur extra overhead.

> We'd also lose the NOHZ update done in idle_balance(), though I think it's
> not such a big deal - were were piggy-backing this on idle_balance() just
> because it happened to be convenient, and we still have NOHZ_STATS_KICK
> anyway.

Agreed.
 
> Another thing - in your test cases, what is the most prevalent cause of
> failure to pull a task in idle_balance()? Is it the load_balance() itself
> that fails to find a task (e.g. because the imbalance is not deemed big
> enough), or is it the idle migration cost logic that prevents
> load_balance() from running to completion?

The latter.  Eg, for the test "X6-2, 40 CPUs, hackbench 3 process 50000",
CPU avg_idle is 355566 nsec, and sched_migration_cost_ns = 500000,
so idle_balance bails at the top:
          if (this_rq->avg_idle < sysctl_sched_migration_cost ||
            ...
            goto out

For other tests, we get past that clause but bail from a domain:
      if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
           ...
           break;

> In the first case, try_steal() makes perfect sense to me. In the second
> case, I'm not sure if we really want to pull something if we know (well,
> we *think*) we're about to resume the execution of some other task.

355.566 microsec is enough time to steal, go on CPU, do useful work, and go 
off CPU, particularly for chatty workloads like hackbench.  The performance
data bear this out.  For the higher loads, the average timeslice for 
hackbench 

Perhaps I could skip try_steal() if avg_idle is very small, although with
hackbench I have seen average time slice as small as 10 microsec under 
high load and preemptions.  I'll run some experiments.

>> We could merge the stealing code into the idle_balance() code to get a
>> union of the two, but IMO that would be less readable.
>>
>> We could remove the core and socket levels from idle_balance()
> 
> I understand that as only doing load_balance() at DIE level in
> idle_balance(), as that is what makes most sense to me (with big.LITTLE
> those misfit migrations are done at DIE level), is that correct?

Correct. 
> Also, with DynamIQ (next gen big.LITTLE) we could have asymmetry at MC
> level, which could cause issues there.

We could keep idle_balance for this level and fall back to stealing as in
my patch, or you could extend the misfits bitmap to also include CPUs 
with reduced memory bandwidth and active tasks. (if I understand the asymmetry 
correctly).

>> and let
>> stealing handle those levels.  I think that makes sense after stealing
>> performance is validated on more architectures, but we would still have
>> two different mechanisms.
>>
>> - Steve
> 
> I'll try out those patches on top of the misfit series to see how the
> whole thing behaves.

Very good, thanks.

- Steve
