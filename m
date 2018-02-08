Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeBHQW6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbeBHQWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:22:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C692621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 8 Feb 2018 13:22:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 11/20 v2] tracing: Add symbol type to function based
 events
Message-ID: <20180208162250.GA5132@kernel.org>
References: <20180207202402.253089656@goodmis.org>
 <20180207202816.348135328@goodmis.org>
 <20180208112031.GB30958@krava>
 <20180208105900.71a8ee8c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208105900.71a8ee8c@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 08, 2018 at 10:59:00AM -0500, Steven Rostedt escreveu:
> On Thu, 8 Feb 2018 12:20:31 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > +Symbols (function names)
> > > +========================
> > > +
> > > +To display kallsyms "%pS" type of output, use the special type "symbol".
> > > +
> > > +Again, using gdb to find the offset of the "func" field of struct work_struct
> > > +
> > > +(gdb) printf "%d\n", &((struct work_struct *)0)->func
> > > +24  
> > 
> > you could also use Arnaldo's pahole for this, seems like less typing:
> > 
> >   $ pahole ./vmlinux -C work_struct
> >   die__process_function: tag not supported (INVALID)!
> >   struct work_struct {
> >           atomic_long_t              data;                 /*     0     8 */
> >           struct list_head           entry;                /*     8    16 */
> >           work_func_t                func;                 /*    24     8 */
> > 
> > it's in 'dwarves' package
> 
> Nice, I'll have to document that:
> 
>  $ pahole ./vmlinux -C net_device |grep perm
>         unsigned char              perm_addr[32];        /*   558    32 */

You can also use just one .o file to speed things up instead of using
vmlinux, where it ill go on parsing stuff till it finds a .o with that
struct definition, i.e.:

[acme@jouet linux]$ pahole -C work_struct ../build/v4.15.0-rc9+/kernel/sys.o 
struct work_struct {
	atomic_long_t              data;                 /*     0     8 */
	struct list_head           entry;                /*     8    16 */
	work_func_t                func;                 /*    24     8 */

	/* size: 32, cachelines: 1, members: 3 */
	/* last cacheline: 32 bytes */
};

One may prefer hexadecimal numbers:

[acme@jouet linux]$ pahole --hex -C work_struct ../build/v4.15.0-rc9+/kernel/sys.o 
struct work_struct {
	atomic_long_t              data;                 /*     0   0x8 */
	struct list_head           entry;                /*   0x8  0x10 */
	work_func_t                func;                 /*  0x18   0x8 */

	/* size: 32, cachelines: 1, members: 3 */
	/* last cacheline: 32 bytes */
};
[acme@jouet linux]$

Or even expand everything and get offsets from that work_struct to
inside the list_head or other embedded types:

[acme@jouet linux]$ pahole -E --hex -C work_struct ../build/v4.15.0-rc9+/kernel/sys.o 
struct work_struct {
	/* typedef atomic_long_t -> atomic64_t */ struct {
		long int           counter;                                              /*     0   0x8 */
	} data; /*     0   0x8 */
	struct list_head {
		struct list_head * next;                                                 /*   0x8   0x8 */
		struct list_head * prev;                                                 /*  0x10   0x8 */
	} entry; /*   0x8  0x10 */
	/* typedef work_func_t */ void                       (*func)(struct work_struct *); /*  0x18   0x8 */

	/* size: 32, cachelines: 1, members: 3 */
	/* last cacheline: 32 bytes */
};
[acme@jouet linux]$ 

A long time ago I put the expansion of task_struct somewhere... yeah,
almost a decade ago, 2008, but it was not -E, was -p (i.e. expand
pointer types):

http://vger.kernel.org/~acme/vmlinux-expand_pointers-task_struct.txt

	/* size: 1680, cachelines: 27, members: 141 */
	/* sum members: 1641, holes: 10, sum holes: 39 */
	/* bit holes: 1, sum bit holes: 31 bits */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 16 bytes */
};

Anyway, now we have:

[acme@jouet linux]$ pahole -C task_struct ../build/v4.15.0-rc9+/kernel/sys.o  | tail -6
	struct thread_struct       thread;               /*  6592  4352 */

	/* size: 10944, cachelines: 171, members: 4 */
	/* sum members: 10896, holes: 1, sum holes: 48 */
	/* paddings: 1, sum paddings: 48 */
};
[acme@jouet linux]$

We have way more memory and features now :-)

The number of members is because now we have that randomize_struct stuff
that creates an unamed struct inside task_struct, so we have:

struct task_struct {
        struct thread_info         thread_info;          /*     0     8 */
        volatile long int          state;                /*     8     8 */

        /* XXX 48 bytes hole, try to pack */

        /* --- cacheline 1 boundary (64 bytes) --- */
        struct {
                void *             stack;                /*    64     8 */
                atomic_t           usage;                /*    72     4 */
<SNIP>
                int                pagefault_disabled;   /*  6504     4 */

                /* XXX 4 bytes hole, try to pack */

                struct task_struct * oom_reaper_list;    /*  6512     8 */
                struct vm_struct * stack_vm_area;        /*  6520     8 */
                /* --- cacheline 102 boundary (6528 bytes) --- */
                atomic_t           stack_refcount;       /*  6528     4 */

                /* XXX 4 bytes hole, try to pack */

                void *             security;             /*  6536     8 */
        };                                               /*    64  6528 */

        /* XXX last struct has 48 bytes of padding */

        /* --- cacheline 103 boundary (6592 bytes) --- */
        struct thread_struct       thread;               /*  6592  4352 */

        /* size: 10944, cachelines: 171, members: 4 */
        /* sum members: 10896, holes: 1, sum holes: 48 */
        /* paddings: 1, sum paddings: 48 */
};

So indeed, 'just' 4 members.

I guess I'll have to add some new mode where one can ask for unnamed
structs to be removed for the sake of --reorganize and the summary
information at the end, erm...

Anyway, digressed too much :-)

- Arnaldo
