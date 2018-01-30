Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeA3Njl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:39:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeA3Njk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:39:40 -0500
Date: Tue, 30 Jan 2018 14:39:17 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Stephane Eranian <eranian@google.com>
Cc: kan.liang@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
Message-ID: <20180130133917.GC29098@krava>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:16:39AM -0800, Stephane Eranian wrote:
> Hi,
> 
> On Mon, Jan 29, 2018 at 8:29 AM, <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > ------
> >
> > Changes since V2:
> >  - Refined the changelog
> >  - Introduced specific read function for large PEBS.
> >    The previous generic PEBS read function is confusing.
> >    Disabled PMU in pmu::read() path for large PEBS.
> >    Handled the corner case when reload_times == 0.
> >  - Modified the parameter of intel_pmu_save_and_restart_reload()
> >    Discarded local64_cmpxchg
> >  - Added fixes tag
> >  - Added WARN to handle reload_times == 0 || reload_val == 0
> >
> > Changes since V1:
> >  - Check PERF_X86_EVENT_AUTO_RELOAD before call
> >    intel_pmu_save_and_restore()
> 
> It is not yet clear to me why PERF_SAMPLE_PERIOD is not allowed
> with large PEBS. Large PEBS requires fixed period. So the kernel could
> make up the period from the event and store it in the sampling buffer.
> 
> I tried using large PEBS recently, and despite trying different option
> combination of perf record, I was not able to get it to work.
> 
> $ perf record  -c 1  -e cpu/event=0xd1,umask=0x10,period=19936/pp
> --no-timestamp --no-period -a -C 0
> 
> But I was able to make this work with a much older kernel.
> 
> Another annoyance I ran into is with perf record requiring -c period
> in order not to set
> PERF_SAMPLE_PERIOD in the event.
> 
> If I do:
> perf record  -c 1  -e cpu/event=0xd1,umask=0x10,period=19936/pp
> --no-timestamp --no-period -a -C 0
> 
> I get
> 
> perf_event_attr:
>   type                             4
>   size                             112
>   config                           0x10d1
>   { sample_period, sample_freq }   199936
>   sample_type                      IP|TID|CPU
> 
> But if I do:
> perf record  -e cpu/event=0xd1,umask=0x10,period=19936/pp
> --no-timestamp --no-period -a -C 0
> 
> I get
> 
> perf_event_attr:
>   type                             4
>   size                             112
>   config                           0x10d1
>   { sample_period, sample_freq }   199936
>   sample_type                      IP|TID|CPU|PERIOD
> 
> Perf should check if all events have a period=, then it should not
> pass PERF_SAMPLE_PERIOD, even
> more so when only one event is defined.
> 
> Also it does not seem to honor --no-period.

yep, there's a bug in period=x term handling
we did not re/set the sample_type based on that

attached patch fixes that for me, also takes into account
the --no/-period options

jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f251e824edac..907267206973 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1566,7 +1566,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
 			"Record the sample timestamps"),
-	OPT_BOOLEAN('P', "period", &record.opts.period, "Record the sample period"),
+	OPT_BOOLEAN_SET('P', "period", &record.opts.period, &record.opts.period_set,
+			"Record the sample period"),
 	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 2357f4ccc9c7..cfe46236a5e5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -50,6 +50,7 @@ struct record_opts {
 	bool	     sample_time_set;
 	bool	     sample_cpu;
 	bool	     period;
+	bool	     period_set;
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66fa45198a11..ff359c9ece2e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -745,12 +745,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
 				attr->sample_period = term->val.period;
 				attr->freq = 0;
+				perf_evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq != UINT_MAX)) {
 				attr->sample_freq = term->val.freq;
 				attr->freq = 1;
+				perf_evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
@@ -969,9 +971,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		perf_evsel__set_sample_bit(evsel, CPU);
 
-	if (opts->period)
-		perf_evsel__set_sample_bit(evsel, PERIOD);
-
 	/*
 	 * When the user explicitly disabled time don't force it here.
 	 */
@@ -1073,6 +1072,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	apply_config_terms(evsel, opts, track);
 
 	evsel->ignore_missing_thread = opts->ignore_missing_thread;
+
+	/* The --period option takes the precedence. */
+	if (opts->period_set) {
+		if (opts->period)
+			perf_evsel__set_sample_bit(evsel, PERIOD);
+		else
+			perf_evsel__reset_sample_bit(evsel, PERIOD);
+	}
 }
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
