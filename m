Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BDC217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MFKQYu7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLRJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:57:51 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39402 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iHiwr/FMFw5Dm9zasFmVTSZRnXhmdru9eEi/AXWWkTY=; b=MFKQYu7lJ/BehPNauB8d8s6A0
        BkI+YWIQjK+zik026CH/G8bw3sROaM0SZtvrln7+qazrQ/TU1xPwwyq9XjGeHgqO/6zWEiWwV7Qms
        ljKjzrjnOZAOZclTfZIW3kQT9AMvvtSRgSc12Gld5qPmGmqC99mM3ipsdpMj3WbX0vEXw=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:55758)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZC7t-0005RJ-53; Tue, 18 Dec 2018 09:57:21 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZC7l-0005fh-Dp; Tue, 18 Dec 2018 09:57:13 +0000
Date:   Tue, 18 Dec 2018 09:57:09 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181218095709.GJ26090@n2100.armlinux.org.uk>
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:53:34AM +0530, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index a8db758..8279084 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -221,26 +221,11 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>  					      struct vm_area_struct *vma)
>  {
>  	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> -	unsigned int i, count = obj->size >> PAGE_SHIFT;
>  	unsigned long user_count = vma_pages(vma);
> -	unsigned long uaddr = vma->vm_start;
>  	unsigned long offset = vma->vm_pgoff;
> -	unsigned long end = user_count + offset;
> -	int ret;
> -
> -	if (user_count == 0)
> -		return -ENXIO;
> -	if (end > count)
> -		return -ENXIO;
>  
> -	for (i = offset; i < end; i++) {
> -		ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> -		if (ret)
> -			return ret;
> -		uaddr += PAGE_SIZE;
> -	}
> -
> -	return 0;
> +	return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
> +				user_count - offset);

This looks like a change in behaviour.

If user_count is zero, and offset is zero, then we pass into
vm_insert_range() a page_count of zero, and vm_insert_range() does
nothing and returns zero.

However, as we can see from the above code, the original behaviour
was to return -ENXIO in that case.

The other thing that I'm wondering is that if (eg) count is 8 (the
object is 8 pages), offset is 2, and the user requests mapping 6
pages (user_count = 6), then we call vm_insert_range() with a
pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
end up inserting four pages.

The original code would calculate end = 6 + 2 = 8.  i would iterate
from 2 through 8, inserting six pages.

(I hadn't spotted that second issue until I'd gone through the
calculations manually - which is worrying.)

I don't have patches 5 through 9 to look at, but I'm concerned that
similar issues also exist in those patches.

I'm concerned that this series seems to be introducing subtle bugs,
it seems to be unnecessarily difficult to use this function correctly.
I think your existing proposal for vm_insert_range() provides an
interface that is way too easy to get wrong, and, therefore, is the
wrong interface.

I think it would be way better to have vm_insert_range() take the
object page array without any offset adjustment, and the object
page_count again without any adjustment, and have vm_insert_range()
itself handle the offsetting and VMA size validation.  That would
then give a simple interface and probably give a further reduction
in code at each call site.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
