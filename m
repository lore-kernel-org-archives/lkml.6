Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBIPDp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:03:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeBIPDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:03:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3473D21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 10 Feb 2018 00:03:37 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 11/20 v2] tracing: Add symbol type to function based
 events
Message-Id: <20180210000337.c2efb5438d281892e83caaba@kernel.org>
In-Reply-To: <20180208112031.GB30958@krava>
References: <20180207202402.253089656@goodmis.org>
        <20180207202816.348135328@goodmis.org>
        <20180208112031.GB30958@krava>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 12:20:31 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Wed, Feb 07, 2018 at 03:24:13PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Add a special type "symbol" that will use %pS to display the field of a
> > function based event.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  Documentation/trace/function-based-events.rst | 26 +++++++++++++++++++++++++-
> >  kernel/trace/trace_event_ftrace.c             | 13 ++++++++++---
> >  2 files changed, 35 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
> > index bdb28f433bfb..f18c8f3ef330 100644
> > --- a/Documentation/trace/function-based-events.rst
> > +++ b/Documentation/trace/function-based-events.rst
> > @@ -98,7 +98,8 @@ as follows:
> >   ATOM := 'u8' | 'u16' | 'u32' | 'u64' |
> >           's8' | 's16' | 's32' | 's64' |
> >           'x8' | 'x16' | 'x32' | 'x64' |
> > -         'char' | 'short' | 'int' | 'long' | 'size_t'
> > +         'char' | 'short' | 'int' | 'long' | 'size_t' |
> > +	 'symbol'
> >  
> >   FIELD := <name> | <name> INDEX | <name> OFFSET | <name> OFFSET INDEX
> >  
> > @@ -243,3 +244,26 @@ The above will take the parameter value, add it by 4, then index it by two
> >  8 byte words. It's the same in C as: (u64 *)((void *)param + 4)[2]
> >  
> >   Note: "int skb[32]" is the same as "int skb+4[31]".
> > +
> > +
> > +Symbols (function names)
> > +========================
> > +
> > +To display kallsyms "%pS" type of output, use the special type "symbol".
> > +
> > +Again, using gdb to find the offset of the "func" field of struct work_struct
> > +
> > +(gdb) printf "%d\n", &((struct work_struct *)0)->func
> > +24
> 
> you could also use Arnaldo's pahole for this, seems like less typing:
> 
>   $ pahole ./vmlinux -C work_struct
>   die__process_function: tag not supported (INVALID)!
>   struct work_struct {
>           atomic_long_t              data;                 /*     0     8 */
>           struct list_head           entry;                /*     8    16 */
>           work_func_t                func;                 /*    24     8 */
> 
> it's in 'dwarves' package
> 

Just FYI, perf probe gives you the offset too :)

# perf probe -D "work_busy work->func"
p:probe/work_busy _text+591936 func=+24(%di):x64

Anyway, this "symbol" type is also interesting. I'll pick it.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
