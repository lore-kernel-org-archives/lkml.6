Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932281AbeDWRlT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:41:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47632 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932261AbeDWRlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:41:09 -0400
Date: Mon, 23 Apr 2018 19:41:06 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/8] dt-bindings: display: atmel: optional
 video-interface of endpoints
Message-ID: <20180423194106.3b178211@bbrezillon>
In-Reply-To: <20180423072301.11962-3-peda@axentia.se>
References: <20180423072301.11962-1-peda@axentia.se>
        <20180423072301.11962-3-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 09:22:55 +0200
Peter Rosin <peda@axentia.se> wrote:

> With bus-type/bus-width properties in the endpoint nodes, the video-
> interface of the connection can be specified for cases where the
> heuristic fails to select the correct output mode. This can happen
> e.g. if not all RGB pins are routed on the PCB; the driver has no
> way of knowing this, and needs to be told explicitly.
> 
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> index 82f2acb3d374..9de434a8f523 100644
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> @@ -15,6 +15,14 @@ Required children nodes:
>   to external devices using the OF graph reprensentation (see ../graph.txt).
>   At least one port node is required.
>  
> +Optional properties in grandchild nodes:
> + Any endpoint grandchild node may specify a desired video interface
> + according to ../../media/video-interfaces.txt, specifically
> + - bus-type: must be <0>.
> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> +   override any output mode selection heuristic, forcing "rgb444",
> +   "rgb565", "rgb666" and "rgb888" respectively.
> +
>  Example:
>  
>  	hlcdc: hlcdc@f0030000 {
> @@ -50,3 +58,21 @@ Example:
>  			#pwm-cells = <3>;
>  		};
>  	};
> +
> +
> +Example 2: With a video interface override to force rgb565; as above
> +but with these changes/additions:
> +
> +	&hlcdc {
> +		hlcdc-display-controller {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +
> +			port@0 {
> +				hlcdc_panel_output: endpoint@0 {
> +					bus-type = <0>;
> +					bus-width = <16>;
> +				};
> +			};
> +		};
> +	};
