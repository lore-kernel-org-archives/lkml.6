Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeDSRk7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:40:59 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33841 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeDSRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:40:56 -0400
X-Google-Smtp-Source: AIpwx49cHjbyx2bF3LcyAFu1/V82HpoeytdUNl5rBpk2X93NX9xL7xr8A6+F7JYeBmuhQSZT0qGHig==
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com> <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
 <20180419154006.GE3600@pd.tnic>
 <977608e6-9f5d-c523-a78a-993ac5bfd55f@gmail.com>
 <20180419164528.GD5635@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <ffe6b459-c80a-d3c0-451d-0d21ae63da54@gmail.com>
Date: Thu, 19 Apr 2018 12:40:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180419164528.GD5635@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SURPRISE!!!

On 04/19/2018 11:45 AM, Borislav Petkov wrote:
> On Thu, Apr 19, 2018 at 11:26:57AM -0500, Alex G. wrote:
>> At a very high level, I'm working with Dell on improving server
>> reliability, with a focus on NVME hotplug and surprise removal. One of
>> the features we don't support is surprise removal of NVME drives;
>> hotplug is supported with 'prepare to remove'. This is one of the
>> reasons NVME is not on feature parity with SAS and SATA.
> 
> Ok, first question: is surprise removal something purely mechanical or
> do you need firmware support for it? In the sense that you need to tell
> the firmware that you will be removing the drive.

SURPRISE!!! removal only means that the system was not expecting the
drive to be yanked. An example is removing a USB flash drive without
first unmounting it and removing the usb device (echo 0 >
/sys/bus/usb/.../authorized).

PCIe removal and hotplug is fairly well spec'd, and NVMe rides on that
without issue. It's much easier and faster for an OS to just follow the
spec and handle things on its own.

Interference from firmware only comes in with EFI/ACPI and FFS. From a
purely technical point of view, firmware has nothing to do with this.
>From a firmware-centric view, unfortunately, firmware wants the ability
to log errors to the BMC... and hotplug events.

Does firmware need to know that a drive will be removed? I'm not aware
of any such requirement. I think the main purpose of 'prepare to remove'
is to shut down any traffic on the link. This way, link removal does not
generate PCIe errors which may otherwise end up crashing the OS.


> I'm sceptical, though, as it has "surprise" in the name so I'm guessing
> the firmware doesn't know about it, the drive physically disappears and
> the FW starts spewing PCIe errors...

It's not the FW that spews out errors. It's the hardware. It's very
likely that a device which is actively used will have several DMA
transactions already queued up and lots of traffic going through the
link. When the link dies and the traffic can't be delivered, Unsupported
Request errors are very common.

On the r740xd, FW just hides those errors from the OS with no further
notification. On this machine BIOS sets things up such that non-posted
requests report fatal (PCIe) errors. FW still tries very hard to hide
this from the OS, and I think the heuristic is that if the drive
physical presence is gone, don't even report the error.

There are a lot of problems with the approach, but one thing to keep in
mind is that the FW was written at a time when OSes were more than happy
to crash at any PCIe error reported through GHES.

Alex

>> I'm not sure if this is the example you're looking for, but
>> take an r740xd server, and slowly unplug an Intel NVME drives at an
>> angle. You're likely to crash the machine.
> 
> No no, that's actually a great example!
> 
> Thx.
> 
