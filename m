Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6F4C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21E4206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21E4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeKTXLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:11:39 -0500
Received: from foss.arm.com ([217.140.101.70]:48294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTXLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:11:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB7C80D;
        Tue, 20 Nov 2018 04:42:41 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3D53F5B7;
        Tue, 20 Nov 2018 04:42:39 -0800 (PST)
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7d9b6789-af17-bcab-e52d-7e05483e10ea@arm.com>
Date:   Tue, 20 Nov 2018 12:42:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0857925d-a24e-90ea-e28c-90d69b2f66dd@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2018 17:33, Steven Sistare wrote:
[...]
>>
>> Thinking about misfit stealing, we can't use the sd_llc_shared's because
>> on big.LITTLE misfit migrations happen across LLC domains.
>>
>> I was thinking of adding a misfit sparsemask to the root_domain, but
>> then I thought we could do the same thing for cfs_overload_cpus.
>>
>> By doing so we'd have a single source of information for overloaded CPUs,
>> and we could filter that down during idle balance - you mentioned earlier
>> wanting to try stealing at each SD level. This would also let you get
>> rid of [PATCH 02].
>>
>> The main part of try_steal() could then be written down as something like
>> this:
>>
>> ----->8-----
>>
>> for_each_domain(this_cpu, sd) {
>> 	span = sched_domain_span(sd)
>> 		
>> 	for_each_sparse_wrap(src_cpu, overload_cpus) {
>> 		if (cpumask_test_cpu(src_cpu, span) &&
>> 		    steal_from(dts_rq, dst_rf, &locked, src_cpu)) {
>> 			stolen = 1;
>> 			goto out;
>> 		}
>> 	}
>> }
>>
>> ------8<-----
>>
>> We could limit the stealing to stop at the highest SD_SHARE_PKG_RESOURCES
>> domain for now so there would be no behavioural change - but we'd
>> factorize the #ifdef SCHED_SMT bit. Furthermore, the door would be open
>> to further stealing.
>>
>> What do you think?
> 
> That is not efficient for a multi-level search because at each domain level we 
> would (re) iterate over overloaded candidates that do not belong in that level.


Mmm I was thinking we could abuse the wrap() and start at
(fls(prev_span) + 1), but we're not guaranteed to have contiguous spans -
the Arm Juno for instance has [0, 3, 4], [1, 2] as MC-level domains, so
that goes down the drain.

Another thing that has been trotting in my head would be some helper to
create a cpumask from a sparsemask (some sort of sparsemask_span()),
which would let us use the standard mask operators:

----->8-----
struct cpumask *overload_span = sparsemask_span(overload_cpus)

for_each_domain(this_cpu, sd)
	for_each_cpu_and(src_cpu, overload_span, sched_domain_span(sd))
		<steal_from here>
-----8>-----

The cpumask could be part of the sparsemask struct to save us the
allocation, and only updated when calling sparsemask_span().

> To extend stealing across LLC, I would like to keep the per-LLC sparsemask, 
> but add to each SD a list of sparsemask pointers.  The list nodes would be
> private, but the sparsemask structs would be shared.  Each list would include
> the masks that overlap the SD's members.  The list would be a singleton at the
> core and LLC levels (same as the socket level for most processors), and would 
> have multiple elements at the NUMA level.
> 

I see. As for misfit, creating asym_cpucapacity siblings of the sd_llc_*()
functions seems a bit much - there'd be a lot of redundancy for basically
just a single shared sparsemask, which is why I was rambling about moving
things to root_domain.

Having different locations where sparsemasks are stored is a bit of a
pain which I'd like to avoid, but if it can't be unified I suppose we'll
have to live with it.

> - Steve
> 
