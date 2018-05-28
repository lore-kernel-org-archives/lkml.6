Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755760AbeE1T0R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 15:26:17 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46191 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755736AbeE1T0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 15:26:16 -0400
X-Google-Smtp-Source: AB8JxZqhj2LOzUW38jl+7YxrVHRGrXpOSDmgRCXHYr6Qoiqav0ilHMgOeIUBV2GDXwf4GksPA45y/7XwxIvx5mSrZIE=
MIME-Version: 1.0
In-Reply-To: <20180527223403.GT30522@ZenIV.linux.org.uk>
References: <20180527223403.GT30522@ZenIV.linux.org.uk>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 28 May 2018 21:25:55 +0200
X-Google-Sender-Auth: vrBCM9dC2E4YuituK73yNn9pNeM
Message-ID: <CA+7wUswhpVRQ4yECc-Zh9djHxiT=9-ALuP7_=mfLMtU-NXDnfg@mail.gmail.com>
Subject: Re: [PATCH][RFC] [powerpc] arch_ptrace() uses of access_ok() are pointless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SJQXk9023340

On Mon, May 28, 2018 at 12:34 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> make it use copy_{from,to}_user(), rather than access_ok() +
> __copy_...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/powerpc/kernel/ptrace.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index d23cf632edf0..d8b0fd2fa3aa 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3081,27 +3081,19 @@ long arch_ptrace(struct task_struct *child, long request,
>  #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
>
> -               if (!access_ok(VERIFY_WRITE, datavp,
> -                              sizeof(struct ppc_debug_info)))
> +               if (unlikely(copy_to_user(datavp, &dbginfo,
> +                                    sizeof(struct ppc_debug_info)))


Maybe this is just an RFC, but:

  CALL    ../arch/powerpc/kernel/systbl_chk.sh
../arch/powerpc/kernel/ptrace.c: In function ‘arch_ptrace’:
../arch/powerpc/kernel/ptrace.c:3086:4: error: expected ‘)’ before ‘return’
    return -EFAULT;
    ^~~~~~

Missing closing parenthesis.

>                         return -EFAULT;
> -               ret = __copy_to_user(datavp, &dbginfo,
> -                                    sizeof(struct ppc_debug_info)) ?
> -                     -EFAULT : 0;
> -               break;
> +               return 0;
>         }
>
>         case PPC_PTRACE_SETHWDEBUG: {
>                 struct ppc_hw_breakpoint bp_info;
>
> -               if (!access_ok(VERIFY_READ, datavp,
> -                              sizeof(struct ppc_hw_breakpoint)))
> -                       return -EFAULT;
> -               ret = __copy_from_user(&bp_info, datavp,
> -                                      sizeof(struct ppc_hw_breakpoint)) ?
> -                     -EFAULT : 0;
> -               if (!ret)
> -                       ret = ppc_set_hwdebug(child, &bp_info);
> -               break;
> +               if (unlikely(copy_from_user(&bp_info, datavp,
> +                                      sizeof(struct ppc_hw_breakpoint)))
> +                     return -EFAULT;
> +               return ppc_set_hwdebug(child, &bp_info);
>         }
>
>         case PPC_PTRACE_DELHWDEBUG: {
> --
> 2.11.0
>
