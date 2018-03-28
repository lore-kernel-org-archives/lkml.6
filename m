Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeC1MZQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 08:25:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55351 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbeC1MZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 08:25:15 -0400
Date: Wed, 28 Mar 2018 14:25:12 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Peter Rosin <peda@axentia.se>, Egbert Eich <eich@suse.de>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/atmel-hlcdc: add command line option to specify
 preferred depth
Message-ID: <20180328142512.14f8c502@bbrezillon>
In-Reply-To: <20180328122236.GF14155@phenom.ffwll.local>
References: <20180326073502.19259-1-peda@axentia.se>
        <20180328093454.4149fa3b@bbrezillon>
        <20180328122236.GF14155@phenom.ffwll.local>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 14:22:36 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Wed, Mar 28, 2018 at 09:34:54AM +0200, Boris Brezillon wrote:
> > Hi Peter,
> > 
> > On Mon, 26 Mar 2018 09:35:02 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> > > I have an sama5d31-based system with 64MB of memory and a 1920x1080
> > > LVDS display wired for 16-bpp. When I enable legacy fbdev support,
> > > the contiguous memory allocator invariably fails with the order-11
> > > allocation for a 1920x1080@24-bpp buffer (~6MB). But this HW can never
> > > make any good use of RGB888, so that is a wasted attempt anyway that
> > > would also waste precious memory should it succeed.
> > > 
> > > Sure, I could rewrite user-space to go directly to KMS etc, and that
> > > makes the (attempted) order-11 allocation go away, replacing it with
> > > one order-10 allocation per application restart for a 1920x1080@16-bpp
> > > buffer (<4MB). But after a few restarts, order-10 allocations start to
> > > fail as well, which is only to be expected AFAIU.
> > > 
> > > So, I'd rather not change user-space (which was originally written
> > > to target a smaller display) so that I at the same time get the
> > > benefit of an early pre-allocated fbdev frame-buffer that can be
> > > reused over and over. But to do that I need to tell the driver that
> > > 16-bpp is the preferred depth. Add a module parameter to do just that.
> > > 
> > > Signed-off-by: Peter Rosin <peda@axentia.se>
> > > ---
> > >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > I found some inspiration regarding naming and implementation here:
> > > https://patchwork.kernel.org/patch/9848631/
> > > 
> > > I have found no feedback on that patch though, which makes me wonder if
> > > I'm perhaps barking up the wronig tree?  
> > 
> > Hm, isn't that something you can already overload with the video=
> > parameter?
> > 
> > 	video=<output>:<resolution>[-<bpp>]
> > 
> > AFAIR, <bpp> encodes the color depth, so what is the benefit of adding
> > this new property to overload the default depth?
> > 
> > Maybe I'm wrong and the default depth param is actually useful, but in
> > this case we should probably make it generic since other drivers seems
> > to need it too, and we might want to attach it to a specific display
> > engine instance.  
> 
> I think for the drm's fbdev emulation we ignore the bpp ...

Nope, it's already parsed [1].

[1]https://elixir.bootlin.com/linux/v4.16-rc3/source/drivers/gpu/drm/drm_fb_helper.c#L1812
-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
