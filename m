Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeDLLcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:32:52 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39961 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeDLLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:32:49 -0400
X-Google-Smtp-Source: AIpwx4/w6H+m9KogyE+O6X+6gH0bR7/SWUpQyK/KwGSEpmAbKQi+BgrIAPpWijlYpIesWCW09jBSgpdNLxrouSJdrTM=
MIME-Version: 1.0
In-Reply-To: <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be> <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Apr 2018 13:32:48 +0200
X-Google-Sender-Auth: 4-OnAPfGfXosih6mLZ3Pjo8MD_M
Message-ID: <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Eric,

On Thu, Apr 12, 2018 at 12:31 PM, Auger Eric <eric.auger@redhat.com> wrote:
> On 11/04/18 11:15, Geert Uytterhoeven wrote:
>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>> platforms, by a device-specific reset driver matching against the
>> device's compatible value.
>>
>> On many SoCs, devices are connected to an SoC-internal reset controller.
>> If the reset hierarchy is described in DT using "resets" properties,
>> such devices can be reset in a generic way through the reset controller
>> subsystem.  Hence add support for this, avoiding the need to write
>> device-specific reset drivers for each single device on affected SoCs.
>>
>> Devices that do require a more complex reset procedure can still provide
>> a device-specific reset driver, as that takes precedence.
>>
>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>> becomes a no-op (as in: "No reset function found for device") if reset
>> controller support is disabled.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c

>> @@ -127,8 +130,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>                                                       &vdev->reset_module);
>>       }
>> +     if (vdev->of_reset)
>> +             return 0;
>> +
>> +     rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>
> Shouldn't we prefer the top level reset_control_get_exclusive()?

I guess that should work, too.

> To make sure about the exclusive/shared terminology, does
> get_reset_control_get_exclusive() check we have an exclusive wire
> between this device and the reset controller?

AFAIU, the "exclusive" means that only a single user can obtain access to
the reset, and it does not guarantee that we have an exclusive wire between
the device and the reset controller.

The latter depends on the SoC's reset topology. If a reset wire is shared
by multiple devices (e.g. resets shared by PWM or Display Unit devices on
R-Car SoCs), exporting a subset of these devices to a guest is a bad idea,
indeed.

I guess the same thing can happen with the ACPI "_RST" method?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
