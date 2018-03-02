Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934658AbeCBXaS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:30:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934230AbeCBXaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:30:17 -0500
Date: Sat, 3 Mar 2018 00:30:14 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
Subject: Re: [PATCH 02/14] perf trace: Apply new perf_mmap__read_event()
 interface
Message-ID: <20180302233014.GA8970@krava>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
 <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 06:08:59PM -0500, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf trace still use the legacy interface.
> 
> Apply the new perf_mmap__read_event() interface for perf trace.
> 
> No functional change.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-trace.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e7f1b18..a46644f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2472,8 +2472,14 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>  		union perf_event *event;
> +		struct perf_mmap *md;
> +		u64 end, start;
>  
> -		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
> +		md = &evlist->mmap[i];
> +		if (perf_mmap__read_init(md, 0, &start, &end) < 0)
> +			continue;

should we break the loop if this returns -EINVAL?

jirka

> +
> +		while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
>  			struct perf_sample sample;
>  
>  			++trace->nr_events;
> @@ -2486,7 +2492,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  
>  			trace__handle_event(trace, event, &sample);
>  next_event:
> -			perf_evlist__mmap_consume(evlist, i);
> +			perf_mmap__consume(md, 0);
>  
>  			if (interrupted)
>  				goto out_disable;
> @@ -2496,6 +2502,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  				draining = true;
>  			}
>  		}
> +		perf_mmap__read_done(md);
>  	}
>  
>  	if (trace->nr_events == before) {
> -- 
> 2.4.11
> 
