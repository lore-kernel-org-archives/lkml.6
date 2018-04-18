Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDRIld (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:41:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55668 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeDRIlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:41:31 -0400
Date: Wed, 18 Apr 2018 10:41:28 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/6] drm/atmel-hlcdc: add support for connecting to
 tda998x HDMI encoder
Message-ID: <20180418104128.6747ad47@bbrezillon>
In-Reply-To: <0155b3cc-29ce-fa43-5588-b465c6ee064a@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
        <20180417131052.16336-6-peda@axentia.se>
        <20180418093649.2c304f29@bbrezillon>
        <0155b3cc-29ce-fa43-5588-b465c6ee064a@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 10:02:12 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-18 09:36, Boris Brezillon wrote:
> > On Tue, 17 Apr 2018 15:10:51 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> When the of-graph points to a tda998x-compatible HDMI encoder, register
> >> as a component master and bind to the encoder/connector provided by
> >> the tda998x driver.  
> > 
> > Can't we do the opposite: make the tda998x driver expose its devices as
> > drm bridges. I'd rather not add another way to connect external
> > encoders (or bridges) to display controller drivers, especially since,
> > when I asked DRM maintainers/devs what was the good approach to
> > represent such external encoders they pointed me to the drm_bridge
> > interface.  
> 
> From the cover letter:
> 
> "However, I don't know if the tilcdc driver is interfacing with the
> tda998x driver in a sane and modern way"
> 
> So, which way is the future? Should bridges become components or should
> existing bridge-like components no longer be components? Are there others?

Well, what I've been told a while ago is that drm_bridge will take over
drm_encoder_slave and custom drm_encoder/drm_connector implementations
when it comes to representing bridges.

AFAIU, using the component framework to bind all elements of the
pipeline to the display controller is orthogonal to how you represent
elements in the pipeline. I mean, you could have a bridge that
registers as a component so that display controllers drivers who want
to use the component framework don't have to re-code the
component-to-bridge glue every time, and those who don't use the
component framework can still get access to the bridge.
