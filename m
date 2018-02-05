Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeBEKJ7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:09:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBEKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:09:50 -0500
Date: Mon, 5 Feb 2018 11:09:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20180205100930.GH2249@hirez.programming.kicks-ass.net>
References: <20180202230458.840252014@goodmis.org>
 <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
 <292744194.15823.1517758204087.JavaMail.zimbra@efficios.com>
 <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwtCP3Nf86jwNFzdRy_m0GZWH5U2KBDutPDh1ZVATHLYg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2018 at 11:39:39AM -0800, Linus Torvalds wrote:
> Then there's the "I just want an overview" MIS people, who care about
> things like "I want a histogram of packets sent according to criteria
> XYZ", who want some highlevel block IO performance, or who just want
> random system-wide statistics.

> The second group might want explicit trace points exactly because that
> group doesn't even care *how* a packet is sent or received, or what
> the path through the block layer is. It just wants to know "packet
> sent" or "latency between IO request and completion" or things like
> that.

So a large sticking point here as been the scheduler tracepoints; which
I'm rather unhappy with.

As a result of adding SCHED_DEADLINE the existing tracepoints no longer
are sufficient (they don't provide any deadline specific information).

So the MIS people that are intersted in deadline tasks are unhappy.

My own preference is to just add the deadline information to the
existing tracepoints, but then people complain these become too big
(which is slow etc..), saying sched_switch is a high rate tracepoint
(true of course) (not to mention that changing the tracepoint will
probably break something, but they'll just have to cope).

So they've proposed all kinds of horrible alternatives that are all
variations of multiple tracepoints in the same location that fragment
the information, each of which I hate.

I'm ok with having the _one_ tracepoint, but I don't want 3+
sched_switch tracepoints, each having a different set of information
depending on what people want, that way lies madness.

As a run-around, Steve then suggested to decouple the trace-hook from
the actual trace-event. Let the scheduler only provide the hook, nothing
else. And then allow users to create their own events with the specific
data they need for their specific use-case.

Various options have been floated, ebpf, modules, whatever.

At this point I'm well tired of all this and would just as soon rip out
all tracepoints entire; but of course, the scheduler has some very
useful information for MIS people, so we can't realy do that either.

/sadface
