Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6B02147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfAGV2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfAGV2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:28:37 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4C32087F;
        Mon,  7 Jan 2019 21:28:35 +0000 (UTC)
Date:   Mon, 7 Jan 2019 16:28:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kprobes: Fix kretprobe incorrect stacking order
 problem
Message-ID: <20190107162833.1e034fc7@gandalf.local.home>
In-Reply-To: <20190107211904.GC5966@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
        <20190107183444.GA5966@xps-13>
        <20190107142749.34231bb6@gandalf.local.home>
        <20190107195209.GB5966@xps-13>
        <20190107145918.407b851b@gandalf.local.home>
        <20190107211904.GC5966@xps-13>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 22:19:04 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> > > If we put a kretprobe to raw_spin_lock_irqsave() it looks like
> > > kretprobe is going to call kretprobe...  
> > 
> > Right, but we should be able to add some recursion protection to stop
> > that. I have similar protection in the ftrace code.  
> 
> If we assume that __raw_spin_lock/unlock*() are always inlined a

I wouldn't assume that.

> possible way to prevent this recursion could be to use directly those
> functions to do locking from the kretprobe trampoline.
> 
> But I'm not sure if that's a safe assumption... if not I'll see if I can
> find a better solution.

All you need to do is have a per_cpu variable, where you just do:

	preempt_disable_notrace();
	if (this_cpu_read(kprobe_recursion))
		goto out;
	this_cpu_inc(kprobe_recursion);
	[...]
	this_cpu_dec(kprobe_recursion);
out:
	preempt_enable_notrace();

And then just ignore any kprobes that trigger while you are processing
the current kprobe.

Something like that. If you want (or if it already happens) replace
preempt_disable() with local_irq_save().

-- Steve

> 
> Thanks,
> 
> From: Andrea Righi <righi.andrea@gmail.com>
> Subject: [PATCH] kprobes: prevent recursion deadlock with kretprobe and
>  spinlocks
> 
> kretprobe_trampoline() is using a spinlock to protect the hash of
> kretprobes. Adding a kretprobe to the spinlock functions may cause
> a recursion deadlock where kretprobe is calling itself:
> 
>  kretprobe_trampoline()
>    -> trampoline_handler()
>      -> kretprobe_hash_lock()
>        -> raw_spin_lock_irqsave()
>          -> _raw_spin_lock_irqsave()  
>  kretprobe_trampoline from _raw_spin_lock_irqsave => DEADLOCK
> 
>  kretprobe_trampoline()
>    -> trampoline_handler()
>      -> recycle_rp_inst()
>        -> raw_spin_lock()
>          -> _raw_spin_lock()  
>  kretprobe_trampoline from _raw_spin_lock => DEADLOCK
> 
> Use the corresponding inlined spinlock functions to prevent this
> recursion.
> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> ---
>  kernel/kprobes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f4ddfdd2d07e..b89bef5e3d80 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1154,9 +1154,9 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
>  	hlist_del(&ri->hlist);
>  	INIT_HLIST_NODE(&ri->hlist);
>  	if (likely(rp)) {
> -		raw_spin_lock(&rp->lock);
> +		__raw_spin_lock(&rp->lock);
>  		hlist_add_head(&ri->hlist, &rp->free_instances);
> -		raw_spin_unlock(&rp->lock);
> +		__raw_spin_unlock(&rp->lock);
>  	} else
>  		/* Unregistering */
>  		hlist_add_head(&ri->hlist, head);
> @@ -1172,7 +1172,7 @@ __acquires(hlist_lock)
>  
>  	*head = &kretprobe_inst_table[hash];
>  	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	*flags = __raw_spin_lock_irqsave(hlist_lock);
>  }
>  NOKPROBE_SYMBOL(kretprobe_hash_lock);
>  
> @@ -1193,7 +1193,7 @@ __releases(hlist_lock)
>  	raw_spinlock_t *hlist_lock;
>  
>  	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_unlock_irqrestore(hlist_lock, *flags);
> +	__raw_spin_unlock_irqrestore(hlist_lock, *flags);
>  }
>  NOKPROBE_SYMBOL(kretprobe_hash_unlock);
>  

