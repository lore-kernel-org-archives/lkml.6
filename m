Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB8C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC42C2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfASPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:37:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfASPhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:37:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35574107AB;
        Sat, 19 Jan 2019 15:37:51 +0000 (UTC)
Received: from krava (ovpn-204-43.brq.redhat.com [10.40.204.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 05D2E61B8F;
        Sat, 19 Jan 2019 15:37:47 +0000 (UTC)
Date:   Sat, 19 Jan 2019 16:37:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190119153745.GA19542@krava>
References: <20190117194834.21940-1-andi@firstfloor.org>
 <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
 <20190118161000.GC28346@krava>
 <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 19 Jan 2019 15:37:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 08:11:42AM -0800, Andi Kleen wrote:
> > +static bool perf_evsel__should_skip(struct perf_evsel *evsel)
> > +{
> > +	struct perf_event_attr *attr = &evsel->attr;
> > +	struct perf_evsel *leader = evsel->leader;
> > +
> > +	return (leader != evsel) && !attr->freq && !attr->sample_freq;
> > +}
> > +
> >  static int process_sample_event(struct perf_tool *tool,
> >  				union perf_event *event,
> >  				struct perf_sample *sample,
> > @@ -1934,6 +1942,9 @@ static int process_sample_event(struct perf_tool *tool,
> >  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
> >  	struct addr_location al;
> >  
> > +	if (perf_evsel__should_skip(evsel))
> > +		return 0;
> 
> That just skips, but surely it has to be displayed somewhere?

actually maybe it's better to keep the current output,
and sort out the output for those slave events

with attached patch I can do:

  # ./perf script -Ftrace:+period,-cpu
              ex  5535 546813.189028:      11069 cpu/cpu-cycles,period=10000/:  ffffffffa492ad90 _raw_spin_lock+0x10 ([kernel.kallsyms])
              ex  5535 546813.189028:        101                probe_ex:main: 
              ex  5535 546813.189034:       9074 cpu/cpu-cycles,period=10000/:  ffffffffa4928066 down_read+0x6 ([kernel.kallsyms])
              ex  5535 546813.189041:      10102 cpu/cpu-cycles,period=10000/:  ffffffffa492af22 _raw_spin_lock_irqsave+0x22 ([kernel.kallsyms])
              ex  5535 546813.189041:          1                probe_ex:main: 

also now it won't make sample for slave events
with zero value/period read

note the patch needs to be split into more patches,
sending it all together for discussion over the solution

thanks,
jirka


---
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0c5dc4a52fc0..c8791d6bdf8e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2726,6 +2726,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			pr_warning("Overriding previous field request for %s events.\n",
 				   event_type(type));
 
+		/* Don't override defaults for +- */
+		if (strchr(tok, '+') || strchr(tok, '-'))
+			goto parse;
+
 		output[type].fields = 0;
 		output[type].user_set = true;
 		output[type].wildcard_set = false;
@@ -2810,6 +2814,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 				rc = -EINVAL;
 				goto out;
 			}
+			if (change == REMOVE)
+				output[type].fields &= ~all_output_options[i].field;
+			else
+				output[type].fields |= all_output_options[i].field;
 			output[type].user_set = true;
 			output[type].wildcard_set = true;
 		}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466db368..7487b8f7ff96 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -956,6 +956,15 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, so let's
+		 * have them following the master sample_type to
+		 * make it easy during report.
+		 */
+		attr->sample_type |= leader->attr.sample_type;
+		perf_evsel__set_sample_bit(evsel, PERIOD);
+		perf_evsel__reset_sample_bit(evsel, READ);
 	}
 
 	if (opts->no_samples)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d6f41611f504..0cbb2a2fb942 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1188,6 +1188,13 @@ static int deliver_sample_value(struct perf_evlist *evlist,
 		return 0;
 	}
 
+	/*
+	 * There's no reason to deliver sample
+	 * for zero period, bail out.
+	 */
+	if (!sample->period)
+		return 0;
+
 	return tool->sample(tool, event, sample, sid->evsel, machine);
 }
 
