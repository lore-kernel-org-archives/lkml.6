Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756500AbeEASqX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756398AbeEASqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:46:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92CE236F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 1 May 2018 14:46:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180501144620.1e832a09@gandalf.local.home>
In-Reply-To: <20171116161506.19691-1-npiggin@gmail.com>
References: <20171116161506.19691-1-npiggin@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2017 02:15:06 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> In local_irq_save and local_irq_restore, only call irq tracing when
> the flag state acutally changes. It is not unexpected for the state
> to go disable->disable.
> 
> This allows the irq tracing code to better track superfluous
> enables and disables, and in future could issue warnings. For the
> most part they are harmless, but they can indicate that the caller
> has lost track of its irq state.

I missed this before (that was a busy time, I missed a lot of emails
then :-/ ). 

Anyway, this makes sense.

Peter?

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> I wonder what you think of this patch? After a small fix to
> init/main.c and some powerpc fixes, I was able to use this patch 
> and a change to warn in the lockdep code in case of redundant ops,
> to verify there were no local_irq_enable() when enabled, or
> local_irq_disable() when disabled (which was implicated in a bug).
> 
> Lots of code to verify so we can't do this immediately, but I
> think it's cleaner to enforce the rule?
> 
> Thanks,
> Nick
> 
>  include/linux/irqflags.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 46cb57d5eb13..82287e1c6c52 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -110,7 +110,8 @@ do {						\
>  #define local_irq_save(flags)				\
>  	do {						\
>  		raw_local_irq_save(flags);		\
> -		trace_hardirqs_off();			\
> +		if (!raw_irqs_disabled_flags(flags))	\
> +			trace_hardirqs_off();		\
>  	} while (0)
>  
>  
> @@ -118,9 +119,11 @@ do {						\
>  	do {						\
>  		if (raw_irqs_disabled_flags(flags)) {	\
>  			raw_local_irq_restore(flags);	\
> -			trace_hardirqs_off();		\
> +			if (!irqs_disabled())		\
> +				trace_hardirqs_off();	\
>  		} else {				\
> -			trace_hardirqs_on();		\
> +			if (irqs_disabled())		\
> +				trace_hardirqs_on();	\
>  			raw_local_irq_restore(flags);	\
>  		}					\
>  	} while (0)
