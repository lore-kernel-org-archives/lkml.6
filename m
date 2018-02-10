Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeBJCpC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 21:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbeBJCpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 21:45:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D70121789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Feb 2018 21:44:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: changbin.du@intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/power: Don't share template for cpu_idle and
 cpu_frequency
Message-ID: <20180209214458.1ed36c3c@vmware.local.home>
In-Reply-To: <1518226624-8931-1-git-send-email-changbin.du@intel.com>
References: <1518226624-8931-1-git-send-email-changbin.du@intel.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018 09:37:04 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> The type of state is signed int, convert it to unsigned int looks weird.
> (-1 become 4294967295)
>    932.123 power:cpu_idle:state=1 cpu_id=0)
>    932.125 power:cpu_idle:state=4294967295 cpu_id=0)
>    932.132 power:cpu_idle:state=1 cpu_id=0)
>    932.133 power:cpu_idle:state=4294967295 cpu_id=0)
> 
> Similarly for cpu_frequency as "state=%lu cpu_id=%lu". User need to read
> the code to understand what 'state' means.
> 
> No functional change in this patch.

That's not true. You split a class into two TRACE_EVENTS. Each
TRACE_EVENT adds approximately 5k of code and data. A DEFINE_EVENT()
adds around 300 bytes. There's better ways to do this,

Please don't add this patch.

-- Steve

> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  include/trace/events/power.h | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 908977d..39bd6de 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -12,14 +12,14 @@
>  
>  #define TPS(x)  tracepoint_string(x)
>  
> -DECLARE_EVENT_CLASS(cpu,
> +TRACE_EVENT(cpu_idle,
>  
> -	TP_PROTO(unsigned int state, unsigned int cpu_id),
> +	TP_PROTO(int state, unsigned int cpu_id),
>  
>  	TP_ARGS(state, cpu_id),
>  
>  	TP_STRUCT__entry(
> -		__field(	u32,		state		)
> +		__field(	int,		state		)
>  		__field(	u32,		cpu_id		)
>  	),
>  
> @@ -28,17 +28,10 @@ DECLARE_EVENT_CLASS(cpu,
>  		__entry->cpu_id = cpu_id;
>  	),
>  
> -	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
> +	TP_printk("state=%d cpu_id=%lu", __entry->state,
>  		  (unsigned long)__entry->cpu_id)
>  );
>  
> -DEFINE_EVENT(cpu, cpu_idle,
> -
> -	TP_PROTO(unsigned int state, unsigned int cpu_id),
> -
> -	TP_ARGS(state, cpu_id)
> -);
> -
>  TRACE_EVENT(powernv_throttle,
>  
>  	TP_PROTO(int chip_id, const char *reason, int pmax),
> @@ -141,11 +134,24 @@ TRACE_EVENT(pstate_sample,
>  		{ PM_EVENT_RESTORE, "restore" }, \
>  		{ PM_EVENT_RECOVER, "recover" })
>  
> -DEFINE_EVENT(cpu, cpu_frequency,
> +TRACE_EVENT(cpu_frequency,
>  
>  	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
>  
> -	TP_ARGS(frequency, cpu_id)
> +	TP_ARGS(frequency, cpu_id),
> +
> +	TP_STRUCT__entry(
> +		__field(	u32,		frequency	)
> +		__field(	u32,		cpu_id		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->frequency = frequency;
> +		__entry->cpu_id = cpu_id;
> +	),
> +
> +	TP_printk("frequency=%lu cpu_id=%lu", __entry->frequency,
> +		  (unsigned long)__entry->cpu_id)
>  );
>  
>  TRACE_EVENT(device_pm_callback_start,
