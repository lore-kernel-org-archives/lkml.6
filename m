Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA209C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F220879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeL1PJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:09:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47131 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeL1PJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:09:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 13082209ED; Fri, 28 Dec 2018 16:09:39 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-80-230.w90-88.abo.wanadoo.fr [90.88.22.230])
        by mail.bootlin.com (Postfix) with ESMTPSA id C6C5C2070E;
        Fri, 28 Dec 2018 16:09:28 +0100 (CET)
Message-ID: <f3358cab41351011ebe7d4a3670682a11df9aed4.camel@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Allow fb modifiers early enough to fill
 IN_FORMATS property
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Date:   Fri, 28 Dec 2018 16:09:28 +0100
In-Reply-To: <20181228120848.GS9058@dvetter-linux.ger.corp.intel.com>
References: <20181224122551.9912-1-paul.kocialkowski@bootlin.com>
         <878t0amtjf.fsf@anholt.net>
         <20181228120848.GS9058@dvetter-linux.ger.corp.intel.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-28 at 13:08 +0100, Daniel Vetter wrote:
> On Thu, Dec 27, 2018 at 03:36:20PM -0800, Eric Anholt wrote:
> > Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> > 
> > > The KMS mode_config elements are currently configured in vc4_kms_load,
> > > that is called after all components are binded (component_bind_all).
> > > However, the CRTC component (for the Pixel Valve) needs to access the
> > > allow_fb_modifiers element at bind time, when initializing its planes
> > > through drm_universal_plane_init.
> > > 
> > > This helpers checks allow_fb_modifiers to decide whether to fill the
> > > IN_FORMATS property. Because allow_fb_modifiers is still set to false
> > > at this point, the property is never filled and userspace cannot
> > > retrieve the combination of supported formats and modifiers.
> > > 
> > > Fix this by setting allow_fb_modifiers right after calling
> > > drm_mode_config_init (which initializes the structure), before binding
> > > the components of the driver.
> > 
> > This makes me wonder if the flag could be removed and replaced with "did
> > non-NULL modifiers get supplied to plane init?"  I think I've tripped
> > over this flag in other KMS hacking, too.
> 
> Sounds like a good idea to me. Just setting it in plane_init should work I
> think ...

Yeah, we probably need to keep the flag around since it's used in
various places, but we could totally have it auto-set as soon as a
plane is registered with a list of modifiers.

I was also thinking of allowing the core to fill-in the IN_FORMATS prop
even without this flag set, which would only list formats (but not
modifiers).

What do you think?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

