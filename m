Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeEaUOV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754293AbeEaUOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:14:20 -0400
X-Google-Smtp-Source: ADUXVKJ9CfigzVIKMwZRC/8Fvg/QFxMoc2CpE8/NxrVSFyrwmF8lZhEzS1WTA9mVxTPKgH2HOm2lRwIXblXULZDrP3s=
MIME-Version: 1.0
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com> <1527789525-8857-2-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1527789525-8857-2-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 31 May 2018 13:14:06 -0700
X-Gmail-Original-Message-ID: <CALCETrXp5at9nQgz0x9TZOpajDGfbMhQXM-igBFjrQGJ_w_Wsg@mail.gmail.com>
Message-ID: <CALCETrXp5at9nQgz0x9TZOpajDGfbMhQXM-igBFjrQGJ_w_Wsg@mail.gmail.com>
Subject: Re: [PATCH V2 01/15] x86/fsgsbase/64: Introduce FS/GS base helper functions
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:58 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> With new helpers, FS/GS base access is centralized.
> Eventually, when FSGSBASE instruction enabled, it will
> be faster.
>
> The helpers are used on ptrace APIs (PTRACE_ARCH_PRCTL,
> PTRACE_SETREG, PTRACE_GETREG, etc). Idea is to keep
> the FS/GS-update mechanism organized.
>
> Notion of "active" and "inactive" are used to distinguish
> GS bases between "kernel" and "user". "inactive" GS base
> is the GS base, backed up at kernel entries, of inactive
> (user) task's.

I'm fine with the code, but the changelog entry is confusing.  A bunch
of the active helpers don't contain the term "active".

> +/*
> + * Read/write an (inactive) task's fsbase or gsbase. This returns
> + * the value that the FS/GS base would have (if the task were to be
> + * resumed). The current task is also supported.
> + */

Please change to "Read/write a task's fsbase or gsbase. ... These work
on current or on a different non-running task."

> +
> +unsigned long read_task_fsbase(struct task_struct *task)
> +{
> +       unsigned long fsbase;
> +
> +       if (task == current)
> +               fsbase = read_fsbase();
> +       else
> +               /*
> +                * XXX: This will not behave as expected if called
> +                * if fsindex != 0
> +                */
> +               fsbase = task->thread.fsbase;
> +

Please put braces around the if and else blocks whenever either of
them spans multiple lines.  Also, maybe change add a note to the
comment and/or the changelog that this is preserving an existing bug
and that it's fixed later in the series.
