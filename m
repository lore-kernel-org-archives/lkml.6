Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeBCN41 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 08:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeBCN4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 08:56:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AD921785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 3 Feb 2018 22:56:15 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
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
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 13/18] tracing: Add array type to function based events
Message-Id: <20180203225615.6e1a21982335405dad13b99b@kernel.org>
In-Reply-To: <20180202231018.977452228@goodmis.org>
References: <20180202230458.840252014@goodmis.org>
        <20180202231018.977452228@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Feb 2018 18:05:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

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

This idea looks good for kprobe events too.
I'll try to implement same one :)

Thank you,

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
> +		fevent->last_arg->array = val;
> +		type = kasprintf(GFP_KERNEL, "%s[%d]", fevent->last_arg->type, (unsigned)val);
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
>  	ret = probe_kernel_read(buf, (void *)val, arg->size);
>  	if (ret)
>  		return 0;
> @@ -474,6 +510,21 @@ static long long get_arg(struct func_arg *arg, unsigned long val)
>  	return val;
>  }
>  
> +static void get_array(void *dst, struct func_arg *arg, unsigned long val)
> +{
> +	void *ptr = (void *)val;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < arg->array; i++) {
> +		ret = probe_kernel_read(dst, ptr, arg->size);
> +		if (ret)
> +			memset(dst, 0, arg->size);
> +		ptr += arg->size;
> +		dst += arg->size;
> +	}
> +}
> +
>  static void func_event_trace(struct trace_event_file *trace_file,
>  			     struct func_event *func_event,
>  			     unsigned long ip, unsigned long parent_ip,
> @@ -520,7 +571,10 @@ static void func_event_trace(struct trace_event_file *trace_file,
>  				val = get_arg(arg, args[arg->arg]);
>  		} else
>  			val = 0;
> -		memcpy(&entry->data[arg->offset], &val, arg->size);
> +		if (arg->array)
> +			get_array(&entry->data[arg->offset], arg, val);
> +		else
> +			memcpy(&entry->data[arg->offset], &val, arg->size);
>  	}
>  
>  	event_trigger_unlock_commit_regs(trace_file, buffer, event,
> @@ -571,6 +625,25 @@ static void make_fmt(struct func_arg *arg, char *fmt)
>  	fmt[c++] = '\0';
>  }
>  
> +static void write_data(struct trace_seq *s, const struct func_arg *arg, const char *fmt,
> +		       const void *data)
> +{
> +	switch (arg->size) {
> +	case 8:
> +		trace_seq_printf(s, fmt, *(unsigned long long *)data);
> +		break;
> +	case 4:
> +		trace_seq_printf(s, fmt, *(unsigned *)data);
> +		break;
> +	case 2:
> +		trace_seq_printf(s, fmt, *(unsigned short *)data);
> +		break;
> +	case 1:
> +		trace_seq_printf(s, fmt, *(unsigned char *)data);
> +		break;
> +	}
> +}
> +
>  static enum print_line_t
>  func_event_print(struct trace_iterator *iter, int flags,
>  		 struct trace_event *event)
> @@ -582,6 +655,7 @@ func_event_print(struct trace_iterator *iter, int flags,
>  	char fmt[FMT_SIZE];
>  	void *data;
>  	bool comma = false;
> +	int a;
>  
>  	entry = (struct func_event_hdr *)iter->ent;
>  
> @@ -598,20 +672,16 @@ func_event_print(struct trace_iterator *iter, int flags,
>  
>  		make_fmt(arg, fmt);
>  
> -		switch (arg->size) {
> -		case 8:
> -			trace_seq_printf(s, fmt, *(unsigned long long *)data);
> -			break;
> -		case 4:
> -			trace_seq_printf(s, fmt, *(unsigned *)data);
> -			break;
> -		case 2:
> -			trace_seq_printf(s, fmt, *(unsigned short *)data);
> -			break;
> -		case 1:
> -			trace_seq_printf(s, fmt, *(unsigned char *)data);
> -			break;
> -		}
> +		if (arg->array) {
> +			comma = false;
> +			for (a = 0; a < arg->array; a++, data += arg->size) {
> +				if (comma)
> +					trace_seq_putc(s, ',');
> +				comma = true;
> +				write_data(s, arg, fmt, data);
> +			}
> +		} else
> +			write_data(s, arg, fmt, data);
>  	}
>  	trace_seq_puts(s, ")\n");
>  	return trace_handle_return(s);
> @@ -634,11 +704,14 @@ static int func_event_define_fields(struct trace_event_call *event_call)
>  	DEFINE_FIELD(unsigned long, parent_ip, "__ip", 0);
>  
>  	list_for_each_entry(arg, &fevent->args, list) {
> +		int size = arg->size;
> +
> +		if (arg->array)
> +			size *= arg->array;
>  		ret = trace_define_field(event_call, arg->type,
>  					 arg->name,
>  					 sizeof(field) + arg->offset,
> -					 arg->size, arg->sign,
> -					 FILTER_OTHER);
> +					 size, arg->sign, FILTER_OTHER);
>  		if (ret < 0)
>  			return ret;
>  	}
> @@ -729,7 +802,7 @@ static int __set_print_fmt(struct func_event *func_event,
>  	const char *fmt_start = "\"%pS->%pS(";
>  	const char *fmt_end = ")\", REC->__ip, REC->__parent_ip";
>  	char fmt[FMT_SIZE];
> -	int r, i;
> +	int r, i, a;
>  	bool comma = false;
>  
>  	r = snprintf(buf, len, "%s", fmt_start);
> @@ -741,19 +814,49 @@ static int __set_print_fmt(struct func_event *func_event,
>  			len = update_len(len, i);
>  		}
>  		comma = true;
> -		make_fmt(arg, fmt);
> -		i = snprintf(buf + r, len, "%s=%s", arg->name, fmt);
> +
> +		i = snprintf(buf + r, len, "%s=", arg->name);
>  		r += i;
>  		len = update_len(len, i);
> +
> +		make_fmt(arg, fmt);
> +
> +		if (arg->array) {
> +			bool colon = false;
> +
> +			for (a = 0; a < arg->array; a++) {
> +				if (colon) {
> +					i = snprintf(buf + r, len, ":");
> +					r += i;
> +					len = update_len(len, i);
> +				}
> +				colon = true;
> +				i = snprintf(buf + r, len, "%s", fmt);
> +				r += i;
> +				len = update_len(len, i);
> +			}
> +		} else {
> +			i = snprintf(buf + r, len, "%s", fmt);
> +			r += i;
> +			len = update_len(len, i);
> +		}
>  	}
>  	i = snprintf(buf + r, len, "%s", fmt_end);
>  	r += i;
>  	len = update_len(len, i);
>  
>  	list_for_each_entry(arg, &func_event->args, list) {
> -		i = snprintf(buf + r, len, ", REC->%s", arg->name);
> -		r += i;
> -		len = update_len(len, i);
> +		if (arg->array) {
> +			for (a = 0; a < arg->array; a++) {
> +				i = snprintf(buf + r, len, ", REC->%s[%d]", arg->name, a);
> +				r += i;
> +				len = update_len(len, i);
> +			}
> +		} else {
> +			i = snprintf(buf + r, len, ", REC->%s", arg->name);
> +			r += i;
> +			len = update_len(len, i);
> +		}
>  	}
>  
>  	return r;
> -- 
> 2.15.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
