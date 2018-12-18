Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69399217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T/XXcNpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeLRJia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:38:30 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39152 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLRJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Idm6aAp6sVxp+WzgidWgoDIbk+vjPvG/6DZo0UnmYpo=; b=T/XXcNpmpTPZ2JEB0Sab25zLX
        8/xz1L5y6CBdrCarLdVWa9xCmzsYdsdpj5Z8Wy2pTnnCyfpW+ueh3jUrQtw9wBkbGwVN2h9oS17qc
        bKKyMsK3KSduRHRMpdKMfYPSXTU3QsErFZnmqgRirzRJASjsPEHOTiOfzZ5t806tbIQ3M=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42644)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZBp9-0005ML-2L; Tue, 18 Dec 2018 09:37:59 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZBp6-0005U0-8m; Tue, 18 Dec 2018 09:37:56 +0000
Date:   Tue, 18 Dec 2018 09:37:54 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        keescook@chromium.org, m.szyprowski@samsung.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181218093754.GI26090@n2100.armlinux.org.uk>
References: <20181217202209.GA8859@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217202209.GA8859@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:52:09AM +0530, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  arch/arm/mm/dma-mapping.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48..7cbcde5 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>  		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		    unsigned long attrs)
>  {
> -	unsigned long uaddr = vma->vm_start;
> -	unsigned long usize = vma->vm_end - vma->vm_start;
> +	unsigned long page_count = vma_pages(vma);
>  	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>  	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	unsigned long off = vma->vm_pgoff;
> +	int err;
>  
>  	if (!pages)
>  		return -ENXIO;
>  
> -	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> +	if (off >= nr_pages)
>  		return -ENXIO;

Are you sure you can make this change?

You are restricting the offset to be within 0..nr_pages which ensures
that the initial struct page that is passed to vm_insert_range() is
valid, but I think the removal of the following check is unsafe.

Your new vm_insert_range() function only checks page_count <=
vma_pages(vma), which it will be since it _is_ vma_pages(vma).  With
the removal of the second condition, there will be nothing checking
that (eg) off may be nr_pages - 1, and page_count=50, meaning that
vm_insert_range() will walk off the end of the page array.

Please take another look at this.

What about the other callsites of your new function - do they have
the same issue?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
