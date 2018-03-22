Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCVF7v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:59:51 -0400
Received: from foss.arm.com ([217.140.101.70]:33414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeCVF7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:59:50 -0400
Date: Thu, 22 Mar 2018 05:59:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ji Zhang <ji.zhang@mediatek.com>
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
Message-ID: <20180322055929.z25brvwlmdighz66@salmiak>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 11:06:00AM +0800, Ji Zhang wrote:
> When we dump the backtrace of some specific task, there is a potential race
> condition due to the task may be running on other cores if SMP enabled.
> That is because for current implementation, if the task is not the current
> task, we will get the registers used for unwind from cpu_context saved in
> thread_info, which is the snapshot before context switch, but if the task
> is running on other cores, the registers and the content of stack are
> changed.
> This may cause that we get the wrong backtrace or incomplete backtrace or
> even crash the kernel.

When do we call dump_backtrace() on a running task that is not current?

AFAICT, we don't do that in the arm64-specific callers of dump_backtrace(), and
this would have to be some caller of show_stack() in generic code.

We pin the task's stack via try_get_task_stack(), so this cannot be unmapped
while we walk it. In unwind_frame() we check that the frame record falls
entirely within the task's stack. So AFAICT, we cannot crash the kernel here,
though the backtrace may be misleading (and we could potentially get stuck in
an infinite loop).

> To avoid this case, do not dump the backtrace of the tasks which are
> running on other cores.
> This patch cannot solve the issue completely but can shrink the window of
> race condition.

> @@ -113,6 +113,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  	if (tsk == current) {
>  		frame.fp = (unsigned long)__builtin_frame_address(0);
>  		frame.pc = (unsigned long)dump_backtrace;
> +	else if (tsk->state == TASK_RUNNING) {
> +		pr_notice("Do not dump other running tasks\n");
> +		return;

As you note, if we can race with the task being scheduled, this doesn't help.

Can we rule this out at a higher level?

Thanks,
Mark.
