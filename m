Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeEILdo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:33:44 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:56524 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933883AbeEILdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:33:01 -0400
Message-ID: <c8ab5f472881063b90abe9461933baf6ee325dcd.camel@paulk.fr>
Subject: Re: [PATCH v4 1/3] drm/panel: Add RGB666 variant of Innolux
 AT070TN90
From: Paul Kocialkowski <contact@paulk.fr>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Date: Wed, 09 May 2018 13:31:23 +0200
In-Reply-To: <20180509071226.ivh4s3wtczg2u7zw@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
         <20180509071226.ivh4s3wtczg2u7zw@flea>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2018-05-09 at 09:12 +0200, Maxime Ripard wrote:
> On Tue, May 08, 2018 at 12:04:11AM +0200, Paul Kocialkowski wrote:
> > This adds timings for the RGB666 variant of the Innolux AT070TN90 panel,
> > as found on the Ainol AW1 tablet.
> > 
> > The panel also supports RGB888 output. When RGB666 mode is used instead,
> > the two extra lanes per component are grounded.
> > 
> > In the future, it might become necessary to introduce a dedicated
> > device-tree property to specify the bus format to use instead of the
> > default one for the panel. This will allow supporting different bus
> > formats for the same panel modes.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index cbf1ab404ee7..32e30d5a8f08 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at043tn24 = {
> >  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
> >  };
> >  
> > +static const struct drm_display_mode innolux_at070tn90_mode = {
> > +	.clock = 40000,
> > +	.hdisplay = 800,
> > +	.hsync_start = 800 + 112,
> > +	.hsync_end = 800 + 112 + 1,
> > +	.htotal = 800 + 112 + 1 + 87,
> > +	.vdisplay = 480,
> > +	.vsync_start = 480 + 141,
> > +	.vsync_end = 480 + 141 + 1,
> > +	.vtotal = 480 + 141 + 1 + 38,
> > +	.vrefresh = 60,
> > +};
> > +
> > +static const struct panel_desc innolux_at070tn90 = {
> > +	.modes = &innolux_at070tn90_mode,
> > +	.num_modes = 1,
> > +	.size = {
> > +		.width = 154,
> > +		.height = 86,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > +};
> > +
> 
> I'm not really convinced this is the right approach. You said it
> yourself, the panel is using a 24-bits interface, and you just happen
> to have a tablet that routed it using a 18-bits interface instead.
> 
> That doesn't belong in the driver, especially associated to the
> compatible, but where the routing is described: in the device
> tree. And given that the panel interface is a 24 bits panel, if we
> were to have a default, we should have this one, and not the one
> fitting your use case.

I fully agree, this is why I suggested introducing a dedicated dt
property for selecting the bus format (in the commit message). I still
proposed this patch as a temporary solution, but I'm definitely willing
to craft a proper solution as well.

Here is an initial proposition:
1. Making bus_format an array in struct panel_desc and listing all the
relevant bus formats that the panel can support there;
2. Introducing an optional "bus-format" dt property that indicates which
bus format to use, and using the first index of the bus formats array if
the property is not present;
3. Checking that the bus format requested from dt is supported by the
panel.

What do you think?

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
