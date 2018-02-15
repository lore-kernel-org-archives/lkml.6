Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033012AbeBONoB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:44:01 -0500
Received: from smtpweb130.aruba.it ([62.149.158.130]:37858 "EHLO
        smtpweb130.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032959AbeBONn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:43:59 -0500
Subject: Re: [PATCH 2/2] pps-gpio: Set echo GPIO pin via devicetree
To: Lukas Senger <lukas@fridolin.com>
Cc: linux-kernel@vger.kernel.org
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
 <20180215125921.29494-1-lukas@fridolin.com>
 <20180215125921.29494-3-lukas@fridolin.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <eb34d5ef-2e99-5983-8bdd-bf6fd0dc8bd2@enneenne.com>
Date: Thu, 15 Feb 2018 14:43:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215125921.29494-3-lukas@fridolin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/18 13:59, Lukas Senger wrote:
> ---
>   arch/arm/boot/dts/overlays/pps-gpio-overlay.dts | 13 ++++++++-----
>   drivers/pps/clients/pps-gpio.c                  | 26 ++++++++++++++-----------
>   include/linux/pps-gpio.h                        |  1 +
>   3 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts b/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts
> index 9ee4bdfa6167..06e6cf5fc6ea 100644
> --- a/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts
> +++ b/arch/arm/boot/dts/overlays/pps-gpio-overlay.dts
> @@ -10,7 +10,8 @@
>   				compatible = "pps-gpio";
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&pps_pins>;
> -				gpios = <&gpio 18 0>;
> +				in-gpios = <&gpio 18 0>;

Please, don't break backward compatibility! You can leave "gpios" as is and 
using, for instance, "echo-gpios" for echoing purposes. -+
                                                          |
                                     +--------------------+
                                     |
                                 vvvvvvvvv
> +				out-gpios = <&gpio 17 0>;
>   				status = "okay";
>   			};
>   		};
> @@ -20,18 +21,20 @@
>   		target = <&gpio>;
>   		__overlay__ {
>   			pps_pins: pps_pins@12 {
> -				brcm,pins =     <18>;
> -				brcm,function = <0>;    // in
> -				brcm,pull =     <0>;    // off
> +				brcm,pins =     <18 17>;
> +				brcm,function = <0 1>;    // in  out
> +				brcm,pull =     <0 0>;    // off off

These modifications are not PPS related.

>   			};
>   		};
>   	};
>   
>   	__overrides__ {
> -		gpiopin = <&pps>,"gpios:4",
> +		gpiopin = <&pps>,"in-gpios:4",
>   			  <&pps>,"reg:0",
>   			  <&pps_pins>,"brcm,pins:0",
>   			  <&pps_pins>,"reg:0";
> +		echopin = <&pps>,"out-gpios:4",
> +			  <&pps_pins>,"brcm,pins:4";

Ditto.

>   		assert_falling_edge = <&pps>,"assert-falling-edge?";
>   	};
>   };
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 35c3b14fc9b9..ce3065889a7e 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -37,10 +37,6 @@
>   #include <linux/of_gpio.h>
>   #include <linux/delay.h>
>   
> -/* TODO: this should work like gpio_pin below but I don't know how to work with
> - * devicetree overlays.
> - */
> -#define PPS_GPIO_ECHO_PIN 17

Please provide patches against current kernel code and not against your old patches.

I stop reviewing here since following modifications are similar to just reviewed 
and not acceptable. I'm sorry.

Ciao,

Rodolfo

-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
