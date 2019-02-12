Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AACC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D22214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfBLNI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:08:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbfBLNI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AFA35947A;
        Tue, 12 Feb 2019 13:08:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id BED946019F;
        Tue, 12 Feb 2019 13:08:23 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:08:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
Message-ID: <20190212130822.GC775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Feb 2019 13:08:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:

SNIP

> +static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map);
> +
>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  {
> -	int delta_max, i, prio, ret;
> +	int i, ret = 0, init_blocks = 1;
>  
>  	map->aio.nr_cblocks = mp->nr_cblocks;
> +	if (map->aio.nr_cblocks == -1) {
> +		map->aio.nr_cblocks = 1;
> +		init_blocks = 0;
> +	}
> +
>  	if (map->aio.nr_cblocks) {
> -		map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
> -		if (!map->aio.aiocb) {
> -			pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
> -			return -1;
> -		}
> -		map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
> -		if (!map->aio.cblocks) {
> -			pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
> -			return -1;
> -		}
>  		map->aio.data = calloc(map->aio.nr_cblocks, sizeof(void *));
>  		if (!map->aio.data) {
>  			pr_debug2("failed to allocate data buffer, error %m\n");
>  			return -1;
>  		}
> -		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
>  			ret = perf_mmap__aio_alloc(map, i);
>  			if (ret == -1) {
> @@ -251,29 +245,16 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
>  			if (ret == -1)
>  				return -1;
> -			/*
> -			 * Use cblock.aio_fildes value different from -1
> -			 * to denote started aio write operation on the
> -			 * cblock so it requires explicit record__aio_sync()
> -			 * call prior the cblock may be reused again.
> -			 */
> -			map->aio.cblocks[i].aio_fildes = -1;
> -			/*
> -			 * Allocate cblocks with priority delta to have
> -			 * faster aio write system calls because queued requests
> -			 * are kept in separate per-prio queues and adding
> -			 * a new request will iterate thru shorter per-prio
> -			 * list. Blocks with numbers higher than
> -			 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
> -			 */
> -			prio = delta_max - i;
> -			map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
>  		}
> +		if (init_blocks)
> +			ret = perf_mmap__aio_mmap_blocks(map);
>  	}
>  
> -	return 0;
> +	return ret;
>  }

SNIP

it seems like little refactoring happened in here (up and down) for
aio code, which is not explained and I'm unable to follow it.. please
separate this in simple change

SNIP

> +#ifdef HAVE_AIO_SUPPORT
> +static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map)
> +{
> +	int delta_max, i, prio;
> +
> +	map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
> +	if (!map->aio.aiocb) {
> +		pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
> +		return -1;
> +	}
> +	map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
> +	if (!map->aio.cblocks) {
> +		pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
> +		return -1;
> +	}
> +	delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
> +	for (i = 0; i < map->aio.nr_cblocks; ++i) {
> +		/*
> +		 * Use cblock.aio_fildes value different from -1
> +		 * to denote started aio write operation on the
> +		 * cblock so it requires explicit record__aio_sync()
> +		 * call prior the cblock may be reused again.
> +		 */
> +		map->aio.cblocks[i].aio_fildes = -1;
> +		/*
> +		 * Allocate cblocks with priority delta to have
> +		 * faster aio write system calls because queued requests
> +		 * are kept in separate per-prio queues and adding
> +		 * a new request will iterate thru shorter per-prio
> +		 * list. Blocks with numbers higher than
> +		 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
> +		 */
> +		prio = delta_max - i;
> +		map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
> +	}
> +
> +	return 0;
> +}
> +

SNIP
