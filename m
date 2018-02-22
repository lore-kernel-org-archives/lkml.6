Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeBVIuF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:50:05 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44899 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeBVIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:50:03 -0500
X-Google-Smtp-Source: AG47ELt4CEK3SAbwMTStVMyF/MCpY3bPO1Sp7Wn61sBrRsSa4Ex3povpVfG+6uOYMkqFXAFV6qJuWbKeIwm0UvrVZZo=
MIME-Version: 1.0
In-Reply-To: <1519231860.3405.11.camel@pengutronix.de>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-3-git-send-email-geert+renesas@glider.be> <1519231860.3405.11.camel@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 09:50:01 +0100
X-Google-Sender-Auth: SeNVIWJHvdGqONmMJ7kcgQl8r8I
Message-ID: <CAMuHMdXSwsH82U8P3N6jXef72ZP0iiZgzkgEuKhUsqoYmpW93g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfio: platform: Add generic DT reset support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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

Hi Philipp,

On Wed, Feb 21, 2018 at 5:51 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> I have a suggestion to avoid having to use the IS_ERR_OR_NULL macro, see
> below:
>
> On Tue, 2018-02-13 at 17:36 +0100, Geert Uytterhoeven wrote:
>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>> platforms, by a device-specific reset driver matching against the
>> device's compatible value.
>>
>> On many SoCs, devices are connected to an SoC-internal reset controller,
>> and can be reset in a generic way.  Hence add support to reset such
>> devices using the reset controller subsystem, provided the reset
>> hierarchy is described correctly in DT using the "resets" property.
>>
>> Devices that require a more complex reset procedure can still
>> provide a device-specific reset driver, as that takes precedence.
>>
>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>> becomes a no-op if reset controller support is disabled.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c  | 23 +++++++++++++++++++++--
>>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index b60bb5326668498c..5d1e48f96e423508 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/iommu.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/reset.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  #include <linux/uaccess.h>
>> @@ -112,7 +113,13 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>>       if (VFIO_PLATFORM_IS_ACPI(vdev))
>>               return vfio_platform_acpi_has_reset(vdev);
>>
>> -     return vdev->of_reset ? true : false;
>> +     if (vdev->of_reset)
>> +             return true;
>> +
>> +     if (!IS_ERR_OR_NULL(vdev->reset_control))
>> +             return true;
>
> I'd avoid storing error values in vdev->reset_control at all, so this
> could be:
>
>         if (vdev->reset_control)
>                 return true;

Thanks, much better!

>> @@ -127,8 +134,15 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>                                                       &vdev->reset_module);
>>       }
>> +     if (vdev->of_reset)
>> +             return 0;
>> +
>> +     vdev->reset_control = __of_reset_control_get(vdev->device->of_node,
>> +                                                  NULL, 0, false, false);
>> +     if (!IS_ERR(vdev->reset_control))
>> +             return 0;
>
> if you assign to a local variable first here:
>
>         struct reset_control *rstc;
>
>          ...
>
>         rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>         if (!IS_ERR(rstc)) {
>                 vdev->reset_control = rstc;
>                 return 0;
>         }
>
> Also, please don't use __of_reset_control_get directly.

OK, apparently I didn't read <linux/reset.h> beyond the first #else...

>> @@ -217,6 +233,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>>       } else if (vdev->of_reset) {
>>               dev_info(vdev->device, "reset\n");
>>               return vdev->of_reset(vdev);
>> +     } else if (!IS_ERR_OR_NULL(vdev->reset_control)) {
>> +             dev_info(vdev->device, "reset\n");
>> +             return reset_control_reset(vdev->reset_control);
>
>         } else {
>                 if (vdev->reset_control)
>                         dev_info(vdev->device, "reset\n");
>                 return reset_control_reset(vdev->reset_control);
>
>>       }

I'd like to keep the "else if", as that's the pattern used by the blocks above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
