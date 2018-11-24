Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C22C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E320673
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 05:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bYbribNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8E320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeKXQSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 11:18:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40496 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbeKXQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 11:18:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so4152326pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 21:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fEWvlp75wwrnJ3SWqSETifLgJNJ31uZinO57+4jrsYU=;
        b=bYbribNZMhhrwMvCmKphpzS+AutlZwfWgfusTVAyQZkzirteMV4FeUpa0V6BRTZgBT
         +VI2dL6di4GM+3/AfyLbr10FO5VHhhI/rQQqK0cNW96ItuBdw2/amcLxILNkIKCVEmHq
         K7VxgogtNhcyHJmZe8Fm8sjEIAlA49IezlFPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fEWvlp75wwrnJ3SWqSETifLgJNJ31uZinO57+4jrsYU=;
        b=b7cKIi4a4DF1McNA3fW8gjvNGU2Mf5M1MHlpGEUUZpg0V3JpCCP3MEI7wJ6A6v49fq
         aTvQjqmUXZsBaOTUWS7MqLbakx/7rnOjeA2r4NuaYBx8PTBYP0VvrtXGCU19Mdr/oYix
         pEu70zV7JggirlTA2yZD3hVNB3fleCLmwL2vpdot0pGHbNsp60JfdtIltsQguYAb8S0S
         A8g54oV7m2vZiLxO2iVcpvAb/j+0BUomDM/xrdpSnLdKKxpQKgz4LgfNP6ASd8TV6r9F
         YXNFgRf32nFETcCiYs4jHIG7KjWfttJmQH7Dy5634U5SzNOVuuBQlBi6VYbc2yWMTT3k
         SHKQ==
X-Gm-Message-State: AGRZ1gKEEgryYTdT4izPvZKS4eoIKtE1M2ZVf7RSNof6SCs+yMWBN1zk
        utycGrmB4OymdZMcNBiv3/qeKg==
X-Google-Smtp-Source: AJdET5d9GKSfmUdPsPPwd7HWijlJxu6bdV0hSbZ+XCkA9bwyiZf7N+VKH+b5M8fEz3D+Xbsdg6mplA==
X-Received: by 2002:a62:6881:: with SMTP id d123-v6mr19555491pfc.195.1543037500807;
        Fri, 23 Nov 2018 21:31:40 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id j185sm30840856pge.72.2018.11.23.21.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 21:31:39 -0800 (PST)
Date:   Fri, 23 Nov 2018 21:31:38 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 11/14] function_graph: Convert ret_stack to a series
 of longs
Message-ID: <20181124053138.GA242510@google.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012804.122411256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122012804.122411256@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:27:19PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In order to make it possible to have multiple callbacks registered with the
> function_graph tracer, the retstack needs to be converted from an array of
> ftrace_ret_stack structures to an array of longs. This will allow to store
> the list of callbacks on the stack for the return side of the functions.
> 
> [ Note, this currently breaks architectures that access the ret_stack of a
>   task to handle unwinding when 'return_to_handler' is on the stack ]
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/sched.h |   2 +-
>  kernel/trace/fgraph.c | 123 +++++++++++++++++++++++-------------------
>  2 files changed, 70 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d6183a55e8eb..71a084a300da 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1119,7 +1119,7 @@ struct task_struct {
>  	int				curr_ret_depth;
>  
>  	/* Stack of return addresses for return function tracing: */
> -	struct ftrace_ret_stack		*ret_stack;
> +	unsigned long			*ret_stack;
>  
>  	/* Timestamp for last schedule: */
>  	unsigned long long		ftrace_timestamp;
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 9b85638ecded..1389fe39f64c 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -23,6 +23,17 @@
>  #define ASSIGN_OPS_HASH(opsname, val)
>  #endif
>  
> +#define FGRAPH_RET_SIZE (sizeof(struct ftrace_ret_stack))
> +#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
> +#define SHADOW_STACK_SIZE (FTRACE_RETFUNC_DEPTH * FGRAPH_RET_SIZE)
> +#define SHADOW_STACK_INDEX			\
> +	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
> +#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
> +
> +#define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
> +#define RET_STACK_INC(c) ({ c += FGRAPH_RET_INDEX; })
> +#define RET_STACK_DEC(c) ({ c -= FGRAPH_RET_INDEX; })
> +
[...]
> @@ -514,7 +531,7 @@ void ftrace_graph_init_task(struct task_struct *t)
>  
>  void ftrace_graph_exit_task(struct task_struct *t)
>  {
> -	struct ftrace_ret_stack	*ret_stack = t->ret_stack;
> +	unsigned long *ret_stack = t->ret_stack;
>  
>  	t->ret_stack = NULL;
>  	/* NULL must become visible to IRQs before we free it: */
> @@ -526,12 +543,10 @@ void ftrace_graph_exit_task(struct task_struct *t)
>  /* Allocate a return stack for each task */
>  static int start_graph_tracing(void)
>  {
> -	struct ftrace_ret_stack **ret_stack_list;
> +	unsigned long **ret_stack_list;
>  	int ret, cpu;
>  
> -	ret_stack_list = kmalloc_array(FTRACE_RETSTACK_ALLOC_SIZE,
> -				       sizeof(struct ftrace_ret_stack *),
> -				       GFP_KERNEL);
> +	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
>  

I had dumped the fgraph size related macros to understand the patch better, I
got:
[    0.909528] val of FGRAPH_RET_SIZE is 40
[    0.910250] val of FGRAPH_RET_INDEX is 5
[    0.910866] val of FGRAPH_ARRAY_SIZE is 16
[    0.911488] val of FGRAPH_ARRAY_MASK is 255
[    0.912134] val of FGRAPH_MAX_INDEX is 16
[    0.912751] val of FGRAPH_INDEX_SHIFT is 8
[    0.913382] val of FGRAPH_FRAME_SIZE is 168
[    0.914033] val of FGRAPH_FRAME_INDEX is 21
                      FTRACE_RETFUNC_DEPTH is 50
[    0.914686] val of SHADOW_STACK_SIZE is 8400

I had a concern about memory overhead per-task. It seems the total memory
needed per task for the stack is 8400 bytes (with my configuration with
FUNCTION_PROFILE
turned off).

Where as before it would be 32 * 40 = 1280 bytes. That looks like ~7 times
more than before.

On my system with ~4000 threads, that becomes ~32MB which seems a bit
wasteful especially if there was only one or 2 function graph callbacks
registered and most of the callback array in the stack isn't used.

Could we make the array size configurable at compile time and start it with a
small number like 4 or 6?

Also for patches 1 through 10:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

