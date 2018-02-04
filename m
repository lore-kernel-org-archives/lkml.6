Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeBDTjs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 14:39:48 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37962 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeBDTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 14:39:41 -0500
X-Google-Smtp-Source: AH8x226E2FVmGzdt1aHjrwvx+sgox0hgqix+w1VzkOJmGwUrbwyr9t3hIMjdiAvqYwEpKZQj/4S+3l2BrUp6ZXoAkuA=
MIME-Version: 1.0
In-Reply-To: <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
References: <20180202230458.840252014@goodmis.org> <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com> <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2018 11:39:39 -0800
X-Google-Sender-Auth: qke-JB3yaqIJ5EhPLGla8S-uaBI
Message-ID: <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based events
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 7:30 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I agree with your arguments. A consequence of those arguments is that
> function-based tracing should be expected to be used by kernel engineers
> and experts who can adapt their scripts to follow code changes, and tune
> the script based on their specific kernel version and configuration.

Honestly, I think that's largely the case already.

The main source of tracing is done by experts at big cloud companies,
I bet. People who do it for performance reasons, or to find some
anomaly. They're pretty intimate with the kernel.

There _are_ "generic MIS" uses for tracing, and I think those are
places where we may want architectural trace points. Things like
gathering IO statistics etc.

I personally think that one of the pain points with tracing has been
exactly the fact that there are two *completely* different uses, and
they have *completely* different requirements. There's the expert
user, who basically wants tracepoints almost everywhere, and who is
doing some really deep analysis of some random area.

Then there's the "I just want an overview" MIS people, who care about
things like "I want a histogram of packets sent according to criteria
XYZ", who want some highlevel block IO performance, or who just want
random system-wide statistics.

One group really needs to tie in to _anything_, and by definition is
going to delve deep into some very specific corner of the kernel,
because they might be chasing a subtle bug and want to have traces to
just _find_ it.

The other group is looking for a much higher-level thing, and isn't
necessarily a kernel hacker, and just wants to know IO latencies or
something for statistics.

I think the function-based events is for that first group. We do not
want to have actual explicit trace events for that group, because that
group might want them _everywhere_.  That first group might want to
know the latency of a packet or block command through one particular
chain.

The second group might want explicit trace points exactly because that
group doesn't even care *how* a packet is sent or received, or what
the path through the block layer is. It just wants to know "packet
sent" or "latency between IO request and completion" or things like
that.

The first group cares about a particular kernel implementation and has
the expertise to line things up for the particular kernel that is
being deployed on a hundred thousand machines.

The second group doesn't want to care about a particular kernel, just
wants tools that work across them.

This is why I pushed Steven towards this function-based events things.
Because I'm *hoping* that this can actually resolve that conflict
between the two groups. Function-based events are for the first group,
while actual explicit trace points are for the second.

(Obviously it's not entirely black-and-white, but I do think there is
a pretty big difference between the two groups. And the first group
will obviously use the explicit trace points _too_, generally to
narrow down where they want to go with the function-based one).

We'll see. Maybe I'm entirely wrong. But I'm hoping that the
function-based one will end up being helpful.

               Linus
