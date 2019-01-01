Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3134C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAC5218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfAAVj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:39:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbfAAVj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:39:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F5DB86679;
        Tue,  1 Jan 2019 21:39:55 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 45C221001F3D;
        Tue,  1 Jan 2019 21:39:53 +0000 (UTC)
Date:   Tue, 1 Jan 2019 22:39:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] perf record: apply affinity masks when reading
 mmap buffers
Message-ID: <20190101213952.GH13760@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <4b7b902b-01b7-7a3f-eee2-e7fc8433322c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7b902b-01b7-7a3f-eee2-e7fc8433322c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Jan 2019 21:39:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:27:17PM +0300, Alexey Budankov wrote:
> 
> Build node cpu masks for mmap data buffers. Apply node cpu
> masks to tool thread every time it references data buffers
> cross node or cross cpu.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - separated AIO buffers binding to patch 2/4
> ---
>  tools/perf/builtin-record.c |  9 +++++++++
>  tools/perf/util/evlist.c    |  6 +++++-
>  tools/perf/util/mmap.c      | 12 ++++++++++++
>  tools/perf/util/mmap.h      |  1 +
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index b26febb54d01..eea96794ee45 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -536,6 +536,9 @@ static int record__mmap_evlist(struct record *rec,
>  	struct record_opts *opts = &rec->opts;
>  	char msg[512];
>  
> +	if (opts->affinity != PERF_AFFINITY_SYS)
> +		cpu__setup_cpunode_map();
> +
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
>  				 opts->auxtrace_snapshot_mode,
> @@ -755,6 +758,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
> +			if (rec->opts.affinity != PERF_AFFINITY_SYS &&
> +			    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
> +				CPU_ZERO(&rec->affinity_mask);
> +				CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
> +				sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);

all this code depends on aio and LIBNUMA, let's keep it there then

also please add this and the affinity_mask setup code below to a function

thanks,
jirka

> +			}
>  			if (!record__aio_enabled(rec)) {
>  				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
>  					rc = -1;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 60e825be944a..5ca5bb5ea0db 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1028,7 +1028,11 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  	 * Its value is decided by evsel's write_backward.
>  	 * So &mp should not be passed through const pointer.
>  	 */
> -	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
> +	struct mmap_params mp = {
> +		.nr_cblocks 	= nr_cblocks,
> +		.affinity 	= affinity,
> +		.cpu_map 	= cpus
> +	};
>  
>  	if (!evlist->mmap)
>  		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 742fa9a8e498..a2095e4eda4b 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -361,6 +361,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
>  
>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
>  {
> +	int c, nr_cpus, node;
>  	/*
>  	 * The last one will be done at perf_mmap__consume(), so that we
>  	 * make sure we don't prevent tools from consuming every last event in
> @@ -389,6 +390,17 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>  	map->cpu = cpu;
>  
>  	CPU_ZERO(&map->affinity_mask);
> +	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
> +		nr_cpus = cpu_map__nr(mp->cpu_map);
> +		node = cpu__get_node(map->cpu);
> +		for (c = 0; c < nr_cpus; c++) {
> +			if (cpu__get_node(c) == node) {
> +				CPU_SET(c, &map->affinity_mask);
> +			}
> +		}
> +	} else if (mp->affinity == PERF_AFFINITY_CPU) {
> +		CPU_SET(map->cpu, &map->affinity_mask);
> +	}
>  
>  	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
>  				&mp->auxtrace_mp, map->base, fd))
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index e566c19b242b..b3f724fad22e 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -72,6 +72,7 @@ enum bkw_mmap_state {
>  struct mmap_params {
>  	int			    prot, mask, nr_cblocks, affinity;
>  	struct auxtrace_mmap_params auxtrace_mp;
> +	const struct cpu_map	    *cpu_map;
>  };
>  
>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
