Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1554C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BF120685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BF120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbeGZOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:53:57 -0400
Received: from foss.arm.com ([217.140.101.70]:56038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbeGZOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:53:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355C615A2;
        Thu, 26 Jul 2018 06:37:02 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6E83F6A8;
        Thu, 26 Jul 2018 06:36:59 -0700 (PDT)
Subject: Re: [PATCH v12 12/16] arm64: kexec_file: add crash dump support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-13-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <e7605411-c54f-c744-43a7-aecc0e36e3f3@arm.com>
Date:   Thu, 26 Jul 2018 14:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-13-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>   using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>   "linux,elfcorehdr", which represent respectively a memory range
>   to be used by crash dump kernel and the header's location

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 5d102a1054b3..1b2c27026ae0 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -97,8 +97,12 @@ static inline void crash_post_resume(void) {}
>  #define ARCH_HAS_KIMAGE_ARCH
>  
>  struct kimage_arch {

> -	void *dtb_buf;
> +	void *dtb;

This change should be in an earlier patch, otherwise this series doesn't build
during bisect.

With the build-issues fixed:
Reviewed-by: James Morse <james.morse@arm.com>

Some boring Nits:

>  	unsigned long dtb_mem;
> +	/* Core ELF header buffer */
> +	void *elf_headers;
> +	unsigned long elf_headers_mem;
> +	unsigned long elf_headers_sz;
>  };
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index b8297f10e2ef..7356da5a53d5 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -38,12 +44,30 @@ static int setup_dtb(struct kimage *image,
>  		void **dtb_buf, unsigned long *dtb_buf_len)
>  {
>  	void *buf = NULL;
> -	size_t buf_size;
> +	size_t buf_size, range_size;
>  	int nodeoffset;
>  	int ret;
>  
>  	/* duplicate dt blob */
>  	buf_size = fdt_totalsize(initial_boot_params);
> +	range_size = of_fdt_reg_cells_size();
> +
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
> +		buf_size += fdt_prop_len("linux,usable-memory-range",
> +								range_size);
> +	}

Nit: it would be better if these strings were defined in a header file somewhere
so we don't risk a typo if this gets refactored.



> @@ -129,6 +170,43 @@ static int setup_dtb(struct kimage *image,
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
> +
> +	nr_ranges = 1; /* for exclusion of crashkernel region */

> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
> +							&start, &end, NULL)

Nit: MEMBLOCK_NONE


Thanks,

James
