Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37359217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfBLNJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfBLNJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:09:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF2143D15;
        Tue, 12 Feb 2019 13:09:04 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4140210021B6;
        Tue, 12 Feb 2019 13:09:03 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:09:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] perf record: enable runtime trace compression
Message-ID: <20190212130902.GI775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 12 Feb 2019 13:09:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:

SNIP

> +	compress_fn = (record__comp_enabled(rec) ?
> +		perf_session__zstd_compress : perf_session__zstd_copy);
> +
>  	if (record__aio_enabled(rec))
>  		off = record__aio_get_pos(trace_fd);
>  
> @@ -799,11 +805,21 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  				map->flush = MMAP_FLUSH_DEFAULT;
>  			}
>  			if (!record__aio_enabled(rec)) {
> -				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> -					if (sync)
> -						map->flush = flush;
> -					rc = -1;
> -					goto out;
> +				if (!record__comp_enabled(rec)) {
> +					if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> +						if (sync)
> +							map->flush = flush;
> +						rc = -1;
> +						goto out;
> +					}
> +				} else {
> +					if (perf_mmap__pack(map, rec, record__pushfn,
> +							compress_fn, session) != 0) {
> +						if (sync)
> +							map->flush = flush;
> +						rc = -1;
> +						goto out;
> +					}

I really dont like this.. the non-compression flow needs to stay untouched

why don't you overload the record__pushfn function for compression
processing and stash the data in there?

thanks,
jirka
