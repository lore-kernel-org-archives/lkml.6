Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23CC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1120862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bOA5uSLw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UUmOFw+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D1120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeKFSxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:53:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:32990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeKFSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:53:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AD2E60ADB; Tue,  6 Nov 2018 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541496539;
        bh=fhMDKdz2qkpoWmcUijENRWLwS+4ODTCiGk3VV+6kj+U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bOA5uSLw9J8VDoXcK5YpKTq5RMstoKZD0x5UhmEM8BoD6tsxegV0OS7iwQUr1O4zw
         WunWSIepLxIPILS8bPxNoh972IwUFDDYObxGkXWiber4NMRIyqr1UcjmP9tC8/0y+J
         yhWfsAkkq0FLZnqKXR+O7m6mSACtCxYMRoVpRzaQ=
Received: from [10.204.82.21] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vinmenon@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B13760247;
        Tue,  6 Nov 2018 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541496536;
        bh=fhMDKdz2qkpoWmcUijENRWLwS+4ODTCiGk3VV+6kj+U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UUmOFw+Hgn7TaSHyImnZx0o/GBxDs6YraaxCayZeruSJLBWu8RsGSMDa3ZLOxt0ED
         C0cAL6OveiDa7kQ0wJNAhY0RdHx/Pc2TaKoHYuXr1Q2UtTFMa+ExxEAFCJRe9qx9aF
         3BR3N1pAfAqOo8TLrjFc6QqtL+f9VGWIH6Sq4pyk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B13760247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vinmenon@codeaurora.org
Subject: Re: [PATCH v11 10/26] mm: protect VMA modifications using VMA
 sequence count
To:     Laurent Dufour <ldufour@liunx.vnet.ibm.com>,
        vinayak menon <vinayakm.list@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kirill@shutemov.name,
        ak@linux.intel.com, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>, punitagrawal@gmail.com,
        yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, haren@linux.vnet.ibm.com, npiggin@gmail.com,
        Balbir Singh <bsingharora@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1526555193-7242-11-git-send-email-ldufour@linux.vnet.ibm.com>
 <CAOaiJ-nJ_=+diXz8ji42Rro3Mj16C1=NpenRuY3-mjs_GhR4mA@mail.gmail.com>
 <239bab9c-e38c-951d-9114-34227b1dc94c@liunx.vnet.ibm.com>
From:   Vinayak Menon <vinmenon@codeaurora.org>
Message-ID: <836276ba-5063-4d65-4649-480c8bd31c45@codeaurora.org>
Date:   Tue, 6 Nov 2018 14:58:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <239bab9c-e38c-951d-9114-34227b1dc94c@liunx.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 11:52 PM, Laurent Dufour wrote:
> Le 05/11/2018 à 08:04, vinayak menon a écrit :
>> Hi Laurent,
>>
>> On Thu, May 17, 2018 at 4:37 PM Laurent Dufour
>> <ldufour@linux.vnet.ibm.com> wrote:
>>>
>>> The VMA sequence count has been introduced to allow fast detection of
>>> VMA modification when running a page fault handler without holding
>>> the mmap_sem.
>>>
>>> This patch provides protection against the VMA modification done in :
>>>          - madvise()
>>>          - mpol_rebind_policy()
>>>          - vma_replace_policy()
>>>          - change_prot_numa()
>>>          - mlock(), munlock()
>>>          - mprotect()
>>>          - mmap_region()
>>>          - collapse_huge_page()
>>>          - userfaultd registering services
>>>
>>> In addition, VMA fields which will be read during the speculative fault
>>> path needs to be written using WRITE_ONCE to prevent write to be split
>>> and intermediate values to be pushed to other CPUs.
>>>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>> ---
>>>   fs/proc/task_mmu.c |  5 ++++-
>>>   fs/userfaultfd.c   | 17 +++++++++++++----
>>>   mm/khugepaged.c    |  3 +++
>>>   mm/madvise.c       |  6 +++++-
>>>   mm/mempolicy.c     | 51 ++++++++++++++++++++++++++++++++++-----------------
>>>   mm/mlock.c         | 13 ++++++++-----
>>>   mm/mmap.c          | 22 +++++++++++++---------
>>>   mm/mprotect.c      |  4 +++-
>>>   mm/swap_state.c    |  8 ++++++--
>>>   9 files changed, 89 insertions(+), 40 deletions(-)
>>>
>>>   struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>>                                  struct vm_fault *vmf)
>>> @@ -665,9 +669,9 @@ static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
>>>                                       unsigned long *start,
>>>                                       unsigned long *end)
>>>   {
>>> -       *start = max3(lpfn, PFN_DOWN(vma->vm_start),
>>> +       *start = max3(lpfn, PFN_DOWN(READ_ONCE(vma->vm_start)),
>>>                        PFN_DOWN(faddr & PMD_MASK));
>>> -       *end = min3(rpfn, PFN_DOWN(vma->vm_end),
>>> +       *end = min3(rpfn, PFN_DOWN(READ_ONCE(vma->vm_end)),
>>>                      PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
>>>   }
>>>
>>> -- 
>>> 2.7.4
>>>
>>
>> I have got a crash on 4.14 kernel with speculative page faults enabled
>> and here is my analysis of the problem.
>> The issue was reported only once.
>
> Hi Vinayak,
>
> Thanks for reporting this.
>
>>
>> [23409.303395]  el1_da+0x24/0x84
>> [23409.303400]  __radix_tree_lookup+0x8/0x90
>> [23409.303407]  find_get_entry+0x64/0x14c
>> [23409.303410]  pagecache_get_page+0x5c/0x27c
>> [23409.303416]  __read_swap_cache_async+0x80/0x260
>> [23409.303420]  swap_vma_readahead+0x264/0x37c
>> [23409.303423]  swapin_readahead+0x5c/0x6c
>> [23409.303428]  do_swap_page+0x128/0x6e4
>> [23409.303431]  handle_pte_fault+0x230/0xca4
>> [23409.303435]  __handle_speculative_fault+0x57c/0x7c8
>> [23409.303438]  do_page_fault+0x228/0x3e8
>> [23409.303442]  do_translation_fault+0x50/0x6c
>> [23409.303445]  do_mem_abort+0x5c/0xe0
>> [23409.303447]  el0_da+0x20/0x24
>>
>> Process A accesses address ADDR (part of VMA A) and that results in a
>> translation fault.
>> Kernel enters __handle_speculative_fault to fix the fault.
>> Process A enters do_swap_page->swapin_readahead->swap_vma_readahead
>> from speculative path.
>> During this time, another process B which shares the same mm, does a
>> mprotect from another CPU which follows
>> mprotect_fixup->__split_vma, and it splits VMA A into VMAs A and B.
>> After the split, ADDR falls into VMA B, but process A is still using
>> VMA A.
>> Now ADDR is greater than VMA_A->vm_start and VMA_A->vm_end.
>> swap_vma_readahead->swap_ra_info uses start and end of vma to
>> calculate ptes and nr_pte, which goes wrong due to this and finally
>> resulting in wrong "entry" passed to
>> swap_vma_readahead->__read_swap_cache_async, and in turn causing
>> invalid swapper_space
>> being passed to __read_swap_cache_async->find_get_page, causing an abort.
>>
>> The fix I have tried is to cache vm_start and vm_end also in vmf and
>> use it in swap_ra_clamp_pfn. Let me know your thoughts on this. I can
>> send
>> the patch I am a using if you feel that is the right thing to do.
>
> I think the best would be to don't do swap readahead during the speculatvive page fault. If the page is found in the swap cache, that's fine, but otherwise, we should f    allback to the regular page fault.
>
> The attached -untested- patch is doing this, if you want to give it a try. I'll review that for the next series.
>

Thanks Laurent. I and going to try this patch.

With this patch, since all non-SWP_SYNCHRONOUS_IO swapins result in non-speculative fault
and a retry, wouldn't this have an impact on some perf numbers ? If so, would caching start
and end be a better option ?

Also, would it make sense to move the FAULT_FLAG_SPECULATIVE check inside swapin_readahead,
in a way that  swap_cluster_readahead can take the speculative path ? swap_cluster_readahead
doesn't seem to use vma values.

Thanks,
Vinayak
