Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeDTUj7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:39:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50934 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDTUj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:39:58 -0400
Date: Fri, 20 Apr 2018 22:39:56 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v2] drm/sun4i: add lvds mode_valid function
Message-ID: <20180420203956.aqcuwu22iaxnnykn@flea>
References: <1520940019-68977-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180419133421.6fx3whge7h364vd3@core>
 <CAGb2v64dqPoJkJDuMWp66HYXvZ3RJkrRz+2-CUVEcEG1k7UTsw@mail.gmail.com>
 <129dfeb0-0962-608d-370e-277a3acce7ca@micronovasrl.com>
 <20180420131026.vbg3qgrj26egw5s2@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180420131026.vbg3qgrj26egw5s2@core>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 03:10:26PM +0200, Ondřej Jirman wrote:
> Hello,
> 
> On Thu, Apr 19, 2018 at 04:02:08PM +0200, Giulio Benetti wrote:
> > Hi everybody,
> > 
> > Il 19/04/2018 15:36, Chen-Yu Tsai ha scritto:
> > > On Thu, Apr 19, 2018 at 9:34 PM, Ondřej Jirman
> > > <doudahwezomiechahtah@xff.cz> wrote:
> > > > Hello Giulio,
> > > > 
> > > > this patch breaks LVDS output on A83T. Without it, modesetting works,
> > > > with it there's no output.
> > > > 
> > > > Some more info below...
> > > > 
> > > > On Tue, Mar 13, 2018 at 12:20:19PM +0100, Giulio Benetti wrote:
> > > > > mode_valid function is missing for lvds.
> > > > > 
> > > > > Add it making it pointed by encoder helper functions.
> > > > > 
> > > > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > > ---
> > > > >   drivers/gpu/drm/sun4i/sun4i_lvds.c | 55 ++++++++++++++++++++++++++++++++++++++
> > > > >   1 file changed, 55 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> > > > > index be3f14d..bffff4c 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> > > > > @@ -94,9 +94,64 @@ static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
> > > > >        }
> > > > >   }
> > > > > 
> > > > > +static enum drm_mode_status sun4i_lvds_encoder_mode_valid(struct drm_encoder *crtc,
> > > > > +                                                       const struct drm_display_mode *mode)
> > > > > +{
> > > > > +     struct sun4i_lvds *lvds = drm_encoder_to_sun4i_lvds(crtc);
> > > > > +     struct sun4i_tcon *tcon = lvds->tcon;
> > > > > +     u32 hsync = mode->hsync_end - mode->hsync_start;
> > > > > +     u32 vsync = mode->vsync_end - mode->vsync_start;
> > > > > +     unsigned long rate = mode->clock * 1000;
> > > > > +     long rounded_rate;
> > > > > +
> > > > > +     DRM_DEBUG_DRIVER("Validating modes...\n");
> > > > > +
> > > > > +     if (hsync < 1)
> > > > > +             return MODE_HSYNC_NARROW;
> > > > > +
> > > > > +     if (hsync > 0x3ff)
> > > > > +             return MODE_HSYNC_WIDE;
> > > > > +
> > > > > +     if ((mode->hdisplay < 1) || (mode->htotal < 1))
> > > > > +             return MODE_H_ILLEGAL;
> > > > > +
> > > > > +     if ((mode->hdisplay > 0x7ff) || (mode->htotal > 0xfff))
> > > > > +             return MODE_BAD_HVALUE;
> > > > > +
> > > > > +     DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
> > > > > +
> > > > > +     if (vsync < 1)
> > > > > +             return MODE_VSYNC_NARROW;
> > > > > +
> > > > > +     if (vsync > 0x3ff)
> > > > > +             return MODE_VSYNC_WIDE;
> > > > > +
> > > > > +     if ((mode->vdisplay < 1) || (mode->vtotal < 1))
> > > > > +             return MODE_V_ILLEGAL;
> > > > > +
> > > > > +     if ((mode->vdisplay > 0x7ff) || (mode->vtotal > 0xfff))
> > > > > +             return MODE_BAD_VVALUE;
> > > > > +
> > > > > +     DRM_DEBUG_DRIVER("Vertical parameters OK\n");
> > > > > +
> > > > > +     tcon->dclk_min_div = 7;
> > > > > +     tcon->dclk_max_div = 7;
> > > > 
> > > > Why would validation function change any state anywhere?
> > > > 
> > > > > +     rounded_rate = clk_round_rate(tcon->dclk, rate);
> > > > 
> > > > The issue is here, on A83T TBS A711 tablet, I get...
> > > > 
> > > > sun4i-tcon 1c0c000.lcd-controller: XXX: hsync=20 hdisplay=1024 htotal=1384
> > > >    vsync=5 vdisplay=600 vtotal=640 rate=52000000 rounded_rate=51857142
> > > > 
> > > > > +     if (rounded_rate < rate)
> > > > > +             return MODE_CLOCK_LOW;
> > > > > +
> > > > > +     if (rounded_rate > rate)
> > > > > +             return MODE_CLOCK_HIGH;
> > > > 
> > > > ... while the previous conditions require an exact match for some reason.
> > > > 
> > > > But HW works fine without an exact rate match. Why is exact match required here?
> > > 
> > > This thread might provide some more info, though we could never get an
> > > agreement.
> > > 
> > > https://patchwork.kernel.org/patch/9446385/
> > 
> > Thanks for pointing that Thread ChenYu.
> > So the only chance is to trim frequency according to encoder capabilities.
> > I agree to block when encoder can't provide frequency specified,
> > otherwise you could drive you panel at the near the lowest(highest)
> > frequency and get out of limits for a few without knowing it.
> 
> When I set the range of pixel clock frequencies on simple-panel connected
> to this encoder, the check still fails, so there's something not working
> there as expected. This check is only called once with a typical frequency.
> 
> I guess drm doesn't implement clock-frequency range on panels. But I haven't
> looked.

It does, but only omapdss is able to use it iirc. We could do it too,
but that would be way out of scope for a fix.

> I can set the exact frequency that the SoC can provide on the simple-panel,
> but that's a bit of a hack.

Yes. And if the only device using this thus far is broken, that's not
really great either.

Can you send a revert?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
