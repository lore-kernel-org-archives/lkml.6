Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AFFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC95214DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC95214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeGDKYa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:24:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933689AbeGDKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E56DE407048D;
        Wed,  4 Jul 2018 10:24:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E5B02166BA9;
        Wed,  4 Jul 2018 10:24:24 +0000 (UTC)
Date:   Wed, 4 Jul 2018 12:24:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jack Henschel <jackdev@mailbox.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf parser: Improve error message for PMU address
 filters
Message-ID: <20180704102424.GA19164@krava>
References: <20180704095409.6109-1-jackdev@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704095409.6109-1-jackdev@mailbox.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 10:24:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 10:24:26 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:54:09AM +0200, Jack Henschel wrote:
> This patch improves the error message of the perf events parser
> when the PMU hardware does not support address filters.
> 
> Previously, the perf returned the following error:
> > --filter option should follow a -e tracepoint or HW tracer option
> This implies there is some syntax error present in the command line,
> which is not true. Rather, notify the user that the CPU does not have
> support for this feature.
> 
> For example, Intel chips based on the Broadwell micro-archticture have
> the Intel PT PMU, but do not support address filtering.

looks ok, but please provide real examples of those error outputs in changelog

thanks,
jirka

> 
> Signed-off-by: Jack Henschel <jackdev@mailbox.org>
> ---
>  tools/perf/util/parse-events.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 15eec49e71a1..f8cd3e7c9186 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
>  	int nr_addr_filters = 0;
>  	struct perf_pmu *pmu = NULL;
>  
> -	if (evsel == NULL)
> -		goto err;
> +	if (evsel == NULL) {
> +		fprintf(stderr,
> +			"--filter option should follow a -e tracepoint or HW tracer option\n");
> +		return -1;
> +	}
>  
>  	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
>  		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
> @@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
>  		perf_pmu__scan_file(pmu, "nr_addr_filters",
>  				    "%d", &nr_addr_filters);
>  
> -	if (!nr_addr_filters)
> -		goto err;
> +	if (!nr_addr_filters) {
> +		fprintf(stderr,
> +			"This CPU does not support address filtering\n");
> +		return -1;
> +	}
>  
>  	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
>  		fprintf(stderr,
> @@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
>  	}
>  
>  	return 0;
> -
> -err:
> -	fprintf(stderr,
> -		"--filter option should follow a -e tracepoint or HW tracer option\n");
> -
> -	return -1;
>  }
>  
>  int parse_filter(const struct option *opt, const char *str,
> -- 
> 2.18.0
> 
