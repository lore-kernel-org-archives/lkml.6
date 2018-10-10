Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E2D2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E2D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeJJLZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:25:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJLZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:25:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B705E7A9;
        Tue,  9 Oct 2018 21:05:41 -0700 (PDT)
Received: from [10.163.1.248] (unknown [10.163.1.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 200453F5BC;
        Tue,  9 Oct 2018 21:05:38 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, will.deacon@arm.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <84509db4-13ce-fd53-e924-cc4288d493f7@arm.com>
Date:   Wed, 10 Oct 2018 09:35:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 07:28 PM, Zi Yan wrote:
> cc: Naoya Horiguchi (who proposed to use !_PAGE_PRESENT && !_PAGE_PSE for x86
> PMD migration entry check)
> 
> On 8 Oct 2018, at 23:58, Anshuman Khandual wrote:
> 
>> A normal mapped THP page at PMD level should be correctly differentiated
>> from a PMD migration entry while walking the page table. A mapped THP would
>> additionally check positive for pmd_present() along with pmd_trans_huge()
>> as compared to a PMD migration entry. This just adds a new conditional test
>> differentiating the two while walking the page table.
>>
>> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
>> exclusive which makes the current conditional block work for both mapped
>> and migration entries. This is not same with arm64 where pmd_trans_huge()
> 
> !pmd_present() && pmd_trans_huge() is used to represent THPs under splitting,

Not really if we just look at code in the conditional blocks.

> since _PAGE_PRESENT is cleared during THP splitting but _PAGE_PSE is not.
> See the comment in pmd_present() for x86, in arch/x86/include/asm/pgtable.h


        if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
                pvmw->ptl = pmd_lock(mm, pvmw->pmd);
                if (likely(pmd_trans_huge(*pvmw->pmd))) {
                        if (pvmw->flags & PVMW_MIGRATION)
                                return not_found(pvmw);
                        if (pmd_page(*pvmw->pmd) != page)
                                return not_found(pvmw);
                        return true;
                } else if (!pmd_present(*pvmw->pmd)) {
                        if (thp_migration_supported()) {
                                if (!(pvmw->flags & PVMW_MIGRATION))
                                        return not_found(pvmw);
                                if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
                                        swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);

                                        if (migration_entry_to_page(entry) != page)
                                                return not_found(pvmw);
                                        return true;
                                }
                        }
                        return not_found(pvmw);
                } else {
                        /* THP pmd was split under us: handle on pte level */
                        spin_unlock(pvmw->ptl);
                        pvmw->ptl = NULL;
                }
        } else if (!pmd_present(pmde)) { ---> Outer 'else if'
                return false;
        }

Looking at the above code, it seems the conditional check for a THP
splitting case would be (!pmd_trans_huge && pmd_present) instead as
it has skipped the first two conditions. But THP splitting must have
been initiated once it has cleared the outer check (else it would not
have cleared otherwise)

if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)).


BTW what PMD state does the outer 'else if' block identify which must
have cleared the following condition to get there.

(!pmd_present && !pmd_trans_huge && !is_pmd_migration_entry)
