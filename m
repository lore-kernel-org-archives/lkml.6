Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeDKInU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:43:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41011 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:43:16 -0400
X-Google-Smtp-Source: AIpwx4/MxLlCEG14Cqxf2K4T+9hpfM9x90HxPb7shUULiFXDpmVuiaKZ0lySOO6/A+1ZrAT3+7ZrTnEZVUFKm3NOPA0=
MIME-Version: 1.0
In-Reply-To: <1523434945.4739.1.camel@pengutronix.de>
References: <1523375627-23746-1-git-send-email-geert+renesas@glider.be>
 <1523375627-23746-3-git-send-email-geert+renesas@glider.be> <1523434945.4739.1.camel@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Apr 2018 10:43:14 +0200
X-Google-Sender-Auth: EXUqVbbe4b2t9WfzkyOCblbV12k
Message-ID: <CAMuHMdXM2GHxE197BNpTjWx+zq_gAbxWzFO5Mnv9SnRA-L-utw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfio: platform: Add generic DT reset controller support
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

On Wed, Apr 11, 2018 at 10:22 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Tue, 2018-04-10 at 17:53 +0200, Geert Uytterhoeven wrote:
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
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks!

>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
> [...]
>> @@ -127,8 +136,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>                                                       &vdev->reset_module);
>>       }
>> +     if (vdev->of_reset)
>> +             return 0;
>> +
>> +     rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>
> If vdev->device->of_node == NULL, this will return -EINVAL ...
>
>> +     if (!IS_ERR(rstc)) {
>> +             vdev->reset_control = rstc;
>> +             return 0;
>> +     }
>>
>> -     return vdev->of_reset ? 0 : -ENOENT;
>> +     return PTR_ERR(rstc);
>
> ... instead of -ENOENT, if that makes any difference.

Not really. The single caller (vfio_platform_probe_common()) already returns
-EINVAL if no IOMMU group is found, so this should be handled fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
