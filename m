Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E508BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0D220863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0D220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440845AbeKXEIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:08:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:35325 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391344AbeKXEIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:08:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2018 09:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,270,1539673200"; 
   d="scan'208";a="107130010"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 23 Nov 2018 09:23:09 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 23 Nov 2018 19:23:08 +0200
Date:   Fri, 23 Nov 2018 19:23:08 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>, nd <nd@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/43] drm/fourcc: Add format helpers for checking YUV
 sub-sampling
Message-ID: <20181123172308.GR9144@intel.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-13-paul.kocialkowski@bootlin.com>
 <20181123165532.GA22326@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123165532.GA22326@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 04:55:33PM +0000, Ayan Halder wrote:
> On Fri, Nov 23, 2018 at 10:24:44AM +0100, Paul Kocialkowski wrote:
> 
> Hi Paul,
> 
> > This introduces new format helpers that use the previously-introduced
> > format info helpers for checking YUV sub-sampling.
> > 
> > Only the format fourcc is required by these helpers and the formats are
> > iterated from the list.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/drm_fourcc.c | 105 +++++++++++++++++++++++++++++++++++
> >  include/drm/drm_fourcc.h     |   5 ++
> >  2 files changed, 110 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index b56e773f9f63..6d395c586ad5 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -492,6 +492,111 @@ bool drm_format_is_yuv_planar(uint32_t format)
> >  }
> >  EXPORT_SYMBOL(drm_format_is_yuv_planar);
> >  
> > +/**
> > + * drm_format_is_yuv_sampling_410 - check that the format is a YUV format with
> > + * 4:1:0 sub-sampling
> > + * @format: pixel format
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format is a YUV format with 4:1:0
> > + * sub-sampling.
> > + */
> > +bool drm_format_is_yuv_sampling_410(uint32_t format)
> > +{
> > +	const struct drm_format_info *info;
> > +
> > +	info = drm_format_info(format);
> > +	if (!info)
> > +		return false;

Looks like you're doing a lot of drm_format_info(fb->format->format),
which doesn't make sense. Not to mention that each lookup is a linear
search so the costs may start to add up.

Unless there's a really good reason I'd rather we try to remove all
the current helpers that do these lookups, and not add any more.

> > +
> > +	return drm_format_info_is_yuv_sampling_410(info);
> > +}
> > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_410);
> > +
> > +/**
> > + * drm_format_is_yuv_sampling_411 - check that the format is a YUV format with
> > + * 4:1:1 sub-sampling
> > + * @format: pixel format
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format is a YUV format with 4:1:1
> > + * sub-sampling.
> > + */
> > +bool drm_format_is_yuv_sampling_411(uint32_t format)
> > +{
> > +	const struct drm_format_info *info;
> > +
> > +	info = drm_format_info(format);
> > +	if (!info)
> > +		return false;
> > +
> > +	return drm_format_info_is_yuv_sampling_411(info);
> > +}
> > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_411);
> > +
> > +/**
> > + * drm_format_is_yuv_sampling_420 - check that the format is a YUV format with
> > + * 4:2:0 sub-sampling
> > + * @format: pixel format
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format is a YUV format with 4:2:0
> > + * sub-sampling.
> > + */
> > +bool drm_format_is_yuv_sampling_420(uint32_t format)
> > +{
> > +	const struct drm_format_info *info;
> > +
> > +	info = drm_format_info(format);
> > +	if (!info)
> > +		return false;
> > +
> > +	return drm_format_info_is_yuv_sampling_420(info);
> > +}
> > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_420);
> > +
> > +/**
> > + * drm_format_is_yuv_sampling_422 - check that the format is a YUV format with
> > + * 4:2:2 sub-sampling
> > + * @format: pixel format
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format is a YUV format with 4:2:2
> > + * sub-sampling.
> > + */
> > +bool drm_format_is_yuv_sampling_422(uint32_t format)
> > +{
> > +	const struct drm_format_info *info;
> > +
> > +	info = drm_format_info(format);
> > +	if (!info)
> > +		return false;
> > +
> > +	return drm_format_info_is_yuv_sampling_422(info);
> > +}
> > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_422);
> > +
> > +/**
> > + * drm_format_is_yuv_sampling_444 - check that the format is a YUV format with
> > + * 4:4:4 sub-sampling
> > + * @format: pixel format
> > + *
> > + * Returns:
> > + * A boolean indicating whether the format is a YUV format with 4:4:4
> > + * sub-sampling.
> > + */
> > +bool drm_format_is_yuv_sampling_444(uint32_t format)
> > +{
> > +	const struct drm_format_info *info;
> > +
> > +	info = drm_format_info(format);
> > +	if (!info)
> > +		return false;
> > +
> > +	return drm_format_info_is_yuv_sampling_444(info);
> > +}
> > +EXPORT_SYMBOL(drm_format_is_yuv_sampling_444);
> > +
> >  /**
> >   * drm_format_info_block_width - width in pixels of block.
> >   * @info: pixel format info
> > diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> > index d170b7b323f7..cf082d8b6ad4 100644
> > --- a/include/drm/drm_fourcc.h
> > +++ b/include/drm/drm_fourcc.h
> > @@ -278,6 +278,11 @@ bool drm_format_is_yuv(uint32_t format);
> >  bool drm_format_is_yuv_packed(uint32_t format);
> >  bool drm_format_is_yuv_semiplanar(uint32_t format);
> >  bool drm_format_is_yuv_planar(uint32_t format);
> > +bool drm_format_is_yuv_sampling_410(uint32_t format);
> > +bool drm_format_is_yuv_sampling_411(uint32_t format);
> > +bool drm_format_is_yuv_sampling_420(uint32_t format);
> > +bool drm_format_is_yuv_sampling_422(uint32_t format);
> > +bool drm_format_is_yuv_sampling_444(uint32_t format);
> >  unsigned int drm_format_info_block_width(const struct drm_format_info *info,
> >  					 int plane);
> >  unsigned int drm_format_info_block_height(const struct drm_format_info *info,
> > -- 
> > 2.19.1
> > 
> From patches [PATCH v2 08/43] till [PATCH v2 12/43], looks good to me.
> 
> How about clubbing all the drm_format_helper functions together in a
> separate file (call it drm_fourcc_helper.c)? This way, we could
> keep the __drm_format_info[] only drm_fourcc.c.
> 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
