Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeEOROZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:14:25 -0400
Received: from foss.arm.com ([217.140.101.70]:35988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754116AbeEOROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:14:24 -0400
Subject: Re: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
Date: Tue, 15 May 2018 18:11:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425062629.29404-8-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>   using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>   "linux,elfcorehdr", which represent repsectively a memory range

(Nit: respectively)


>   to be used by crash dump kernel and the header's location

>  arch/arm64/include/asm/kexec.h         |   4 +
>  arch/arm64/kernel/kexec_image.c        |   9 +-
>  arch/arm64/kernel/machine_kexec_file.c | 202 +++++++++++++++++++++++++

In this patch, machine_kexec_file.c gains its own private fdt array encoder.


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 37c0a9dc2e47..ec674f4d267c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -76,6 +81,78 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  	return ret;
>  }
>  
> +static int __init arch_kexec_file_init(void)
> +{
> +	/* Those values are used later on loading the kernel */
> +	__dt_root_addr_cells = dt_root_addr_cells;
> +	__dt_root_size_cells = dt_root_size_cells;
> +
> +	return 0;
> +}
> +late_initcall(arch_kexec_file_init);

If we need these is it worth taking them out of __initdata? I note they've been
'temporary' for quite a long time.


> +
> +#define FDT_ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
> +#define FDT_TAGALIGN(x)	(FDT_ALIGN((x), FDT_TAGSIZE))
> +
> +static int fdt_prop_len(const char *prop_name, int len)
> +{
> +	return (strlen(prop_name) + 1) +
> +		sizeof(struct fdt_property) +
> +		FDT_TAGALIGN(len);
> +}

This stuff should really be in libfdt.h  Those macros come from
libfdt_internal.h, so we're probably doing something wrong here.


> +static bool cells_size_fitted(unsigned long base, unsigned long size)
> +{
> +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
> +	if ((__dt_root_addr_cells == 1) && (base >= (1ULL << 32)))
> +		return false;
> +
> +	if ((__dt_root_size_cells == 1) && (size >= (1ULL << 32)))
> +		return false;

Using '> U32_MAX' here may be more readable.


> +	return true;
> +}
> +
> +static void fill_property(void *buf, u64 val64, int cells)
> +{
> +	u32 val32;
> +
> +	if (cells == 1) {
> +		val32 = cpu_to_fdt32((u32)val64);
> +		memcpy(buf, &val32, sizeof(val32));
> +	} else {

> +		memset(buf, 0, cells * sizeof(u32) - sizeof(u64));
> +		buf += cells * sizeof(u32) - sizeof(u64);

Is this trying to clear the 'top' cells and shuffle the pointer to point at the
'bottom' 2? I'm pretty sure this isn't endian safe.

Do we really expect a system to have #address-cells > 2?


> +		val64 = cpu_to_fdt64(val64);
> +		memcpy(buf, &val64, sizeof(val64));
> +	}
> +}
> +
> +static int fdt_setprop_range(void *fdt, int nodeoffset, const char *name,
> +				unsigned long addr, unsigned long size)

(the device-tree spec describes a 'ranges' property, which had me confused. This
is encoding a prop-encoded-array)

> +{
> +	void *buf, *prop;
> +	size_t buf_size;
> +	int result;
> +
> +	buf_size = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
> +	prop = buf = vmalloc(buf_size);

virtual memory allocation for something less than PAGE_SIZE?


> +	if (!buf)
> +		return -ENOMEM;
> +
> +	fill_property(prop, addr, __dt_root_addr_cells);
> +	prop += __dt_root_addr_cells * sizeof(u32);
> +
> +	fill_property(prop, size, __dt_root_size_cells);
> +
> +	result = fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
> +
> +	vfree(buf);
> +
> +	return result;
> +}

Doesn't this stuff belong in libfdt? I guess there is no 'add array element' api
because this the first time we've wanted to create a node with more than
key=fixed-size-value.

I don't think this belongs in arch C code. Do we have a plan for getting libfdt
to support encoding prop-arrays? Can we put it somewhere anyone else duplicating
this will find it, until we can (re)move it?

I have no idea how that happens... it looks like the devicetree list is the
place to ask.


>  static int setup_dtb(struct kimage *image,
>  		unsigned long initrd_load_addr, unsigned long initrd_len,
>  		char *cmdline, unsigned long cmdline_len,
> @@ -88,10 +165,26 @@ static int setup_dtb(struct kimage *image,
>  	int range_len;
>  	int ret;
>  
> +	/* check ranges against root's #address-cells and #size-cells */
> +	if (image->type == KEXEC_TYPE_CRASH &&
> +		(!cells_size_fitted(image->arch.elf_load_addr,
> +				image->arch.elf_headers_sz) ||
> +		 !cells_size_fitted(crashk_res.start,
> +				crashk_res.end - crashk_res.start + 1))) {
> +		pr_err("Crash memory region doesn't fit into DT's root cell sizes.\n");
> +		ret = -EINVAL;
> +		goto out_err;
> +	}

To check I've understood this properly: This can happen if the firmware provided
a DTB with 32bit address/size cells, but at least some of the memory requires 64
bit address/size cells. This could only happen on a UEFI system where the
firmware-DTB doesn't describe memory. ACPI-only systems would have the EFIstub DT.


>  	/* duplicate dt blob */
>  	buf_size = fdt_totalsize(initial_boot_params);
>  	range_len = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
>  
> +	if (image->type == KEXEC_TYPE_CRASH)
> +		buf_size += fdt_prop_len("linux,elfcorehdr", range_len)
> +				+ fdt_prop_len("linux,usable-memory-range",
> +								range_len);
> +
>  	if (initrd_load_addr)
>  		buf_size += fdt_prop_len("linux,initrd-start", sizeof(u64))
>  				+ fdt_prop_len("linux,initrd-end", sizeof(u64));
> @@ -113,6 +206,23 @@ static int setup_dtb(struct kimage *image,
>  	if (nodeoffset < 0)
>  		goto out_err;
>  
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		/* add linux,elfcorehdr */
> +		ret = fdt_setprop_range(buf, nodeoffset, "linux,elfcorehdr",
> +				image->arch.elf_load_addr,
> +				image->arch.elf_headers_sz);
> +		if (ret)
> +			goto out_err;
> +
> +		/* add linux,usable-memory-range */
> +		ret = fdt_setprop_range(buf, nodeoffset,
> +				"linux,usable-memory-range",
> +				crashk_res.start,
> +				crashk_res.end - crashk_res.start + 1);

Don't you need to add "linux,usable-memory-range" to the buf_size estimate?


> +		if (ret)
> +			goto out_err;
> +	}

> @@ -148,17 +258,109 @@ static int setup_dtb(struct kimage *image,

> +static struct crash_mem *get_crash_memory_ranges(void)
> +{
> +	unsigned int nr_ranges;
> +	struct crash_mem *cmem;
> +
> +	nr_ranges = 1; /* for exclusion of crashkernel region */
> +	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ranges_callback);
> +
> +	cmem = vmalloc(sizeof(struct crash_mem) +
> +			sizeof(struct crash_mem_range) * nr_ranges);
> +	if (!cmem)
> +		return NULL;
> +
> +	cmem->max_nr_ranges = nr_ranges;
> +	cmem->nr_ranges = 0;
> +	walk_system_ram_res(0, -1, cmem, add_mem_range_callback);
> +
> +	/* Exclude crashkernel region */
> +	if (crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end)) {
> +		vfree(cmem);
> +		return NULL;
> +	}
> +
> +	return cmem;
> +}

Could this function be included in prepare_elf_headers() so that the alloc() and
free() occur together.


> +static int prepare_elf_headers(void **addr, unsigned long *sz)
> +{
> +	struct crash_mem *cmem;
> +	int ret = 0;
> +
> +	cmem = get_crash_memory_ranges();
> +	if (!cmem)
> +		return -ENOMEM;
> +
> +	ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +
> +	vfree(cmem);

> +	return ret;
> +}

All this is moving memory-range information from core-code's
walk_system_ram_res() into core-code's struct crash_mem, and excluding
crashk_res, which again is accessible to the core code.

It looks like this is duplicated in arch/x86 and arch/arm64 because arm64
doesn't have a second 'crashk_low_res' region, and always wants elf64, instead
of when IS_ENABLED(CONFIG_X86_64).
If we can abstract just those two, more of this could be moved to core code
where powerpc can make use of it if they want to support kdump with
kexec_file_load().

But, its getting late for cross-architecture dependencies, lets put that on the
for-later list. (assuming there isn't a powerpc-kdump series out there adding a
third copy of this)


Thanks,

James
