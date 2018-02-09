Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBIShP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeBIShO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:37:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7056C2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Feb 2018 15:37:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf report: Add support to display group output for non
 group events
Message-ID: <20180209183711.GN3451@kernel.org>
References: <20180202202849.GA8297@kernel.org>
 <20180202204004.GB8297@kernel.org>
 <CABPqkBQniVqi_7OuEmWQohWSsnp17BkDMRYgOE1RQYE00GpuVw@mail.gmail.com>
 <20180205151720.GA29340@krava>
 <CABPqkBRDVfoTEfR-4XLkYKKbPenpFfQ0QkibSBO1iTTAYQbzLA@mail.gmail.com>
 <20180205211340.GD25353@kernel.org>
 <CABPqkBQ272K=f7eYzk1MkgG04sy_szkMuyyTmyNEVSyBdYo-Og@mail.gmail.com>
 <20180206093553.GA8065@krava>
 <CABPqkBTXhL1U0HBbc2J0mdpGDiC2LG=Cm8MN+Pp_K=a_euDuUg@mail.gmail.com>
 <20180209092734.GB20449@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209092734.GB20449@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 09, 2018 at 10:27:34AM +0100, Jiri Olsa escreveu:
> On Wed, Feb 07, 2018 at 10:52:35AM -0800, Stephane Eranian wrote:
> 
> SNIP
> 
> > >> Similar to what I get if I do instead:
> > >> $ perf record -e '{branches,branches,branches,branches}' my_test
> > >> $ perf report --group
> > >>
> > >> But here, I would have to ensure all events fits in a group to allow
> > >> the reporting
> > >> I want. So that would limit me to 4 events.
> > >>
> > >> I think perf report --group should work regardless of how the events
> > >> were grouped.
> > >> Is there already a way to work around this?
> > >
> > > no workaround.. please try attached patch, it seems
> > > to work for what you described
> > >
> > Works for me. That's great!
> > Thanks.
> > 
> > Tested-By: Stephane Eranian <eranian@google.com>
> 
> thanks, full patch attached
> 
> jirka

Humm, its a nice hack, but it would be even better if it didn't showed
it as if it was really a group:

  Samples: 20  of event 'anon group { cycles, instructions }', Event count (approx.): 4712980

It would be better to instead add another condition to the evlist that
would trigger the view with all the examples...

I'm applying it anyway, as it is useful, but would be nice to have the
same output except for that header, that should read instead:

  Samples: 20  of non grouped events: cycles, instructions, Event count (approx.): 4712980

- Arnaldo

 
> 
> ---
> Add support to display group output for if non grouped events
> are detected and user forces --group option. Now for non-group
> events recorded like:
> 
>   $ perf record -e 'cycles,instructions' ls
> 
> you can still get group output by using --group option
> in report:
> 
>   $ perf report --group --stdio
>   ...
>   #         Overhead  Command  Shared Object     Symbol
>   # ................  .......  ................  ......................
>   #
>       17.67%   0.00%  ls       libc-2.25.so      [.] _IO_do_write@@GLIB
>       15.59%  25.94%  ls       ls                [.] calculate_columns
>       15.41%  31.35%  ls       libc-2.25.so      [.] __strcoll_l
>   ...
> 
> Requested-and-Tested-by: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-m1ffikw8c3a55b3uaxrmk5w3@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt | 3 ++-
>  tools/perf/builtin-report.c              | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 907e505b6309..a76b871f78a6 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -354,7 +354,8 @@ OPTIONS
>          Path to objdump binary.
>  
>  --group::
> -	Show event group information together.
> +	Show event group information together. It forces group output also
> +	if there are no groups defined in data file.
>  
>  --demangle::
>  	Demangle symbol names to human readable form. It's enabled by default,
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 8ef71669e7a0..1eedb1815c4c 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -938,6 +938,7 @@ int cmd_report(int argc, const char **argv)
>  		"perf report [<options>]",
>  		NULL
>  	};
> +	bool group_set = false;
>  	struct report report = {
>  		.tool = {
>  			.sample		 = process_sample_event,
> @@ -1057,7 +1058,7 @@ int cmd_report(int argc, const char **argv)
>  		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>  	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
>  		    "Show a column with the sum of periods"),
> -	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
> +	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &group_set,
>  		    "Show event group information together"),
>  	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
>  		    "use branch records for per branch histogram filling",
> @@ -1174,6 +1175,9 @@ int cmd_report(int argc, const char **argv)
>  	has_br_stack = perf_header__has_feat(&session->header,
>  					     HEADER_BRANCH_STACK);
>  
> +	if (group_set && !session->evlist->nr_groups)
> +		perf_evlist__set_leader(session->evlist);
> +
>  	if (itrace_synth_opts.last_branch)
>  		has_br_stack = true;
>  
> -- 
> 2.13.6
