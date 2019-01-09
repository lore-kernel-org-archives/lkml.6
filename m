Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D7FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315F2206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfAIP64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:58:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731016AbfAIP64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:58:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA61D7E9C4;
        Wed,  9 Jan 2019 15:58:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 227315D9C9;
        Wed,  9 Jan 2019 15:58:53 +0000 (UTC)
Date:   Wed, 9 Jan 2019 16:58:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] perf record: bind the AIO user space buffers to
 nodes
Message-ID: <20190109155853.GA19455@krava>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
 <848d3b31-7efb-880b-3e82-87ba6748104c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <848d3b31-7efb-880b-3e82-87ba6748104c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 15:58:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:37:17PM +0300, Alexey Budankov wrote:
> 
> Allocate and bind AIO user space buffers to the memory nodes
> that mmap kernel buffers are bound to.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v3:
> - corrected code style issues
> - adjusted __aio_alloc,__aio_bind,__aio_free() implementation
> Changes in v2:
> - implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
>   and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
> ---
>  tools/perf/util/mmap.c | 71 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e68ba754a8e2..e5220790f1fb 100644
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
> @@ -154,9 +157,68 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>  }
>  
>  #ifdef HAVE_AIO_SUPPORT
> +
> +#ifdef HAVE_LIBNUMA_SUPPORT
> +static int perf_mmap__aio_alloc(struct perf_mmap *map, int index)
> +{
> +	map->aio.data[index] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> +				    MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> +	if (map->aio.data[index] == MAP_FAILED) {
> +		map->aio.data[index] = NULL;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void perf_mmap__aio_free(struct perf_mmap *map, int index)
> +{
> +	if (map->aio.data[index]) {
> +		munmap(map->aio.data[index], perf_mmap__mmap_len(map));
> +		map->aio.data[index] = NULL;
> +	}
> +}
> +
> +static void perf_mmap__aio_bind(struct perf_mmap *map, int index, int cpu, int affinity)
> +{
> +	void *data;
> +	size_t mmap_len;
> +	unsigned long node_mask;
> +
> +	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
> +		data = map->aio.data[index];
> +		mmap_len = perf_mmap__mmap_len(map);
> +		node_mask = 1UL << cpu__get_node(cpu);
> +		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
> +			pr_warn("failed to bind [%p-%p] to node %d\n",
> +				data, data + mmap_len, cpu__get_node(cpu));
> +		}

getting compilation fail in here:

  CC       util/mmap.o
util/mmap.c: In function ‘perf_mmap__aio_bind’:
util/mmap.c:193:4: error: implicit declaration of function ‘pr_warn’; did you mean ‘pr_warning’? [-Werror=implicit-function-declaration]
    pr_warn("failed to bind [%p-%p] to node %d\n",
    ^~~~~~~
    pr_warning
util/mmap.c:193:4: error: nested extern declaration of ‘pr_warn’ [-Werror=nested-externs]
cc1: all warnings being treated as errors


jirka
