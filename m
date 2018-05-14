Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeENVrL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:47:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:63767 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeENVrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:47:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="224207898"
Message-ID: <1526334427.26800.15.camel@tzanussi-mobl.amr.corp.intel.com>
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
Date: Mon, 14 May 2018 16:47:07 -0500
In-Reply-To: <20180514205958.769987842@goodmis.org>
References: <20180514205845.017925650@goodmis.org>
         <20180514205958.769987842@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

This is a nice new event feature - thanks for doing it!  Some minor typo
comments below..

On Mon, 2018-05-14 at 16:58 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add documentation and an example on how to use trace_marker triggers.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Documentation/trace/events.rst    |   6 +-
>  Documentation/trace/ftrace.rst    |   5 +
>  Documentation/trace/histogram.txt | 546 +++++++++++++++++++++++++++++-
>  3 files changed, 555 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index a5ea2cb0082b..1afae55dc55c 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -338,10 +338,14 @@ used for conditionally invoking triggers.
>  
>  The syntax for event triggers is roughly based on the syntax for
>  set_ftrace_filter 'ftrace filter commands' (see the 'Filter commands'
> -section of Documentation/trace/ftrace.txt), but there are major
> +section of Documentation/trace/ftrace.rst), but there are major
>  differences and the implementation isn't currently tied to it in any
>  way, so beware about making generalizations between the two.
>  
> +Note: Writing into trace_marker (See Documentation/trace/ftrace.rst)
> +     can also enable triggers that are written into
> +     /sys/kernel/tracing/events/ftrace/print/trigger
> +
>  6.1 Expression syntax
>  ---------------------
>  
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 67d9c38e95eb..aad4776c0f5d 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -507,6 +507,11 @@ of ftrace. Here is a list of some of the key files:
>  
>  		trace_fd = open("trace_marker", WR_ONLY);
>  
> +	Note: Writing into the trace_marker file can also initiate triggers
> +	      that are written into /sys/kernel/tracing/events/ftrace/print/trigger
> +	      See "Event triggers" in Documentation/trace/events.rst and an
> +              example in Documentation/trace/histogram.rst (Section 3.)
> +
>    trace_marker_raw:
>  
>  	This is similar to trace_marker above, but is meant for for binary data
> diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
> index 6e05510afc28..8c871f0c0e33 100644
> --- a/Documentation/trace/histogram.txt
> +++ b/Documentation/trace/histogram.txt
> @@ -1604,7 +1604,6 @@
>          Entries: 7
>          Dropped: 0
>  
> -
>  2.2 Inter-event hist triggers
>  -----------------------------
>  
> @@ -1993,3 +1992,548 @@ hist trigger specification.
>            Hits: 12970
>            Entries: 2
>            Dropped: 0
> +
> +3. User space creating a trigger
> +--------------------------------
> +
> +Writing into /sys/kernel/tracing/trace_marker writes into the ftrace
> +ring buffer. This can also act like an event, by writing into the trigger
> +file located in /sys/kernel/tracing/events/ftrace/print/
> +
> +Modifying cyclictest to write into the trace_marker file before it sleeps
> +and after it wakes up, something like this:
> +
> +static void traceputs(char *str)
> +{
> +	/* tracemark_fd is the trace_marker file descripto */
> 

Should be 'descriptor'?

> 
> +	if (tracemark_fd < 0)
> +		return;
> +	/* write the tracemark message */
> +	write(tracemark_fd, str, strlen(str));
> +}
> +
> +And later add something like:
> +
> +	traceputs("start");
> +	clock_nanosleep(...);
> +	traceputs("end");
> +
> +We can make a histogram from this:
> +
> + # cd /sys/kernel/tracing
> + # echo 'latency u64 lat' > synthetic_events
> + # echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
> + # echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
> + # echo 'hist:keys=lat,common_pid:sort=lat' > events/synthetic/latency/trigger
> +
> +The above created a synthetic event called "latency" and two histograms
> +against the trace_marker, one gets triggered when "start" is written into the
> +trace_marker file and the other when "end" is written. If the pids match, then
> +it will call the "latency" synthetic event with the calculated latency as its
> +parameter. Finally, a histogram is added to the latency synthetic event to
> +record the calculated latency along with the pid.
> +
> +Now running cyclictest with:
> +
> + # ./cyclictest -p80 -d0 -i250 -n -a -t --tracemark -b 1000
> +
> + -p80  : run threads at priority 80
> + -d0   : have all threads run at the same interval
> + -i250 : start the interval at 250 microseconds (all threads will do this)
> + -n    : sleep with nanosleep
> + -a    : affine all threads to a separate CPU
> + -t    : one thread per available CPU
> + --tracemark : enable trace mark writing
> + -b 1000 : stop if any latency is greater than 1000 microseconds
> +
> +Note, the -b 1000 is used just to make --tracemark available.
> +
> +The we can see the histogram created by this with:
> +

'Then we can..

> 
> + # cat events/synthetic/latency/hist
> +# event histogram
> +#
> +# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
> +#
> +
> +{ lat:        107, common_pid:       2039 } hitcount:          1
> 

snip

> 
> +{ lat:        289, common_pid:       2039 } hitcount:          1
> +{ lat:        300, common_pid:       2039 } hitcount:          1
> +{ lat:        384, common_pid:       2039 } hitcount:          1
> +
> +Totals:
> +    Hits: 67625
> +    Entries: 278
> +    Dropped: 0
> +
> +Note, the writes are around the sleep, so ideally they will all be of 250
> +microseconds. If you are wondering how there are several that are under
> +250 microseconds, that is because the way cyclictest works, is if one
> +iteration comes in late, the next one will set the timer to wake up less that
> +250. That is, if an iteration came in 50 microseconds late, the next wake up
> +will be at 200 microseconds.
> +
> +But this could easily be done in userspace. To make this even more
> +interesting, we can mix the histogram between events that happened in the
> +kernel with trace_marker.
> +
> + # cd /sys/kernel/tracing
> + # echo 'latency u64 lat' > synthetic_events
> + # echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
> + # echo '!hist:keys=common_pid:vals=hitcount:lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_switch).latency($lat) if buf == "end"' > events/ftrace/print/trigger

This seems out of place here - disabling an onmatch(sched.sched_switch)
trigger that you haven't mentioned before.

> 
> 
> # echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat) if buf == "end"' > events/ftrace/print/trigger
> + # echo 'hist:keys=lat,common_pid:sort=lat' > events/synthetic/latency/trigger
> +
> +The difference this time is that instead of using the trace_marker to start
> +the latency, the sched_waking event is used, matching the common_pid for the
> +trace_marker write with the pid that is being worken by sched_waking.
> 

s/worken/woken ?

> 
> +
> +After running cyclictest again with the same parameters, we now have:
> +
> + # cat events/synthetic/latency/hist
> +# event histogram
> +#
> +# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
> +#
> +
> +{ lat:          7, common_pid:       2302 } hitcount:        640
> 

snip

> 
> +{ lat:         61, common_pid:       2302 } hitcount:          1
> +{ lat:        110, common_pid:       2302 } hitcount:          1
> +
> +Totals:
> +    Hits: 89565
> +    Entries: 158
> +    Dropped: 0
> +
> +This doesn't tell us any information about how late cyclictest may have
> +worken up, but it does show us a nice histogram of how long it took from
> +the time that cyclictest was worken to the time it made it into user space.
> 

A couple more that don't seem to be 'worken' ;-)

Tom
