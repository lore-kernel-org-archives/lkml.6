Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15451C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87B120857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87B120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeIFPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:39:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbeIFPji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F24577886;
        Thu,  6 Sep 2018 11:04:43 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC40F112C247;
        Thu,  6 Sep 2018 11:04:41 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:04:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2]: perf util: map data buffer for preserving
 collected data
Message-ID: <20180906110441.GI8248@krava>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
 <cf6cd6ca-12dd-9ee8-8e18-ee02f289c45e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6cd6ca-12dd-9ee8-8e18-ee02f289c45e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 11:04:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 06 Sep 2018 11:04:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:19:56AM +0300, Alexey Budankov wrote:

SNIP

> @@ -166,6 +174,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
>  
>  int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>  {
> +	int i;
>  	/*
>  	 * The last one will be done at perf_mmap__consume(), so that we
>  	 * make sure we don't prevent tools from consuming every last event in
> @@ -190,6 +199,50 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
>  		map->base = NULL;
>  		return -1;
>  	}
> +	map->nr_cblocks = mp->nr_cblocks;
> +	map->cblocks = calloc(map->nr_cblocks, sizeof(struct aiocb*));
> +	if (!map->cblocks) {
> +		pr_debug2("failed to allocate perf event data buffers, error %d\n",
> +				errno);
> +		return -1;
> +	}
> +	map->data = calloc(map->nr_cblocks, sizeof(void*));
> +	if (map->data) {
> +		int delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
> +		for (i = 0; i < map->nr_cblocks; ++i) {
> +			map->data[i] = malloc(perf_mmap__mmap_len(map));
> +			if (map->data[i]) {
> +				int prio;
> +				unsigned char *data = map->data[i];
> +				map->cblocks[i] = (struct aiocb *)&data[map->mask + 1];

the 'struct aiocb' is allocated at the last page of the buffer?
is that enough space? could we please make this more transparent
and allocate that space separately?

thanks,
jirka
