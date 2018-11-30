Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DC120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHS8LBd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DC120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLAGaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:30:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37935 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAGaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:30:39 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so5440760ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oyLivuR6iu3HBUduImb583ldtAsf/AHlenv6DXRn7I=;
        b=hHS8LBd2YHsWqDkPHzu+JfBTi4G6Rb0rtS5CdBZeGFmxdcDqzUianqzCpVdRfk+R0V
         ffGKyShmJWinTSqvOT79TUqn3R3ndPV0wbcw9nk8CDb+0PlD8Sv11XxEKJ3+y/OTkxVw
         6foQDWk1Jk2WJAdJw7Clwgur97sGZv5WUdbXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oyLivuR6iu3HBUduImb583ldtAsf/AHlenv6DXRn7I=;
        b=L50cBg0U9ZkMGbTMTxiHyaZao5YeZutub1lrsDsutA5l0KgMQ5K3ppeR2idtm94rQ4
         zn+jhkSnc/DjUCIXzGtLUiSrBL0upOpKWMFRcw2Szy4d0nWyj9Z4Vo6uwjF1CAm7NOkg
         qQh1H42zOXLzmBaEIeapUkTxChcIKZDYIaevhehVSS5FvX5akDjZrA9xgYPrNKo6nI2d
         DFKdZ7ngfZEeuJumy1APpcwP8tgKgYJK27NwOpzzofV9rA2HcElIksU53haSxh+BszBw
         ojPA5ZIKxM7D/dYnz5CEwYIPXpLqx0UmeCli5EtHHy/7FbP+I0iDSG7boI/SjrQpjoZe
         0GXg==
X-Gm-Message-State: AA+aEWZQBpdQ7Q6NTf6txY/+vR6xyaVW1Hw03evbxJhHfmdf5ryqHczj
        UIX9XBzDjVDFO7G3vN4lXOS7KMMxmJzvHHfweRqjBQ==
X-Google-Smtp-Source: AFSGD/VhXBciaLlTOF6kvbc1O2gs0a4+AjyfEH4L6uD4+ox5SdkbFDXw/HS5RJAr4ZvDqaVsVy4+/j2Pm1+JX8ejzo8=
X-Received: by 2002:a5d:8402:: with SMTP id i2mr5799226ion.173.1543605620911;
 Fri, 30 Nov 2018 11:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-3-ard.biesheuvel@linaro.org> <20181130182629.GA16085@arm.com>
In-Reply-To: <20181130182629.GA16085@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 20:20:06 +0100
Message-ID: <CAKv+Gu9QVHLWu5H3Ok1Kbm=vtzd1KaHUn2VEij6oToW5aPR9uA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 23, 2018 at 11:18:04PM +0100, Ard Biesheuvel wrote:
> > The arm64 module region is a 128 MB region that is kept close to
> > the core kernel, in order to ensure that relative branches are
> > always in range. So using the same region for programs that do
> > not have this restriction is wasteful, and preferably avoided.
> >
> > Now that the core BPF JIT code permits the alloc/free routines to
> > be overridden, implement them by vmalloc()/vfree() calls from a
> > dedicated 128 MB region set aside for BPF programs. This ensures
> > that BPF programs are still in branching range of each other, which
> > is something the JIT currently depends upon (and is not guaranteed
> > when using module_alloc() on KASLR kernels like we do currently).
> > It also ensures that placement of BPF programs does not correlate
> > with the placement of the core kernel or modules, making it less
> > likely that leaking the former will reveal the latter.
> >
> > This also solves an issue under KASAN, where shadow memory is
> > needlessly allocated for all BPF programs (which don't require KASAN
> > shadow pages since they are not KASAN instrumented)
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/include/asm/memory.h |  5 ++++-
> >  arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index b96442960aea..ee20fc63899c 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -62,8 +62,11 @@
> >  #define PAGE_OFFSET          (UL(0xffffffffffffffff) - \
> >       (UL(1) << (VA_BITS - 1)) + 1)
> >  #define KIMAGE_VADDR         (MODULES_END)
> > +#define BPF_JIT_REGION_START (VA_START + KASAN_SHADOW_SIZE)
> > +#define BPF_JIT_REGION_SIZE  (SZ_128M)
> > +#define BPF_JIT_REGION_END   (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
> >  #define MODULES_END          (MODULES_VADDR + MODULES_VSIZE)
> > -#define MODULES_VADDR                (VA_START + KASAN_SHADOW_SIZE)
> > +#define MODULES_VADDR                (BPF_JIT_REGION_END)
> >  #define MODULES_VSIZE                (SZ_128M)
> >  #define VMEMMAP_START                (PAGE_OFFSET - VMEMMAP_SIZE)
> >  #define PCI_IO_END           (VMEMMAP_START - SZ_2M)
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index a6fdaea07c63..76c2ab40c02d 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >                                          tmp : orig_prog);
> >       return prog;
> >  }
> > +
> > +void *bpf_jit_alloc_exec(unsigned long size)
> > +{
> > +     return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
> > +                                 BPF_JIT_REGION_END, GFP_KERNEL,
> > +                                 PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
> > +                                 __builtin_return_address(0));
>
> I guess we'll want VM_IMMEDIATE_UNMAP here if Rich gets that merged.

I think akpm already queued up that patch.

> In the
> meantime, I wonder if it's worth zeroing the region in bpf_jit_free_exec()?
> (although we'd need the size information...).
>

Not sure. What exactly would that achieve?
