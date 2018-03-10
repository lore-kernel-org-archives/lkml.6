Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeCJIYu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:24:50 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42529 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:24:48 -0500
X-Google-Smtp-Source: AG47ELv4B+wnXfDb8qUqR/nwvujkYi6c2I7OKp0hIYFwInmWiFLcGiAtTiNLgMevigEdWtVXsveYVw==
Date: Sat, 10 Mar 2018 09:24:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH -tip 0/9] kprobes: Cleanup jprobe implementation
Message-ID: <20180310082444.uiy7fdqlxh6qbuwp@gmail.com>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152059891712.4214.9539716544254881611.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> Since we decided to remove jprobe from kernel last year,
> its APIs are disabled and we worked on moving in-kernel
> jprobe users to kprobes or trace-events. And now no jprobe
> users are here anymore.
> 
> I think it is good time to get rid of jprobe implementation
> from the kernel. However, I need other arch developers help
> to complete it, since jprobe is implemented multi arch wide.
> I can remove those code, but can not test all of those.
> 
> Here is the series of patches to show how to do that.
> I tried to remove it from x86 tree. Basically we need to
> do 3 things;
> 
>  - Remove jprobe functions (register/unregister,
>    setjump/longjump) from generic/arch-dependent code.
>    [1/9][2/9][3/9]
>  - Remove break_handler related code.
>    [4/9][5/9][6/9]
>  - Do not disable preemption on exception handler
>    [7/9][8/9][9/9]
> 
> The [3/9] and [6/9] are destractive changes except for x86
> (means causes build errors) since those arch still have some
> references of those functions. So we need to write patches
> similar to [2/9] and [5/9] for each arch before applying those.
> In this series I sorted it as this order just for review,
> [3/9] and [6/9] should be applied after all archs have
> been fixed.
> 
> Also, [7/9] is a kind of destractive, which changes required
> behavior for the pre_handlers which changes regs->ip.
> So we also need a patch similar to [7/9] for each arch too.
> Fortunately, current in-tree such user is very limited, both
> works only on x86. So it is not hurry, but we need to change
> arch dependent code.
>
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (9):
>       kprobes: Remove jprobe API implementation
>       x86: kprobes: Remove jprobe implementation
>       kprobes: Remove jprobe data structure and interfaces
>       kprobes: Ignore break_handler
>       x86: kprobes: Ignore break_handler
>       kprobes: Remove break_handler from struct kprobe
>       x86: kprobes: Do not disable preempt on int3 path
>       error-injection: Fix to not enabling preemption in pre_handler
>       tracing: kprobes: Fix to not enabling preemption
> 
> 
>  Documentation/kprobes.txt        |   13 ++--
>  arch/x86/include/asm/kprobes.h   |    3 -
>  arch/x86/kernel/kprobes/common.h |   10 ---
>  arch/x86/kernel/kprobes/core.c   |  114 ++------------------------------------
>  arch/x86/kernel/kprobes/ftrace.c |   21 +------
>  arch/x86/kernel/kprobes/opt.c    |    1 
>  include/linux/kprobes.h          |   54 ------------------
>  kernel/fail_function.c           |    1 
>  kernel/kprobes.c                 |  115 ++------------------------------------
>  kernel/trace/trace_kprobe.c      |    3 -
>  10 files changed, 20 insertions(+), 315 deletions(-)

Nice work, and I love the diffstat, but please do a series that works (builds and 
boots and has working kprobes) at every interim step.

Thanks,

	Ingo
