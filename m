Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE13C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A65214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A65214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJIUe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:34:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJIUe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:34:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F05C87A9;
        Tue,  9 Oct 2018 06:18:04 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C142A3F5B3;
        Tue,  9 Oct 2018 06:18:04 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 1A5B71AE0876; Tue,  9 Oct 2018 14:18:04 +0100 (BST)
Date:   Tue, 9 Oct 2018 14:18:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, mhocko@suse.com, zi.yan@cs.rutgers.edu
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Message-ID: <20181009131803.GH6248@arm.com>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 04:04:21PM +0300, Kirill A. Shutemov wrote:
> On Tue, Oct 09, 2018 at 09:28:58AM +0530, Anshuman Khandual wrote:
> > A normal mapped THP page at PMD level should be correctly differentiated
> > from a PMD migration entry while walking the page table. A mapped THP would
> > additionally check positive for pmd_present() along with pmd_trans_huge()
> > as compared to a PMD migration entry. This just adds a new conditional test
> > differentiating the two while walking the page table.
> > 
> > Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
> > exclusive which makes the current conditional block work for both mapped
> > and migration entries. This is not same with arm64 where pmd_trans_huge()
> > returns positive for both mapped and migration entries. Could some one
> > please explain why pmd_trans_huge() has to return false for migration
> > entries which just install swap bits and its still a PMD ?
> 
> I guess it's just a design choice. Any reason why arm64 cannot do the
> same?

Anshuman, would it work to:

#define pmd_trans_huge(pmd)     (pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))

?

> > Nonetheless pmd_present() seems to be a better check to distinguish
> > between mapped and (non-mapped non-present) migration entries without
> > any ambiguity.
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

I'd much rather have portable semantics for pmd_trans_huge(), if we can
achieve that efficiently. But that would be fast /and/ correct, so perhaps
I'm being too hopeful :)

Will
