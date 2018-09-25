Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075DBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A273620684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ox0a3r7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeIZCKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:10:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeIZCKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nT9Bbj43/rT4c8I+AWOwCTTawHvyYyP9pNBvgcPEH/0=; b=ox0a3r7qHwxDjwpspkr8tMH3P
        ugiMMfnMHhwtaCkIUQKK52V+j89gBOH1xLkiVfUsfSXgN7Dt+hR5lYNTyin5ygB8eGejnldAMgy9z
        KDzdfh1mD56nmamnEAJRF6ebDSRvvoiEbhx/01UTk5EMcAuLc2qnxsqFXCzh0tyh4ApnZuJfQOOIr
        exRC/L0XvRfp5d99zNfXUl2ZNR6mpP0/a/qNOgnG24+HNCaRJmWPlDysEnJ8hyNCesm2slGC0Gx58
        kNSBUsht0lRi2j0a+igP03DEVEqYB/OwYyep+2VhtBXqvgAlqN+D9mI4xhCOYOhJJiSnydLRt5TKJ
        06STh2+nA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4tVm-0000eh-9c; Tue, 25 Sep 2018 20:01:06 +0000
Subject: Re: [PATCH v14 12/19] x86/sgx: Add data structures for tracking the
 EPC pages
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-13-jarkko.sakkinen@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b2bf157-e162-89ff-000b-190aa8dddb53@infradead.org>
Date:   Tue, 25 Sep 2018 13:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925130845.9962-13-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 6:06 AM, Jarkko Sakkinen wrote:
> Add data structures to track Enclave Page Cache (EPC) pages.  EPC is
> divided into multiple banks (1-N) of which addresses and sizes can be
> enumerated with CPUID by the OS.
> 
> On NUMA systems a node can have at most bank. A bank can be at most part of
> two nodes. SGX supports both nodes with a single memory controller and also
> sub-cluster nodes with severals memory controllers on a single die.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/sgx.h      |  55 +++++++++++++++
>  arch/x86/kernel/cpu/intel_sgx.c | 115 ++++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)

Hi,

Several comment blocks begin with "/**" but they are either not intended
to be kernel-doc notation or they are incomplete kernel-doc notation.

> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index e66e2572011e..468e609147cd 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -5,10 +5,65 @@
>  #ifndef _ASM_X86_SGX_H
>  #define _ASM_X86_SGX_H
>  
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/rwsem.h>
>  #include <linux/types.h>
> +#include <asm/sgx_arch.h>
> +#include <asm/asm.h>
> +
> +struct sgx_epc_page {
> +	unsigned long desc;
> +	struct list_head list;
> +};
> +
> +/**
> + * struct sgx_epc_section
> + *
> + * The firmware can define multiple chunks of EPC to the different areas of the
> + * physical memory e.g. for memory areas of the each node. This structure is
> + * used to store EPC pages for one EPC section and virtual memory area where
> + * the pages have been mapped.
> + */

Incomplete...

> +struct sgx_epc_section {
> +	unsigned long pa;
> +	void __iomem *va;
> +	struct sgx_epc_page **pages;
> +	unsigned long free_cnt;
> +	spinlock_t lock;
> +};
>  
>  extern bool sgx_enabled;
>  extern bool sgx_lc_enabled;
> +extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
> +
> +/*
> + * enum sgx_epc_page_desc - bits and masks for an EPC page's descriptor
> + * %SGX_EPC_SECTION_MASK:	SGX allows to have multiple EPC sections in the
> + *				physical memory. The existing and near-future
> + *				hardware defines at most eight sections, hence
> + *				three bits to hold a section.
> + * %SGX_EPC_PAGE_RECLAIMABLE:	The page page is reclaimable. Used when freeing
> + *				a page to know that we also need to remove the
> + *				page from the list of reclaimable pages.
> + */

OTOH, this one is close to ready for kernel-doc but it does not begin with
"/**".  But that's OK, your choice.

> +enum sgx_epc_page_desc {
> +	SGX_EPC_SECTION_MASK			= GENMASK_ULL(3, 0),
> +	SGX_EPC_PAGE_RECLAIMABLE		= BIT(4),
> +	/* bits 12-63 are reserved for the physical page address of the page */
> +};
> +
> +static inline struct sgx_epc_section *sgx_epc_section(struct sgx_epc_page *page)
> +{
> +	return &sgx_epc_sections[page->desc & SGX_EPC_SECTION_MASK];
> +}
> +
> +static inline void __iomem *sgx_epc_addr(struct sgx_epc_page *page)
> +{
> +	struct sgx_epc_section *section = sgx_epc_section(page);
> +
> +	return section->va + (page->desc & PAGE_MASK) - section->pa;
> +}
>  
>  /**
>   * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
> diff --git a/arch/x86/kernel/cpu/intel_sgx.c b/arch/x86/kernel/cpu/intel_sgx.c
> index 138af9b9a39a..b24d6287442d 100644
> --- a/arch/x86/kernel/cpu/intel_sgx.c
> +++ b/arch/x86/kernel/cpu/intel_sgx.c
> @@ -14,10 +14,121 @@ bool sgx_enabled __ro_after_init;
>  EXPORT_SYMBOL_GPL(sgx_enabled);
>  bool sgx_lc_enabled __ro_after_init;
>  EXPORT_SYMBOL_GPL(sgx_lc_enabled);
> +struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
> +EXPORT_SYMBOL_GPL(sgx_epc_sections);
> +
> +static int sgx_nr_epc_sections;
> +
> +static __init void sgx_free_epc_section(struct sgx_epc_section *section)
> +{
> +	int i;
> +
> +	for (i = 0; i < section->free_cnt && section->pages[i]; i++)
> +		kfree(section->pages[i]);
> +	kfree(section->pages);
> +	iounmap(section->va);
> +}
> +
> +static __init int sgx_init_epc_section(u64 addr, u64 size, unsigned long index,
> +				       struct sgx_epc_section *section)
> +{
> +	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	unsigned long i;
> +
> +	section->va = ioremap_cache(addr, size);
> +	if (!section->va)
> +		return -ENOMEM;
> +
> +	section->pa = addr;
> +	section->free_cnt = nr_pages;
> +	spin_lock_init(&section->lock);
> +
> +	section->pages = kcalloc(nr_pages, sizeof(struct sgx_epc_page *),
> +				 GFP_KERNEL);
> +	if (!section->pages)
> +		goto out;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		section->pages[i] = kzalloc(sizeof(struct sgx_epc_page),
> +					    GFP_KERNEL);
> +		if (!section->pages[i])
> +			goto out;
> +
> +		section->pages[i]->desc = (addr + (i << PAGE_SHIFT)) | index;
> +	}
> +
> +	return 0;
> +out:
> +	sgx_free_epc_section(section);
> +	return -ENOMEM;
> +}
> +
> +static __init void sgx_page_cache_teardown(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < sgx_nr_epc_sections; i++)
> +		sgx_free_epc_section(&sgx_epc_sections[i]);
> +}
> +
> +/**
> + * A section metric is concatenated in a way that @low bits 12-31 define the
> + * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
> + * metric.
> + */

not kernel-doc notation.

> +static inline u64 sgx_calc_section_metric(u64 low, u64 high)
> +{
> +	return (low & GENMASK_ULL(31, 12)) +
> +	       ((high & GENMASK_ULL(19, 0)) << 32);
> +}

thanks,
-- 
~Randy
