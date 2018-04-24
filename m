Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756238AbeDXII6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:08:58 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50758 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756046AbeDXIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:08:46 -0400
Date: Tue, 24 Apr 2018 09:08:33 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
Message-ID: <20180424080833.GJ16141@n2100.armlinux.org.uk>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
> > On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
> >>  static int tda998x_remove(struct i2c_client *client)
> >>  {
> >> -	component_del(&client->dev, &tda998x_ops);
> >> +	struct device *dev = &client->dev;
> >> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> >> +
> >> +	drm_bridge_remove(&bridge->bridge);
> >> +	component_del(dev, &tda998x_ops);
> >> +
> > 
> > I'd like to ask a rather fundamental question about DRM bridge support,
> > because I suspect that there's a major fsckup here.
> > 
> > The above is the function that deals with the TDA998x device being
> > unbound from the driver.  With the component API, this results in the
> > DRM device correctly being torn down, because one of the hardware
> > devices has gone.
> > 
> > With DRM bridge, the bridge is merely removed from the list of
> > bridges:
> > 
> > void drm_bridge_remove(struct drm_bridge *bridge)
> > {
> >         mutex_lock(&bridge_lock);
> >         list_del_init(&bridge->list);
> >         mutex_unlock(&bridge_lock);
> > }
> > EXPORT_SYMBOL(drm_bridge_remove);
> > 
> > and the memory backing the "struct tda998x_bridge" (which contains
> > the struct drm_bridge) will be freed by the devm subsystem.
> > 
> > However, there is no notification into the rest of the DRM subsystem
> > that the device has gone away.  Worse, the memory that is still in
> > use by DRM has now been freed, so further use of the DRM device
> > results in a use-after-free bug.
> > 
> > This is really not good, and to me looks like a fundamental problem
> > with the DRM bridge code.  I see nothing in the DRM bridge code that
> > deals with the lifetime of a "DRM bridge" or indeed the lifetime of
> > the actual device itself.
> > 
> > So, from what I can see, there seems to be a fundamental lifetime
> > issue with the design of the DRM bridge code.  This needs to be
> > fixed.
> 
> Oh crap. A gigantic can of worms...

Yes, it's especially annoying for me, having put the effort in to
the component helper to cover all these cases.

> Would a patch (completely untested btw) along this line of thinking make
> any difference whatsoever?

It looks interesting - from what I can see of the device links code,
it would have the effect of unbinding the DRM device just before
TDA998x is unbound, so that's an improvement.

However, from what I can see, the link vanishes at that point (as
DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
in nothing further happening - the link will be recreated, but there
appears to be nothing that triggers the "consumer" to rebind at that
point.  Maybe I've missed something?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
