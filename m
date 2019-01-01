Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F96218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbfAAVjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:39:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfAAVjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:39:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E560E8666D;
        Tue,  1 Jan 2019 21:39:41 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id D53B0608D9;
        Tue,  1 Jan 2019 21:39:39 +0000 (UTC)
Date:   Tue, 1 Jan 2019 22:39:38 +0100
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
Message-ID: <20190101213938.GF13760@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Jan 2019 21:39:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:24:36PM +0300, Alexey Budankov wrote:

SNIP

> +#else
> +static void perf_mmap__aio_alloc(void **data, size_t len)
> +{
> +	*data = malloc(len);
> +}
> +
> +static void perf_mmap__aio_free(void **data, size_t len __maybe_unused)
> +{
> +	zfree(data);
> +}
> +
> +static void perf_mmap__aio_bind(void *data __maybe_unused, size_t len __maybe_unused,
> +                                int cpu __maybe_unused, int affinity __maybe_unused)
> +{
> +}
> +#endif
> +
>  static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  {
>  	int delta_max, i, prio;
> @@ -177,11 +220,13 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  		}
>  		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
>  		for (i = 0; i < map->aio.nr_cblocks; ++i) {
> -			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
> +			size_t mmap_len = perf_mmap__mmap_len(map);

WARNING: Missing a blank line after declarations

and plenty of othres from scripts/checkpatch.pl,
please run that

jirka
