Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeCVSz1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:55:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44927 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCVSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:55:26 -0400
X-Google-Smtp-Source: AG47ELthxRNzHh1fmuxUCczhx5CZEPLsK6uK5UoWpWesuXnkUZb4fYrhxHxQ5gTCwzZs0yPn3O+IQQ==
Date: Thu, 22 Mar 2018 11:55:24 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, ard.biesheuvel@linaro.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: Clang build of arm64 kernel fails
Message-ID: <20180322185524.GA78232@google.com>
References: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
 <d601e0ca-dd91-3dd4-c610-dd2ae49aa1b6@arm.com>
 <20180301103100.GE32331@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301103100.GE32331@e103592.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, Mar 01, 2018 at 10:31:02AM +0000 Dave Martin ha dit:

> On Thu, Mar 01, 2018 at 09:45:24AM +0000, Robin Murphy wrote:
> > Hi Andrey,
> > 
> > On 28/02/18 19:32, Andrey Konovalov wrote:
> > >Hi Marc!
> > >
> > >I've tried to pull in new upstream commits and the kernel build
> > >started failing for me with the following errors (see below).
> > >
> > >It seems that the reason is your commit "arm64: Add
> > >ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
> > >doesn't like 32 bits registers being used in 64 bits build.
> > 
> > I'd say this is really a bug in Clang. Architecturally, the register in
> > AArch64 state is still named "r0"; "x0"/"w0" are assembler operands which
> > additionally encode the size of the corresponding *access* to r0.
> > 
> > I note that GCC's documentation on register variables[1] does just say "the
> > name of the register", which implies this code is not incorrect. Given that
> > Clang already likes to infer the operand size from the argument type in
> > actual inline asms, it seems funny that its register allocator should care
> > in this non-instruction context.
> 
> +1
> 
> rN is perfectly reasonable here and has always been supported by GCC for
> AArch64 AFAIK.
> 
> (IMHO rN is preferable, because this separates the register allocation
> specification from how that register is used to encode the data type --
> GCC has no choice about the latter, but using "w"/"x" gives the
> misleading impression of control over this.)
> 
> > >Would you mind sending a fix?
> > 
> > That said, I guess it's a bug we might have to work around anyway. Oh well.
> 
> It would be preferable to see evidence of the llvm community committing
> to fix this before we consider merging a bodge into Linux for it.
> 
> Although this one issue is easy-ish to work around, we're on a slippery
> slope towards allowing the LLVM and GCC inline assemblers to diverge if
> we don't push back on worthless incompatibilities.

For the record, a LLVM bug was opened to add support for the rN names
in constraints: https://bugs.llvm.org/show_bug.cgi?id=36862 . I know
Manoj intends to submit a fix once the scope has been clarified.

I plan to send a kernel fix soon, unless someone beats me to it.

Matthias
