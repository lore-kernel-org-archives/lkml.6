Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeBCVnu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 16:43:50 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34404 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754091AbeBCVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 16:43:41 -0500
X-Google-Smtp-Source: AH8x226e1vekOIAghPbpsUYHwRiy2Jo+14HJ6BzBmU1n2hU8gwzw/qpDpqfHjqJso81e7pD+u/ZohJDt3jqXJFXcTkc=
MIME-Version: 1.0
In-Reply-To: <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
References: <20180202230458.840252014@goodmis.org> <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 3 Feb 2018 13:43:39 -0800
X-Google-Sender-Auth: 6-J1hxW5fOTfbaGD4_XtwvB5LzI
Message-ID: <CA+55aFz1=qWvnJ2271SGwuezwQRBA2nZp8_BxFyR-R0VKKgXRw@mail.gmail.com>
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

On Sat, Feb 3, 2018 at 9:04 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> The approach proposed here will introduce an expectation that internal
> function signatures never change in the kernel, else it would break user-space
> tools hooking on those functions.

No, I really don't think so.

There's two reasons for that:

The first is purely about kernel development. I, and every sane kernel
engineer, will simply laugh in the face of somebody who comes to us
and says "hey, I had this script that did low-level function tracing
on your kernel, and then you changed something, and now the random
function I was tracing has a new name and different arguments".

We'll just go "yeah, tough, change your script". Or more likely, not
even bother to reply at all.

But the bigger issue is actually simply just psychology. Exactly
*because* this is all implicit, and there are no explicit trace
points, it's _obvious_ to any user that there isn't something
long-term dependable that they hang their hat on.

Everybody *understands* that this is like a debugger: if you have a
gdb script that shows some information, and then you go around and
change the source code, then *obviously* you'll have to change your
debugger script too. You don't keep the source code static just to
make your gdb script happy., That would be silly.

In contrast, the explicit tracepoints really made people believe that
they have some long-term meaning.

So yes, we'll  make it obvious that hell no, random kernel functions
are not a long-term ABI. But honestly, I don't think we even need to
have a lot of "education" on this, simply because it's so obvious that
anybody who thinks it's some ABI is not going to be somebody we'll
have to worry about.

Because the kind of person thinking "Ooh, this is a stable ABI" won't
be doing interesting work anyway. That kind of person will be sitting
in a corner eating paste, not doing interesting kernel tracing.

                 Linus
