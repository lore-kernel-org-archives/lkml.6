Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08830C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66BA208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HRJNZk6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66BA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeLNIfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:35:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35913 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeLNIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:35:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so4288565edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=70dVirz4fnBbVianUK2jDuCnZkgXC35g87hwr8o0saU=;
        b=HRJNZk6MutYi1mFHPwQp9kpRAsNeTIo3bQ+qM+OcbEfn/ewtayo4d9y4XDTQ+/11tm
         dEMYMGhkJKigqhR8PsHaf/h4nFjzFAhUpNAkeAAwbx6lmUgxpj08mWmsbH+hyM9u1DsT
         LQiPJg1Vgn89rD3wkAwBlTr7RS2zEJQbEEM/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=70dVirz4fnBbVianUK2jDuCnZkgXC35g87hwr8o0saU=;
        b=MBXHxrCIscaALMBs4GB9UjcRTwqgok0jFI9iV948AUc3+48//g+95qjb71mH/DiNNe
         X8mdngwdzVGYT34SjNcQ9A4Rx/x4aHzRTWTVLz1pwBHQd41QyCDrLSiCCWn1wKEOU5Ex
         GEzoZc+tslF03UOaN0T3Y02zWLECM3yCYfCHTbEu3G56q2FVWoj7eIo3fCFV9nLWKmgR
         hXEVkMr3lTxHWa7h9N4dkoLyplJ7BTFuA0tGg5a73w5X60UWaSUqdEysB2bxSVEOO5lL
         m7QKE2MupJEPSEBKsc8Q092iX2XBdb/tPw0BhGI0C1IIdDHA+nYWUESict/RlGxjthkU
         qZUw==
X-Gm-Message-State: AA+aEWbNQzqL0AmFvUMoLiIjT0HkXJwWD61Kg5gdyaGlDd+YQKzua7tC
        eillTVruHPojwIPdS3itBJBRkA==
X-Google-Smtp-Source: AFSGD/VLxxPKxlCj9M8MP5ypWnxHmE6jVHKKBBFhwkLbPcnlADHGhSQcfw2pCFSKlaVOrFJTGiutdw==
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr2164856edp.173.1544776522781;
        Fri, 14 Dec 2018 00:35:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t26sm1308279eda.22.2018.12.14.00.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 00:35:21 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:35:19 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jgross@suse.com,
        boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181214083519.GI21184@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jgross@suse.com,
        boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <b8f34c60-5692-c40d-3635-071d214bfeed@gmail.com>
 <20181213154845.GF21184@phenom.ffwll.local>
 <57b468f5-cf7a-0dcd-fef8-fd399025fb45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b468f5-cf7a-0dcd-fef8-fd399025fb45@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:09:45AM +0200, Oleksandr Andrushchenko wrote:
> On 12/13/18 5:48 PM, Daniel Vetter wrote:
> > On Thu, Dec 13, 2018 at 12:17:54PM +0200, Oleksandr Andrushchenko wrote:
> > > Daniel, could you please comment?
> > Cross-revieweing someone else's stuff would scale better,
> fair enough
> >   I don't think
> > I'll get around to anything before next year.
> 
> I put you on CC explicitly because you had comments on other patch [1]
> 
> and this one tries to solve the issue raised (I tried to figure out
> 
> at [2] if this is the way to go, but it seems I have no alternative here).
> 
> While at it [3] (I hope) addresses your comments and the series just
> 
> needs your single ack/nack to get in: all the rest ack/r-b are already
> 
> there. Do you mind looking at it?

As mentioned, much better if you aim for more per review with others, not
just me. And all that dma coherency stuff isn't something a really
understand all that well (I just know we have lots of pain). For options
maybe work together with Gerd Hoffman or Noralf Tronnes, I think either
has some patches pending that also need some review.
-Daniel

> 
> > -Daniel
> 
> Thank you very much for your time,
> 
> Oleksandr
> 
> > > Thank you
> > > 
> > > On 11/27/18 12:32 PM, Oleksandr Andrushchenko wrote:
> > > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > > 
> > > > When GEM backing storage is allocated with drm_gem_get_pages
> > > > the backing pages may be cached, thus making it possible that
> > > > the backend sees only partial content of the buffer which may
> > > > lead to screen artifacts. Make sure that the frontend's
> > > > memory is coherent and the backend always sees correct display
> > > > buffer content.
> > > > 
> > > > Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
> > > > 
> > > > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > > ---
> > > >    drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
> > > >    1 file changed, 48 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > > > index 47ff019d3aef..c592735e49d2 100644
> > > > --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > > > +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > > > @@ -33,8 +33,11 @@ struct xen_gem_object {
> > > >    	/* set for buffers allocated by the backend */
> > > >    	bool be_alloc;
> > > > -	/* this is for imported PRIME buffer */
> > > > -	struct sg_table *sgt_imported;
> > > > +	/*
> > > > +	 * this is for imported PRIME buffer or the one allocated via
> > > > +	 * drm_gem_get_pages.
> > > > +	 */
> > > > +	struct sg_table *sgt;
> > > >    };
> > > >    static inline struct xen_gem_object *
> > > > @@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
> > > >    	return xen_obj;
> > > >    }
> > > > +struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> > > > +{
> > > > +	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> > > > +
> > > > +	if (!xen_obj->pages)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> > > > +}
> > > > +
> > > >    static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> > > >    {
> > > >    	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
> > > >    	struct xen_gem_object *xen_obj;
> > > > +	struct address_space *mapping;
> > > >    	int ret;
> > > >    	size = round_up(size, PAGE_SIZE);
> > > > @@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> > > >    		xen_obj->be_alloc = true;
> > > >    		return xen_obj;
> > > >    	}
> > > > +
> > > >    	/*
> > > >    	 * need to allocate backing pages now, so we can share those
> > > >    	 * with the backend
> > > >    	 */
> > > > +	mapping = xen_obj->base.filp->f_mapping;
> > > > +	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
> > > > +
> > > >    	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
> > > >    	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
> > > >    	if (IS_ERR_OR_NULL(xen_obj->pages)) {
> > > > @@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> > > >    		goto fail;
> > > >    	}
> > > > +	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
> > > > +	if (IS_ERR_OR_NULL(xen_obj->sgt)){
> > > > +		ret = PTR_ERR(xen_obj->sgt);
> > > > +		xen_obj->sgt = NULL;
> > > > +		goto fail_put_pages;
> > > > +	}
> > > > +
> > > > +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > > > +			DMA_BIDIRECTIONAL)) {
> > > > +		ret = -EFAULT;
> > > > +		goto fail_free_sgt;
> > > > +	}
> > > > +
> > > >    	return xen_obj;
> > > > +fail_free_sgt:
> > > > +	sg_free_table(xen_obj->sgt);
> > > > +	xen_obj->sgt = NULL;
> > > > +fail_put_pages:
> > > > +	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
> > > > +	xen_obj->pages = NULL;
> > > >    fail:
> > > >    	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
> > > >    	return ERR_PTR(ret);
> > > > @@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
> > > >    	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> > > >    	if (xen_obj->base.import_attach) {
> > > > -		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
> > > > +		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
> > > >    		gem_free_pages_array(xen_obj);
> > > >    	} else {
> > > >    		if (xen_obj->pages) {
> > > > @@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
> > > >    							xen_obj->pages);
> > > >    				gem_free_pages_array(xen_obj);
> > > >    			} else {
> > > > +				if (xen_obj->sgt) {
> > > > +					dma_unmap_sg(xen_obj->base.dev->dev,
> > > > +						     xen_obj->sgt->sgl,
> > > > +						     xen_obj->sgt->nents,
> > > > +						     DMA_BIDIRECTIONAL);
> > > > +					sg_free_table(xen_obj->sgt);
> > > > +				}
> > > >    				drm_gem_put_pages(&xen_obj->base,
> > > >    						  xen_obj->pages, true, false);
> > > >    			}
> > > > @@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
> > > >    	return xen_obj->pages;
> > > >    }
> > > > -struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> > > > -{
> > > > -	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> > > > -
> > > > -	if (!xen_obj->pages)
> > > > -		return ERR_PTR(-ENOMEM);
> > > > -
> > > > -	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> > > > -}
> > > > -
> > > >    struct drm_gem_object *
> > > >    xen_drm_front_gem_import_sg_table(struct drm_device *dev,
> > > >    				  struct dma_buf_attachment *attach,
> > > > @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
> > > >    	if (ret < 0)
> > > >    		return ERR_PTR(ret);
> > > > -	xen_obj->sgt_imported = sgt;
> > > > +	xen_obj->sgt = sgt;
> > > >    	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
> > > >    					       NULL, xen_obj->num_pages);
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> [1] https://patchwork.kernel.org/patch/10693787/
> 
> [2] https://lists.xen.org/archives/html/xen-devel/2018-11/msg02882.html
> 
> [3] https://patchwork.kernel.org/patch/10705853/
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
