Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8736BC5AC75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EA62184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cb1dQr9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLXO34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:29:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52502 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeLXO3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kvKnfvcb3iLFqvHcRSa+XDrZ1f+GPM4hMRTAJKCzQ9w=; b=Cb1dQr9njcsp0qf4pHVdBXH9H
        rp1LGl7GSrr2Tusok2Fye23JUGYa7J5c2AJBlX5qaStt4v47r3Du0ExYRKFvzCsSW3O9Hrbpk0FR2
        EahuDg66ZTj522MzpLTSDjzf3/TpveX4bp/HG4udPiRQdFFwpuvjET3OY5sr3amkbZAFg=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:59018)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gbREZ-0007n3-S2; Mon, 24 Dec 2018 14:29:33 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gbREX-0006ez-0f; Mon, 24 Dec 2018 14:29:29 +0000
Date:   Mon, 24 Dec 2018 14:29:27 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181224142927.GZ26090@n2100.armlinux.org.uk>
References: <20181224132531.GA22150@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224132531.GA22150@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 06:55:31PM +0530, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/iommu/dma-iommu.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..de7ffd8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  
>  int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>  {
> -	unsigned long uaddr = vma->vm_start;
> -	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	int ret = -ENXIO;
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  
> -	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -		ret = vm_insert_page(vma, uaddr, pages[i]);
> -		if (ret)
> -			break;
> -		uaddr += PAGE_SIZE;
> -	}
> -	return ret;
> +	return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff,
> +				count - vma->vm_pgoff);

This introduces a new bug.

I'm not going to continue to point out in minute detail the mistakes
you are introducing, as I don't think that is helping you to learn.

Look at this closely, and see whether you can spot the mistake.
Specifically, compare the boundary conditions for the final page
that is to be inserted and the value returned by the original version
and by your version for different scenarios.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
