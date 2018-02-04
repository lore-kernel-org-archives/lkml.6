Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbeBDD6B (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 22:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeBDD5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 22:57:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E89B21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sun, 4 Feb 2018 12:57:47 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-Id: <20180204125747.70eb79dd0a69d30fb8a47fcd@kernel.org>
In-Reply-To: <20180203102759.56d03ada@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org>
        <20180203223817.0c8cc485d8163ad84039cf02@kernel.org>
        <20180203102759.56d03ada@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2018 10:27:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 3 Feb 2018 22:38:17 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > This seems very similar feature of what kprobe-based event does.
> 
> It is similar, but not the same as kprobes. It only focuses on
> functions and their arguments, and should not require any disassembling
> (no knowledge of regs required). Any need to see anything within the
> function will still require kprobe based help.

Yes, I see that point.

> > Earlier version of kprobe-based event supported Nth argument, but I decided
> > to drop it because we can not ensure the "function signature" from kernel
> > binary. It has been passed to "perf probe", so that we can define line-level
> > granularity. 
> 
> Sure, and if we get a wrong function, which can happen, the code is set
> up not to break anything. You only get garbage output.
> 
> > 
> > Of course if it is easy to support "argN" again as it does if the arch's
> > calling convention is clearly stated. (and now kprobe is based on ftrace
> > if it is on the entry of functions)
> > 
> > So my question is, what is the difference of those from the user perspective?
> > Only event syntax is a problem?
> > I'm very confusing...
> 
> Again, this is not a kprobe replacement. It is somewhat of a syntax
> issue. I want this to be very simple and not need a disassembler. For
> indexing of structures one may use gdb, but that's about it. You could
> get the same info from counting what's in a structure itself.

OK, so it is a simpler version of function event...

> I based some of the code from kprobes too. But I wanted this to be
> simpler, and as such, not as powerful as kprobes. More of a "poor mans"
> kprobe ;-) Where you are limited to functions and their arguments. If
> you need more power, switch to kprobes. In other words, its just an
> added stepping stone.
> 
> Also, this should work without kprobe support, only ftrace, and function
> args from the arch.

Hmm, but implementation seems very far from current probe events, we need
to consider how to unify it. Anyway, it is a very good time to do, because
I found current probe-event fetch method is not good with retpoline/IBRS,
it is full of indirect call.

I would like to convert it to eBPF if possible. It will be good for the
performance with JIT, and we can collaborate on the same code with BPF
people.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
