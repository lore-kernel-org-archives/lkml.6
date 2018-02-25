Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBYOcP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 09:32:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37149 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBYOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 09:32:10 -0500
X-Google-Smtp-Source: AG47ELv28/GjtMM9bYZoPKmJQSDranwbh+WeT+C/V2KlKKxQWxI+jDHrHGOYkGS0tm0OZUltyMS3Kg==
Subject: Re: [PATCH v4 1/2] leds: ncp5623: Add device tree binding
 documentation
To: Florian Vaussard <florian.vaussard@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20180221214654.3306-1-florian.vaussard@gmail.com>
 <20180221214654.3306-2-florian.vaussard@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <9ed5c785-c40b-6e6e-a727-ba8b58517fa1@gmail.com>
Date: Sun, 25 Feb 2018 15:30:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180221214654.3306-2-florian.vaussard@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thanks for the v4.

On 02/21/2018 10:46 PM, Florian Vaussard wrote:
> Add device tree binding documentation for On Semiconductor NCP5623 I2C
> LED driver. The driver can independently control the PWM of the 3
> channels with 32 levels of intensity.
> 
> The current delivered by the current source can also be controlled. To
> do so, the led-max-microamp property is used by each LED sub-node. The
> maximum value is then found and used as a limit to compute the final
> intensity of the current source. If a LED happens to have a lower limit,
> the PWM is then used to limit the current to the requested value.
> 
> In order to control the current source, it is also necessary to know
> the current on the Iref pin, hence the onnn,led-iref-microamp property.
> It is usually set using an external bias resistor, following
> Iref = Vref/Rbias with Vref=0.6V.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/leds/leds-ncp5623.txt      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-ncp5623.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-ncp5623.txt b/Documentation/devicetree/bindings/leds/leds-ncp5623.txt
> new file mode 100644
> index 000000000000..d83e5094343e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-ncp5623.txt
> @@ -0,0 +1,60 @@
> +* ON Semiconductor - NCP5623 3-Channel LED Driver
> +
> +The NCP5623 is a 3-channel I2C LED driver. The brightness of each
> +channel can be independently set using 32 levels. Each LED is represented
> +as a sub-node of the device.
> +
> +Required properties:
> +  - compatible: Should be "onnn,ncp5623"
> +  - reg: I2C slave address (fixed to 0x38)
> +  - #address-cells: must be 1
> +  - #size-cells: must be 0
> +  - onnn,led-iref-microamp: Current on the Iref pin in microampere. It depends
> +    on the value of the external bias resistor Rbias, following
> +    Iref = Vref / Rbias with Vref = 0.6V. This is used to set the intensity of
> +    the current that can be provided by the internal current source, based on
> +    the maximum current permitted by LED sub-nodes (see below), but no more than
> +    Imax = 2400 * Iref.
> +
> +LED sub-nodes
> +=============
> +
> +Required properties:
> +  - reg : LED channel number (0..2)
> +  - led-max-microamp: Maximum allowable current inside the LED in microampere.
> +    This property is used to limit the PWM ratio, based on the intensity of the
> +    internal current source (see above).
> +
> +Optional properties:
> +  - label: see Documentation/devicetree/bindings/leds/common.txt
> +  - linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example
> +=======
> +
> +led1: ncp5623@38 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "onnn,ncp5623";
> +	reg = <0x38>;
> +	onnn,led-iref-microamp = <10>;
> +
> +	led1r@0 {
> +		label = "ncp:power:red";
> +		linux,default-trigger = "default-on";
> +		reg = <0>;
> +		led-max-microamp = <20000>;
> +	};
> +
> +	led1b@1 {
> +		label = "ncp:power:blue";
> +		reg = <1>;
> +		led-max-microamp = <20000>;
> +	};
> +
> +	led1g@2 {
> +		label = "ncp:power:green";
> +		reg = <2>;
> +		led-max-microamp = <20000>;
> +	};
> +};
> 

Some time ago we was instructed how our DT bindings should
look like. See [0]. In view of that, the above should be changed
as below. Please note dropped "ncp:" segment from label. Also
LED class device name pattern is "devicename:colour:function",
so you will have to reverse the order of segments in your labels.
Last but not least - couldn't the LED functions be better
distinguishable - now we have "power" for all three LEDs?


led-controller@38 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "onnn,ncp5623";
	reg = <0x38>;
	onnn,led-iref-microamp = <10>;

	led@0 {
		label = "red:power";
		linux,default-trigger = "default-on";
		reg = <0>;
		led-max-microamp = <20000>;
	};

	led@1 {
		label = "blue:power";
		reg = <1>;
		led-max-microamp = <20000>;
	};

	led@2 {
		label = "green:power";
		reg = <2>;
		led-max-microamp = <20000>;
	};

You can refer to drivers/leds/leds-lp8860.c on how to construct
the label. Generally from the discussions with DT maintainer
it turned out that we shouldn't have controller name in the LED
class device name at all, but it will have to be addressed globally
for all LED class drivers at once at some point.


[0] https://patchwork.kernel.org/patch/10093757/

-- 
Best regards,
Jacek Anaszewski
