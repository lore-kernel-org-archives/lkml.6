Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44381C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E18B2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfAIObY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbfAIObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:31:24 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73F4206B6;
        Wed,  9 Jan 2019 14:31:22 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:31:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] kprobes: Mark ftrace mcount handler functions
 nokprobe
Message-ID: <20190109093121.01519d81@gandalf.local.home>
In-Reply-To: <154692269381.1133.17151202401532686704.stgit@devbox>
References: <154692263564.1133.17363562046971295490.stgit@devbox>
        <154692269381.1133.17151202401532686704.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jan 2019 13:44:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Mark ftrace mcount handler functions nokprobe since
> probing on these functions with kretprobe pushes
> return address incorrectly on kretprobe shadow stack.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> Tested-by: Andrea Righi <righi.andrea@gmail.com>
> Cc: stable@vger.kernel.org

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  - Changes in v2:
>    Fix to include kprobes.h (Thanks Andrea!)
> ---
>  kernel/trace/ftrace.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f0ff24173a0b..b0774388d52b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -34,6 +34,7 @@
>  #include <linux/list.h>
>  #include <linux/hash.h>
>  #include <linux/rcupdate.h>
> +#include <linux/kprobes.h>
>  
>  #include <trace/events/sched.h>
>  
> @@ -6250,7 +6251,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
>  	tr->ops->func = ftrace_stub;
>  }
>  
> -static inline void
> +static nokprobe_inline void
>  __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *ignored, struct pt_regs *regs)
>  {
> @@ -6310,11 +6311,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
>  }
> +NOKPROBE_SYMBOL(ftrace_ops_list_func);
>  #else
>  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
>  }
> +NOKPROBE_SYMBOL(ftrace_ops_no_ops);
>  #endif
>  
>  /*
> @@ -6341,6 +6344,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
>  	preempt_enable_notrace();
>  	trace_clear_recursion(bit);
>  }
> +NOKPROBE_SYMBOL(ftrace_ops_assist_func);
>  
>  /**
>   * ftrace_ops_get_func - get the function a trampoline should call

