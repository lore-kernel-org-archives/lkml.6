Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDLLtP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:49:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751832AbeDLLtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:49:10 -0400
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
 <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com>
 <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kaya Sinan <okaya@codeaurora.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2e09425d-0f27-3069-3421-e454ee70e3b2@redhat.com>
Date: Thu, 12 Apr 2018 13:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,
On 12/04/18 13:32, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Thu, Apr 12, 2018 at 12:31 PM, Auger Eric <eric.auger@redhat.com> wrote:
>> On 11/04/18 11:15, Geert Uytterhoeven wrote:
>>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>>> platforms, by a device-specific reset driver matching against the
>>> device's compatible value.
>>>
>>> On many SoCs, devices are connected to an SoC-internal reset controller.
>>> If the reset hierarchy is described in DT using "resets" properties,
>>> such devices can be reset in a generic way through the reset controller
>>> subsystem.  Hence add support for this, avoiding the need to write
>>> device-specific reset drivers for each single device on affected SoCs.
>>>
>>> Devices that do require a more complex reset procedure can still provide
>>> a device-specific reset driver, as that takes precedence.
>>>
>>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>>> becomes a no-op (as in: "No reset function found for device") if reset
>>> controller support is disabled.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
>>> --- a/drivers/vfio/platform/vfio_platform_common.c
>>> +++ b/drivers/vfio/platform/vfio_platform_common.c
> 
>>> @@ -127,8 +130,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>>                                                       &vdev->reset_module);
>>>       }
>>> +     if (vdev->of_reset)
>>> +             return 0;
>>> +
>>> +     rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>>
>> Shouldn't we prefer the top level reset_control_get_exclusive()?
> 
> I guess that should work, too.
> 
>> To make sure about the exclusive/shared terminology, does
>> get_reset_control_get_exclusive() check we have an exclusive wire
>> between this device and the reset controller?
> 
> AFAIU, the "exclusive" means that only a single user can obtain access to
> the reset, and it does not guarantee that we have an exclusive wire between
> the device and the reset controller.
> 
> The latter depends on the SoC's reset topology. If a reset wire is shared
> by multiple devices (e.g. resets shared by PWM or Display Unit devices on
> R-Car SoCs), exporting a subset of these devices to a guest is a bad idea,
> indeed.

So who's going to check this assigned device will not trigger a reset of
other non assigned devices sharing the same reset controller?

> 
> I guess the same thing can happen with the ACPI "_RST" method?

ACPI spec _RST chapter says about _RST object:

"This object executes a reset on the associated device
 or devices. If included in a device context, the
reset must not affect any other ACPI-described de
vices; if included in a power resource for reset
(_PRR, Section 7.3.26) the reset must affect all ACPI-described devices
that reference it. When this object is described in
a device context, it executes a function level reset that only affects
the device it is associated with; neither parent nor children should be
affected by the execution of this reset. Executing this must only result
in this device resetting without the device appearing as if it
has been removed from the bus altogether, to prevent OSPM re-enumeration
of devices on hot-pluggable buses (e.g. USB)."

Adding Sinan in copy for clarification.

Thanks

Eric
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
