Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966287AbeBUQMR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:12:17 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:46893 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932757AbeBUQMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:12:15 -0500
X-Google-Smtp-Source: AH8x224iftizx23WQsOCJ1W3r3M+OeN/AlhSSWuUgTazEPuPmZ32l0p0ke991Muv+t7hbiCc7SEZCJ/iNOU28E7whlQ=
MIME-Version: 1.0
In-Reply-To: <28255dd8-427f-f81a-1ec4-0837eb4738db@redhat.com>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-3-git-send-email-geert+renesas@glider.be>
 <ed556509-1460-3e05-b161-f476090ff480@redhat.com> <CAMuHMdULCdVCY7k5ZHX66poxRMTJZ3B1KvDrCzBmtkEipC=CMw@mail.gmail.com>
 <28255dd8-427f-f81a-1ec4-0837eb4738db@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 17:12:13 +0100
X-Google-Sender-Auth: NNf00-mIU1Nu9ZkUmcDcpUg5ZJw
Message-ID: <CAMuHMdXaG2Vef4UPKnAYWc27Pd=iK=e+-_R1=1+zTGXcYSg4uQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfio: platform: Add generic DT reset support
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

On Wed, Feb 14, 2018 at 11:11 AM, Auger Eric <eric.auger@redhat.com> wrote:
> On 14/02/18 10:43, Geert Uytterhoeven wrote:
>> On Wed, Feb 14, 2018 at 10:09 AM, Auger Eric <eric.auger@redhat.com> wrote:
>>> On 13/02/18 17:36, Geert Uytterhoeven wrote:
>>>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>>>> platforms, by a device-specific reset driver matching against the
>>>> device's compatible value.
>>>>
>>>> On many SoCs, devices are connected to an SoC-internal reset controller,
>>>> and can be reset in a generic way.  Hence add support to reset such
>>>> devices using the reset controller subsystem, provided the reset
>>>> hierarchy is described correctly in DT using the "resets" property.
>>>
>>> I first acknowledge I am not familiar with what those reset controllers
>>> do in practice. My fear is that we may rely on generic SW pieces that
>>> may not be adapted to passthrough constraints. We must guarantee that
>>> any DMA access attempted by the devices are stopped and any interrupts
>>> gets stopped. Can we guarantee that the reset controller always induce
>>> that? Otherwise we may leave the door opened to badly reset assigned
>>> devices.
>>
>> An on-SoC reset controller is basically a block controlling signals to the
>> reset inputs of the individual on-SoC devices.
>> On Renesas ARM SoCs, this allows to do a full reset of the attached device.
>>
>> Of course the exact semantics depend on the actual SoC.
> that's the issue actually.
>> If e.g. DMA and interrupts are not stopped for a specific device on a
>> specific SoC, it still needs a device-specific reset driver, matching against
>> the appropriate compatible value, cfr. the quoted paragraph below.
> yes but by default we still accept the reset controller solution.
>>
>> You could add a whitelist for of_machine_is_compatible() or
>> of_device_is_compatible(), but that will grow large fast.
> Could be the kind of solution needed. At the moment the list of assigned
> platform devices is pretty reduced.
>
> Couldn't we imagine additional dt properties to emphasize the fact a
> platform device is passthrough friendly in terms of reset, either
> through a reset controller or exposing a single reg that need to be
> reset for full reset to be achieved, in accordance with assignment
> constraints. That way, the driver writer would somehow certify the
> device is eligible for passthrough. One of the issue today is that the
> vfio platform reset driver is not maintained by the native driver
> maintainer.

I'm not so fond of adding more DT properties for this. They can be abused
as well.

In general, if there's a "resets" DT property, it means the device can be
reset through the pointed-by reset controller. So that's the common case,
which I'd like to optimize/simplify for.

If more is needed, a separate (device-specific) vfio_reset handler needs
to be written, by the people that know the hardware.

> I think if people want to do platform passthrough, they need to devise
> their HW IPs so that this reset modality is simplified by exposing this
> kind of single reg and then dt description may expose this. Also if
> possible, the dt node must be as simple/generic as possible to avoid
> writing a huge dt node creation function on QEMU side and avoid
> dependencies on other nodes.

Yes. It all depends on sane hardware ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
