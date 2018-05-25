Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967402AbeEYR1t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:27:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54606 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967305AbeEYR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:27:48 -0400
X-Google-Smtp-Source: AB8JxZpma7CND0URlNwJI/5o9c9jE7Kn5bm/zSb1NQiTKCxbdz17cp4uRbTaJm1QYGK/shW9RiP99ebO4p6+q5E0/4Y=
MIME-Version: 1.0
In-Reply-To: <4986a636-d5a5-387c-abf1-d68afe063f06@arm.com>
References: <20180517070643.GC13919@kroah.com> <20180518012024.22645-1-kim.phillips@arm.com>
 <20180518012024.22645-6-kim.phillips@arm.com> <4986a636-d5a5-387c-abf1-d68afe063f06@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 25 May 2018 11:27:46 -0600
Message-ID: <CANLsYkzD9Ot1noY7QpTu76fUcGsTu4V8y6Dep9Haffw-0uPM9w@mail.gmail.com>
Subject: Re: [PATCH 6/6] coresight: allow to build as modules
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2018 at 11:12, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 18/05/18 02:20, Kim Phillips wrote:
>>
>> Allow to build coresight as modules.  This greatly enhances developer
>> efficiency by allowing the development to take place exclusively on the
>> target, and without needing to reboot in between changes.
>>
>> - Kconfig bools become tristates, to allow =m
>>
>> - use -objs to denote merge object directives in Makefile, adds a
>>    coresight-core nomenclature for the base module.
>>
>> - Export core functions so as to be able to be used by
>>    non-core modules.
>>
>> - add a coresight_exit() that unregisters the coresight bus, add
>>    remove fns for most others.
>>
>> - fix up modules with ID tables for autoloading on boot
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>
>
> Kim,
>
> I see that you have addressed my comments on a previous version
> of this series posted in April. But I don't see the version number
> increased for this new version. Please add versioning to make it
> easier to make it more obvious.
>
> Also, generally it is a good idea to keep the people who reviewed
> and commented on your previous versions in the newer versions.
>
> Some comments below :
>
>> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> index fc742215ab05..bc42b8022556 100644
>> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
>> @@ -37,7 +37,12 @@ struct replicator_state {
>>   static int replicator_enable(struct coresight_device *csdev, int inport,
>>                               int outport)
>>   {
>> -       struct replicator_state *drvdata =
>> dev_get_drvdata(csdev->dev.parent);
>> +       struct device *parent_dev = csdev->dev.parent;
>> +       struct replicator_state *drvdata = dev_get_drvdata(parent_dev);
>> +       struct module *module = parent_dev->driver->owner;
>> +
>> +       if (!try_module_get(module))
>> +               return -ENODEV;
>>         CS_UNLOCK(drvdata->base);
>
>
> What is the guarantee that the "csdev" is still available when we reach
> here ?
>
> A module could be unloaded "after the component was added to the path"
> (via coresight_build_path) and before we invoke the "enable" on each
> component in the path ?

Very good point - this is invariably racy.

>
> Also, it  is tedious to do module_get in "enable" and module_put in the
> disable call backs for each component.
>
> Instead, if we do a module_get() in build_path and module_put() in
> release path, we could solve all these problems and keep it the module
> refcount in a central place.

Good idea, it does streamline things a lot.

>
>> +MODULE_DEVICE_TABLE(amba, replicator_ids);
>> +
>>   static struct amba_driver replicator_driver = {
>>         .drv = {
>>                 .name   = "coresight-dynamic-replicator",
>> @@ -207,9 +226,10 @@ static struct amba_driver replicator_driver = {
>>                 .suppress_bind_attrs = true,
>>         },
>>         .probe          = replicator_probe,
>> +       .remove         = replicator_remove,
>>         .id_table       = replicator_ids,
>>   };
>
>
> Do we have the owner field set here for this driver ? I see that you
> added it for some components and not others. e.g, you have added it for
> etm4x, while not for replicator and others.
>
>
>> +MODULE_DEVICE_TABLE(amba, etm4_ids);
>> +
>>   static struct amba_driver etm4x_driver = {
>>         .drv = {
>>                 .name   = "coresight-etm4x",
>> +               .owner  = THIS_MODULE,
>>                 .suppress_bind_attrs = true,
>>         },
>>         .probe          = etm4_probe,
>> +       .remove         = etm4_remove,
>>         .id_table       = etm4_ids,
>>   };
>> -builtin_amba_driver(etm4x_driver);
>> +module_amba_driver(etm4x_driver);
>
>
>
> Suzuki
