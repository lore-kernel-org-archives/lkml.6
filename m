Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeCZPsT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:48:19 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45414 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCZPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:48:17 -0400
Date: Mon, 26 Mar 2018 17:47:54 +0200
From: Emil Goode <emil.fsw@goode.io>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Fix compiler errors
Message-ID: <20180326154753.akbdpxlstb4mr3ne@lianli>
References: <20180326144314.xeuocqp5fjpfjm3q@lianli>
 <20180326145734.GA8016@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180326145734.GA8016@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 26, 2018 at 04:57:34PM +0200, Thierry Reding wrote:
> On Mon, Mar 26, 2018 at 04:44:14PM +0200, Emil Goode wrote:
> > The compiler is complaining with the following errors:
> > 
> > drivers/gpu/host1x/cdma.c:94:48: error:
> > 	passing argument 3 of ‘dma_alloc_wc’ from incompatible pointer type
> > 	[-Werror=incompatible-pointer-types]
> > 
> > drivers/gpu/host1x/cdma.c:113:48: error:
> > 	passing argument 3 of ‘dma_alloc_wc’ from incompatible pointer type
> > 	[-Werror=incompatible-pointer-types]
> > 
> > The expected pointer type of the third argument to dma_alloc_wc() is
> > dma_addr_t but phys_addr_t is passed. Fix this by adding casts to the
> > expected pointer type.
> > 
> > Signed-off-by: Emil Goode <emil.fsw@goode.io>
> > ---
> >  drivers/gpu/host1x/cdma.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> What compiler do you use? I do regular builds and check for warnings and
> errors, and this one is new to me.
> 
> Thierry
>

I use gcc version 6.3.0 cross compiler for armhf supplied with Debian Stretch.

Best regards,

Emil

> > 
> > diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
> > index 28541b280739..5e8b321a751e 100644
> > --- a/drivers/gpu/host1x/cdma.c
> > +++ b/drivers/gpu/host1x/cdma.c
> > @@ -91,8 +91,8 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
> >  
> >  		size = iova_align(&host1x->iova, size);
> >  
> > -		pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
> > -					  GFP_KERNEL);
> > +		pb->mapped = dma_alloc_wc(host1x->dev, size,
> > +					  (dma_addr_t *)&pb->phys, GFP_KERNEL);
> >  		if (!pb->mapped)
> >  			return -ENOMEM;
> >  
> > @@ -110,8 +110,8 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
> >  		if (err)
> >  			goto iommu_free_iova;
> >  	} else {
> > -		pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
> > -					  GFP_KERNEL);
> > +		pb->mapped = dma_alloc_wc(host1x->dev, size,
> > +					  (dma_addr_t *)&pb->phys, GFP_KERNEL);
> >  		if (!pb->mapped)
> >  			return -ENOMEM;
> >  
> > -- 
> > 2.11.0
> > 
