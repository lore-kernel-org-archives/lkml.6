Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeBBQaT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:30:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeBBQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:30:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7735B60364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 2 Feb 2018 09:30:06 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno/a5xx_debugfs: fix potential NULL pointer
 dereference
Message-ID: <20180202163006.GA878@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180202123223.GA4410@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202123223.GA4410@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:32:23AM -0600, Gustavo A. R. Silva wrote:
> _minor_ is being dereferenced before it is null checked, hence there
> is a potential null pointer dereference. Fix this by moving the pointer
> dereference after _minor_ has been null checked.
> 
> Fixes: 024ad8df763f ("drm/msm: add a5xx specific debugfs")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> 
> I wonder if a better solution for this would be to WARN_ON in case _minor_
> happens to be NULL and return -EINVAL, instead of just returning zero.
> 
> Something like:
> 
> struct drm_device *dev;
> 
> if (WARN_ON(!minor)
> 	return -EINVAL;
> 
> dev = minor->dev;
> 
> What do you think?

In my opinion everything in debugfs is optional. I'm not sure if it is even
possible for dev->primary, dev->render or dev->control to be NULL from the DRM
core but if so I think the failure should be silent.

Jordan
> 
>  drivers/gpu/drm/msm/adreno/a5xx_debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> index 6b27941..059ec7d 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
> @@ -159,13 +159,15 @@ DEFINE_SIMPLE_ATTRIBUTE(reset_fops, NULL, reset_set, "%llx\n");
>  
>  int a5xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor)
>  {
> -	struct drm_device *dev = minor->dev;
> +	struct drm_device *dev;
>  	struct dentry *ent;
>  	int ret;
>  
>  	if (!minor)
>  		return 0;
>  
> +	dev = minor->dev;
> +
>  	ret = drm_debugfs_create_files(a5xx_debugfs_list,
>  			ARRAY_SIZE(a5xx_debugfs_list),
>  			minor->debugfs_root, minor);
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
