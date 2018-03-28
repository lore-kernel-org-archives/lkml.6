Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeC1TRj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:17:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35637 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbeC1TRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:17:37 -0400
X-Google-Smtp-Source: AIpwx4/iuWcJ2u0WiZBKaO8hAXxlPfn17SDhji7MIIsYKbkFqAa5x0guYtFnai9amjPBNQumtLzXD3gxWTRktscol60=
MIME-Version: 1.0
In-Reply-To: <20180328162416.GB25325@roeck-us.net>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
 <1522250043-8065-2-git-send-email-tharvey@gateworks.com> <20180328162416.GB25325@roeck-us.net>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 Mar 2018 12:17:34 -0700
Message-ID: <CAJ+vNU2aUN4ME3+RA3DNPO75O6vPBcQpuRSfQJ4_Ns_zQAtCCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Add Gateworks System Controller bindings
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 9:24 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Mar 28, 2018 at 08:14:00AM -0700, Tim Harvey wrote:
>> This patch adds documentation of device-tree bindings for the
>> Gateworks System Controller (GSC).
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>> v3:
>>  - replaced _ with -
>>  - remove input bindings
>>  - added full description of hwmon
>>  - fix unit address of hwmon child nodes
>>
>> ---
>>  .../devicetree/bindings/mfd/gateworks-gsc.txt      | 135 +++++++++++++++++++++
>>  1 file changed, 135 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt b/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
>> new file mode 100644
>> index 0000000..8f530ed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
>> @@ -0,0 +1,135 @@
>> +Gateworks System Controller multi-function device
>> +
>> +The GSC is a Multifunction I2C slave device with the following submodules:
>> +- WDT
>> +- GPIO
>> +- Pushbutton controller
>> +- HWMON
>> +
>> +Required properties:
>> +- compatible : Must be "gw,gsc"
>> +- reg: I2C address of the device
>> +- interrupts: interrupt triggered by GSC_IRQ# signal
>> +- interrupt-parent: Interrupt controller GSC is connected to
>> +- #interrupt-cells: should be <1>, index of the interrupt within the
>> +  controller, in accordance with the "one cell" variant of
>> +  <devicetree/bindings/interrupt-controller/interrupt.txt>
>> +
>> +Optional nodes:
>> +* watchdog:
>> +The GSC provides a Watchdog monitor which can power cycle the board's
>> +primary power supply on most board models when tripped.
>> +
>> +Required watchdog properties:
>> +- compatible: must be "gw,gsc-watchdog"
>> +
>> +* hwmon:
>> +The GSC provides a set of Analog to Digitcal Converter (ADC) pins used for
>> +temperature and/or voltage monitoring.
>> +
>> +Required hwmon properties:
>> +- compatible: must be "gw,gsc-hwmon"
>> +
>
> "hwmon" is a very Linux specific term. It might make sense to find a more
> generic term.

The 'hwmon' driver supports child nodes that fall into the following category:
 - temperature sensor (GSC internal temperature sensor - i2c registers
returns value in C*10)
 - voltage rails (two types here; cooked: i2c registers return
pre-scaled value in mV), raw: i2c registers return a raw ADC value
that must be scaled based on ADC internal ref voltage and resolution
and adjusted for a voltage divider to convert to mV
 - fan setpoints (I'll explain these below)

I called the node 'gw,gsc-hwmon' because the driver fits into the
'hwmon' API. Isn't that appropriate here for the driver compatible
string?

>
>> +Optional hwmon properties:
>> +- gw,reference-voltage: ADC reference voltage (mV) used in scaling raw ADCs
>
> AFAIK devicetree likes to specify voltages in uV.

There are currently plenty of dt props specified in mV (grep -r mV
Documentation/devicetree/bindings/).

>
>> +- gw,resolution: ADC resolution (ie 4096) used in scaling raw ADCs
>> +
>
> 4096 what ?

reference-voltage and resolution are used to scale the values from the
nodes that report a raw ADC value:

V = Vadc * (reference-voltage / resolution)

I can provide that in bits if it makes more sense? I can also hard
code both the resolution and the vref in the hwmon driver and remove
it from dt as currently the only GSC that uses raw ADC values is 12bit
with 2.5V ref.

>
>> +Each hwmon child node defines an ADC input on the chip which the GSC may
>> +report cooked values (ie temperature sensor based on thermister), raw values,
>> +(ie voltage rail with a pre-scaling resistor divider), or a fan controller
>> +setpoint.
>> +
>> +Required hwmon child properties:
>> +- type: one of the following ADC types:
>> +  "gw,hwmon-temperature" - reports temperature in C*10
>> +  "gw,hwmon-voltage" - reports a pre-scaled voltage value
>> +  "gw,hwmon-voltage-raw" - reports a raw ADC that is scaled with
>> +       vreference, resolution, and optional resistor divider
>> +  "gw,hwmon-fan" - a fan temperature setpoint in C*10
>
> What is a "fan temperature setpoint" ?
>

The GSC supports a fan controller which drives a PWM signal to vary
the speed of a fan based on the GSC internal temperature sensor. The
FAN controller has 6 setpoints each having a fixed PWM duty-cycle but
the temperature at which those setpoints kick in can be varies via
registers at the 0x29 slave address (same slave address as the
temperature sensor and voltage inputs which is why I have it in the
hwmon driver):

fan0_point - 50% PWM (default 300)
fan1_point - 60% PWM (default 330)
fan2_point - 70% PWM (default 360)
fan3_point - 80% PWM (default 390)
fan4_point - 90% PWM (default 420)
fan5_point - 100% PWM (default 450)

The values are C/10 thus if the internal GSC temp sensor is below 30C
the fan output will be 0% duty cycle and if it hits 30C it will go to
50% until it hits 60% at 33C etc.

That is the hardware implementation that I'm trying to abstract and
define here. You pointed out the fact that the fan*_input ABI is
read-only fan PWM and I see that now. What do you suggest I use for
this feature I'm trying to implement driver support for?

I did notice that nouveau_hwmon.c has a single temperature setpoint
similar to this that they support with SENSOR_DEVICE_ATTR:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nouveau_hwmon.c#L63

>> +- reg: offset of the ADC register
>> +- label: name of the ADC input or FAN setpoint
>> +
>> +Optional hwmon child properties:
>> +- gw,voltage-divider: An array of two integers containing the resistor
>> +  values R1 and R2 of the optinal resistor divider on a raw ADC
>> +- gw,voltage-offset: a mV voltage offset to apply to a raw ADC (ie to
>> +  compensate for a diode drop)
>> +
>> +Example:
>> +
>> +     gsc: gsc@20 {
>> +             compatible = "gw,gsc";
>> +             reg = <0x20>;
>> +             interrupt-parent = <&gpio1>;
>> +             interrupts = <4 GPIO_ACTIVE_LOW>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <1>;
>> +
>> +             watchdog {
>> +                     compatible = "gw,gsc-watchdog";
>> +             };
>> +
>> +             hwmon {
>> +                     compatible = "gw,gsc-hwmon";
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +                     gw,reference-voltage = <2500>;
>> +                     gw,resolution = <4096>;
>> +
>> +                     hwmon@0 { /* A0: Board Temperature */
>> +                             type = "gw,hwmon-temperature";
>> +                             reg = <0x00>;
>> +                             label = "temp";
>> +                     };
>> +
>> +                     hwmon@2 { /* A1: Input Voltage (raw ADC) */
>> +                             type = "gw,hwmon-voltage-raw";
>> +                             reg = <0x02>;
>> +                             label = "vdd_vin";
>> +                             gw,voltage-divider = <22100 1000>;
>> +                             gw,voltage-offset = <800>;
>> +                     };
>> +
>> +                     hwmon@b { /* A2: Battery voltage */
>> +                             type = "gw,hwmon-voltage";
>> +                             reg = <0x0b>;
>> +                             label = "vdd_bat";
>> +                     };
>> +
>> +                     hwmon@2c { /* fan temperature setpoint for 50% duty */
>> +                             type = "gw,hwmon-fan";
>> +                             reg = <0x2c>;
>> +                             label = "fan_50p";
>> +                     };
>> +
>> +                     hwmon@2e { /* fan1 */
>> +                             type = "gw,hwmon-fan";
>> +                             reg = <0x2e>;
>> +                             label = "fan_60p";
>> +                     };
>> +
>> +                     hwmon@30 { /* fan2 */
>> +                             type = "gw,hwmon-fan";
>> +                             reg = <0x30>;
>> +                             label = "fan_70p";
>> +                     };
>> +
>> +                     hwmon@32 { /* fan3 */
>> +                             type = "gw,hwmon-fan";
>> +                             reg = <0x32>;
>> +                             label = "fan_80p";
>> +                     };
>> +
>> +                     hwmon@34 { /* fan4 */
>> +                             type = "gw,hwmon-fan";
>> +                             reg = <0x34>;
>> +                             label = "fan_90p";
>> +                     };
>> +
>> +                     hwmon@36 { /* fan5 */
>> +                             type = "gw,hwmon-fan";
>> +                             reg = <0x36>;
>> +                             label = "fan_100p";
>> +                     };
>
> No idea what this is supposed to be doing, but whatever it is,
> it appears to be wrong. I'll comment more on it in the hwmon driver.
>

ok - I'll respond to that thread.

Thanks for the review!

Tim
