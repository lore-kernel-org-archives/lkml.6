Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AE8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276120661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0276120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeH3WvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:51:12 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:40278 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3WvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:51:12 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 5CDE75C0B55; Thu, 30 Aug 2018 18:45:45 +0000 (UTC)
Date:   Thu, 30 Aug 2018 18:45:45 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Li Philip <philip.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] drm: handle error values properly
Message-ID: <20180830184545.GA5617@osadl.at>
References: <1531905244-18044-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531905244-18044-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:14:04AM +0200, Nicholas Mc Guire wrote:
> drm_legacy_ctxbitmap_next() returns idr_alloc() which can return
> -ENOMEM, -EINVAL or -ENOSPC none of which are -1. since drm_context_t
> is an unsigned int an intermediate variable is used to handle the
> error cases, and then cast to drm_context_t after ensuring that the
> value is >= 0. The explicit cast is to mark the type conversion as
> intentional.

As the first version made it into -stable unfortunately I would ask
for a review on this V3 so that a correct fix could go into -stabele
ASAP.

thx!
hofrat

> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Sean Paul <seanpaul@chromium.org>
> Fixes: d530b5f1ca0b ("drm: re-enable error handling")
> Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
> ---
> 
> V3: bug in patch - omission to remove old code properly - V3 fixes the
>     original problem as proposed in V2 and drops the excess line.
>     reported by Sean Paul <seanpaul@chromium.org> - thanks!
> 
> V2: The proposed fix in d530b5f1ca0b ("drm: re-enable error handling")
>     actually was ineffective as the negative return value check was
>     against a unsigned int and thus always false as reported by
>     kbuild test robot <lkp@intel.com>. The below patch removes that
>     warning and fixes the original problem of missed error handling.
> 
> drm_context_t is actually just used in a few placed so the type could be
> changed but it is also exported via tools/include/uapi/drm/drm.h so
> changing the typedef of drm_context_t could break applications and thus
> this is not an option.
> 
> Patch was compile tested with: x86_64_defconfig
> 
> Patch is against 4.18-rc5 (localversion-next is next-20180718)
> 
>  drivers/gpu/drm/drm_context.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
> index f973d28..ad268c8 100644
> --- a/drivers/gpu/drm/drm_context.c
> +++ b/drivers/gpu/drm/drm_context.c
> @@ -361,22 +361,25 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
>  {
>  	struct drm_ctx_list *ctx_entry;
>  	struct drm_ctx *ctx = data;
> +	int ret;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_KMS_LEGACY_CONTEXT) &&
>  	    !drm_core_check_feature(dev, DRIVER_LEGACY))
>  		return -EINVAL;
>  
> -	ctx->handle = drm_legacy_ctxbitmap_next(dev);
> -	if (ctx->handle == DRM_KERNEL_CONTEXT) {
> +	ret = drm_legacy_ctxbitmap_next(dev);
> +	if (ret == DRM_KERNEL_CONTEXT) {
>  		/* Skip kernel's context and get a new one. */
> -		ctx->handle = drm_legacy_ctxbitmap_next(dev);
> +		ret = drm_legacy_ctxbitmap_next(dev);
>  	}
> -	DRM_DEBUG("%d\n", ctx->handle);
> -	if (ctx->handle < 0) {
> +	DRM_DEBUG("ctxbitmap is error code %d\n", ret);
> +	if (ret < 0) {
>  		DRM_DEBUG("Not enough free contexts.\n");
>  		/* Should this return -EBUSY instead? */
>  		return -ENOMEM;
>  	}
> +	/* valid context is >= 0 */
> +	ctx->handle = (drm_context_t)ret;
>  
>  	ctx_entry = kmalloc(sizeof(*ctx_entry), GFP_KERNEL);
>  	if (!ctx_entry) {
> -- 
> 2.1.4
> 
