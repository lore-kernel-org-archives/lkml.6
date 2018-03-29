Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeC2Vl0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:41:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbeC2VlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:41:24 -0400
Date: Thu, 29 Mar 2018 23:41:20 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: replace TASK_UNINTERRUPTIBLE with TASK_KILLABLE
Message-ID: <20180329214116.GO26753@flask>
References: <20180316105729.ykomeftdvlzqm4p6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316105729.ykomeftdvlzqm4p6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 00:57-1000, Joey Pabalinas:
> There doesn't seem to be any advantage to having a *completely*
> uninterruptible task here. For most users, allowing a task to respond
> to the SIGKILL interrupt signal (all other signals are ignored just like
> TASK_UNINTERRUPTIBLE) will not impact them at all.
> 
> However, for the rare edge-cases where a task becomes stuck, maybe due to
> snapshot corruption or some other similarly unrecoverable error, it
> is *much* more convenient for a user to be able to have the additional
> option of nuking that task with SIGKILL, rather than annoying them by
> forcing them to reboot in order to remove the immortal process.
> 
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> 
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index bc1a27280c4bf77899..7d4faee962e0c2e3c1 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -154,8 +154,8 @@ void kvm_async_pf_task_wait(u32 token, int interrupt_kernel)
>  
>  	for (;;) {
>  		if (!n.halted)
> -			prepare_to_swait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
> -		if (hlist_unhashed(&n.link))
> +			prepare_to_swait(&n.wq, &wait, TASK_KILLABLE);

Makes sense, but it's not as easy:

> +		if (hlist_unhashed(&n.link) || fatal_signal_pending(current))

Removing the waiter from the list is currently waker's job, but the
entry is stack-allocated by waiter;  simply breaking there would cause
use after free on the waker's side.

We could take the lock again near the end of kvm_async_pf_task_wait to
remove the entry and use a variable (instead of hlist_unhashed) to
signal that the wakeup happened.

And there is another problem as well: If the waiting task is killed
before the wakeup arrives, the waker allocates a dummy entry that is not
going to be consumed by a future waiter, leading to a leak that could
potentially deplete the whole memory.

A solution to that could use a list of waiters that were killed before
the wakeup, so the normal working case wouldn't regress.

Doing that to handle snapshot corruption is definitely not worth it --
restoring from a snapshot should do apf_task_wake_all, so the corruption
would have to be very precise.

I remember we had a bug where tasks were getting stuck when running
nested and maybe there are going to be other cases to excuse the change.
I'm slightly against changing the behavior as it's pretty hard to test,
but I can be easily convinced with a well reasoned patch,

thanks!
