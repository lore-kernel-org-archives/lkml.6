Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeBGDJX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 22:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbeBGDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:09:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B54208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Feb 2018 22:09:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@redhat.com>
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
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 01/18] tracing: Add function based events
Message-ID: <20180206220917.1ca65b54@vmware.local.home>
In-Reply-To: <20180205100050.75c04497@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180202231017.160509978@goodmis.org>
        <20180205082423.GB1253@krava>
        <20180205100050.75c04497@gandalf.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 10:00:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 5 Feb 2018 09:24:23 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> 
> > should this be done under 'func_event_mutex' ?  
> 
> Probably.

I think we only need to add the list.

> 
> > 
> > I tried and crashed the system by running 2 scripts with:
> > 
> >   echo 'ip_rcv(u64 skb, u64 dev)' > /sys/kernel/debug/tracing/function_events
> >   echo 'SyS_openat(int dfd, string buf, x32 flags, x32 mode)' >> /sys/kernel/debug/tracing/function_events
> >   echo 'SyS_open(x8[32] buf, x32 flags, x32 mode)' >> /sys/kernel/debug/tracing/function_events
> >  
> 

There's no reason that we can't have more than one function  event
attached to the same function. I'm adding this:

diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index b145639eac45..928168fc2025 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -1275,12 +1275,6 @@ static int create_function_event(int argc, char **argv)
 	if (state != FUNC_STATE_END)
 		goto fail;
 
-	ret = -EALREADY;
-	list_for_each_entry(fe, &func_events, list) {
-		if (strcmp(fe->func, func_event->func) == 0)
-			goto fail;
-	}
-
 	ret = ftrace_set_filter(&func_event->ops, func_event->func,
 				strlen(func_event->func), 0);
 	if (ret < 0)
@@ -1290,7 +1284,9 @@ static int create_function_event(int argc, char **argv)
 	if (ret < 0)
 		goto fail;
 
+	mutex_lock(&func_event_mutex);
 	list_add_tail(&func_event->list, &func_events);
+	mutex_unlock(&func_event_mutex);
 	return 0;
  fail:
 	free_func_event(func_event);

-- Steve
