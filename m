Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeENDNK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:13:10 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:57679 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeENDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:13:09 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 14 May 2018 12:13:22 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC][PATCH 06/10] tracing: Add trigger file for trace_markers
 tracefs/ftrace/print
Message-ID: <20180514031322.GB9220@sejong>
References: <20180511194927.190877137@goodmis.org>
 <20180511195340.876528094@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511195340.876528094@goodmis.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:49:33PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Allow writing to the trace_markers file initiate triggers defined in
> tracefs/ftrace/print/trigger file. This will allow of user space to trigger
> the same type of triggers (including histograms) that the trace events use.
> 
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Karim Yaghmour <karim.yaghmour@opersys.com>
> Cc: Brendan Gregg <bgregg@netflix.com>
> Suggested-by: Joel Fernandes <joelaf@google.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

[SNIP]
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index e3a658bac10f..de3fce14cd00 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -230,7 +230,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
>  	FILTER_OTHER
>  );
>  
> -FTRACE_ENTRY(print, print_entry,
> +FTRACE_ENTRY_REG(print, print_entry,
>  
>  	TRACE_PRINT,
>  
> @@ -242,7 +242,9 @@ FTRACE_ENTRY(print, print_entry,
>  	F_printk("%ps: %s",
>  		 (void *)__entry->ip, __entry->buf),
>  
> -	FILTER_OTHER
> +	FILTER_OTHER,
> +
> +	 ftrace_event_register

I wonder this is still needed since you added __find_event_file()
which ignores the reg field.  Maybe I'm missing something..

Anyway it looks whitespace damaged.

Thanks,
Namhyung


>  );
>  
>  FTRACE_ENTRY(raw_data, raw_data_entry,
> diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
> index d842f1eadfe5..45630a76ed3a 100644
> --- a/kernel/trace/trace_export.c
> +++ b/kernel/trace/trace_export.c
> @@ -14,6 +14,13 @@
>  
>  #include "trace_output.h"
>  
> +/* Stub function for events with triggers */
> +static int ftrace_event_register(struct trace_event_call *call,
> +				 enum trace_reg type, void *data)
> +{
> +	return 0;
> +}
> +
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM	ftrace
>  
> -- 
> 2.17.0
> 
> 
