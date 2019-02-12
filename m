Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF66A2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pnw6BM58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfBLOOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:14:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfBLOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Nd8kozV4BV/GafBh+rTz1qGEH7cU811uOSRQdc3z+A=; b=Pnw6BM58jcRxGFb1E+v5ODUr4
        ck2FVyDH5Guq1KlYCse2PP1Eyjmzc/H6S0WU9djukLTon1zd9bYJ/S48SnJee/BsWSrfXzcqYF0iQ
        3gVQ5BtQp05Fm8Q+ygk2Ne8t8CxXUaUb1Jguz0MNkaT8tfjXyzK+zT8gAUcJiVIOpMaaM5uQ+GVtH
        4pIBMZE5IKPem9nJe352NIt9Mp+StcfNEqEoJXRDVJoCtQqeF9CP+PaxxsxYMeFP65t74Uq7lYyH3
        OHLlwFUeBY3XrhfVnOVqrKI93k8eYOpQ3yJb7ZyTittqVYWRl22iaqm9jd/TZ9HG3XT5hxlvexbbT
        RmG8VfTvA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtYpG-0007rc-Dc; Tue, 12 Feb 2019 14:14:18 +0000
Date:   Tue, 12 Feb 2019 06:14:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: use memblock_alloc() instead of custom
 get_memblock()
Message-ID: <20190212141418.GM12668@bombadil.infradead.org>
References: <1549979990-6642-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549979990-6642-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:59:50PM +0200, Mike Rapoport wrote:
> -static void * __init get_memblock(unsigned long size)
> -{
> -	static phys_addr_t search_addr __initdata;
> -	phys_addr_t phys;
> -
> -	if (!search_addr)
> -		search_addr = PAGE_ALIGN(__pa((unsigned long) &_end));
> -	search_addr = ALIGN(search_addr, size);
> -	while (!memblock_is_region_memory(search_addr, size) ||
> -		memblock_is_region_reserved(search_addr, size)) {
> -		search_addr += size;
> -	}
> -	phys = search_addr;

This implies to me that the allocation will be 'size' aligned.

>  		if (!pmd) {
> -			pmd = (pmd_t *) get_memblock(PAGE_SIZE << PMD_ORDER);
> +			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
> +					     SMP_CACHE_BYTES);

So why would this only need to be cacheline aligned?  It's pretty common
for hardware to require that pgd/pud/pmd/pte tables be naturally aligned.

> @@ -700,7 +683,10 @@ static void __init pagetable_init(void)
>  	}
>  #endif
>  
> -	empty_zero_page = get_memblock(PAGE_SIZE);
> +	empty_zero_page = memblock_alloc(PAGE_SIZE, SMP_CACHE_BYTES);

... and surely the zero page also needs to be page aligned, by definition.

