Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932159AbeEORQH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:16:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeEORQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:16:06 -0400
Subject: Re: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <0aba6388-8a73-d371-7b92-3594639eb27e@arm.com>
Date: Tue, 15 May 2018 18:12:59 +0100
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

Hi guys,

(CC: +RobH, devicetree list)

On 25/04/18 07:26, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>   using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>   "linux,elfcorehdr", which represent repsectively a memory range
>   to be used by crash dump kernel and the header's location

kexec_file_load() on arm64 needs to be able to create a prop encoded array to
the FDT, but there doesn't appear to be a libfdt helper to do this.

Akashi's code below adds fdt_setprop_range() to the arch code, and duplicates
bits of libfdt_internal.h to do the work.

How should this be done? I'm assuming this is something we need a new API in
libfdt.h for. How do these come about, and is there an interim step we can use
until then?

Thanks!

James

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
> +
> +static bool cells_size_fitted(unsigned long base, unsigned long size)
> +{
> +	/* if *_cells >= 2, cells can hold 64-bit values anyway */
> +	if ((__dt_root_addr_cells == 1) && (base >= (1ULL << 32)))
> +		return false;
> +
> +	if ((__dt_root_size_cells == 1) && (size >= (1ULL << 32)))
> +		return false;
> +
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
> +
> +		val64 = cpu_to_fdt64(val64);
> +		memcpy(buf, &val64, sizeof(val64));
> +	}
> +}
> +
> +static int fdt_setprop_range(void *fdt, int nodeoffset, const char *name,
> +				unsigned long addr, unsigned long size)
> +{
> +	void *buf, *prop;
> +	size_t buf_size;
> +	int result;
> +
> +	buf_size = (__dt_root_addr_cells + __dt_root_size_cells) * sizeof(u32);
> +	prop = buf = vmalloc(buf_size);
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
> +
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
> +
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
> +		if (ret)
> +			goto out_err;
> +	}
> +
>  	/* add bootargs */
>  	if (cmdline) {
>  		ret = fdt_setprop(buf, nodeoffset, "bootargs",
