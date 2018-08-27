Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16193C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06B208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06B208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeH0Vzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:55:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:57927 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeH0Vzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:55:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 11:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="75987960"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 27 Aug 2018 11:07:51 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 27 Aug 2018 21:07:50 +0300
Date:   Mon, 27 Aug 2018 21:07:50 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH v4] drm/i915: Re-apply "Perform link quality
 check, unconditionally during long pulse"
Message-ID: <20180827180750.GU5565@intel.com>
References: <20180825191035.3945-1-lyude@redhat.com>
 <20180827120844.GR5565@intel.com>
 <d2a170d48fb58d0115898b19765e32cbeceee42c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2a170d48fb58d0115898b19765e32cbeceee42c.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:45:48PM -0400, Lyude Paul wrote:
> On Mon, 2018-08-27 at 15:08 +0300, Ville Syrjälä wrote:
> > On Sat, Aug 25, 2018 at 03:10:35PM -0400, Lyude Paul wrote:
> > > From: Jan-Marek Glogowski <glogow@fbihome.de>
> > > 
> > > This re-applies the workaround for "some DP sinks, [which] are a
> > > little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
> > > quality check unconditionally during long pulse").
> > > It makes the secondary AOC E2460P monitor connected via DP to an
> > > acer Veriton N4640G usable again.
> > > 
> > > This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
> > > DP link retraining into the ->post_hotplug() hook")
> > > 
> > > Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> > > ->post_hotplug() hook")
> > > [Cleaned up commit message, added stable cc]
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> > > Cc: stable@vger.kernel.org
> > > ---
> > > Resending this to update patchwork; will push in a little bit
> > > 
> > >  drivers/gpu/drm/i915/intel_dp.c | 33 +++++++++++++++++++--------------
> > >  1 file changed, 19 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > b/drivers/gpu/drm/i915/intel_dp.c
> > > index b3f6f04c3c7d..db8515171270 100644
> > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > @@ -4333,18 +4333,6 @@ intel_dp_needs_link_retrain(struct intel_dp
> > > *intel_dp)
> > >  	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
> > >  }
> > >  
> > > -/*
> > > - * If display is now connected check links status,
> > > - * there has been known issues of link loss triggering
> > > - * long pulse.
> > > - *
> > > - * Some sinks (eg. ASUS PB287Q) seem to perform some
> > > - * weird HPD ping pong during modesets. So we can apparently
> > > - * end up with HPD going low during a modeset, and then
> > > - * going back up soon after. And once that happens we must
> > > - * retrain the link to get a picture. That's in case no
> > > - * userspace component reacted to intermittent HPD dip.
> > > - */
> > >  int intel_dp_retrain_link(struct intel_encoder *encoder,
> > >  			  struct drm_modeset_acquire_ctx *ctx)
> > >  {
> > > @@ -5031,7 +5019,8 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
> > >  }
> > >  
> > >  static int
> > > -intel_dp_long_pulse(struct intel_connector *connector)
> > > +intel_dp_long_pulse(struct intel_connector *connector,
> > > +		    struct drm_modeset_acquire_ctx *ctx)
> > >  {
> > >  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
> > >  	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
> > > @@ -5090,6 +5079,22 @@ intel_dp_long_pulse(struct intel_connector
> > > *connector)
> > >  		 */
> > >  		status = connector_status_disconnected;
> > >  		goto out;
> > > +	} else {
> > > +		/*
> > > +		 * If display is now connected check links status,
> > > +		 * there has been known issues of link loss triggering
> > > +		 * long pulse.
> > > +		 *
> > > +		 * Some sinks (eg. ASUS PB287Q) seem to perform some
> > > +		 * weird HPD ping pong during modesets. So we can apparently
> > > +		 * end up with HPD going low during a modeset, and then
> > > +		 * going back up soon after. And once that happens we must
> > > +		 * retrain the link to get a picture. That's in case no
> > > +		 * userspace component reacted to intermittent HPD dip.
> > > +		 */
> > > +		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)-
> > > >base;
> > > +
> > > +		intel_dp_retrain_link(encoder, ctx);
> > 
> > We should really have a comment here that this is purely duct tape for
> > sinks that fail to signal a hpd when the link goes bad (either that or
> > we fail to process the hpd correctly).
> I'm fine with adding another patch to clarify that comment as well
> 
> > 
> > I suppose a better way to do this hack would be to do the link quality
> > check at the end of modeset, or from a delayed work. As is this depends
> > on userspace/fbdev doing an explicit probe after the modeset which seems
> > pretty fragile.
> I think having that at the end of a modeset in addition to this would be a
> good idea as well, I don't see any harm in having an additional check in the
> long pulse handler in case something causes the link to become unstable at
> some point in the future after the initial modeset

We already have that via the hotplug hook. The problem here is that there
is apparently no hpd signalled by the sink.

Someone should probably rename intel_dp_long_pulse() to something
else so that people don't get the wrong impression that it's somehow
dedicated to handling long hpds. In fact just 
s/intel_dp_long_pulse()/intel_dp_detect()/ and sucking the few lines of
extra code into the function might be the right way to go.

> 
> Jan, do you think you could provide some dmesg logs for this issue?
> > 
> > >  	}
> > >  
> > >  	/*
> > > @@ -5151,7 +5156,7 @@ intel_dp_detect(struct drm_connector *connector,
> > >  				return ret;
> > >  		}
> > >  
> > > -		status = intel_dp_long_pulse(intel_dp->attached_connector);
> > > +		status = intel_dp_long_pulse(intel_dp->attached_connector,
> > > ctx);
> > >  	}
> > >  
> > >  	intel_dp->detect_done = false;
> > > -- 
> > > 2.17.1
> > > 
> > > _______________________________________________
> > > Intel-gfx mailing list
> > > Intel-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> > 
> > 
> -- 
> Cheers,
> 	Lyude Paul

-- 
Ville Syrjälä
Intel
