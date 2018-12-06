Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC277C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648BC20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MT5iidYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648BC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLFQkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:40:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:40:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6GcfoX150924;
        Thu, 6 Dec 2018 16:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hcGID0YAOFO6Leph6qb9RHrkVFHTLZwaAWe4lzo3F1s=;
 b=MT5iidYHo4Ih86fSbBtIooLq2O66b1ZOP4oThwmOM9fMf8qh4cQi3jN9tRHGBkfTDHBw
 8AmN8erPttv7CpjbVB6tI+afXozMZ+obw20drl919dL1KbeK0NrnfqiIgIrIEHc5wUN7
 I9SHggxoDd8BoaYUdMQLldROpNkVElkvpYTF5NPAVb/extbH37JHya1/LNQP3PlVbnKK
 aOdSJgQhB4C+2PZU2MuYueJ2t8f8AvgOFaFWGqrMSxo1zF2GtcyF/AIfG+xWa+B2rAz8
 BRKy1wGcaJOj9wE/GbUWpmxBi4OGhTGYqAtGcjpS4e+lo0WW0Xha+r/5u5S1DrBUEH7g PA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqu9cdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 16:40:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB6GeDFo031534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 16:40:13 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB6GeDxx000850;
        Thu, 6 Dec 2018 16:40:13 GMT
Received: from [10.39.209.220] (/10.39.209.220)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 08:40:13 -0800
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
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
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <2e1f4d52-8ac6-04a3-c453-1679ef3df0e7@oracle.com>
Date:   Thu, 6 Dec 2018 11:40:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <094f54a9-a6ec-3c0d-4e06-6572023963c6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/2018 11:56 AM, Valentin Schneider wrote:
> Hi Steve,
> On 26/11/2018 19:06, Steven Sistare wrote:
>> [...]
>>> Mmm I was thinking we could abuse the wrap() and start at
>>> (fls(prev_span) + 1), but we're not guaranteed to have contiguous spans -
>>> the Arm Juno for instance has [0, 3, 4], [1, 2] as MC-level domains, so
>>> that goes down the drain.
>>>
>>> Another thing that has been trotting in my head would be some helper to
>>> create a cpumask from a sparsemask (some sort of sparsemask_span()),
>>> which would let us use the standard mask operators:
>>>
>>> ----->8-----
>>> struct cpumask *overload_span = sparsemask_span(overload_cpus)
>>>
>>> for_each_domain(this_cpu, sd)
>>> 	for_each_cpu_and(src_cpu, overload_span, sched_domain_span(sd))
>>> 		<steal_from here>
>>> -----8>-----
>>>
>>> The cpumask could be part of the sparsemask struct to save us the
>>> allocation, and only updated when calling sparsemask_span().
>>
>> I thought of providing something like this along with other sparsemask
>> utility functions, but I decided to be minimalist, and let others add
>> more functions if/when they become needed.  this_cpu_cpumask_var_ptr(select_idle_mask) 
>> is a temporary that could be used as the destination of the conversion.
>>
>> Also, conversion adds cost, particularly on larger systems.  When comparing a
>> cpumask and a sparsemask, it is more efficient to iterate over the smaller
>> set, and test for membership in the larger, such as in try_steal:
>>
>>     for_each_cpu(src_cpu, cpu_smt_mask(dst_cpu)) {
>>             if (sparsemask_test_elem(src_cpu, overload_cpus)
>>  
>>>> To extend stealing across LLC, I would like to keep the per-LLC sparsemask, 
>>>> but add to each SD a list of sparsemask pointers.  The list nodes would be
>>>> private, but the sparsemask structs would be shared.  Each list would include
>>>> the masks that overlap the SD's members.  The list would be a singleton at the
>>>> core and LLC levels (same as the socket level for most processors), and would 
>>>> have multiple elements at the NUMA level.
>>>
>>> I see. As for misfit, creating asym_cpucapacity siblings of the sd_llc_*()
>>> functions seems a bit much - there'd be a lot of redundancy for basically
>>> just a single shared sparsemask, which is why I was rambling about moving
>>> things to root_domain.
>>>
>>> Having different locations where sparsemasks are stored is a bit of a
>>> pain which I'd like to avoid, but if it can't be unified I suppose we'll
>>> have to live with it.
>>
>> I don't follow.  A per-LLC sparsemask representing misfits can be allocated with
>> one more line in sd_llc_alloc, and you can steal across LLC using the list I
>> briefly described above.
> 
> Ah yes, that would work. Thing is, I had excluded having the misfit masks
> being in the sd_llc_shareds, since from a logical standpoint they don't
> really belong there.
> 
> With asymmetric CPU capacities we kind of disregard the cache landscape

Sure, but adding awareness of the cache hierarchy can only make it better,
and a per-LLC mask organization can serve both the overloaded and misfit
use cases quite naturally.

> and focus on, well, CPU asymmetries. There's a few commits laying around
> that forgo some cache usage optimisations for asymmetric systems -
> this one comes to mind:
> 
>     9c63e84db29b ("sched/core: Disable SD_PREFER_SIBLING on asymmetric CPU capacity domains")
> 
> So in truth I was envisioning separate SD_ASYM_CPUCAPACITY-based 
> sparsemasks, which is why I was rambling about SD_ASYM_CPUCAPACITY siblings
> of sd_llc_*()... *But* after I had a go at it, it looked to me like that
> was a lot of duplicated code.

I would be happy to review your code and make suggestions to reduce duplication,
and happy to continue to discuss clean and optimal handling for misfits. However, 
I have a request: can we push my patches across the finish line first?  Stealing 
for misfits can be its own patch series.  Please consider sending your reviewed-by
for the next version of my series.  I will send it soon.

> My root_domain suggestion stems from the fact that we only really need one
> single sparsemask for misfit stealing, and it provides a unique location
> to store the sparsemasks (and you mask them however you want when it comes
> to using them).
> 
> Sadly I think that doesn't work as well for cfs_overload_cpus since you
> can't split a sparsemask's chunks over several NUMA nodes, so we'd be
> stuck with an allocation on a single node (but we already do that in some
> places, e.g. for nohz.idle_cpus_mask, so... Is it that bad?).

It can be bad for high memory bandwidth workloads, as the sparsemasks will
be displaced from cache and we incur remote memory latencies on next access.

- Steve
