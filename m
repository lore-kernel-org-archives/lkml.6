Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934986AbeBMMJz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:09:55 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:42051 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934801AbeBMMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:09:53 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kbingham@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, Mark Brown <broonie@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: adv7511: Add support for i2c_new_secondary_device
Date: Tue, 13 Feb 2018 14:10:23 +0200
Message-ID: <138061694.kW5LlSP0Rd@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518473273-6333-3-git-send-email-kbingham@kernel.org>
References: <1518473273-6333-1-git-send-email-kbingham@kernel.org> <1518473273-6333-3-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1DCA0E0002871

Hi Kieran,

Thank you for the patch.

On Tuesday, 13 February 2018 00:07:50 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The ADV7511 has four 256-byte maps that can be accessed via the main I²C
> ports. Each map has it own I²C address and acts as a standard slave
> device on the I²C bus.
> 
> Extend the device tree node bindings to be able to override the default
> addresses so that address conflicts with other devices on the same bus
> may be resolved at the board description level.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Same comment as for 1/5 about the subject line.

> ---
> v2:
>  - Fixed up reg: property description to account for multiple optional
>    addresses.
>  - Minor reword to commit message to account for DT only change
>  - Collected Robs RB tag
> 
> v3:
>  - Split map register addresses into individual declarations.
> 
>  .../devicetree/bindings/display/bridge/adi,adv7511.txt | 18 +++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt index
> 0047b1394c70..3f85c351dd39 100644
> --- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> @@ -14,7 +14,13 @@ Required properties:
>  		"adi,adv7513"
>  		"adi,adv7533"
> 
> -- reg: I2C slave address
> +- reg: I2C slave addresses
> +  The ADV7511 internal registers are split into four pages exposed through
> +  different I2C addresses, creating four register maps. Each map has it own
> +  I2C address and acts as a standard slave device on the I²C bus. The main
> +  address is mandatory, others are optional and revert to defaults if not
> +  specified.

Nitpicking again, you're mixing I2C and I²C.

> +
> 
>  The ADV7511 supports a large number of input data formats that differ by
> their color depth, color format, clock mode, bit justification and random
> @@ -70,6 +76,9 @@ Optional properties:
>    rather than generate its own timings for HDMI output.
>  - clocks: from common clock binding: reference to the CEC clock.
>  - clock-names: from common clock binding: must be "cec".
> +- reg-names : Names of maps with programmable addresses.
> +	It can contain any map needing a non-default address.
> +	Possible maps names are : "main", "edid", "cec", "packet"
> 
>  Required nodes:
> 
> @@ -88,7 +97,12 @@ Example
> 
>  	adv7511w: hdmi@39 {
>  		compatible = "adi,adv7511w";
> -		reg = <39>;
> +		/*
> +		 * The EDID page will be accessible on address 0x66 on the i2c

And now you're using lowercase :-)

> +		 * bus. All other maps continue to use their default addresses.
> +		 */
> +		reg = <0x39>, <0x66>;
> +		reg-names = "main", "edid";
>  		interrupt-parent = <&gpio3>;
>  		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
>  		clocks = <&cec_clock>;

With these fixed (or not, up to you),

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
