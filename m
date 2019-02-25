Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DDEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF58213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBYM4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfBYM4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 224BF3082E07;
        Mon, 25 Feb 2019 12:56:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B08E1001947;
        Mon, 25 Feb 2019 12:56:43 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 01/11] perf tools script: Handle missing fields with -F
 +..
Message-ID: <20190225125642.GM19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-2-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 25 Feb 2019 12:56:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:12AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When using -F + syntax to add a field the existing defaults
> are currently all marked user_set. This can cause errors when
> some field is missing in the perf.data
> 
> This patch tracks the actually user set fields separately,
> so that we don't error out in this case.
> 
> Before:
> 
> % perf record true
> % perf script -F +metric
> Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
> %
> 
> After
> 
> 5 perf record true
> % perf script -F +metric
>             perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
> ...
> %
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

nice, that one was annoying

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-script.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 8d5fe092525c..29e95a25c6e6 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -149,6 +149,7 @@ static struct {
>  	unsigned int print_ip_opts;
>  	u64 fields;
>  	u64 invalid_fields;
> +	u64 user_set_fields;
>  } output[OUTPUT_TYPE_MAX] = {
>  
>  	[PERF_TYPE_HARDWARE] = {
> @@ -345,7 +346,7 @@ static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
>  	if (attr->sample_type & sample_type)
>  		return 0;
>  
> -	if (output[type].user_set) {
> +	if (output[type].user_set_fields & field) {
>  		if (allow_user_set)
>  			return 0;
>  		evname = perf_evsel__name(evsel);
> @@ -2628,10 +2629,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
>  					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
>  						   all_output_options[i].str, event_type(j));
>  				} else {
> -					if (change == REMOVE)
> +					if (change == REMOVE) {
>  						output[j].fields &= ~all_output_options[i].field;
> -					else
> +						output[j].user_set_fields &= ~all_output_options[i].field;
> +					} else {
>  						output[j].fields |= all_output_options[i].field;
> +						output[j].user_set_fields |= all_output_options[i].field;
> +					}
>  					output[j].user_set = true;
>  					output[j].wildcard_set = true;
>  				}
> -- 
> 2.17.2
> 
