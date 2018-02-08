Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHPiC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeBHPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:38:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42ED21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:37:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH 03/18] tracing: Add simple arguments to function based
 events
Message-ID: <20180208103756.743a53e0@gandalf.local.home>
In-Reply-To: <20180208101818.GA26290@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231017.459764446@goodmis.org>
        <20180208101818.GA26290@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 19:18:18 +0900
Namhyung Kim <namhyung@kernel.org> wrote:
						call->event.type,
> > @@ -150,6 +310,15 @@ static void func_event_trace(struct trace_event_file *trace_file,
> >  	entry = ring_buffer_event_data(event);
> >  	entry->ip = ip;
> >  	entry->parent_ip = parent_ip;
> > +	nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
> > +
> > +	list_for_each_entry(arg, &func_event->args, list) {
> > +		if (i < nr_args)
> > +			val = args[i];
> > +		else
> > +			val = 0;
> > +		memcpy(&entry->data[arg->offset], &val, arg->size);
> > +	}  
> 
> Where is the 'i' increased?

Good question. I think the increment got nuked via one of my rebases,
and then most my testing happened at the end of the patch series where
"i" is no longer used. But that's no excuse for keeping this bug
around. I'll fix it and test again at each patch.

Thanks for reporting.

-- Steve
