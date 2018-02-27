Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeB0S7t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:59:49 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46656 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeB0S7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:59:19 -0500
X-Google-Smtp-Source: AG47ELsQWaxJk5sG9gkDGD1z8g908jloQqH1XdpZQEqATjoaLpJrzgO6COD2sUBVo011Ypz5rghpFUn4lLQIGsEh4sk=
MIME-Version: 1.0
In-Reply-To: <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CACi5LpM9hn17o7i7R3GUjQYy=6DFtCFKSbDUN7A7MGBTuf7=xw@mail.gmail.com> <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 28 Feb 2018 00:29:16 +0530
Message-ID: <CACi5LpMv_LB3wi7qn33b6mysdK_weki0YYsG0EkqPhR8FvFq5w@mail.gmail.com>
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
To: Jonathan Toppins <jtoppins@redhat.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        astone@redhat.com, Jonathan Masters <jcm@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, rafael.j.wysocki@intel.com,
        Ingo Molnar <mingo@kernel.org>, Prarit Bhargava <prarit@redhat.com>,
        James Morse <james.morse@arm.com>, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 8:14 PM, Jonathan Toppins <jtoppins@redhat.com> wrote:
> On 02/27/2018 07:40 AM, Bhupesh Sharma wrote:
>> Hi,
>>
>> On Tue, Feb 27, 2018 at 11:35 AM, Jonathan Toppins <jtoppins@redhat.com> wrote:
>>> This patch allows a user to configure ACPI to be preferred over
>>> device-tree.
>>>
>>> Currently for ACPI to be used a user either has to set acpi=on on the
>>> kernel command line or make sure any device tree passed to the kernel
>>> is empty. If the dtb passed to the kernel is non-empty then device-tree
>>> will be chosen as the boot method of choice even if it is not correct.
>>
>> Hmm. Not sure if I correctly understand what you mean here by the term
>> 'incorrect device tree'. Do you mean a corrupted device tree blob (but
>> normally we can catch those cases via the device tree header) or a
>> deliberate (or a broken) firmware attempt to pass an incorrect device
>> tree blob to the OS.
>
> I mean a device tree that doesn't list all devices in the SOC. So it is
> more incomplete than incorrect. It could also be incorrect in that it
> doesn't list proper timings, memory/pci/etc.
>
>>
>> If its the later, I think the onus should be on the firmware (u-boot
>> or UEFI or others.. ) to fix the problems. I know we carry a lot of
>> fixes in the kernel for x86 firmware quirks but then we have several
>> broken x86 machines on which kernel has been running since several
>> years now.
>>
>> IMO, if we have a known firmware quirk (to fix the broken DTB being
>> passed from the firmware), we can look at adding it in the early arm64
>> kernel code (similar to the quirk handling we do in the x86 early
>> kernel code for broken firmware), rather than forcing ACPI as the boot
>> method.
>>
>>> To prevent this situation where a system is only intended to be booted
>>> via ACPI a user can set this kernel configuration so it ignores
>>> device-tree settings unless ACPI table checks fail.
>>
>> Or, if decide to depreciate DTB as the boot method for such boards,
>> can we look at setting 'acpi=force' in the bootagrs always to make
>> sure that ACPI (and no fallback on DTB) is forced as the boot method
>> for such arm64 machines.
>
> For arm64 DT is suppose to *not* be the preferred method, yet still DT
> is preferred if the firmware provides both tables to the kernel.

That is true mainly for arm64 systems which are compliant to SBSA/SBBR
specifications and are mainly targeted for server markets.

However several arm64 products in embedded applications are still not
SBSA/SBBR compliant (and I have worked on a couple of such
implementations earlier) and still use bootloaders like u-boot (and
also closed-source implementations) which have no support for ACPI
currently and still rely on a DT to pass the system hardware
information to the kernel.

So far only open source implementation of a ACPI compliant firmware is
EDK2/UEFI which supports ACPI as the preferred boot method and I am
not sure if all u-boot/in-house firmware implementations are planned
to be ported over to EDK2/UEFI for embedded applications.

Even if they do, it would be safe to assume that to maintain backward
compatibility they will still look to support boot via DT as the
default boot method rather than ACPI.

Regards,
Bhupesh
