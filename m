Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeC1HId (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:08:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38950 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeC1HIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:08:30 -0400
X-Google-Smtp-Source: AIpwx481ItZm2IzjSrpfh75h6oh97ta8JU7zVlzVQLvjBgCpoK+B8ZqvwCDfF0yd/Gh7j/qmx/60WA==
Date: Wed, 28 Mar 2018 09:08:26 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] allow override of bus format in bridges
Message-ID: <20180328070826.GY14155@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180326212447.7380-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:24:42PM +0200, Peter Rosin wrote:
> Hi!
> 
> [I got to v2 sooner than expected]
> 
> I have an Atmel sama5d31 hooked up to an lvds encoder and then
> on to an lvds panel. Which seems like something that has been
> done one or two times before...
> 
> The problem is that the bus_format of the SoC and the panel do
> not agree. The SoC driver (atmel-hlcdc) can handle the
> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
> wired for the rgb565 case. The lvds encoder supports rgb888 on
> its input side with the LSB wires for each color simply pulled
> down internally in the encoder in my case which means that the
> rgb565 bus_format is the format that works best. And the panel
> is expecting lvds (vesa-24), which is what the encoder outputs.
> 
> The reason I "blame" the bus_format of the drm_connector is that
> with the below DT snippet, things do not work *exactly* due to
> that. At least, it starts to work if I hack the panel-lvds driver
> to report the rgb565 bus_format instead of vesa-24.
> 
> 	panel: panel {
> 		compatible = "panel-lvds";
> 
> 		width-mm = <304>;
> 		height-mm = <228;
> 
> 		data-mapping = "vesa-24";
> 
> 		panel-timing {
> 			// 1024x768 @ 60Hz (typical)
> 			clock-frequency = <52140000 65000000 71100000>;
> 			hactive = <1024>;
> 			vactive = <768>;
> 			hfront-porch = <48 88 88>;
> 			hback-porch = <96 168 168>;
> 			hsync-len = <32 64 64>;
> 			vfront-porch = <8 13 14>;
> 			vback-porch = <8 13 14>;
> 			vsync-len = <8 12 14>;
> 		};
> 
> 		port {
> 			panel_input: endpoint {
> 				remote-endpoint = <&lvds_encoder_output>;
> 			};
> 		};
> 	};
> 
> 	lvds-encoder {
> 		compatible = "ti,ds90c185", "lvds-encoder";
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			port@0 {
> 				reg = <0>;
> 
> 				lvds_encoder_input: endpoint {
> 					remote-endpoint = <&hlcdc_output>;
> 				};
> 			};
> 
> 			port@1 {
> 				reg = <1>;
> 
> 				lvds_encoder_output: endpoint {
> 					remote-endpoint = <&panel_input>;
> 				};
> 			};
> 		};
> 	};
> 
> But, instead of perverting the panel-lvds driver with support
> for a totally fake non-lvds bus_format, I intruduce an API that allows
> display controller drivers to query the required bus_format of any
> intermediate bridges, and match up with that instead of the formats
> given by the drm_connector. I trigger this with this addition to the
> lvds-encoder DT node:
> 
> 		interface-pix-fmt = "rgb565";
> 
> Naming is hard though, so I'm not sure if that's good?
> 
> I threw in the first patch, since that is the actual lvds encoder
> I have in this case.
> 
> Suggestions welcome.

Took a quick look, feels rather un-atomic. And there's beend discussing
for other bridge related state that we might want to track (like the full
adjusted_mode that might need to be adjusted at each stage in the chain).
So here's my suggestions:

- Add an optional per-bridge internal state struct using the support in

https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#handling-driver-private-state

  Yes it says "driver private", but since bridge is just helper stuff
  that's all included. "driver private" == "not exposed as uapi" here.
  Include all the usual convenience wrappers to get at the state for a
  bridge.

- Then stuff your bus_format into that new drm_bridge_state struct.

- Add a new bridge callback atomic_check, which gets that bridge state as
  parameter (similar to all the other atomic_check functions).

This way we can even handle the bus_format dynamically, through the atomic
framework your bridge's atomic_check callback can look at the entire
atomic state (both up and down the chain if needed), it all neatly fits
into atomic overall and it's much easier to extend.

Please also cc Laurent Pinchart on this.

Cheers, Daniel


> 
> Cheers,
> Peter
> 
> Changes since v1 https://lkml.org/lkml/2018/3/17/221
> - Add a proper bridge API to query the bus_format instead of abusing
>   the ->get_modes part of the code. This is cleaner but requires
>   changes to all display controller drivers wishing to participate.
> - Add patch to adjust the atmel-hlcdc driver according to the above.
> - Hook the new info into the bridge local to the lvds-encoder instead
>   of messing about with new interfaces for the panel-bridge driver.
> - Add patch with a DT parsing function of bus_formats in a central place.
> - Rephrase the addition of ti,ds90c185 to the lvds-transmitter binding.
> 
> Peter Rosin (5):
>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>   drm: bridge: add API to query the expected input formats of bridges
>   drm: of: add display bus-format parser
>   drm: bridge: lvds-encoder: allow specifying the input bus format
>   drm/atmel-hlcdc: take bridges into account when selecting output
>     format
> 
>  .../bindings/display/bridge/lvds-transmitter.txt   | 14 ++++-
>  .../devicetree/bindings/display/bus-format.txt     | 35 +++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 49 ++++++++++++++++--
>  drivers/gpu/drm/bridge/lvds-encoder.c              | 25 +++++++++
>  drivers/gpu/drm/drm_bridge.c                       | 32 ++++++++++++
>  drivers/gpu/drm/drm_of.c                           | 59 ++++++++++++++++++++++
>  include/drm/drm_bridge.h                           | 18 +++++++
>  include/drm/drm_of.h                               |  9 ++++
>  8 files changed, 237 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bus-format.txt
> 
> -- 
> 2.11.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
