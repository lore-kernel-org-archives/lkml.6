Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCIIiX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:38:23 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33940 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeCIIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:38:18 -0500
X-Google-Smtp-Source: AG47ELvc0EggfLWUA9dZXwALXFyoIwTZprpZ5VGTwa8vp6cdIcz/Nyezcf6NNFP+eCMrJt4ODXo5FA==
Date: Fri, 9 Mar 2018 09:38:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Show zero counters as well in 'perf report
 --stat'
Message-ID: <20180309083814.d6dzbaqcsyfo3cza@gmail.com>
References: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
 <20180307154338.GM3701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307154338.GM3701@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> >             STAT events:          0
> >       STAT_ROUND events:          0
> >     EVENT_UPDATE events:          0
> >        TIME_CONV events:          1
> >          FEATURE events:          0
> > 
> > It's pretty clear at a glance that LOST_SAMPLES is present but zero.
> 
> Your wording confused me a bit, that "is present" part, because there
> are some PERF_RECORD_ events that will only be "present" if we actually
> explicitely ask them to be, by setting flags in perf_event_attr, like:
> 
> 				mmap           :  1, /* include mmap data     */
> 				comm	       :  1, /* include comm data     */
> 				task           :  1, /* trace fork/exit       */
> 				mmap_data      :  1, /* non-exec mmap data    */
> 				sample_id_all  :  1, /* sample_type all events */
> 				mmap2          :  1, /* include mmap with inode data     */
> 				comm_exec      :  1, /* flag comm events that are due to an exec */
> 				context_switch :  1, /* context switch data */
> 				namespaces     :  1, /* include namespaces data */
> 
> So, for PERF_RECORD_MMAP2 events, one can say that it is "present but
> zero" if we have an event with perf_event_attr.mmap2 = 1 and no
> PERF_RECORD_MMAP2 events recorded.
> 
> But for PERF_RECORD_LOST, that will always be present, if we lose
> records.

Yeah, the triple ambiguity between:

  -    did the event disappear due to 'we did not lose any records',
  - or did it disappear because it's somehow a conditional stat field,
  - or did it disappear because I'm blind and/or mis-remembering the field name.

... is what was causing trouble to me personally, to the level that I had to go 
and look into the tooling code to make sure I'm interpreting it correctly.

> So perhaps to make all this clean we can add your patch, and on top of
> it another that shows the perf_record_attr flag for the ones that are
> not on all the time, something like:
> 
>    fomalhaut:~> perf report --stat
>  
>    Aggregated stats:
>             TOTAL events:     495984
>              MMAP events:         85	attr.mmap: 1
>              LOST events:          0
>              COMM events:       3389	attr.comm: 1, attr.comm_exec: 0
>              EXIT events:       1605    attr.task: 1
>          THROTTLE events:          2
>        UNTHROTTLE events:          2
>              FORK events:       3377	attr.task: 1
>              READ events:          0
>            SAMPLE events:     472629
>             MMAP2 events:      14753	attr.mmap2: 1
>               AUX events:          0    have to look at what enables this, etc
>      ITRACE_START events:          0	ditto
>      LOST_SAMPLES events:          0
>            SWITCH events:          0	attr.context_switch: 0
>   SWITCH_CPU_WIDE events:          0	attr.context_switch: 0
>        NAMESPACES events:          0	attr.namespaces: 0
>              ATTR events:          0
>        EVENT_TYPE events:          0
>      TRACING_DATA events:          0
>          BUILD_ID events:          0	this implies disabling in 'perf record' command line
>    FINISHED_ROUND events:        139
>          ID_INDEX events:          0
>     AUXTRACE_INFO events:          0
>          AUXTRACE events:          0
>    AUXTRACE_ERROR events:          0
>        THREAD_MAP events:          1
>           CPU_MAP events:          1
>       STAT_CONFIG events:          0
>              STAT events:          0
>        STAT_ROUND events:          0
>      EVENT_UPDATE events:          0
>         TIME_CONV events:          1	have to check
>           FEATURE events:          0

Yeah, I'm fine with this too if it's easy enough to implement - although I suspect 
in most cases the knowledge that a stat field not present must be due to an 
environment/setup dependency (and not a runtime/workload dependency) is enough.

It's the uncertainty of 'stat line can disappear because it was zero' that was my 
main beef :-)

Thanks,

	Ingo
