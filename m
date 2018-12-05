Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A94C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649CD20834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHa86hL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649CD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeLECmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:42:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:42:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so9299291plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 18:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vAkVSMpKp0bT/ZPz3JLKcBfo7BA15bdk+E9nrEkPO4k=;
        b=UHa86hL2ekOolp9esHCiV0BW6h+rk24fJargeozGOGBF9locjSlVenLJhn0LjWldVc
         QAiezmy5gr+gmsKWB43VDkI902VTO5CqK/StQ5WNxtGPrJEMAjApqmzbJdStr+Yuarl/
         BYzetIkuPDOkdlKgfzZmdR3IgfhBA4560PRzGZSbK1Gktp8C2+cPY+yDsL51CEESrKls
         dK5irEcOxD82pZhF3Ujq6PKe718DY2H3kojJ8yzrzcPpcXMD7rhe8Q02sIoShwkXARON
         ZLR4vwUOiKDhPdq/VtsFeYxxdqGKtZTs6bP/aSpYOsQAsp4XKUDg1CoMy5/vUanQzW+h
         on0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAkVSMpKp0bT/ZPz3JLKcBfo7BA15bdk+E9nrEkPO4k=;
        b=ttQl3x1YfrFFDJ4zhVPgaIDUNBV5cBsxmcy1MstLlgzd8CTjlp9LKdHnvBT6vJeLda
         JoDVycvDQMkiuPw/VoIPil6YpK1C6nzfGZ3RdE2vwM3hjU9CudyWo2Bik7wtxAvk/JFD
         XUV+vazqhqT46GrOIuDI3sAiE5OkuKpSul3upeU8VdiFPbDeVspsRLUqYdrmePbGP/2Z
         hXEUXFyg8NfTsLbt0D9Ci+ea3WoKmA1EBPjhznf4eWj3VJI1JlqxeyNHBjEGbcrHOsNO
         +wlf1BuVPGo2h3mROHg1JqvBR95w9mORSsay10WsczH6Lwq+HwfTwj/UAYmszRqaSxND
         2+8g==
X-Gm-Message-State: AA+aEWaYD9IXFwd6610zLEbpvr4kjtMChbLuzPn8i6V8M5uk+/jmOiYd
        qyV6g+QHjsfX23KbPgSss5/GLwcw
X-Google-Smtp-Source: AFSGD/UIZIIrdt4d3Tigsk3eihU49UbVy5i2EZTGOvaz1k+SWDzKudv9yT4JbavVsW+aVr1l7tWP5g==
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr10790471plb.311.1543977748847;
        Tue, 04 Dec 2018 18:42:28 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id c13sm25817539pfo.121.2018.12.04.18.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 18:42:27 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:42:22 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Mark Drayton <mbd@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] perf: allow specifying proc-map-timeout in config file
Message-ID: <20181205024222.GA32453@danjae.aot.lge.com>
References: <20181204203420.1683114-1-mbd@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181204203420.1683114-1-mbd@fb.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 04, 2018 at 12:34:20PM -0800, Mark Drayton wrote:
> The default timeout of 500ms for parsing /proc/<pid>/maps files is too
> short for profiling many of our services. This can be overridden by
> passing --proc-map-timeout to the relevant command but it'd be nice to
> globally increase our default value. This patch permits setting a
> different default with the core.proc-map-timeout config file parameter.
> 
> Signed-off-by: Mark Drayton <mbd@fb.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Documentation/perf-config.txt |  6 +++++
>  tools/perf/builtin-kvm.c                 |  6 ++---
>  tools/perf/builtin-record.c              |  8 +++---
>  tools/perf/builtin-top.c                 |  4 +--
>  tools/perf/builtin-trace.c               |  5 ++--
>  tools/perf/perf.h                        |  1 -
>  tools/perf/tests/code-reading.c          |  2 +-
>  tools/perf/tests/dwarf-unwind.c          |  2 +-
>  tools/perf/tests/mmap-thread-lookup.c    |  4 +--
>  tools/perf/util/config.c                 |  4 +++
>  tools/perf/util/event.c                  | 32 ++++++++++--------------
>  tools/perf/util/event.h                  |  8 +++---
>  tools/perf/util/machine.c                |  4 +--
>  tools/perf/util/machine.h                |  3 ---
>  14 files changed, 39 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 32f4a898e3f2..661b1fb3f8ba 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -199,6 +199,12 @@ colors.*::
>  		Colors for headers in the output of a sub-commands (top, report).
>  		Default values are 'white', 'blue'.
>  
> +core.*::
> +	core.proc-map-timeout::
> +		Sets a timeout (in milliseconds) for parsing /proc/<pid>/maps files.
> +		Can be overridden by the --proc-map-timeout option on supported
> +		subcommands. The default timeout is 500ms.
> +
>  tui.*, gtk.*::
>  	Subcommands that can be configured here are 'top', 'report' and 'annotate'.
>  	These values are booleans, for example:
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 2b1ef704169f..3d4cbc4e87c7 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -1364,7 +1364,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
>  			"show events other than"
>  			" HLT (x86 only) or Wait state (s390 only)"
>  			" that take longer than duration usecs"),
> -		OPT_UINTEGER(0, "proc-map-timeout", &kvm->opts.proc_map_timeout,
> +		OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
>  				"per thread proc mmap processing timeout in ms"),
>  		OPT_END()
>  	};
> @@ -1394,7 +1394,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
>  	kvm->opts.target.uses_mmap = false;
>  	kvm->opts.target.uid_str = NULL;
>  	kvm->opts.target.uid = UINT_MAX;
> -	kvm->opts.proc_map_timeout = 500;
>  
>  	symbol__init(NULL);
>  	disable_buildid_cache();
> @@ -1453,8 +1452,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
>  	perf_session__set_id_hdr_size(kvm->session);
>  	ordered_events__set_copy_on_queue(&kvm->session->ordered_events, true);
>  	machine__synthesize_threads(&kvm->session->machines.host, &kvm->opts.target,
> -				    kvm->evlist->threads, false,
> -				    kvm->opts.proc_map_timeout, 1);
> +				    kvm->evlist->threads, false, 1);
>  	err = kvm_live_open_events(kvm);
>  	if (err)
>  		goto out;
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 488779bc4c8d..ebb8922d436b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -641,8 +641,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
>  	err = perf_event__synthesize_thread_map(&rec->tool, thread_map,
>  						 process_synthesized_event,
>  						 &rec->session->machines.host,
> -						 rec->opts.sample_address,
> -						 rec->opts.proc_map_timeout);
> +						 rec->opts.sample_address);
>  	thread_map__put(thread_map);
>  	return err;
>  }
> @@ -857,7 +856,7 @@ static int record__synthesize(struct record *rec, bool tail)
>  
>  	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
>  					    process_synthesized_event, opts->sample_address,
> -					    opts->proc_map_timeout, 1);
> +					    1);
>  out:
>  	return err;
>  }
> @@ -1546,7 +1545,6 @@ static struct record record = {
>  			.uses_mmap   = true,
>  			.default_per_cpu = true,
>  		},
> -		.proc_map_timeout     = 500,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -1676,7 +1674,7 @@ static struct option __record_options[] = {
>  	parse_clockid),
>  	OPT_STRING_OPTARG('S', "snapshot", &record.opts.auxtrace_snapshot_opts,
>  			  "opts", "AUX area tracing Snapshot Mode", ""),
> -	OPT_UINTEGER(0, "proc-map-timeout", &record.opts.proc_map_timeout,
> +	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
>  			"per thread proc mmap processing timeout in ms"),
>  	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
>  		    "Record namespaces events"),
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index aa0c73e57924..a8e48dbd5b66 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1096,7 +1096,6 @@ static int __cmd_top(struct perf_top *top)
>  
>  	machine__synthesize_threads(&top->session->machines.host, &opts->target,
>  				    top->evlist->threads, false,
> -				    opts->proc_map_timeout,
>  				    top->nr_threads_synthesize);
>  
>  	if (top->nr_threads_synthesize > 1)
> @@ -1256,7 +1255,6 @@ int cmd_top(int argc, const char **argv)
>  			.target		= {
>  				.uses_mmap   = true,
>  			},
> -			.proc_map_timeout    = 500,
>  			/*
>  			 * FIXME: This will lose PERF_RECORD_MMAP and other metadata
>  			 * when we pause, fix that and reenable. Probably using a
> @@ -1367,7 +1365,7 @@ int cmd_top(int argc, const char **argv)
>  	OPT_STRING('w', "column-widths", &symbol_conf.col_width_list_str,
>  		   "width[,width...]",
>  		   "don't try to adjust column width, use these fixed values"),
> -	OPT_UINTEGER(0, "proc-map-timeout", &opts->proc_map_timeout,
> +	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
>  			"per thread proc mmap processing timeout in ms"),
>  	OPT_CALLBACK_NOOPT('b', "branch-any", &opts->branch_stack,
>  		     "branch any", "sample any taken branches",
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8e3c3f74a3a4..414780649987 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1264,7 +1264,7 @@ static int trace__symbols_init(struct trace *trace, struct perf_evlist *evlist)
>  
>  	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
>  					    evlist->threads, trace__tool_process, false,
> -					    trace->opts.proc_map_timeout, 1);
> +					    1);
>  out:
>  	if (err)
>  		symbol__exit();
> @@ -3393,7 +3393,6 @@ int cmd_trace(int argc, const char **argv)
>  			.user_interval = ULLONG_MAX,
>  			.no_buffering  = true,
>  			.mmap_pages    = UINT_MAX,
> -			.proc_map_timeout  = 500,
>  		},
>  		.output = stderr,
>  		.show_comm = true,
> @@ -3464,7 +3463,7 @@ int cmd_trace(int argc, const char **argv)
>  		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
>  	OPT_BOOLEAN(0, "print-sample", &trace.print_sample,
>  			"print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info, for debugging"),
> -	OPT_UINTEGER(0, "proc-map-timeout", &trace.opts.proc_map_timeout,
> +	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
>  			"per thread proc mmap processing timeout in ms"),
>  	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
>  		     trace__parse_cgroups),
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 0ed4a34c74c4..3bac760fa872 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -82,7 +82,6 @@ struct record_opts {
>  	bool         use_clockid;
>  	clockid_t    clockid;
>  	u64          clockid_res_ns;
> -	unsigned int proc_map_timeout;
>  };
>  
>  struct option;
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 6b049f3f5cf4..dbf2c69944d2 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -599,7 +599,7 @@ static int do_test_code_reading(bool try_kcore)
>  	}
>  
>  	ret = perf_event__synthesize_thread_map(NULL, threads,
> -						perf_event__process, machine, false, 500);
> +						perf_event__process, machine, false);
>  	if (ret < 0) {
>  		pr_debug("perf_event__synthesize_thread_map failed\n");
>  		goto out_err;
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index 2f008067d989..7c8d2e422401 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -34,7 +34,7 @@ static int init_live_machine(struct machine *machine)
>  	pid_t pid = getpid();
>  
>  	return perf_event__synthesize_mmap_events(NULL, &event, pid, pid,
> -						  mmap_handler, machine, true, 500);
> +						  mmap_handler, machine, true);
>  }
>  
>  /*
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index b1af2499a3c9..5ede9b561d32 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -132,7 +132,7 @@ static int synth_all(struct machine *machine)
>  {
>  	return perf_event__synthesize_threads(NULL,
>  					      perf_event__process,
> -					      machine, 0, 500, 1);
> +					      machine, 0, 1);
>  }
>  
>  static int synth_process(struct machine *machine)
> @@ -144,7 +144,7 @@ static int synth_process(struct machine *machine)
>  
>  	err = perf_event__synthesize_thread_map(NULL, map,
>  						perf_event__process,
> -						machine, 0, 500);
> +						machine, 0);
>  
>  	thread_map__put(map);
>  	return err;
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 5ac157056cdf..3beb4cf44c31 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -14,6 +14,7 @@
>  #include "util.h"
>  #include "cache.h"
>  #include <subcmd/exec-cmd.h>
> +#include "util/event.h"  /* proc_map_timeout */
>  #include "util/hist.h"  /* perf_hist_config */
>  #include "util/llvm-utils.h"   /* perf_llvm_config */
>  #include "config.h"
> @@ -419,6 +420,9 @@ static int perf_buildid_config(const char *var, const char *value)
>  static int perf_default_core_config(const char *var __maybe_unused,
>  				    const char *value __maybe_unused)
>  {
> +	if (!strcmp(var, "core.proc-map-timeout"))
> +		proc_map_timeout = strtoul(value, NULL, 10);
> +
>  	/* Add other config variables here. */
>  	return 0;
>  }
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index e9c108a6b1c3..552b4d127121 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -25,6 +25,8 @@
>  #include "asm/bug.h"
>  #include "stat.h"
>  
> +#define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
> +
>  static const char *perf_event__names[] = {
>  	[0]					= "TOTAL",
>  	[PERF_RECORD_MMAP]			= "MMAP",
> @@ -72,6 +74,8 @@ static const char *perf_ns__names[] = {
>  	[CGROUP_NS_INDEX]	= "cgroup",
>  };
>  
> +unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
> +
>  const char *perf_event__name(unsigned int id)
>  {
>  	if (id >= ARRAY_SIZE(perf_event__names))
> @@ -323,8 +327,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       pid_t pid, pid_t tgid,
>  				       perf_event__handler_t process,
>  				       struct machine *machine,
> -				       bool mmap_data,
> -				       unsigned int proc_map_timeout)
> +				       bool mmap_data)
>  {
>  	char filename[PATH_MAX];
>  	FILE *fp;
> @@ -521,8 +524,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  				      perf_event__handler_t process,
>  				      struct perf_tool *tool,
>  				      struct machine *machine,
> -				      bool mmap_data,
> -				      unsigned int proc_map_timeout)
> +				      bool mmap_data)
>  {
>  	char filename[PATH_MAX];
>  	DIR *tasks;
> @@ -548,8 +550,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  		 */
>  		if (pid == tgid &&
>  		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
> -						       process, machine, mmap_data,
> -						       proc_map_timeout))
> +						       process, machine, mmap_data))
>  			return -1;
>  
>  		return 0;
> @@ -598,7 +599,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
>  		if (_pid == pid) {
>  			/* process the parent's maps too */
>  			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
> -						process, machine, mmap_data, proc_map_timeout);
> +						process, machine, mmap_data);
>  			if (rc)
>  				break;
>  		}
> @@ -612,8 +613,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  				      struct thread_map *threads,
>  				      perf_event__handler_t process,
>  				      struct machine *machine,
> -				      bool mmap_data,
> -				      unsigned int proc_map_timeout)
> +				      bool mmap_data)
>  {
>  	union perf_event *comm_event, *mmap_event, *fork_event;
>  	union perf_event *namespaces_event;
> @@ -643,7 +643,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  					       fork_event, namespaces_event,
>  					       thread_map__pid(threads, thread), 0,
>  					       process, tool, machine,
> -					       mmap_data, proc_map_timeout)) {
> +					       mmap_data)) {
>  			err = -1;
>  			break;
>  		}
> @@ -669,7 +669,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  						       fork_event, namespaces_event,
>  						       comm_event->comm.pid, 0,
>  						       process, tool, machine,
> -						       mmap_data, proc_map_timeout)) {
> +						       mmap_data)) {
>  				err = -1;
>  				break;
>  			}
> @@ -690,7 +690,6 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
>  					    perf_event__handler_t process,
>  					    struct machine *machine,
>  					    bool mmap_data,
> -					    unsigned int proc_map_timeout,
>  					    struct dirent **dirent,
>  					    int start,
>  					    int num)
> @@ -734,8 +733,7 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
>  		 */
>  		__event__synthesize_thread(comm_event, mmap_event, fork_event,
>  					   namespaces_event, pid, 1, process,
> -					   tool, machine, mmap_data,
> -					   proc_map_timeout);
> +					   tool, machine, mmap_data);
>  	}
>  	err = 0;
>  
> @@ -755,7 +753,6 @@ struct synthesize_threads_arg {
>  	perf_event__handler_t process;
>  	struct machine *machine;
>  	bool mmap_data;
> -	unsigned int proc_map_timeout;
>  	struct dirent **dirent;
>  	int num;
>  	int start;
> @@ -767,7 +764,7 @@ static void *synthesize_threads_worker(void *arg)
>  
>  	__perf_event__synthesize_threads(args->tool, args->process,
>  					 args->machine, args->mmap_data,
> -					 args->proc_map_timeout, args->dirent,
> +					 args->dirent,
>  					 args->start, args->num);
>  	return NULL;
>  }
> @@ -776,7 +773,6 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>  				   perf_event__handler_t process,
>  				   struct machine *machine,
>  				   bool mmap_data,
> -				   unsigned int proc_map_timeout,
>  				   unsigned int nr_threads_synthesize)
>  {
>  	struct synthesize_threads_arg *args = NULL;
> @@ -806,7 +802,6 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>  	if (thread_nr <= 1) {
>  		err = __perf_event__synthesize_threads(tool, process,
>  						       machine, mmap_data,
> -						       proc_map_timeout,
>  						       dirent, base, n);
>  		goto free_dirent;
>  	}
> @@ -828,7 +823,6 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>  		args[i].process = process;
>  		args[i].machine = machine;
>  		args[i].mmap_data = mmap_data;
> -		args[i].proc_map_timeout = proc_map_timeout;
>  		args[i].dirent = dirent;
>  	}
>  	for (i = 0; i < m; i++) {
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index bfa60bcafbde..eb95f3384958 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -669,8 +669,7 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool,
>  int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  				      struct thread_map *threads,
>  				      perf_event__handler_t process,
> -				      struct machine *machine, bool mmap_data,
> -				      unsigned int proc_map_timeout);
> +				      struct machine *machine, bool mmap_data);
>  int perf_event__synthesize_thread_map2(struct perf_tool *tool,
>  				      struct thread_map *threads,
>  				      perf_event__handler_t process,
> @@ -682,7 +681,6 @@ int perf_event__synthesize_cpu_map(struct perf_tool *tool,
>  int perf_event__synthesize_threads(struct perf_tool *tool,
>  				   perf_event__handler_t process,
>  				   struct machine *machine, bool mmap_data,
> -				   unsigned int proc_map_timeout,
>  				   unsigned int nr_threads_synthesize);
>  int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  				       perf_event__handler_t process,
> @@ -797,8 +795,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  				       pid_t pid, pid_t tgid,
>  				       perf_event__handler_t process,
>  				       struct machine *machine,
> -				       bool mmap_data,
> -				       unsigned int proc_map_timeout);
> +				       bool mmap_data);
>  
>  int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
>  				       perf_event__handler_t process,
> @@ -829,5 +826,6 @@ int perf_event_paranoid(void);
>  
>  extern int sysctl_perf_event_max_stack;
>  extern int sysctl_perf_event_max_contexts_per_stack;
> +extern unsigned int proc_map_timeout;
>  
>  #endif /* __PERF_RECORD_H */
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8f36ce813bc5..8551b3e75bb2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2493,15 +2493,13 @@ int machines__for_each_thread(struct machines *machines,
>  int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
>  				  struct target *target, struct thread_map *threads,
>  				  perf_event__handler_t process, bool data_mmap,
> -				  unsigned int proc_map_timeout,
>  				  unsigned int nr_threads_synthesize)
>  {
>  	if (target__has_task(target))
> -		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap, proc_map_timeout);
> +		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap);
>  	else if (target__has_cpu(target))
>  		return perf_event__synthesize_threads(tool, process,
>  						      machine, data_mmap,
> -						      proc_map_timeout,
>  						      nr_threads_synthesize);
>  	/* command specified */
>  	return 0;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index d856b85862e2..688d84ba823a 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -247,17 +247,14 @@ int machines__for_each_thread(struct machines *machines,
>  int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
>  				  struct target *target, struct thread_map *threads,
>  				  perf_event__handler_t process, bool data_mmap,
> -				  unsigned int proc_map_timeout,
>  				  unsigned int nr_threads_synthesize);
>  static inline
>  int machine__synthesize_threads(struct machine *machine, struct target *target,
>  				struct thread_map *threads, bool data_mmap,
> -				unsigned int proc_map_timeout,
>  				unsigned int nr_threads_synthesize)
>  {
>  	return __machine__synthesize_threads(machine, NULL, target, threads,
>  					     perf_event__process, data_mmap,
> -					     proc_map_timeout,
>  					     nr_threads_synthesize);
>  }
>  
> -- 
> 2.17.1
> 
