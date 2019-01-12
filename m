Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0241C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE0720854
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CeXJKRaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfALMMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:12:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfALMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=usOnlJ+n0ouIA825JYmyeYCXdfJgDQn6tYUepfZTml4=; b=CeXJKRaXRnkz6fpEkxa+HS++N
        Nv+E3EXqQuvSm/yk5laLWDPmokTjURvDjfdZmxl+sIacD3JunbAZXgk/wDwCE6WvboTyW/u6XFJRd
        Gdg+Zo4Y6iVTTeshlbpORnHbVfYde17ndn1oi8CxCdyGPeltug/EgPYeu+Huue8qXIG1FF0P+1/QE
        OkI4MFeIUyV9CIYVFhzufJVxn8HHs5i26d0rVH1jBwAt+8BO5kc+cNzWSMKYdaRVgV2scxI+ny+G+
        Wx4ZTWnSMg86Ie6pICfmg6HCsUzfLYDchz8liDQCBYyTo+POARPZOFYLKVhnbMr8FAxNbCCaSL5ho
        5wuB4g8tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giI9Q-0004Q7-1d; Sat, 12 Jan 2019 12:12:32 +0000
Date:   Sat, 12 Jan 2019 04:12:31 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, mpe@ellerman.id.au,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kirill@shutemov.name,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        steve.capper@arm.com, james.morse@arm.com, robin.murphy@arm.com,
        aneesh.kumar@linux.ibm.com, vbabka@suse.cz, shakeelb@google.com,
        rientjes@google.com
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190112121230.GQ6310@bombadil.infradead.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> __GFP_ZERO) and using it for allocating page table pages.

Except that's not true.

> +++ b/arch/x86/mm/pgtable.c
> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>  EXPORT_SYMBOL(physical_mask);
>  #endif
>  
> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
> -
>  #ifdef CONFIG_HIGHPTE

...

>  pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>  }

I think x86 was the only odd one out here, but you'll need to try again ...
