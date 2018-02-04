Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBDP3b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:29:31 -0500
Received: from mail.efficios.com ([167.114.142.141]:42725 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBDP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:29:24 -0500
Date: Sun, 4 Feb 2018 15:30:04 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
References: <20180202230458.840252014@goodmis.org> <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com> <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: Dynamically created function based events
Thread-Index: kaZ2eDvVBvH9B/whLMfJXn7eHtGXfQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 3, 2018, at 4:43 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Sat, Feb 3, 2018 at 9:04 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> The approach proposed here will introduce an expectation that internal
>> function signatures never change in the kernel, else it would break user-space
>> tools hooking on those functions.
> 
> No, I really don't think so.
> 
> There's two reasons for that:
> 
> The first is purely about kernel development. I, and every sane kernel
> engineer, will simply laugh in the face of somebody who comes to us
> and says "hey, I had this script that did low-level function tracing
> on your kernel, and then you changed something, and now the random
> function I was tracing has a new name and different arguments".
> 
> We'll just go "yeah, tough, change your script". Or more likely, not
> even bother to reply at all.
> 
> But the bigger issue is actually simply just psychology. Exactly
> *because* this is all implicit, and there are no explicit trace
> points, it's _obvious_ to any user that there isn't something
> long-term dependable that they hang their hat on.
> 
> Everybody *understands* that this is like a debugger: if you have a
> gdb script that shows some information, and then you go around and
> change the source code, then *obviously* you'll have to change your
> debugger script too. You don't keep the source code static just to
> make your gdb script happy., That would be silly.
> 
> In contrast, the explicit tracepoints really made people believe that
> they have some long-term meaning.
> 
> So yes, we'll  make it obvious that hell no, random kernel functions
> are not a long-term ABI. But honestly, I don't think we even need to
> have a lot of "education" on this, simply because it's so obvious that
> anybody who thinks it's some ABI is not going to be somebody we'll
> have to worry about.
> 
> Because the kind of person thinking "Ooh, this is a stable ABI" won't
> be doing interesting work anyway. That kind of person will be sitting
> in a corner eating paste, not doing interesting kernel tracing.

I agree with your arguments. A consequence of those arguments is that
function-based tracing should be expected to be used by kernel engineers
and experts who can adapt their scripts to follow code changes, and tune
the script based on their specific kernel version and configuration.

On the other hand, system administrators and application developers who
wish to tune and understand their workload will more likely fetch their
analysis scripts/tools from a third-party. If those scripts hook on
functions/arguments, it becomes really hard to ensure those will work
with a myriad of kernel versions, configurations, and toolchain versions
out there.

The good news is that Steven's approach should allow us to deal with
use-cases that are specific to kernel developers by simply using
function tracing. That should take care of most "one off" and very
specialized use-cases.

My genuine concern here is that tools targeting sysadmins and application
developers start hooking on kernel functions, and all goes well for a
few months or years until someone changes that part of the code. Then
all those wonderfully useful scripts that users depend on will end up
being broken: in the best scenario those tools will detect the change
and require to be updated, but in the worse case the tools will simply
print bogus results that people will take for granted.

This should therefore leave a door open to adding new tracepoints: cases
where the data gathered is shown to be useful enough for tools targeting
an audience wider than just kernel developers. To improve over the current
situation, we should think about documenting some rules about how those
tools should cope with tracepoints changing over time (event version,
tools backward compatibility, and so on), and make sure the ABI exposes
the information required to help tools cope with change.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
