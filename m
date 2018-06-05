Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeFEBo2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeFEBo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:44:27 -0400
Date: Mon, 4 Jun 2018 21:44:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hoeun Ryu <hoeun.ryu@lge.com.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Hoeun Ryu <hoeun.ryu@lge.com>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] panic: move bust_spinlocks(0) after
 console_flush_on_panic() to avoid deadlocks
Message-ID: <20180604214423.3014dc63@vmware.local.home>
In-Reply-To: <1528091179-3015-1-git-send-email-hoeun.ryu@lge.com.com>
References: <1528091179-3015-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Jun 2018 14:45:57 +0900
Hoeun Ryu <hoeun.ryu@lge.com.com> wrote:

> From: Hoeun Ryu <hoeun.ryu@lge.com>
> 
>  Many console device drivers hold the uart_port->lock spinlock with irq enabled
> (using spin_lock()) while the device drivers are writing characters to their devices,
> but the device drivers just try to hold the spin lock (using spin_trylock()) if
> "oops_in_progress" is equal or greater than 1 to avoid deadlocks.
> 
>  There is a case ocurring a deadlock related to the lock and oops_in_progress. A CPU
> could be stopped by smp_send_stop() while it was holding the port lock because irq was
> enabled. Once a CPU stops, it doesn't respond interrupts anymore and the lock stays
> locked forever.
> 
>  console_flush_on_panic() is called during panic() and it eventually holds the uart
> lock but the lock is held by another stopped CPU and it is a deadlock. By moving
> bust_spinlocks(0) after console_flush_on_panic(), let the console device drivers
> think the Oops is still in progress to call spin_trylock() instead of spin_lock() to
> avoid the deadlock.
> 
> Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
> ---
>  kernel/panic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 42e4874..b4063b6 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -233,8 +233,6 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>  
> -	bust_spinlocks(0);
> -
>  	/*
>  	 * We may have ended up stopping the CPU holding the lock (in
>  	 * smp_send_stop()) while still having some valuable data in the console
> @@ -246,6 +244,8 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic();
>  
> +	bust_spinlocks(0);

Added a few more to Cc. This looks like it could have subtle
side-effects. I'd like those that have been touching the code around
here to have a look.

-- Steve


> +
>  	if (!panic_blink)
>  		panic_blink = no_blink;
>  
