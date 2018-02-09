Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBIAeo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:34:44 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:58067 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeBIAem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:34:42 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 9 Feb 2018 09:34:36 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 12/18] tracing: Add accessing direct address from
 function based events
Message-ID: <20180209003436.GB28206@sejong>
References: <20180202230458.840252014@goodmis.org>
 <20180202231018.828677654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180202231018.828677654@goodmis.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:05:10PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Allow referencing any address during the function based event. The syntax is
> to use <type> <name>=<addr> For example:
> 
>  # echo 'do_IRQ(long total_forks=0xffffffffa2a4b4c0)' > function_events
>  # echo 1 > events/function/enable
>  # cat trace
>             sshd-832   [000] d... 221639.210845: ret_from_intr->do_IRQ(total_forks=855)
>             sshd-832   [000] d... 221639.211114: ret_from_intr->do_IRQ(total_forks=855)
>           <idle>-0     [000] d... 221639.211198: ret_from_intr->do_IRQ(total_forks=855)
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Documentation/trace/function-based-events.rst |  40 +++++++-
>  kernel/trace/trace_event_ftrace.c             | 129 +++++++++++++++++++++-----
>  2 files changed, 143 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
> index f18c8f3ef330..b0e6725f3032 100644
> --- a/Documentation/trace/function-based-events.rst
> +++ b/Documentation/trace/function-based-events.rst
> @@ -91,7 +91,7 @@ as follows:
>  
>   ARGS := ARG | ARG ',' ARGS | ''
>  
> - ARG := TYPE FIELD | ARG '|' ARG
> + ARG := TYPE FIELD | TYPE <name> '=' ADDR | TYPE ADDR | ARG '|' ARG
>  
>   TYPE := ATOM | 'unsigned' ATOM
>  
> @@ -107,6 +107,8 @@ as follows:
>  
>   OFFSET := '+' <number>
>  
> + ADDR := A hexidecimal address starting with '0x'
> +
>   Where <name> is a unique string starting with an alphabetic character
>   and consists only of letters and numbers and underscores.
>  
> @@ -267,3 +269,39 @@ Again, using gdb to find the offset of the "func" field of struct work_struct
>       <idle>-0     [000] dNs3  6241.172004: delayed_work_timer_fn->__queue_work(cpu=128, wq=ffff88011a010800, func=vmstat_shepherd+0x0/0xb0)
>   worker/0:2-1689  [000] d..2  6241.172026: __queue_delayed_work->__queue_work(cpu=7, wq=ffff88011a11da00, func=vmstat_update+0x0/0x70)
>       <idle>-0     [005] d.s3  6241.347996: queue_work_on->__queue_work(cpu=128, wq=ffff88011a011200, func=fb_flashcursor+0x0/0x110 [fb])
> +
> +
> +Direct memory access
> +====================
> +
> +Function arguments are not the only thing that can be recorded from a function
> +based event. Memory addresses can also be examined. If there's a global variable
> +that you want to monitor via an interrupt, you can put in the address directly.
> +
> +  # grep total_forks /proc/kallsyms
> +ffffffff82354c18 B total_forks
> +
> +  # echo 'do_IRQ(int total_forks=0xffffffff82354c18)' > function_events

Couldn't we use the symbol name directly?  Maybe it needs a syntax to
indicate global variable.  Like this?

  # echo 'do_IRQ(int $total_forks)' > function_events


> +
> +  # echo 1 events/functions/do_IRQ/enable
> +  # cat trace
> +    <idle>-0     [003] d..3   337.076709: ret_from_intr->do_IRQ(total_forks=1419)
> +    <idle>-0     [003] d..3   337.077046: ret_from_intr->do_IRQ(total_forks=1419)
> +    <idle>-0     [003] d..3   337.077076: ret_from_intr->do_IRQ(total_forks=1420)
> +
> +Note, address notations do not affect the argument count. For instance, with
> +
> +__visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
> +
> +  # echo 'do_IRQ(int total_forks=0xffffffff82354c18, symbol regs[16])' > function_events
> +
> +Is the same as
> +
> +  # echo 'do_IRQ(int total_forks=0xffffffff82354c18 | symbol regs[16])' > function_events
> +
> +  # cat trace
> +    <idle>-0     [003] d..3   653.839546: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
> +    <idle>-0     [003] d..3   653.906011: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
> +    <idle>-0     [003] d..3   655.823498: ret_from_intr->do_IRQ(total_forks=1504, regs=tick_nohz_idle_enter+0x4c/0x50)
> +    <idle>-0     [003] d..3   655.954096: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
> +
> diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
> index ba10177b9bd6..206114f192be 100644
> --- a/kernel/trace/trace_event_ftrace.c
> +++ b/kernel/trace/trace_event_ftrace.c
> @@ -256,14 +286,16 @@ static int add_arg(struct func_event *fevent, int ftype, int unsign)
>  static enum func_states
>  process_event(struct func_event *fevent, const char *token, enum func_states state)
>  {
> +	static bool update_arg;
>  	static int unsign;
> -	long val;
> +	unsigned long val;
>  	int ret;
>  	int i;
>  
>  	switch (state) {
>  	case FUNC_STATE_INIT:
>  		unsign = 0;
> +		update_arg = false;
>  		if (!isalpha(token[0]) && token[0] != '_')
>  			break;
>  		/* Do not allow wild cards */
> @@ -279,15 +311,15 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  			break;
>  		return FUNC_STATE_PARAM;
>  
> -	case FUNC_STATE_PIPE:
> -		fevent->arg_cnt--;
> -		goto comma;
>  	case FUNC_STATE_PARAM:
>  		if (token[0] == ')')
>  			return FUNC_STATE_END;
>  		/* Fall through */
>  	case FUNC_STATE_COMMA:
> - comma:
> +		if (update_arg)
> +			fevent->arg_cnt++;
> +		update_arg = false;
                /* Fall through */

> +	case FUNC_STATE_PIPE:
>  		if (strcmp(token, "unsigned") == 0) {
>  			unsign = 2;
>  			return FUNC_STATE_UNSIGNED;
> @@ -307,18 +339,20 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  		return FUNC_STATE_TYPE;
>  
>  	case FUNC_STATE_TYPE:
> -		if (!isalpha(token[0]) || token[0] == '_')
> -			break;
>  		if (WARN_ON(!fevent->last_arg))
>  			break;
> -		fevent->last_arg->name = kstrdup(token, GFP_KERNEL);
> -		if (!fevent->last_arg->name)
> +		if (update_arg_name(fevent, token) < 0)
> +			break;
> +		if (strncmp(token, "0x", 2) == 0)
> +			goto equal;

Not sure it's needed here.  IIUC it should see '=' first and you used
the same token with arg->name.  Hmm.. do you want support accessing to
an unnamed address directly like below?

  # echo 'do_IRQ(int 0xffffffff82354c18)' > function_events 

> +		if (!isalpha(token[0]) && token[0] != '_')
>  			break;

Maybe you want to check it before the update_arg_name().

Thanks,
Namhyung


> +		update_arg = true;
>  		return FUNC_STATE_VAR;
>  
>  	case FUNC_STATE_BRACKET:
>  		WARN_ON(!fevent->last_arg);
> -		ret = kstrtol(token, 0, &val);
> +		ret = kstrtoul(token, 0, &val);
>  		if (ret)
>  			break;
>  		val *= fevent->last_arg->size;
> @@ -333,7 +367,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  	case FUNC_STATE_BRACKET_END:
>  		switch (token[0]) {
>  		case ')':
> -			return FUNC_STATE_END;
> +			goto end;
>  		case ',':
>  			return FUNC_STATE_COMMA;
>  		case '|':
> @@ -344,16 +378,33 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  	case FUNC_STATE_PLUS:
>  		if (WARN_ON(!fevent->last_arg))
>  			break;
> -		ret = kstrtol(token, 0, &val);
> +		ret = kstrtoul(token, 0, &val);
>  		if (ret)
>  			break;
>  		fevent->last_arg->index += val;
>  		return FUNC_STATE_VAR;
>  
> +	case FUNC_STATE_ADDR:
> +		switch (token[0]) {
> +		case ')':
> +			goto end;
> +		case ',':
> +			return FUNC_STATE_COMMA;
> +		case '|':
> +			return FUNC_STATE_PIPE;
> +		}
> +		break;
> +
>  	case FUNC_STATE_VAR:
> +		if (token[0] == '=')
> +			return FUNC_STATE_EQUAL;
> +		if (WARN_ON(!fevent->last_arg))
> +			break;
> +		update_arg_arg(fevent);
> +		update_arg = true;
>  		switch (token[0]) {
>  		case ')':
> -			return FUNC_STATE_END;
> +			goto end;
>  		case ',':
>  			return FUNC_STATE_COMMA;
>  		case '|':
> @@ -365,10 +416,29 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  		}
>  		break;
>  
> +	case FUNC_STATE_EQUAL:
> +		if (strncmp(token, "0x", 2) != 0)
> +			break;
> + equal:
> +		if (WARN_ON(!fevent->last_arg))
> +			break;
> +		ret = kstrtoul(token, 0, &val);
> +		if (ret < 0)
> +			break;
> +		update_arg = false;
> +		fevent->last_arg->index = val;
> +		fevent->last_arg->arg = -1;
> +		fevent->last_arg->indirect = INDIRECT_FLAG;
> +		return FUNC_STATE_ADDR;
> +
>  	default:
>  		break;
>  	}
>  	return FUNC_STATE_ERROR;
> + end:
> +	if (update_arg)
> +		fevent->arg_cnt++;
> +	return FUNC_STATE_END;
>  }
