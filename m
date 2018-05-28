Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162386AbeE1OMt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:12:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162423AbeE1OMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:12:20 -0400
Date: Mon, 28 May 2018 15:12:19 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, akpm@linux-foundation.org,
        oleg@redhat.com
Subject: Re: [PATCH 3/8] signal: make may_ptrace_stop() return bool
Message-ID: <20180528141219.GZ30522@ZenIV.linux.org.uk>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-4-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528134916.7568-4-christian@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:49:11PM +0200, Christian Brauner wrote:
> may_ptrace_stop() already behaves like a boolean function. Let's actually
> declare it as such too.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
>  kernel/signal.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 81be01d193f4..6c2e7b45cba1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1889,10 +1889,10 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  	spin_unlock_irqrestore(&sighand->siglock, flags);
>  }
>  
> -static inline int may_ptrace_stop(void)
> +static inline bool may_ptrace_stop(void)
>  {
>  	if (!likely(current->ptrace))
> -		return 0;
> +		return false;
>  	/*
>  	 * Are we in the middle of do_coredump?
>  	 * If so and our tracer is also part of the coredump stopping
> @@ -1908,9 +1908,9 @@ static inline int may_ptrace_stop(void)
>  	 */
>  	if (unlikely(current->mm->core_state) &&
>  	    unlikely(current->mm == current->parent->mm))
> -		return 0;
> +		return false;
>  
> -	return 1;
> +	return true;

	return !current->mm->core_state || current->mm != current->parent->mm;

or, if it gives any measurably better code generation,

	return likely(!current->mm->core_state ||
			current->mm != current->parent->mm);
