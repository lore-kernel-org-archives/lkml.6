Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeDMIwP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:52:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752446AbeDMIwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:52:11 -0400
Subject: Re: [PATCH v3 2/2] vfio: platform: Add generic DT reset support
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
 <1523438149-16433-4-git-send-email-geert+renesas@glider.be>
 <e6a70247-14f2-63b6-852b-3d43e45f8fa2@redhat.com>
 <CAMuHMdU5m=vV9nuVoRkX6tX-A=az3aK6HT7yFqgDam_rCNEfSg@mail.gmail.com>
 <2e09425d-0f27-3069-3421-e454ee70e3b2@redhat.com>
 <e06c459f-51bd-74d1-7a43-bf54231d08ba@codeaurora.org>
 <CAMuHMdXhFwhhZqa79F7_90VKhiegumizmswSsgDc9K+HP12wFA@mail.gmail.com>
 <1523542206.3689.10.camel@pengutronix.de>
 <CAMuHMdV+x9B1YVDiGkaeeG6tXV_nyzmJ3U=GkBAyhVuWPfdzFw@mail.gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <afed717f-6a20-8615-c41f-e7d1d76b9e15@redhat.com>
Date: Fri, 13 Apr 2018 10:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV+x9B1YVDiGkaeeG6tXV_nyzmJ3U=GkBAyhVuWPfdzFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert, Philipp,

On 12/04/18 18:02, Geert Uytterhoeven wrote:
> Hi Philipp,
> 
> On Thu, Apr 12, 2018 at 4:10 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> On Thu, 2018-04-12 at 15:12 +0200, Geert Uytterhoeven wrote:
>>> On Thu, Apr 12, 2018 at 2:36 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>> On 4/12/2018 7:49 AM, Auger Eric wrote:
>>>>> On 12/04/18 13:32, Geert Uytterhoeven wrote:
>>>>>> On Thu, Apr 12, 2018 at 12:31 PM, Auger Eric <eric.auger@redhat.com> wrote:
>>>>>>> On 11/04/18 11:15, Geert Uytterhoeven wrote:
>>>>>>>> Vfio-platform requires reset support, provided either by ACPI, or, on DT
>>>>>>>> platforms, by a device-specific reset driver matching against the
>>>>>>>> device's compatible value.
>>>>>>>>
>>>>>>>> On many SoCs, devices are connected to an SoC-internal reset controller.
>>>>>>>> If the reset hierarchy is described in DT using "resets" properties,
>>>>>>>> such devices can be reset in a generic way through the reset controller
>>>>>>>> subsystem.  Hence add support for this, avoiding the need to write
>>>>>>>> device-specific reset drivers for each single device on affected SoCs.
>>>>>>>>
>>>>>>>> Devices that do require a more complex reset procedure can still provide
>>>>>>>> a device-specific reset driver, as that takes precedence.
>>>>>>>>
>>>>>>>> Note that this functionality depends on CONFIG_RESET_CONTROLLER=y, and
>>>>>>>> becomes a no-op (as in: "No reset function found for device") if reset
>>>>>>>> controller support is disabled.
>>>>>>>>
>>>>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>>>>>>>> --- a/drivers/vfio/platform/vfio_platform_common.c
>>>>>>>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>>>>>>>> @@ -127,8 +130,16 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>>>>>>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>>>>>>>                                                       &vdev->reset_module);
>>>>>>>>       }
>>>>>>>> +     if (vdev->of_reset)
>>>>>>>> +             return 0;
>>>>>>>> +
>>>>>>>> +     rstc = of_reset_control_get_exclusive(vdev->device->of_node, NULL);
>>>>>>>
>>>>>>> Shouldn't we prefer the top level reset_control_get_exclusive()?
>>>>>>
>>>>>> I guess that should work, too.
>>>>>>
>>>>>>> To make sure about the exclusive/shared terminology, does
>>>>>>> get_reset_control_get_exclusive() check we have an exclusive wire
>>>>>>> between this device and the reset controller?
>>>>>>
>>>>>> AFAIU, the "exclusive" means that only a single user can obtain access to
>>>>>> the reset, and it does not guarantee that we have an exclusive wire between
>>>>>> the device and the reset controller.
>>>>>>
>>>>>> The latter depends on the SoC's reset topology. If a reset wire is shared
>>>>>> by multiple devices (e.g. resets shared by PWM or Display Unit devices on
>>>>>> R-Car SoCs), exporting a subset of these devices to a guest is a bad idea,
>>>>>> indeed.
>>>>>
>>>>> So who's going to check this assigned device will not trigger a reset of
>>>>> other non assigned devices sharing the same reset controller?
>>
>> If the reset control is requested as exclusive, any other driver
>> requesting the same reset control will fail (or this reset_control_get
>> will fail, whichever comes last).
>>
>>>> I like the direction in general. I was hoping that you'd call it of_reset_control
>>>> rather than reset_control.
>>>
>>> You mean vfio_platform_device.of_reset_control?
>>> If we switch to reset_control_get_exclusive(), that doesn't make much sense...
>>>
>>>> Is there anything in the OF spec about what to expect from DT's reset?
>>>
>>> Documentation/devicetree/bindings/reset/reset.txt says:
>>>
>>> "A word on where to place reset signal consumers in device tree: It is possible
>>>  in hardware for a reset signal to affect multiple logically separate HW blocks
>>>  at once. In this case, it would be unwise to represent this reset signal in
>>>  the DT node of each affected HW block, since if activated, an unrelated block
>>>  may be reset. Instead, reset signals should be represented in the DT node
>>>  where it makes most sense to control it; this may be a bus node if all
>>>  children of the bus are affected by the reset signal, or an individual HW
>>>  block node for dedicated reset signals. The intent of this binding is to give
>>>  appropriate software access to the reset signals in order to manage the HW,
>>>  rather than to slavishly enumerate the reset signal that affects each HW
>>>  block."
>>
>> This was written in 2012, and unfortunately the DT binding documentation
>> does not inform hardware development, and has not been updated since.
>>
>> There's generally two kinds of reset uses:
>> - either to bring a device into a known state at a given point in time,
>>   which is often done using a timed assert/deassert sequence,
>> - or just to park a device while not in active use (must deassert any
>>   time before use, may or may not assert any time after use)
>>
>> For the former case, the above paragraph makes a lot of sense, because
>> when it is necessary to reset a device that shares the reset line with
>> another, either choice between disturbing the other device, or not
>> being able to reset when necessary, is a bad one. The reset controller
>> framework supports those use cases via the reset_control_get_exclusive
>> function variants.
>>
>> But for the latter case, there is absolutely no need to forbid sharing
>> reset lines among multiple devices, as deassertion/assertion can just be
>> handled reference counted, like clocks or power management. The reset
>> controller framework supports those use cases via the
>> reset_control_get_shared function variants.
>>
>> The case we are talking about here is the first one.
> 
> Except that vfio-platform wants to reset the device before and after its
> use by the guest, for isolation reasons, which does cause a major
> disturbance in case of a shared reset.
Do we have any guarantee that drivers whose device are sharing the reset
signal will have got the reset control when the vfio-platform driver
calls reset_control_get_exclusive(). In such a case vfio-platform
reset_control_get_exclusive() will fail and this is what we want.
Otherwise it is unsafe, right. Doesn't this assumption look a little risky?

Thanks

Eric
> 
>>> So according to the bindings, a specific reset should apply to a single
>>> device only.
>>
>> Indeed sharing reset lines between peripherals has become unexpectedly
>> common, making it impractical to forbid shared resets in the device
>> tree.
>>
>>> A quick check shows there are several violators:
> 
> [...]
> 
>>> Perhaps we should start grouping devices sharing a reset signal in a
>>> "simple-bus" node?
>>>
>>> Phillip: any comments?
>>
>> For some of those it may be possible, but that is basically just a work-
>> around for reality not matching expectations. There may be other cases
>> where devices sharing a reset line are not even in the same parent node
>> because they are controlled via a different bus. In general, I don't
>> think it is feasible or desirable to force grouping of devices that
>> share the same reset line into a common parent node.
> 
> At least for Renesas R-Car SoCs, I think this is feasible, as all affected
> devices are currently grouped under the same /soc node.
> I added subnodes for all devices sharing resets (one for pwm, 4 for USB2,
> and one for USB3; display doesn't have resets yet), and it still boots ;-)
> 
> However, ehci_platform_probe() cannot get its (optional) resets anymore.
> Probably the reset controller framework needs to be taught to look for
> shared resets in the parent node, too?
> 
>> My suggestion would be to relax the language in the reset.txt DT
>> bindings doc.
> 
> Which is fine to keep the status quo with the hardware designers, but makes
> it less likely for non-whitelisted generic reset controller support to
> become acceptable for the vfio people...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
