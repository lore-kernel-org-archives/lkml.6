Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04D8460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFFPoT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:44:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeFFPoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:44:16 -0400
Date: Wed, 6 Jun 2018 16:44:48 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 3/3] arm64: Implement page table free interfaces
Message-ID: <20180606154447.GG6631@arm.com>
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528268481-19299-4-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:31:21PM +0530, Chintan Pandya wrote:
> arm64 requires break-before-make. Originally, before
> setting up new pmd/pud entry for huge mapping, in few
> cases, the modifying pmd/pud entry was still valid
> and pointing to next level page table as we only
> clear off leaf PTE in unmap leg.
> 
>  a) This was resulting into stale entry in TLBs (as few
>     TLBs also cache intermediate mapping for performance
>     reasons)
>  b) Also, modifying pmd/pud was the only reference to
>     next level page table and it was getting lost without
>     freeing it. So, page leaks were happening.
> 
> Implement pud_free_pmd_page() and pmd_free_pte_page() to
> enforce BBM and also free the leaking page tables.
> 
> Implementation requires,
>  1) Clearing off the current pud/pmd entry
>  2) Invalidation of TLB
>  3) Freeing of the un-used next level page tables
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)

Thanks, I think this looks really good now:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
