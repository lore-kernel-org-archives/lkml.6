Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7892DC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4050B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4050B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeJKVND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:13:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeJKVND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69A1C30014CF;
        Thu, 11 Oct 2018 13:45:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id AFD146031A;
        Thu, 11 Oct 2018 13:45:45 +0000 (UTC)
Date:   Thu, 11 Oct 2018 15:45:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181011134544.GA29634@krava>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 11 Oct 2018 13:45:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:58:53AM +0300, Alexey Budankov wrote:

SNIP

> @@ -329,7 +469,7 @@ static int record__mmap_evlist(struct record *rec,
>  
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
> -				 opts->auxtrace_snapshot_mode) < 0) {
> +				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
>  		if (errno == EPERM) {
>  			pr_err("Permission error mapping pages.\n"
>  			       "Consider increasing "
> @@ -513,6 +653,29 @@ static struct perf_event_header finished_round_event = {
>  	.type = PERF_RECORD_FINISHED_ROUND,
>  };
>  
> +#ifdef HAVE_AIO_SUPPORT
> +static void record__mmap_read_sync(struct record *rec)
> +{
> +	int i;
> +	struct perf_evlist *evlist = rec->evlist;
> +	struct perf_mmap *maps = evlist->mmap;
> +
> +	if (!rec->opts.nr_cblocks)
> +		return;
> +
> +	for (i = 0; i < evlist->nr_mmaps; i++) {
> +		struct perf_mmap *map = &maps[i];
> +
> +		if (map->base)
> +			record__aio_sync(map);
> +	}
> +}
> +#else
> +static void record__mmap_read_sync(struct record *rec __maybe_unused)
> +{
> +}
> +#endif

please move this up so we have just one  'ifdef HAVE_AIO_SUPPORT' block

and change the name to record__aio_mmap_read_sync, so it's obvious it's
aio related, like the rest of the functions you added

thanks,
jirka
