Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8668C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F612087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F612087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeLCQ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:56:38 -0500
Received: from foss.arm.com ([217.140.101.70]:41960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeLCQ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:56:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387A41682;
        Mon,  3 Dec 2018 08:56:35 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5B23F59C;
        Mon,  3 Dec 2018 08:56:32 -0800 (PST)
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
 <de2d2824-d66e-8852-d67a-d58b478b74c1@arm.com>
 <0857925d-a24e-90ea-e28c-90d69b2f66dd@oracle.com>
 <7d9b6789-af17-bcab-e52d-7e05483e10ea@arm.com>
 <bccc5096-1353-5103-8c45-3dc5193db4e1@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <094f54a9-a6ec-3c0d-4e06-6572023963c6@arm.com>
Date:   Mon, 3 Dec 2018 16:56:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bccc5096-1353-5103-8c45-3dc5193db4e1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 26/11/2018 19:06, Steven Sistare wrote:
> [...]
>> Mmm I was thinking we could abuse the wrap() and start at
>> (fls(prev_span) + 1), but we're not guaranteed to have contiguous spans -
>> the Arm Juno for instance has [0, 3, 4], [1, 2] as MC-level domains, so
>> that goes down the drain.
>>
>> Another thing that has been trotting in my head would be some helper to
>> create a cpumask from a sparsemask (some sort of sparsemask_span()),
>> which would let us use the standard mask operators:
>>
>> ----->8-----
>> struct cpumask *overload_span = sparsemask_span(overload_cpus)
>>
>> for_each_domain(this_cpu, sd)
>> 	for_each_cpu_and(src_cpu, overload_span, sched_domain_span(sd))
>> 		<steal_from here>
>> -----8>-----
>>
>> The cpumask could be part of the sparsemask struct to save us the
>> allocation, and only updated when calling sparsemask_span().
> 
> I thought of providing something like this along with other sparsemask
> utility functions, but I decided to be minimalist, and let others add
> more functions if/when they become needed.  this_cpu_cpumask_var_ptr(select_idle_mask) 
> is a temporary that could be used as the destination of the conversion.
> 
> Also, conversion adds cost, particularly on larger systems.  When comparing a
> cpumask and a sparsemask, it is more efficient to iterate over the smaller
> set, and test for membership in the larger, such as in try_steal:
> 
>     for_each_cpu(src_cpu, cpu_smt_mask(dst_cpu)) {
>             if (sparsemask_test_elem(src_cpu, overload_cpus)
>  
>>> To extend stealing across LLC, I would like to keep the per-LLC sparsemask, 
>>> but add to each SD a list of sparsemask pointers.  The list nodes would be
>>> private, but the sparsemask structs would be shared.  Each list would include
>>> the masks that overlap the SD's members.  The list would be a singleton at the
>>> core and LLC levels (same as the socket level for most processors), and would 
>>> have multiple elements at the NUMA level.
>>
>> I see. As for misfit, creating asym_cpucapacity siblings of the sd_llc_*()
>> functions seems a bit much - there'd be a lot of redundancy for basically
>> just a single shared sparsemask, which is why I was rambling about moving
>> things to root_domain.
>>
>> Having different locations where sparsemasks are stored is a bit of a
>> pain which I'd like to avoid, but if it can't be unified I suppose we'll
>> have to live with it.
> 
> I don't follow.  A per-LLC sparsemask representing misfits can be allocated with
> one more line in sd_llc_alloc, and you can steal across LLC using the list I
> briefly described above.
> 

Ah yes, that would work. Thing is, I had excluded having the misfit masks
being in the sd_llc_shareds, since from a logical standpoint they don't
really belong there.

With asymmetric CPU capacities we kind of disregard the cache landscape
and focus on, well, CPU asymmetries. There's a few commits laying around
that forgo some cache usage optimisations for asymmetric systems -
this one comes to mind:

    9c63e84db29b ("sched/core: Disable SD_PREFER_SIBLING on asymmetric CPU capacity domains")

So in truth I was envisioning separate SD_ASYM_CPUCAPACITY-based 
sparsemasks, which is why I was rambling about SD_ASYM_CPUCAPACITY siblings
of sd_llc_*()... *But* after I had a go at it, it looked to me like that
was a lot of duplicated code.

My root_domain suggestion stems from the fact that we only really need one
single sparsemask for misfit stealing, and it provides a unique location
to store the sparsemasks (and you mask them however you want when it comes
to using them).

Sadly I think that doesn't work as well for cfs_overload_cpus since you
can't split a sparsemask's chunks over several NUMA nodes, so we'd be
stuck with an allocation on a single node (but we already do that in some
places, e.g. for nohz.idle_cpus_mask, so... Is it that bad?).

> - Steve
> 
