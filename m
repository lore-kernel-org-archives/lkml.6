Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F4B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfBLNIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:08:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLNIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:08:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C507D8E580;
        Tue, 12 Feb 2019 13:08:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 386825D9D1;
        Tue, 12 Feb 2019 13:08:35 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:08:34 +0100
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
Message-ID: <20190212130834.GE775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 12 Feb 2019 13:08:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:

SNIP

>  static void record__init_features(struct record *rec)
> @@ -838,6 +881,9 @@ static void record__init_features(struct record *rec)
>  	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
>  		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
>  
> +	if (!record__comp_enabled(rec))
> +		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
> +
>  	perf_header__clear_feat(&session->header, HEADER_STAT);
>  }
>  
> @@ -1147,6 +1193,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	fd = perf_data__fd(data);
>  	rec->session = session;
>  
> +	rec->opts.comp_level = 0;
> +	session->header.env.comp_level = rec->opts.comp_level;
> +	session->header.env.comp_type = PERF_COMP_NONE;

hum I think both record and session are zerod from start,
so this seems superfluous

SNIP

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index dec6d218c31c..5ad3a27a042f 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1463,6 +1463,21 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
>  	return ret;
>  }
>  
> +static int write_compressed(struct feat_fd *ff __maybe_unused,
> +			    struct perf_evlist *evlist __maybe_unused)
> +{
> +	int ret;
> +	u64 compression_info = ((u64)ff->ph->env.comp_type  << 32) | ff->ph->env.comp_level;
> +
> +	ret = do_write(ff, &compression_info, sizeof(compression_info));
> +	if (ret)
> +		return ret;
> +
> +	compression_info = ((u64)ff->ph->env.comp_ratio << 32) | ff->ph->env.comp_mmap_len;

let's not complicate this, if you have two u32 values
to store, store two u32 values ;-)

also please add version in case we will add new fields in the future,
so we can stay backward compatible

jirka
