Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE22C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB07D213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB07D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJCWka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:40:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:14596 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCWka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:40:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 08:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="91856341"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 03 Oct 2018 08:51:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 03 Oct 2018 18:51:23 +0300
Date:   Wed, 3 Oct 2018 18:51:23 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        stable <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm: fb-helper: Validate requested pixel format against
 bpp
Message-ID: <20181003155123.GJ9144@intel.com>
References: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
 <CAKMK7uFP3bMcNSY2L9ZmvFPz6KB51_gMnZ-b7FPCz3NEOafi=w@mail.gmail.com>
 <20181003123047.GK9144@intel.com>
 <1538577004.11140.5.camel@synopsys.com>
 <CAKMK7uGEGQbg=Us3_C25JXvKR084fP0qLif1hHttMYq=xNAZ7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uGEGQbg=Us3_C25JXvKR084fP0qLif1hHttMYq=xNAZ7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 05:29:34PM +0200, Daniel Vetter wrote:
> On Wed, Oct 3, 2018 at 4:30 PM Eugeniy Paltsev
> <eugeniy.paltsev@synopsys.com> wrote:
> >
> > On Wed, 2018-10-03 at 15:30 +0300, Ville Syrjälä wrote:
> > > On Wed, Oct 03, 2018 at 01:36:00PM +0200, Daniel Vetter wrote:
> > > > On Wed, Oct 3, 2018 at 1:05 PM Eugeniy Paltsev
> > > > <Eugeniy.Paltsev@synopsys.com> wrote:
> > > > >
> > > > > Validate requested pixel format against bits_per_pixel to reject
> > > > > invalid formats with subcomponents length sum is greater than requested
> > > > > bits_per_pixel.
> > > > >
> > > > > weston 5.0.0 with fbdev backend tries to set up an ARGB x8r8g8b8 pixel
> > > > > format without bits_per_pixel updating. So it can request
> > > > > x8r8g8b8 with 16 bpp which is obviously incorrect and should be
> > > > > rejected.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > > >
> > > > drm fbdev emulation doesn't support changing the pixel format at all.
> > > > I think we should reject all such request, not just the invalid ones.
> > > > Can you pls respin?
> > >
> > > FYI I once posted a patch to tighten up the fb-helper pixel format
> > > stuff:
> > > https://patchwork.freedesktop.org/patch/203189/
> >
> >
> > Hi Daniel,
> >
> > will you take Ville's patch or should I create the new one which is only related
> > to new pixel format validation in drm_fb_helper_check_var() ?
> 
> Ville's patch isn't the bugfix we're looking for, but a draft version
> of what adding proper format support in drm's fbdev emulation could
> look like. With lots&lots of open questions.

Actually it does pretty much what you seem to be asking for.
Ie. reject any attempt to change the pixel format. Not really
sure how to do it much more minimally.

Hmm. Oh there is a more minimal way actually. I mistakenly remembered
that fbdev clobbers info->var already before check_var(), but actually
it only does that before set_par(). So I guess all we really need is
to compare the fb_bitfields/bits_per_pixel/etc. between info->var
and the passed in var.

> Not anywhere near ready
> for merging, and definitely not stable backport material.
> 
> So yes, still want the minimal bugfix.
> -Daniel
> 
> >
> >
> > > > Thanks, Daniel
> > > >
> > > > > ---
> > > > >  drivers/gpu/drm/drm_fb_helper.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > > > > index 16ec93b75dbf..4f39da07f053 100644
> > > > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > > > @@ -1610,6 +1610,13 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> > > > >                 return -EINVAL;
> > > > >         }
> > > > >
> > > > > +       if ((var->green.length + var->blue.length + var->red.length +
> > > > > +           var->transp.length) > var->bits_per_pixel) {
> > > > > +               DRM_DEBUG("fb requested pixel format can't fit in %d bpp\n",
> > > > > +                         var->bits_per_pixel);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > >         switch (var->bits_per_pixel) {
> > > > >         case 16:
> > > > >                 depth = (var->green.length == 6) ? 16 : 15;
> > > > > --
> > > > > 2.14.4
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.freedesktop.org_mailman_listinfo_dri-2Ddevel&d=DwIDAw&c=DPL6_X_6JkXFx7AXWqB0tg&r=ZlJN
> > > > > 1MriPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=f12ZyEESIeavtqCUKutiZ9F6xtRFC2UUvdqnM4ywBx8&s=CPS8taMiYbIgXo-fxhqErOJXvO6PMTzmr-BNnGJIoy0&e=
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > +41 (0) 79 365 57 48 - https://urldefense.proofpoint.com/v2/url?u=http-3A__blog.ffwll.ch&d=DwIDAw&c=DPL6_X_6JkXFx7AXWqB0tg&r=ZlJN1MriPUTkBKCrPSx67
> > > > GmaplEUGcAEk9yPtCLdUXI&m=f12ZyEESIeavtqCUKutiZ9F6xtRFC2UUvdqnM4ywBx8&s=Vt8OX9s9ljSK6GDgbnwsF-Yd35fbBUfe8SBV2jPnVaQ&e=
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.freedesktop.org_mailman_listinfo_dri-2Ddevel&d=DwIDAw&c=DPL6_X_6JkXFx7AXWqB0tg&r=ZlJN1M
> > > > riPUTkBKCrPSx67GmaplEUGcAEk9yPtCLdUXI&m=f12ZyEESIeavtqCUKutiZ9F6xtRFC2UUvdqnM4ywBx8&s=CPS8taMiYbIgXo-fxhqErOJXvO6PMTzmr-BNnGJIoy0&e=
> > >
> > >
> > --
> >  Eugeniy Paltsev
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
Ville Syrjälä
Intel
