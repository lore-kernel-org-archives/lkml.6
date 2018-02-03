Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeBCRDr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:03:47 -0500
Received: from mail.efficios.com ([167.114.142.141]:33178 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbeBCRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:03:35 -0500
Date: Sat, 3 Feb 2018 17:04:14 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>
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
Message-ID: <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180202230458.840252014@goodmis.org>
References: <20180202230458.840252014@goodmis.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: Dynamically created function based events
Thread-Index: fPL43jEnYN/EOpqM6KhztwoU79a2+A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 2, 2018, at 6:04 PM, rostedt rostedt@goodmis.org wrote:

> At Kernel Summit back in October, we tried to bring up trace markers, which
> would be nops within the kernel proper, that would allow modules to hook
> arbitrary trace events to them. The reaction to this proposal was less than
> favorable. We were told that we were trying to make a work around for a
> problem, and not solving it. The problem in our minds is the notion of a
> "stable trace event".
> 
> There are maintainers that do not want trace events, or more trace events in
> their subsystems. This is due to the fact that trace events post an
> interface to user space, and this interface could become required by some
> tool. This may cause the trace event to become stable where it must not
> break the tool, and thus prevent the code from changing.
> 
> Or, the trace event may just have to add padding for fields that tools
> may require. The "success" field of the sched_wakeup trace event is one such
> instance. There is no more "success" variable, but tools may fail if it were
> to go away, so a "1" is simply added to the trace event wasting ring buffer
> real estate.
> 
> I talked with Linus about this, and he told me that we already have these
> markers in the kernel. They are from the mcount/__fentry__ used by function
> tracing. Have the trace events be created by these, and see if this will
> satisfy most areas that want trace events.

The approach proposed here will introduce an expectation that internal
function signatures never change in the kernel, else it would break user-space
tools hooking on those functions.

The instrumentation infrastructure provided by this patchset might be useful
for "one off" scripts, but it does not address the "stable instrumentation"
expectations issue.

The problem today is caused by widely used trace analysis tools that cannot
cope with changes to the kernel instrumentation, do not report the
instrumentation mismatch compared to their expectations, and we generally
don't expect users to ever update those tools to deal with newer kernels. Having
those tools hook on function names/arguments will not make this magically go
away. As soon as kernel code changes, widely used trace analysis tools will
start breaking left and right, and we will be back to square one. Only this time,
it's the internal function signature which will have become an ABI.

A possible solution to this problem appears if we start considering trace
analysis tools as just that: "tooling", with the following properties:

1) Tools need to validate that the instrumentation provided matches their
   expectations. This can be done by checking event/field names and/or version.
   Tools that fail to do that should be fixed.

2) Tools need to report to the user when the instrumentation does not match
   their expectations, and hint users to upgrade in order to deal with change.

3) Tools need to be backward compatible with respect to instrumentation: a
   user switching between older and newer kernels should not have to keep
   various copies of their tooling stack (graphical UI, analysis scripts,
   and so on).

If our goal is really to address this "stable instrumentation" issue, I don't
think hooking on functions helps in any way. I hope we can work on defining
instrumentation interface rules in order to deal with the fundamental problem
of requiring tooling to adapt to kernel changes.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
