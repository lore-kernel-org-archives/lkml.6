Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932160AbeEHKZH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:25:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754211AbeEHKZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:25:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 15:55:00 +0530
From: kgunda@codeaurora.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
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
In-Reply-To: <20180507162004.GB2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
 <20180507162004.GB2259@tuxbook-pro>
Message-ID: <f970143860bd64624e7fad58333df1be@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 21:50, Bjorn Andersson wrote:
> On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
> 
>> WLED4 peripheral is present on some PMICs like pmi8998
>> and pm660l. It has a different register map and also
>> configurations are different. Add support for it.
>> 
> 
> Several things are going on in this patch, it needs to be split to
> not hide the functional changes from the structural/renames.
> 
Ok. I will split it in the next series.
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
>>  drivers/video/backlight/qcom-wled.c                | 749 
>> +++++++++++++++------
>>  2 files changed, 696 insertions(+), 225 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> index fb39e32..0ceffa1 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> @@ -1,30 +1,129 @@
>>  Binding for Qualcomm Technologies, Inc. WLED driver
>> 
>> -Required properties:
>> -- compatible: should be "qcom,pm8941-wled"
>> -- reg: slave address
>> -
>> -Optional properties:
>> -- default-brightness: brightness value on boot, value from: 0-4095
>> -	default: 2048
>> -- label: The name of the backlight device
>> -- qcom,cs-out: bool; enable current sink output
>> -- qcom,cabc: bool; enable content adaptive backlight control
>> -- qcom,ext-gen: bool; use externally generated modulator signal to 
>> dim
>> -- qcom,current-limit: mA; per-string current limit; value from 0 to 
>> 25
>> -	default: 20mA
>> -- qcom,current-boost-limit: mA; boost current limit; one of:
>> -	105, 385, 525, 805, 980, 1260, 1400, 1680
>> -	default: 805mA
>> -- qcom,switching-freq: kHz; switching frequency; one of:
>> -	600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
>> -	1600, 1920, 2400, 3200, 4800, 9600,
>> -	default: 1600kHz
>> -- qcom,ovp: V; Over-voltage protection limit; one of:
>> -	27, 29, 32, 35
>> -	default: 29V
>> -- qcom,num-strings: #; number of led strings attached; value from 1 
>> to 3
>> -	default: 2
>> +WLED (White Light Emitting Diode) driver is used for controlling 
>> display
>> +backlight that is part of PMIC on Qualcomm Technologies, Inc. 
>> reference
>> +platforms. The PMIC is connected to the host processor via SPMI bus.
>> +
>> +- compatible
>> +	Usage:        required
>> +	Value type:   <string>
>> +	Definition:   should be "qcom,pm8941-wled" or "qcom,pmi8998-wled".
>> +		      or "qcom,pm660l-wled".
> 
> Better written as
> 
> 		should be one of:
> 		      	X
> 		      	Y
> 		      	Z
> 
Will do it in the next series.
>> +
>> +- reg
>> +	Usage:        required
>> +	Value type:   <prop encoded array>
>> +	Definition:   Base address of the WLED modules.
>> +
>> +- interrupts
>> +	Usage:        optional
>> +	Value type:   <prop encoded array>
>> +	Definition:   Interrupts associated with WLED. Interrupts can be
>> +		      specified as per the encoding listed under
>> +		      Documentation/devicetree/bindings/spmi/
>> +		      qcom,spmi-pmic-arb.txt.
> 
> Better to describe that this should be the "short" and "ovp" interrupts
> in this property than in the interrupt-names.
> 
Ok. I will do it in the next series.
>> +
>> +- interrupt-names
>> +	Usage:        optional
>> +	Value type:   <string>
>> +	Definition:   Interrupt names associated with the interrupts.
>> +		      Must be "short" and "ovp". The short circuit detection
>> +		      is not supported for PM8941.
>> +
>> +- label
>> +	Usage:        required
>> +	Value type:   <string>
>> +	Definition:   The name of the backlight device
>> +
>> +- default-brightness
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   brightness value on boot, value from: 0-4095
>> +		      Default: 2048
>> +
>> +- qcom,current-limit
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   uA; per-string current limit
> 
> You can't change unit on an existing property, that breaks any existing
> dts using the qcom,pm8941-wled compatible.
> 

>> +		      value:
>> +		      For pm8941: from 0 to 25000 with 5000 ua step
>> +				  Default 20000 uA
>> +		      For pmi8998: from 0 to 30000 with 5000 ua step
>> +				   Default 25000 uA.
> 
> These values could be described just as well in mA, so keep the 
> original
> unit - in particular since the boot-limit is in mA...
> 
Ok. Will keep the original as is in the next series.
>> +
>> +- qcom,current-boost-limit
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   mA; boost current limit.
>> +		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
>> +				 1680. Default: 805 mA
>> +		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
>> +				  1500. Default: 970 mA
>> +
>> +- qcom,switching-freq
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
>> +		      800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
>> +		      4800, 9600.
>> +		      Default: for pm8941: 1600 kHz
>> +			      for pmi8998: 800 kHz
>> +
>> +- qcom,ovp
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   mV; Over-voltage protection limit;
> 
> The existing users of qcom,pm8941-wled depends on this being in V, so
> you can't change the unit. I suggest that you add a new "qcom,ovp-mv"
> property and make the driver fall back to looking for qcom,ovp if that
> isn't specified.
> 
> PS. This is a very good example of why it is a good idea to not
> restructure and make changes at the same time - I almost missed this.
> 
Actually I have checked the current kernel and none of the properties 
are
being configured from the device tree node. Hence, i thought it is the 
right
time modify the units to mV to support the PMI8998.

You still want to have the qcom,ovp-mv, even though it is not being 
configured from
device tree ?
>> +		      For pm8941:  one of 27000, 29000, 32000, 35000
>> +				  Default: 29000 mV
>> +		      For pmi8998: one of 18100, 19600, 29600, 31100
>> +				  Default: 29600 mV
>> +
>> +- qcom,num-strings
>> +	Usage:        optional
>> +	Value type:   <u32>
>> +	Definition:   #; number of led strings attached;
>> +		      for pm8941: value 3.
>> +		      for pmi8998: value 4.
> 
> This was the number of strings actually used, so you can't turn this
> into max number of strings supported. As we have different compatibles
> for the different pmics this can be hard coded in the driver, based on
> compatible, and qcom,num-strings can be kept as a special case of
> qcom,enabled-strings (enabling string 0 through N).
> 
Ok. Actually I don't see the use of this property as the 
qcom,enabled-strings
it self is enough to know the strings to be enabled. But for backward 
compatibility
i keep it as original property.
>> +
>> +- qcom,enabled-strings
>> +	Usage:        optional
>> +	Value tyoe:   <u32>
>> +	Definition:   Bit mask of the WLED strings. Bit 0 to 3 indicates 
>> strings
>> +		      0 to 3 respectively. Each string of leds are operated
>> +		      individually. Specify the strings using the bit mask. Any
>> +		      combination of led strings can be used.
>> +		      for pm8941: Default value is 7 (b111).
>> +		      for pmi8998: Default value is 15 (b1111).
> 
> I think it's better if you describe the enabled strings in an array, as
> it makes the dts easier to read and write for humans.
> 
ok. I will do that in the next series.
> Also I'm uncertain about the validity of these defaults, as it's not
> that the defaults are 7 and 15 it's that if this property is not
> specified all strings will be enabled and the auto calibration will 
> kick
> in to figure out the proper configuration.
> 
> It would be better to describe this as "absence of this property will
> trigger auto calibration".
> 
Ok. I will describe it in the next series.
>> +
>> +- qcom,cs-out
>> +	Usage:        optional
>> +	Value type:   <bool>
>> +	Definition:   enable current sink output.
>> +		      This property is supported only for PM8941.
>> +
>> +- qcom,cabc
>> +	Usage:        optional
>> +	Value type:   <bool>
>> +	Definition:   enable content adaptive backlight control.
>> +
>> +- qcom,ext-gen
>> +	Usage:        optional
>> +	Value type:   <bool>
>> +	Definition:   use externally generated modulator signal to dim.
>> +		      This property is supported only for PM8941.
>> +
>> +- qcom,external-pfet
>> +	Usage:        optional
>> +	Value type:   <bool>
>> +	Definition:   Specify if external PFET control for short circuit
>> +		      protection is used. This property is supported only
>> +		      for PMI8998.
>> +
>> +- qcom,auto-string-detection
>> +	Usage:        optional
>> +	Value type:   <bool>
>> +	Definition:   Enables auto-detection of the WLED string 
>> configuration.
>> +		      This feature is not supported for PM8941.
> 
> I don't like the idea of having the developer specifying
> qcom,enabled-strings and then qcom,auto-string-detection just in case. 
> I
> think it's better to trust the developer when qcom,enabled-strings is
> specified and if not use auto detection.
> 
Ok. I will modify the description in that way.
>> 
>>  Example:
>> 
>> @@ -34,9 +133,26 @@ pm8941-wled@d800 {
>>  	label = "backlight";
>> 
>>  	qcom,cs-out;
>> -	qcom,current-limit = <20>;
>> +	qcom,current-limit = <20000>;
>> +	qcom,current-boost-limit = <805>;
>> +	qcom,switching-freq = <1600>;
>> +	qcom,ovp = <29000>;
>> +	qcom,num-strings = <3>;
>> +	qcom,enabled-strings = <7>;
> 
> Having to change the existing example shows that you made non-backwards
> compatible changes.
> 
Ok. I will keep them as is in the next series.
>> +};
>> +
>> +pmi8998-wled@d800 {
>> +	compatible = "qcom,pmi8998-wled";
>> +	reg = <0xd800 0xd900>;
>> +	label = "backlight";
>> +
>> +	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
>> +		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
>> +	interrupt-names = "short", "ovp";
>> +	qcom,current-limit = <25000>;
>>  	qcom,current-boost-limit = <805>;
>>  	qcom,switching-freq = <1600>;
>> -	qcom,ovp = <29>;
>> -	qcom,num-strings = <2>;
>> +	qcom,ovp = <29600>;
>> +	qcom,num-strings = <4>;
>> +	qcom,enabled-strings = <15>;
>>  };
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 0b6d219..be8b8d3 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -15,253 +15,529 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_address.h>
>>  #include <linux/regmap.h>
>> 
>>  /* From DT binding */
>> -#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
>> +#define WLED_DEFAULT_BRIGHTNESS				2048
> 
> These renames are good, but needs to go in a separate commit (either
> patch 1 or a new one), the current approach makes it impossible to
> review the rest of this patch.
> 
> 
> So, as the DT change is substantial that should be split in one patch
> that change the structure, then one that adds the new properties, one
> patch that renames pm8941 -> wled3 and finally one that adds wled4
> support.
> 
Ok. I will split the patches as you suggested.
> Regards,
> Bjorn
