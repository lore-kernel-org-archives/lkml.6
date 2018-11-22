Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE59BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE52C20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE52C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393438AbeKVTrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:47:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42991 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbeKVTrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:47:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72FB888314;
        Thu, 22 Nov 2018 09:08:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB8355C21E;
        Thu, 22 Nov 2018 09:08:36 +0000 (UTC)
Date:   Thu, 22 Nov 2018 10:08:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        acme@kernel.org
Subject: Re: [PATCH] perf stat: fix csv mode column output for non-cgroup
 events
Message-ID: <20181122090835.GB15953@krava>
References: <1541587845-9150-1-git-send-email-eranian@google.com>
 <20181122035811.GD5468@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122035811.GD5468@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 22 Nov 2018 09:08:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:58:11AM -0200, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 07, 2018 at 02:50:45AM -0800, Stephane Eranian escreveu:
> > When using the -x option, perf stat prints csv-style output
> > with one event per line.  For each event, it prints the count,
> > the unit, the event name, the cgroup, and a bunch of other event
> > specific fields (such as insn per cycles).
> > 
> > When you use csv-style mode, you expect a normalized output where
> > each event is printed with the same number of fields regardless of
> > what it is so it can easily be imported into a spreadsheet or parsed.
> > For instance, if an event does not have a unit, then print an empty field
> > for it. Although this approach was implemented for the unit, it was not
> > for the cgroup.  When mixing cgroup and non-cgroup events, then non-cgroup
> > events would not show an empty field, instead the next field was printed,
> > make columns not line up correctly.
> > 
> > This patch fixes the cgroup output issues by forcing an empty field
> > for non-cgroup events as soon as one event has cgroup.
> 
> Looks sane, that nr_cgroups global variable at some point has to go to
> the evlist, but that is not introduced by this patch, Jiri, are you ok
> with it as well?

yep, looks good, sry I missed it

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> - Arnaldo
>  
> > Before:
> > <not counted> @ @cycles @foo    @ 0    @100.00@@
> > 2531614       @ @cycles @6420922@100.00@    @
> > 
> > foo cgroup lines up with time_running!
> > 
> > After:
> > <not counted> @ @cycles @foo @0       @100.00@@
> > 2594834       @ @cycles @    @5287372 @100.00@@
> > 
> > Fields line up.
> > 
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index e7b4c44ebb62..665ee374fc01 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -59,6 +59,15 @@ static void print_noise(struct perf_stat_config *config,
> >  	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
> >  }
> >  
> > +static void print_cgroup(struct perf_stat_config *config, struct perf_evsel *evsel)
> > +{
> > +	if (nr_cgroups) {
> > +		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
> > +		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
> > +	}
> > +}
> > +
> > +
> >  static void aggr_printout(struct perf_stat_config *config,
> >  			  struct perf_evsel *evsel, int id, int nr)
> >  {
> > @@ -336,8 +345,7 @@ static void abs_printout(struct perf_stat_config *config,
> >  
> >  	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
> >  
> > -	if (evsel->cgrp)
> > -		fprintf(output, "%s%s", config->csv_sep, evsel->cgrp->name);
> > +	print_cgroup(config, evsel);
> >  }
> >  
> >  static bool is_mixed_hw_group(struct perf_evsel *counter)
> > @@ -431,9 +439,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
> >  			config->csv_output ? 0 : -25,
> >  			perf_evsel__name(counter));
> >  
> > -		if (counter->cgrp)
> > -			fprintf(config->output, "%s%s",
> > -				config->csv_sep, counter->cgrp->name);
> > +		print_cgroup(config, counter);
> >  
> >  		if (!config->csv_output)
> >  			pm(config, &os, NULL, NULL, "", 0);
> > -- 
> > 2.7.4
