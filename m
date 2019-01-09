Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBA7206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfAIQtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfAIQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:49:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96C10C0C427A;
        Wed,  9 Jan 2019 16:49:17 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id DF8C460C45;
        Wed,  9 Jan 2019 16:49:15 +0000 (UTC)
Date:   Wed, 9 Jan 2019 17:49:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf record: bind the AIO user space buffers to
 nodes
Message-ID: <20190109164915.GB19455@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
 <20190101214117.GI13760@krava>
 <d03c0f6b-57d8-773b-7d82-316c2bef2fb3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03c0f6b-57d8-773b-7d82-316c2bef2fb3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 16:49:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:12:37PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 02.01.2019 0:41, Jiri Olsa wrote:
> > On Mon, Dec 24, 2018 at 03:24:36PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> +static void perf_mmap__aio_free(void **data, size_t len __maybe_unused)
> >> +{
> >> +	zfree(data);
> >> +}
> >> +
> >> +static void perf_mmap__aio_bind(void *data __maybe_unused, size_t len __maybe_unused,
> >> +                                int cpu __maybe_unused, int affinity __maybe_unused)
> >> +{
> >> +}
> >> +#endif
> >> +
> >>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
> >>  {
> >>  	int delta_max, i, prio;
> >> @@ -177,11 +220,13 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
> >>  		}
> >>  		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
> >>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
> >> -			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
> >> +			size_t mmap_len = perf_mmap__mmap_len(map);
> >> +			perf_mmap__aio_alloc(&(map->aio.data[i]), mmap_len);
> >>  			if (!map->aio.data[i]) {
> >>  				pr_debug2("failed to allocate data buffer area, error %m");
> >>  				return -1;
> >>  			}
> >> +			perf_mmap__aio_bind(map->aio.data[i], mmap_len, map->cpu, mp->affinity);
> > 
> > this all does not work if bind fails.. I think we need to
> > propagate the error value here and fail
> 
> Proceeding further from this point still makes sense because 
> the buffer is available for operations and thread migration 
> alone can bring performance benefits. So the error is not fatal 
> and an explicit warning is implemented in v3. If you still think 
> it is better to propagate error from here it can be implemented.

so if that fails that the aio buffers won't be bound to node,
while mmaps are, so I guess the speedup is from there?

if I use:

# perf record --aio --affinity=node

and see:
  "failed to bind..."

I can still see the benefit..? I guess the warning is ok then,
another option seems confusing

jirka
