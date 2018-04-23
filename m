Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755715AbeDWQIw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:08:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40156 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755339AbeDWQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:08:47 -0400
Date: Mon, 23 Apr 2018 17:08:33 +0100
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
Message-ID: <20180423160833.GF16141@n2100.armlinux.org.uk>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423072301.11962-8-peda@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>  static int tda998x_remove(struct i2c_client *client)
>  {
> -	component_del(&client->dev, &tda998x_ops);
> +	struct device *dev = &client->dev;
> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
> +
> +	drm_bridge_remove(&bridge->bridge);
> +	component_del(dev, &tda998x_ops);
> +

I'd like to ask a rather fundamental question about DRM bridge support,
because I suspect that there's a major fsckup here.

The above is the function that deals with the TDA998x device being
unbound from the driver.  With the component API, this results in the
DRM device correctly being torn down, because one of the hardware
devices has gone.

With DRM bridge, the bridge is merely removed from the list of
bridges:

void drm_bridge_remove(struct drm_bridge *bridge)
{
        mutex_lock(&bridge_lock);
        list_del_init(&bridge->list);
        mutex_unlock(&bridge_lock);
}
EXPORT_SYMBOL(drm_bridge_remove);

and the memory backing the "struct tda998x_bridge" (which contains
the struct drm_bridge) will be freed by the devm subsystem.

However, there is no notification into the rest of the DRM subsystem
that the device has gone away.  Worse, the memory that is still in
use by DRM has now been freed, so further use of the DRM device
results in a use-after-free bug.

This is really not good, and to me looks like a fundamental problem
with the DRM bridge code.  I see nothing in the DRM bridge code that
deals with the lifetime of a "DRM bridge" or indeed the lifetime of
the actual device itself.

So, from what I can see, there seems to be a fundamental lifetime
issue with the design of the DRM bridge code.  This needs to be
fixed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
