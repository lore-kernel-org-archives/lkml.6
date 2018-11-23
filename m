Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2508C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581E320813
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Y8tOPr0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581E320813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393128AbeKWN4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:56:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731997AbeKWN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:56:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so10006624plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 19:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF4q3yj07SrQPATIMm5bK+qV58UjTXSShJS7quSLwJc=;
        b=Y8tOPr0X0i8z/tlJGKTWAHY7EtfizSw/tPu/6gAV5N6SfkjL5t0yGeaEZRCnCD/c4g
         ihhXquz1SqpAYikYjHwlsbo38LHrYaW7n1e24zN50Cw199dfUIeeC2fkSHOXCRlnmXZH
         bFgYxZpKBNp+HG/zVIk3ZjQr4tPJ1Xaz6K+2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF4q3yj07SrQPATIMm5bK+qV58UjTXSShJS7quSLwJc=;
        b=L1GTLCLDWEMj5B0J238VER9X1QQdOicLZF1vQiHP4wkSgIE0Hr1XM2/fu+3iKzpWNh
         u9ly2JsMtXnfVjN4bnRmoBYIh1bL9mBkqjFr5T7SzgDeSuPrVP4IqE9GIE1E71Xn2mgx
         KFmWu5Z2YSnSUPh17FKrXP9NLP4kKXBT5TUcYn6r7KfEz/Wz8TnE5YKlO3T7IsaWjwoc
         n+pEMksZiMsx6XsblRWTNm/MR2Vy8wXP3iujGfjArsgaQfJtydUyBCllJd8op6ZUe7Ip
         518j0X3iSH21tJql3WodIPdEqAsQlMA5SdVCP1rSXwtqzHmL4J0i8sWlxRzoL+vU9gOA
         p4HA==
X-Gm-Message-State: AA+aEWbRiluCbbdlb84o6gdySgngTomVLnF3qr/rNaFoRewpGBElr8Oy
        9MQXpFJM+3LvLrsrA156w/msx2aNj7Y=
X-Google-Smtp-Source: AFSGD/W4PX/ShhpbUVtsCT1/Bb6fgJwlCk04csDAcWYDTqr9nLvRnB26N/mB+HxUZesYGUAjV1yAjg==
X-Received: by 2002:a17:902:b406:: with SMTP id x6mr7795503plr.329.1542942821282;
        Thu, 22 Nov 2018 19:13:41 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h74sm2726162pfd.35.2018.11.22.19.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 19:13:39 -0800 (PST)
Date:   Thu, 22 Nov 2018 19:13:38 -0800
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
Subject: Re: [RFC][PATCH 09/14] function_graph: Move ftrace_graph_get_addr()
 to fgraph.c
Message-ID: <20181123031338.GC17060@google.com>
References: <20181122012708.491151844@goodmis.org>
 <20181122012803.843285508@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122012803.843285508@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:27:17PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Move the function function_graph_get_addr() to fgraph.c, as the management
> of the curr_ret_stack is going to change, and all the accesses to ret_stack
> needs to be done in fgraph.c.

s/ftrace_graph_get_addr/ftrace_graph_ret_addr/

thanks,

 - Joel

> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c                | 55 ++++++++++++++++++++++++++++
>  kernel/trace/trace_functions_graph.c | 55 ----------------------------
>  2 files changed, 55 insertions(+), 55 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index f3a89ecac671..c7d612897e33 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -233,6 +233,61 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  	return ret;
>  }
>  
> +/**
> + * ftrace_graph_ret_addr - convert a potentially modified stack return address
> + *			   to its original value
> + *
> + * This function can be called by stack unwinding code to convert a found stack
> + * return address ('ret') to its original value, in case the function graph
> + * tracer has modified it to be 'return_to_handler'.  If the address hasn't
> + * been modified, the unchanged value of 'ret' is returned.
> + *
> + * 'idx' is a state variable which should be initialized by the caller to zero
> + * before the first call.
> + *
> + * 'retp' is a pointer to the return address on the stack.  It's ignored if
> + * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
> + */
> +#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
> +unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> +				    unsigned long ret, unsigned long *retp)
> +{
> +	int index = task->curr_ret_stack;
> +	int i;
> +
> +	if (ret != (unsigned long)return_to_handler)
> +		return ret;
> +
> +	if (index < 0)
> +		return ret;
> +
> +	for (i = 0; i <= index; i++)
> +		if (task->ret_stack[i].retp == retp)
> +			return task->ret_stack[i].ret;
> +
> +	return ret;
> +}
> +#else /* !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
> +unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> +				    unsigned long ret, unsigned long *retp)
> +{
> +	int task_idx;
> +
> +	if (ret != (unsigned long)return_to_handler)
> +		return ret;
> +
> +	task_idx = task->curr_ret_stack;
> +
> +	if (!task->ret_stack || task_idx < *idx)
> +		return ret;
> +
> +	task_idx -= *idx;
> +	(*idx)++;
> +
> +	return task->ret_stack[task_idx].ret;
> +}
> +#endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
> +
>  static struct ftrace_ops graph_ops = {
>  	.func			= ftrace_stub,
>  	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 7c7fd13d2373..0f9cbc30645d 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -90,61 +90,6 @@ static void
>  print_graph_duration(struct trace_array *tr, unsigned long long duration,
>  		     struct trace_seq *s, u32 flags);
>  
> -/**
> - * ftrace_graph_ret_addr - convert a potentially modified stack return address
> - *			   to its original value
> - *
> - * This function can be called by stack unwinding code to convert a found stack
> - * return address ('ret') to its original value, in case the function graph
> - * tracer has modified it to be 'return_to_handler'.  If the address hasn't
> - * been modified, the unchanged value of 'ret' is returned.
> - *
> - * 'idx' is a state variable which should be initialized by the caller to zero
> - * before the first call.
> - *
> - * 'retp' is a pointer to the return address on the stack.  It's ignored if
> - * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
> - */
> -#ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
> -unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> -				    unsigned long ret, unsigned long *retp)
> -{
> -	int index = task->curr_ret_stack;
> -	int i;
> -
> -	if (ret != (unsigned long)return_to_handler)
> -		return ret;
> -
> -	if (index < 0)
> -		return ret;
> -
> -	for (i = 0; i <= index; i++)
> -		if (task->ret_stack[i].retp == retp)
> -			return task->ret_stack[i].ret;
> -
> -	return ret;
> -}
> -#else /* !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
> -unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> -				    unsigned long ret, unsigned long *retp)
> -{
> -	int task_idx;
> -
> -	if (ret != (unsigned long)return_to_handler)
> -		return ret;
> -
> -	task_idx = task->curr_ret_stack;
> -
> -	if (!task->ret_stack || task_idx < *idx)
> -		return ret;
> -
> -	task_idx -= *idx;
> -	(*idx)++;
> -
> -	return task->ret_stack[task_idx].ret;
> -}
> -#endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
> -
>  int __trace_graph_entry(struct trace_array *tr,
>  				struct ftrace_graph_ent *trace,
>  				unsigned long flags,
> -- 
> 2.19.1
> 
> 
