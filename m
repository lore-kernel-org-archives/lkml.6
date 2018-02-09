Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeBIBRu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:17:50 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:34801 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeBIBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:17:49 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 9 Feb 2018 10:17:45 +0900
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
Subject: Re: [PATCH 13/18] tracing: Add array type to function based events
Message-ID: <20180209011745.GC28206@sejong>
References: <20180202230458.840252014@goodmis.org>
 <20180202231018.977452228@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180202231018.977452228@goodmis.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 06:05:11PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add syntex to allow the user to create an array type. Brackets after the
> type field will denote that this is an array type. For example:
> 
>  # echo 'SyS_open(x8[32] buf, x32 flags, x32 mode)' > function_events
> 
> Will make the first argument of the sys_open function call an array of
> 32 bytes.
> 
> The array type can also be used in conjunction with the indirect offset
> brackets as well. For example to get the interrupt stack of regs in do_IRQ()
> for x86_64.
> 
>  # echo 'do_IRQ(x64[5] regs[16])' > function_events
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Documentation/trace/function-based-events.rst |  22 +++-
>  kernel/trace/trace_event_ftrace.c             | 157 +++++++++++++++++++++-----
>  2 files changed, 151 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
> index b0e6725f3032..4a8a6fb16a0a 100644
> --- a/Documentation/trace/function-based-events.rst
> +++ b/Documentation/trace/function-based-events.rst
> @@ -93,7 +93,7 @@ as follows:
>  
>   ARG := TYPE FIELD | TYPE <name> '=' ADDR | TYPE ADDR | ARG '|' ARG
>  
> - TYPE := ATOM | 'unsigned' ATOM
> + TYPE := ATOM | ATOM '[' <number> ']' | 'unsigned' TYPE
>  
>   ATOM := 'u8' | 'u16' | 'u32' | 'u64' |
>           's8' | 's16' | 's32' | 's64' |
> @@ -305,3 +305,23 @@ Is the same as
>      <idle>-0     [003] d..3   655.823498: ret_from_intr->do_IRQ(total_forks=1504, regs=tick_nohz_idle_enter+0x4c/0x50)
>      <idle>-0     [003] d..3   655.954096: ret_from_intr->do_IRQ(total_forks=1504, regs=cpuidle_enter_state+0xb1/0x330)
>  
> +
> +Array types
> +===========
> +
> +If there's a case where you want to see an array of a type, then you can
> +declare a type as an array by adding '[' number ']' after the type.
> +
> +To get the net_device perm_addr, from the dev parameter.
> +
> + (gdb) printf "%d\n", &((struct net_device *)0)->perm_addr
> +558
> +
> + # echo 'ip_rcv(x64 skb, x8[6] perm_addr+558)' > function_events
> +
> + # echo 1 > events/functions/ip_rcv/enable
> + # cat trace
> +    <idle>-0     [003] ..s3   219.813582: __netif_receive_skb_core->ip_rcv(skb=ffff880118195e00, perm_addr=b4,b5,2f,ce,18,65)
> +    <idle>-0     [003] ..s3   219.813595: __netif_receive_skb_core->ip_rcv(skb=ffff880118195e00, perm_addr=b4,b5,2f,ce,18,65)
> +    <idle>-0     [003] ..s3   220.115053: __netif_receive_skb_core->ip_rcv(skb=ffff880118195c00, perm_addr=b4,b5,2f,ce,18,65)
> +    <idle>-0     [003] ..s3   220.115293: __netif_receive_skb_core->ip_rcv(skb=ffff880118195c00, perm_addr=b4,b5,2f,ce,18,65)

What about adding braces to indicate array type like below?

... ip_rcv(skb=ffff880118195c00, perm_addr={b4,b5,2f,ce,18,65})


> diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
> index 206114f192be..64e2d7dcfd18 100644
> --- a/kernel/trace/trace_event_ftrace.c
> +++ b/kernel/trace/trace_event_ftrace.c
> @@ -20,6 +20,7 @@ struct func_arg {
>  	char				*name;
>  	long				indirect;
>  	long				index;
> +	short				array;
>  	short				offset;
>  	short				size;
>  	s8				arg;
> @@ -68,6 +69,9 @@ enum func_states {
>  	FUNC_STATE_PIPE,
>  	FUNC_STATE_PLUS,
>  	FUNC_STATE_TYPE,
> +	FUNC_STATE_ARRAY,
> +	FUNC_STATE_ARRAY_SIZE,
> +	FUNC_STATE_ARRAY_END,
>  	FUNC_STATE_VAR,
>  	FUNC_STATE_COMMA,
>  	FUNC_STATE_END,
> @@ -289,6 +293,7 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  	static bool update_arg;
>  	static int unsign;
>  	unsigned long val;
> +	char *type;
>  	int ret;
>  	int i;
>  
> @@ -339,6 +344,10 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  		return FUNC_STATE_TYPE;
>  
>  	case FUNC_STATE_TYPE:
> +		if (token[0] == '[')
> +			return FUNC_STATE_ARRAY;
> +		/* Fall through */
> +	case FUNC_STATE_ARRAY_END:
>  		if (WARN_ON(!fevent->last_arg))
>  			break;
>  		if (update_arg_name(fevent, token) < 0)
> @@ -350,14 +359,37 @@ process_event(struct func_event *fevent, const char *token, enum func_states sta
>  		update_arg = true;
>  		return FUNC_STATE_VAR;
>  
> +	case FUNC_STATE_ARRAY:
>  	case FUNC_STATE_BRACKET:
> -		WARN_ON(!fevent->last_arg);
> +		if (WARN_ON(!fevent->last_arg))
> +			break;
>  		ret = kstrtoul(token, 0, &val);
>  		if (ret)
>  			break;
> -		val *= fevent->last_arg->size;
> -		fevent->last_arg->indirect = val ^ INDIRECT_FLAG;
> -		return FUNC_STATE_INDIRECT;
> +		if (state == FUNC_STATE_BRACKET) {
> +			val *= fevent->last_arg->size;
> +			fevent->last_arg->indirect = val ^ INDIRECT_FLAG;
> +			return FUNC_STATE_INDIRECT;
> +		}
> +		if (val <= 0)
> +			break;

The val is unsigned long type.


> +		fevent->last_arg->array = val;
> +		type = kasprintf(GFP_KERNEL, "%s[%d]", fevent->last_arg->type, (unsigned)val);

s/%d/%lu/  and no need to cast it.


> +		if (!type)
> +			break;
> +		kfree(fevent->last_arg->type);
> +		fevent->last_arg->type = type;
> +		/*
> +		 * arg_offset has already been updated once by size.
> +		 * This update needs to account for that (hence the "- 1").
> +		 */
> +		fevent->arg_offset += fevent->last_arg->size * (fevent->last_arg->array - 1);
> +		return FUNC_STATE_ARRAY_SIZE;
> +
> +	case FUNC_STATE_ARRAY_SIZE:
> +		if (token[0] != ']')
> +			break;
> +		return FUNC_STATE_ARRAY_END;
>  
>  	case FUNC_STATE_INDIRECT:
>  		if (token[0] != ']')
> @@ -453,6 +485,10 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
>  
>  	val = val + (arg->indirect ^ INDIRECT_FLAG);
>  
> +	/* Arrays do their own indirect reads */
> +	if (arg->array)
> +		return val;
> +

Not sure about this.  After this change it would make 'x64[1] foo' and
'x64[1] foo[0]' equivalent, right?

Thanks,
Namhyung


>  	ret = probe_kernel_read(buf, (void *)val, arg->size);
>  	if (ret)
>  		return 0;
> @@ -474,6 +510,21 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
>  	return val;
>  }
