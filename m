Return-Path: <ghammer@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521100831; cv=none;
        d=google.com; s=arc-20160816;
        b=kzDhhZAQDiX9nnrUr3RzHz4J9bdAp2tEs7Lteq7ejMtWwXOxDHnISGGrKTTwR8qjPB
         zdu6Loqk5AB9zmDB7NJCv6eM1FsvywBi8SJcmdnS1y/Woxc7d2GexuOfYFW4mZ/176mx
         BcJFxcVzvDR9GeOB7EaNriTu46q8Nhv/ut2mJpAJ5Dq8WQG6JvbFH7h0xxBzySghMPq1
         Clj+3TdH88KqT/mPW+NuQTOLYy6fpNfarGaVxtCUBWKsgUUZM0xzOMWytmSu6A8oxmim
         ez4Sw8GhE+FU0dDRP9hGyLrs1QPhEBp8Z7FCpskdQX4fqsTYPrsBMzkg/T1R5aV13UZM
         92ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=CODZDGFi5Y5m6Zyy1CNkoQroOLDpKRvR4T9cWePLd34=;
        b=iU6e4tcolt8ErBhL6398HLlHtAS4QBMl+ORD12bFxHW8nVmNuk3UiAi0+NgUrCrHPr
         /UpUR9sGniIjoP7viaimwM3JgJgXnWZ22tpEO4hWr4W2Q0wRaB+0vPOUM+YtSwosbqDF
         zhNosayK71YPSAsaF10l9yo5Mr2IFxw9a9V5t7jfAAOfZIh4f9Z5iTbXzkJWc/eN1EiD
         q4LLmbm5yzHAkmKyEZSJUITV6whG2TC++KZTwwctLx93zPyLa32YmPDV1EigDCJOa9+z
         5FUoOv/H25LXX4bmlj1RTBGHoHptn9bPk/+FHqEgnGFagcE1AG5WEg+sk6VYL9whJRGE
         Mskg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ghammer@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghammer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ghammer@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghammer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELtqPTWyu++LexsCc+Gmoye7C1ZOqbI0QQTrOeZ8LHg9Q+m9hgDrWbZb3npikGQHJIWsikEulzt04DXhBIxZ9P4=
MIME-Version: 1.0
In-Reply-To: <20180313190617-mutt-send-email-mst@kernel.org>
References: <20180301142215.11812-1-idgar@virtualoco.com> <20180313190617-mutt-send-email-mst@kernel.org>
From: Gal Hammer <ghammer@redhat.com>
Date: Thu, 15 Mar 2018 10:00:30 +0200
Message-ID: <CAA2ifQz9ZQPSG-Xx5RmHRaQCveFehXZQL6zaGhZP99s6oYEFaw@mail.gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver implementation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Or Idgar <oidgar@redhat.com>,
	Or Idgar <oridgar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593745507285614890?=
X-GMAIL-MSGID: =?utf-8?q?1594989825581639158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 7:40 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Thanks for the patch! Yet something to improve (see below):

Thanks for the review.

> On Thu, Mar 01, 2018 at 04:22:15PM +0200, Or Idgar wrote:
>> From: Or Idgar <oridgar@gmail.com>
>
> I see addresses at gmail, virtualoco and redhat.com At this point I
> don't really know which address to use to contact you :) All of them?

Use his gmail or virtualoco one.

> Also, I think it's a good idea to CC this more widely. Consider CC-ing
> qemu contributors to the vm gen id (use git log to get the list), Ben
> Warren who wrote a prototype driver a while ago, qemu mailing list,
> maybe more.
>
>>
>> This patch is a driver which expose the Virtual Machine Generation ID
>> via sysfs.
>>
>> The ID is a UUID value used to differentiate between virtual
>> machines.
>>
>> The VM-Generation ID is a feature defined by Microsoft (paper:
>> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by multiple
>> hypervisor vendors.
>>
>> Signed-off-by: Or Idgar <oridgar@gmail.com>
>
> I think it's a good idea to use sysfs for this. However,
> there are a couple of missing interfaces here:
>
> 1. Userspace needs a way to know when this value changes.
>    I see no change notifications here and that does not seem right.

We have the next version which includes notification. The problem is
that right now QEMU doesn't include a mean to change the generation id
on-the-fly, so it was not published it.

> 2. Userspace needs to be able to read these without
>    system calls. Pls add mmap support to the raw format.
>    (Phys address is not guaranteed to be page-aligned so you will
>     probably want an offset attribute for that as well).

I don't agree that this should be a requirement. According to the
specs, the value doesn't change frequently. A notification about a
change the re-reading the value should be enough for now.

> While it's possible to add these later in theory, it's
> easier if userspace can rely on all interfaces being
> in place just by detecting the directory presence.
>
>> ---
>>
>> Changes in v5:
>> - added to VMGENID module dependency on ACPI module.
>>
>>  Documentation/ABI/testing/sysfs-hypervisor |  13 +++
>>  drivers/misc/Kconfig                       |   7 ++
>>  drivers/misc/Makefile                      |   1 +
>>  drivers/misc/vmgenid.c                     | 142 +++++++++++++++++++++++++++++
>
> Do you want to add this under QEMU MACHINE EMULATOR in MAINTAINERS?
> This way e.g. qemu-devel will be copied.

This feature is supported by other hypervisors and this driver should
be able to support them in the next versions. I don't see a reason to
bound it to QEMU.

>>  4 files changed, 163 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
>>  create mode 100644 drivers/misc/vmgenid.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
>> new file mode 100644
>> index 000000000000..2f9a7b8eab70
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-hypervisor
>> @@ -0,0 +1,13 @@
>> +What:                /sys/hypervisor/vm_gen_counter
>
> It's not a counter, is it?
> I'd go with "vm_generation_id" here. Eschew abbreviation.

The names were chosen so they'll match Microsoft's specification and
code examples.

>> +Date:                February 2018
>> +Contact:     Or Idgar <idgar@virtualoco.com>
>> +             Gal Hammer <ghammer@redhat.com>
>> +Description: Expose the virtual machine generation ID. The directory
>> +             contains two files: "generation_id" and "raw". Both files
>> +             represent the same information.
>> +
>> +             "generation_id" file is a UUID string
>
> And this I'd call "uuid" then.

Why? The name says what the value is, not its type. This is not common
to see values' types in the sysfs directory.

>> +             representation.
>> +
>> +             "raw" file is a 128-bit integer
>> +             representation (binary).
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 03605f8fc0dc..a39feff6a867 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -500,6 +500,13 @@ config MISC_RTSX
>>       tristate
>>       default MISC_RTSX_PCI || MISC_RTSX_USB
>>
>> +config VMGENID
>> +     depends on ACPI
>> +     tristate "Virtual Machine Generation ID driver"
>> +     help
>> +       This is a Virtual Machine Generation ID driver which provides
>> +       a virtual machine unique identifier.
>> +
>>  source "drivers/misc/c2port/Kconfig"
>>  source "drivers/misc/eeprom/Kconfig"
>>  source "drivers/misc/cb710/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index c3c8624f4d95..067aa666bb6a 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -57,6 +57,7 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)      += aspeed-lpc-snoop.o
>>  obj-$(CONFIG_PCI_ENDPOINT_TEST)      += pci_endpoint_test.o
>>  obj-$(CONFIG_OCXL)           += ocxl/
>>  obj-$(CONFIG_MISC_RTSX)              += cardreader/
>> +obj-$(CONFIG_VMGENID)                += vmgenid.o
>>
>>  lkdtm-$(CONFIG_LKDTM)                += lkdtm_core.o
>>  lkdtm-$(CONFIG_LKDTM)                += lkdtm_bugs.o
>> diff --git a/drivers/misc/vmgenid.c b/drivers/misc/vmgenid.c
>> new file mode 100644
>> index 000000000000..6c8d8fe75335
>> --- /dev/null
>> +++ b/drivers/misc/vmgenid.c
>> @@ -0,0 +1,142 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Virtual Machine Generation ID driver
>> + *
>> + * Copyright (C) 2018 Red Hat, Inc. All rights reserved.
>> + *   Authors:
>> + *     Or Idgar <oridgar@gmail.com>
>> + *     Gal Hammer <ghammer@redhat.com>
>> + *
>> + */
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kobject.h>
>> +#include <linux/acpi.h>
>> +#include <linux/uuid.h>
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Or Idgar <oridgar@gmail.com>");
>> +MODULE_AUTHOR("Gal Hammer <ghammer@redhat.com>");
>> +MODULE_DESCRIPTION("Virtual Machine Generation ID");
>> +MODULE_VERSION("0.1");
>> +
>> +ACPI_MODULE_NAME("vmgenid");
>> +
>> +static u64 phys_addr;
>> +
>> +static ssize_t generation_id_show(struct device *_d,
>> +                           struct device_attribute *attr, char *buf)
>> +{
>> +     void __iomem *uuid_map;
>> +     uuid_t uuid;
>> +     ssize_t result;
>> +
>> +     uuid_map = acpi_os_map_iomem(phys_addr, sizeof(uuid_t));
>> +     if (!uuid_map)
>> +             return -EFAULT;
>
> Shouldn't this be acpi_os_map_memory? Spec says it's never an IO address.
>
>> +
>> +     memcpy_fromio(&uuid, uuid_map, sizeof(uuid_t));
>> +     result = sprintf(buf, "%pUl\n", &uuid);
>> +     acpi_os_unmap_iomem(uuid_map, sizeof(uuid_t));
>> +     return result;
>> +}
>> +static DEVICE_ATTR_RO(generation_id);
>> +
>> +static ssize_t raw_show(struct device *_d,
>> +                     struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     void __iomem *uuid_map;
>> +
>> +     uuid_map = acpi_os_map_iomem(phys_addr, sizeof(uuid_t));
>> +     if (!uuid_map)
>> +             return -EFAULT;
>> +     memcpy_fromio(buf, uuid_map, sizeof(uuid_t));
>> +     acpi_os_unmap_iomem(uuid_map, sizeof(uuid_t));
>> +     return sizeof(uuid_t);
>> +}
>> +static DEVICE_ATTR_RO(raw);
>
> I think you want BIN_ATTR_RO.
>
>
>> +
>> +static struct attribute *vmgenid_attrs[] = {
>> +     &dev_attr_generation_id.attr,
>> +     &dev_attr_raw.attr,
>> +     NULL,
>> +};
>> +static const struct attribute_group vmgenid_group = {
>> +     .name = "vm_gen_counter",
>> +     .attrs = vmgenid_attrs,
>> +};
>> +
>> +static int get_vmgenid(acpi_handle handle)
>> +{
>> +     int i;
>> +     struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +     acpi_status status;
>> +     union acpi_object *pss;
>> +     union acpi_object *element;
>> +
>> +     status = acpi_evaluate_object(handle, "ADDR", NULL, &buffer);
>> +     if (ACPI_FAILURE(status)) {
>> +             ACPI_EXCEPTION((AE_INFO, status, "Evaluating _ADDR"));
>
> It's ADDR - not _ADDR, right?
>
>> +             return -ENODEV;
>> +     }
>> +     pss = buffer.pointer;
>> +     if (!pss || pss->type != ACPI_TYPE_PACKAGE || pss->package.count != 2)
>> +             return -EFAULT;
>> +
>> +     phys_addr = 0;
>> +     for (i = 0; i < pss->package.count; i++) {
>> +             element = &(pss->package.elements[i]);
>> +             if (element->type != ACPI_TYPE_INTEGER)
>> +                     return -EFAULT;
>
> EINVAL  here and elsewhere.
>
>> +             phys_addr |= element->integer.value << i*32;
>
> i * 32
>
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int acpi_vmgenid_add(struct acpi_device *device)
>> +{
>> +     int retval;
>> +
>> +     if (!device)
>> +             return -EINVAL;
>> +     retval = get_vmgenid(device->handle);
>> +     if (retval < 0)
>> +             return retval;
>> +     return sysfs_create_group(hypervisor_kobj, &vmgenid_group);
>> +}
>> +
>> +static int acpi_vmgenid_remove(struct acpi_device *device)
>> +{
>> +     sysfs_remove_group(hypervisor_kobj, &vmgenid_group);
>> +     return 0;
>> +}
>> +
>> +static const struct acpi_device_id vmgenid_ids[] = {
>> +     {"QEMUVGID", 0},
>> +     {"", 0},
>> +};
>
> That's not right I think. You should go by _CID and maybe
> _DDN.

You are probably right on this. However, we didn't see that Linux
supports loading ACPI modules other than using the _HID value.

>>
>> +
>> +static struct acpi_driver acpi_vmgenid_driver = {
>> +     .name = "vm_gen_counter",
>> +     .ids = vmgenid_ids,
>> +     .owner = THIS_MODULE,
>> +     .ops = {
>> +             .add = acpi_vmgenid_add,
>> +             .remove = acpi_vmgenid_remove,
>> +     }
>> +};
>> +
>> +static int __init vmgenid_init(void)
>> +{
>> +     return acpi_bus_register_driver(&acpi_vmgenid_driver);
>> +}
>> +
>> +static void __exit vmgenid_exit(void)
>> +{
>> +     acpi_bus_unregister_driver(&acpi_vmgenid_driver);
>> +}
>> +
>> +module_init(vmgenid_init);
>> +module_exit(vmgenid_exit);
>
> Thanks for your work, and I hope this helps!
>
> --
> MST

Thanks,

    Gal.
