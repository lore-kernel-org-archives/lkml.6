Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F797C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F032070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547485899;
	bh=26xhfANAfhy0SElrya5Q1iOqufPTFrRDrKX1VYf3cCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kfnP0crWcguL2nisFBVJR+fasS/qDQa+sW2+fu3VyzSpC1uOJutG9LKQcoTWMJvDK
	 lZe1v38I0kSFgDf/V8TJBvSA1CdhWGHJOQ+Sq+JwXHaYwgdnHsEuWtzZMclm8K8IPv
	 1ZrwZYC8+f4E/MehV/VosRpji5N4Ct3c/7hrLVus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfANRLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANRLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:11:37 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A00420659;
        Mon, 14 Jan 2019 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547485896;
        bh=26xhfANAfhy0SElrya5Q1iOqufPTFrRDrKX1VYf3cCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9o7gsO6+q71drJDdwUOx7NPO36daIAKBuiwcq1lwKZQXk2dj+DXdZFKduGao0PuX
         LzlH0Om8diLLBlKBSuhlpgoafwXA9Q5ZbLrJXjfVo9w5nV7eR5sbMsnnh10ml+RjIJ
         +bHX1ceGrLI0s+Aa8qQVBzj4fQXv6WNeU/6ZgGnI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 122ED41AB5; Mon, 14 Jan 2019 14:11:33 -0300 (-03)
Date:   Mon, 14 Jan 2019 14:11:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v7 perf, bpf-next 6/8] perf util: handle
 PERF_RECORD_KSYMBOL
Message-ID: <20190114171133.GB11922@kernel.org>
References: <20190111001933.4153792-1-songliubraving@fb.com>
 <20190111001933.4153792-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111001933.4153792-7-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 10, 2019 at 04:19:31PM -0800, Song Liu escreveu:
> This patch handles PERF_RECORD_KSYMBOL in perf record/report.
> Specifically, map and symbol are created for ksymbol register, and
> removed for ksymbol unregister.
> 
> This patch also set perf_event_attr.ksymbol properly. The flag is
> ON by default.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/event.c   | 21 +++++++++++++++
>  tools/perf/util/event.h   | 20 ++++++++++++++
>  tools/perf/util/evsel.c   |  9 +++++++
>  tools/perf/util/evsel.h   |  1 +
>  tools/perf/util/machine.c | 57 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/machine.h |  3 +++
>  tools/perf/util/session.c |  4 +++
>  tools/perf/util/tool.h    |  4 ++-
>  8 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 937a5a4f71cc..3c8a6a8dd260 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -24,6 +24,7 @@
>  #include "symbol/kallsyms.h"
>  #include "asm/bug.h"
>  #include "stat.h"
> +#include "session.h"
>  
>  #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
>  
> @@ -45,6 +46,7 @@ static const char *perf_event__names[] = {
>  	[PERF_RECORD_SWITCH]			= "SWITCH",
>  	[PERF_RECORD_SWITCH_CPU_WIDE]		= "SWITCH_CPU_WIDE",
>  	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
> +	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
>  	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
>  	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
>  	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
> @@ -1329,6 +1331,14 @@ int perf_event__process_switch(struct perf_tool *tool __maybe_unused,
>  	return machine__process_switch_event(machine, event);
>  }
>  
> +int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
> +				union perf_event *event,
> +				struct perf_sample *sample __maybe_unused,
> +				struct machine *machine)
> +{
> +	return machine__process_ksymbol(machine, event, sample);
> +}
> +
>  size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
>  {
>  	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
> @@ -1461,6 +1471,14 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
>  	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
>  }
>  
> +size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
> +{
> +	return fprintf(fp, " ksymbol event with addr %lx len %u type %u flags 0x%x name %s\n",
> +		       event->ksymbol_event.addr, event->ksymbol_event.len,
> +		       event->ksymbol_event.ksym_type,
> +		       event->ksymbol_event.flags, event->ksymbol_event.name);
> +}
> +
>  size_t perf_event__fprintf(union perf_event *event, FILE *fp)
>  {
>  	size_t ret = fprintf(fp, "PERF_RECORD_%s",
> @@ -1496,6 +1514,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
>  	case PERF_RECORD_LOST:
>  		ret += perf_event__fprintf_lost(event, fp);
>  		break;
> +	case PERF_RECORD_KSYMBOL:
> +		ret += perf_event__fprintf_ksymbol(event, fp);
> +		break;
>  	default:
>  		ret += fprintf(fp, "\n");
>  	}
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index eb95f3384958..018322f2a13e 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -5,6 +5,7 @@
>  #include <limits.h>
>  #include <stdio.h>
>  #include <linux/kernel.h>
> +#include <linux/bpf.h>
>  
>  #include "../perf.h"
>  #include "build-id.h"
> @@ -84,6 +85,19 @@ struct throttle_event {
>  	u64 stream_id;
>  };
>  
> +#ifndef KSYM_NAME_LEN
> +#define KSYM_NAME_LEN 256
> +#endif
> +
> +struct ksymbol_event {
> +	struct perf_event_header header;
> +	u64 addr;
> +	u32 len;
> +	u16 ksym_type;
> +	u16 flags;
> +	char name[KSYM_NAME_LEN];
> +};
> +
>  #define PERF_SAMPLE_MASK				\
>  	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
>  	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
> @@ -651,6 +665,7 @@ union perf_event {
>  	struct stat_round_event		stat_round;
>  	struct time_conv_event		time_conv;
>  	struct feature_event		feat;
> +	struct ksymbol_event		ksymbol_event;
>  };
>  
>  void perf_event__print_totals(void);
> @@ -748,6 +763,10 @@ int perf_event__process_exit(struct perf_tool *tool,
>  			     union perf_event *event,
>  			     struct perf_sample *sample,
>  			     struct machine *machine);
> +int perf_event__process_ksymbol(struct perf_tool *tool,
> +				union perf_event *event,
> +				struct perf_sample *sample,
> +				struct machine *machine);
>  int perf_tool__process_synth_event(struct perf_tool *tool,
>  				   union perf_event *event,
>  				   struct machine *machine,
> @@ -811,6 +830,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
> +size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
>  size_t perf_event__fprintf(union perf_event *event, FILE *fp);
>  
>  int kallsyms__get_function_start(const char *kallsyms_filename,
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbc0466db368..de34ce875648 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1035,6 +1035,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
>  	attr->mmap  = track;
>  	attr->mmap2 = track && !perf_missing_features.mmap2;
>  	attr->comm  = track;
> +	attr->ksymbol = track && !perf_missing_features.ksymbol;
>  
>  	if (opts->record_namespaces)
>  		attr->namespaces  = track;
> @@ -1652,6 +1653,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(context_switch, p_unsigned);
>  	PRINT_ATTRf(write_backward, p_unsigned);
>  	PRINT_ATTRf(namespaces, p_unsigned);
> +	PRINT_ATTRf(ksymbol, p_unsigned);
>  
>  	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
>  	PRINT_ATTRf(bp_type, p_unsigned);
> @@ -1811,6 +1813,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  				     PERF_SAMPLE_BRANCH_NO_CYCLES);
>  	if (perf_missing_features.group_read && evsel->attr.inherit)
>  		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
> +	if (perf_missing_features.ksymbol)
> +		evsel->attr.ksymbol = 0;
>  retry_sample_id:
>  	if (perf_missing_features.sample_id_all)
>  		evsel->attr.sample_id_all = 0;
> @@ -1955,6 +1959,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  		perf_missing_features.exclude_guest = true;
>  		pr_debug2("switching off exclude_guest, exclude_host\n");
>  		goto fallback_missing_features;
> +	} else if (!perf_missing_features.ksymbol &&
> +		   evsel->attr.ksymbol) {
> +		perf_missing_features.ksymbol = true;
> +		pr_debug2("switching off ksymbol\n");
> +		goto fallback_missing_features;
>  	} else if (!perf_missing_features.sample_id_all) {
>  		perf_missing_features.sample_id_all = true;
>  		pr_debug2("switching off sample_id_all\n");
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 82a289ce8b0c..4a8c3e7f4808 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -168,6 +168,7 @@ struct perf_missing_features {
>  	bool lbr_flags;
>  	bool write_backward;
>  	bool group_read;
> +	bool ksymbol;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 6fcb3bce0442..1734ca027661 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -681,6 +681,61 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
>  	return 0;
>  }
>  
> +static int machine__process_ksymbol_register(
> +	struct machine *machine,
> +	union perf_event *event,
> +	struct perf_sample *sample __maybe_unused)
> +{
> +	struct symbol *sym;
> +	struct map *map;
> +
> +	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
> +	if (!map) {
> +		map = dso__new_map("bpf_prog");
> +		if (!map)
> +			return -ENOMEM;
> +
> +		map->start = event->ksymbol_event.addr;
> +		map->pgoff = map->start;
> +		map->end = map->start + event->ksymbol_event.len;
> +		map_groups__insert(&machine->kmaps, map);
> +	}
> +
> +	sym = symbol__new(event->ksymbol_event.addr, event->ksymbol_event.len,
> +			  0, 0, event->ksymbol_event.name);
> +	if (!sym)
> +		return -ENOMEM;
> +	dso__insert_symbol(map->dso, sym);
> +	return 0;
> +}
> +
> +static int machine__process_ksymbol_unregister(
> +	struct machine *machine,
> +	union perf_event *event,
> +	struct perf_sample *sample __maybe_unused)
> +{
> +	struct map *map;
> +
> +	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
> +	if (map)
> +		map_groups__remove(&machine->kmaps, map);
> +
> +	return 0;
> +}
> +
> +int machine__process_ksymbol(struct machine *machine __maybe_unused,
> +			     union perf_event *event,
> +			     struct perf_sample *sample)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_ksymbol(event, stderr);

This should be stdout, otherwise we get garbled output from 'perf report
-D', that is what sets dump_trace to true.

Ditto for the machine__process_bpf_event case, i.e. this patch, each
hunk applied to the respective patch introducing the handling of those
events:

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index ee60c8b1e636..b06cd1789f1f 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -24,7 +24,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 			       struct perf_sample *sample __maybe_unused)
 {
 	if (dump_trace)
-		perf_event__fprintf_bpf_event(event, stderr);
+		perf_event__fprintf_bpf_event(event, stdout);
 	return 0;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 292992d7b504..34bd8018e45a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -729,7 +729,7 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 			     struct perf_sample *sample)
 {
 	if (dump_trace)
-		perf_event__fprintf_ksymbol(event, stderr);
+		perf_event__fprintf_ksymbol(event, stdout);
 
 	if (event->ksymbol_event.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
 		return machine__process_ksymbol_unregister(machine, event,

> +
> +	if (event->ksymbol_event.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
> +		return machine__process_ksymbol_unregister(machine, event,
> +							   sample);
> +	return machine__process_ksymbol_register(machine, event, sample);
> +}
> +
>  static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)
>  {
>  	const char *dup_filename;
> @@ -1812,6 +1867,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
>  	case PERF_RECORD_SWITCH:
>  	case PERF_RECORD_SWITCH_CPU_WIDE:
>  		ret = machine__process_switch_event(machine, event); break;
> +	case PERF_RECORD_KSYMBOL:
> +		ret = machine__process_ksymbol(machine, event, sample); break;
>  	default:
>  		ret = -1;
>  		break;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index a5d1da60f751..4ecd380ce1b4 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -130,6 +130,9 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
>  				struct perf_sample *sample);
>  int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
>  				 struct perf_sample *sample);
> +int machine__process_ksymbol(struct machine *machine,
> +			     union perf_event *event,
> +			     struct perf_sample *sample);
>  int machine__process_event(struct machine *machine, union perf_event *event,
>  				struct perf_sample *sample);
>  
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 78a067777144..a9c98c3914ed 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -376,6 +376,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>  		tool->itrace_start = perf_event__process_itrace_start;
>  	if (tool->context_switch == NULL)
>  		tool->context_switch = perf_event__process_switch;
> +	if (tool->ksymbol == NULL)
> +		tool->ksymbol = perf_event__process_ksymbol;
>  	if (tool->read == NULL)
>  		tool->read = process_event_sample_stub;
>  	if (tool->throttle == NULL)
> @@ -1305,6 +1307,8 @@ static int machines__deliver_event(struct machines *machines,
>  	case PERF_RECORD_SWITCH:
>  	case PERF_RECORD_SWITCH_CPU_WIDE:
>  		return tool->context_switch(tool, event, sample, machine);
> +	case PERF_RECORD_KSYMBOL:
> +		return tool->ksymbol(tool, event, sample, machine);
>  	default:
>  		++evlist->stats.nr_unknown_events;
>  		return -1;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 56e4ca54020a..9c81ca2f3cf7 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -53,7 +53,9 @@ struct perf_tool {
>  			itrace_start,
>  			context_switch,
>  			throttle,
> -			unthrottle;
> +			unthrottle,
> +			ksymbol;
> +
>  	event_attr_op	attr;
>  	event_attr_op	event_update;
>  	event_op2	tracing_data;
> -- 
> 2.17.1

-- 

- Arnaldo
