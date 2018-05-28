Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934930AbeE1WOW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 18:14:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33854 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbeE1WOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 18:14:17 -0400
X-Google-Smtp-Source: ADUXVKLEsLVzUl29eqE+z5Hli+0rVbhH6hDgQhD8j47pqTHWIr1AehjobLzMb1iO9wumbqwJae7r89ubpUfdoHDuAZo=
MIME-Version: 1.0
In-Reply-To: <ff3992c7-1d59-1fec-1393-47e2d278d8c9@redhat.com>
References: <1527521165-29345-1-git-send-email-geert+renesas@glider.be> <ff3992c7-1d59-1fec-1393-47e2d278d8c9@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 May 2018 00:14:15 +0200
X-Google-Sender-Auth: q1r8t6OgvDWQXOe78doBeLcpdE4
Message-ID: <CAMuHMdVUZJeySfjd=cpjBDu8s2B-hwcZ3Rk4-0m1iOSzrhtYiw@mail.gmail.com>
Subject: Re: [PATCH v3] vfio: platform: Fix using devices in PM Domains
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, May 28, 2018 at 10:27 PM, Auger Eric <eric.auger@redhat.com> wrote:
> On 05/28/2018 05:26 PM, Geert Uytterhoeven wrote:
>> If a device is part of a PM Domain (e.g. power and/or clock domain), its
>> power state is managed using Runtime PM.  Without Runtime PM, the device
>> may not be powered up or clocked, causing subtle failures, crashes, or
>> system lock-ups when the device is accessed by the guest.
>>
>> Fix this by adding Runtime PM support, powering the device when the VFIO
>> device is opened by the guest.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>> v3:
>>   - Drop controversial note about unsafeness of exporting fine-grained
>>     power management from host to guest,
> thanks ;-)
>
>>
>> v2:
>>   - Improve wording,
>>   - Add Reviewed-by.
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index b60bb5326668498c..41f862f055054543 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/iommu.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  #include <linux/uaccess.h>
>> @@ -233,6 +234,8 @@ static void vfio_platform_release(void *device_data)
>>               const char *extra_dbg = NULL;
>>               int ret;
>>
>> +             pm_runtime_put(vdev->device);
>
>> +
>>               ret = vfio_platform_call_reset(vdev, &extra_dbg);
> While reading the code again, the reset is using the HW. Don't you want
> to call the get() before.

Thanks, you're right, it's safer to do the reset here first...

>>               if (ret && vdev->reset_required) {
>>                       dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
>> @@ -275,6 +278,10 @@ static int vfio_platform_open(void *device_data)
>>                                ret, extra_dbg ? extra_dbg : "");
>>                       goto err_rst;
>>               }
>> +
>> +             ret = pm_runtime_get_sync(vdev->device);

... and to do the reset here last.

Will fix and send v4.

>> +             if (ret < 0)
>> +                     goto err_rst;
>>       }
>>
>>       vdev->refcnt++;
>> @@ -690,6 +697,7 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>
>>       mutex_init(&vdev->igate);
>>
>> +     pm_runtime_enable(vdev->device);
>>       return 0;
>>
>>  put_iommu:
>> @@ -707,6 +715,7 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
>>       vdev = vfio_del_group_dev(dev);
>>
>>       if (vdev) {
>> +             pm_runtime_disable(vdev->device);
>>               vfio_platform_put_reset(vdev);
>>               vfio_iommu_group_put(dev->iommu_group, dev);
>>       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
