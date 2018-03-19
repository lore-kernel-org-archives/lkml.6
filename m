Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971260AbeCSURc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:17:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54448 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969057AbeCSUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:17:26 -0400
Date: Mon, 19 Mar 2018 21:17:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] sched/debug: fix per-task line continuation for
 console
Message-ID: <20180319201723.GK4043@hirez.programming.kicks-ass.net>
References: <1521484555-8620-1-git-send-email-joe.lawrence@redhat.com>
 <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521484555-8620-2-git-send-email-joe.lawrence@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 02:35:54PM -0400, Joe Lawrence wrote:
> When the SEQ_printf() macro prints to the console, it runs a simple
> printk() without KERN_CONT "continued" line printing.  The result of
> this is oddly wrapped task info, for example:
> 
>   % echo t > /proc/sysrq-trigger
>   % dmesg
>   ...
>   runnable tasks:
>   ...
>   [   29.608611]  I
>   [   29.608613]       rcu_sched     8      3252.013846      4087   120
>   [   29.608614]         0.000000        29.090111         0.000000
>   [   29.608615]  0 0
>   [   29.608616]  /
> 
> Modify SEQ_printf to use pr_cont() for expected one-line results:
> 
>   % echo t > /proc/sysrq-trigger
>   % dmesg
>   ...
>   runnable tasks:
>   ...
>   [  106.716329]  S        cpuhp/5    37      2006.315026        14   120         0.000000         0.496893         0.000000 0 0 /
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  kernel/sched/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1ca0130ed4f9..50026aa2d81e 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -32,7 +32,7 @@
>  	if (m)					\
>  		seq_printf(m, x);		\
>  	else					\
> -		printk(x);			\
> +		pr_cont(x);			\

That used to work I think.. I think someone changed how printk() behaves
somewhere along the lines.

Does pr_cont("\n") DTRT? it seems like something weird.
