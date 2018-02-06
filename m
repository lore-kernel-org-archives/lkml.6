Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeBFCvO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:51:14 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:52798 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeBFCvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:51:06 -0500
X-Google-Smtp-Source: AH8x2260JYudvxdLa0gP7/8IeR5ZNg4+BW+6jwgvj9yvBq3keLgrEU0D6eZfXWS3p7SktVzQkvTuvgCwWS4ZdH16slY=
MIME-Version: 1.0
In-Reply-To: <20180205211340.GD25353@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org> <20180201083812.11359-2-jolsa@kernel.org>
 <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
 <20180202202849.GA8297@kernel.org> <20180202204004.GB8297@kernel.org>
 <CABPqkBQniVqi_7OuEmWQohWSsnp17BkDMRYgOE1RQYE00GpuVw@mail.gmail.com>
 <20180205151720.GA29340@krava> <CABPqkBRDVfoTEfR-4XLkYKKbPenpFfQ0QkibSBO1iTTAYQbzLA@mail.gmail.com>
 <20180205211340.GD25353@kernel.org>
From: Stephane Eranian <eranian@google.com>
Date: Mon, 5 Feb 2018 18:51:05 -0800
Message-ID: <CABPqkBQ272K=f7eYzk1MkgG04sy_szkMuyyTmyNEVSyBdYo-Og@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tools: Fix period/freq terms setup
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 1:13 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Mon, Feb 05, 2018 at 12:58:16PM -0800, Stephane Eranian escreveu:
>> On Mon, Feb 5, 2018 at 7:17 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>> > On Fri, Feb 02, 2018 at 01:04:34PM -0800, Stephane Eranian wrote:
>> >> On Fri, Feb 2, 2018 at 12:40 PM, Arnaldo Carvalho de Melo
>> >> <acme@kernel.org> wrote:
>> >> > Em Fri, Feb 02, 2018 at 05:28:49PM -0300, Arnaldo Carvalho de Melo escreveu:
>> >> >> Em Fri, Feb 02, 2018 at 10:45:46AM -0800, Stephane Eranian escreveu:
>> >> >> > Otherwise, I tested what you have written so far and it works.
>> >> >
>> >> >> So I take that as a Tested-by: Stephane and will apply the patches, Jiri
>> >> >> can continue working on these other aspects, right?
>> >> >
>> >> > I also added this for the casual reader to get up to speed more quickly,
>> >> > please check that it makes sense.
>> >> >
>> >> >     Committer note:
>> >> >
>> >> >     When we use -c or a period=N term in the event definition, then we don't
>> >> >     need to ask the kernel, via perf_event_attr.sample_type |=
>> >> >     PERF_SAMPLE_PERIOD, to put the event period in each sample, as we know
>> >> >     it already, it is in perf_event_attr.sample_period.
>> >> >
>> >> Not quite. It depends on how each event is setup. I can mix & match period
>> >> and frequency. The PERF_SAMPLE_PERIOD can be dropped only if all the
>> >> events use a fixed period either via period=N or -c.
>
>> > I think you can have both period and freq based event in one session
>> > if that's your concern..? what would be the problem?
>
>> My understanding was that perf only support configs where all events
>> have the same attr.sample_type. With frequency mode, you'd want the period
>> recorded in some cases.
>
> [root@jouet ~]# perf record -e cycles/period=2/,instructions/freq=100/
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.895 MB perf.data (122 samples) ]
>
> [root@jouet ~]# perf report
> [root@jouet ~]# perf evlist -v
> cycles/period=2/: size: 112, { sample_period, sample_freq }: 2, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
> instructions/freq=100/: size: 112, config: 0x1, { sample_period, sample_freq }: 100, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, freq: 1, sample_id_all: 1, exclude_guest: 1
> [root@jouet ~]#
>
Looks like this is working then, great!

Now, related to profiling and reporting. There is still an issue I
keep running into
with grouping. I want to sample on N events, where N > number of  hw counters.
Yet I want the same output as perf report --group, i.e., side-by-side
profiles as
opposed to showing me one event profile at a time (which is not very useful).

You should not require events to belong to the same group to support this. Many
other tools support such output (e.g., VTUNE, Gooda). It is still very
valuable even
though events may not have been measured at the same time.

Let me use a simple (and silly but portable) example.
Today if I do on  Intel x86:

 $ perf record -e branches,branches,branches,branches,branches my_test

And I do:

$ perf report --group
It will show me 5 distinct profiles.

I would like perf to show me a single profile where the 5 events are
side-by-side.

Similar to what I get if I do instead:
$ perf record -e '{branches,branches,branches,branches}' my_test
$ perf report --group

But here, I would have to ensure all events fits in a group to allow
the reporting
I want. So that would limit me to 4 events.

I think perf report --group should work regardless of how the events
were grouped.
Is there already a way to work around this?

Thanks.

> commit ff3d527cebc1fa3707c617bfe9e74f53fcfb0955
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Tue Aug 27 11:23:07 2013 +0300
>
>     perf: make events stream always parsable
>
>     The event stream is not always parsable because the format of a sample
>     is dependent on the sample_type of the selected event.  When there is
>     more than one selected event and the sample_types are not the same then
>     parsing becomes problematic.  A sample can be matched to its selected
>     event using the ID that is allocated when the event is opened.
>     Unfortunately, to get the ID from the sample means first parsing it.
>
>     This patch adds a new sample format bit PERF_SAMPLE_IDENTIFER that puts
>     the ID at a fixed position so that the ID can be retrieved without
>     parsing the sample.  For sample events, that is the first position
>     immediately after the header.  For non-sample events, that is the last
>     position.
>
>     In this respect parsing samples requires that the sample_type and ID
>     values are recorded.  For example, perf tools records struct
>     perf_event_attr and the IDs within the perf.data file.  Those must be
>     read first before it is possible to parse samples found later in the
>     perf.data file.
>
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Tested-by: Stephane Eranian <eranian@google.com>
>     Acked-by: Peter Zijlstra <peterz@infradead.org>
>
