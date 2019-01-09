Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF51C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F02420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfAIDLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:11:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfAIDLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:11:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 737C087643;
        Wed,  9 Jan 2019 03:11:14 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 737E92C8F1;
        Wed,  9 Jan 2019 03:11:05 +0000 (UTC)
Date:   Wed, 9 Jan 2019 11:11:03 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, cohuck@redhat.com
Subject: Re: [PATCH] vfio/type1: Fix unmap overflow off-by-one
Message-ID: <20190109031102.GB12837@xz-x1>
References: <154696559827.32763.11706407320970225120.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154696559827.32763.11706407320970225120.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 03:11:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:40:06AM -0700, Alex Williamson wrote:
> The below referenced commit adds a test for integer overflow, but in
> doing so prevents the unmap ioctl from ever including the last page of
> the address space.  Subtract one to compare to the last address of the
> unmap to avoid the overflow and wrap-around.
> 
> Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Debugged-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

I tested this against the QEMU reboot error and it works.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>

Thanks,

> ---
>  drivers/vfio/vfio_iommu_type1.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 7651cfb14836..73652e21efec 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -878,7 +878,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  		return -EINVAL;
>  	if (!unmap->size || unmap->size & mask)
>  		return -EINVAL;
> -	if (unmap->iova + unmap->size < unmap->iova ||
> +	if (unmap->iova + unmap->size - 1 < unmap->iova ||
>  	    unmap->size > SIZE_MAX)
>  		return -EINVAL;
>  
> 

-- 
Peter Xu
