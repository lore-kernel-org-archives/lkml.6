Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeBCPam (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:30:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751869AbeBCPaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:30:35 -0500
Date: Sat, 3 Feb 2018 16:30:31 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/3] perf tools: Fix period/freq terms setup
Message-ID: <20180203153031.GA5004@krava>
References: <20180201083812.11359-1-jolsa@kernel.org>
 <20180201083812.11359-2-jolsa@kernel.org>
 <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 10:45:46AM -0800, Stephane Eranian wrote:
> Jiri,
> 
> On Thu, Feb 1, 2018 at 12:38 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> > Stephane reported that we don't set properly PERIOD
> > sample type for events with period term defined.
> >
> > Before:
> >   $ perf record -e cpu/cpu-cycles,period=1000/u ls
> >   $ perf evlist -v
> >   cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...
> >
> > After:
> >   $ perf record -e cpu/cpu-cycles,period=1000/u ls
> >   $ perf evlist -v
> >   cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME, ...
> >
> > Setting PERIOD sample type based on period term setup.
> >
> there is still one problem remaining here. It has to do with the handling
> of cycles:pp or :p or :ppp. Suppose I want to set a period for it while I am
> also sampling on other events: Something like:
> 
> $ perf record -e
> cycles:pp,instructions,cpu/event=0xd0,umaks=0x81,period=100000/ .....
> 
> I want to set the period for cycles:pp, but not for instructions. I
> cannot use -c because
> it would also force a period on instructions. I could use the raw hw
> raw event code for cycles:pp.
> But that does not work because recent kernels prevent use of hw
> filters on events programmed
> for PEBS, e.g., cpu/event=0xc2,umask=0x1,cmask=16,inv/pp is rejected.
> PEBS does not support filters.
> It works in the case of cycles:pp simply by the nature on the
> underlying event and the stalls.
> 
> To get precise cycles, the only event syntax you can use is cycles:pp,
> but then you cannot specify
> an event-specific period. This needs to be fixed as well.

you can use p modifier behind like: cpu/.../pp

> 
> I'd like to be able to say:
> 
> $ perf record -e
> cycles:pp:period=10000001,cpu/event=0xd0,umaks=0x81,period=100000/
> 
> Or something equivalent.

and you can specify terms for hw events like 'cycles'

[jolsa@krava perf]$ sudo ./perf record -e 'cycles/period=10000001/pp,cpu/event=0xd0,umask=0x81,period=100000/'
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.579 MB perf.data (722 samples) ]

[jolsa@krava perf]$ ./perf evlist -v
cycles/period=10000001/pp: size: 112, { sample_period, sample_freq }: 10000001, sample_type: IP|TID|TIME|ID|CPU, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, task: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
cpu/event=0xd0,umask=0x81,period=100000/: type: 4, size: 112, config: 0x81d0, { sample_period, sample_freq }: 100000, sample_type: IP|TID|TIME|ID|CPU, read_format: ID, disabled: 1, inherit: 1, sample_id_all: 1, exclude_guest: 1

jirka
