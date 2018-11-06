Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A0C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAD420827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeKFJ5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:57:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53636 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbeKFJ5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B078E80D;
        Mon,  5 Nov 2018 16:35:14 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F513F718;
        Mon,  5 Nov 2018 16:35:14 -0800 (PST)
Date:   Tue, 6 Nov 2018 00:35:10 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
Message-ID: <20181106003509.GA27283@brain-police>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
 <84509db4-13ce-fd53-e924-cc4288d493f7@arm.com>
 <1968F276-5D96-426B-823F-38F6A51FB465@cs.rutgers.edu>
 <5e0e772c-7eef-e75c-2921-e80d4fbe8324@arm.com>
 <2398C491-E1DA-4B3C-B60A-377A09A02F1A@cs.rutgers.edu>
 <20181017020930.GN30832@redhat.com>
 <9d9aaf03-617a-d383-7d59-8b98fdd3c1e7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9aaf03-617a-d383-7d59-8b98fdd3c1e7@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:45:00AM +0530, Anshuman Khandual wrote:
> On 10/17/2018 07:39 AM, Andrea Arcangeli wrote:
> > What we need to do during split is an invalidate of the huge TLB.
> > There's no pmd_trans_splitting anymore, so we only clear the present
> > bit in the PTE despite pmd_present still returns true (just like
> > PROT_NONE, nothing new in this respect). pmd_present never meant the
> 
> On arm64, the problem is that pmd_present() is tied with pte_present() which
> checks for PTE_VALID (also PTE_PROT_NONE) but which gets cleared during PTE
> invalidation. pmd_present() returns false just after the first step of PMD
> splitting. So pmd_present() needs to be decoupled from PTE_VALID which is
> same as PMD_SECT_VALID and instead should depend upon a pte bit which sticks
> around like PAGE_PSE as in case of x86. I am working towards a solution.

Could we not just go via a PROT_NONE mapping during the split, instead of
having to allocate a new software bit to treat these invalid ptes as
present?

Will
