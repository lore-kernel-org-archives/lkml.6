Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55FBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCA7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4Hj3cdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCA7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJJUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJJUUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:20:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1F121479;
        Wed, 10 Oct 2018 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539176298;
        bh=Lmz8k6GKaMEDZVIYvGRKJNao/PHdOsHlzjoMiMIy8gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4Hj3cdwpBTyxWDrjKgOTF2IjFrDxqIkJ5H25B1xbntj2y4sNoivHL4aVcPq9J58i
         L77r/FIwaHNLaV3JSOu7sh0xA3+D3RT+CufqSodlAYOIHfoV8WYYDToI67v/HicGe4
         MV/N7DqhgjHUpD8gR473KOP14D9NZ6T9Aj7Vprc8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 38184142C5E; Wed, 10 Oct 2018 09:58:16 -0300 (-03)
Date:   Wed, 10 Oct 2018 09:58:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix wrong filter_band* values for uncore
 events
Message-ID: <20181010125816.GJ10775@kernel.org>
References: <20181003072046.29276-1-jolsa@kernel.org>
 <20181003143456.GE31725@krava>
 <20181003144550.GI32651@tassilo.jf.intel.com>
 <20181009100144.GG6499@krava>
 <20181009211839.GK32651@tassilo.jf.intel.com>
 <20181010080339.GB15790@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010080339.GB15790@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 10, 2018 at 10:03:39AM +0200, Jiri Olsa escreveu:
> On Tue, Oct 09, 2018 at 02:18:39PM -0700, Andi Kleen wrote:
> > On Tue, Oct 09, 2018 at 12:01:44PM +0200, Jiri Olsa wrote:
> > > On Wed, Oct 03, 2018 at 07:45:50AM -0700, Andi Kleen wrote:
> > > > > note there's couple of changes that actually changed
> > > > > the number completely, like:
> > > > > 
> > > > > -        "Filter": "edge=1,filter_band2=4000",
> > > > > +        "Filter": "edge=1,filter_band2=30",
> > > > 
> > > > Thanks. Looks good. I'll fix the scripts to generate the uncore events.
> > > 
> > > hi,
> > > any idea when you could post an update for this?
> > 
> > Can just use your patch for the existing event lists. You can add
> > 
> > Acked-by: Andi Kleen <ak@linux.intel.com>
> > 
> > I was mainly worried about future updates, but it doesn't seem to be a problem.
> 
> ok, attaching patch with full changelog
> 
> thanks,
> jirka

Ok, queuing this up in perf/urgent.

Thanks,

- Arnaldo
 
> 
> ---
> Michael reported that he could not stat following event:
> 
>   $ perf stat -e unc_p_freq_ge_1200mhz_cycles -a -- ls
>   event syntax error: '..e_1200mhz_cycles'
>                                     \___ value too big for format, maximum is 255
>   Run 'perf list' for a list of valid events
> 
> The event is unwrapped into:
>   uncore_pcu/event=0xb,filter_band0=1200/
> 
> where filter_band0 format says it's one byte only:
> 
>   # cat uncore_pcu/format/filter_band0
>   config1:0-7
> 
> while json files specifies bigger number:
> 
>   "Filter": "filter_band0=1200",
> 
> all the filter_band* formats show 1 byte width:
> 
>   # cat uncore_pcu/format/filter_band1
>   config1:8-15
>   # cat uncore_pcu/format/filter_band2
>   config1:16-23
>   # cat uncore_pcu/format/filter_band3
>   config1:24-31
> 
> The reason of the issue is that filter_band* values are
> supposed to be in 100Mhz units.. it's stated in the json
> help for the events, like:
> 
>   filter_band3=XXX, with XXX in 100Mhz units
> 
> This patch divides the filter_band* values by 100,
> plus there's couple of changes that actually change
> the number completely, like:
> 
> -        "Filter": "edge=1,filter_band2=4000",
> +        "Filter": "edge=1,filter_band2=30",
> 
> Reported-by: Michael Petlan <mpetlan@redhat.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Link: http://lkml.kernel.org/n/tip-ujl4yzkexf3i10fjw24maa9e@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../arch/x86/ivytown/uncore-power.json           | 16 ++++++++--------
>  .../arch/x86/jaketown/uncore-power.json          | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> index d40498f2cb1e..635c09fda1d9 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> @@ -188,7 +188,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xb",
>          "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
> -        "Filter": "filter_band0=1200",
> +        "Filter": "filter_band0=12",
>          "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_1200mhz_cycles %",
>          "PerPkg": "1",
> @@ -199,7 +199,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xc",
>          "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
> -        "Filter": "filter_band1=2000",
> +        "Filter": "filter_band1=20",
>          "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_2000mhz_cycles %",
>          "PerPkg": "1",
> @@ -210,7 +210,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xd",
>          "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
> -        "Filter": "filter_band2=3000",
> +        "Filter": "filter_band2=30",
>          "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_3000mhz_cycles %",
>          "PerPkg": "1",
> @@ -221,7 +221,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xe",
>          "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
> -        "Filter": "filter_band3=4000",
> +        "Filter": "filter_band3=40",
>          "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_4000mhz_cycles %",
>          "PerPkg": "1",
> @@ -232,7 +232,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xb",
>          "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band0=1200",
> +        "Filter": "edge=1,filter_band0=12",
>          "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_1200mhz_cycles %",
>          "PerPkg": "1",
> @@ -243,7 +243,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xc",
>          "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band1=2000",
> +        "Filter": "edge=1,filter_band1=20",
>          "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_2000mhz_cycles %",
>          "PerPkg": "1",
> @@ -254,7 +254,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xd",
>          "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band2=4000",
> +        "Filter": "edge=1,filter_band2=30",
>          "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_3000mhz_cycles %",
>          "PerPkg": "1",
> @@ -265,7 +265,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xe",
>          "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band3=4000",
> +        "Filter": "edge=1,filter_band3=40",
>          "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_4000mhz_cycles %",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> index 16034bfd06dd..8755693d86c6 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> @@ -187,7 +187,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xb",
>          "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
> -        "Filter": "filter_band0=1200",
> +        "Filter": "filter_band0=12",
>          "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_1200mhz_cycles %",
>          "PerPkg": "1",
> @@ -198,7 +198,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xc",
>          "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
> -        "Filter": "filter_band1=2000",
> +        "Filter": "filter_band1=20",
>          "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_2000mhz_cycles %",
>          "PerPkg": "1",
> @@ -209,7 +209,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xd",
>          "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
> -        "Filter": "filter_band2=3000",
> +        "Filter": "filter_band2=30",
>          "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_3000mhz_cycles %",
>          "PerPkg": "1",
> @@ -220,7 +220,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xe",
>          "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
> -        "Filter": "filter_band3=4000",
> +        "Filter": "filter_band3=40",
>          "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_4000mhz_cycles %",
>          "PerPkg": "1",
> @@ -231,7 +231,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xb",
>          "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band0=1200",
> +        "Filter": "edge=1,filter_band0=12",
>          "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_1200mhz_cycles %",
>          "PerPkg": "1",
> @@ -242,7 +242,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xc",
>          "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band1=2000",
> +        "Filter": "edge=1,filter_band1=20",
>          "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_2000mhz_cycles %",
>          "PerPkg": "1",
> @@ -253,7 +253,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xd",
>          "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band2=4000",
> +        "Filter": "edge=1,filter_band2=30",
>          "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_3000mhz_cycles %",
>          "PerPkg": "1",
> @@ -264,7 +264,7 @@
>          "Counter": "0,1,2,3",
>          "EventCode": "0xe",
>          "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
> -        "Filter": "edge=1,filter_band3=4000",
> +        "Filter": "edge=1,filter_band3=40",
>          "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
>          "MetricName": "freq_ge_4000mhz_cycles %",
>          "PerPkg": "1",
> -- 
> 2.17.1
