Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeEUOu3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:50:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48392 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEUOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:50:28 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: niklas.soderlund@ragnatech.se, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] arm64: dts: renesas: draak: Describe CVBS input
Date: Mon, 21 May 2018 17:50:50 +0300
Message-ID: <1958464.yiJe0NDHa3@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1526913942-15426-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org> <1526913942-15426-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4LEoXSD015568

Hi Jacopo,

Thank you for the patch.

On Monday, 21 May 2018 17:45:41 EEST Jacopo Mondi wrote:
> Describe CVBS video input through analog video decoder ADV7180
> connected to video input interface VIN4.
> 
> The video input signal path is shared with HDMI video input, and
> selected by on-board switches SW-53 and SW-54 with CVBS input selected
> by the default switches configuration.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3 -> v4:
> - Use 'adi,adv7180cp' compatible string in place of just 'adi,adv7180'
>   as suggested by Laurent.
> - Re-structure CVBS input ports definition according to adv7180cp
>   bindings: add port@0 for composite input, add port@3 for parallel
>   video output.
> - Change node label to 'composite-in' as in Gose board bindings.
> 
> v2 -> v3:
> - Add comment to describe the shared input video path.
> - Add my SoB and Niklas' R-b tags.
> ---
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 68
> ++++++++++++++++++++++++++ 1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index 9d73de8..ad59032
> 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> @@ -59,6 +59,16 @@
>  		};
>  	};
> 
> +	composite-in {
> +		compatible = "composite-video-connector";
> +
> +		port {
> +			composite_con_in: endpoint {
> +				remote-endpoint = <&adv7180_in>;
> +			};
> +		};
> +	};
> +
>  	memory@48000000 {
>  		device_type = "memory";
>  		/* first 128MB is reserved for secure area. */
> @@ -142,6 +152,11 @@
>  		groups = "usb0";
>  		function = "usb0";
>  	};
> +
> +	vin4_pins_cvbs: vin4 {
> +		groups = "vin4_data8", "vin4_sync", "vin4_clk";
> +		function = "vin4";
> +	};
>  };
> 
>  &i2c0 {
> @@ -154,6 +169,39 @@
>  		reg = <0x50>;
>  		pagesize = <8>;
>  	};
> +
> +	composite-in@20 {
> +		compatible = "adi,adv7180cp";
> +		reg = <0x20>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7180_in: endpoint {
> +					remote-endpoint = <&composite_con_in>;
> +				};
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +
> +				/*
> +				 * The VIN4 video input path is shared between
> +				 * CVBS and HDMI inputs through SW[49-53]
> +				 * switches.
> +				 *
> +				 * CVBS is the default selection, link it to
> +				 * VIN4 here.
> +				 */
> +				adv7180_out: endpoint {
> +					remote-endpoint = <&vin4_in>;
> +				};
> +			};
> +		};
> +	};
>  };
> 
>  &i2c1 {
> @@ -246,3 +294,23 @@
>  	timeout-sec = <60>;
>  	status = "okay";
>  };
> +
> +&vin4 {
> +	pinctrl-0 = <&vin4_pins_cvbs>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			vin4_in: endpoint {
> +				remote-endpoint = <&adv7180_out>;
> +			};
> +		};
> +	};
> +};


-- 
Regards,

Laurent Pinchart
