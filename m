Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBIQGZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:06:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48832 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBIQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:06:23 -0500
Message-ID: <5A7DC66C.10107@arm.com>
Date: Fri, 09 Feb 2018 16:03:56 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: acpi,efi: fix alignment fault in accessing ACPI
 tables at kdump
References: <20180201090449.19514-1-takahiro.akashi@linaro.org> <CAKv+Gu-2-cG3vse4briKPK0gpi5Zrg+pZHiiN7-4DSBPn0n_3A@mail.gmail.com> <20180202043519.GD23847@linaro.org>
In-Reply-To: <20180202043519.GD23847@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi, Ard,

On 02/02/18 04:35, AKASHI Takahiro wrote:
> On Thu, Feb 01, 2018 at 05:34:26PM +0000, Ard Biesheuvel wrote:
>> On 1 February 2018 at 09:04, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>>> * Initial ACPI tables are normally stored in system ram and marked as
>>>   "ACPI Reclaim memory" by the firmware.

>>> * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
>>>   memory as MEMBLOCK_NOMAP"), those regions are differently handled
>>>   as they are "memblock-reserved", without NOMAP bit.

I don't think I'd grasped the implications of this before... are we accessing
the acpi tables via the linear map now?


>>> * So they are now excluded from device tree's "usable-memory-range"
>>>   which kexec-tools determines based on a current view of /proc/iomem.

>> So this patch does fix the fallout of how this issue affects ACPI boot
>> in particular, but is it correct in the first place for the kexec
>> tools to disregard memory that has been memblock_reserved()?

I don't think kexec should be allowed to accidentally overwrite these regions as
they contain data needed to boot the system.
The reason to allow this would be booting a non-acpi OS and removing all the
ACPI gubbins from the DTB, (but I don't care if kexec can't do this).

Overwriting these regions used to be prevented because these regions were nomap,
but now they are showing up as 'System RAM', so they could be accidentally
overwritten. It looks like /proc/iomem doesn't see memblock_reserve()d regions
as they are in both memblock.memory and memblock.reserved.


> My previous patch[1] is just for this. It would work not only for
> the case here but also for any "reserved" memory regions.
> The only noticeable drawback that I see in this approach is that
> the meaning of "usable-memory-range" is now a bit obscure.

usable-memory-range is only for kdump. The usable-memory-range is the reserved
crash region of the previous kernel, it can't overlap with anything that is
reserved by firmware.

Have I understood the problem correctly?:
1. ACPI reserved regions may be accidentally overwritten by kexec,
2. Kdump-kernel can't access the ACPI reserved regions via its linear map.


> Alternatively we may want to modify /proc/iomem, adding a specific
> resource entry for "ACPI Reclaim regions," 

This covers 1, nicely. kexec-tool's arm64:iomem_range_callback() looks like it
ignores regions it doesn't know about.


> and in turn kexec-tool so as to put them into "usable-memory-range",
> but it is rather a stopgap
> measure in my opinion. I don't like kexec relying heavily on userspace
> tool as exporting the reserved regions in /proc/iomem is also useless
> for most users.

Describing all the iomem:reserved regions in dt:usable-memory-range? Yes, that
sounds fragile.



For 1:
Changing /proc/iomem to report memblock_reserved() regions as reserved would fix
1. (I assume its harder to find the ACPI reserved regions again to describe them
separately). This stops kexec overwriting them.


For 2:
This patch solves the problem, but we access the acpi tables via the linear map
in the first kernel, but ioremap() them in the kdump kernel.

The only way to avoid this would be for the kernel's efi code to check that the
ACPI regions are mapped by the linear map, and add them if they aren't... which
is much scarier. So I prefer this patch for 2..



Thanks,

James
