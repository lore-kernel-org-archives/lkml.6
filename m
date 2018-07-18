Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52442075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52442075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeGRGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:14:40 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:47237 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeGRGOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:14:39 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 790065C02FA; Wed, 18 Jul 2018 05:36:58 +0000 (UTC)
Date:   Wed, 18 Jul 2018 05:36:58 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Li Philip <philip.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm: handle error values properly
Message-ID: <20180718053658.GA10618@osadl.at>
References: <1531834101-6018-1-git-send-email-hofrat@osadl.org>
 <20180717201416.GZ20303@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717201416.GZ20303@art_vandelay>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:14:16PM -0400, Sean Paul wrote:
> On Tue, Jul 17, 2018 at 03:28:21PM +0200, Nicholas Mc Guire wrote:
> > drm_legacy_ctxbitmap_next() returns idr_alloc() which can return
> > -ENOMEM, -EINVAL or -ENOSPC none of which are -1. since drm_context_t
> > is an unsigned int an intermediate variable is used to handle the
> > error cases, and then cast to drm_context_t after ensuring that the
> > value is >= 0. The explicit cast is to mark the type conversion as
> > intentional.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Fixes: d530b5f1ca0b ("drm: re-enable error handling")
> > Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
> > ---
> > 
> > kbuild test robot reported:
> > <snip>
> > tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next-fixes
> > head:   d530b5f1ca0bb66958a2b714bebe40a1248b9c15
> > commit: d530b5f1ca0bb66958a2b714bebe40a1248b9c15 [2/2] drm: re-enable error
> > +handling
> > 
> > smatch warnings:
> > drivers/gpu/drm/drm_context.c:375 drm_legacy_addctx() warn: unsigned
> > +'ctx->handle' is never less than zero.
> > <snip>
> > 
> > V2: The proposed fix in d530b5f1ca0b ("drm: re-enable error handling")
> >     actually was ineffective as the negative return value check was 
> >     against a unsigned int and thus always false as reported by
> >     kbuild test robot <lkp@intel.com>. The below patch removes that
> >     warning and fixes the original problem of missed error handling.
> > 
> > drm_context_t is actually just used in a few placed so the type could be
> > changed but it is also exported via tools/include/uapi/drm/drm.h so
> > changing the typedef of drm_context_t could break applications and thus
> > this is not an option.
> > 
> > Patch was compile tested with: x86_64_defconfig
> > 
> > Patch is against 4.18-rc4 (localversion-next is next-20180717)
> > 
> >  drivers/gpu/drm/drm_context.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
> > index 3c4000f..78f32a3 100644
> > --- a/drivers/gpu/drm/drm_context.c
> > +++ b/drivers/gpu/drm/drm_context.c
> > @@ -361,22 +361,26 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
> >  {
> >  	struct drm_ctx_list *ctx_entry;
> >  	struct drm_ctx *ctx = data;
> > +	int ret;
> >  
> >  	if (!drm_core_check_feature(dev, DRIVER_KMS_LEGACY_CONTEXT) &&
> >  	    !drm_core_check_feature(dev, DRIVER_LEGACY))
> >  		return -EINVAL;
> >  
> >  	ctx->handle = drm_legacy_ctxbitmap_next(dev);
> 
> Remove this call?

yup - forgot to remove that line after copying

The modified block should be:
	int ret;
	...

        ret = drm_legacy_ctxbitmap_next(dev); 
        if (ret == DRM_KERNEL_CONTEXT) { 
                /* Skip kernel's context and get a new one. */ 
                ret = drm_legacy_ctxbitmap_next(dev); 
        } 
        DRM_DEBUG("ctxbitmap is error code %d\n", ret); 
        if (ret < 0) { 
                DRM_DEBUG("Not enough free contexts.\n"); 
                /* Should this return -EBUSY instead? */ 
                return -ENOMEM; 
        } 
        /* valid context is >= 0 */ 
        ctx->handle = (drm_context_t)ret; 

thanks for cathcing that - will resend

thx!
hofrat

> 
> > -	if (ctx->handle == DRM_KERNEL_CONTEXT) {
> > +	ret = drm_legacy_ctxbitmap_next(dev);
> > +	if (ret == DRM_KERNEL_CONTEXT) {
> >  		/* Skip kernel's context and get a new one. */
> > -		ctx->handle = drm_legacy_ctxbitmap_next(dev);
> > +		ret = drm_legacy_ctxbitmap_next(dev);
> >  	}
> > -	DRM_DEBUG("%d\n", ctx->handle);
> > -	if (ctx->handle < 0) {
> > +	DRM_DEBUG("ctxbitmap is error code %d\n", ret);
> > +	if (ret < 0) {
> >  		DRM_DEBUG("Not enough free contexts.\n");
> >  		/* Should this return -EBUSY instead? */
> >  		return -ENOMEM;
> >  	}
> > +	/* valid context is >= 0 */
> > +	ctx->handle = (drm_context_t)ret;
> >  
> >  	ctx_entry = kmalloc(sizeof(*ctx_entry), GFP_KERNEL);
> >  	if (!ctx_entry) {
> > -- 
> > 2.1.4
> > 
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
