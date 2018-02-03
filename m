Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753927AbeBCVIh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 16:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbeBCVI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 16:08:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1545021707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 3 Feb 2018 16:08:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180203160824.42a6c1bb@gandalf.local.home>
In-Reply-To: <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <20180203140217.2382df69@gandalf.local.home>
        <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2018 12:52:08 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sat, Feb 03, 2018 at 02:02:17PM -0500, Steven Rostedt wrote:
> > 
> > From those that were asking about having "trace markers" (ie.
> > Facebook), they told us they can cope with kernel changes.  
> 
> There is some misunderstanding here.
> We never asked for this interface.

But you wanted trace markers? Just to confirm.

> We're perfectly fine with existing kprobe/tracepoint+bpf.

OK, so no new development in this was wanted? So the entire talk about
getting tracepoints into vfs and scheduling wasn't needed?

> There are plenty of things to improve there, but this 'function based events'
> is not something we're interested in.

OK, but when I was showing this interface in DevConf.cz, there appeared
to be a lot of interest for it.

> I don't see how they are any better than kprobes and suffer from the same issues.

One only needs to look at source code, to add these. You don't need to
know the specifics of a registers and such. That's a big +. Sure, we
could add this to kprobes as well. But this also doesn't need the
kprobe infrastructure.

> We really dislike text based interfaces since they are good only

Who exactly is "we"?

Peter Zijlstra told me it's basically the only interface he uses. He
doesn't care for tools on top.

> for human access and very awkward to use from tools.

trace-cmd builds its entire connection without issue via these
interfaces. What is awkward about it?

> We also dislike when kernel takes on challenge to do text language parsing.
> It's a user space job.

Not if you are working in the embedded space and only have busybox as
your interface.

> 
> > The issue is that people are afraid to add tracepoints into their
> > subsystem because they are afraid that they will become stable and
> > limit their own development.  
> 
> This is not true. Tracepoints are being added and they're being changed.

vfs doesn't have any tracepoints. And Peter is reluctant to add any
more to the scheduler.

> We have a bunch of tools that use both kprobe and tracepoint hooks
> together with bpf programs to extract information from the kernel.
> They do break from time to time when we upgrade kernels (and we upgrade often),
> but keeping 'if kernel X do this, if kernel Y do that' inside the tool
> is perfectly fine.
> More often the tools have 'if kernel X ...' due to bpf verifier differences.
> It's constantly evolving and older kernels cannot load complex bpf
> programs written for the latest. So tools have to do some ugly workarounds.
> 
> > One problem we are having today is that too many trace events are being
> > created, where there are a lot of them that have been used once and
> > never used again. And people don't care about them.  
> 
> I don't think such issue exists. Please point an example of
> a tracepoint that was added and no one cares about it.

I've already cleaned up several tracepoints that have no path to them.
I'd say those are ones people do not care about. I've also removed
several trace events that are not even connected anywhere. These take
up around 5k each of memory. And these are just the trace events that
don't have paths to them. If we have tracepoints that no longer have
paths to them (which I can detect), how many more have paths but people
don't care about?

-- Steve

> 
> As far as Mathieu's point about detecting the difference between kernels,
> yes, it's a real problem to solve. The tracepoint changes are
> easy to detect, but changes to function arguments are much harder.
> Hence we're using kprobes on functions that are unlikely to change
> and that works well.
> 
> Also please note that kernel tracepoints are not different from tracing tool
> point of view than USDT tracepoints in user space apps.
> The tools attach to both of them and expect both to be more or less
> stable. Yet kernel tracepoints and USDT in apps _do_ change
> and tools have to deal with changes. It's actually harder with USDT.
