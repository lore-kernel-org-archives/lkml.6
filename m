Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C7C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F9620684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F9620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJCU1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbeJCU1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:27:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74C433D13;
        Wed,  3 Oct 2018 13:39:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB34667154;
        Wed,  3 Oct 2018 13:39:25 +0000 (UTC)
Date:   Wed, 3 Oct 2018 15:39:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf record: encode -k clockid frequency into Perf
 trace
Message-ID: <20181003133924.GD31725@krava>
References: <16b2d206-896b-c0ec-5bfd-6179ab05199a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b2d206-896b-c0ec-5bfd-6179ab05199a@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 03 Oct 2018 13:39:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 10:01:56AM +0300, Alexey Budankov wrote:
> 
> Store -k clockid frequency into Perf trace to enable timestamps 
> derived metrics conversion into wall clock time on reporting stage.
> 
> Below is the example of perf report output:
> 
> tools/perf/perf record -k raw -- ../../matrix/linux/matrix.gcc
> ...
> [ perf record: Captured and wrote 31.222 MB perf.data (818054 samples) ]
> 
> tools/perf/perf report --header
> # ========
> ...
> # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, clockid = 4
> ...
> # clockid frequency: 1000 MHz
> ...
> # ========
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
>  - renamed clockid_freq to clockid_res_ns and get_clockid_freq() to get_clockid_res()
>  - avoided redundant define of NSEC_IN_SEC, reused linux/time64.h:NSEC_PER_SEC
>  - moved MHz conversion into print_clockid() and shortened write_clockid()
> ---
>  tools/perf/builtin-record.c | 21 +++++++++++++++++++--
>  tools/perf/perf.h           |  1 +
>  tools/perf/util/env.h       |  1 +
>  tools/perf/util/header.c    | 27 +++++++++++++++++++++++++++
>  tools/perf/util/header.h    |  1 +
>  5 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0980dfe3396b..127dc7432394 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -592,6 +592,11 @@ static void record__init_features(struct record *rec)
>  	if (!rec->opts.full_auxtrace)
>  		perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
>  
> +	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
> +		session->header.env.clockid_res_ns = rec->opts.clockid_res_ns;
> +	else
> +		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
> +

could you please keep only bits setting in record__init_features
and move the header.env.clockid_res_ns assignment out of it?

sry for not catching this in the first version

>  	perf_header__clear_feat(&session->header, HEADER_STAT);
>  }
>  
> @@ -1337,6 +1342,17 @@ static const struct clockid_map clockids[] = {
>  	CLOCKID_END,
>  };
>  
> +static int get_clockid_res(clockid_t clk_id, size_t *res_ns)
> +{
> +	struct timespec res;
> +
> +	*res_ns = 0;
> +	if (!clock_getres(clk_id, &res))
> +		*res_ns = res.tv_nsec + res.tv_sec * NSEC_PER_SEC;

hum, if this one fails (which I guess is unlikely) we should tell
and probably even quit

thanks,
jirka
