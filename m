Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6EFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7285620883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7285620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeGKJcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:32:36 -0400
Received: from foss.arm.com ([217.140.101.70]:59798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbeGKJcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:32:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B406ED1;
        Wed, 11 Jul 2018 02:29:12 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED67F3F318;
        Wed, 11 Jul 2018 02:29:11 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 548AF6818E4; Wed, 11 Jul 2018 10:29:10 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:29:10 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 2/4] drm/arm/malidp: Implemented the size validation
 for AFBC framebuffers
Message-ID: <20180711092910.GO15340@e110455-lin.cambridge.arm.com>
References: <1531228737-5450-1-git-send-email-ayan.halder@arm.com>
 <1531228737-5450-3-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531228737-5450-3-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:18:55PM +0100, Ayan Kumar Halder wrote:
> AFBC buffers include additional metadata which increases the required
> allocation size. Implement the appropriate size validation and sanity
> checking for AFBC buffers.
> Added malidp specific function for framebuffer creation. This checks
> if the framebuffer has AFBC modifiers and if so, it verifies the
> necessary constraints on the size, alignment, offsets and pitch.
> 
> Changes from v2:
> - Replaced DRM_ERROR() with DRM_DEBUG_KMS() in
> malidp_verify_afbc_framebuffer_caps() and malidp_verify_afbc_framebuffer_size()
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 128 ++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/arm/malidp_hw.h  |   5 ++
>  2 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 8d20faa..262a830 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -35,6 +35,7 @@
>  #include "malidp_hw.h"
>  
>  #define MALIDP_CONF_VALID_TIMEOUT	250
> +#define AFBC_HEADER_SIZE		16
>  
>  static void malidp_write_gamma_table(struct malidp_hw_device *hwdev,
>  				     u32 data[MALIDP_COEFFTAB_NUM_COEFFS])
> @@ -245,8 +246,133 @@ static const struct drm_mode_config_helper_funcs malidp_mode_config_helpers = {
>  	.atomic_commit_tail = malidp_atomic_commit_tail,
>  };
>  
> +static bool
> +malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
> +				    const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	const struct drm_format_info *info;
> +
> +	if ((mode_cmd->modifier[0] >> 56) != DRM_FORMAT_MOD_VENDOR_ARM) {
> +		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
> +		return false;
> +	}
> +
> +	if (mode_cmd->modifier[0] &
> +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> +		DRM_DEBUG_KMS("Unsupported modifiers\n");
> +		return false;
> +	}
> +
> +	info = drm_get_format_info(dev, mode_cmd);
> +	if (!info) {
> +		DRM_DEBUG_KMS("Unable to get the format information\n");
> +		return false;
> +	}
> +
> +	if (info->num_planes != 1) {
> +		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> +		return false;
> +	}
> +
> +	if (mode_cmd->offsets[0] != 0) {
> +		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
> +		return false;
> +	}
> +
> +	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
> +			DRM_DEBUG_KMS("AFBC buffers must be aligned to 16 pixels\n");
> +			return false;
> +		}
> +		break;
> +	default:
> +		DRM_DEBUG_KMS("Unsupported AFBC block size\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool
> +malidp_verify_afbc_framebuffer_size(struct drm_device *dev,
> +				    struct drm_file *file,
> +				    const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	int n_superblocks = 0;
> +	const struct drm_format_info *info;
> +	struct drm_gem_object *objs = NULL;
> +	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
> +	u32 afbc_superblock_width = 0, afbc_size = 0;
> +
> +	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> +	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
> +		afbc_superblock_height = 16;
> +		afbc_superblock_width = 16;
> +		break;
> +	default:
> +		DRM_DEBUG_KMS("AFBC superblock size is not supported\n");
> +		return false;
> +	}
> +
> +	info = drm_get_format_info(dev, mode_cmd);
> +
> +	n_superblocks = (mode_cmd->width / afbc_superblock_width) *
> +		(mode_cmd->height / afbc_superblock_height);
> +
> +	afbc_superblock_size = info->cpp[0] * afbc_superblock_width *
> +		afbc_superblock_height;
> +
> +	afbc_size = ALIGN(n_superblocks * AFBC_HEADER_SIZE, 128);
> +
> +	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
> +		DRM_DEBUG_KMS("Invalid value of pitch (=%u) should be same as width (=%u) * cpp (=%u)\n",
> +			      mode_cmd->pitches[0], mode_cmd->width, info->cpp[0]);
> +		return false;
> +	}
> +
> +	objs = drm_gem_object_lookup(file, mode_cmd->handles[0]);
> +	if (!objs) {
> +		DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> +		return false;
> +	}
> +
> +	if (objs->size < afbc_size) {
> +		DRM_DEBUG_KMS("buffer size (%zu) too small for AFBC buffer size = %u\n",
> +			      objs->size, afbc_size);
> +		drm_gem_object_put_unlocked(objs);
> +		return false;
> +	}
> +
> +	drm_gem_object_put_unlocked(objs);
> +
> +	return true;
> +}
> +
> +static bool
> +malidp_verify_afbc_framebuffer(struct drm_device *dev, struct drm_file *file,
> +			       const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (malidp_verify_afbc_framebuffer_caps(dev, mode_cmd))
> +		return malidp_verify_afbc_framebuffer_size(dev, file, mode_cmd);
> +
> +	return false;
> +}
> +
> +struct drm_framebuffer *
> +malidp_fb_create(struct drm_device *dev, struct drm_file *file,
> +		 const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (mode_cmd->modifier[0]) {
> +		if (!malidp_verify_afbc_framebuffer(dev, file, mode_cmd))
> +			return ERR_PTR(-EINVAL);
> +	}
> +
> +	return drm_gem_fb_create(dev, file, mode_cmd);
> +}
> +
>  static const struct drm_mode_config_funcs malidp_mode_config_funcs = {
> -	.fb_create = drm_gem_fb_create,
> +	.fb_create = malidp_fb_create,
>  	.output_poll_changed = drm_fb_helper_output_poll_changed,
>  	.atomic_check = drm_atomic_helper_check,
>  	.atomic_commit = drm_atomic_helper_commit,
> diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
> index 41f4521..4390243 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.h
> +++ b/drivers/gpu/drm/arm/malidp_hw.h
> @@ -361,4 +361,9 @@ static inline void malidp_se_set_enh_coeffs(struct malidp_hw_device *hwdev)
>  
>  #define MALIDP_GAMMA_LUT_SIZE		4096
>  
> +#define AFBC_MOD_VALID_BITS (AFBC_FORMAT_MOD_BLOCK_SIZE_MASK | \
> +			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPLIT | \
> +			AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_CBR | \
> +			AFBC_FORMAT_MOD_TILED | AFBC_FORMAT_MOD_SC)
> +
>  #endif  /* __MALIDP_HW_H__ */
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
