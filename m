Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeEPPWq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:22:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:41994 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752290AbeEPPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:22:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="56422769"
Message-ID: <1526484147.11544.6.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH v2 10/14] tracing: Document trace_marker triggers
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
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
Date: Wed, 16 May 2018 10:22:27 -0500
In-Reply-To: <20180516095534.676d7938@gandalf.local.home>
References: <20180514205845.017925650@goodmis.org>
         <20180514205958.769987842@goodmis.org>
         <1526334427.26800.15.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180516095534.676d7938@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2018-05-16 at 09:55 -0400, Steven Rostedt wrote:
> On Mon, 14 May 2018 16:47:07 -0500
> Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> 
> > Hi Steve,
> > 
> > This is a nice new event feature - thanks for doing it!  Some minor typo
> > comments below..
> 
> Can I get an Acked-by from you?
> 
> 
> 
> > > +3. User space creating a trigger
> > > +--------------------------------
> > > +
> > > +Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
> > > +ring buffer. This can also act like an event, by writing into the trigger
> > > +file located in /sys/kernel/tracing/events/ftrace/print/
> > > +
> > > +Modifying cyclictest to write into the trace_marker file before it sleeps
> > > +and after it wakes up, something like this:
> > > +
> > > +static void traceputs(char *str)
> > > +{
> > > +	/* tracemark_fd is the trace_marker file descripto */
> > >   
> > 
> > Should be 'descriptor'?
> 
> Fixed.
> 
> 
> 
> > > + # ./cyclictest -p80 -d0 -i250 -n -a -t --tracemark -b 1000
> > > +
> > > + -p80  : run threads at priority 80
> > > + -d0   : have all threads run at the same interval
> > > + -i250 : start the interval at 250 microseconds (all threads will do this)
> > > + -n    : sleep with nanosleep
> > > + -a    : affine all threads to a separate CPU
> > > + -t    : one thread per available CPU
> > > + --tracemark : enable trace mark writing
> > > + -b 1000 : stop if any latency is greater than 1000 microseconds
> > > +
> > > +Note, the -b 1000 is used just to make --tracemark available.
> > > +
> > > +The we can see the histogram created by this with:
> > > +  
> > 
> > 'Then we can..
> 
> Fixed
> 
> 
> > > +The difference this time is that instead of using the trace_marker to start
> > > +the latency, the sched_waking event is used, matching the common_pid for the
> > > +trace_marker write with the pid that is being worken by sched_waking.
> > >   
> > 
> > s/worken/woken ?
> 
> Fixed. (It's kind of like Borken)

:-)

> 
> > 
> > > 
> > > +
> > > +After running cyclictest again with the same parameters, we now have:
> > > +
> > > + # cat events/synthetic/latency/hist
> > > +# event histogram
> > > +#
> > > +# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
> > > +#
> > > +
> > > +{ lat:          7, common_pid:       2302 } hitcount:        640
> > >   
> > 
> > snip
> > 
> > > 
> > > +{ lat:         61, common_pid:       2302 } hitcount:          1
> > > +{ lat:        110, common_pid:       2302 } hitcount:          1
> > > +
> > > +Totals:
> > > +    Hits: 89565
> > > +    Entries: 158
> > > +    Dropped: 0
> > > +
> > > +This doesn't tell us any information about how late cyclictest may have
> > > +worken up, but it does show us a nice histogram of how long it took from
> > > +the time that cyclictest was worken to the time it made it into user space.
> > >   
> > 
> > A couple more that don't seem to be 'worken' ;-)
> 
> I have an itchy 'r' finger.
> 
> Thanks for the review, I just updated this.
> 
> Oh, I guess I think I prefer a "Reviewed-by" tag instead of Ack (gives
> a stronger meaning).

Sure, but noticed in the new version you just posted, that this line is
still in there for your second example:

+ # echo '!hist:keys=common_pid:vals=hitcount:lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_switch).latency($lat) if buf == "end"' > events/ftrace/print/trigger

Did you intend that, or am I missing something?

Anyway, you have my

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom
