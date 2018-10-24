Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA03C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7815020824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJYADL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:03:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44800 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeJYADL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:03:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27EA6A78;
        Wed, 24 Oct 2018 08:34:38 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1385B3F71D;
        Wed, 24 Oct 2018 08:34:35 -0700 (PDT)
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a43db228-ddd0-c30f-6ba0-8d54f17f57c7@arm.com>
Date:   Wed, 24 Oct 2018 16:34:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8e38ce84-ec1a-aef7-4784-462ef754f62a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/10/2018 20:07, Steven Sistare wrote:
> On 10/22/2018 1:04 PM, Peter Zijlstra wrote:
[...]
> 
> We could delete idle_balance() and use stealing exclusively for handling
> new idle.  For each sd level, stealing would look for an overloaded CPU
> in the overloaded bitmap(s) that overlap that level.  I played with that
> a little but it is not ready for prime time, and I did not want to hold
> the patch series for it.  Also, I would like folks to get some production
> experience with stealing on a variety of architectures before considering
> a radical step like replacing idle_balance().
> 

I think this could work fine for standard symmetrical systems, but I have
some concerns for asymmetric systems (Arm big.LITTLE & co). One thing that
should show up in 4.20-rc1 is the misfit logic, which caters to those
asymmetric systems.

If you look at 757ffdd705ee ("sched/fair: Set rq->rd->overload when
misfit") on Linus' tree, we can set rq->rd->overload even if
(rq->nr_running == 1). This is because we do want to do an idle_balance()
when we have misfit tasks, which should lead to active balancing one of
those CPU-hungry tasks to move it to a more powerful CPU.

With a pure try_steal() approach, we won't do any active balancing - we
could steal some task from a cfs_overload_cpu but that's not what the
load balancer would have done. The load balancer would only do such a thing
if the imbalance type is group_overloaded, which means:

  sum_nr_running > group_weight &&
  group_util * sd->imbalance_pct > group_capacity * 100

(IOW the number of tasks running on the CPU is not the sole deciding
factor)

Otherwise, misfit tasks (group_misfit_task imbalance type) would have
priority.

Perhaps we could decorate the cfs_overload_cpus with some more information
(e.g. misfit task presence), but then we'd have to add some logic to decide
when to steal what.




We'd also lose the NOHZ update done in idle_balance(), though I think it's
not such a big deal - were were piggy-backing this on idle_balance() just
because it happened to be convenient, and we still have NOHZ_STATS_KICK
anyway.




Another thing - in your test cases, what is the most prevalent cause of
failure to pull a task in idle_balance()? Is it the load_balance() itself
that fails to find a task (e.g. because the imbalance is not deemed big
enough), or is it the idle migration cost logic that prevents
load_balance() from running to completion?

In the first case, try_steal() makes perfect sense to me. In the second
case, I'm not sure if we really want to pull something if we know (well,
we *think*) we're about to resume the execution of some other task.

> We could merge the stealing code into the idle_balance() code to get a
> union of the two, but IMO that would be less readable.
> 
> We could remove the core and socket levels from idle_balance()

I understand that as only doing load_balance() at DIE level in
idle_balance(), as that is what makes most sense to me (with big.LITTLE
those misfit migrations are done at DIE level), is that correct?

Also, with DynamIQ (next gen big.LITTLE) we could have asymmetry at MC
level, which could cause issues there.

> and let
> stealing handle those levels.  I think that makes sense after stealing
> performance is validated on more architectures, but we would still have
> two different mechanisms.
> 
> - Steve
> 

I'll try out those patches on top of the misfit series to see how the
whole thing behaves.
