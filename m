Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031191AbeBNPTf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:19:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030839AbeBNPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:19:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F062178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 14 Feb 2018 10:19:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: changbin.du@intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and
 cpu_frequency
Message-ID: <20180214101930.7599c67b@gandalf.local.home>
In-Reply-To: <1518576038-16198-1-git-send-email-changbin.du@intel.com>
References: <1518576038-16198-1-git-send-email-changbin.du@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending due to typo in LKML address ]

On Wed, 14 Feb 2018 10:40:38 +0800
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
> 
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>


>From the tracing perspective:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Changbin Du <changbin.du@intel.com>
> 
> ---
> v2:
>   o rename title.
>   o define tracepoint with DEFINE_EVENT_PRINT().
> ---
>  Documentation/trace/events-power.txt |  4 ++--
>  include/trace/events/power.h         | 17 ++++++++++-------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/trace/events-power.txt b/Documentation/trace/events-power.txt
> index 21d514c..9485039 100644
> --- a/Documentation/trace/events-power.txt
> +++ b/Documentation/trace/events-power.txt
> @@ -23,8 +23,8 @@ Cf. include/trace/events/power.h for the events definitions.
>  A 'cpu' event class gathers the CPU-related events: cpuidle and
>  cpufreq.
>  
> -cpu_idle		"state=%lu cpu_id=%lu"
> -cpu_frequency		"state=%lu cpu_id=%lu"
> +cpu_idle		"state=%ld cpu_id=%lu"
> +cpu_frequency		"frequency=%lu cpu_id=%lu"
>  
>  A suspend event is used to indicate the system going in and out of the
>  suspend mode:
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 908977d..f1b82de 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -14,12 +14,12 @@
>  
>  DECLARE_EVENT_CLASS(cpu,
>  
> -	TP_PROTO(unsigned int state, unsigned int cpu_id),
> +	TP_PROTO(int state, unsigned int cpu_id),
>  
>  	TP_ARGS(state, cpu_id),
>  
>  	TP_STRUCT__entry(
> -		__field(	u32,		state		)
> +		__field(	s32,		state		)
>  		__field(	u32,		cpu_id		)
>  	),
>  
> @@ -28,13 +28,13 @@ DECLARE_EVENT_CLASS(cpu,
>  		__entry->cpu_id = cpu_id;
>  	),
>  
> -	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
> +	TP_printk("state=%ld cpu_id=%lu", (long)__entry->state,
>  		  (unsigned long)__entry->cpu_id)
>  );
>  
>  DEFINE_EVENT(cpu, cpu_idle,
>  
> -	TP_PROTO(unsigned int state, unsigned int cpu_id),
> +	TP_PROTO(int state, unsigned int cpu_id),
>  
>  	TP_ARGS(state, cpu_id)
>  );
> @@ -141,11 +141,14 @@ TRACE_EVENT(pstate_sample,
>  		{ PM_EVENT_RESTORE, "restore" }, \
>  		{ PM_EVENT_RECOVER, "recover" })
>  
> -DEFINE_EVENT(cpu, cpu_frequency,
> +DEFINE_EVENT_PRINT(cpu, cpu_frequency,
>  
> -	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
> +	TP_PROTO(int state, unsigned int cpu_id),
>  
> -	TP_ARGS(frequency, cpu_id)
> +	TP_ARGS(state, cpu_id),
> +
> +	TP_printk("frequency=%lu cpu_id=%lu",  (unsigned long)__entry->state,
> +		  (unsigned long)__entry->cpu_id)
>  );
>  
>  TRACE_EVENT(device_pm_callback_start,
