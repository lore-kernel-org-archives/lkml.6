Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeCMOCT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:02:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751673AbeCMOCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:02:17 -0400
Date: Tue, 13 Mar 2018 22:02:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        lcapitulino@redhat.com
Subject: Re: [PATCH v9 0/5] x86/KASLR: Add parameter
 kaslr_boot_mem=nn[KMG]@ss[KMG]
Message-ID: <20180313140210.GJ18656@localhost.localdomain>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
 <20180312093557.gxypr66vrbftz3v3@gmail.com>
 <20180312101031.GH18656@localhost.localdomain>
 <20180312105727.mzrtjvnyxgyz7jn7@gmail.com>
 <20180312120415.GC8547@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312120415.GC8547@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/18 at 08:04pm, Chao Fan wrote:
> On Mon, Mar 12, 2018 at 11:57:27AM +0100, Ingo Molnar wrote:
> >> > > ***Background:
> >> > > People reported that kaslr may randomly chooses some positions
> >> > > which are located in movable memory regions. This will break memory
> >> > > hotplug feature.
> >> > 
> >> > [...]
> >> > 
> >> > > ***Solutions:
> >> > > Introduce a new kernel parameter 'kaslr_boot_mem=nn@ss' to let users to
> >> > > specify the memory regions where kernel can be allowed to randomize
> >> > > safely.
> >> > 
> >> > Manual solutions like that are pretty suboptimal to users, aren't they?
> >> > 
> >> > In what way does memory hotplug feature 'break'? Does it crash or misbehave? Or 
> >> > simply does it not allow the movement of the affected memory region, while still 
> >> > allowing the rest to be moved?
> >> 
> >> AFAIT, if kernel is randomized into the movable memory region, the
> >> affected memory region can not be hot added/removed since it has kernel
> >> data. Surely, the system can still work, the unaffected part still can
> >> be moved. Still it will cause regression on memory hotplug.
> >> 
> >> Mainly we parse SRAT table to get the ranges of memory provided by
> >> hot-added memory devices in initmem_init(), that's very late. During boot,
> >> we don't know it. Chao ever posted patches to grab SRAT at decompressing
> >> stage, the code is very complicated and not elegant, ACPI maintainer
> >> NACKed that.
> 
> Thanks for Ingo's suggestion and Baoquan's explaination.
> 
> Yes, I did ever try to dig SRAT table in boot period in early RFC PATCH:
> https://lkml.org/lkml/2017/9/3/77
> But the change is too huge so made this patchset to avoid this bug in a
> small change, which will not make the code looks messy.

ACPI tables are not independent, to parse SRAT to get information of
hotplug memory, we need get RSDP pointer, which points at RSDT or XSDT.
Then find SRAT from them. While RSDP is not in a fixed location, there
are several candidate positions, code can be checked in acpi_find_root_pointer()
of drivers/acpi/acpica/tbxfroot.c . And then iterate RSDT/XSDT to search
SRAT. These codes can not be reused between kaslr.c and drivers/acpi
because acpi code has special handling. So it will bloat kaslr boot
code. This is why both Rafael and I think it might be not good to grab
parse ACPI SRAT table in kaslr boot code.

> 
> >
> >So there's apparently a mis-design here:
> >
> > - KASLR needs to be done very early on during bootup: - it's not realistic to 
> >   expect KASLR to be done with a booted up kernel, because pointers to various 
> >   KASLR-ed objects are already widely spread out in memory.
> >
> > - But for some unfathomable reason the memory hotplug attribute of memory
> >   regions is not part of the regular memory map but part of late-init ACPI data
> >   structures.
> >
> >The right solution would be _not_ to fudge the KASLR location, but to provide the 
> >memory hotplug information to early code, preferably via the primary memory map. 
> >KASLR can then make use of it and avoid those regions, just like it avoids other 
> >memory regions already.
> >
> >In addition to that hardware makers (including virtualized hardware) should also 
> >fix their systems to provide memory hotplug information to early code.

The hugepage allocation on kvm guest is a different situation. If people
want to allocate n pages of 1G size, they will get one page less in
kaslr enabled kernel than kaslr disabled kernel, casually. Because
kernel might be randomized to those 1G aligned huge pages in kaslr
kernel. While in no kaslr case, kernel will be put at 16M.

default_hugepagesz=1G hugepagesz=1G hugepages='n'

For this issue, unless we use a algorithm to analyze kernel cmdline and
do a flexiable estimate to avoid those 1G aligned huge pages. Still we
can't avoid the case that memblock may break the good 1G page. I can't
think of a good way to fix this in kaslr boot code.

Thanks
Baoquan

> >
> >
> 
> 
