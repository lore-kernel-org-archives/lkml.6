Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0254C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE0C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfBLNJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfBLNI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52C98804EE;
        Tue, 12 Feb 2019 13:08:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8E6C5C236;
        Tue, 12 Feb 2019 13:08:57 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:08:56 +0100
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
Message-ID: <20190212130856.GH775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 12 Feb 2019 13:08:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:23:40PM +0300, Alexey Budankov wrote:

SNIP

> @@ -774,6 +775,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  	struct perf_mmap *maps;
>  	int trace_fd = rec->data.file.fd;
>  	off_t off;
> +	struct perf_session *session = rec->session;
> +	perf_mmap__compress_fn_t compress_fn;
>  
>  	if (!evlist)
>  		return 0;
> @@ -785,6 +788,9 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>  		return 0;
>  
> +	compress_fn = (record__comp_enabled(rec) ?
> +		perf_session__zstd_compress : perf_session__zstd_copy);
> +

I don't follow what's the perf_session__zstd_copy function for..?

for !record__comp_enabled case we seem not to use it
and calling the current perf_mmap__push interface

however I dont see point to have this function at all

jirka


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

SNIP
