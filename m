Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757039AbeDFNvQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:51:16 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35089 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeDFNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:51:12 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas =?ISO-8859-1?Q?S=F6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: Re: [PATCH 7/7] arm64: dts: renesas: eagle: Add ADV7511W and HDMI output
Date: Fri, 06 Apr 2018 16:51:11 +0300
Message-ID: <2235860.8H9ojNphtF@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1523020092-25540-8-git-send-email-jacopo+renesas@jmondi.org>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org> <1523020092-25540-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36DpMPZ016677

Hi Jacopo,

Thank you for the patch.

On Friday, 6 April 2018 16:08:12 EEST Jacopo Mondi wrote:
> From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Enable HDMI output adding the HDMI connector and the ADV7511W, connected
> to THC63LVD1024 LVDS decoder output.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 51 ++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts index 9d0e65d..e9f7b83
> 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -32,6 +32,17 @@
>  		reg = <0x0 0x48000000 0x0 0x38000000>;
>  	};
> 
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_out: endpoint {
> +				remote-endpoint = <&adv7511_out>;
> +			};
> +		};
> +	};
> +
>  	thc63lvd1024: lvds-decoder {
>  		compatible = "thine,thc63lvd1024";
> 
> @@ -41,11 +52,17 @@
> 
>  			port@0 {
>  				reg = <0>;
> -

This is unrelated, if you don't want a blank line here remove it from patch 
6/7 :-)

>  				thc63lvd1024_in: endpoint {
>  					remote-endpoint = <&lvds0_out>;
>  				};
>  			};
> +
> +			port@2 {
> +				reg = <2>;
> +				thc63lvd1024_out: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +			};
>  		};
>  	};
>  };
> @@ -85,6 +102,38 @@
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  	};
> +
> +	hdmi@39 {
> +		compatible = "adi,adv7511w";
> +		reg = <0x39>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
> +
> +		adi,input-depth = <8>;
> +		adi,input-colorspace = "rgb";
> +		adi,input-clock = "1x";
> +		adi,input-style = <1>;
> +		adi,input-justification = "evenly";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7511_in: endpoint {
> +					remote-endpoint = <&thc63lvd1024_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7511_out: endpoint {
> +					remote-endpoint = <&hdmi_con_out>;
> +				};
> +			};
> +		};
> +	};
>  };
> 
>  &pfc {

With patches 5/7, 6/7 and 7/7 merged together and the pinmux removed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
