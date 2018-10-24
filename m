Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AFAC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75102064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75102064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJXWYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:24:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbeJXWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:24:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF0A7AF3B;
        Wed, 24 Oct 2018 13:56:39 +0000 (UTC)
Date:   Wed, 24 Oct 2018 15:56:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH V3 3/5] mm/hugetlb: Enable arch specific huge page size
 support for migration
Message-ID: <20181024135639.GH18839@dhcp22.suse.cz>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540299721-26484-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-10-18 18:31:59, Anshuman Khandual wrote:
> Architectures like arm64 have HugeTLB page sizes which are different than
> generic sizes at PMD, PUD, PGD level and implemented via contiguous bits.
> At present these special size HugeTLB pages cannot be identified through
> macros like (PMD|PUD|PGDIR)_SHIFT and hence chosen not be migrated.
> 
> Enabling migration support for these special HugeTLB page sizes along with
> the generic ones (PMD|PUD|PGD) would require identifying all of them on a
> given platform. A platform specific hook can precisely enumerate all huge
> page sizes supported for migration. Instead of comparing against standard
> huge page orders let hugetlb_migration_support() function call a platform
> hook arch_hugetlb_migration_support(). Default definition for the platform
> hook maintains existing semantics which checks standard huge page order.
> But an architecture can choose to override the default and provide support
> for a comprehensive set of huge page sizes.
> 
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Michal Hocko <mhocko@use.com>

> ---
>  include/linux/hugetlb.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 70bcd89..4cc3871 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -493,18 +493,29 @@ static inline pgoff_t basepage_index(struct page *page)
>  extern int dissolve_free_huge_page(struct page *page);
>  extern int dissolve_free_huge_pages(unsigned long start_pfn,
>  				    unsigned long end_pfn);
> -static inline bool hugepage_migration_supported(struct hstate *h)
> -{
> +
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> +#ifndef arch_hugetlb_migration_supported
> +static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
>  	if ((huge_page_shift(h) == PMD_SHIFT) ||
>  		(huge_page_shift(h) == PUD_SHIFT) ||
>  			(huge_page_shift(h) == PGDIR_SHIFT))
>  		return true;
>  	else
>  		return false;
> +}
> +#endif
>  #else
> +static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> +{
>  	return false;
> +}
>  #endif
> +
> +static inline bool hugepage_migration_supported(struct hstate *h)
> +{
> +	return arch_hugetlb_migration_supported(h);
>  }
>  
>  /*
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
