Return-Path: <ghammer@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519318143; cv=none;
        d=google.com; s=arc-20160816;
        b=nS43/qKswQfqp/Ox9YtsZZpezIghLRVJVxgWy/XsyGDACbMerJHHekOQQMjHpkY9Rs
         y6Ic4PLwXTxO2ztnDLQ0F5etqqYYXLA8HR239hcwqi8/6Uy6VQcFcboTsbUeB2gjPM12
         H299KarL/d22B4ilRY5tKWf8jSRyvp6G6Ry3u4yUq6aNHhgIbChuQPC/lQHDB9ofrEnn
         39MWAkkK2MAv7bhuIfmDzYPHCtOUVQgYFwhhkE0uOu2a8s+yn9d4TLjdAjpeUWjyQmdg
         +VjZKqO20MpuaxQ9l+L0lYiBAQr2Ta/3aMxNuKn9gQiWDiQWbYwbnkiQVjXTEEqQpbwe
         xaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=ibG871woPSXtHUG8OGtM9lxdQU/NhkLkVNjujDsX6og=;
        b=tD3Z0Rgl1evv0WQixuKHHA7NrFn6Gz2Nc4OH15UsdpNIWD25+aLMZy6acInGGVfmsM
         7ZqXMk5ZnE+h9aJ7JnAs/Lo8bmVgoNFTecIk2ZeP6BzphSOwJaspouR5qOt3pIgi9Nwq
         dcZqhTKOT03xRpJ9B/qgrgk1JRfL+F4HySaM+0DeZao0QH3pXwHH+5KUbc1ZZpcxBsYO
         blslIdvREXfohZXA7O69veq5KqaQRG1IXUmLNC6gnmb2SrAowjj/BA1JheFPNtLsCLEl
         NXKf5iY1j7NsODSucosHJn6OGoKpTwv4nc3FY3hXOkUD0j0uBB/TfsAJxSGQKMXBOWVV
         Ccug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ghammer@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ghammer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ghammer@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ghammer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AH8x226dgdkYg0Vh/XzJlTospQd0BvpRfCbZ1UDGUc1KHur5tuZO907ROnHYuM2IDq8779eSi0scUw/RyKA1d5Ua8Qg=
MIME-Version: 1.0
In-Reply-To: <20180222163628.GA19172@kroah.com>
References: <20180222162038.28768-1-idgar@virtualoco.com> <20180222163628.GA19172@kroah.com>
From: Gal Hammer <ghammer@redhat.com>
Date: Thu, 22 Feb 2018 18:49:00 +0200
Message-ID: <CAA2ifQxGKaY-Atc-pF5XOkqUpjE=9HOFt2g1THDAxdeMwrL0eQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vm_gen_counter: initial driver implementation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org, arnd@arndb.de,
	Or Idgar <oridgar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593118768319025256?=
X-GMAIL-MSGID: =?utf-8?q?1593120541175570251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Feb 22, 2018 at 6:36 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Feb 22, 2018 at 06:20:38PM +0200, Or Idgar wrote:
>> From: Or Idgar <oridgar@gmail.com>
>>
>> This patch is a driver which expose the Virtual Machine Generation ID
>> via sysfs. The ID is a UUID value used to differentiate between virtual
>> machines.
>>
>> The VM-Generation ID is a feature defined by Microsoft (paper:
>> http://go.microsoft.com/fwlink/?LinkId=260709) and supported by multiple
>> hypervisor vendors.
>>
>> Signed-off-by: Or Idgar <oridgar@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-hypervisor |  13 +++
>>  drivers/misc/Kconfig                       |   6 ++
>>  drivers/misc/Makefile                      |   1 +
>>  drivers/misc/vmgenid.c                     | 141 +++++++++++++++++++++++++++++
>>  4 files changed, 161 insertions(+)
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
> Shouldn't this go under the specific hypervisor you are running on?  Why
> in the "root" of /sys/hypervisor?

As far as I know, most of today's hypervisors support this feature, so
adding a subdirectory doesn't seem right. The guest user should be
able to access the UUID without a knowledge of the running host.

At the moment, the driver supports only QEMU, but we're planning to
enhance it once we'll have access to other vendor hypervisors.

>
>> +Date:                February 2018
>> +Contact:     Or Idgar <idgar@virtualoco.com>
>> +             Gal Hammer <ghammer@redhat.com>
>> +Description: Expose the virtual machine generation ID. The directory
>> +             contains two files: "generation_id" and "raw". Both files
>> +             represent the same information.
>> +
>> +             "generation_id" file is a UUID string
>> +             representation.
>> +
>> +             "raw" file is a 128-bit integer
>> +             representation (binary).
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 03605f8fc0dc..5a74802bdfb4 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -500,6 +500,12 @@ config MISC_RTSX
>>       tristate
>>       default MISC_RTSX_PCI || MISC_RTSX_USB
>>
>> +config VMGENID
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
>> index 000000000000..9d7f09f9e7bd
>> --- /dev/null
>> +++ b/drivers/misc/vmgenid.c
>> @@ -0,0 +1,141 @@
>> +/*
>> + * Virtual Machine Generation ID driver
>> + *
>> + * Copyright (C) 2018 Red Hat, Inc. All rights reserved.
>> + *   Authors:
>> + *     Or Idgar <oridgar@gmail.com>
>> + *     Gal Hammer <ghammer@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>
> No SPDX line?  Please see the documentation for how to properly add this
> as the first line of any new file.

We'll give it another try.

> I want some hypervisor people to weigh in on this before I can take
> it...
>
> thanks,
>
> greg k-h

Thank you.

    Gal.
