Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbeCTNqz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:46:55 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:34029 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753700AbeCTNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:46:51 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [RFC PATCH 0/3] allow override of bus format in bridges
Date: Tue, 20 Mar 2018 15:47:55 +0200
Message-ID: <7353957.qIouzRlT7t@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180317221525.18534-1-peda@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

(CC'ing Jacopo Mondi who might be working on something similar)

On Sunday, 18 March 2018 00:15:22 EET Peter Rosin wrote:
> I'm trying to get something to work that I assumed would not
> need patches, so I think I might be missing something completely
> obvious...
> 
> I have an Atmel sama5d31 hooked up to an lvds encoder and then
> on to an lvds panel. Which seems like something that has been
> done one or two times before...
> 
> The problem (I think) is that the bus_format of the SoC and the
> panel do not agree. The SoC driver (atmel-hlcdc) can handle the
> rgb444, rgb565, rgb666 and rgb888 bus formats. The hardware is
> wired for the rgb565 case. The lvds encoder supports rgb888 on
> its input side with the LSB wires simply pulled down internally
> in the encoder in my case. And the panel is expecting lvds
> (vesa-24), which is what the encoder outputs.
> 
> The reason I "blame" the bus_format of the drm_connector is that
> with the below DT snippet, things do not work *exactly* due to
> that. At least, it starts to work if I hack the panel-lvds driver
> to report the rgb565 bus_format instead of vesa-24.
> 
> 	panel: panel {
> 		compatible = "panel-lvds";
> 
> 		width-mm = <476>;
> 		height-mm = <268>;
> 
> 		data-mapping = "vesa-24";
> 
> 		panel-timing {
> 			// 1024x768 @ 60Hz (typical)
> 			clock-frequency = <52140000 65000000 71100000>;
> 			hactive = <1024>;
> 			vactive = <768>;
> 			hfront-porch = <59 107 107>;
> 			hback-porch = <59 107 107>;
> 			hsync-len = <59 106 106>;
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
> 		compatible = "ti,ds90c187", "lvds-encoder";
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

I agree with your analysis, it's wrong for a display controller to use the 
formats reported by the panel (through the connector) without taking into 
account intermediate bridges.

> But, instead of perverting the panel-lvds driver with support
> for a totally fake non-lvds bus_format, I came up with an optional
> bus_format override in the lvds-encoder driver, which I trigger with
> this addition to the lvds-encoder DT node:
> 
> 		interface-pix-fmt = "rgb565";
> 
> There are some issues with the interface-pix-fmt name. I copied it
> from the freescale fsl-imx-drm binding, but a) I personally don't
> like how that binding uses rgb24 instead of rgb888 and b) I don't
> like how the implementation of that binding selects rgb666 when you
> say bgr666 in the DT, but for parallel hardware interface the bit
> order is not really relevant so I swallowed that. Anyway, it might
> be better to use something else than interface-pix-fmt? Perhaps
> reuse the "data-mapping" name from the panel-lvds binding? But that
> seems somewhat lvds specific? Then there a couple of instances of
> "bus-format-override" in some dtsi files, but that name is not
> mentioned in any binding, nor in (upstream) code...

The data-mappings property describe the mapping of the bits over the LVDS time 
slots, so I wouldn't reuse that name, especially given that the property you 
need isn't specific to LVDS. "bus-format" sounds better to me, or maybe 
"video-format" (coming from a similar property in a Xilinx-specific V4L2 
binding).

> And maybe it should be fourcc codes or something instead of these
> "rgb565" names?

We'd end up introducing the format fourcc values, which are to some extent 
Linux-specific (with identical formats that have different fourccs in V4L2 and 
DRM), in the DT bindings, so I'm tempted to stick to strings, but I could be 
convinced otherwise.

Another option would be to use device-specific compatible strings, in which 
case the format could be stored in the driver instead of in a DT property. I'm 
not sure that's a good idea, I haven't really thought about it much :-)

> I threw in the first patch, since that is the actual lvds encoder
> I have in this case.
> 
> Suggestions welcome.

I'll comment on the API in replies to the patches.

> Peter Rosin (3):
>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>   drm: bridge: panel: allow override of the bus format
>   drm: bridge: lvds-encoder: on request, override the bus format
> 
>  .../bindings/display/bridge/lvds-transmitter.txt   | 13 +++++++++++++
>  drivers/gpu/drm/bridge/lvds-encoder.c              | 18 ++++++++++++++++++
>  drivers/gpu/drm/bridge/panel.c                     | 22 ++++++++++++++++++-
>  include/drm/drm_bridge.h                           |  1 +
>  4 files changed, 53 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart
