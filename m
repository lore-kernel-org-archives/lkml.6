Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeEGQSr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:18:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54361 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeEGQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:18:43 -0400
X-Google-Smtp-Source: AB8JxZpYGqwFNhFOKyIyOE04zaGceJZE4JQxuEh0fqqpTbkkPt7vYL46e61diJtnnGKVynP/7b4yzA==
Date: Mon, 7 May 2018 09:20:04 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4
 peripheral
Message-ID: <20180507162004.GB2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:

> WLED4 peripheral is present on some PMICs like pmi8998
> and pm660l. It has a different register map and also
> configurations are different. Add support for it.
> 

Several things are going on in this patch, it needs to be split to
not hide the functional changes from the structural/renames.

> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
>  drivers/video/backlight/qcom-wled.c                | 749 +++++++++++++++------
>  2 files changed, 696 insertions(+), 225 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> index fb39e32..0ceffa1 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> @@ -1,30 +1,129 @@
>  Binding for Qualcomm Technologies, Inc. WLED driver
>  
> -Required properties:
> -- compatible: should be "qcom,pm8941-wled"
> -- reg: slave address
> -
> -Optional properties:
> -- default-brightness: brightness value on boot, value from: 0-4095
> -	default: 2048
> -- label: The name of the backlight device
> -- qcom,cs-out: bool; enable current sink output
> -- qcom,cabc: bool; enable content adaptive backlight control
> -- qcom,ext-gen: bool; use externally generated modulator signal to dim
> -- qcom,current-limit: mA; per-string current limit; value from 0 to 25
> -	default: 20mA
> -- qcom,current-boost-limit: mA; boost current limit; one of:
> -	105, 385, 525, 805, 980, 1260, 1400, 1680
> -	default: 805mA
> -- qcom,switching-freq: kHz; switching frequency; one of:
> -	600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
> -	1600, 1920, 2400, 3200, 4800, 9600,
> -	default: 1600kHz
> -- qcom,ovp: V; Over-voltage protection limit; one of:
> -	27, 29, 32, 35
> -	default: 29V
> -- qcom,num-strings: #; number of led strings attached; value from 1 to 3
> -	default: 2
> +WLED (White Light Emitting Diode) driver is used for controlling display
> +backlight that is part of PMIC on Qualcomm Technologies, Inc. reference
> +platforms. The PMIC is connected to the host processor via SPMI bus.
> +
> +- compatible
> +	Usage:        required
> +	Value type:   <string>
> +	Definition:   should be "qcom,pm8941-wled" or "qcom,pmi8998-wled".
> +		      or "qcom,pm660l-wled".

Better written as

		should be one of:
		      	X
		      	Y
		      	Z

> +
> +- reg
> +	Usage:        required
> +	Value type:   <prop encoded array>
> +	Definition:   Base address of the WLED modules.
> +
> +- interrupts
> +	Usage:        optional
> +	Value type:   <prop encoded array>
> +	Definition:   Interrupts associated with WLED. Interrupts can be
> +		      specified as per the encoding listed under
> +		      Documentation/devicetree/bindings/spmi/
> +		      qcom,spmi-pmic-arb.txt.

Better to describe that this should be the "short" and "ovp" interrupts
in this property than in the interrupt-names.

> +
> +- interrupt-names
> +	Usage:        optional
> +	Value type:   <string>
> +	Definition:   Interrupt names associated with the interrupts.
> +		      Must be "short" and "ovp". The short circuit detection
> +		      is not supported for PM8941.
> +
> +- label
> +	Usage:        required
> +	Value type:   <string>
> +	Definition:   The name of the backlight device
> +
> +- default-brightness
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   brightness value on boot, value from: 0-4095
> +		      Default: 2048
> +
> +- qcom,current-limit
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   uA; per-string current limit

You can't change unit on an existing property, that breaks any existing
dts using the qcom,pm8941-wled compatible.

> +		      value:
> +		      For pm8941: from 0 to 25000 with 5000 ua step
> +				  Default 20000 uA
> +		      For pmi8998: from 0 to 30000 with 5000 ua step
> +				   Default 25000 uA.

These values could be described just as well in mA, so keep the original
unit - in particular since the boot-limit is in mA...

> +
> +- qcom,current-boost-limit
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mA; boost current limit.
> +		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
> +				 1680. Default: 805 mA
> +		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
> +				  1500. Default: 970 mA
> +
> +- qcom,switching-freq
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
> +		      800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
> +		      4800, 9600.
> +		      Default: for pm8941: 1600 kHz
> +			      for pmi8998: 800 kHz
> +
> +- qcom,ovp
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   mV; Over-voltage protection limit;

The existing users of qcom,pm8941-wled depends on this being in V, so
you can't change the unit. I suggest that you add a new "qcom,ovp-mv"
property and make the driver fall back to looking for qcom,ovp if that
isn't specified.

PS. This is a very good example of why it is a good idea to not
restructure and make changes at the same time - I almost missed this.

> +		      For pm8941:  one of 27000, 29000, 32000, 35000
> +				  Default: 29000 mV
> +		      For pmi8998: one of 18100, 19600, 29600, 31100
> +				  Default: 29600 mV
> +
> +- qcom,num-strings
> +	Usage:        optional
> +	Value type:   <u32>
> +	Definition:   #; number of led strings attached;
> +		      for pm8941: value 3.
> +		      for pmi8998: value 4.

This was the number of strings actually used, so you can't turn this
into max number of strings supported. As we have different compatibles
for the different pmics this can be hard coded in the driver, based on
compatible, and qcom,num-strings can be kept as a special case of
qcom,enabled-strings (enabling string 0 through N).

> +
> +- qcom,enabled-strings
> +	Usage:        optional
> +	Value tyoe:   <u32>
> +	Definition:   Bit mask of the WLED strings. Bit 0 to 3 indicates strings
> +		      0 to 3 respectively. Each string of leds are operated
> +		      individually. Specify the strings using the bit mask. Any
> +		      combination of led strings can be used.
> +		      for pm8941: Default value is 7 (b111).
> +		      for pmi8998: Default value is 15 (b1111).

I think it's better if you describe the enabled strings in an array, as
it makes the dts easier to read and write for humans.

Also I'm uncertain about the validity of these defaults, as it's not
that the defaults are 7 and 15 it's that if this property is not
specified all strings will be enabled and the auto calibration will kick
in to figure out the proper configuration.

It would be better to describe this as "absence of this property will
trigger auto calibration".

> +
> +- qcom,cs-out
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   enable current sink output.
> +		      This property is supported only for PM8941.
> +
> +- qcom,cabc
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   enable content adaptive backlight control.
> +
> +- qcom,ext-gen
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   use externally generated modulator signal to dim.
> +		      This property is supported only for PM8941.
> +
> +- qcom,external-pfet
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   Specify if external PFET control for short circuit
> +		      protection is used. This property is supported only
> +		      for PMI8998.
> +
> +- qcom,auto-string-detection
> +	Usage:        optional
> +	Value type:   <bool>
> +	Definition:   Enables auto-detection of the WLED string configuration.
> +		      This feature is not supported for PM8941.

I don't like the idea of having the developer specifying
qcom,enabled-strings and then qcom,auto-string-detection just in case. I
think it's better to trust the developer when qcom,enabled-strings is
specified and if not use auto detection.

>  
>  Example:
>  
> @@ -34,9 +133,26 @@ pm8941-wled@d800 {
>  	label = "backlight";
>  
>  	qcom,cs-out;
> -	qcom,current-limit = <20>;
> +	qcom,current-limit = <20000>;
> +	qcom,current-boost-limit = <805>;
> +	qcom,switching-freq = <1600>;
> +	qcom,ovp = <29000>;
> +	qcom,num-strings = <3>;
> +	qcom,enabled-strings = <7>;

Having to change the existing example shows that you made non-backwards
compatible changes.

> +};
> +
> +pmi8998-wled@d800 {
> +	compatible = "qcom,pmi8998-wled";
> +	reg = <0xd800 0xd900>;
> +	label = "backlight";
> +
> +	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
> +		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
> +	interrupt-names = "short", "ovp";
> +	qcom,current-limit = <25000>;
>  	qcom,current-boost-limit = <805>;
>  	qcom,switching-freq = <1600>;
> -	qcom,ovp = <29>;
> -	qcom,num-strings = <2>;
> +	qcom,ovp = <29600>;
> +	qcom,num-strings = <4>;
> +	qcom,enabled-strings = <15>;
>  };
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 0b6d219..be8b8d3 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -15,253 +15,529 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/regmap.h>
>  
>  /* From DT binding */
> -#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
> +#define WLED_DEFAULT_BRIGHTNESS				2048

These renames are good, but needs to go in a separate commit (either
patch 1 or a new one), the current approach makes it impossible to
review the rest of this patch.


So, as the DT change is substantial that should be split in one patch
that change the structure, then one that adds the new properties, one
patch that renames pm8941 -> wled3 and finally one that adds wled4
support.

Regards,
Bjorn
