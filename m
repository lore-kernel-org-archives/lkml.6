Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeBCUwS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:52:18 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:37801 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbeBCUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:52:13 -0500
X-Google-Smtp-Source: AH8x2265hVtHHdlxwLXwHPsu5IEWrKcPx2f0sCUTXsLzfuvlisadVBdOTsMsvr/VhVpW/0/U6HVM0g==
Date: Sat, 3 Feb 2018 12:52:08 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
References: <20180202230458.840252014@goodmis.org>
 <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <20180203140217.2382df69@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203140217.2382df69@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 02:02:17PM -0500, Steven Rostedt wrote:
> 
> From those that were asking about having "trace markers" (ie.
> Facebook), they told us they can cope with kernel changes.

There is some misunderstanding here.
We never asked for this interface.
We're perfectly fine with existing kprobe/tracepoint+bpf.
There are plenty of things to improve there, but this 'function based events'
is not something we're interested in.
I don't see how they are any better than kprobes and suffer from the same issues.
We really dislike text based interfaces since they are good only
for human access and very awkward to use from tools.
We also dislike when kernel takes on challenge to do text language parsing.
It's a user space job.

> The issue is that people are afraid to add tracepoints into their
> subsystem because they are afraid that they will become stable and
> limit their own development.

This is not true. Tracepoints are being added and they're being changed.
We have a bunch of tools that use both kprobe and tracepoint hooks
together with bpf programs to extract information from the kernel.
They do break from time to time when we upgrade kernels (and we upgrade often),
but keeping 'if kernel X do this, if kernel Y do that' inside the tool
is perfectly fine.
More often the tools have 'if kernel X ...' due to bpf verifier differences.
It's constantly evolving and older kernels cannot load complex bpf
programs written for the latest. So tools have to do some ugly workarounds.

> One problem we are having today is that too many trace events are being
> created, where there are a lot of them that have been used once and
> never used again. And people don't care about them.

I don't think such issue exists. Please point an example of
a tracepoint that was added and no one cares about it.

As far as Mathieu's point about detecting the difference between kernels,
yes, it's a real problem to solve. The tracepoint changes are
easy to detect, but changes to function arguments are much harder.
Hence we're using kprobes on functions that are unlikely to change
and that works well.

Also please note that kernel tracepoints are not different from tracing tool
point of view than USDT tracepoints in user space apps.
The tools attach to both of them and expect both to be more or less
stable. Yet kernel tracepoints and USDT in apps _do_ change
and tools have to deal with changes. It's actually harder with USDT.
