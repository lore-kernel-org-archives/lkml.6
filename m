Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7379BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EA8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EA8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933374AbeGJNGK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:06:10 -0400
Received: from foss.arm.com ([217.140.101.70]:46104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbeGJNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:06:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1FBDED1;
        Tue, 10 Jul 2018 06:06:08 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2F963F5A0;
        Tue, 10 Jul 2018 06:06:08 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 874B11AE53F1; Tue, 10 Jul 2018 14:06:50 +0100 (BST)
Date:   Tue, 10 Jul 2018 14:06:50 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nikunj Kela <nkela@cisco.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        xe-kernel@external.cisco.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: add ARM64-specific support for flatmem
Message-ID: <20180710130650.GD31318@arm.com>
References: <20180706174724.44594-1-nkela@cisco.com>
 <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Op6DudVf--n4u_qimcvJf19OkbdzGm6ak=nB44oZEGQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jul 10, 2018 at 02:55:41PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 6, 2018 at 7:47 PM, Nikunj Kela <nkela@cisco.com> wrote:
> > Flatmem is useful in reducing kernel memory usage.
> > One usecase is in kdump kernel. We are able to save
> > ~14M by moving to flatmem scheme.
> >
> > Cc: xe-kernel@external.cisco.com
> > Cc: Nikunj Kela <nkela@cisco.com>
> > Signed-off-by: Nikunj Kela <nkela@cisco.com>
> > ---
> >  arch/arm64/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 42c090c..f5b4c49 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -775,6 +775,9 @@ config ARCH_SPARSEMEM_DEFAULT
> >  config ARCH_SELECT_MEMORY_MODEL
> >         def_bool ARCH_SPARSEMEM_ENABLE
> >
> > +config ARCH_FLATMEM_ENABLE
> > +       def_bool y
> > +
> >  config HAVE_ARCH_PFN_VALID
> >         def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> >
> 
> I'm getting hundreds of errors in randconfig builds with this:

Damn, I was worried something like this might happen. Sorry!

Does randconfig also fuzz CONFIG_EXPERT? We only added ARCH_FLATMEM_ENABLE
so that people can hand-configure crashkernels to make them small; there will
be plenty of situations where it's just going to cause more problems than it
solves, so I'd be happy hiding it behind EXPERT if it helps.

Otherwise we can probably through a 'def_bool !NUMA' at it.

Will

> + /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld
> -EB -maarch64elfb --no-undefined -X -pie -shared -Bsymbolic
> --no-apply-dynamic-relocs --build-id -o .tmp_vmlinux1 -T
> ./arch/arm64/kernel/vmlinux.lds --whole-archive built-in.a
> --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a
> --end-group
> init/do_mounts.o: In function `mount_block_root':
> do_mounts.c:(.init.text+0x1e8): undefined reference to `mem_map'
> /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
> init/do_mounts.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol
> `mem_map' which may bind externally can not be used when making a
> shared object; recompile with -fPIC
> do_mounts.c:(.init.text+0x1e8): dangerous relocation: unsupported relocation
> do_mounts.c:(.init.text+0x1f4): undefined reference to `mem_map'
> arch/arm64/kernel/vdso.o: In function `vdso_init':
> vdso.c:(.init.text+0xb4): undefined reference to `mem_map'
> /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
> arch/arm64/kernel/vdso.o: relocation R_AARCH64_ADR_PREL_PG_HI21
> against symbol `mem_map' which may bind externally can not be used
> when making a shared object; recompile with -fPIC
> vdso.c:(.init.text+0xb4): dangerous relocation: unsupported relocation
> vdso.c:(.init.text+0xbc): undefined reference to `mem_map'
> vdso.c:(.init.text+0xec): undefined reference to `mem_map'
> arch/arm64/kernel/insn.o:insn.c:(.text+0x2ec): more undefined
> references to `mem_map' follow
> /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld:
> arch/arm64/kernel/insn.o: relocation R_AARCH64_ADR_PREL_PG_HI21
> against symbol `mem_map' which may bind externally can not be used
> when making a shared object; recompile with -fPIC
> 
> The problem seems to be that CONFIG_NUMA is enabled in my
> build, so mem_map[] is not defined anywhere.
> 
>      Arnd
