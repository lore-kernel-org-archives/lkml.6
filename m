Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbeERFHw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:07:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39111 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERFHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:07:51 -0400
X-Google-Smtp-Source: AB8JxZphWgJQRKf1BEwGEAjGhGC6CoEfKKNOdf3Xd8FDJSIxaQKMK6RduBt3gq6rC/rWijpC2q8wew==
Date: Fri, 18 May 2018 14:07:47 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Baoquan He <bhe@redhat.com>
Cc: James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/11] arm64: kexec_file: allocate memory walking
 through memblock list
Message-ID: <20180518050741.GJ2737@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Baoquan He <bhe@redhat.com>, James Morse <james.morse@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-5-takahiro.akashi@linaro.org>
 <648656ef-1f1e-b0ac-581c-aba1e62f4eee@arm.com>
 <20180507055906.GE11326@linaro.org>
 <20180517021024.GI24627@MiWiFi-R3L-srv>
 <20180517021547.GJ24627@MiWiFi-R3L-srv>
 <d9b8a3ca-93bc-87f9-1316-f45c0dfe47ae@arm.com>
 <20180518013735.GP24627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518013735.GP24627@MiWiFi-R3L-srv>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,

On Fri, May 18, 2018 at 09:37:35AM +0800, Baoquan He wrote:
> On 05/17/18 at 07:04pm, James Morse wrote:
> > Hi Baoquan,
> > 
> > On 17/05/18 03:15, Baoquan He wrote:
> > > On 05/17/18 at 10:10am, Baoquan He wrote:
> > >> On 05/07/18 at 02:59pm, AKASHI Takahiro wrote:
> > >>> On Tue, May 01, 2018 at 06:46:09PM +0100, James Morse wrote:
> > >>>> On 25/04/18 07:26, AKASHI Takahiro wrote:
> > >>>>> We need to prevent firmware-reserved memory regions, particularly EFI
> > >>>>> memory map as well as ACPI tables, from being corrupted by loading
> > >>>>> kernel/initrd (or other kexec buffers). We also want to support memory
> > >>>>> allocation in top-down manner in addition to default bottom-up.
> > >>>>> So let's have arm64 specific arch_kexec_walk_mem() which will search
> > >>>>> for available memory ranges in usable memblock list,
> > >>>>> i.e. !NOMAP & !reserved, 
> > >>>>
> > >>>>> instead of system resource tree.
> > >>>>
> > >>>> Didn't we try to fix the system-resource-tree in order to fix regular-kexec to
> > >>>> be safe in the EFI-memory-map/ACPI-tables case?
> > >>>>
> > >>>> It would be good to avoid having two ways of doing this, and I would like to
> > >>>> avoid having extra arch code...
> > >>>
> > >>> I know what you mean.
> > >>> /proc/iomem or system resource is, in my opinion, not the best place to
> > >>> describe memory usage of kernel but rather to describe *physical* hardware
> > >>> layout. As we are still discussing about "reserved" memory, I don't want
> > >>> to depend on it.
> > >>> Along with memblock list, we will have more accurate control over memory
> > >>> usage.
> > >>
> > >> In kexec-tools, we see any usable memory as candidate which can be used
> > > 
> > > Here I said 'any', it's not accurate. Those memory which need be passed
> > > to 2nd kernel for use need be excluded, just as we have done in
> > > kexec-tools.
> > > 
> > >> to load kexec kernel image/initrd etc. However kexec loading is a
> > >> preparation work, it just books those position for later kexec kernel
> > >> jumping after "kexec -e", that is why we need kexec_buf to remember
> > >> them and do the real content copy of kernel/initrd.
> > 
> > The problem we have on arm64 is /proc/iomem is being used for two things.
> > 1) Kexec's this is memory I can book for the new kernel.
> > 2) Kdump's this is memory I must describe for vmcore.
> > 
> > We get the memory map from UEFI via the EFI stub, and leave it in
> > memblock_reserved() memory. A new kexec kernel needs this to boot: it mustn't
> > overwrite it. The same goes for the ACPI tables, they could be reclaimed and
> > used as memory, but the new kexec kernel needs them to boot, they are
> > memblock_reserved() too.
> 
> Thanks for these details. Seems arm64 is different. In x86 64 memblock

Thanks to James from me, too.

> is used as bootmem allocator and will be released when buddy takes over.
> Mainly, using memblock may bring concern that kexec kernel
> will jump to a unfixed position. This creates an unexpected effect as
> KASLR is doing, namely kernel could be put at a random position. As we

I don't think that this would be a problem on arm64.

> know, kexec was invented for fast kernel dev testing by bypassing
> firmware reset, and has been taken to reboot those huge server with
> thousands of devices and large memory for business currently. This extra
> unpected KASLR effect may cause annoyance even though people have
> disabled KASLR explicitly for a specific testing purpose.
> 
> Besides, discarding the /proc/iomem scanning but taking memblock instead
> in kernel space works for kexec loading for the time being, the flaw of
> /proc/iomem still exists and cause problem for user space kexec-tools,
> as pointed out. Do we have a plan for that?

This was the difference between my and James' standpoint (at leas initially).
James didn't want to require userspace changes to fix the issue, but
the reality is that, without modifying it, we can't support kexec and kdump
perfectly as James explained in his email.

> > 
> > If we knock all memblock_reserved() regions out of /proc/iomem then kdump
> > doesn't work, because /proc/iomem is only generated once. Its a snapshot. The
> > initcode/data is an example of memory we release from memblock_reserve() after
> > this, then gets used for data we need in the vmcore.
> 
> Hmm, I'm a little confused here. We have defined different iores type
> for different memory region. If acpi need be reused by kdump/kexec, we
> can change to not reclaim it, and add them into /proc/iomem in order to
> notify components which rely on them to process.
> 
> 
> enum {  
>         IORES_DESC_NONE                         = 0,
>         IORES_DESC_CRASH_KERNEL                 = 1,
>         IORES_DESC_ACPI_TABLES                  = 2,
>         IORES_DESC_ACPI_NV_STORAGE              = 3,
>         IORES_DESC_PERSISTENT_MEMORY            = 4,
>         IORES_DESC_PERSISTENT_MEMORY_LEGACY     = 5,
>         IORES_DESC_DEVICE_PRIVATE_MEMORY        = 6,
>         IORES_DESC_DEVICE_PUBLIC_MEMORY         = 7,
> };

I don't think that is the point.
Let me give you analogy: x86 has e820 and handles memory layout in kexec/
kdump with *x86-specific* code in kexec-tools, right? We want to do
something similar without introducing e820-like data.
In the current implementation on arm64, however, kexec-tools will only
recognize top-level entries in /proc/iomem leaving subsequent level of
entries ignored (except kernel text & data).
So adding extra hierarchy to /proc/iomem will break the compatibility
in any way.

The main reason that I insist on memblock in my kexec_file patch
is that we seem to be still far from reaching to agreement and
final solution in kexec (opposite to kexec_file) case.

Thanks,
-Takahiro AKASHI


> 
> Just walk around and talk about it, limited by poor arm64 knowledge, I
> may not have a complete view. If it's not like what I think about, I
> will stop, and can come back when I get more background knowledge.
> 
> Thanks
> Baoquan
> 
> > 
> > Ideally we would describe all this in /proc/iomem with:
> > | 8001e80000-83ff186fff : System RAM
> > |   8002080000-8002feffff : [Data you really need to boot]
> > 
> > kexec-tools should not overwrite 'data you really need to boot' unless it knows
> > what it is, and that the system will never need it again. (examples: overwrite
> > the ACPI tables when booting a non-acpi kernel, overwrite the UEFI memory map if
> > the DT has been regenerated for a non-uefi kernel)
> > 
> > But, kexec-tools doesn't parse those second level entries properly. We have a
> > bug in user-space, and a bug in the kernel.
> > 
> > Because /proc/iomem is being used for two things, and kexec-tools only parses
> > one level, I don't think we can fix this in the kernel without breaking one of
> > the use-cases. I think Akashi's fix user-space too approach is the most
> > pragmatic approach.
> > 
> > 
> > >> Here you use
> > >> memblock to search available memory, isn't it deviating too far away
> > >> from the original design in kexec-tools. Assume kexec loading and
> > >> kexec_file loading should be consistent on loading even though they are
> > >> done in different space, kernel space and user space.
> > 
> > Its much easier for us to parse memblock in the kernel as the helpers step over
> > the regions we know we don't want. For the resource list we would need to
> > strcmp(), and a bunch of handling for the second level entries.
> > 
> > 
> > Thanks,
> > 
> > James
