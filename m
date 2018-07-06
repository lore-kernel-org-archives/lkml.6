Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D12C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CF52154B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CF52154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGFQco (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:32:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:25744 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932724AbeGFQcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:32:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 09:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,316,1526367600"; 
   d="scan'208";a="72777425"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 06 Jul 2018 09:32:36 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 06 Jul 2018 19:32:35 +0300
Date:   Fri, 6 Jul 2018 19:32:35 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] drm: Add generic colorkey properties for DRM
 planes
Message-ID: <20180706163235.GO5565@intel.com>
References: <20180603220059.17670-1-digetx@gmail.com>
 <a2e6e02b-bc6c-a411-0797-99e1bdb6674a@gmail.com>
 <20180706141010.GJ5565@intel.com>
 <2295190.xHWjP7Ltc3@dimapc>
 <20180706154027.GB17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180706154027.GB17271@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:40:27PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 06, 2018 at 05:58:50PM +0300, Dmitry Osipenko wrote:
> > On Friday, 6 July 2018 17:10:10 MSK Ville Syrjälä wrote:
> > > IIRC my earlier idea was to have different colorkey modes for the
> > > min+max and value+mask modes. That way userspace might actually have
> > > some chance of figuring out which bits of state actually do something.
> > > Although for Intel hw I think the general rule is that min+max for YUV,
> > > value+mask for RGB, so it's still not 100% clear what to pick if the
> > > plane supports both.
> > > 
> > > I guess one alternative would be to have min+max only, and the driver
> > > would reject 'min != max' if it only uses a single value?
> > > 
> > 
> > You should pick both and reject unsupported property values based on the 
> > planes framebuffer format. So it will be possible to set unsupported values 
> > while plane is disabled because it doesn't have an associated framebuffer and 
> > then atomic check will fail to enable plane if property values are invalid for 
> > the given format.
> 
> The colorkey which is attached to a plane 'A' is not applied to plane
> 'A', so the format of plane 'A' is not relevant.  The colorkey is
> applied to some other plane which will be below this plane in terms
> of the plane blending operation.
> 
> What if you have several planes below plane 'A' with differing
> framebuffer formats - maybe an ARGB8888 plane and a ARGB1555 plane -
> do you decide to limit the colorkey to 8bits per channel, or to
> ARGB1555 format?
> 
> The answer is, of course, hardware dependent - generic code can't
> know the details of the colorkey implementation, which could be one
> of:
> 
>   lower plane data -> expand to 8bpc -> match ARGB8888 colorkey
>   lower plane data -> match ARGB8888 reduced to plane compatible colorkey
> 
> which will give different results depending on the format of the
> lower plane data.

Yeah. This is one of the other issues I highlighted previously. On some
Intel hw you enable the dst colorkey on the lower plane where you paint
the colorkey, on others you enable it on the plane above that gets
shown/hidden based on the key match on the lower plane. I think on most
of our hardware dst keying only ever happens between two planes, even
if more planes are enabled on the crtc. But there is at least one
exception where you can have two overlay planes that get keyed against
the same primary plane.

I was questioning which one is the better model for the uapi. Either
way you still have the uncertainty of which planes actually participate
in the keying process. One way around that would be to expose some kind
of plane mask which would indicate the set of planes taking part in the
keying process. I think for that to work we would have to move to a
model where you enable the dst key on the lower plane where you paint
the color key, otherwise having multiple bits set in the mask wouldn't
make sense. That would perhaps also make it more clear what the
format of the color key will be.

So as an example that exception Intel hw case would have:
 overlay 2: key_mode={src,none}
 overlay 1: key_mode={src,none}
 primary:   key_mode={dst,none}, dst_key_plane_mask=0x6

to indicate that both overlay planes participate in the keying
process.

Whereas most other Intel hw would have:
 overlay 2: key_mode={src,none}
 overlay 1: key_mode={src,none}
 primary:   key_mode={dst,none}, dst_key_plane_mask=0x2

to indicate that only the overlay immediately above the primary
will participate.

-- 
Ville Syrjälä
Intel
