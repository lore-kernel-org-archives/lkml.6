Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE568C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AB620870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tQ50ZO0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAWO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:26:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36432 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfAWO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:26:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NEO5Bj058309;
        Wed, 23 Jan 2019 14:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3/BHDXBDjwaMslYodL58H902nHYtHgdrjeSHAL9Rim4=;
 b=tQ50ZO0mMFU/r47bPEQw09c+k8zRY002JWSjxdoFz6jjfI2kVAe4dtv/Oa9NMJ3LNuJA
 gfKMxVe0/l67rEURRsAA7nMGmQFg1affh+xbZs1Z23E/FsDe3lrb59pgZsu4deTnt2x3
 H9lMuiHBKZWm1uU3k+oWUfumK5HLfchyj6ZsuFCp66e/DEygmkvc0ieRfH8CnPMn9J68
 IPWyPOeb2tvs2g7AXVFOu2uilgkqGXcwul1xpzCXlzYIWnWqx8nMf+RAogbiTzZ6OrqH
 qoXHgRb8QtRllcVjNZb/Wyi21NztmuUommixCTz9WTbS2KsdYXkY+ojtTyEjKnrWzKN4 EQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q3sdej9fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:25:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEP9f5017026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:25:09 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEP6wA014770;
        Wed, 23 Jan 2019 14:25:06 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 06:25:05 -0800
Date:   Wed, 23 Jan 2019 09:24:13 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tycho Andersen <tycho@docker.com>
Subject: Re: [RFC PATCH v7 05/16] arm64/mm: Add support for XPFO
Message-ID: <20190123142410.GC19289@Konrads-MacBook-Pro.local>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <89f03091af87f5ab27bd6cafb032236d5bd81d65.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f03091af87f5ab27bd6cafb032236d5bd81d65.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:09:37PM -0700, Khalid Aziz wrote:
> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> Enable support for eXclusive Page Frame Ownership (XPFO) for arm64 and
> provide a hook for updating a single kernel page table entry (which is
> required by the generic XPFO code).
> 
> v6: use flush_tlb_kernel_range() instead of __flush_tlb_one()
> 
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  arch/arm64/Kconfig     |  1 +
>  arch/arm64/mm/Makefile |  2 ++
>  arch/arm64/mm/xpfo.c   | 58 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 arch/arm64/mm/xpfo.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..f0a9c0007d23 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -171,6 +171,7 @@ config ARM64
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select ARCH_SUPPORTS_XPFO
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index 849c1df3d214..cca3808d9776 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -12,3 +12,5 @@ KASAN_SANITIZE_physaddr.o	+= n
>  
>  obj-$(CONFIG_KASAN)		+= kasan_init.o
>  KASAN_SANITIZE_kasan_init.o	:= n
> +
> +obj-$(CONFIG_XPFO)		+= xpfo.o
> diff --git a/arch/arm64/mm/xpfo.c b/arch/arm64/mm/xpfo.c
> new file mode 100644
> index 000000000000..678e2be848eb
> --- /dev/null
> +++ b/arch/arm64/mm/xpfo.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
> + * Copyright (C) 2016 Brown University. All rights reserved.
> + *
> + * Authors:
> + *   Juerg Haefliger <juerg.haefliger@hpe.com>
> + *   Vasileios P. Kemerlis <vpk@cs.brown.edu>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +
> +#include <asm/tlbflush.h>
> +
> +/*
> + * Lookup the page table entry for a virtual address and return a pointer to
> + * the entry. Based on x86 tree.
> + */
> +static pte_t *lookup_address(unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = pgd_offset_k(addr);
> +	if (pgd_none(*pgd))
> +		return NULL;
> +
> +	pud = pud_offset(pgd, addr);
> +	if (pud_none(*pud))
> +		return NULL;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		return NULL;
> +
> +	return pte_offset_kernel(pmd, addr);
> +}
> +
> +/* Update a single kernel page table entry */
> +inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
> +{
> +	pte_t *pte = lookup_address((unsigned long)kaddr);
> +
> +	set_pte(pte, pfn_pte(page_to_pfn(page), prot));

Thought on the other hand.. what if the page is PMD? Do you really want
to do this?

What if 'pte' is NULL?
> +}
> +
> +inline void xpfo_flush_kernel_tlb(struct page *page, int order)
> +{
> +	unsigned long kaddr = (unsigned long)page_address(page);
> +	unsigned long size = PAGE_SIZE;
> +
> +	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);

Ditto here. You are assuming it is PTE, but it may be PMD or such.
Or worts - the lookup_address could be NULL.

> +}
> -- 
> 2.17.1
> 
