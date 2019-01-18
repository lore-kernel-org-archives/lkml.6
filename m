Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94067C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfARQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:3667 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbfARQci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 08:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="127118149"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 18 Jan 2019 08:32:34 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 18 Jan 2019 18:32:33 +0200
Date:   Fri, 18 Jan 2019 18:32:33 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 23/23] drm/qxl: add overflow checks to
 qxl_mode_dumb_create()
Message-ID: <20190118163233.GM20097@intel.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-24-kraxel@redhat.com>
 <20190118154944.GH3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118154944.GH3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:49:44PM +0100, Daniel Vetter wrote:
> On Fri, Jan 18, 2019 at 01:20:20PM +0100, Gerd Hoffmann wrote:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> We already do all reasonable overflow checks in drm_mode_create_dumb(). If
> you don't trust them I think would be better time spent typing an igt to
> test this than adding redundant check in all drivers.
> 
> You're also missing one check for bpp underflows :-)

BTW I just noticed that we don't seem to validating 
create_dumb->flags at all. Someone should probably add some
checks for that, or mark it as deprecated in case we already
lost the battle with userspace stack garbage.

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/qxl/qxl_dumb.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
> > index 272d19b677..bed6d06ee4 100644
> > --- a/drivers/gpu/drm/qxl/qxl_dumb.c
> > +++ b/drivers/gpu/drm/qxl/qxl_dumb.c
> > @@ -37,11 +37,13 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
> >  	uint32_t handle;
> >  	int r;
> >  	struct qxl_surface surf;
> > -	uint32_t pitch, format;
> > +	uint32_t pitch, size, format;
> >  
> > -	pitch = args->width * ((args->bpp + 1) / 8);
> > -	args->size = pitch * args->height;
> > -	args->size = ALIGN(args->size, PAGE_SIZE);
> > +	if (check_mul_overflow(args->width, ((args->bpp + 1) / 8), &pitch))
> > +		return -EINVAL;
> > +	if (check_mul_overflow(pitch, args->height, &size))
> > +		return -EINVAL;
> > +	args->size = ALIGN(size, PAGE_SIZE);
> >  
> >  	switch (args->bpp) {
> >  	case 16:
> > -- 
> > 2.9.3
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
