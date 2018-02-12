Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeBLQ3J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964886AbeBLQ3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:29:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E4F21779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Tue, 13 Feb 2018 01:29:03 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Md. Islam" <mislam4@kent.edu>
Cc: tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        mathieu.desnoyers@polymtl.ca, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH net-next] trace_events_filter: conditional trace event
 (tcp_probe full=0)
Message-Id: <20180213012903.ef6b0efe5b896994ef8fc713@kernel.org>
In-Reply-To: <CAFgPn1C0Yc+QDkA3szkYgRXqK6PWDDJE1fGhJkfYM-hXR3ABQg@mail.gmail.com>
References: <CAFgPn1C0Yc+QDkA3szkYgRXqK6PWDDJE1fGhJkfYM-hXR3ABQg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 00:08:46 -0500
"Md. Islam" <mislam4@kent.edu> wrote:

> Recently tcp_probe kernel module has been replaced by trace_event. Old
> tcp_probe had full=0 option where it only takes a snapshot only when
> congestion window is changed. However I did not find such
> functionality in trace_event.

Yes, that seems broken to me. You should filter by using perf script or
bpf. I'm not so clear about network stack, but it seems that cwnd can be
set for each tcp connection. This means "current snd_cwnd" must be stored
for each connection.

> This is why I implemented this
> "conditional trace_event" where a snapshot is taken only if some field
> is changed. For instance, following filter will record a snapshot only
> if snd_cwnd field is changed from the previous snapshot:
> 
> cd /sys/kernel/debug/tracing
> echo 1 > events/tcp/tcp_probe/enable
> echo "(sport == 8554 && snd_cwnd =< 0)"  > events/tcp/tcp_probe/filter &
> cat trace_pipe > /home/tamim/net-next/trace.data

Sounds interesting, but it seems like a hack.
Filter pred is stored for each trace event (tracepoint) so it is shared
among several context. At least you need a lock to exclude each thread
to update it. And I don't recommend to update filter_pred while tracing,
since it means we have a kind of "hidden state" in the filer. And again,
that filter_pred is shared, other tcp connection can see it.
(sport can be same as other connection's sport from other IP)

So IMHO, this kind of hack we don't implement in the kernel. Instead,
you can use perf-script and program it by python or perl. It gives you
much safer way to filter it out.

Or, please try to make it as complete feature. For example, maybe we can
introduce a global 'named' variable (which has correct accessor with spinlock
or atomic update), and you can refer it with name.
Then, it becomes safe and more generic, like below;

$ cd /sys/kernel/debug/tracing
$ touch vars/cwnd
$ echo '(sport == 12345 && snd_cwnd != $cwnd)' > events/tcp/tcp_probe/filter
$ echo 'update_var:cwnd:snd_cwnd if traced' > events/tcp/tcp_probe/trigger

Thank you,

> 
> This will record a snapshot where source port is 8554 and snd_cwnd is
> not same as the snd_cwnd in previous snapshot. For lack of better
> operator, I used "=<" to represent the field on which the filter will
> be applied.
> 
> The way it works is, it updates the predicate with new value every
> time. So the next time, if the field is same as in the predicate, the
> snapshot is ignored. Initially it checks if  the field is 0 or not.
> 
> diff --git a/kernel/trace/trace_events_filter.c
> b/kernel/trace/trace_events_filter.c
> index 61e7f06..8d733fa 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -39,6 +39,7 @@ enum filter_op_ids
>      OP_AND,
>      OP_GLOB,
>      OP_NE,
> +        OP_NE_PREV,
>      OP_EQ,
>      OP_LT,
>      OP_LE,
> @@ -62,6 +63,7 @@ static struct filter_op filter_ops[] = {
>      { OP_AND,    "&&",        2 },
>      { OP_GLOB,    "~",        4 },
>      { OP_NE,    "!=",        4 },
> +    { OP_NE_PREV,   "=<",        4 },
>      { OP_EQ,    "==",        4 },
>      { OP_LT,    "<",        5 },
>      { OP_LE,    "<=",        5 },
> @@ -202,6 +204,21 @@ static int filter_pred_##size(struct filter_pred
> *pred, void *event)    \
>      return match;                            \
>  }
> 
> +#define DEFINE_NE_PREV_PRED(size)                    \
> +static int filter_ne_prev_pred_##size(struct filter_pred *pred, void
> *event)    \
> +{                                    \
> +    u##size *addr = (u##size *)(event + pred->offset);        \
> +    u##size val = (u##size)pred->val;                \
> +    int match;                                                      \
> +                                    \
> +    match = (val == *addr) ^ pred->not;                \
> +                                                                        \
> +        if(match == 1)                                                  \
> +                pred->val = *addr;                                      \
> +    return match;                            \
> +}
> +
> +
>  DEFINE_COMPARISON_PRED(s64);
>  DEFINE_COMPARISON_PRED(u64);
>  DEFINE_COMPARISON_PRED(s32);
> @@ -216,6 +233,11 @@ DEFINE_EQUALITY_PRED(32);
>  DEFINE_EQUALITY_PRED(16);
>  DEFINE_EQUALITY_PRED(8);
> 
> +DEFINE_NE_PREV_PRED(64);
> +DEFINE_NE_PREV_PRED(32);
> +DEFINE_NE_PREV_PRED(16);
> +DEFINE_NE_PREV_PRED(8);
> +
>  /* Filter predicate for fixed sized arrays of characters */
>  static int filter_pred_string(struct filter_pred *pred, void *event)
>  {
> @@ -980,7 +1002,7 @@ int filter_assign_type(const char *type)
>  static bool is_legal_op(struct ftrace_event_field *field, enum
> filter_op_ids op)
>  {
>      if (is_string_field(field) &&
> -        (op != OP_EQ && op != OP_NE && op != OP_GLOB))
> +        (op != OP_EQ && op != OP_NE && op != OP_GLOB && op != OP_NE_PREV))
>          return false;
>      if (!is_string_field(field) && op == OP_GLOB)
>          return false;
> @@ -997,6 +1019,8 @@ static filter_pred_fn_t select_comparison_fn(enum
> filter_op_ids op,
>      case 8:
>          if (op == OP_EQ || op == OP_NE)
>              fn = filter_pred_64;
> +                else if (op == OP_NE_PREV)
> +            fn = filter_ne_prev_pred_64;
>          else if (field_is_signed)
>              fn = pred_funcs_s64[op - PRED_FUNC_START];
>          else
> @@ -1005,6 +1029,8 @@ static filter_pred_fn_t
> select_comparison_fn(enum filter_op_ids op,
>      case 4:
>          if (op == OP_EQ || op == OP_NE)
>              fn = filter_pred_32;
> +                else if (op == OP_NE_PREV)
> +            fn = filter_ne_prev_pred_32;
>          else if (field_is_signed)
>              fn = pred_funcs_s32[op - PRED_FUNC_START];
>          else
> @@ -1013,6 +1039,8 @@ static filter_pred_fn_t
> select_comparison_fn(enum filter_op_ids op,
>      case 2:
>          if (op == OP_EQ || op == OP_NE)
>              fn = filter_pred_16;
> +                else if (op == OP_NE_PREV)
> +            fn = filter_ne_prev_pred_16;
>          else if (field_is_signed)
>              fn = pred_funcs_s16[op - PRED_FUNC_START];
>          else
> @@ -1021,6 +1049,8 @@ static filter_pred_fn_t
> select_comparison_fn(enum filter_op_ids op,
>      case 1:
>          if (op == OP_EQ || op == OP_NE)
>              fn = filter_pred_8;
> +                else if (op == OP_NE_PREV)
> +            fn = filter_ne_prev_pred_8;
>          else if (field_is_signed)
>              fn = pred_funcs_s8[op - PRED_FUNC_START];
>          else
> @@ -1088,7 +1118,7 @@ static int init_pred(struct filter_parse_state *ps,
>          }
>      }
> 
> -    if (pred->op == OP_NE)
> +    if (pred->op == OP_NE || pred->op == OP_NE_PREV)
>          pred->not ^= 1;
> 
>      pred->fn = fn;
> @@ -2197,7 +2227,7 @@ static int ftrace_function_check_pred(struct
> filter_pred *pred, int leaf)
>           *  - only '==' and '!=' is used
>           *  - the 'ip' field is used
>           */
> -        if ((pred->op != OP_EQ) && (pred->op != OP_NE))
> +        if ((pred->op != OP_EQ) && (pred->op != OP_NE) && (pred->op
> != OP_NE_PREV))
>              return -EINVAL;
> 
>          if (strcmp(field->name, "ip"))
> 
> 
> I'm new to upstream kernel development. Please let me any suggestion.
> 
> Many thanks
> Tamim
> PhD Candidate,
> Kent State University


-- 
Masami Hiramatsu <mhiramat@kernel.org>
