Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeDLNMm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:12:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38439 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeDLNMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:12:40 -0400
X-Google-Smtp-Source: AIpwx48Qh9yZD4v4demL3YChPH88yUY8gWe+i9D/wLEbbnbdZAsBL6+iiqz3aSzEMPdbOoja2S7qZIctaJW8SMDd+0M=
MIME-Version: 1.0
In-Reply-To: <e06c459f-51bd-74d1-7a43-bf54231d08ba@codeaurora.org>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
 <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com> <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
 <2e09425d-0f27-3069-3421-e454ee70e3b2@redhat.com> <e06c459f-51bd-74d1-7a43-bf54231d08ba@codeaurora.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Apr 2018 15:12:38 +0200
X-Google-Sender-Auth: LhI8gTR9DiRt0d5Q5W1cqYZHN_Y
Message-ID: <CAMuHMdXhFwhhZqa79F7_90VKhiegumizmswSsgDc9K+HP12wFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Auger Eric <eric.auger@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinan,

On Thu, Apr 12, 2018 at 2:36 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/12/2018 7:49 AM, Auger Eric wrote:
>> On 12/04/18 13:32, Geert Uytterhoeven wrote:
>>> On Thu, Apr 12, 2018 at 12:31 PM, Auger Eric <eric.auger@redhat.com> wrote:
>>>> On 11/04/18 11:15, Geert Uytterhoeven wrote:
>>>>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>>>>> platforms, by a device-specific reset driver matching against the
>>>>> device's compatible value.
>>>>>
>>>>> On many SoCs, devices are connected to an SoC-internal reset controller.
>>>>> If the reset hierarchy is described in DT using "resets" properties,
>>>>> such devices can be reset in a generic way through the reset controller
>>>>> subsystem.  Hence add support for this, avoiding the need to write
>>>>> device-specific reset drivers for each single device on affected SoCs.
>>>>>
>>>>> Devices that do require a more complex reset procedure can still provide
>>>>> a device-specific reset driver, as that takes precedence.
>>>>>
>>>>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>>>>> becomes a no-op (as in: "No reset function found for device") if reset
>>>>> controller support is disabled.
>>>>>
>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>>>
>>>>> --- a/drivers/vfio/platform/vfio_platform_common.c
>>>>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>>>
>>>>> @@ -127,8 +130,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>>>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>>>>                                                       &vdev->reset_module);
>>>>>       }
>>>>> +     if (vdev->of_reset)
>>>>> +             return 0;
>>>>> +
>>>>> +     rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>>>>
>>>> Shouldn't we prefer the top level reset_control_get_exclusive()?
>>>
>>> I guess that should work, too.
>>>
>>>> To make sure about the exclusive/shared terminology, does
>>>> get_reset_control_get_exclusive() check we have an exclusive wire
>>>> between this device and the reset controller?
>>>
>>> AFAIU, the "exclusive" means that only a single user can obtain access to
>>> the reset, and it does not guarantee that we have an exclusive wire between
>>> the device and the reset controller.
>>>
>>> The latter depends on the SoC's reset topology. If a reset wire is shared
>>> by multiple devices (e.g. resets shared by PWM or Display Unit devices on
>>> R-Car SoCs), exporting a subset of these devices to a guest is a bad idea,
>>> indeed.
>>
>> So who's going to check this assigned device will not trigger a reset of
>> other non assigned devices sharing the same reset controller?
>
> I like the direction in general. I was hoping that you'd call it of_reset_control
> rather than reset_control.

You mean vfio_platform_device.of_reset_control?
If we switch to reset_control_get_exclusive(), that doesn't make much sense...

> Is there anything in the OF spec about what to expect from DT's reset?

Documentation/devicetree/bindings/reset/reset.txt says:

"A word on where to place reset signal consumers in device tree: It is possible
 in hardware for a reset signal to affect multiple logically separate HW blocks
 at once. In this case, it would be unwise to represent this reset signal in
 the DT node of each affected HW block, since if activated, an unrelated block
 may be reset. Instead, reset signals should be represented in the DT node
 where it makes most sense to control it; this may be a bus node if all
 children of the bus are affected by the reset signal, or an individual HW
 block node for dedicated reset signals. The intent of this binding is to give
 appropriate software access to the reset signals in order to manage the HW,
 rather than to slavishly enumerate the reset signal that affects each HW
 block."

So according to the bindings, a specific reset should apply to a single
device only.

A quick check shows there are several violators:

$ for i in $(git grep -lw resets -- "*dts*"); do grep -w resets $i |
sort | uniq -c | sed -e "s@^@$i:@g"; done | grep -v ":      1 "
arch/arm/boot/dts/aspeed-g4.dtsi:     14 resets = <&syscon ASPEED_RESET_I2C>;
arch/arm/boot/dts/aspeed-g5.dtsi:     14 resets = <&syscon ASPEED_RESET_I2C>;
arch/arm/boot/dts/atlas7.dtsi:      2 resets = <&car 29>;
arch/arm/boot/dts/gemini.dtsi:      2 resets = <&syscon GEMINI_RESET_IDE>;
arch/arm/boot/dts/meson8.dtsi:      2 resets = <&reset RESET_USB_OTG>;
arch/arm/boot/dts/meson8b.dtsi:      2 resets = <&reset RESET_USB_OTG>;
arch/arm/boot/dts/r8a7743.dtsi:      7 resets = <&cpg 523>;
arch/arm/boot/dts/r8a7743.dtsi:      2 resets = <&cpg 703>;
arch/arm/boot/dts/r8a7743.dtsi:      2 resets = <&cpg 704>;
arch/arm/boot/dts/r8a7745.dtsi:      7 resets = <&cpg 523>;
arch/arm/boot/dts/r8a7745.dtsi:      2 resets = <&cpg 703>;
arch/arm/boot/dts/r8a7745.dtsi:      2 resets = <&cpg 704>;
arch/arm/boot/dts/r8a7790.dtsi:      3 resets = <&cpg 703>;
arch/arm/boot/dts/r8a7790.dtsi:      2 resets = <&cpg 704>;
arch/arm/boot/dts/r8a7791.dtsi:      2 resets = <&cpg 703>;
arch/arm/boot/dts/r8a7791.dtsi:      2 resets = <&cpg 704>;
arch/arm/boot/dts/r8a7794.dtsi:      2 resets = <&cpg 703>;
arch/arm/boot/dts/r8a7794.dtsi:      2 resets = <&cpg 704>;
arch/arm/boot/dts/stih410.dtsi:      2 resets = <&powerdown
STIH407_USB2_PORT0_POWERDOWN>,
arch/arm/boot/dts/stih410.dtsi:      2 resets = <&powerdown
STIH407_USB2_PORT1_POWERDOWN>,
arch/arm/boot/dts/stih410.dtsi:      2 resets = <&softreset
STIH407_PICOPHY_SOFTRESET>,
arch/arm/boot/dts/stih418.dtsi:      2 resets = <&powerdown
STIH407_USB2_PORT0_POWERDOWN>,
arch/arm/boot/dts/stih418.dtsi:      2 resets = <&powerdown
STIH407_USB2_PORT1_POWERDOWN>,
arch/arm/boot/dts/stih418.dtsi:      2 resets = <&softreset
STIH407_PICOPHY_SOFTRESET>,
arch/arm/boot/dts/sun9i-a80.dtsi:      2 resets = <&de_clocks RST_FE0>;
arch/arm/boot/dts/sun9i-a80.dtsi:      2 resets = <&usb_clocks RST_USB0_HCI>;
arch/arm/boot/dts/sun9i-a80.dtsi:      2 resets = <&usb_clocks RST_USB2_HCI>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi:      2 resets = <&ccu
RST_BUS_EHCI0>, <&ccu RST_BUS_OHCI0>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi:      2 resets = <&ccu
RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi:      2 resets = <&ccu
RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;
arch/arm/boot/dts/sunxi-h3-h5.dtsi:      2 resets = <&ccu
RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;
arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:      2 resets = <&reset
RESET_USB_OTG>;
arch/arm64/boot/dts/nvidia/tegra186.dtsi:      2 resets = <&bpmp
TEGRA186_RESET_DSI>;
arch/arm64/boot/dts/renesas/r8a7795.dtsi:      3 resets = <&cpg 328>;
arch/arm64/boot/dts/renesas/r8a7795.dtsi:      7 resets = <&cpg 523>;
arch/arm64/boot/dts/renesas/r8a7795.dtsi:      3 resets = <&cpg 700>;
arch/arm64/boot/dts/renesas/r8a7795.dtsi:      3 resets = <&cpg 701>;
arch/arm64/boot/dts/renesas/r8a7795.dtsi:      3 resets = <&cpg 702>;
arch/arm64/boot/dts/renesas/r8a7795.dtsi:      3 resets = <&cpg 703>;
arch/arm64/boot/dts/renesas/r8a7796.dtsi:      3 resets = <&cpg 328>;
arch/arm64/boot/dts/renesas/r8a7796.dtsi:      7 resets = <&cpg 523>;
arch/arm64/boot/dts/renesas/r8a7796.dtsi:      3 resets = <&cpg 702>;
arch/arm64/boot/dts/renesas/r8a7796.dtsi:      3 resets = <&cpg 703>;
arch/arm64/boot/dts/renesas/r8a77965.dtsi:      3 resets = <&cpg 328>;
arch/arm64/boot/dts/renesas/r8a77965.dtsi:      7 resets = <&cpg 523>;
arch/arm64/boot/dts/renesas/r8a77965.dtsi:      2 resets = <&cpg 702>;
arch/arm64/boot/dts/renesas/r8a77965.dtsi:      4 resets = <&cpg 703>;
arch/arm64/boot/dts/renesas/r8a77995.dtsi:      4 resets = <&cpg 523>;
arch/arm64/boot/dts/renesas/r8a77995.dtsi:      3 resets = <&cpg 703>;
$

Perhaps we should start grouping devices sharing a reset signal in a
"simple-bus" node?

Phillip: any comments?

> ACPI spec is clear. We are doing a device specific reset aka function level
> reset here. It does not impact other devices in the system.

Assumed all ACPI implementations comply, of course.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
