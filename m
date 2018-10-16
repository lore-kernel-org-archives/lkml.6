Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B874AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF702148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF702148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeJQBTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:19:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:55348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeJQBTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:19:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="99721395"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 16 Oct 2018 10:28:03 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 Oct 2018 20:28:03 +0300
Date:   Tue, 16 Oct 2018 20:28:03 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181016172803.GH9144@intel.com>
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <57b40f9f-24d2-27de-4895-5a76ff267643@linux.intel.com>
 <20181016163831.GA31561@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016163831.GA31561@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:38:31PM +0200, Daniel Vetter wrote:
> On Tue, Oct 16, 2018 at 03:36:20PM +0200, Maarten Lankhorst wrote:
> > Op 15-10-18 om 19:05 schreef Rodrigo Siqueira:
> > > For historical reason, the function drm_wait_vblank_ioctl always return
> > > -EINVAL if something gets wrong. This scenario limits the flexibility
> > > for the userspace make detailed verification of the problem and take
> > > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > > support vblank or not. If the driver does not support VBlank, the
> > > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > > Additionally, some operations are unsupported by this function, and
> > > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > > libdrm, which is used by many compositors; because of this, it is
> > > important to check if this change breaks any compositor. In this sense,
> > > the following projects were examined:
> > >
> > > * Drm-hwcomposer
> > > * Kwin
> > > * Sway
> > > * Wlroots
> > > * Wayland-core
> > > * Weston
> > > * Xorg (67 different drivers)
> > >
> > > For each repository the verification happened in three steps:
> > >
> > > * Update the main branch
> > > * Look for any occurrence "drmWaitVBlank" with the command:
> > >   git grep -n "drmWaitVBlank"
> > > * Look in the git history of the project with the command:
> > >   git log -SdrmWaitVBlank
> > >
> > > Finally, none of the above projects validate the use of EINVAL which
> > > make safe, at least for these projects, to change the return values.
> > >
> > > Change since V1:
> > >  Daniel Vetter and Chris Wilson
> > >  - Replace ENOTTY by EOPNOTSUPP
> > >  - Return EINVAL if the parameters are wrong
> > >
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > > index 98e091175921..80f5a3bb427e 100644
> > > --- a/drivers/gpu/drm/drm_vblank.c
> > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> > >  	unsigned int flags, pipe, high_pipe;
> > >  
> > >  	if (!dev->irq_enabled)
> > > -		return -EINVAL;
> > > +		return -EOPNOTSUPP;
> > Change to -EIO?
> > 
> > If userspace would ever print this out, it would print the following
> > confusing message to userspace:
> > "Operation not supported on transport endpoint"
> 
> You're a bit late, EOPNOTSUPP is not established already in upstream for
> this. And -EIO is taken already for "the gpu is dead".
> 
> > >  
> > >  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > -		return -EINVAL;
> > > +		return -EOPNOTSUPP;
> > I would keep this -EINVAL, tbh and making it part of the below if statement..
> 
> We discussed this, it's different: This here is an ioctl flag that's no
> longer supported, the below is just an invalid request. Hence different
> errno.
> 
> I think you missed a bit with your bikeshed :-)

I think I too agree with the -EINVAL here as this flag is never
supported, whereas -EOPNOTSUPP seems to mean "this flag is still
valid, but not supported by your current hardware/driver
configuration".

Also drm_invalid_op() uses -EINVAL for deprecated features as well.

-- 
Ville Syrjälä
Intel
