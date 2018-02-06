Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeBFJgH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbeBFJf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:35:57 -0500
Date: Tue, 6 Feb 2018 10:35:53 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 1/3] perf tools: Fix period/freq terms setup
Message-ID: <20180206093553.GA8065@krava>
References: <20180201083812.11359-1-jolsa@kernel.org>
 <20180201083812.11359-2-jolsa@kernel.org>
 <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
 <20180202202849.GA8297@kernel.org>
 <20180202204004.GB8297@kernel.org>
 <CABPqkBQniVqi_7OuEmWQohWSsnp17BkDMRYgOE1RQYE00GpuVw@mail.gmail.com>
 <20180205151720.GA29340@krava>
 <CABPqkBRDVfoTEfR-4XLkYKKbPenpFfQ0QkibSBO1iTTAYQbzLA@mail.gmail.com>
 <20180205211340.GD25353@kernel.org>
 <CABPqkBQ272K=f7eYzk1MkgG04sy_szkMuyyTmyNEVSyBdYo-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ272K=f7eYzk1MkgG04sy_szkMuyyTmyNEVSyBdYo-Og@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 06:51:05PM -0800, Stephane Eranian wrote:

SNIP

> >
> Looks like this is working then, great!
> 
> Now, related to profiling and reporting. There is still an issue I
> keep running into
> with grouping. I want to sample on N events, where N > number of  hw counters.
> Yet I want the same output as perf report --group, i.e., side-by-side
> profiles as
> opposed to showing me one event profile at a time (which is not very useful).
> 
> You should not require events to belong to the same group to support this. Many
> other tools support such output (e.g., VTUNE, Gooda). It is still very
> valuable even
> though events may not have been measured at the same time.
> 
> Let me use a simple (and silly but portable) example.
> Today if I do on  Intel x86:
> 
>  $ perf record -e branches,branches,branches,branches,branches my_test
> 
> And I do:
> 
> $ perf report --group
> It will show me 5 distinct profiles.
> 
> I would like perf to show me a single profile where the 5 events are
> side-by-side.
> 
> Similar to what I get if I do instead:
> $ perf record -e '{branches,branches,branches,branches}' my_test
> $ perf report --group
> 
> But here, I would have to ensure all events fits in a group to allow
> the reporting
> I want. So that would limit me to 4 events.
> 
> I think perf report --group should work regardless of how the events
> were grouped.
> Is there already a way to work around this?

no workaround.. please try attached patch, it seems
to work for what you described

thanks,
jirka


---
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4ad5dc649716..35a013992092 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -937,6 +937,7 @@ int cmd_report(int argc, const char **argv)
 		"perf report [<options>]",
 		NULL
 	};
+	bool group_set = false;
 	struct report report = {
 		.tool = {
 			.sample		 = process_sample_event,
@@ -1056,7 +1057,7 @@ int cmd_report(int argc, const char **argv)
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
-	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
+	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &group_set,
 		    "Show event group information together"),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
@@ -1173,6 +1174,9 @@ int cmd_report(int argc, const char **argv)
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
 
+	if (group_set && !session->evlist->nr_groups)
+		perf_evlist__set_leader(session->evlist);
+
 	if (itrace_synth_opts.last_branch)
 		has_br_stack = true;
 
