Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1223020673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1223020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLAFgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:36:20 -0500
Received: from foss.arm.com ([217.140.101.70]:34354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:36:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129F9165C;
        Fri, 30 Nov 2018 10:26:11 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5DA83F575;
        Fri, 30 Nov 2018 10:26:10 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B8FAC1AE0FA2; Fri, 30 Nov 2018 18:26:29 +0000 (GMT)
Date:   Fri, 30 Nov 2018 18:26:29 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
Message-ID: <20181130182629.GA16085@arm.com>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123221804.440-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
> The arm64 module region is a 128 MB region that is kept close to
> the core kernel, in order to ensure that relative branches are
> always in range. So using the same region for programs that do
> not have this restriction is wasteful, and preferably avoided.
> 
> Now that the core BPF JIT code permits the alloc/free routines to
> be overridden, implement them by vmalloc()/vfree() calls from a
> dedicated 128 MB region set aside for BPF programs. This ensures
> that BPF programs are still in branching range of each other, which
> is something the JIT currently depends upon (and is not guaranteed
> when using module_alloc() on KASLR kernels like we do currently).
> It also ensures that placement of BPF programs does not correlate
> with the placement of the core kernel or modules, making it less
> likely that leaking the former will reveal the latter.
> 
> This also solves an issue under KASAN, where shadow memory is
> needlessly allocated for all BPF programs (which don't require KASAN
> shadow pages since they are not KASAN instrumented)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h |  5 ++++-
>  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..ee20fc63899c 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -62,8 +62,11 @@
>  #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
>  	(UL(1) << (VA_BITS - 1)) + 1)
>  #define KIMAGE_VADDR		(MODULES_END)
> +#define BPF_JIT_REGION_START	(VA_START + KASAN_SHADOW_SIZE)
> +#define BPF_JIT_REGION_SIZE	(SZ_128M)
> +#define BPF_JIT_REGION_END	(BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
>  #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
> -#define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
> +#define MODULES_VADDR		(BPF_JIT_REGION_END)
>  #define MODULES_VSIZE		(SZ_128M)
>  #define VMEMMAP_START		(PAGE_OFFSET - VMEMMAP_SIZE)
>  #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a6fdaea07c63..76c2ab40c02d 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  					   tmp : orig_prog);
>  	return prog;
>  }
> +
> +void *bpf_jit_alloc_exec(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> +				    BPF_JIT_REGION_END, GFP_KERNEL,
> +				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));

I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged. In the
meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
(although we'd need the size information...).

Will
