Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A944C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5F2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC5F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeJCTTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:19:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:56665 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCTTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:19:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 05:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="91801167"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 03 Oct 2018 05:30:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:30:47 +0300
Date:   Wed, 3 Oct 2018 15:30:47 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Dave Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: fb-helper: Validate requested pixel format against
 bpp
Message-ID: <20181003123047.GK9144@intel.com>
References: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
 <CAKMK7uFP3bMcNSY2L9ZmvFPz6KB51_gMnZ-b7FPCz3NEOafi=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uFP3bMcNSY2L9ZmvFPz6KB51_gMnZ-b7FPCz3NEOafi=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 01:36:00PM +0200, Daniel Vetter wrote:
> On Wed, Oct 3, 2018 at 1:05 PM Eugeniy Paltsev
> <Eugeniy.Paltsev@synopsys.com> wrote:
> >
> > Validate requested pixel format against bits_per_pixel to reject
> > invalid formats with subcomponents length sum is greater than requested
> > bits_per_pixel.
> >
> > weston 5.0.0 with fbdev backend tries to set up an ARGB x8r8g8b8 pixel
> > format without bits_per_pixel updating. So it can request
> > x8r8g8b8 with 16 bpp which is obviously incorrect and should be
> > rejected.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> 
> drm fbdev emulation doesn't support changing the pixel format at all.
> I think we should reject all such request, not just the invalid ones.
> Can you pls respin?

FYI I once posted a patch to tighten up the fb-helper pixel format
stuff:
https://patchwork.freedesktop.org/patch/203189/

> 
> Thanks, Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 16ec93b75dbf..4f39da07f053 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1610,6 +1610,13 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >                 return -EINVAL;
> >         }
> >
> > +       if ((var->green.length + var->blue.length + var->red.length +
> > +           var->transp.length) > var->bits_per_pixel) {
> > +               DRM_DEBUG("fb requested pixel format can't fit in %d bpp\n",
> > +                         var->bits_per_pixel);
> > +               return -EINVAL;
> > +       }
> > +
> >         switch (var->bits_per_pixel) {
> >         case 16:
> >                 depth = (var->green.length == 6) ? 16 : 15;
> > --
> > 2.14.4
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
