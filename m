Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D28620875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBdXFX0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D28620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeFTNtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeFTNtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:49:09 -0400
Received: from jouet.infradead.org (unknown [189.40.103.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621CF20846;
        Wed, 20 Jun 2018 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529502548;
        bh=QRpm8p0T/4ic/4YYJBknJgHfjnmb3ApLsNNd9AgXVdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBdXFX0Fjv0mWtnFi+hj4c84Eyq1IjKPmFCyq2c7yyB4uZOyhoj0vfx0BFtxOoH5U
         3pf1WFF6bFROXHLfdq0NXlhbeTfEBG1NF+etv6dE9A9Ey6lOC7wWsW14J+e2Smg5on
         v8CixYYmGTdwvkUUowouUI1zKZbUUo8F6sX1gh3E=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 27F3E1401E5; Wed, 20 Jun 2018 10:49:05 -0300 (-03)
Date:   Wed, 20 Jun 2018 10:49:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, dsahern@gmail.com, davidcc@google.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf script: Fix crash because of missing feat_op[]
 entry
Message-ID: <20180620134905.GO20477@kernel.org>
References: <20180620133030.2188-1-ravi.bangoria@linux.ibm.com>
 <20180620133030.2188-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620133030.2188-4-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 20, 2018 at 07:00:30PM +0530, Ravi Bangoria escreveu:
> perf_event__process_feature() tries to access feat_ops[feat].process
> which is not defined for feat = HEADER_LAST_FEATURE and thus perf is
> crashing. Add dummy entry for HEADER_LAST_FEATURE in the feat_ops.

Humm, first impression is that we should check for HEADER_LAST_FEATURE
and not try to access that array slot, as it is just a marker, not an
actual feature.

- Arnaldo
 
> Before:
>   # ./perf record -o - ls | ./perf script
>   Segmentation fault (core dumped)
> 
> After:
>   # ./perf record -o - ls | ./perf script
>   ls 7031 4392.099856:  250000 cpu-clock:uhH:  7f5e0ce7cd60
>   ls 7031 4392.100355:  250000 cpu-clock:uhH:  7f5e0c706ef7
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Fixes: 57b5de463925 ("perf report: Support forced leader feature in pipe mode")
> ---
>  tools/perf/util/header.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 540cd2dcd3e7..de8e3e29d870 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2555,14 +2555,18 @@ struct feature_ops {
>  	}
>  
>  /* feature_ops not implemented: */
> +#define write_last_feature	NULL
> +
>  #define print_tracing_data	NULL
>  #define print_build_id		NULL
> +#define print_last_feature	NULL
>  
>  #define process_branch_stack	NULL
>  #define process_stat		NULL
> +#define process_last_feature	NULL
>  
>  
> -static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
> +static const struct feature_ops feat_ops[HEADER_LAST_FEATURE + 1] = {
>  	FEAT_OPN(TRACING_DATA,	tracing_data,	false),
>  	FEAT_OPN(BUILD_ID,	build_id,	false),
>  	FEAT_OPR(HOSTNAME,	hostname,	false),
> @@ -2585,6 +2589,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPN(CACHE,		cache,		true),
>  	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
>  	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
> +	FEAT_OPN(LAST_FEATURE,	last_feature,	false),
>  };
>  
>  struct header_print_data {
> -- 
> 2.14.4
