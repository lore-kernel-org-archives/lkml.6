Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeC1KMr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:12:47 -0400
Received: from foss.arm.com ([217.140.101.70]:38988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbeC1KMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:12:46 -0400
Date: Wed, 28 Mar 2018 11:12:41 +0100
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
Message-ID: <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522229612.26617.47.camel@mtksdccf07>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 05:33:32PM +0800, Ji.Zhang wrote:
> On Mon, 2018-03-26 at 12:39 +0100, Mark Rutland wrote:
> > I think that it would be preferable to try to avoid the inifinite loop
> > case. We could hit that by accident if we're tracing a live task.
> > 
> > It's a little tricky to ensure that we don't loop, since we can have
> > traces that span several stacks, e.g. overflow -> irq -> task, so we
> > need to know where the last frame was, and we need to defnie a strict
> > order for stack nesting.
> Can we consider this through an easier way? According to AArch64 PCS,
> stack should be full-descending, which means we can add validation on fp
> by comparing the fp and previous fp, if they are equal means there is an
> exactly loop, while if current fp is smaller than previous means the
> uwnind is rollback, which is also unexpected. The only concern is how to
> handle the unwind from one stack span to another (eg. overflow->irq, or
> irq->task, etc)
> Below diff is a proposal that we check if stack spans, and if yes, a
> tricky is used to bypass the fp check.
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index eb2d151..760ea59 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -101,6 +101,7 @@ void dump_backtrace(struct pt_regs *regs, struct
> task_struct *tsk)
>  {
>         struct stackframe frame;
>         int skip;
> +       unsigned long fp = 0x0;
> 
>         pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
> 
> @@ -127,6 +128,20 @@ void dump_backtrace(struct pt_regs *regs, struct
> task_struct *tsk)
>         skip = !!regs;
>         printk("Call trace:\n");
>         do {
> +               unsigned long stack;
> +               if (fp) {
> +                       if (in_entry_text(frame.pc)) {
> +                               stack = frame.fp - offsetof(struct
> pt_regs, stackframe);
> +
> +                               if (on_accessible_stack(tsk, stack))
> +                                       fp = frame.fp + 0x8; //tricky to
> bypass the fp check
> +                       }
> +                       if (fp <= frame->fp) {
> +                               pr_notice("fp invalid, stop unwind\n");
> +                               break;
> +                       }
> +               }
> +               fp = frame.fp;

I'm very much not keen on this.

I think that if we're going to do this, the only sane way to do it is to
have unwind_frame() verify the current fp against the previous one, and
verify that we have some strict nesting of stacks. Generally, that means
we can go:

  overflow -> irq -> task

... though I'm not sure what to do about the SDEI stack vs the overflow
stack.

Thanks,
Mark.
