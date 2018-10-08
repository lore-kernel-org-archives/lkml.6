Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753CDC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4577820652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4577820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJHSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeJHSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E153308424F;
        Mon,  8 Oct 2018 10:55:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD6EA6AEA9;
        Mon,  8 Oct 2018 10:55:10 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:55:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181008105509.GH17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <3c3d65dc-b2f6-b102-1805-a05ee6755653@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3d65dc-b2f6-b102-1805-a05ee6755653@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Oct 2018 10:55:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:19:17AM +0300, Alexey Budankov wrote:

SNIP

>  #ifdef HAVE_AIO_SUPPORT
>  			} else {
> +				int idx;
>  				/*
>  				 * Call record__aio_sync() to wait till map->data buffer
>  				 * becomes available after previous aio write request.
>  				 */
> -				record__aio_sync(map);
> -				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
> +				idx = record__aio_sync(map, false);
> +				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>  					lseek(trace_fd, off, SEEK_SET);
>  					rc = -1;
>  					goto out;
> @@ -1446,6 +1469,10 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  		var = "call-graph.record-mode";
>  		return perf_default_config(var, value, cb);
>  	}
> +#ifdef HAVE_AIO_SUPPORT
> +	if (!strcmp(var, "record.aio-cblocks"))
> +		rec->opts.nr_cblocks = strtol(value, NULL, 0);
> +#endif
>  
>  	return 0;
>  }
> @@ -1837,6 +1864,10 @@ static struct option __record_options[] = {
>  			  "signal"),
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>  		    "Parse options then exit"),
> +#ifdef HAVE_AIO_SUPPORT
> +	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
> +		    "Max number of simultaneous per-mmap trace writes (default: 0 - serial, max: 4)"),
> +#endif

could you please move the option to enable that to the previou patch?
so we could test the simple variant as well

also I think it'd be better if we have simple '--aio' option that would
enable this with some default values..  and add --aio-cblocks to configure
that further

thanks,
jirka
