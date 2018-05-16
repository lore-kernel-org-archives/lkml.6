Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeEPNzk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbeEPNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:55:38 -0400
Date: Wed, 16 May 2018 09:55:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 10/14] tracing: Document trace_marker triggers
Message-ID: <20180516095534.676d7938@gandalf.local.home>
In-Reply-To: <1526334427.26800.15.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20180514205845.017925650@goodmis.org>
        <20180514205958.769987842@goodmis.org>
        <1526334427.26800.15.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 16:47:07 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Steve,
> 
> This is a nice new event feature - thanks for doing it!  Some minor typo
> comments below..

Can I get an Acked-by from you?



> > +3. User space creating a trigger
> > +--------------------------------
> > +
> > +Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
> > +ring buffer. This can also act like an event, by writing into the trigger
> > +file located in /sys/kernel/tracing/events/ftrace/print/
> > +
> > +Modifying cyclictest to write into the trace_marker file before it sleeps
> > +and after it wakes up, something like this:
> > +
> > +static void traceputs(char *str)
> > +{
> > +	/* tracemark_fd is the trace_marker file descripto */
> >   
> 
> Should be 'descriptor'?

Fixed.



> > + # ./cyclictest -p80 -d0 -i250 -n -a -t --tracemark -b 1000
> > +
> > + -p80  : run threads at priority 80
> > + -d0   : have all threads run at the same interval
> > + -i250 : start the interval at 250 microseconds (all threads will do this)
> > + -n    : sleep with nanosleep
> > + -a    : affine all threads to a separate CPU
> > + -t    : one thread per available CPU
> > + --tracemark : enable trace mark writing
> > + -b 1000 : stop if any latency is greater than 1000 microseconds
> > +
> > +Note, the -b 1000 is used just to make --tracemark available.
> > +
> > +The we can see the histogram created by this with:
> > +  
> 
> 'Then we can..

Fixed


> > +The difference this time is that instead of using the trace_marker to start
> > +the latency, the sched_waking event is used, matching the common_pid for the
> > +trace_marker write with the pid that is being worken by sched_waking.
> >   
> 
> s/worken/woken ?

Fixed. (It's kind of like Borken)

> 
> > 
> > +
> > +After running cyclictest again with the same parameters, we now have:
> > +
> > + # cat events/synthetic/latency/hist
> > +# event histogram
> > +#
> > +# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
> > +#
> > +
> > +{ lat:          7, common_pid:       2302 } hitcount:        640
> >   
> 
> snip
> 
> > 
> > +{ lat:         61, common_pid:       2302 } hitcount:          1
> > +{ lat:        110, common_pid:       2302 } hitcount:          1
> > +
> > +Totals:
> > +    Hits: 89565
> > +    Entries: 158
> > +    Dropped: 0
> > +
> > +This doesn't tell us any information about how late cyclictest may have
> > +worken up, but it does show us a nice histogram of how long it took from
> > +the time that cyclictest was worken to the time it made it into user space.
> >   
> 
> A couple more that don't seem to be 'worken' ;-)

I have an itchy 'r' finger.

Thanks for the review, I just updated this.

Oh, I guess I think I prefer a "Reviewed-by" tag instead of Ack (gives
a stronger meaning).

-- Steve
