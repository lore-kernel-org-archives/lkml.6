Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A458C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539D220C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQFB3x9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539D220C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbeHWSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbeHWSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:00:04 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6647206B6;
        Thu, 23 Aug 2018 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535034608;
        bh=+ZRpyXRWbITIDf5vaWVpQP2Ikmgwdk8TOmYt6GLd0V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQFB3x9Kn2T7qTCqEGt6NG0Bp9E8H9durqeQDFM1ZybWlEmRbeNk6nPT49gT02uqL
         0/XSWv8tgVrpxVmx4E/MaZNJscNGPj92t9Kk+sKZbEviCasKK7Cmo1yHUGt+LJHmtY
         J2w5tOj+8nGMIA/LMhu5iHlpKCsYC/fvceqFlDSM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CF4C0141C3F; Thu, 23 Aug 2018 11:30:05 -0300 (-03)
Date:   Thu, 23 Aug 2018 11:30:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2]: perf util: map data buffer for preserving
 collected data
Message-ID: <20180823143005.GB4766@kernel.org>
References: <1c3fd88f-c408-2863-15b3-221829f3d383@linux.intel.com>
 <e2c4db6b-555b-c029-5c35-986a90b284fe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c4db6b-555b-c029-5c35-986a90b284fe@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2018 at 01:30:47PM +0300, Alexey Budankov escreveu:
> +++ b/tools/perf/util/evlist.c
> @@ -718,6 +718,8 @@ static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
>  void perf_evlist__munmap(struct perf_evlist *evlist)
>  {
>  	perf_evlist__munmap_nofree(evlist);
> +	if (&evlist->mmap_aio)

Is the above test for evlist->mmap_aio being NULL? I think that '&' is
not needed here, with it this test will always be true, right?

> +		zfree(&evlist->mmap_aio);

>  	zfree(&evlist->mmap);
>  	zfree(&evlist->overwrite_mmap);
>  }
> @@ -749,6 +751,13 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
>  		 */
>  		refcount_set(&map[i].refcnt, 0);
>  	}
> +
> +	evlist->mmap_aio = zalloc(evlist->nr_mmaps * sizeof(struct aiocb *));

Right, and here you could have used calloc(evlist->nr_mmaps, sizeof(struct aiocb *))

> +	if (!evlist->mmap_aio) {
> +		zfree(&map);

If you use zfree(&map); then map becomes NULL and you do not return NULL
in the next line, if you insist in using the following 'return NULL;',
then you could as well use just 'free(map);', as 'map' is a local
variable and thus we need not set it to NULL :-)

> +		return NULL;
> +	}
> +
>  	return map;
>  }
>  
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index dc66436add98..f98b949561fd 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -15,6 +15,7 @@
>  #include "util.h"
>  #include <signal.h>
>  #include <unistd.h>
> +#include <aio.h>
>  
>  struct pollfd;
>  struct thread_map;
> @@ -43,6 +44,7 @@ struct perf_evlist {
>  	} workload;
>  	struct fdarray	 pollfd;
>  	struct perf_mmap *mmap;
> +	struct aiocb	 **mmap_aio;
>  	struct perf_mmap *overwrite_mmap;
>  	struct thread_map *threads;
>  	struct cpu_map	  *cpus;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index fc832676a798..e71d46cb01cc 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -155,6 +155,10 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>  
>  void perf_mmap__munmap(struct perf_mmap *map)
>  {
> +	if (map->data != NULL) {
> +		munmap(map->data, perf_mmap__mmap_len(map));
> +		map->data = NULL;
> +	}
>  	if (map->base != NULL) {
>  		munmap(map->base, perf_mmap__mmap_len(map));
>  		map->base = NULL;
> @@ -190,6 +194,14 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>  		map->base = NULL;
>  		return -1;
>  	}
> +	map->data = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (map->data == MAP_FAILED) {
> +		pr_debug2("failed to mmap perf event data buffer, error %d\n",
> +				errno);
> +		map->data = NULL;
> +		return -1;
> +	}
>  	map->fd = fd;
>  
>  	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index d82294db1295..1974e621e36b 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  #include <asm/barrier.h>
>  #include <stdbool.h>
> +#include <aio.h>
>  #include "auxtrace.h"
>  #include "event.h"
>  
> @@ -25,6 +26,8 @@ struct perf_mmap {
>  	bool		 overwrite;
>  	struct auxtrace_mmap auxtrace_mmap;
>  	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
> +	void 		 *data;
> +	struct aiocb	 cblock;
>  };
>  
>  /*
>  
