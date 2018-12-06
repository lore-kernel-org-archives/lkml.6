Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04A9C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8635920850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8635920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeLFR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:28:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbeLFR2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:28:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B46580D;
        Thu,  6 Dec 2018 09:28:41 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2653F5AF;
        Thu,  6 Dec 2018 09:28:39 -0800 (PST)
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
 <094f54a9-a6ec-3c0d-4e06-6572023963c6@arm.com>
 <2e1f4d52-8ac6-04a3-c453-1679ef3df0e7@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c872ddfb-eb12-e293-7ade-ef602ac45b1c@arm.com>
Date:   Thu, 6 Dec 2018 17:28:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2e1f4d52-8ac6-04a3-c453-1679ef3df0e7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 06/12/2018 16:40, Steven Sistare wrote:
> [...]
>>
>> Ah yes, that would work. Thing is, I had excluded having the misfit masks
>> being in the sd_llc_shareds, since from a logical standpoint they don't
>> really belong there.
>>
>> With asymmetric CPU capacities we kind of disregard the cache landscape
> 
> Sure, but adding awareness of the cache hierarchy can only make it better,
> and a per-LLC mask organization can serve both the overloaded and misfit
> use cases quite naturally.
> [...]
>> So in truth I was envisioning separate SD_ASYM_CPUCAPACITY-based 
>> sparsemasks, which is why I was rambling about SD_ASYM_CPUCAPACITY siblings
>> of sd_llc_*()... *But* after I had a go at it, it looked to me like that
>> was a lot of duplicated code.
> 
> I would be happy to review your code and make suggestions to reduce duplication,
> and happy to continue to discuss clean and optimal handling for misfits. However, 
> I have a request: can we push my patches across the finish line first?  Stealing 
> for misfits can be its own patch series.  Please consider sending your reviewed-by
> for the next version of my series.  I will send it soon.
> 

Sure, as things stand right now I'm fairly convinced this doesn't harm
asymmetric systems.

The only thing I would add (ignoring misfits) is that with EAS we would
need to gate stealing with something like:

    !static_branch_unlikely(&sched_energy_present) ||
    READ_ONCE(rq->rd->overutilized)

And who "gets" to add this gating (or at least, when must it be added)
depends on which patch-set gets in first.

[...]
>> Sadly I think that doesn't work as well for cfs_overload_cpus since you
>> can't split a sparsemask's chunks over several NUMA nodes, so we'd be
>> stuck with an allocation on a single node (but we already do that in some
>> places, e.g. for nohz.idle_cpus_mask, so... Is it that bad?).
> 
> It can be bad for high memory bandwidth workloads, as the sparsemasks will
> be displaced from cache and we incur remote memory latencies on next access.
> 

Aye, I just caught up with the LPC videos and was about to reply here to
say that, all things considered, it's probably not such a good idea...

> - Steve
> 
