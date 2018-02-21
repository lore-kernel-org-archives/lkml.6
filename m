Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937845AbeBUOji (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:39:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934187AbeBUOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:39:36 -0500
Date: Wed, 21 Feb 2018 15:39:33 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf, tools, stat: Reset ids counter when retrying
 events
Message-ID: <20180221143933.GE2565@krava>
References: <20171006020029.13339-1-andi@firstfloor.org>
 <20171006020029.13339-2-andi@firstfloor.org>
 <20180221140002.GB24416@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221140002.GB24416@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:00:02AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 05, 2017 at 07:00:29PM -0700, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > perf stat can retry opening events. After opening an file descriptor
> > it adds the ids to the ecsel. Each event keeps a running
> > count of ids.
> 
> Ok, and that is done in perf_evlist__id_add() where we also add things
> to the evlist->heads hashtable, shouldn't we remove all these before
> retrying? I.e. perf_evlist__close() shouldn't be resetting that
> hashtable?
> 
> I.e. like in the following patch? Jiri? Namhyung?
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7b7d535396f7..e8942456106e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -37,13 +37,18 @@
>  #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
>  #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
>  
> -void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
> -		       struct thread_map *threads)
> +static void perf_evlist__init_heads(struct perf_evlist *evlist)
>  {
>  	int i;
>  
>  	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
>  		INIT_HLIST_HEAD(&evlist->heads[i]);
> +}
> +
> +void perf_evlist__init(struct perf_evlist *evlist, struct cpu_map *cpus,
> +		       struct thread_map *threads)
> +{
> +	perf_evlist__init_heads(evlist);
>  	INIT_LIST_HEAD(&evlist->entries);
>  	perf_evlist__set_maps(evlist, cpus, threads);
>  	fdarray__init(&evlist->pollfd, 64);
> @@ -1381,8 +1386,11 @@ void perf_evlist__close(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel;
>  
> -	evlist__for_each_entry_reverse(evlist, evsel)
> +	evlist__for_each_entry_reverse(evlist, evsel) {
>  		perf_evsel__close(evsel);
> +	}
> +
> +	perf_evlist__init_heads(evlist);
>  }
>  
>  static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ef351688b797..fba708bc9d98 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1932,6 +1932,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
>  
>  	perf_evsel__close_fd(evsel);
>  	perf_evsel__free_fd(evsel);
> +	evsel->ids = 0;
>  }

yes, that seems correct

jirka
