Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1329C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A272820672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPLwCYsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A272820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410020AbeKXANj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:13:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53307 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405583AbeKXANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:13:38 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so18401651ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzdV3bLc0g8yTcTewKK70erjP8WTGgNJSxxyJo/v2og=;
        b=IPLwCYsqizcNdTMIw2Vt3dUeq9L39XK6AP3TBa+s56fUUleymYMNWlZvx0tUJJ0BFY
         OlU7DW1Am7DTvS/U4HakbuUYVYQ/P5AdxyJSQVM5iNNKOHwneTckqlA1Wr9hE0HBAutr
         YFKgNklqzlG0MaV0p+RJcTbXg4XSLTexG0jb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzdV3bLc0g8yTcTewKK70erjP8WTGgNJSxxyJo/v2og=;
        b=dxcVODqrvqG3Z20rWhCYkI9mNAHJLlg6ircW8z5w5j3xZvaq9hM1AzbiYtofglYVj8
         1kvksH1Rg8Soe79gQud3EMK1pq/cLAA6ru2dCIb0FMCk+WKUGEIoMqwk60G2i7ohVHq9
         kDFS4HSmynj++xAGq++/2+muTTtayBiInufyDTcH/3UXCH6MGJYhGci6pSZ1U4Yyx8nD
         /JLBU8gZVcRtVRjURD0cy1K+1PT1heY1+S2BlNGd5j0J/66xvUnGhgYfeu0Kn4tDMDlD
         5+sHlmGlKzwcc8pG9iZd1gRaiG3NC1mUi2LYbu3kUQNd65eY66/975ceN04n+oZJ8hzM
         BHXw==
X-Gm-Message-State: AGRZ1gJwnLOuUX4XMmPFbFNovK4DLqQF3p0gbwx3bXe9pPVh/2XkWkVW
        usM1NAc3rVeKqcBH0nWDTjcCeAnz++fgJF9Q10cLsYxl
X-Google-Smtp-Source: AFSGD/XvPe5aTEXXvs2Bychq6vtB1fj3aVrB+mgfVmu0vcI0bssTua6V6XJjd8sAAxFX8gTi7Vw8vZrf8IO0geEBKDs=
X-Received: by 2002:a24:710:: with SMTP id f16mr11783375itf.121.1542979765588;
 Fri, 23 Nov 2018 05:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org> <20181123094152.21368-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20181123094152.21368-3-ard.biesheuvel@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 23 Nov 2018 14:29:14 +0100
Message-ID: <CAKv+Gu9L10sCQ6j3NbZgC4U6-LzLfjyfVbE_MSpZop-2coYtXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 at 10:42, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
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
>  arch/arm64/include/asm/memory.h  |  3 +++
>  arch/arm64/include/asm/pgtable.h |  2 +-
>  arch/arm64/net/bpf_jit_comp.c    | 13 +++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..506e319da98f 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -69,6 +69,9 @@
>  #define PCI_IO_END             (VMEMMAP_START - SZ_2M)
>  #define PCI_IO_START           (PCI_IO_END - PCI_IO_SIZE)
>  #define FIXADDR_TOP            (PCI_IO_START - SZ_2M)
> +#define BPF_JIT_REGION_BASE    (VMALLOC_END)
> +#define BPF_JIT_REGION_SIZE    (SZ_128M)
> +#define BPF_JIT_REGION_END     (BPF_JIT_REGION_BASE + BPF_JIT_REGION_SIZE)
>

Discussing this off-line with Daniel, it may be better to put the BPF
region before the module space instead.

This will permit the use of adrp/add/b[l]r sequences for long
jumps/calls. When booting with KASLR enabled, we can enhance the logic
there to ensure that the BPF region remains inside the same 4 GB
window as the module region and the core kernel (and randomize it
relatively as well)

>  #define KERNEL_START      _text
>  #define KERNEL_END        _end
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 50b1ef8584c0..9db98a4cd9b4 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -31,7 +31,7 @@
>   *     and fixed mappings
>   */
>  #define VMALLOC_START          (MODULES_END)
> -#define VMALLOC_END            (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
> +#define VMALLOC_END            (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - BPF_JIT_REGION_SIZE - SZ_64K)
>
>  #define vmemmap                        ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a6fdaea07c63..298beba29fa5 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>                                            tmp : orig_prog);
>         return prog;
>  }
> +
> +void *bpf_jit_alloc_exec(unsigned long size)
> +{
> +       return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_BASE,
> +                                   BPF_JIT_REGION_END, GFP_KERNEL,
> +                                   PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> +                                   __builtin_return_address(0));
> +}
> +
> +void bpf_jit_free_exec(const void *addr)
> +{
> +       return vfree(addr);
> +}
> --
> 2.17.1
>
