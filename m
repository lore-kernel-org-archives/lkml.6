Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeBCTCY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 14:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752616AbeBCTCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 14:02:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C180721707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 3 Feb 2018 14:02:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180203140217.2382df69@gandalf.local.home>
In-Reply-To: <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2018 17:04:14 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> The approach proposed here will introduce an expectation that internal
> function signatures never change in the kernel, else it would break user-space
> tools hooking on those functions.

I had this exact discussion with Linus. Linus, please correct me if I'm
wrong.

This is a case where he said if someone expected a function to be
there, than too bad. Functions can come and go depending on if gcc
inlines it or not. We already have this interface today. It's the
function tracer. One could argue a tool requires a function to exist
because it depends on a function being accessible to the function
tracer.

> 
> The instrumentation infrastructure provided by this patchset might be useful
> for "one off" scripts, but it does not address the "stable instrumentation"
> expectations issue.

Actually, it could work for adding a tracepoint.

> 
> The problem today is caused by widely used trace analysis tools that cannot
> cope with changes to the kernel instrumentation, do not report the
> instrumentation mismatch compared to their expectations, and we generally
> don't expect users to ever update those tools to deal with newer kernels. Having
> those tools hook on function names/arguments will not make this magically go
> away. As soon as kernel code changes, widely used trace analysis tools will
> start breaking left and right, and we will be back to square one. Only this time,
> it's the internal function signature which will have become an ABI.

>From those that were asking about having "trace markers" (ie.
Facebook), they told us they can cope with kernel changes.

If a user can't cope with the changes, then they need to have their own
custom kernels.

> 
> A possible solution to this problem appears if we start considering trace
> analysis tools as just that: "tooling", with the following properties:
> 
> 1) Tools need to validate that the instrumentation provided matches their
>    expectations. This can be done by checking event/field names and/or version.
>    Tools that fail to do that should be fixed.
> 
> 2) Tools need to report to the user when the instrumentation does not match
>    their expectations, and hint users to upgrade in order to deal with change.
> 
> 3) Tools need to be backward compatible with respect to instrumentation: a
>    user switching between older and newer kernels should not have to keep
>    various copies of their tooling stack (graphical UI, analysis scripts,
>    and so on).
> 
> If our goal is really to address this "stable instrumentation" issue, I don't
> think hooking on functions helps in any way. I hope we can work on defining
> instrumentation interface rules in order to deal with the fundamental problem
> of requiring tooling to adapt to kernel changes.

I think you may have mistaken my goal. It was not to establish stable
instrumentation. In fact, it was the exact opposite. It was a way to
avoid stable instrumentation but still be able to add trace events.

The issue is that people are afraid to add tracepoints into their
subsystem because they are afraid that they will become stable and
limit their own development. The problem is that it hurts those that
want to trace these subsystems who are perfectly fine with the
tracepoints going away, and then they would need to change their tools.
This change set was to help those that can customize their tools with
new kernels. It was not to help those that just want their tools to
work with all kernels.

With that said, this actually can help those who want stable
infrastructure as well. If there happens to be a function that is
constantly used to create a dynamic function based event, it can then
be shown to ask the sub system maintainer to add a static tracepoint
there. As they can show that it is very useful to have.

One problem we are having today is that too many trace events are being
created, where there are a lot of them that have been used once and
never used again. And people don't care about them. I want to slow down
the addition of trace events if these function events can be used
instead. And when they are not good enough, or we see that one is
constantly being added, then we will know that we can add a trace event
that would be useful in the future.

-- Steve
