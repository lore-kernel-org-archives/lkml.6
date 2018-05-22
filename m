Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVNp7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:45:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51201 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEVNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:45:58 -0400
X-Google-Smtp-Source: AB8JxZqqDi+9G+FlOg56qgKVvHngcUDZU9SwvLJswe9tKjdpXHNvSMQ0wELGWVgM7WOrvqltttCwBVAUG6wwRwyvEdc=
MIME-Version: 1.0
In-Reply-To: <20180522035445.16911-2-boris.ostrovsky@oracle.com>
References: <20180522035445.16911-1-boris.ostrovsky@oracle.com> <20180522035445.16911-2-boris.ostrovsky@oracle.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 22 May 2018 09:45:57 -0400
Message-ID: <CAMzpN2iMrEqee+8yGP_qk-qAuXf+_o6vrOUSDTvX=8JAUDT5Fg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] xen/PVH: Set up GS segment for stack canary
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:54 PM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> We are making calls to C code (e.g. xen_prepare_pvh()) which may use
> stack canary (stored in GS segment).
>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>  arch/x86/xen/xen-pvh.S | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
> index e1a5fbe..0169374 100644
> --- a/arch/x86/xen/xen-pvh.S
> +++ b/arch/x86/xen/xen-pvh.S
> @@ -54,6 +54,9 @@
>   * charge of setting up it's own stack, GDT and IDT.
>   */
>
> +#define PVH_GDT_ENTRY_CANARY   4
> +#define PVH_CANARY_SEL         (PVH_GDT_ENTRY_CANARY * 8)
> +
>  ENTRY(pvh_start_xen)
>         cld
>
> @@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
>         /* 64-bit entry point. */
>         .code64
>  1:
> +       /* Set base address in stack canary descriptor. */
> +       mov $MSR_GS_BASE,%ecx
> +       mov $canary, %rax
> +       cdq
> +       wrmsr

CDQ only sign-extends EAX to RAX.  What you really want is to move the
high 32-bits to EDX (or zero EDX if we can guarantee it is loaded
below 4G).

--
Brian Gerst
