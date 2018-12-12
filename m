Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E52C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABD920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABD920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeLLMO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:14:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbeLLMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:14:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 040AA308213D;
        Wed, 12 Dec 2018 12:14:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 80A935D70A;
        Wed, 12 Dec 2018 12:14:54 +0000 (UTC)
Date:   Wed, 12 Dec 2018 13:14:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] perf record: apply affinity masks when reading
 mmap buffers
Message-ID: <20181212121453.GB25240@krava>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
 <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 12 Dec 2018 12:14:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:40:22AM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e68ba754a8e2..0d017ea85dcb 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -10,6 +10,9 @@
>  #include <sys/mman.h>
>  #include <inttypes.h>
>  #include <asm/bug.h>
> +#ifdef HAVE_LIBNUMA_SUPPORT
> +#include <numaif.h>
> +#endif
>  #include "debug.h"
>  #include "event.h"
>  #include "mmap.h"
> @@ -177,11 +180,27 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  		}
>  		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
> +#ifndef HAVE_LIBNUMA_SUPPORT
>  			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
> +#else
> +			size_t mmap_len = perf_mmap__mmap_len(map);
> +			map->aio.data[i] = mmap(NULL, mmap_len,
> +				PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> +#endif
>  			if (!map->aio.data[i]) {
>  				pr_debug2("failed to allocate data buffer area, error %m");
>  				return -1;
>  			}
> +#ifdef HAVE_LIBNUMA_SUPPORT
> +			if (mp->affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
> +				unsigned long node_mask = 1UL << cpu__get_node(map->cpu);
> +				if (mbind(map->aio.data[i], mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
> +					pr_debug2("failed to bind [%p-%p] to node %d\n",
> +						  map->aio.data[i], map->aio.data[i] + mmap_len,
> +						  cpu__get_node(map->cpu));
> +				}
> +			}
> +#endif

could you please do the same thing as we did for aio functions
(like record__aio_mmap_read_sync) and provide functions for both
#fidef cases?

thanks,
jirka
