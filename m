Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeDDJFC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:05:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDDJEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:04:44 -0400
Date: Wed, 4 Apr 2018 10:04:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Ji.Zhang" <ji.zhang@mediatek.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, shadanji@163.com
Subject: Re: [PATCH] arm64: avoid race condition issue in dump_backtrace
Message-ID: <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
 <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
 <1522397292.26617.63.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522397292.26617.63.camel@mtksdccf07>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 04:08:12PM +0800, Ji.Zhang wrote:
> On Wed, 2018-03-28 at 11:12 +0100, Mark Rutland wrote:
> > On Wed, Mar 28, 2018 at 05:33:32PM +0800, Ji.Zhang wrote:
> > 
> > I'm very much not keen on this.
> > 
> > I think that if we're going to do this, the only sane way to do it is to
> > have unwind_frame() verify the current fp against the previous one, and
> > verify that we have some strict nesting of stacks. Generally, that means
> > we can go:
> > 
> >   overflow -> irq -> task
> > 
> > ... though I'm not sure what to do about the SDEI stack vs the overflow
> > stack.
> Actually I have had the fp check in unwind_frame(), but since I use the
> in_entry_text() to determine if stack spans, and I did not want to
> include traps.h in stacktrace.c, so I move the check out to
> dump_backtrace.
> Anyway, It seems that the key point is how should we verify that there
> are some nesting of stacks. Since in unwind_frame() we already have the
> previous fp and current fp, could we assume that if these two fps are
> NOT belong to the same stack, there should be stack spans (no matter
> task->irq, or irq->overflow, etc), and we can do the tricky to bypass
> the fp check.The sample of the prosal just like:

Unfortuantely, this still allows for loops, like task -> irq -> task, so
I think if we're going to try to fix this, we must define a nesting
order and check against that.

Thanks,
Mark.

> diff --git a/arch/arm64/include/asm/stacktrace.h
> b/arch/arm64/include/asm/stacktrace.h
> index 902f9ed..fc2bf4d 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -92,4 +92,18 @@ static inline bool on_accessible_stack(struct
> task_struct *tsk, unsigned long sp
>         return false;
>  }
> 
> +static inline bool on_same_stack(struct task_struct *tsk, unsigned long
> sp1, unsigned sp2)
> +{
> +       if (on_task_stack(tsk, sp1) && on_task_stack(tsk, sp2))
> +               return true;
> +       if (on_irq_stack(sp1) && on_irq_stack(sp2))
> +               return true;
> +       if (on_overflow_stack(sp1) && on_overflow_stack(sp2))
> +               return true;
> +       if (on_sdei_stack(sp1) && on_sdei_stack(sp2))
> +               return true;
> +
> +       return false;
> +}
> +
>  #endif /* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/kernel/stacktrace.c
> b/arch/arm64/kernel/stacktrace.c
> index d5718a0..4907a67 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -56,6 +56,13 @@ int notrace unwind_frame(struct task_struct *tsk,
> struct stackframe *frame)
>         frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
>         frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
> 
> +       if (!on_same_stack(fp, frame->fp))
> +               fp = frame->fp + 0x8;
> +       if (fp <= frame->fp) {
> +               pr_notice("fp invalid, stop unwind\n");
> +               return -EINVAL;
> +       }
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         if (tsk->ret_stack &&
>                         (frame->pc == (unsigned long)return_to_handler))
> {
> 
> Could this work?
> 
> Best Regards,
> Ji
> 
