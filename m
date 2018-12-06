Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D132151B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D132151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLFQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:05:00 -0500
Received: from foss.arm.com ([217.140.101.70]:54374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFQFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:05:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC8480D;
        Thu,  6 Dec 2018 08:04:59 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B6643F59C;
        Thu,  6 Dec 2018 08:04:58 -0800 (PST)
Date:   Thu, 6 Dec 2018 16:04:56 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Allen Pais <allen.pais@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <Steve.Capper@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: hugetlb: Register hugepages during arch init
Message-ID: <20181206160455.GK54495@arrakis.emea.arm.com>
References: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that we somehow missed this patch. Cc'ing a few more people
that touched hugetlbpage.c.

Catalin

On Tue, Oct 23, 2018 at 06:36:57AM +0530, Allen Pais wrote:
> Add hstate for each supported hugepage size using arch initcall.
> 
> * no hugepage parameters
> 
>   Without hugepage parameters, only a default hugepage size is
>   available for dynamic allocation.  It's different, for example, from
>   x86_64 and sparc64 where all supported hugepage sizes are available.
> 
> * only default_hugepagesz= is specified and set not to HPAGE_SIZE
> 
>   In spite of the fact that default_hugepagesz= is set to a valid
>   hugepage size, it's treated as unsupported and reverted to
>   HPAGE_SIZE.  Such behaviour is also different from x86_64 and
>   sparc64.
> 
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> Signed-off-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index f58ea50..28cbc22 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -429,6 +429,27 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>  }
>  
> +static void __init add_huge_page_size(unsigned long size)
> +{
> +	if (size_to_hstate(size))
> +		return;
> +
> +	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> +}
> +
> +static int __init hugetlbpage_init(void)
> +{
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	add_huge_page_size(PUD_SIZE);
> +#endif
> +	add_huge_page_size(PMD_SIZE * CONT_PMDS);
> +	add_huge_page_size(PMD_SIZE);
> +	add_huge_page_size(PAGE_SIZE * CONT_PTES);
> +
> +	return 0;
> +}
> +arch_initcall(hugetlbpage_init);
> +
>  static __init int setup_hugepagesz(char *opt)
>  {
>  	unsigned long ps = memparse(opt, &opt);
> @@ -440,7 +461,7 @@ static __init int setup_hugepagesz(char *opt)
>  	case PMD_SIZE * CONT_PMDS:
>  	case PMD_SIZE:
>  	case PAGE_SIZE * CONT_PTES:
> -		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
> +		add_huge_page_size(ps);
>  		return 1;
>  	}
>  
> @@ -449,13 +470,3 @@ static __init int setup_hugepagesz(char *opt)
>  	return 0;
>  }
>  __setup("hugepagesz=", setup_hugepagesz);
> -
> -#ifdef CONFIG_ARM64_64K_PAGES
> -static __init int add_default_hugepagesz(void)
> -{
> -	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
> -		hugetlb_add_hstate(CONT_PTE_SHIFT);
> -	return 0;
> -}
> -arch_initcall(add_default_hugepagesz);
> -#endif
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
