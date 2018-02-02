Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeBBSp5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:45:57 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54247 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeBBSpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:45:50 -0500
X-Google-Smtp-Source: AH8x224OlJfMXCswDWDTgI21D6QN+CbIM/15JiYp/HlujO/2sphLojS827lESH6MZgeJ19BHzs9oNs/OgZ6c4FKalEA=
MIME-Version: 1.0
In-Reply-To: <20180201083812.11359-2-jolsa@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org> <20180201083812.11359-2-jolsa@kernel.org>
From: Stephane Eranian <eranian@google.com>
Date: Fri, 2 Feb 2018 10:45:46 -0800
Message-ID: <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tools: Fix period/freq terms setup
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,

On Thu, Feb 1, 2018 at 12:38 AM, Jiri Olsa <jolsa@kernel.org> wrote:
> Stephane reported that we don't set properly PERIOD
> sample type for events with period term defined.
>
> Before:
>   $ perf record -e cpu/cpu-cycles,period=1000/u ls
>   $ perf evlist -v
>   cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...
>
> After:
>   $ perf record -e cpu/cpu-cycles,period=1000/u ls
>   $ perf evlist -v
>   cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME, ...
>
> Setting PERIOD sample type based on period term setup.
>
there is still one problem remaining here. It has to do with the handling
of cycles:pp or :p or :ppp. Suppose I want to set a period for it while I am
also sampling on other events: Something like:

$ perf record -e
cycles:pp,instructions,cpu/event=0xd0,umaks=0x81,period=100000/ .....

I want to set the period for cycles:pp, but not for instructions. I
cannot use -c because
it would also force a period on instructions. I could use the raw hw
raw event code for cycles:pp.
But that does not work because recent kernels prevent use of hw
filters on events programmed
for PEBS, e.g., cpu/event=0xc2,umask=0x1,cmask=16,inv/pp is rejected.
PEBS does not support filters.
It works in the case of cycles:pp simply by the nature on the
underlying event and the stalls.

To get precise cycles, the only event syntax you can use is cycles:pp,
but then you cannot specify
an event-specific period. This needs to be fixed as well.

I'd like to be able to say:

$ perf record -e
cycles:pp:period=10000001,cpu/event=0xd0,umaks=0x81,period=100000/

Or something equivalent.

Otherwise, I tested what you have written so far and it works.

Thanks.


> Reported-by: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-anrtntkwfto5rqulegfwitn5@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evsel.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 66fa45198a11..f2f2eaafde6d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -745,12 +745,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
>                         if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
>                                 attr->sample_period = term->val.period;
>                                 attr->freq = 0;
> +                               perf_evsel__reset_sample_bit(evsel, PERIOD);
>                         }
>                         break;
>                 case PERF_EVSEL__CONFIG_TERM_FREQ:
>                         if (!(term->weak && opts->user_freq != UINT_MAX)) {
>                                 attr->sample_freq = term->val.freq;
>                                 attr->freq = 1;
> +                               perf_evsel__set_sample_bit(evsel, PERIOD);
>                         }
>                         break;
>                 case PERF_EVSEL__CONFIG_TERM_TIME:
> --
> 2.13.6
>
