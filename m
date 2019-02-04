Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EBAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0EC20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549308556;
	bh=7DBtzHzcJ5DLeLYYPn/djqMsesr7VXZ2VC2O8dqw2JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HctF9/c/oFtulfaCP/WN4Yzn1L+Hi/w/sElwI+aRUAjlRCHc7YKG50/5Mfpy8Q56C
	 68bmbn0PjAPI0qkBImc8mHDZ1gtvRinD7QZGF5R7o682VHqHDr0YAlzGYw15Al+53J
	 tcG/VCicuC/uaSQV/saFD3uz4FOh0gYRNngxYstA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfBDT3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfBDT3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:29:14 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F072620821;
        Mon,  4 Feb 2019 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549308553;
        bh=7DBtzHzcJ5DLeLYYPn/djqMsesr7VXZ2VC2O8dqw2JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pn1RRUb0c54wXEpU8WP662QLg75taPACnFdN3oz6Q8Dh8IJs1CwvGiGZWQsNiqGVS
         0he/RiZ1BIb/HiOwpeqmStVbPk8EOPFXZ/f86NpU1su4cSKwduz6If8cb1RmdiRdKp
         9/A6r6g5bdsIIanYfmSARxiJemOJDnZuV/GP/syU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A472C4034F; Mon,  4 Feb 2019 16:29:10 -0300 (-03)
Date:   Mon, 4 Feb 2019 16:29:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] perf record: bind the AIO user space buffers to
 nodes
Message-ID: <20190204192910.GK5593@kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <5a5adebc-afe0-4806-81cd-180d49ec043f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5adebc-afe0-4806-81cd-180d49ec043f@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 22, 2019 at 08:48:54PM +0300, Alexey Budankov escreveu:
> 
> Allocate and bind AIO user space buffers to the memory nodes
> that mmap kernel buffers are bound to.

[root@quaco amazonlinux]# perf test -v python
18: 'import perf' in python                               :
--- start ---
test child forked, pid 526
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf/python/perf.so: undefined symbol: mbind
test child finished with -1
---- end ----
'import perf' in python: FAILED!
[root@quaco amazonlinux]#


Please always use 'perf test' before pushing upstream, I'll try to fix
this one, either by linking libnuma into the python binding or by moving
the routines using it to a separate file.

Thanks,

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v4:
> - fixed compilation issue converting pr_warn() to pr_warning()
> - implemented stop if mbind() fails
> 
> Changes in v3:
> - corrected code style issues
> - adjusted __aio_alloc,__aio_bind,__aio_free() implementation
> 
> Changes in v2:
> - implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
>   and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
> ---
>  tools/perf/util/mmap.c | 77 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index e68ba754a8e2..34be9f900575 100644
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
> @@ -154,9 +157,72 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
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
> +static int perf_mmap__aio_bind(struct perf_mmap *map, int index, int cpu, int affinity)
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
> +			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
> +				data, data + mmap_len, cpu__get_node(cpu));
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int perf_mmap__aio_alloc(struct perf_mmap *map, int index)
> +{
> +	map->aio.data[index] = malloc(perf_mmap__mmap_len(map));
> +	if (map->aio.data[index] == NULL)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void perf_mmap__aio_free(struct perf_mmap *map, int index)
> +{
> +	zfree(&(map->aio.data[index]));
> +}
> +
> +static int perf_mmap__aio_bind(struct perf_mmap *map __maybe_unused, int index __maybe_unused,
> +		int cpu __maybe_unused, int affinity __maybe_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  {
> -	int delta_max, i, prio;
> +	int delta_max, i, prio, ret;
>  
>  	map->aio.nr_cblocks = mp->nr_cblocks;
>  	if (map->aio.nr_cblocks) {
> @@ -177,11 +243,14 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  		}
>  		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
> -			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
> -			if (!map->aio.data[i]) {
> +			ret = perf_mmap__aio_alloc(map, i);
> +			if (ret == -1) {
>  				pr_debug2("failed to allocate data buffer area, error %m");
>  				return -1;
>  			}
> +			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
> +			if (ret == -1)
> +				return -1;
>  			/*
>  			 * Use cblock.aio_fildes value different from -1
>  			 * to denote started aio write operation on the
> @@ -210,7 +279,7 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
>  	int i;
>  
>  	for (i = 0; i < map->aio.nr_cblocks; ++i)
> -		zfree(&map->aio.data[i]);
> +		perf_mmap__aio_free(map, i);
>  	if (map->aio.data)
>  		zfree(&map->aio.data);
>  	zfree(&map->aio.cblocks);

-- 

- Arnaldo
