Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B36DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277BD2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XjC9FFBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BD2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeKOJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:22:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:22:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAENEGNR030766;
        Wed, 14 Nov 2018 23:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/HqmEyxnUILXu2NMx4O7kU1g0ONLMSoBFwTTFZtadFA=;
 b=XjC9FFBMaJ6K8X7DFiovkpmAZKQNKT40lC/YhdKk3xDO39jk4X7jDwcNosQMrJbl/zxr
 Xl+tDSujlYkdAheAvdI/NDgn4lqXN2+yDKgavCSV+wgCtOnvv/RXNaGe89M4xdIMeDPH
 eEC3dxbJyfiucPmtiVBAo0iOlk7C3ss/UzTnT5t39+aTkhzqfoqmZb5eQkC0/LALUopN
 +ZgVD3I+WsTiAi351Dbrh7ZfCsDkeR0uYNcyiVCVjce9wvI2ZzSY3InwQe9RdQY2p/du
 KvkjqpavZKoHicaXL/tsCSt2WCGnufgUlmNuntuhY8J/uFTtCneF/8NgmXFP6c3z1HUs eQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nr7cs6fmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 23:15:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAENFdH2007756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 23:15:39 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAENFalL025154;
        Wed, 14 Nov 2018 23:15:36 GMT
Received: from [10.39.242.107] (/10.39.242.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 15:15:36 -0800
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mhocko@kernel.org, minchan@kernel.org, peterz@infradead.org,
        rientjes@google.com, vbabka@suse.cz, willy@infradead.org,
        ying.huang@intel.com, nitingupta910@gmail.com
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109195150.GA24747@redhat.com>
 <20181110132249.GH23260@techsingularity.net>
 <20181110164412.GB22642@redhat.com>
From:   anthony.yznaga@oracle.com
Organization: Oracle Corporation
Message-ID: <3310b7c3-4bcf-3378-e567-1c9200061c25@oracle.com>
Date:   Wed, 14 Nov 2018 15:15:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181110164412.GB22642@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9077 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2018 08:44 AM, Andrea Arcangeli wrote:
> On Sat, Nov 10, 2018 at 01:22:49PM +0000, Mel Gorman wrote:
>> On Fri, Nov 09, 2018 at 02:51:50PM -0500, Andrea Arcangeli wrote:
>>> And if you're in the camp that is concerned about the use of more RAM
>>> or/and about the higher latency of COW faults, I'm afraid the
>>> intermediate solution will be still slower than the already available
>>> MADV_NOHUGEPAGE or enabled=madvise.
>>>
>> Does that not prevent huge page usage? Maybe you can spell it out a bit
> Yes it prevents huge page usage, but preventing the huge page usage is
> also what is achieved with the reservation.
>
>> better. What is the set of system calls an application should make to
>> not use huge pages either for the address space or on a per-VMA basis
>> and defer to kcompactd? I know that can be tuned globally but that's not
>> quite the same thing given that multiple applications or containers can
>> be running with different requirements.
> Yes, in terms of inheritance that could be used to tune a container
> we've only PR_SET_THP_DISABLE, and that will render MADV_HUGEPAGE
> useless too, but then for microservices that should not be a
> concern. How to make those sysfs tunables reentrant in namespaces is a
> separate issue I think.
>
> The difference is that with the reservation over time they can be
> promoted, with MADV_NOHUGEPAGE they cannot become hugepages later, not
> even khugepaged will scan that vma anymore.
>
> The benefit of the reservation will showup in those regions that will
> not become hugepages, so if you can predict beforehand that those
> ranges don't benefit from THP, it's better if userland calls
> madvise(MADV_NOHUGEPAGE) on the range and then there's no need to undo
> the reservation later during memory pressure.
>
> The reservation and promotion is a bit like auto-detecting when
> MADV_NOHUGEPAGE should be set, so it boils down of how much of a
> corner case that is.
>
> I'm not so concerned about the RAM wasted because I don't think it's
> very significant, after all the application can just do a smaller
> malloc if it wants to reduce memory usage.
>
> A massive amount of huge RAM waste is fairly rare and to the extreme
> it could still be wasted even with 4k if the app uses only 1 bit from
> every 4k page it allocates with malloc.
>
> I'm more concerned about cases where THP is wasting CPU: like in redis
> that is hurted by the 2M COWs. redis will map all pages and they will
> be all promoted to THP also with the reservation logic applied, but
> when the parent writes to the memory (after fork) it must trigger 4k
> cows (not 2M cows) and in turn split the THP before the COW, or it
> won't work as fast as with THP disabled. In addition we should try to
> reuse the same IPI for the transhuge pmd split to cover the COW too.
>
> If we add the reservation and that work makes zero difference for the
> redis corner case, and redis must still use MADV_NOHUGEPAGE, it's not
> great in my view. It looks like we're trying to optimize issues that
> are less critical.
>
> The redis+THP case should be possible to optimize later with uffd WP
> model (once completed, Peter Xu is working on it), and uffd WP will
> also remove fork() and it'll convert it to a clone(). The granularity
> of the fault is decided by the userland that way so when uffd
> wrprotects a 4k fragment of a THP, the THP will be split during the
> uffd mprotect ioctl.
>
>>> Now about the implementation: the whole point of the reservation
>>> complexity is to skip the khugepaged copy, so it can collapse in
>>> place. Is skipping the copy worth it? Isn't the big cost the IPI
>>> anyway to avoid leaving two simultaneous TLB mappings of different
>>> granularity?
>>>
>> Not necessarily. With THP anon in the simple case, it might be just a
>> single thread and kcompact so that's one IPI (kcompactd flushes local and
>> one IPI to the CPU the thread was running on assuming it's not migrating
>> excessively). It would scale up with the number of threads but I suspect
>> the main cost is the actual copying, page table manipulation and the
>> locking required.
> Agreed, the IPI wouldn't be a concern for a single threaded app. I was
> looking more at the worst case scenario. For a single threaded app the
> locking should not be too bad either.
>
>> As an aside, a universal benefit would be looking at reducing the time
>> to allocate the necessary huge page as we know that can be excessive. It
>> would be ortogonal to this series.
> With what I suggested the allocation would happen as usual in
> khugepaged at slow peace, without holding locks. So I don't see
> obvious disadvantages in terms of THP allocation latency.
>
>> Could you and Kirill outline what sort of workloads you would consider
>> acceptable for evaluating this series? One would assume it covers at
>> least the following, potentially with a number of workloads.
> I would prefer to add intelligence to detect when COWs after fork
> should be done at 2m or 4k granularity (in the latter case by
> splitting the pmd before the actual COW while leaving the transhuge
> pmd intact in the other mm), because that would save CPU (and it'd
> automatically optimize redis). The snapshot process especially would
> run faster as it will read with THP performance.
And presumably to maintain the performance benefit in subsequent
snapshots the original split PMD would need to be re-promoted
prior to forking or promoted in the child during fork?

>
> I'm more worried to ensure THP doesn't cause more CPU usage like it
> happens to the above case in COWs, than to just try to save RAM when
> the virtual ranges are only partially utilized by the app.
>
>> 1. Evaluate the collapse and copying costs (probing the entire time
>>    spent in collapse_huge_page might do it)
>> 2. Evaluate mmap_sem hold time during hugepage collapse
>> 3. Estimate excessive RAM use due to unnecessary THP usage
>> 4. Estimate the slowdown due to delayed THP usage 
>>
>> 1 and 2 would indicate how much time is lost due to not using
>> reservations. That potentially goes in the direction of simply making
>> this faster -- fragmentation reduction (posted but unreviewed), faster
>> compaction searches, better page isolation during compaction to
>> avoid free pages being reused before an order-9 is free.
>>
>> 3 should be straight-forward but 4 would be the hardest to evaluate
>> because it would have to be determimed if 4 is offset by improvements to
>> 1-3. If 1-3 is improved enough, it might remove the motivation for the
>> series entirely.
>>
>> In other words, if we agree on a workload in advance, it might bring
>> this the right direction and not accidentally throw Anthony down a hole
>> working on a series that never gets ack'd.
>>
>> I'm not necessarily the best person to answer because my natural inclination
>> after the fragmentation series would be to keep using thpfiosacle
>> (from the fragmentation avoidance series) and work on improving the THP
>> allocation success rates and reduce latencies. I've tunnel vision on that
>> for the moment.
> Deciding the workloads is a good question indeed, but I would also be
> curious to how many of those pages would not end up to be promoted
> with this logic.
>
> What's the number of pte_none that you require in each pmd to avoid
> promotion? If it's just 1 then apps will run slower, if there's
> partial utilization THP already helps. I've an hard time to think at
> an ideal ratio, this is why max_ptes_none is 511 after all.
>
> Can we start by counting the total number of pte_none() in all pmds
> that can fit a THP according to vma->vm_start/end? The pagetable
> dumper in debugfs may already provide the info we need by scanning all
> mm and by printing the number of "none" pte that would generate
> "wasted" memory (and marginally wasted CPU during copy/clear).
>
> Then you can exactly tell how many pmds won't be promoted to transhuge
> pmds with the patch applied in the real life workloads, even before
> running any benchmark. It'd be good to be sure we're talking about a
> significant number in real life workloads or there's not much to
> optimize to begin with.
>
> If the amount of RAM saved is significant in real life workloads and
> in turn there's a chance of having a worthwhile tradeoff from the
> reservation logic, then we can do the benchmarks because the behavior
> will be different for the page fault, and it'll end up running slower
> with the reservation logic.

Thank you, Andrea and Mel, for the feedback.  I really appreciate it.
I'm going to proceed as suggested and evaluate the huge page
collapse and copy costs and perform more analysis on the potential
RAM savings.

Anthony

>
> Thanks,
> Andrea

