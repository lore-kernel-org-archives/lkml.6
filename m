Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeEROTC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeEROTB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:19:01 -0400
Date: Fri, 18 May 2018 11:18:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/3] perf evlist: Create a new function
 perf_evlist_forced_leader
Message-ID: <20180518141858.GC32141@kernel.org>
References: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
 <1526659234-1556-2-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526659234-1556-2-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 19, 2018 at 12:00:32AM +0800, Jin Yao escreveu:
> For non-explicit group, perf report supports a option '--group'
> which can enable group output. We also need to support perf annotate
> with the same '--group'.
> 
> Create a new function perf_evlist_forced_leader which contains
> common code to force setting the group leader.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/evlist.c | 15 +++++++++++++++
>  tools/perf/util/evlist.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index a59281d..6983f6a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1795,3 +1795,18 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
>  
>  	return true;
>  }
> +
> +/*
> + * Events in data file are not collect in groups, but we still want
> + * the group display. Set the artificial group and set the leader's
> + * forced_leader flag to notify the display code.
> + */
> +void perf_evlist_forced_leader(struct perf_evlist *evlist)

This should've been:

void perf_evlist__forced_leader(struct perf_evlist *evlist)

But then, by the verb conjugation, I thought that this would be a query,
i.e. "is this a forced leader?", but then, it returning void didn't
match that expectation, which leads me having to actually _read_ that
code to understand what is that this function does, which I would, but
just to check that it matches what it seems to be, now I'm trying to do
it to figure it out what is it that this thing does :-\


I see, its a 'd' to many, this should be:

void perf_evlist__force_leader(struct perf_evlist *evlist)

Please confirm that this is what you intend by posting a v4, so far,
just for this specific patch and any other in the series that uses this
function, ok?

- Arnaldo

> +{
> +	if (!evlist->nr_groups) {
> +		struct perf_evsel *leader = perf_evlist__first(evlist);
> +
> +		perf_evlist__set_leader(evlist);
> +		leader->forced_leader = true;
> +	}
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 6c41b2f..d77d514 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -309,4 +309,7 @@ struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
>  					    union perf_event *event);
>  
>  bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
> +
> +void perf_evlist_forced_leader(struct perf_evlist *evlist);
> +
>  #endif /* __PERF_EVLIST_H */
> -- 
> 2.7.4
