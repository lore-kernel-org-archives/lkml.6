Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC038C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6DE20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6DE20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbeKTGZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:25:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64763 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeKTGZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:25:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 148DC309706C;
        Mon, 19 Nov 2018 20:00:16 +0000 (UTC)
Received: from [10.36.116.185] (ovpn-116-185.ams2.redhat.com [10.36.116.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA89B105706A;
        Mon, 19 Nov 2018 20:00:04 +0000 (UTC)
Subject: Re: [PATCH v5] vfio: platform: Add generic reset controller support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        KVM list <kvm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181113131508.18246-1-geert+renesas@glider.be>
 <12064722-6e85-c40c-12c9-7c7d4e1e2677@redhat.com>
 <CAMuHMdV8UXPVMcQx17rwVrnQ8XnE6jhproTwO4SY=WnPT+2Hyg@mail.gmail.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <85923f50-df2b-3946-7d76-692d6e143276@redhat.com>
Date:   Mon, 19 Nov 2018 21:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV8UXPVMcQx17rwVrnQ8XnE6jhproTwO4SY=WnPT+2Hyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 19 Nov 2018 20:00:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,
On 11/19/18 8:24 PM, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Mon, Nov 19, 2018 at 11:52 AM Auger Eric <eric.auger@redhat.com> wrote:
>> On 11/13/18 2:15 PM, Geert Uytterhoeven wrote:
>>> Vfio-platform requires dedicated reset support, provided either by ACPI,
>>> or, on DT platforms, by a device-specific reset driver matching against
>>> the device's compatible value.
>>>
>>> On many SoCs, devices are connected to an SoC-internal reset controller.
>>> If the reset hierarchy is described in DT using "resets" properties, or
>>> in lookup tables in platform code, and devices have exactly one
>>> dedicated reset each, such devices can be reset in a generic way through
>>> the reset controller subsystem.  Hence add support for this, avoiding
>>> the need to write device-specific reset drivers for each single device
>>> on affected SoCs.
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
>>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>>> ---
>>> This depends on "[PATCH] reset: Add reset_control_get_count()"
>>> (https://lore.kernel.org/lkml/20181113124744.7769-1-geert+renesas@glider.be/).
>>>
>>> v5:
>>>   - Use reset_control_get_exclusive() instead of rejected
>>>     reset_control_get_dedicated(), as exclusive already implies a
>>>     dedicated reset line,
>>>   - Ensure the device has exactly one reset,
>>>
>>> v4:
>>>   - Add Reviewed-by,
>>>   - Use new RFC reset_control_get_dedicated() instead of
>>>     of_reset_control_get_exclusive(), to (a) make it more generic, and
>>>     (b) make sure the reset returned is really a dedicated reset, and
>>>     does not affect other devices,
>>>
>>> v3:
>>>   - Add Reviewed-by,
>>>   - Merge similar checks in vfio_platform_has_reset(),
>>>
>>> v2:
>>>   - Don't store error values in vdev->reset_control,
>>>   - Use of_reset_control_get_exclusive() instead of
>>>     __of_reset_control_get(),
>>>   - Improve description.
>>> ---
>>>  drivers/vfio/platform/vfio_platform_common.c  | 29 +++++++++++++++++--
>>>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>>>  2 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>>> index c0cd824be2b767be..ce2aad8e0a8159f9 100644
>>> --- a/drivers/vfio/platform/vfio_platform_common.c
>>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/reset.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/types.h>
>>>  #include <linux/uaccess.h>
>>> @@ -113,11 +114,14 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>>>       if (VFIO_PLATFORM_IS_ACPI(vdev))
>>>               return vfio_platform_acpi_has_reset(vdev);
>>>
>>> -     return vdev->of_reset ? true : false;
>>> +     return vdev->of_reset || vdev->reset_control;
>>>  }
>>>
>>>  static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>>  {
>>> +     struct reset_control *rstc;
>>> +     int count;
>>> +
>>>       if (VFIO_PLATFORM_IS_ACPI(vdev))
>>>               return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
>>>
>>> @@ -128,8 +132,24 @@ static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>>>               vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>>>                                                       &vdev->reset_module);
>>>       }
>>> +     if (vdev->of_reset)
>>> +             return 0;
>>> +
>>> +     /* Generic reset handling needs a single, dedicated reset line */
>>> +     count = reset_control_get_count(vdev->device);
>>> +     if (count < 0)
>>> +             return count;
>>> +
>>> +     if (count != 1)
>>> +             return -EINVAL;
>>>
>>> -     return vdev->of_reset ? 0 : -ENOENT;
>>> +     rstc = reset_control_get_exclusive(vdev->device, NULL);
>>
>> So I understand the semantics of reset_control_get_exclusive() is now
>> agreed and this means the reset line is not shared with other devices,
>> correct?
> 
> Yes, it has been clarified that the intended semantics of an exclusive
> reset are that the reset line is not shared with other devices.
> However, currently the reset controller subsystem does not enforce this.
> 
> Given the clarification, this is something to fix in the reset
> controller subsystem, and thus orthogonal to this vfio patch.
> My patch "[PATCH v3] reset: Exclusive resets must be dedicated to a
> single hardware block"
> (https://lore.kernel.org/lkml/20181113133520.20889-1-geert+renesas@glider.be/)
> is meant to fix this.

OK thank you for the clarification. So from a functional point of view I
would consider the above patch is a dependency that needs to be resolved
before getting this upstreamed.
> 
>> A question about the usage of reset_control_get_count(). Why is it an
>> issue if the count is > 1? Does it check there are several reset lines,
>> each of then being used for resetting something different or does it
>> check there are several reset controllers are able to do the reset job?
>> My point behind is what's the issue as long as one non shared line can
>> be grabbed with reset_control_get_exclusive().
> 
> A device may have multiple resets[*].  If this is the case, a specific
> procedure (e.g. reset order) may be needed to reset the device fully.
> Assuming that just asserting the first reset will do the job may lead
> to failure.
> Hence the generic method, which is the target of my patch, should only
> be applied for devices with a single reset.
> Devices that do require a more complex reset procedure can still provide
> a device-specific reset driver, as that takes precedence.
> 
> [*] git grep "\<resets\>.*=.*," -- "*dts*" gives +200 hits.

OK understood, this fully clarifies.
> 
>>> +     if (!IS_ERR(rstc)) {
>>> +             vdev->reset_control = rstc;
>>> +             return 0;
>>> +     }
>>> +
>>> +     return PTR_ERR(rstc);
>>>  }
>>>
>>>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>>> @@ -139,6 +159,8 @@ static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>>>
>>>       if (vdev->of_reset)
>>>               module_put(vdev->reset_module);
>>> +
>>> +     reset_control_put(vdev->reset_control);
>>
>> Most of the drivers use devm_reset_control_get_exclusive(), can't we use
>> that instead and benefit from the fact the reset_control_put() is called
>> automatically on driver detach?
> 
> Yes, we could use devm_reset_control_get_exclusive() instead.
> Given we still need manual release of a device-specific reset_module,
> and a manual call to vfio_iommu_group_put(), it wouldn't simplify the error
> and removal path much, though, and even lead to confusion.
Yep I don't have a strong opinion here, as long as the put is done ;-)

With respect to that patch and as long as "[PATCH v3] reset: Exclusive
resets must be dedicated to a single hardware block" functionality is
enforced,

Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
