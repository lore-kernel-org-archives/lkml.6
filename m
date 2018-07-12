Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7886A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7886A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeGLHzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:55:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbeGLHzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:55:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC6E0AE54;
        Thu, 12 Jul 2018 07:47:18 +0000 (UTC)
Date:   Thu, 12 Jul 2018 09:47:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/hugetlb: remove gigantic page support for HIGHMEM
Message-ID: <20180712074716.GA32648@dhcp22.suse.cz>
References: <20180711195913.1294-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711195913.1294-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 12:59:13, Mike Kravetz wrote:
> This reverts commit ee8f248d266e ("hugetlb: add phys addr to struct
> huge_bootmem_page")
> 
> At one time powerpc used this field and supporting code. However that
> was removed with commit 79cc38ded1e1 ("powerpc/mm/hugetlb: Add support
> for reserving gigantic huge pages via kernel command line").
> 
> There are no users of this field and supporting code, so remove it.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/hugetlb.h | 3 ---
>  mm/hugetlb.c            | 9 +--------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 36fa6a2a82e3..c39d9170a8a0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -348,9 +348,6 @@ struct hstate {
>  struct huge_bootmem_page {
>  	struct list_head list;
>  	struct hstate *hstate;
> -#ifdef CONFIG_HIGHMEM
> -	phys_addr_t phys;
> -#endif
>  };
>  
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 430be42b6ca1..e39593df050b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2139,16 +2139,9 @@ static void __init gather_bootmem_prealloc(void)
>  	struct huge_bootmem_page *m;
>  
>  	list_for_each_entry(m, &huge_boot_pages, list) {
> +		struct page *page = virt_to_page(m);
>  		struct hstate *h = m->hstate;
> -		struct page *page;
>  
> -#ifdef CONFIG_HIGHMEM
> -		page = pfn_to_page(m->phys >> PAGE_SHIFT);
> -		memblock_free_late(__pa(m),
> -				   sizeof(struct huge_bootmem_page));
> -#else
> -		page = virt_to_page(m);
> -#endif
>  		WARN_ON(page_count(page) != 1);
>  		prep_compound_huge_page(page, h->order);
>  		WARN_ON(PageReserved(page));
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
