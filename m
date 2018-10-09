Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F29C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185B02086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185B02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJIU70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:59:26 -0400
Received: from foss.arm.com ([217.140.101.70]:38094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeJIU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:59:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3A380D;
        Tue,  9 Oct 2018 06:42:25 -0700 (PDT)
Received: from [10.163.1.248] (unknown [10.163.1.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51553F5B7;
        Tue,  9 Oct 2018 06:42:23 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, zi.yan@cs.rutgers.edu, will.deacon@arm.com
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c0a81be1-4734-2ff8-4167-6d5e219008e6@arm.com>
Date:   Tue, 9 Oct 2018 19:12:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 06:34 PM, Kirill A. Shutemov wrote:
> On Tue, Oct 09, 2018 at 09:28:58AM +0530, Anshuman Khandual wrote:
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
>> returns positive for both mapped and migration entries. Could some one
>> please explain why pmd_trans_huge() has to return false for migration
>> entries which just install swap bits and its still a PMD ?
> 
> I guess it's just a design choice. Any reason why arm64 cannot do the
> same?
>
I think probably it can do. I am happy to look into these in detail what
will make pmd_trans_huge() return false on migration entries but it does
not quite sound like a right semantic at the moment.

>> Nonetheless pmd_present() seems to be a better check to distinguish
>> between mapped and (non-mapped non-present) migration entries without
>> any ambiguity.
> 
> Can we instead reverse order of check:
> 
> if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
> 	pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> 	if (!pmd_present(*pvmw->pmd)) {
> 		...
> 	} else if (likely(pmd_trans_huge(*pvmw->pmd))) {
> 		...
> 	} else {
> 		...
> 	}
> ...
> 
> This should cover both imeplementations of pmd_trans_huge().

Yeah it does cover and I have tested it first before proposing the current
patch. The only problem is that the order saves the code :) Having another
reasonable check like pmd_present() prevents it from being broken if the
code block moves around for some reason. But I am happy to do either way.
