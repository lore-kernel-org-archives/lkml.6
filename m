Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A67C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9734E20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9734E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeJPV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:26:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:20967 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeJPV0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:26:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 06:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="95675238"
Received: from tletko-mobl3.ger.corp.intel.com (HELO [10.252.39.57]) ([10.252.39.57])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2018 06:36:21 -0700
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <57b40f9f-24d2-27de-4895-5a76ff267643@linux.intel.com>
Date:   Tue, 16 Oct 2018 15:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 15-10-18 om 19:05 schreef Rodrigo Siqueira:
> For historical reason, the function drm_wait_vblank_ioctl always return
> -EINVAL if something gets wrong. This scenario limits the flexibility
> for the userspace make detailed verification of the problem and take
> some action. In particular, the validation of “if (!dev->irq_enabled)”
> in the drm_wait_vblank_ioctl is responsible for checking if the driver
> support vblank or not. If the driver does not support VBlank, the
> function drm_wait_vblank_ioctl returns EINVAL which does not represent
> the real issue; this patch changes this behavior by return EOPNOTSUPP.
> Additionally, some operations are unsupported by this function, and
> returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> libdrm, which is used by many compositors; because of this, it is
> important to check if this change breaks any compositor. In this sense,
> the following projects were examined:
>
> * Drm-hwcomposer
> * Kwin
> * Sway
> * Wlroots
> * Wayland-core
> * Weston
> * Xorg (67 different drivers)
>
> For each repository the verification happened in three steps:
>
> * Update the main branch
> * Look for any occurrence "drmWaitVBlank" with the command:
>   git grep -n "drmWaitVBlank"
> * Look in the git history of the project with the command:
>   git log -SdrmWaitVBlank
>
> Finally, none of the above projects validate the use of EINVAL which
> make safe, at least for these projects, to change the return values.
>
> Change since V1:
>  Daniel Vetter and Chris Wilson
>  - Replace ENOTTY by EOPNOTSUPP
>  - Return EINVAL if the parameters are wrong
>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 98e091175921..80f5a3bb427e 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>  	unsigned int flags, pipe, high_pipe;
>  
>  	if (!dev->irq_enabled)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
Change to -EIO?

If userspace would ever print this out, it would print the following
confusing message to userspace:
"Operation not supported on transport endpoint"
>  
>  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
I would keep this -EINVAL, tbh and making it part of the below if statement..
>  	if (vblwait->request.type &
>  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |

Cheers,

Maarten

