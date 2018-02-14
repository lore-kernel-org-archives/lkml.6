Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966944AbeBNJnb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:43:31 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33389 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966503AbeBNJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:43:29 -0500
X-Google-Smtp-Source: AH8x2266MGvF4vRPu3StK+04zZKhaXOGP97u1lvzbZe20+5CKxKPyaPlEtDuOZDYheagD+0+7cJmpjFqkRfvxX3TwYc=
MIME-Version: 1.0
In-Reply-To: <ed556509-1460-3e05-b161-f476090ff480@redhat.com>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-3-git-send-email-geert+renesas@glider.be> <ed556509-1460-3e05-b161-f476090ff480@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 10:43:27 +0100
X-Google-Sender-Auth: sNNLT6WP8qX26fB-V9_KwrJHoOE
Message-ID: <CAMuHMdULCdVCY7k5ZHX66poxRMTJZ3B1KvDrCzBmtkEipC=CMw@mail.gmail.com>
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

On Wed, Feb 14, 2018 at 10:09 AM, Auger Eric <eric.auger@redhat.com> wrote:
> On 13/02/18 17:36, Geert Uytterhoeven wrote:
>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>> platforms, by a device-specific reset driver matching against the
>> device's compatible value.
>>
>> On many SoCs, devices are connected to an SoC-internal reset controller,
>> and can be reset in a generic way.  Hence add support to reset such
>> devices using the reset controller subsystem, provided the reset
>> hierarchy is described correctly in DT using the "resets" property.
>
> I first acknowledge I am not familiar with what those reset controllers
> do in practice. My fear is that we may rely on generic SW pieces that
> may not be adapted to passthrough constraints. We must guarantee that
> any DMA access attempted by the devices are stopped and any interrupts
> gets stopped. Can we guarantee that the reset controller always induce
> that? Otherwise we may leave the door opened to badly reset assigned
> devices.

An on-SoC reset controller is basically a block controlling signals to the
reset inputs of the individual on-SoC devices.
On Renesas ARM SoCs, this allows to do a full reset of the attached device.

Of course the exact semantics depend on the actual SoC.
If e.g. DMA and interrupts are not stopped for a specific device on a
specific SoC, it still needs a device-specific reset driver, matching against
the appropriate compatible value, cfr. the quoted paragraph below.

You could add a whitelist for of_machine_is_compatible() or
of_device_is_compatible(), but that will grow large fast.

>> Devices that require a more complex reset procedure can still
>> provide a device-specific reset driver, as that takes precedence.

>> @@ -138,6 +152,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>>
>>       if (vdev->of_reset)
>>               module_put(vdev->reset_module);
>> +
> if (vdev->reset_control) ?
> reset_control_put seems to only check IS_ERR()

    void reset_control_put(struct reset_control *rstc)
    {
            if (IS_ERR_OR_NULL(rstc))
                    return;

So it does handle NULL.

>> +     reset_control_put(vdev->reset_control);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
