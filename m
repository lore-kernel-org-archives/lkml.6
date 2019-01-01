Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D8E218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfAAVjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbfAAVjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:39:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5331388304;
        Tue,  1 Jan 2019 21:39:35 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3649F1001F3D;
        Tue,  1 Jan 2019 21:39:32 +0000 (UTC)
Date:   Tue, 1 Jan 2019 22:39:32 +0100
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
Message-ID: <20190101213932.GE13760@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <4b7b902b-01b7-7a3f-eee2-e7fc8433322c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7b902b-01b7-7a3f-eee2-e7fc8433322c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 01 Jan 2019 21:39:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:27:17PM +0300, Alexey Budankov wrote:

SNIP

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

the 'c' is just an index here, I think you need to
use the real cpu value from the mp->cpu_map->map[c]

jirka

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
