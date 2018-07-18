Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D523BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989D820854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989D820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeGRR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:29:15 -0400
Received: from foss.arm.com ([217.140.101.70]:37704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbeGRR3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:29:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90917A9;
        Wed, 18 Jul 2018 09:50:29 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15273F318;
        Wed, 18 Jul 2018 09:50:26 -0700 (PDT)
Subject: Re: [PATCH v11 11/15] arm64: kexec_file: add crash dump support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-12-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <9efd0567-35dc-7435-74d6-1b540f3e5b9f@arm.com>
Date:   Wed, 18 Jul 2018 17:50:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711074203.3019-12-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 11/07/18 08:41, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>   using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>   "linux,elfcorehdr", which represent respectively a memory range
>   to be used by crash dump kernel and the header's location

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 69333694e3e2..eeb5766928b0 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -99,6 +99,10 @@ static inline void crash_post_resume(void) {}
>  struct kimage_arch {
>  	phys_addr_t dtb_mem;
>  	void *dtb_buf;
> +	/* Core ELF header buffer */

> +	void *elf_headers;

Shouldn't this be a phys_addr_t if it comes from kbuf.mem?
(dtb_mem is, and they type tells us which way round the runtime/kexec-time
pointers are)


> +	unsigned long elf_headers_sz;
> +	unsigned long elf_load_addr;
>  };
>  
>  /**


> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index a0b44fe18b95..261564df7210 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -132,6 +173,45 @@ static int setup_dtb(struct kimage *image,
>  	return ret;
>  }
>  
> +static int prepare_elf_headers(void **addr, unsigned long *sz)
> +{
> +	struct crash_mem *cmem;
> +	unsigned int nr_ranges;
> +	int ret;
> +	u64 i;
> +	phys_addr_t start, end;

> +	nr_ranges = 1; /* for exclusion of crashkernel region */
> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
> +							&start, &end, NULL)

Nit: flags = MEMBLOCK_NONE? Just to make it obvious this is how MEMBLOCK_NOMAP
regions are weeded out.

This is going to get interesting if we ever support hotpluggable memory... but
it works for now and implicitly removes the nomap regions.


> +		nr_ranges++;

> +
> +	cmem = kmalloc(sizeof(struct crash_mem) +
> +			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
> +	if (!cmem)
> +		return -ENOMEM;
> +
> +	cmem->max_nr_ranges = nr_ranges;
> +	cmem->nr_ranges = 0;
> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
> +							&start, &end, NULL) {
> +		cmem->ranges[cmem->nr_ranges].start = start;
> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +		cmem->nr_ranges++;
> +	}
> +
> +	/* Exclude crashkernel region */
> +	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);


> +	if (ret)
> +		goto out;
> +
> +	ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +
> +out:

Nit: You could save the goto if you wrote this as:
|	if (!ret)
|		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);


> +	kfree(cmem);
> +	return ret;
> +}
> +
>  int load_other_segments(struct kimage *image,
>  			unsigned long kernel_load_addr,
>  			unsigned long kernel_size,
> @@ -139,11 +219,43 @@ int load_other_segments(struct kimage *image,
>  			char *cmdline, unsigned long cmdline_len)
>  {
>  	struct kexec_buf kbuf;
> +	void *hdrs_addr;
> +	unsigned long hdrs_sz;
>  	unsigned long initrd_load_addr = 0;
>  	char *dtb = NULL;
>  	unsigned long dtb_len = 0;
>  	int ret = 0;
>  
> +	/* load elf core header */
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		ret = prepare_elf_headers(&hdrs_addr, &hdrs_sz);
> +		if (ret) {
> +			pr_err("Preparing elf core header failed\n");
> +			goto out_err;
> +		}
> +
> +		kbuf.image = image;
> +		kbuf.buffer = hdrs_addr;
> +		kbuf.bufsz = hdrs_sz;
> +		kbuf.memsz = hdrs_sz;

> +		kbuf.buf_align = PAGE_SIZE;

Whose PAGE_SIZE?

Won't this break if the kdump kernel is 64K pages, but the first kernel uses 4K?
Should we change this to the largest supported PAGE_SIZE: SZ_64K?


> +		kbuf.buf_min = crashk_res.start;
> +		kbuf.buf_max = crashk_res.end + 1;
> +		kbuf.top_down = true;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret) {
> +			vfree(hdrs_addr);
> +			goto out_err;
> +		}
> +		image->arch.elf_headers = hdrs_addr;
> +		image->arch.elf_headers_sz = hdrs_sz;
> +		image->arch.elf_load_addr = kbuf.mem;
> +
> +		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +				 image->arch.elf_load_addr, hdrs_sz, hdrs_sz);
> +	}
> +
>  	kbuf.image = image;
>  	/* not allocate anything below the kernel */
>  	kbuf.buf_min = kernel_load_addr + kernel_size;


I think the initramfs can escape the crash kernel range because you add to the
buf_max region:
|	/* within 1GB-aligned window of up to 32GB in size */
|	kbuf.buf_max = round_down(kernel_load_addr, SZ_1G)
|				 + (unsigned long)SZ_1G * 32;


I think we need a helper to clamp these min/max ranges to within the crash
kernel range, as its needs doing in a few places.


Thanks,

James
