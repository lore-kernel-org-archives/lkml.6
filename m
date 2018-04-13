Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeDML4Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:56:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38722 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754020AbeDML4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:56:21 -0400
X-Google-Smtp-Source: AIpwx4/xIYMq+54RcfKDlA9gsDF8HHt/6V65NtTY8WIqa0WTHRA59AI+412iIZslQ9uavEKm1Mp6GgGRvm4QYyX0zY4=
MIME-Version: 1.0
In-Reply-To: <1523611347.3396.3.camel@pengutronix.de>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
 <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com> <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
 <2e09425d-0f27-3069-3421-e454ee70e3b2@redhat.com> <e06c459f-51bd-74d1-7a43-bf54231d08ba@codeaurora.org>
 <CAMuHMdXhFwhhZqa79F7_90VKhiegumizmswSsgDc9K+HP12wFA@mail.gmail.com>
 <1523542206.3689.10.camel@pengutronix.de> <CAMuHMdV+x9B1YVDiGkaeeG6tXV_nyzmJ3U=GkBAyhVuWPfdzFw@mail.gmail.com>
 <1523611347.3396.3.camel@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Apr 2018 13:56:19 +0200
X-Google-Sender-Auth: WRFbfmhNA00soslDTdAyT2iVDAU
Message-ID: <CAMuHMdXXreMTWQXUkHuL1M342kt3qTvM_1Hq6_zHWFBfofi9rg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sinan Kaya <okaya@codeaurora.org>, Auger Eric <eric.auger@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

On Fri, Apr 13, 2018 at 11:22 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Thu, 2018-04-12 at 18:02 +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 12, 2018 at 4:10 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> > On Thu, 2018-04-12 at 15:12 +0200, Geert Uytterhoeven wrote:
>> > > On Thu, Apr 12, 2018 at 2:36 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> > > > On 4/12/2018 7:49 AM, Auger Eric wrote:
>> > > > > On 12/04/18 13:32, Geert Uytterhoeven wrote:
>> > > > > > On Thu, Apr 12, 2018 at 12:31 PM, Auger Eric <eric.auger@redhat.com> wrote:
>> > > > > > > On 11/04/18 11:15, Geert Uytterhoeven wrote:
>> > > > > > > > Vfio-platform requires reset support, provided either by ACPI, or, on DT
>> > > > > > > > platforms, by a device-specific reset driver matching against the
>> > > > > > > > device's compatible value.
>> > > > > > > >
>> > > > > > > > On many SoCs, devices are connected to an SoC-internal reset controller.
>> > > > > > > > If the reset hierarchy is described in DT using "resets" properties,
>> > > > > > > > such devices can be reset in a generic way through the reset controller
>> > > > > > > > subsystem.  Hence add support for this, avoiding the need to write
>> > > > > > > > device-specific reset drivers for each single device on affected SoCs.
>> > > > > > > >
>> > > > > > > > Devices that do require a more complex reset procedure can still provide
>> > > > > > > > a device-specific reset driver, as that takes precedence.
>> > > > > > > >
>> > > > > > > > Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>> > > > > > > > becomes a no-op (as in: "No reset function found for device") if reset
>> > > > > > > > controller support is disabled.
>> > > > > > > >
>> > > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > > > > > > > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>> > > > > > > > --- a/drivers/vfio/platform/vfio_platform_common.c
>> > > > > > > > +++ b/drivers/vfio/platform/vfio_platform_common.c
>> > > > > > > > @@ -127,8 +130,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>> > > > > > > >               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>> > > > > > > >                                                       &vdev->reset_module);
>> > > > > > > >       }
>> > > > > > > > +     if (vdev->of_reset)
>> > > > > > > > +             return 0;
>> > > > > > > > +
>> > > > > > > > +     rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>> > > > > > >
>> > > > > > > Shouldn't we prefer the top level reset_control_get_exclusive()?
>> > > > > >
>> > > > > > I guess that should work, too.
>> > > > > >
>> > > > > > > To make sure about the exclusive/shared terminology, does
>> > > > > > > get_reset_control_get_exclusive() check we have an exclusive wire
>> > > > > > > between this device and the reset controller?
>> > > > > >
>> > > > > > AFAIU, the "exclusive" means that only a single user can obtain access to
>> > > > > > the reset, and it does not guarantee that we have an exclusive wire between
>> > > > > > the device and the reset controller.
>> > > > > >
>> > > > > > The latter depends on the SoC's reset topology. If a reset wire is shared
>> > > > > > by multiple devices (e.g. resets shared by PWM or Display Unit devices on
>> > > > > > R-Car SoCs), exporting a subset of these devices to a guest is a bad idea,
>> > > > > > indeed.
>> > > > >
>> > > > > So who's going to check this assigned device will not trigger a reset of
>> > > > > other non assigned devices sharing the same reset controller?
>> >
>> > If the reset control is requested as exclusive, any other driver
>> > requesting the same reset control will fail (or this reset_control_get
>> > will fail, whichever comes last).
>> >
>> > > > I like the direction in general. I was hoping that you'd call it of_reset_control
>> > > > rather than reset_control.
>> > >
>> > > You mean vfio_platform_device.of_reset_control?
>> > > If we switch to reset_control_get_exclusive(), that doesn't make much sense...
>> > >
>> > > > Is there anything in the OF spec about what to expect from DT's reset?
>> > >
>> > > Documentation/devicetree/bindings/reset/reset.txt says:
>> > >
>> > > "A word on where to place reset signal consumers in device tree: It is possible
>> > >  in hardware for a reset signal to affect multiple logically separate HW blocks
>> > >  at once. In this case, it would be unwise to represent this reset signal in
>> > >  the DT node of each affected HW block, since if activated, an unrelated block
>> > >  may be reset. Instead, reset signals should be represented in the DT node
>> > >  where it makes most sense to control it; this may be a bus node if all
>> > >  children of the bus are affected by the reset signal, or an individual HW
>> > >  block node for dedicated reset signals. The intent of this binding is to give
>> > >  appropriate software access to the reset signals in order to manage the HW,
>> > >  rather than to slavishly enumerate the reset signal that affects each HW
>> > >  block."
>> >
>> > This was written in 2012, and unfortunately the DT binding documentation
>> > does not inform hardware development, and has not been updated since.
>> >
>> > There's generally two kinds of reset uses:
>> > - either to bring a device into a known state at a given point in time,
>> >   which is often done using a timed assert/deassert sequence,
>> > - or just to park a device while not in active use (must deassert any
>> >   time before use, may or may not assert any time after use)
>> >
>> > For the former case, the above paragraph makes a lot of sense, because
>> > when it is necessary to reset a device that shares the reset line with
>> > another, either choice between disturbing the other device, or not
>> > being able to reset when necessary, is a bad one. The reset controller
>> > framework supports those use cases via the reset_control_get_exclusive
>> > function variants.
>> >
>> > But for the latter case, there is absolutely no need to forbid sharing
>> > reset lines among multiple devices, as deassertion/assertion can just be
>> > handled reference counted, like clocks or power management. The reset
>> > controller framework supports those use cases via the
>> > reset_control_get_shared function variants.
>> >
>> > The case we are talking about here is the first one.
>>
>> Except that vfio-platform wants to reset the device before and after its
>> use by the guest, for isolation reasons, which does cause a major
>> disturbance in case of a shared reset.
>
> Right. So suddenly we are making devices / drivers that usually would
> fall into the latter case add a requirement from the first case.
>
> That also means it is impossible to use just one of the devices that
> share a reset line for vfio individually, while the other ones are still
> in use by the host. Currently the reset line is a shared resource
> similar to the iommu for devices in the same iommu_group.

Correct.

> [...]
>> > For some of those it may be possible, but that is basically just a work-
>> > around for reality not matching expectations. There may be other cases
>> > where devices sharing a reset line are not even in the same parent node
>> > because they are controlled via a different bus. In general, I don't
>> > think it is feasible or desirable to force grouping of devices that
>> > share the same reset line into a common parent node.
>>
>> At least for Renesas R-Car SoCs, I think this is feasible, as all affected
>> devices are currently grouped under the same /soc node.
>> I added subnodes for all devices sharing resets (one for pwm, 4 for USB2,
>> and one for USB3; display doesn't have resets yet), and it still boots ;-)
>
> Is this grouping enough to make sure all of the pwm/usb2/usb3 devices
> are only ever configured for vfio use together?

Currently exporting to a guest using vfio-platform is done on a per-device
basis.

VFIO has to be taught to consider the parent reset, and export them as
a group.

> Assuming I have pwm[1-4] all sharing the same reset line, and I want
> pwm2 to be used by a vfio guest, I first have to make sure that all of
> pwm[1-4] are unbound, releasing their shared resets, before vfio-
> platform can request the same reset line as exclusive.

Right.

> Thinking about it, if the pwm drivers keep their requested reset control
> around for the duration the device is bound, the reset controller
> framework should already kind of handle this - while any of the shared
> reset control handles is kept around, any exclusive request for the same
> reset control will fail with -EBUSY (and the other way around).
> But that requires all drivers to request the reset control during probe
> and release it during remove.

All of that assumes the pwm driver uses resets, which it currently doesn't.

Note that pwm is a bad example, as you probably want to use
para-virtualization instead of vfio-platform.

>> However, ehci_platform_probe() cannot get its (optional) resets anymore.
>> Probably the reset controller framework needs to be taught to look for
>> shared resets in the parent node, too?
>
> Hm, a generic framework shouldn't do such a thing, the parent node could
> be covered by a completely different binding.

True. So grouping is not an option?
Else every single driver needs to be aware of it, and start looking for
parent resets if the device resets cannot be found?

>> > My suggestion would be to relax the language in the reset.txt DT
>> > bindings doc.
>>
>> Which is fine to keep the status quo with the hardware designers, but makes
>> it less likely for non-whitelisted generic reset controller support to
>> become acceptable for the vfio people...
>
> I still may be missing context, but I fail to see how
>
>         pwm@0 {
>                 resets = <&shared_reset_control>;
>         };
>
>         pwm@1 {
>                 resets = <&shared_reset_control>;
>         };
>
> ->
>
>         pwms {
>                 resets = <&shared_reset_control>;
>
>                 pwm@0 {
>                 };
>
>                 pwm@1 {
>                 };
>         };
>
> makes any difference here, unless pwms gets bound to an actual driver
> that is used for vfio?

I just suggested the grouping to comply with the current DT reset bindings,
i.e. to avoid adding the same resets property to multiple nodes.

Doing so has the side effect that even after my patch, a single pwm device
can still not be exported to a guest, as it doesn't have a resets property
anymore.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
