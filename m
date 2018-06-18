Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D680D20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D680D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755130AbeFRQUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:20:38 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:39041 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754136AbeFRQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:20:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3D779182CF673;
        Mon, 18 Jun 2018 16:20:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: house72_7967792fd2f5e
X-Filterd-Recvd-Size: 4158
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jun 2018 16:20:34 +0000 (UTC)
Message-ID: <1d81ec0834a57d4a864ed05611614192ba5eb3d6.camel@perches.com>
Subject: Re: [PATCH] drm/i915/gvt: Use ARRAY_SIZE macro
From:   Joe Perches <joe@perches.com>
To:     rajan.vaja@gmail.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 09:20:32 -0700
In-Reply-To: <1529308106-30716-1-git-send-email-rajan.vaja@softnautics.com>
References: <1529308106-30716-1-git-send-email-rajan.vaja@softnautics.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 13:18 +0530, rajan.vaja@gmail.com wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof
> an element. This fixes below warning reported by Coccinelle:
> drivers/gpu/drm//i915/gvt/vgpu.c:122:30-31: WARNING: Use ARRAY_SIZE
[]
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
[]
> @@ -119,7 +119,7 @@ int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
>  	 */
>  	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
>  	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;
> -	num_types = sizeof(vgpu_types) / sizeof(vgpu_types[0]);
> +	num_types = ARRAY_SIZE(vgpu_types);
>  
>  	gvt->types = kzalloc(num_types * sizeof(struct intel_vgpu_type),
>  			     GFP_KERNEL);

It seems you are not using -next as this alloc has
already been changed to kcalloc.

It'd be better to get rid of num_types altogether and
use ARRAY_SIZE everywhere instead.

There are also string overflow possibilities in the
function where sprintf should probably use snprintf.

Perhaps:
'
int intel_gvt_init_vgpu_types(struct intel_gvt *gvt)
{
	unsigned int i, low_avail, high_avail;
	unsigned int min_low;

	/* vGPU type name is defined as GVTg_Vx_y which contains
	 * physical GPU generation type (e.g V4 as BDW server, V5 as
	 * SKL server).
	 *
	 * Depend on physical SKU resource, might see vGPU types like
	 * GVTg_V4_8, GVTg_V4_4, GVTg_V4_2, etc. We can create
	 * different types of vGPU on same physical GPU depending on
	 * available resource. Each vGPU type will have "avail_instance"
	 * to indicate how many vGPU instance can be created for this
	 * type.
	 *
	 */
	low_avail = gvt_aperture_sz(gvt) - HOST_LOW_GM_SIZE;
	high_avail = gvt_hidden_sz(gvt) - HOST_HIGH_GM_SIZE;

	gvt->types = kcalloc(ARRAY_SIZE(vgpu_types),
			     sizeof(struct intel_vgpu_type), GFP_KERNEL);
	if (!gvt->types)
		return -ENOMEM;

	min_low = MB_TO_BYTES(32);
	for (i = 0; i < ARRAY_SIZE(vgpu_types); i++) {
		if (low_avail / vgpu_types[i].low_mm == 0)
			break;

		gvt->types[i].low_gm_size = vgpu_types[i].low_mm;
		gvt->types[i].high_gm_size = vgpu_types[i].high_mm;
		gvt->types[i].fence = vgpu_types[i].fence;

		if (vgpu_types[i].weight < 1 ||
		    vgpu_types[i].weight > VGPU_MAX_WEIGHT)
			return -EINVAL;

		gvt->types[i].weight = vgpu_types[i].weight;
		gvt->types[i].resolution = vgpu_types[i].edid;
		gvt->types[i].avail_instance =
			min(low_avail / vgpu_types[i].low_mm,
			    high_avail / vgpu_types[i].high_mm);

		if (IS_GEN8(gvt->dev_priv))
			snprintf(gvt->types[i].name, sizeof(gvt->types[i].name),
				 "GVTg_V4_%s", vgpu_types[i].name);
		else if (IS_GEN9(gvt->dev_priv))
			snprintf(gvt->types[i].name, sizeof(gvt->types[i].name),
				 "GVTg_V5_%s", vgpu_types[i].name);

		gvt_dbg_core("type[%d]: %s avail %u low %u high %u fence %u weight %u res %s\n",
			     i, gvt->types[i].name,
			     gvt->types[i].avail_instance,
			     gvt->types[i].low_gm_size,
			     gvt->types[i].high_gm_size, gvt->types[i].fence,
			     gvt->types[i].weight,
			     vgpu_edid_str(gvt->types[i].resolution));
	}

	gvt->num_types = i;

	return 0;
}
