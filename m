Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2147C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796242081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796242081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeKBPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:21:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbeKBPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:21:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEAA7A78;
        Thu,  1 Nov 2018 23:15:09 -0700 (PDT)
Received: from [192.168.225.42] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB5C3F71E;
        Thu,  1 Nov 2018 23:15:06 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, will.deacon@arm.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
 <84509db4-13ce-fd53-e924-cc4288d493f7@arm.com>
 <1968F276-5D96-426B-823F-38F6A51FB465@cs.rutgers.edu>
 <5e0e772c-7eef-e75c-2921-e80d4fbe8324@arm.com>
 <2398C491-E1DA-4B3C-B60A-377A09A02F1A@cs.rutgers.edu>
 <20181017020930.GN30832@redhat.com>
Message-ID: <9d9aaf03-617a-d383-7d59-8b98fdd3c1e7@arm.com>
Date:   Fri, 2 Nov 2018 11:45:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017020930.GN30832@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2018 07:39 AM, Andrea Arcangeli wrote:
> Hello Zi,
> 
> On Sun, Oct 14, 2018 at 08:53:55PM -0400, Zi Yan wrote:
>> Hi Andrea, what is the purpose/benefit of making x86’s pmd_present() returns true
>> for a THP under splitting? Does it cause problems when ARM64’s pmd_present()
>> returns false in the same situation?
Thank you Andrea for a such a detailed explanation. It really helped us in
understanding certain subtle details about pmd_present() & pmd_trans_huge().

> 
> !pmd_present means it's a migration entry or swap entry and doesn't
> point to RAM. It means if you do pmd_to_page(*pmd) it will return you
> an undefined result.

Sure but this needs to be made clear some where. Not sure whether its better
just by adding some in-code documentation or enforcing it in generic paths.

> 
> During splitting the physical page is still very well pointed by the
> pmd as long as pmd_trans_huge returns true and you hold the
> pmd_lock.

Agreed, it still does point to a huge page in RAM. So pmd_present() should
just return true in such cases as you have explained above.

> 
> pmd_trans_huge must be true at all times for a transhuge pmd that
> points to a hugepage, or all VM fast paths won't serialize with the

But as Naoya mentioned we should not check for pmd_trans_huge() on swap or
migration entries. If this makes sense, I will be happy to look into this
further and remove/replace pmd_trans_huge() check from affected code paths.

> pmd_lock, that is the only reason why, and it's a very good reason
> because it avoids to take the pmd_lock when walking over non transhuge
> pmds (i.e. when there are no THP allocated).
> 
> Now if we've to keep _PAGE_PSE set and return true in pmd_trans_huge
> at all times, why would you want to make pmd_present return false? How
> could it help if pmd_trans_huge returns true, but pmd_present returns
> false despite pmd_to_page works fine and the pmd is really still
> pointing to the page?

Then what is the difference between pmd_trans_huge() and pmd_present()
if both should return true if the PMD points to a huge page in RAM and
pmd_page() also returns a valid huge page in RAM.

> 
> When userland faults on such pmd !pmd_present it will make the page
> fault take a swap or migration path, but that's the wrong path if the
> pmd points to RAM.
This is a real concern. __handle_mm_fault() does check for a swap entry
(which can only be a migration entry at the moment) and then wait on
till the migration is completed.

                if (unlikely(is_swap_pmd(orig_pmd))) {
                        VM_BUG_ON(thp_migration_supported() &&
                                          !is_pmd_migration_entry(orig_pmd));
                        if (is_pmd_migration_entry(orig_pmd))
                                pmd_migration_entry_wait(mm, vmf.pmd);
                        return 0;
                }

> 
> What we need to do during split is an invalidate of the huge TL> There's no pmd_trans_splitting anymore, so we only clear the present
> bit in the PTE despite pmd_present still returns true (just like
> PROT_NONE, nothing new in this respect). pmd_present never meant the

On arm64, the problem is that pmd_present() is tied with pte_present() which
checks for PTE_VALID (also PTE_PROT_NONE) but which gets cleared during PTE
invalidation. pmd_present() returns false just after the first step of PMD
splitting. So pmd_present() needs to be decoupled from PTE_VALID which is
same as PMD_SECT_VALID and instead should depend upon a pte bit which sticks
around like PAGE_PSE as in case of x86. I am working towards a solution.

> real present bit in the pte was set, it just means the pmd points to
> RAM. It means it doesn't point to swap or migration entry and you can
> do pmd_to_page and it works fine
> We need to invalidate the TLB by clearing the present bit and by
> flushing the TLB before overwriting the transhuge pmd with the regular
> pte (i.e. to make it non huge). That is actually required by an errata
> (l1 cache aliasing of the same mapping through two different TLB of
> two different sizes broke some old CPU and triggered machine checks).
> It's not something fundamentally necessary from a common code point of

TLB entries mapping same VA -> PA space with different pages sizes might
not co-exist with each other which requires TLB invalidation. PMD split
phase initiating a TLB invalidation is not like getting around a CPU HW
problem but its just that SW should not assume behavior on behalf of the
architecture regarding which TLB entries can co-exist at any point.

> view. It's more risky from an hardware (not software) standpoint and
> before you can get rid of the pmd you need to do a TLB flush anyway to
> be sure CPUs stops using it, so better clear the present bit before
> doing the real costly thing (the tlb flush with IPIs). Clearing the
> present bit during the TLB flush is a cost that gets lost in the noise.

Doing TLB invalidation is not tied to whether present bit is marked on
the PTE or not. If I am not mistaken, a TLB invalidation can still get
started on a PTE with it's present bit marked on. IIUC the reason we
clear the present bit on the PMD entry to prevent further MMU HW walk
of the table and creation of new TLB entries reflecting older mapping
while flushing the older ones.

> 
> The clear of the real present bit during pmd (virtual) splitting is
> done with pmdp_invalidate, that is created specifically to keeps
> pmd_trans_huge=true, pmd_present=true despite the present bit is not
> set. So you could imagine _PAGE_PSE as the real present bit.
> 
I understand. In conclusion we would need to make some changes to
pmd_present() and pmd_trans_huge() on arm64 in accordance with the
semantics explained above. pmd_present() is very clear though I am
still wondering how pmd_trans_huge() is different than pmd_present().
