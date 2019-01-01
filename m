Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF317C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7766B21871
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfAAVj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbfAAVj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:39:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A73BC0B0238;
        Tue,  1 Jan 2019 21:39:27 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8241D5D73F;
        Tue,  1 Jan 2019 21:39:25 +0000 (UTC)
Date:   Tue, 1 Jan 2019 22:39:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] perf record: allocate affinity masks
Message-ID: <20190101213924.GD13760@krava>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
 <ed9acf48-def7-1539-331f-454951dad3d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9acf48-def7-1539-331f-454951dad3d9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 01 Jan 2019 21:39:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:23:13PM +0300, Alexey Budankov wrote:

SNIP

> @@ -2143,6 +2152,8 @@ int cmd_record(int argc, const char **argv)
>  	if (verbose > 0)
>  		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>  
> +	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
> +
>  	err = __cmd_record(&record, argc, argv);
>  out:
>  	perf_evlist__delete(rec->evlist);
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 388c6dd128b8..69f54529d81f 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -83,6 +83,14 @@ struct record_opts {
>  	clockid_t    clockid;
>  	u64          clockid_res_ns;
>  	int	     nr_cblocks;
> +	int	     affinity;
> +};
> +
> +enum perf_affinity {
> +	PERF_AFFINITY_SYS = 0,
> +	PERF_AFFINITY_NODE,
> +	PERF_AFFINITY_CPU,
> +	PERF_AFFINITY_EOF

PERF_AFFINITY_MAX might be better name

jirka
