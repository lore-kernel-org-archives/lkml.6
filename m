Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C60C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739812085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739812085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJHSIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeJHSIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:08:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99928C07C588;
        Mon,  8 Oct 2018 10:57:22 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id E763A170FD;
        Mon,  8 Oct 2018 10:57:20 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:57:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181008105720.GI17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 08 Oct 2018 10:57:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:

SNIP

>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
>  				    bool overwrite)
>  {
> @@ -520,7 +644,10 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  	int i;
>  	int rc = 0;
>  	struct perf_mmap *maps;
> -
> +#ifdef HAVE_AIO_SUPPORT
> +	int trace_fd = rec->data.file.fd;
> +	off_t off;
> +#endif
>  	if (!evlist)
>  		return 0;
>  
> @@ -531,14 +658,34 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
>  		return 0;
>  
> +#ifdef HAVE_AIO_SUPPORT
> +	off = lseek(trace_fd, 0, SEEK_CUR);
> +#endif
>  	for (i = 0; i < evlist->nr_mmaps; i++) {
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
> -			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> -				rc = -1;
> -				goto out;
> +#ifdef HAVE_AIO_SUPPORT
> +			if (!rec->opts.nr_cblocks) {
> +#endif
> +				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> +					rc = -1;
> +					goto out;
> +				}
> +#ifdef HAVE_AIO_SUPPORT
> +			} else {
> +				/*
> +				 * Call record__aio_sync() to wait till map->data buffer
> +				 * becomes available after previous aio write request.
> +				 */
> +				record__aio_sync(map);
> +				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
> +					lseek(trace_fd, off, SEEK_SET);
> +					rc = -1;
> +					goto out;
> +				}
>  			}
> +#endif

I really don't like this.. let's have some aio_... function with its
dummy counterpart to be called in here.. and again.. if we realyl must
have this compiled optionaly, which I'm not convinced of

jirka
