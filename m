Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeDKIjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:39:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36311 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:39:21 -0400
X-Google-Smtp-Source: AIpwx4/Py+cbJHaTzivYC/c9KDos3trGc37BB3uqbKRSNqujKDZQHmF04rTILONeMY4NaLDTWolSO/Jlv7ubtofw2us=
MIME-Version: 1.0
In-Reply-To: <20180411082226.qbhf7hcvtcns7ge3@verge.net.au>
References: <1523375627-23746-1-git-send-email-geert+renesas@glider.be>
 <1523375627-23746-3-git-send-email-geert+renesas@glider.be> <20180411082226.qbhf7hcvtcns7ge3@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Apr 2018 10:39:19 +0200
X-Google-Sender-Auth: RdrfGeboVKN02AOYcXjxRsUFWOE
Message-ID: <CAMuHMdXq5gTrYBGnP8EfL4s_c+=JA6vXgrmgs3Wa_+8cS3jYNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfio: platform: Add generic DT reset controller support
To: Simon Horman <horms@verge.net.au>
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

Hi Simon,

On Wed, Apr 11, 2018 at 10:22 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Apr 10, 2018 at 05:53:47PM +0200, Geert Uytterhoeven wrote:
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
>> ---
>> v2:
>>   - Don't store error values in vdev->reset_control,
>>   - Use of_reset_control_get_exclusive() instead of
>>     __of_reset_control_get(),
>>   - Improve description.

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
>> @@ -112,11 +113,19 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>>       if (VFIO_PLATFORM_IS_ACPI(vdev))
>>               return vfio_platform_acpi_has_reset(vdev);
>>
>> -     return vdev->of_reset ? true : false;
>> +     if (vdev->of_reset)
>> +             return true;
>> +
>> +     if (vdev->reset_control)
>> +             return true;
>> +
>> +     return false;
>
> I wonder if the above would be better expressed as:
>
>         return vdev->of_reset || vdev->reset_control;

Makes sense, now both checks are of the same type.

>> @@ -217,6 +236,9 @@ static int vfio_platform_call_reset(struct vfio_platform_device *vdev,
>>       } else if (vdev->of_reset) {
>>               dev_info(vdev->device, "reset\n");
>>               return vdev->of_reset(vdev);
>> +     } else if (vdev->reset_control) {
>> +             dev_info(vdev->device, "reset\n");
>
> Would it be useful to differentiate between the above two informational
> messages?

Probably not, there's also no differentiation with the message for the
ACPI case above (out of visible context).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
