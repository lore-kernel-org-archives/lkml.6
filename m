Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeCTMme (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:42:34 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:33840 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeCTMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:42:29 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
Date: Tue, 20 Mar 2018 14:43:33 +0200
Message-ID: <4060923.7DxT9ae38L@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1521213399-31947-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org> <1521213399-31947-2-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2KCgg1l008942

Hi Jacopo,

(CC'ing Rob)

Thank you for the patch.

On Friday, 16 March 2018 17:16:37 EET Jacopo Mondi wrote:
> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> new file mode 100644
> index 0000000..8225c6a
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -0,0 +1,66 @@
> +Thine Electronics THC63LVD1024 LVDS decoder
> +-------------------------------------------
> +
> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS
> streams
> +to parallel data outputs. The chip supports single/dual input/output modes,
> +handling up to two two input LVDS stream and up to two digital CMOS/TTL
> outputs.
> +
> +Single or dual operation modes, output data mapping and DDR output modes
> are
> +configured through input signals and the chip does not expose any control
> bus.
> +
> +Required properties:
> +- compatible: Shall be "thine,thc63lvd1024"
> +
> +Optional properties:
> +- vcc-supply: Power supply for TTL output and digital circuitry
> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
> +- lvcc-supply: Power supply for LVDS inputs
> +- pvcc-supply: Power supply for PLL circuitry

As explained in a comment to one of the previous versions of this series, I'm 
tempted to make vcc-supply mandatory and drop the three other power supplies 
for now, as I believe there's very little chance they will be connected to 
separately controllable regulators (all supplies use the same voltage). In the 
very unlikely event that this occurs in design we need to support in the 
future, the cvcc, lvcc and pvcc supplies can be added later as optional 
without breaking backward compatibility.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +- pdwn-gpios: Power down GPIO signal. Active low
> +- oe-gpios: Output enable GPIO signal. Active high
> +
> +The THC63LVD1024 video port connections are modeled according
> +to OF graph bindings specified by
> Documentation/devicetree/bindings/graph.txt
> +
> +Required video port nodes:
> +- Port@0: First LVDS input port
> +- Port@2: First digital CMOS/TTL parallel output
> +
> +Optional video port nodes:
> +- Port@1: Second LVDS input port
> +- Port@3: Second digital CMOS/TTL parallel output
> +
> +Example:
> +--------
> +
> +	thc63lvd1024: lvds-decoder {
> +		compatible = "thine,thc63lvd1024";
> +
> +		vcc-supply = <&reg_lvds_vcc>;
> +		lvcc-supply = <&reg_lvds_lvcc>;
> +
> +		pdwn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				lvds_dec_in_0: endpoint {
> +					remote-endpoint = <&lvds_out>;
> +				};
> +			};
> +
> +			port@2{
> +				reg = <2>;
> +
> +				lvds_dec_out_2: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +
> +			};
> +
> +		};
> +	};

-- 
Regards,

Laurent Pinchart
