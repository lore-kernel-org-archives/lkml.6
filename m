Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1813A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vy5Y2jr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1813A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbeKVJJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:09:56 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42432 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390125AbeKVJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:09:56 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so4234185vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fe+/BH9+z11hYH6xVZazuRoUd1WG4gc2Oob49Cc5vs4=;
        b=Vy5Y2jr95N4Ay8swuvR4EH38atjeikqhlZK6/Di75BjRr6pwiX5CRpxKYS4qXOy7OD
         7BN9ChntOF1sL3ZAhMYQKWVM6jL6vg9LTD3ujRh0jVuh9y0PdN8QgZmDoIX2GOPv+wuy
         OkKSp549xk6crtbDw2SrMhV95Gd628EefeLFbLvdS4cird/szF6rPAY3oz9ExqMqgp+0
         Oxokx72lpjsQawIZCS/CuL2izSEuWh9cTfAzon85pp/h+JrMRmhHEgqoIr2G4jG44x24
         43jD70kgois37Ampazy3qXLu+5J+jtUNbFNmPia9MDSObtp3fPP/rwuHjGBDsDrnv/oP
         MTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fe+/BH9+z11hYH6xVZazuRoUd1WG4gc2Oob49Cc5vs4=;
        b=K1NeKKaGe/ZCo2HrxlzvTAgNuo6CRXHJT/7I41Mt1Cv4d8Zn2rB3AWA8lfd4yRM2l0
         ecDUxQMFHskf0prDLCHMqMXcI6FYZ8A7cCsG0pmq3Zan74155LpM69pEkw0J07j4ILy6
         xiCO0OpAwNApznnzhRzvM+DUAEQK4MJkOJhXLk1iH9rFzqNr3TvfV/jG1XWHEtvR71RO
         FQp7V19tb8N2L36SFaBbGO/s46LDd732m+tqkaH97XiQSLCOYR4jVgDLl2y79JqL4fsk
         lz4ek4V7vjJcBEvFj2py0jF4Y/aQ9/VGlkpbbpPEVDoctgp8JTh+Nk4x5H73fygOBoiS
         Kf+g==
X-Gm-Message-State: AA+aEWbe7iWE1d7juT4rQKEH/kptrrMn8TvMBMVR/98lbbIrobVCdy+u
        fS+2C95znEXuanx77/N7zM84oGtkGrC28mckZG25OZGW+Sg=
X-Google-Smtp-Source: AJdET5froNNwLLMKPQ6WBPXmpusNR1NldMIFjA8qR6zlpO+419gAV8d1H6/927lIgefIjHB5a1CTKYQgVz1Tjm7k3QY=
X-Received: by 2002:a67:1106:: with SMTP id 6mr3625114vsr.213.1542839614432;
 Wed, 21 Nov 2018 14:33:34 -0800 (PST)
MIME-Version: 1.0
References: <1541587845-9150-1-git-send-email-eranian@google.com>
In-Reply-To: <1541587845-9150-1-git-send-email-eranian@google.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 21 Nov 2018 14:33:23 -0800
Message-ID: <CABPqkBQrAFSJBJSGTPRaJu1_LJmurgYpF69RxWHht-+o8cvqFg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: fix csv mode column output for non-cgroup events
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,

Any update on this patch?
Thanks.
On Wed, Nov 7, 2018 at 2:50 AM Stephane Eranian <eranian@google.com> wrote:
>
> When using the -x option, perf stat prints csv-style output
> with one event per line.  For each event, it prints the count,
> the unit, the event name, the cgroup, and a bunch of other event
> specific fields (such as insn per cycles).
>
> When you use csv-style mode, you expect a normalized output where
> each event is printed with the same number of fields regardless of
> what it is so it can easily be imported into a spreadsheet or parsed.
> For instance, if an event does not have a unit, then print an empty field
> for it. Although this approach was implemented for the unit, it was not
> for the cgroup.  When mixing cgroup and non-cgroup events, then non-cgroup
> events would not show an empty field, instead the next field was printed,
> make columns not line up correctly.
>
> This patch fixes the cgroup output issues by forcing an empty field
> for non-cgroup events as soon as one event has cgroup.
>
> Before:
> <not counted> @ @cycles @foo    @ 0    @100.00@@
> 2531614       @ @cycles @6420922@100.00@    @
>
> foo cgroup lines up with time_running!
>
> After:
> <not counted> @ @cycles @foo @0       @100.00@@
> 2594834       @ @cycles @    @5287372 @100.00@@
>
> Fields line up.
>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/stat-display.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index e7b4c44ebb62..665ee374fc01 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -59,6 +59,15 @@ static void print_noise(struct perf_stat_config *config,
>         print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
>  }
>
> +static void print_cgroup(struct perf_stat_config *config, struct perf_evsel *evsel)
> +{
> +       if (nr_cgroups) {
> +               const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
> +               fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
> +       }
> +}
> +
> +
>  static void aggr_printout(struct perf_stat_config *config,
>                           struct perf_evsel *evsel, int id, int nr)
>  {
> @@ -336,8 +345,7 @@ static void abs_printout(struct perf_stat_config *config,
>
>         fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
>
> -       if (evsel->cgrp)
> -               fprintf(output, "%s%s", config->csv_sep, evsel->cgrp->name);
> +       print_cgroup(config, evsel);
>  }
>
>  static bool is_mixed_hw_group(struct perf_evsel *counter)
> @@ -431,9 +439,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
>                         config->csv_output ? 0 : -25,
>                         perf_evsel__name(counter));
>
> -               if (counter->cgrp)
> -                       fprintf(config->output, "%s%s",
> -                               config->csv_sep, counter->cgrp->name);
> +               print_cgroup(config, counter);
>
>                 if (!config->csv_output)
>                         pm(config, &os, NULL, NULL, "", 0);
> --
> 2.7.4
>
