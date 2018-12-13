Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F16C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA4920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LMuCpsmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeLMPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:48:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43326 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbeLMPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:48:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so2392230eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7d5yHXUfSV/qxnehmAd/ytEzurRBkbvMqLCeiGC+5o=;
        b=LMuCpsmPSzrGETw612wUW3AtvpGl43PyQxAVYHESeXD947yRA7B8FcSNLcm62AN7Yy
         Q9/pBTqCMzo6Ha+euMUdOUpBz6hKpv6O5/iD6UdIhNtgQCN3wIcvcKFc0H4dClKNItGU
         O2CNL3ud3E/X0DE1nVXbom4oCvrdqK/RTSBtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=P7d5yHXUfSV/qxnehmAd/ytEzurRBkbvMqLCeiGC+5o=;
        b=a54p8HEGup92g66qRu8RaTHQG70jcRGRAn+H3t1wJUIWTa28LLcs+qdRe0GWPgV8lT
         VMVALMGiIKlokPH9KYBn2JnaGpH748Uhye1nP2L4dcGGHSOG3KCHYQJMqH9at2CtUaAs
         Me4qgQ6zvobqP3ExanioMmvEhYWHbwp6xu2HnLS0kVSj32bE2t6pqGCprr/F7imwP1EH
         gZAxX3Tk1+AloVKI+uZGxjVaiCy6mnRtYqBLpj5+MDAXmlKw9nLAHxBaEQhxtapqPnzH
         aThEUbV9/EWkvw/NPE4EJ57IsH37/AUJCGUfGm2eX6iq2TvYSa04WPdFxTWpyprk4ZX+
         /Hfw==
X-Gm-Message-State: AA+aEWY8+feTBQ0Bk1G+6WA2oxWI9vGqfK1nPzxn5UooJqL29UBPzIo6
        Pnf+4FspWeR+rUVmK+zgDfuJBQ==
X-Google-Smtp-Source: AFSGD/XmcAeytAMIsFj/ep1FraCrKrxzwX3YijV1sDaXM5nfxdvulywv64yBDWvjI5ZvRhcRKs8l3w==
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr21494990edd.188.1544716128120;
        Thu, 13 Dec 2018 07:48:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e53sm700371ede.90.2018.12.13.07.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 07:48:47 -0800 (PST)
Date:   Thu, 13 Dec 2018 16:48:45 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181213154845.GF21184@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <b8f34c60-5692-c40d-3635-071d214bfeed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f34c60-5692-c40d-3635-071d214bfeed@gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:17:54PM +0200, Oleksandr Andrushchenko wrote:
> Daniel, could you please comment?

Cross-revieweing someone else's stuff would scale better, I don't think
I'll get around to anything before next year.
-Daniel

> 
> Thank you
> 
> On 11/27/18 12:32 PM, Oleksandr Andrushchenko wrote:
> > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > 
> > When GEM backing storage is allocated with drm_gem_get_pages
> > the backing pages may be cached, thus making it possible that
> > the backend sees only partial content of the buffer which may
> > lead to screen artifacts. Make sure that the frontend's
> > memory is coherent and the backend always sees correct display
> > buffer content.
> > 
> > Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
> > 
> > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > ---
> >   drivers/gpu/drm/xen/xen_drm_front_gem.c | 62 +++++++++++++++++++------
> >   1 file changed, 48 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > index 47ff019d3aef..c592735e49d2 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> > @@ -33,8 +33,11 @@ struct xen_gem_object {
> >   	/* set for buffers allocated by the backend */
> >   	bool be_alloc;
> > -	/* this is for imported PRIME buffer */
> > -	struct sg_table *sgt_imported;
> > +	/*
> > +	 * this is for imported PRIME buffer or the one allocated via
> > +	 * drm_gem_get_pages.
> > +	 */
> > +	struct sg_table *sgt;
> >   };
> >   static inline struct xen_gem_object *
> > @@ -77,10 +80,21 @@ static struct xen_gem_object *gem_create_obj(struct drm_device *dev,
> >   	return xen_obj;
> >   }
> > +struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> > +{
> > +	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> > +
> > +	if (!xen_obj->pages)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> > +}
> > +
> >   static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> >   {
> >   	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
> >   	struct xen_gem_object *xen_obj;
> > +	struct address_space *mapping;
> >   	int ret;
> >   	size = round_up(size, PAGE_SIZE);
> > @@ -113,10 +127,14 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> >   		xen_obj->be_alloc = true;
> >   		return xen_obj;
> >   	}
> > +
> >   	/*
> >   	 * need to allocate backing pages now, so we can share those
> >   	 * with the backend
> >   	 */
> > +	mapping = xen_obj->base.filp->f_mapping;
> > +	mapping_set_gfp_mask(mapping, GFP_USER | __GFP_DMA32);
> > +
> >   	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
> >   	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
> >   	if (IS_ERR_OR_NULL(xen_obj->pages)) {
> > @@ -125,8 +143,27 @@ static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
> >   		goto fail;
> >   	}
> > +	xen_obj->sgt = xen_drm_front_gem_get_sg_table(&xen_obj->base);
> > +	if (IS_ERR_OR_NULL(xen_obj->sgt)){
> > +		ret = PTR_ERR(xen_obj->sgt);
> > +		xen_obj->sgt = NULL;
> > +		goto fail_put_pages;
> > +	}
> > +
> > +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > +			DMA_BIDIRECTIONAL)) {
> > +		ret = -EFAULT;
> > +		goto fail_free_sgt;
> > +	}
> > +
> >   	return xen_obj;
> > +fail_free_sgt:
> > +	sg_free_table(xen_obj->sgt);
> > +	xen_obj->sgt = NULL;
> > +fail_put_pages:
> > +	drm_gem_put_pages(&xen_obj->base, xen_obj->pages, true, false);
> > +	xen_obj->pages = NULL;
> >   fail:
> >   	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
> >   	return ERR_PTR(ret);
> > @@ -149,7 +186,7 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
> >   	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> >   	if (xen_obj->base.import_attach) {
> > -		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt_imported);
> > +		drm_prime_gem_destroy(&xen_obj->base, xen_obj->sgt);
> >   		gem_free_pages_array(xen_obj);
> >   	} else {
> >   		if (xen_obj->pages) {
> > @@ -158,6 +195,13 @@ void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj)
> >   							xen_obj->pages);
> >   				gem_free_pages_array(xen_obj);
> >   			} else {
> > +				if (xen_obj->sgt) {
> > +					dma_unmap_sg(xen_obj->base.dev->dev,
> > +						     xen_obj->sgt->sgl,
> > +						     xen_obj->sgt->nents,
> > +						     DMA_BIDIRECTIONAL);
> > +					sg_free_table(xen_obj->sgt);
> > +				}
> >   				drm_gem_put_pages(&xen_obj->base,
> >   						  xen_obj->pages, true, false);
> >   			}
> > @@ -174,16 +218,6 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *gem_obj)
> >   	return xen_obj->pages;
> >   }
> > -struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
> > -{
> > -	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
> > -
> > -	if (!xen_obj->pages)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
> > -}
> > -
> >   struct drm_gem_object *
> >   xen_drm_front_gem_import_sg_table(struct drm_device *dev,
> >   				  struct dma_buf_attachment *attach,
> > @@ -203,7 +237,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
> >   	if (ret < 0)
> >   		return ERR_PTR(ret);
> > -	xen_obj->sgt_imported = sgt;
> > +	xen_obj->sgt = sgt;
> >   	ret = drm_prime_sg_to_page_addr_arrays(sgt, xen_obj->pages,
> >   					       NULL, xen_obj->num_pages);
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
