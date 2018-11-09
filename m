Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D19C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D86C20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D86C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeKJCEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeKJCEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DABB185A07;
        Fri,  9 Nov 2018 16:23:30 +0000 (UTC)
Received: from t450s.home (ovpn-116-133.phx2.redhat.com [10.3.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6400C5D736;
        Fri,  9 Nov 2018 16:23:30 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:23:29 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de
Subject: Re: [PATCH 7/7] vfio/type1: Remove map_try_harder() code path
Message-ID: <20181109092329.79b0fe91@t450s.home>
In-Reply-To: <20181109110712.12469-8-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
        <20181109110712.12469-8-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 09 Nov 2018 16:23:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 12:07:12 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> The AMD IOMMU driver can now map a huge-page where smaller
> mappings existed before, so this code-path is no longer
> triggered.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 33 ++-------------------------------
>  1 file changed, 2 insertions(+), 31 deletions(-)

Cool, glad to see this finally fixed.  My "should be fixed soon"
comment turned out to be a little optimistic with the fix finally
coming 5 years later.  We could of course keep this code as it really
doesn't harm anything, but I'm in favor trying to remove it if we think
it's dead now.  In order to expedite into one pull:

Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex
 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index d9fd3188615d..7651cfb14836 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -978,32 +978,6 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> -/*
> - * Turns out AMD IOMMU has a page table bug where it won't map large pages
> - * to a region that previously mapped smaller pages.  This should be fixed
> - * soon, so this is just a temporary workaround to break mappings down into
> - * PAGE_SIZE.  Better to map smaller pages than nothing.
> - */
> -static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
> -			  unsigned long pfn, long npage, int prot)
> -{
> -	long i;
> -	int ret = 0;
> -
> -	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
> -		ret = iommu_map(domain->domain, iova,
> -				(phys_addr_t)pfn << PAGE_SHIFT,
> -				PAGE_SIZE, prot | domain->prot);
> -		if (ret)
> -			break;
> -	}
> -
> -	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
> -		iommu_unmap(domain->domain, iova, PAGE_SIZE);
> -
> -	return ret;
> -}
> -
>  static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
>  			  unsigned long pfn, long npage, int prot)
>  {
> @@ -1013,11 +987,8 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
>  	list_for_each_entry(d, &iommu->domain_list, next) {
>  		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
>  				npage << PAGE_SHIFT, prot | d->prot);
> -		if (ret) {
> -			if (ret != -EBUSY ||
> -			    map_try_harder(d, iova, pfn, npage, prot))
> -				goto unwind;
> -		}
> +		if (ret)
> +			goto unwind;
>  
>  		cond_resched();
>  	}

