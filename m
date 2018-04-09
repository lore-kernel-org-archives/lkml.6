Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDIMvN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:51:13 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35024 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeDIMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:51:11 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/5] allow override of bus format in bridges
Date: Mon, 09 Apr 2018 15:51:12 +0300
Message-ID: <1535937.JbitjzqBjA@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <8bba78e3-ed61-4648-d4a4-5d12dd9ef11d@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se> <9af25e5a-7334-b07c-ff49-46530df6b1aa@axentia.se> <8bba78e3-ed61-4648-d4a4-5d12dd9ef11d@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Monday, 9 April 2018 10:04:05 EEST Peter Rosin wrote:
> On 2018-04-04 14:35, Peter Rosin wrote:
> > On 2018-04-04 11:07, Laurent Pinchart wrote:
> >> On Wednesday, 4 April 2018 09:34:41 EEST Daniel Vetter wrote:
> >>> On Wed, Apr 4, 2018 at 12:28 AM, Laurent Pinchart wrote:
> >>>> On Wednesday, 28 March 2018 10:08:26 EEST Daniel Vetter wrote:
> >>>>> On Mon, Mar 26, 2018 at 11:24:42PM +0200, Peter Rosin wrote:
> >>>>>> Hi!
> >>>>>> 
> >>>>>> [I got to v2 sooner than expected]
> >>>>>> 
> >>>>>> I have an Atmel sama5d31 hooked up to an lvds encoder and then
> >>>>>> on to an lvds panel. Which seems like something that has been
> >>>>>> done one or two times before...
> >>>>>> 
> >>>>>> The problem is that the bus_format of the SoC and the panel do
> >>>>>> not agree. The SoC driver (atmel-hlcdc) can handle the
> >>>>>> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
> >>>>>> wired for the rgb565 case. The lvds encoder supports rgb888 on
> >>>>>> its input side with the LSB wires for each color simply pulled
> >>>>>> down internally in the encoder in my case which means that the
> >>>>>> rgb565 bus_format is the format that works best. And the panel
> >>>>>> is expecting lvds (vesa-24), which is what the encoder outputs.
> >>>>>> 
> >>>>>> The reason I "blame" the bus_format of the drm_connector is that
> >>>>>> with the below DT snippet, things do not work *exactly* due to
> >>>>>> that. At least, it starts to work if I hack the panel-lvds driver
> >>>>>> to report the rgb565 bus_format instead of vesa-24.
> >>>>>> 
> >>>>>>     panel: panel {
> >>>>>>             compatible = "panel-lvds";
> >>>>>>             
> >>>>>>             width-mm = <304>;
> >>>>>>             height-mm = <228;
> >>>>>>             
> >>>>>>             data-mapping = "vesa-24";
> >>>>>>             
> >>>>>>             panel-timing {
> >>>>>>                     // 1024x768 @ 60Hz (typical)
> >>>>>>                     clock-frequency = <52140000 65000000 71100000>;
> >>>>>>                     hactive = <1024>;
> >>>>>>                     vactive = <768>;
> >>>>>>                     hfront-porch = <48 88 88>;
> >>>>>>                     hback-porch = <96 168 168>;
> >>>>>>                     hsync-len = <32 64 64>;
> >>>>>>                     vfront-porch = <8 13 14>;
> >>>>>>                     vback-porch = <8 13 14>;
> >>>>>>                     vsync-len = <8 12 14>;
> >>>>>>             };
> >>>>>>             
> >>>>>>             port {
> >>>>>>                     panel_input: endpoint {
> >>>>>>                             remote-endpoint = <&lvds_encoder_output>;
> >>>>>>                     };
> >>>>>>             };
> >>>>>>     };
> >>>>>>     
> >>>>>>     lvds-encoder {
> >>>>>>             compatible = "ti,ds90c185", "lvds-encoder";
> >>>>>>             
> >>>>>>             ports {
> >>>>>>                     #address-cells = <1>;
> >>>>>>                     #size-cells = <0>;
> >>>>>>                     
> >>>>>>                     port@0 {
> >>>>>>                             reg = <0>;
> >>>>>>                             
> >>>>>>                             lvds_encoder_input: endpoint {
> >>>>>>                                     remote-endpoint =
> >>>>>>                                     <&hlcdc_output>;
> >>>>>>                             };
> >>>>>>                     };
> >>>>>>                     
> >>>>>>                     port@1 {
> >>>>>>                             reg = <1>;
> >>>>>>                             
> >>>>>>                             lvds_encoder_output: endpoint {
> >>>>>>                                     remote-endpoint = <&panel_input>;
> >>>>>>                             };
> >>>>>>                     };
> >>>>>>             };
> >>>>>>     };
> >>>>>> 
> >>>>>> But, instead of perverting the panel-lvds driver with support
> >>>>>> for a totally fake non-lvds bus_format, I intruduce an API that
> >>>>>> allows display controller drivers to query the required bus_format of
> >>>>>> any intermediate bridges, and match up with that instead of the
> >>>>>> formats given by the drm_connector. I trigger this with this addition
> >>>>>> to the lvds-encoder DT node:
> >>>>>>             interface-pix-fmt = "rgb565";
> >>>>>> 
> >>>>>> Naming is hard though, so I'm not sure if that's good?
> >>>>>> 
> >>>>>> I threw in the first patch, since that is the actual lvds encoder
> >>>>>> I have in this case.
> >>>>>> 
> >>>>>> Suggestions welcome.
> >>>>> 
> >>>>> Took a quick look, feels rather un-atomic. And there's beend
> >>>>> discussing for other bridge related state that we might want to track
> >>>>> (like the full adjusted_mode that might need to be adjusted at each
> >>>>> stage in the chain). So here's my suggestions:
> >>>>> 
> >>>>> - Add an optional per-bridge internal state struct using the support
> >>>>>   in https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#handling-> >>>>>   driver-private-state
> >>>>>   
> >>>>>   Yes it says "driver private", but since bridge is just helper stuff
> >>>>>   that's all included. "driver private" == "not exposed as uapi" here.
> >>>>>   Include all the usual convenience wrappers to get at the state for a
> >>>>>   bridge.
> >>>>> 
> >>>>> - Then stuff your bus_format into that new drm_bridge_state struct.
> >>>>> 
> >>>>> - Add a new bridge callback atomic_check, which gets that bridge state
> >>>>>   as parameter (similar to all the other atomic_check functions).
> >>>>> 
> >>>>> This way we can even handle the bus_format dynamically, through the
> >>>>> atomic framework your bridge's atomic_check callback can look at the
> >>>>> entire atomic state (both up and down the chain if needed), it all
> >>>>> neatly fits into atomic overall and it's much easier to extend.
> >>>> 
> >>>> While I think we'll eventually need bridge states, I don't think that's
> >>>> need yet. The bus formats reported by this patch series are static.
> >>>> We're not talking about the currently configured format for a bridge,
> >>>> but about the list of supported formats. This is similar to the
> >>>> bus_formats field present in the drm_display_info structure. There is
> >>>> thus in my opinion no need to interface this with atomic until we need
> >>>> to track the current format (and I think that will indeed happen at
> >>>> some point, but I don't think Peter needs this feature for now). That's
> >>>> why I've told Peter that I would like a bridge API to report the
> >>>> information and haven't requested a state-based implementation.
> >>> 
> >>> If it's static, why a dynamic callback? Just add it to struct
> >>> drm_bridge, require it's filled out before registering the bridge,
> >>> done.
> >> 
> >> If I remember correctly I mentioned both options in my initial proposal,
> >> without a personal preference. A new field in struct drm_bridge would
> >> certainly work for me.
> > 
> > You did. Ok, so v3 coming up...
> 
> Nope, v3 is not coming up. This feels like an impossible mission for me, as
> this changes core DRM design, and it would just be too much of a time sink
> for me. Besides, the final paragraph of the nice long "state of
> bridges"-mail from Laurent, i.e.
> 
> On 2018-04-04 15:07, Laurent Pinchart wrote:
> > Finally, still regarding Peter's case, the decision to output RGB565
> > instead of RGB888 (which the LVDS encoder expects) is due to PCB routing
> > between the display controller and the LVDS encoder. This isn't a
> > property of the LVDS encoder or the display controller, but of their
> > hardware connection. This patch series uses a DT property in the LVDS
> > encoder DT node to convey that information, but wouldn't it be equally
> > correct (or incorrect :-)) to instead use a DT property in the display
> > controller DT node ?
> 
> hints at where I'm going. The reason is that I have a patch (that needs some
> polish, will post soon) that makes the atmel-hlcdc driver use components in
> order to hook it with the tda998x driver (an hdmi encoder), and there too I
> need the atmel-hlcdc driver to use rgb565 output. And in that case there
> are no bridges involved, so the proposed solution in this series has zero
> hope of being adequate. It simply seems that forcing the output mode in the
> atmel-hlcdc driver is what fixes the root cause.
> 
> End result; the only thing that survives this series is the interesting
> discussion and patch 1/5. But I will include that patch in the alternative
> solution, so you can drop this series entirely...

I feel some disappointment here. I would like to make it very clear that your 
work was appreciated. Not all efforts turn into patches that get merged 
upstream, and some of the greatest work only results in ideas that are then 
taken over by other developers. Even if this patch series ends up being 
dropped, it served as a very useful experiment to get us closer to a good 
solution to the problem. As such the time and efforts you have invested in it 
are certainly not wasted and were very helpful.

-- 
Regards,

Laurent Pinchart
