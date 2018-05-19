Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeESNh1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 09:37:27 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:42623 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeESNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 09:37:25 -0400
Subject: Re: [PATCH 2/3] dt-bindings: new binding for Ilitek ILI9341 display
 panels
To: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
References: <20180515014349.26226-1-david@lechnology.com>
 <20180515014349.26226-3-david@lechnology.com>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <50928486-822a-aff3-7c37-cc1c40cb62b8@tronnes.org>
Date: Sat, 19 May 2018 15:37:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515014349.26226-3-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 15.05.2018 03.43, skrev David Lechner:
> This adds a new binding for Ilitek ILI9341 display panels. It includes
> a compatible string for one display (more can be added in the future).
>
> The vendor prefix "noname" is used because the vendor is not known.
> The YX240QV29-T panel[1] is found, for example, in an Adafruit breakout
> board[2] and in Mindsensors' PiStorms[3].
>
> [1]: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf
> [2]: https://www.adafruit.com/product/2478
> [3]: http://www.mindsensors.com/stem-with-robotics/13-pistorms-v2-base-kit-raspberry-pi-brain-for-lego-robot
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>   .../bindings/display/ilitek,ili9341.txt       | 27 +++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>
> diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
> new file mode 100644
> index 000000000000..0fc90b2dd732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
> @@ -0,0 +1,27 @@
> +Ilitek ILI9341 display panels
> +
> +This binding is for display panels using an Ilitek ILI9341 controller in SPI
> +mode.
> +
> +Required properties:
> +- compatible:	"noname,yx240qv29", "ilitek,ili9341"

Calling a vendor 'noname' looks a bit odd and AFAICT it isn't used by
any other binding. A google search always mentions Adafruit in
connection with this panel, so I suggest we use Adafruit as vendor.

I don't think we should use "ilitek,ili9341" as an option/fallback,
because panels varies in resolution (rarely) and initialization. A
generic ili9341 driver would probably not work with a random new panel.

> +- dc-gpios:	D/C pin
> +- reset-gpios:	Reset pin
> +
> +The node for this driver must be a child node of a SPI controller, hence
> +all mandatory properties described in ../spi/spi-bus.txt must be specified.
> +
> +Optional properties:
> +- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
> +- backlight:	phandle of the backlight device attached to the panel

You forgot to mention the regulator that you support in the driver.

Noralf.

> +
> +Example:
> +	display@0{
> +		compatible = "noname,yx240qv29", "ilitek,ili9341";
> +		reg = <0>;
> +		spi-max-frequency = <32000000>;
> +		dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
> +		rotation = <270>;
> +		backlight = <&backlight>;
> +	};
