Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967128AbeBNKLd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:11:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750830AbeBNKLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:11:32 -0500
Subject: Re: [PATCH 2/2] vfio: platform: Add generic DT reset support
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-3-git-send-email-geert+renesas@glider.be>
 <ed556509-1460-3e05-b161-f476090ff480@redhat.com>
 <CAMuHMdULCdVCY7k5ZHX66poxRMTJZ3B1KvDrCzBmtkEipC=CMw@mail.gmail.com>
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
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <28255dd8-427f-f81a-1ec4-0837eb4738db@redhat.com>
Date: Wed, 14 Feb 2018 11:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdULCdVCY7k5ZHX66poxRMTJZ3B1KvDrCzBmtkEipC=CMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 14/02/18 10:43, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Wed, Feb 14, 2018 at 10:09 AM, Auger Eric <eric.auger@redhat.com> wrote:
>> On 13/02/18 17:36, Geert Uytterhoeven wrote:
>>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>>> platforms, by a device-specific reset driver matching against the
>>> device's compatible value.
>>>
>>> On many SoCs, devices are connected to an SoC-internal reset controller,
>>> and can be reset in a generic way.  Hence add support to reset such
>>> devices using the reset controller subsystem, provided the reset
>>> hierarchy is described correctly in DT using the "resets" property.
>>
>> I first acknowledge I am not familiar with what those reset controllers
>> do in practice. My fear is that we may rely on generic SW pieces that
>> may not be adapted to passthrough constraints. We must guarantee that
>> any DMA access attempted by the devices are stopped and any interrupts
>> gets stopped. Can we guarantee that the reset controller always induce
>> that? Otherwise we may leave the door opened to badly reset assigned
>> devices.
> 
> An on-SoC reset controller is basically a block controlling signals to the
> reset inputs of the individual on-SoC devices.
> On Renesas ARM SoCs, this allows to do a full reset of the attached device.
> 
> Of course the exact semantics depend on the actual SoC.
that's the issue actually.
> If e.g. DMA and interrupts are not stopped for a specific device on a
> specific SoC, it still needs a device-specific reset driver, matching against
> the appropriate compatible value, cfr. the quoted paragraph below.
yes but by default we still accept the reset controller solution.
> 
> You could add a whitelist for of_machine_is_compatible() or
> of_device_is_compatible(), but that will grow large fast.
Could be the kind of solution needed. At the moment the list of assigned
platform devices is pretty reduced.

Couldn't we imagine additional dt properties to emphasize the fact a
platform device is passthrough friendly in terms of reset, either
through a reset controller or exposing a single reg that need to be
reset for full reset to be achieved, in accordance with assignment
constraints. That way, the driver writer would somehow certify the
device is eligible for passthrough. One of the issue today is that the
vfio platform reset driver is not maintained by the native driver
maintainer.

I think if people want to do platform passthrough, they need to devise
their HW IPs so that this reset modality is simplified by exposing this
kind of single reg and then dt description may expose this. Also if
possible, the dt node must be as simple/generic as possible to avoid
writing a huge dt node creation function on QEMU side and avoid
dependencies on other nodes.


> 
>>> Devices that require a more complex reset procedure can still
>>> provide a device-specific reset driver, as that takes precedence.
> 
>>> @@ -138,6 +152,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>>>
>>>       if (vdev->of_reset)
>>>               module_put(vdev->reset_module);
>>> +
>> if (vdev->reset_control) ?
>> reset_control_put seems to only check IS_ERR()
> 
>     void reset_control_put(struct reset_control *rstc)
>     {
>             if (IS_ERR_OR_NULL(rstc))
>                     return;
> 
> So it does handle NULL.
Sorry I checked an older 4.3 kernel version.

Thanks

Eric
> 
>>> +     reset_control_put(vdev->reset_control);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
