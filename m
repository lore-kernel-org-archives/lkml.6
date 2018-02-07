Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbeBGSjk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:39:40 -0500
Received: from foss.arm.com ([217.140.101.70]:54800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754185AbeBGSji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:39:38 -0500
Message-ID: <5A7B4756.1060503@arm.com>
Date: Wed, 07 Feb 2018 18:37:10 +0000
From: James Morse <james.morse@arm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
CC: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/11] kexec_file: factor out crashdump elf header
 function from x86
References: <20171204025801.12161-1-takahiro.akashi@linaro.org> <20171204025801.12161-4-takahiro.akashi@linaro.org>
In-Reply-To: <20171204025801.12161-4-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 04/12/17 02:57, AKASHI Takahiro wrote:
> prepare_elf_headers() can also be useful for other architectures,
> including arm64.

What does arm64 need this for? This is generating ELF headers for something, but
I can't work out what. (I'll keep reading,...)

The x86 decompressor? arm64 doesn't have one.
If its for the vmcore file, how does this work today?
If its for kexec_file_load()ing a vmlinux, I don't think we need to support this.

crashdump... how does the first kernel generate all the elf-notes etc today
without this?


> So let it factored out.

factored out... did anything change or is this patch just moving code around?


>  arch/x86/kernel/crash.c | 324 ------------------------------------------------
>  include/linux/kexec.h   |  17 +++
>  kernel/kexec_file.c     | 308 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_internal.h |  20 +++
>  4 files changed, 345 insertions(+), 324 deletions(-)

This is a lot of code being moved. Could you split this into a patch that just
moves the code, and another that makes any changes so they don't have to be
reviewed at the same time.

Some comments on the differences I spotted:

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 10e74d4778a1..bb8f3dcddaaa 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c

> -/* Gather all the required information to prepare elf headers for ram regions */
> -static void fill_up_crash_elf_data(struct crash_elf_data *ced,
> -				   struct kimage *image)
> -{
> -	unsigned int nr_ranges = 0;
> -
> -	ced->image = image;
> -
> -	walk_system_ram_res(0, -1, &nr_ranges,
> -				get_nr_ram_ranges_callback);
> -
> -	ced->max_nr_ranges = nr_ranges;
> -
> -	/* Exclusion of crash region could split memory ranges */
> -	ced->max_nr_ranges++;


> -	/* If crashk_low_res is not 0, another range split possible */
> -	if (crashk_low_res.end)
> -		ced->max_nr_ranges++;

This crashk stuff gets wrapped in #ifdef CONFIG_X86. Is it because arm64 doesn't
support kdump via kexec_file_load()? or because crashk_low_res isn't defined on
other architectures...

If this is moving to core code, could we add ARCH_HAS kconfig symbols so its
clear what it does and straightforward for another architecture to re-use.


> -}

[...]

> -/*
> - * Look for any unwanted ranges between mstart, mend and remove them. This
> - * might lead to split and split ranges are put in ced->mem.ranges[] array
> - */
> -static int elf_header_exclude_ranges(struct crash_elf_data *ced,
> -		unsigned long long mstart, unsigned long long mend)
> -{
> -	struct crash_mem *cmem = &ced->mem;
> -	int ret = 0;
> -
> -	memset(cmem->ranges, 0, sizeof(cmem->ranges));
> -
> -	cmem->ranges[0].start = mstart;
> -	cmem->ranges[0].end = mend;
> -	cmem->nr_ranges = 1;
> -
> -	/* Exclude crashkernel region */
> -	ret = exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> -	if (ret)
> -		return ret;


> -	if (crashk_low_res.end) {
> -		ret = exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> -		if (ret)
> -			return ret;
> -	}

And again here,


> -	return ret;
> -}

[..]

> -static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> -{
> -	struct crash_elf_data *ced = arg;
> -	Elf64_Ehdr *ehdr;
> -	Elf64_Phdr *phdr;
> -	unsigned long mstart, mend;

> -	struct kimage *image = ced->image;

> -	struct crash_mem *cmem;
> -	int ret, i;
> -
> -	ehdr = ced->ehdr;
> -
> -	/* Exclude unwanted mem ranges */
> -	ret = elf_header_exclude_ranges(ced, res->start, res->end);
> -	if (ret)
> -		return ret;
> -
> -	/* Go through all the ranges in ced->mem.ranges[] and prepare phdr */
> -	cmem = &ced->mem;
> -
> -	for (i = 0; i < cmem->nr_ranges; i++) {
> -		mstart = cmem->ranges[i].start;
> -		mend = cmem->ranges[i].end;
> -
> -		phdr = ced->bufp;
> -		ced->bufp += sizeof(Elf64_Phdr);
> -
> -		phdr->p_type = PT_LOAD;
> -		phdr->p_flags = PF_R|PF_W|PF_X;
> -		phdr->p_offset  = mstart;


> -		/*
> -		 * If a range matches backup region, adjust offset to backup
> -		 * segment.
> -		 */
> -		if (mstart == image->arch.backup_src_start &&
> -		    (mend - mstart + 1) == image->arch.backup_src_sz)
> -			phdr->p_offset = image->arch.backup_load_addr;

This becomes x86 only too, but this time its not touching crashk_low_res.
Could this be some kconfig name that describes what its for?
(We may want it in the future, and it silently gets #ifdef'd out!)


> -		phdr->p_paddr = mstart;
> -		phdr->p_vaddr = (unsigned long long) __va(mstart);
> -		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
> -		phdr->p_align = 0;
> -		ehdr->e_phnum++;
> -		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> -			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> -			ehdr->e_phnum, phdr->p_offset);
> -	}
> -
> -	return ret;
> -}

[..]

> -static int prepare_elf64_headers(struct crash_elf_data *ced,
> -		void **addr, unsigned long *sz)
> -{
> -	Elf64_Ehdr *ehdr;
> -	Elf64_Phdr *phdr;
> -	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
> -	unsigned char *buf, *bufp;
> -	unsigned int cpu;
> -	unsigned long long notes_addr;
> -	int ret;
> -
> -	/* extra phdr for vmcoreinfo elf note */
> -	nr_phdr = nr_cpus + 1;
> -	nr_phdr += ced->max_nr_ranges;
> -
> -	/*
> -	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
> -	 * area on x86_64 (ffffffff80000000 - ffffffffa0000000).
> -	 * I think this is required by tools like gdb. So same physical
> -	 * memory will be mapped in two elf headers. One will contain kernel
> -	 * text virtual addresses and other will have __va(physical) addresses.
> -	 */
> -
> -	nr_phdr++;
> -	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
> -	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
> -
> -	buf = vzalloc(elf_sz);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	bufp = buf;
> -	ehdr = (Elf64_Ehdr *)bufp;
> -	bufp += sizeof(Elf64_Ehdr);
> -	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> -	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
> -	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> -	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> -	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
> -	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
> -	ehdr->e_type = ET_CORE;
> -	ehdr->e_machine = ELF_ARCH;
> -	ehdr->e_version = EV_CURRENT;
> -	ehdr->e_phoff = sizeof(Elf64_Ehdr);
> -	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
> -	ehdr->e_phentsize = sizeof(Elf64_Phdr);
> -
> -	/* Prepare one phdr of type PT_NOTE for each present cpu */
> -	for_each_present_cpu(cpu) {
> -		phdr = (Elf64_Phdr *)bufp;
> -		bufp += sizeof(Elf64_Phdr);
> -		phdr->p_type = PT_NOTE;
> -		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
> -		phdr->p_offset = phdr->p_paddr = notes_addr;
> -		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
> -		(ehdr->e_phnum)++;
> -	}
> -
> -	/* Prepare one PT_NOTE header for vmcoreinfo */
> -	phdr = (Elf64_Phdr *)bufp;
> -	bufp += sizeof(Elf64_Phdr);
> -	phdr->p_type = PT_NOTE;
> -	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
> -	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
> -	(ehdr->e_phnum)++;
> -
> -#ifdef CONFIG_X86_64
> -	/* Prepare PT_LOAD type program header for kernel text region */
> -	phdr = (Elf64_Phdr *)bufp;
> -	bufp += sizeof(Elf64_Phdr);
> -	phdr->p_type = PT_LOAD;
> -	phdr->p_flags = PF_R|PF_W|PF_X;
> -	phdr->p_vaddr = (Elf64_Addr)_text;
> -	phdr->p_filesz = phdr->p_memsz = _end - _text;
> -	phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> -	(ehdr->e_phnum)++;
> -#endif

Eh?

You keep this #ifdef, is it actually x86_64 specific (i.e. not i386 or arm64),
or something affecting all 64bit architectures...
If its a historic ABI thing, could we add a comment explaining that...


> -	/* Prepare PT_LOAD headers for system ram chunks. */
> -	ced->ehdr = ehdr;
> -	ced->bufp = bufp;
> -	ret = walk_system_ram_res(0, -1, ced,
> -			prepare_elf64_ram_headers_callback);
> -	if (ret < 0)
> -		return ret;
> -
> -	*addr = buf;
> -	*sz = elf_sz;
> -	return 0;
> -}


Thanks,

James
