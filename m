Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DEEC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CA62085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CA62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJHSCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbeJHSCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:02:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96274308AA0F;
        Mon,  8 Oct 2018 10:50:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9882170FD;
        Mon,  8 Oct 2018 10:50:57 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:50:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
Message-ID: <20181008105057.GD17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 08 Oct 2018 10:50:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index be440df29615..af2f8c965d7a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1029,7 +1029,9 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  	 * So &mp should not be passed through const pointer.
>  	 */
>  	struct mmap_params mp;
> -
> +#ifdef HAVE_AIO_SUPPORT
> +	mp.nr_cblocks = 0;
> +#endif
>  	if (!evlist->mmap)
>  		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
>  	if (!evlist->mmap)
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index cdb95b3a1213..db8f16f8a363 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -153,8 +153,19 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
>  {
>  }
>  
> +#ifdef HAVE_AIO_SUPPORT
> +static void perf_mmap__aio_munmap(struct perf_mmap *map)
> +{
> +	if (map->data)
> +		zfree(&map->data);
> +}

if we really need to keep this optional for compilation,
please make it as single block with dummy functions
for when it's not compiled in, like:

#ifdef 
static void perf_mmap__aio_munmap(struct perf_mmap *map)
{
	if (map->data)
		zfree(&map->data);
}
#else
static void perf_mmap__aio_munmap(struct perf_mmap *map) { }
#endif

thanks,
jirka


> +#endif
> +
>  void perf_mmap__munmap(struct perf_mmap *map)
>  {
> +#ifdef HAVE_AIO_SUPPORT
> +	perf_mmap__aio_munmap(map);
> +#endif
>  	if (map->base != NULL) {
>  		munmap(map->base, perf_mmap__mmap_len(map));
>  		map->base = NULL;
> @@ -164,8 +175,40 @@ void perf_mmap__munmap(struct perf_mmap *map)
>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
>  }

SNIP
