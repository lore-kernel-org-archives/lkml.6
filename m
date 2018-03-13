Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeCMO1h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbeCMO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:27:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E9B204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 13 Mar 2018 11:27:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, yan.y.zhao@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: __print_array should print hex format
 instead of dec
Message-ID: <20180313142732.GA29837@kernel.org>
References: <1520937557-24895-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520937557-24895-1-git-send-email-changbin.du@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 13, 2018 at 06:39:17PM +0800, changbin.du@intel.com escreveu:
> From: Changbin Du <changbin.du@intel.com>
> 
> The token '__print_array' is to print the array in hex format, but not
> decimal numbers. The implementation of __print_array in kernel side is:
> __print_array()->trace_print_array_seq()
> 
> This patch align the perf's behavior with kernel so we have a consistent
> event format.

Look ok, i.e. makes the userspace formatting do what the equivalent
kernel code does, Rostedt, Ack?

- Arnaldo
 
> Reported-by: Zhao Yan <yan.y.zhao@intel.com>
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/lib/traceevent/event-parse.c                 | 60 +++++++++++-----------
>  tools/lib/traceevent/event-parse.h                 |  6 +--
>  .../perf/util/scripting-engines/trace-event-perl.c |  8 +--
>  .../util/scripting-engines/trace-event-python.c    |  8 +--
>  4 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index e5f2acb..d9f770c 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -835,10 +835,10 @@ static void free_arg(struct print_arg *arg)
>  		free_arg(arg->hex.field);
>  		free_arg(arg->hex.size);
>  		break;
> -	case PRINT_INT_ARRAY:
> -		free_arg(arg->int_array.field);
> -		free_arg(arg->int_array.count);
> -		free_arg(arg->int_array.el_size);
> +	case PRINT_ARRAY:
> +		free_arg(arg->array.field);
> +		free_arg(arg->array.count);
> +		free_arg(arg->array.el_size);
>  		break;
>  	case PRINT_TYPE:
>  		free(arg->typecast.type);
> @@ -2669,25 +2669,25 @@ static enum event_type
>  process_int_array(struct event_format *event, struct print_arg *arg, char **tok)
>  {
>  	memset(arg, 0, sizeof(*arg));
> -	arg->type = PRINT_INT_ARRAY;
> +	arg->type = PRINT_ARRAY;
>  
> -	if (alloc_and_process_delim(event, ",", &arg->int_array.field))
> +	if (alloc_and_process_delim(event, ",", &arg->array.field))
>  		goto out;
>  
> -	if (alloc_and_process_delim(event, ",", &arg->int_array.count))
> +	if (alloc_and_process_delim(event, ",", &arg->array.count))
>  		goto free_field;
>  
> -	if (alloc_and_process_delim(event, ")", &arg->int_array.el_size))
> +	if (alloc_and_process_delim(event, ")", &arg->array.el_size))
>  		goto free_size;
>  
>  	return read_token_item(tok);
>  
>  free_size:
> -	free_arg(arg->int_array.count);
> -	arg->int_array.count = NULL;
> +	free_arg(arg->array.count);
> +	arg->array.count = NULL;
>  free_field:
> -	free_arg(arg->int_array.field);
> -	arg->int_array.field = NULL;
> +	free_arg(arg->array.field);
> +	arg->array.field = NULL;
>  out:
>  	*tok = NULL;
>  	return EVENT_ERROR;
> @@ -3564,7 +3564,7 @@ eval_num_arg(void *data, int size, struct event_format *event, struct print_arg
>  		break;
>  	case PRINT_FLAGS:
>  	case PRINT_SYMBOL:
> -	case PRINT_INT_ARRAY:
> +	case PRINT_ARRAY:
>  	case PRINT_HEX:
>  	case PRINT_HEX_STR:
>  		break;
> @@ -4015,44 +4015,45 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
>  		}
>  		break;
>  
> -	case PRINT_INT_ARRAY: {
> +	case PRINT_ARRAY: {
>  		void *num;
>  		int el_size;
>  
> -		if (arg->int_array.field->type == PRINT_DYNAMIC_ARRAY) {
> +		if (arg->array.field->type == PRINT_DYNAMIC_ARRAY) {
>  			unsigned long offset;
>  			struct format_field *field =
> -				arg->int_array.field->dynarray.field;
> +				arg->array.field->dynarray.field;
>  			offset = pevent_read_number(pevent,
>  						    data + field->offset,
>  						    field->size);
>  			num = data + (offset & 0xffff);
>  		} else {
> -			field = arg->int_array.field->field.field;
> +			field = arg->array.field->field.field;
>  			if (!field) {
> -				str = arg->int_array.field->field.name;
> +				str = arg->array.field->field.name;
>  				field = pevent_find_any_field(event, str);
>  				if (!field)
>  					goto out_warning_field;
> -				arg->int_array.field->field.field = field;
> +				arg->array.field->field.field = field;
>  			}
>  			num = data + field->offset;
>  		}
> -		len = eval_num_arg(data, size, event, arg->int_array.count);
> +		len = eval_num_arg(data, size, event, arg->array.count);
>  		el_size = eval_num_arg(data, size, event,
> -				       arg->int_array.el_size);
> +				       arg->array.el_size);
> +		trace_seq_putc(s, '{');
>  		for (i = 0; i < len; i++) {
>  			if (i)
>  				trace_seq_putc(s, ' ');
>  
>  			if (el_size == 1) {
> -				trace_seq_printf(s, "%u", *(uint8_t *)num);
> +				trace_seq_printf(s, "0x%x", *(uint8_t *)num);
>  			} else if (el_size == 2) {
> -				trace_seq_printf(s, "%u", *(uint16_t *)num);
> +				trace_seq_printf(s, "0x%x", *(uint16_t *)num);
>  			} else if (el_size == 4) {
> -				trace_seq_printf(s, "%u", *(uint32_t *)num);
> +				trace_seq_printf(s, "0x%x", *(uint32_t *)num);
>  			} else if (el_size == 8) {
> -				trace_seq_printf(s, "%"PRIu64, *(uint64_t *)num);
> +				trace_seq_printf(s, "0x%"PRIx64, *(uint64_t *)num);
>  			} else {
>  				trace_seq_printf(s, "BAD SIZE:%d 0x%x",
>  						 el_size, *(uint8_t *)num);
> @@ -4061,6 +4062,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
>  
>  			num += el_size;
>  		}
> +		trace_seq_putc(s, '}');
>  		break;
>  	}
>  	case PRINT_TYPE:
> @@ -5795,13 +5797,13 @@ static void print_args(struct print_arg *args)
>  		print_args(args->hex.size);
>  		printf(")");
>  		break;
> -	case PRINT_INT_ARRAY:
> +	case PRINT_ARRAY:
>  		printf("__print_array(");
> -		print_args(args->int_array.field);
> +		print_args(args->array.field);
>  		printf(", ");
> -		print_args(args->int_array.count);
> +		print_args(args->array.count);
>  		printf(", ");
> -		print_args(args->int_array.el_size);
> +		print_args(args->array.el_size);
>  		printf(")");
>  		break;
>  	case PRINT_STRING:
> diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
> index 0c03538..6ae2e8b 100644
> --- a/tools/lib/traceevent/event-parse.h
> +++ b/tools/lib/traceevent/event-parse.h
> @@ -249,7 +249,7 @@ struct print_arg_hex {
>  	struct print_arg	*size;
>  };
>  
> -struct print_arg_int_array {
> +struct print_arg_array {
>  	struct print_arg	*field;
>  	struct print_arg	*count;
>  	struct print_arg	*el_size;
> @@ -283,7 +283,7 @@ enum print_arg_type {
>  	PRINT_FLAGS,
>  	PRINT_SYMBOL,
>  	PRINT_HEX,
> -	PRINT_INT_ARRAY,
> +	PRINT_ARRAY,
>  	PRINT_TYPE,
>  	PRINT_STRING,
>  	PRINT_BSTRING,
> @@ -305,7 +305,7 @@ struct print_arg {
>  		struct print_arg_flags		flags;
>  		struct print_arg_symbol		symbol;
>  		struct print_arg_hex		hex;
> -		struct print_arg_int_array	int_array;
> +		struct print_arg_array		array;
>  		struct print_arg_func		func;
>  		struct print_arg_string		string;
>  		struct print_arg_bitmask	bitmask;
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index 7b79c41..112d627 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -224,10 +224,10 @@ static void define_event_symbols(struct event_format *event,
>  		define_event_symbols(event, ev_name, args->hex.field);
>  		define_event_symbols(event, ev_name, args->hex.size);
>  		break;
> -	case PRINT_INT_ARRAY:
> -		define_event_symbols(event, ev_name, args->int_array.field);
> -		define_event_symbols(event, ev_name, args->int_array.count);
> -		define_event_symbols(event, ev_name, args->int_array.el_size);
> +	case PRINT_ARRAY:
> +		define_event_symbols(event, ev_name, args->array.field);
> +		define_event_symbols(event, ev_name, args->array.count);
> +		define_event_symbols(event, ev_name, args->array.el_size);
>  		break;
>  	case PRINT_BSTRING:
>  	case PRINT_DYNAMIC_ARRAY:
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index ea07088..fb24f83 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -270,10 +270,10 @@ static void define_event_symbols(struct event_format *event,
>  		define_event_symbols(event, ev_name, args->hex.field);
>  		define_event_symbols(event, ev_name, args->hex.size);
>  		break;
> -	case PRINT_INT_ARRAY:
> -		define_event_symbols(event, ev_name, args->int_array.field);
> -		define_event_symbols(event, ev_name, args->int_array.count);
> -		define_event_symbols(event, ev_name, args->int_array.el_size);
> +	case PRINT_ARRAY:
> +		define_event_symbols(event, ev_name, args->array.field);
> +		define_event_symbols(event, ev_name, args->array.count);
> +		define_event_symbols(event, ev_name, args->array.el_size);
>  		break;
>  	case PRINT_STRING:
>  		break;
> -- 
> 2.7.4
