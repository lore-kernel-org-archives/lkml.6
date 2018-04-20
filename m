Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeDTKx5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:53:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45978 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbeDTKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:53:56 -0400
Date: Fri, 20 Apr 2018 11:53:38 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Peter Rosin <peda@axentia.se>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
Message-ID: <20180420105337.GX16141@n2100.armlinux.org.uk>
References: <20180419162751.25223-8-peda@axentia.se>
 <201804201731.D3OnDg0p%fengguang.wu@intel.com>
 <4e9bd91c-6b29-cdd2-9e1d-1728311ddb81@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9bd91c-6b29-cdd2-9e1d-1728311ddb81@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 12:49:42PM +0200, Peter Rosin wrote:
> On 2018-04-20 12:41, kbuild test robot wrote:
> > Hi Peter,
> > 
> > I love your patch! Yet something to improve:
> 
> Yup, right you are!
> 
> > [auto build test ERROR on drm/drm-next]
> > [also build test ERROR on v4.17-rc1 next-20180420]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/Add-tda998x-HDMI-support-to-atmel-hlcdc/20180420-160131
> > base:   git://people.freedesktop.org/~airlied/linux.git drm-next
> > config: i386-randconfig-a0-201815 (attached as .config)
> > compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_probe':
> >>> drivers/gpu/drm/i2c/tda998x_drv.c:1859:16: error: 'struct drm_bridge' has no member named 'of_node'
> >      bridge->bridge.of_node = dev->of_node;
> >                    ^
> 
> Anybody got a better fix than this?
> 
> #ifdef CONFIG_OF
> 	bridge->bridge.of_node = dev->of_node;
> #endif

How about the bridge code provides a helper to do this, something like:

static inline void bridge_set_device(struct drm_bridge *bridge,
				     struct device *dev)
{
#ifdef CONFIG_OF
	bridge->of_node = dev->of_node;
#endif
}

which (a) nicely hides the firmware flavour, and (b) hides the ifdef in
the bridge header where it belongs.  If the bridge code needs to be
converted to fwnode in the future, at least this would be abstracted
from the drivers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
