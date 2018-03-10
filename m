Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeCJIWy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:22:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34231 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:22:53 -0500
X-Google-Smtp-Source: AG47ELvUA/nNLtLKCkeS8isvlZhjTjn3NF8k8DLQfrVtP7BKnIsWB7j1XGtQI5BCmJr0Aclc0VBEkQ==
Date: Sat, 10 Mar 2018 09:22:48 +0100
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
Subject: Re: [RFC PATCH -tip 8/9] error-injection: Fix to not enabling
 preemption in pre_handler
Message-ID: <20180310082248.6inyi5rcxhay2e6v@gmail.com>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
 <152059915597.4214.4086303893931787678.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152059915597.4214.4086303893931787678.stgit@devbox>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since kprobes pre_handler doesn't need to recover preemption
> even if it modifies regs->ip anymore, this fixes to remove
> the preempt_enable_no_resched() from pre_handler.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/fail_function.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 21b0122cb39c..b1713521f096 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -176,7 +176,6 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
>  		override_function_with_return(regs);
>  		/* Kprobe specific fixup */
>  		reset_current_kprobe();
> -		preempt_enable_no_resched();
>  		return 1;
>  	}

So where did the matching preempt_disable() get removed? If it's the 6/9 patch, 
then this patch (and 8/9) should very much be part of it.

There should be no bisection breakage in the series.

Thanks,

	Ingo
