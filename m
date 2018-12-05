Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD16C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E9206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544053265;
	bh=F6lCC3XqEasS4ZuYpSk/DN6ZGVwC5Ditn89Kt38xFo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JdMTH013NEJTg6loYmK/V9yyBV22kpDD30iMdEr9k8EpVTYBtSp6XqsnQvtYhoh/Z
	 m3QUuj+nb4i6UhlndfO4zXwx1bscS7XU/OVVVts1ZcoAHivvuV59/9KSvIaHzwYke2
	 BiYRaftVpHO/KJ+8KbxpXK2pAlIl1B70e/03S+Js=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744E9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeLEXlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbeLEXlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:41:03 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56E1214C1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544053262;
        bh=F6lCC3XqEasS4ZuYpSk/DN6ZGVwC5Ditn89Kt38xFo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b783H/wXsb0E5azHeIQ/OUYBucz8YV5GG1Jziz7qYDzxP99jodZhRy6KFTzUK1Jr5
         uo80Dv1uf3Ze01zYtDAMfX1sl93+UuZqQmtnmK4JnfUJY7FuOzFf11GfdkPDIyfneO
         txL8rRjQoOkKr9ep0IExnGbXtEhqzcFajva+rYYU=
Received: by mail-wr1-f49.google.com with SMTP id l9so21436870wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:41:01 -0800 (PST)
X-Gm-Message-State: AA+aEWbRFSeo0DxhclbVdMeDC7Q+RtM5Xedso3bptRSFZskvnzHMF2r+
        BfoZsvpgUuN+TQHRBbGsG2/wgMZm5yhWJmjZ875C7Q==
X-Google-Smtp-Source: AFSGD/W2FtDsFEzHD6ZejaKdq6tTyHxPRCkJxHS70gjlGXzqpLA95NLgAcfZV5tFvzxNFxNtS/9DwOwu3tFKh94YMJw=
X-Received: by 2002:a5d:5502:: with SMTP id b2mr24123627wrv.330.1544053260314;
 Wed, 05 Dec 2018 15:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20181205232012.28920-1-sean.j.christopherson@intel.com> <20181205232012.28920-5-sean.j.christopherson@intel.com>
In-Reply-To: <20181205232012.28920-5-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Dec 2018 15:40:48 -0800
X-Gmail-Original-Message-ID: <CALCETrXNvbhMnitCiydoSweEr92RaA2fKrFQjCdeg+--u-TeuA@mail.gmail.com>
Message-ID: <CALCETrXNvbhMnitCiydoSweEr92RaA2fKrFQjCdeg+--u-TeuA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/vdso: Add __vdso_sgx_eenter() to wrap SGX
 enclave transitions
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:20 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Intel Software Guard Extensions (SGX) SGX introduces a new CPL3-only
> enclave mode that runs as a sort of black box shared object that is
> hosted by an untrusted normal CPL3 process.
>
> Enclave transitions have semantics that are a lovely blend of SYCSALL,
> SYSRET and VM-Exit.  In a non-faulting scenario, entering and exiting
> an enclave can only be done through SGX-specific instructions, EENTER
> and EEXIT respectively.  EENTER+EEXIT is analogous to SYSCALL+SYSRET,
> e.g. EENTER/SYSCALL load RCX with the next RIP and EEXIT/SYSRET load
> RIP from R{B,C}X.
>
> But in a faulting/interrupting scenario, enclave transitions act more
> like VM-Exit and VMRESUME.  Maintaining the black box nature of the
> enclave means that hardware must automatically switch CPU context when
> an Asynchronous Exiting Event (AEE) occurs, an AEE being any interrupt
> or exception (exceptions are AEEs because asynchronous in this context
> is relative to the enclave and not CPU execution, e.g. the enclave
> doesn't get an opportunity to save/fuzz CPU state).
>
> Like VM-Exits, all AEEs jump to a common location, referred to as the
> Asynchronous Exiting Point (AEP).  The AEP is specified at enclave entry
> via register passed to EENTER/ERESUME, similar to how the hypervisor
> specifies the VM-Exit point (via VMCS.HOST_RIP at VMLAUNCH/VMRESUME).
> Resuming the enclave/VM after the exiting event is handled is done via
> ERESUME/VMRESUME respectively.  In SGX, AEEs that are handled by the
> kernel, e.g. INTR, NMI and most page faults, IRET will journey back to
> the AEP which then ERESUMEs th enclave.
>
> Enclaves also behave a bit like VMs in the sense that they can generate
> exceptions as part of their normal operation that for all intents and
> purposes need to handled in the enclave/VM.  However, unlike VMX, SGX
> doesn't allow the host to modify its guest's, a.k.a. enclave's, state,
> as doing so would circumvent the enclave's security.  So to handle an
> exception, the enclave must first be re-entered through the normal
> EENTER flow (SYSCALL/SYSRET behavior), and then resumed via ERESUME
> (VMRESUME behavior) after the source of the exception is resolved.
>
> All of the above is just the tip of the iceberg when it comes to running
> an enclave.  But, SGX was designed in such a way that the host process
> can utilize a library to build, launch and run an enclave.  This is
> roughly analogous to how e.g. libc implementations are used by most
> applications so that the application can focus on its business logic.
>
> The big gotcha is that because enclaves can generate *and* handle
> exceptions, any SGX library must be prepared to handle nearly any
> exception at any time (well, any time a thread is executing in an
> enclave).  In Linux, this means the SGX library must register a
> signal handler in order to intercept relevant exceptions and forward
> them to the enclave (or in some cases, take action on behalf of the
> enclave).  Unfortunately, Linux's signal mechanism doesn't mesh well
> with libraries, e.g. signal handlers are process wide, are difficult
> to chain, etc...  This becomes particularly nasty when using multiple
> levels of libraries that register signal handlers, e.g. running an
> enclave via cgo inside of the Go runtime.
>
> In comes vDSO to save the day.  Now that vDSO can fixup exceptions,
> add a function to wrap enclave transitions and intercept any exceptions
> that occur in the enclave or on EENTER/ERESUME.  The actually code is
> blissfully short (especially compared to this changelog).
>
> In addition to the obvious trapnr, error_code and address, propagate
> the leaf number, i.e. RAX, back to userspace so that the caller can know
> whether the fault occurred in the enclave or if it occurred on EENTER.
> A fault on EENTER generally means the enclave has died and needs to be
> restarted.
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/entry/vdso/Makefile      |   1 +
>  arch/x86/entry/vdso/vdso.lds.S    |   1 +
>  arch/x86/entry/vdso/vsgx_eenter.c | 108 ++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 arch/x86/entry/vdso/vsgx_eenter.c
>
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index eb543ee1bcec..ba46673076bd 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -18,6 +18,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)       := y
>
>  # files to link into the vdso
>  vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
> +vobjs-$(VDSO64-y)              += vsgx_eenter.o
>
>  # files to link into kernel
>  obj-y                          += vma.o extable.o
> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> index d3a2dce4cfa9..e422c4454f34 100644
> --- a/arch/x86/entry/vdso/vdso.lds.S
> +++ b/arch/x86/entry/vdso/vdso.lds.S
> @@ -25,6 +25,7 @@ VERSION {
>                 __vdso_getcpu;
>                 time;
>                 __vdso_time;
> +               __vdso_sgx_eenter;
>         local: *;
>         };
>  }
> diff --git a/arch/x86/entry/vdso/vsgx_eenter.c b/arch/x86/entry/vdso/vsgx_eenter.c
> new file mode 100644
> index 000000000000..3df4a95a34cc
> --- /dev/null
> +++ b/arch/x86/entry/vdso/vsgx_eenter.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2018 Intel Corporation.
> +
> +#include <uapi/linux/errno.h>
> +#include <uapi/linux/types.h>
> +
> +#include "extable.h"
> +
> +/*
> + * This struct will be defined elsewhere in the actual implementation,
> + * e.g. arch/x86/include/uapi/asm/sgx.h.
> + */
> +struct sgx_eenter_fault_info {
> +       __u32   leaf;
> +       __u16   trapnr;
> +       __u16   error_code;
> +       __u64   address;
> +};
> +
> +/*
> + * ENCLU (ENCLave User) is an umbrella instruction for a variety of CPL3
> + * SGX functions,  The ENCLU function that is executed is specified in EAX,
> + * with each function potentially having more leaf-specific operands beyond
> + * EAX.  In the vDSO we're only concerned with the leafs that are used to
> + * transition to/from the enclave.
> + */
> +enum sgx_enclu_leaves {
> +       SGX_EENTER      = 2,
> +       SGX_ERESUME     = 3,
> +       SGX_EEXIT       = 4,
> +};
> +
> +notrace long __vdso_sgx_eenter(void *tcs, void *priv,
> +                              struct sgx_eenter_fault_info *fault_info)
> +{
> +       u32 trapnr, error_code;
> +       long leaf;
> +       u64 addr;
> +
> +       /*
> +        *      %eax = EENTER
> +        *      %rbx = tcs
> +        *      %rcx = do_eresume
> +        *      %rdi = priv
> +        * do_eenter:
> +        *      enclu
> +        *      jmp     out
> +        *
> +        * do_eresume:
> +        *      enclu
> +        *      ud2

Is the only reason for do_eresume to be different from do_eenter so
that you can do the ud2?

> +        *
> +        * out:
> +        *      <return to C code>
> +        *
> +        * fault_fixup:
> +        *      <extable loads RDI, DSI and RDX with fault info>
> +        *      jmp     out
> +        */

This has the IMO excellent property that it's extremely awkward to use
it for a model where the enclave is reentrant.  I think it's excellent
because reentrancy on the same enclave thread is just asking for
severe bugs.  Of course, I fully expect the SDK to emulate reentrancy,
but then it's 100% their problem :)  On the fiip side, it means that
you can't really recover from a reported fault, even if you want to,
because there's no way to ask for ERESUME.  So maybe the API should
allow that after all.

I think it might be polite to at least give some out regs, maybe RSI and RDI?
