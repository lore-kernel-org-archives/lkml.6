Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033878AbeBOUDK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033802AbeBOUDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:03:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36171217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x227daxZ6g6nwGOK2I/d3rrZnl554bA/0BtsjObwbq6A7y6ZHQWW4TDFwgjAvI2dH0pp7oHle/f+0URWE9XFNOzc=
MIME-Version: 1.0
In-Reply-To: <20180215163602.61162-5-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com> <20180215163602.61162-5-namit@vmware.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 15 Feb 2018 20:02:47 +0000
X-Gmail-Original-Message-ID: <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
Message-ID: <CALCETrUY4uZeG2fz=OQWGuyCOcBBNbep6TaJz82CZSP89=g3-A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
To: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 4:36 PM, Nadav Amit <namit@vmware.com> wrote:
> Based on the understanding that there should be no way for userspace to
> address the kernel-space from compatibility mode, disable it while
> running in compatibility mode as long as the 64-bit code segment of the
> user is not used.
>
> Reenabling PTI is performed by restoring NX-bits to the userspace
> mappings, flushing the TLBs, and notifying all the CPUs that use the
> affected mm to disable PTI. Each core responds by removing the present
> bit for the 64-bit code-segment, and marking that PTI is disabled on
> that core.
>

I dislike this patch because it's conflating two things.  The patch
claims to merely disable PTI for compat tasks, whatever those are.
But it's also introducing a much stronger concept of what a compat
task is.  The kernel currently mostly doesn't care whether a task is
"compat" or not, and I think that most remaining code paths that do
care are buggy and should be removed.

I think the right way to approach this is to add a new arch_prctl()
that changes allowable bitness, like this:

arch_prctl(ARCH_SET_ALLOWED_GDT_CS, X86_ALLOW_CS32 | X86_ALLOW_CS64);

this would set the current task to work the normal way, where 32-bit
and 64-bit CS are available.  You could set just X86_ALLOW_CS32 to
deny 64-bit mode and just X86_ALLOW_CS64 to deny 32-bit mode.  This
would make nice attack surface reduction tools for the more paranoid
sandbox users to use.  Doing arch_prctl(ARCH_SET_ALLOWED_GDT_CS, 0)
would return -EINVAL.

A separate patch would turn PTI off if you set X86_ALLOW_CS32.

This has the downside that old code doesn't get the benefit without
some code change, but that's not the end of the world.

> +static void pti_cpu_update_func(void *info)
> +{
> +       struct mm_struct *mm = (struct mm_struct *)info;
> +
> +       if (mm != this_cpu_read(cpu_tlbstate.loaded_mm))
> +               return;
> +
> +       /*
> +        * Keep CS64 and CPU settings in sync despite potential concurrent
> +        * updates.
> +        */
> +       set_cpu_pti_disable(READ_ONCE(mm->context.pti_disable));
> +}

I don't like this at all.  IMO a sane implementation should never
change PTI status on a remote CPU.  Just track it per task.

> +void __pti_reenable(void)
> +{
> +       struct mm_struct *mm = current->mm;
> +       int cpu;
> +
> +       if (!mm_pti_disable(mm))
> +               return;
> +
> +       /*
> +        * Prevent spurious page-fault storm while we set the NX-bit and have
> +        * yet not updated the per-CPU pti_disable flag.
> +        */
> +       down_write(&mm->mmap_sem);
> +
> +       if (!mm_pti_disable(mm))
> +               goto out;
> +
> +       /*
> +        * First, mark the PTI is enabled. Although we do anything yet, we are
> +        * safe as long as we do not reenable CS64. Since we did not update the
> +        * page tables yet, this may lead to spurious page-faults, but we need
> +        * the pti_disable in mm to be set for __pti_set_user_pgd() to do the
> +        * right thing.  Holding mmap_sem would ensure matter we hold the
> +        * mmap_sem to prevent them from swamping the system.
> +        */
> +       mm->context.pti_disable = PTI_DISABLE_OFF;
> +
> +       /* Second, restore the NX bits. */
> +       pti_update_user_pgds(mm, true);

You're holding mmap_sem, but there are code paths that touch page
tables that don't hold mmap_sem, such as the stack extension code.

> +
> +bool pti_handle_segment_not_present(long error_code)
> +{
> +       if (!static_cpu_has(X86_FEATURE_PTI))
> +               return false;
> +
> +       if ((unsigned short)error_code != GDT_ENTRY_DEFAULT_USER_CS << 3)
> +               return false;
> +
> +       pti_reenable();
> +       return true;
> +}

Please don't.  You're trying to emulate the old behavior here, but
you're emulating it wrong.  In particular, you won't trap on LAR.
