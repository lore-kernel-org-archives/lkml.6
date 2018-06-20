Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B534CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3A420836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v8lzwLeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3A420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeFTNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754122AbeFTNwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:52:25 -0400
Received: from jouet.infradead.org (unknown [189.40.103.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139C920836;
        Wed, 20 Jun 2018 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529502744;
        bh=CfTniiKrNNLjZitEmAd/T8/VgJZJ090qJrI8bpL7cYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8lzwLeKIP+owfiR+FZZdKoExME1SGSKXZoRHkVF2CL8NqqgA4os1vDHQJ3WJdoYk
         MDBp0yelADxicBtIaVFG46E2cf20/5w3R6OLMOHR8MYuPpTWacdCGMIJJ7XyP5q+fD
         ADzStmBVsaxv5i21a8wBwkDqZQZUtyvesTeCnejQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0323F1401E5; Wed, 20 Jun 2018 10:52:20 -0300 (-03)
Date:   Wed, 20 Jun 2018 10:52:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, dsahern@gmail.com, davidcc@google.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf script: Fix crash because of missing evsel->priv
Message-ID: <20180620135220.GP20477@kernel.org>
References: <20180620133030.2188-1-ravi.bangoria@linux.ibm.com>
 <20180620133030.2188-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620133030.2188-3-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 20, 2018 at 07:00:29PM +0530, Ravi Bangoria escreveu:
> perf script in pipped mode is crashing because evsel->priv is not
> set properly. Fix it.
> 
> Before:
>   # ./perf record -o - -- ls | ./perf script
>     Segmentation fault (core dumped)
> 
> After:
>   # ./perf record -o - -- ls | ./perf script
>   ls 2282 1031.731974:  250000 cpu-clock:uhH:  7effe4b3d29e
>   ls 2282 1031.732222:  250000 cpu-clock:uhH:  7effe4b3a650
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Fixes: a14390fde64e ("perf script: Allow creating per-event dump files")

Humm, this cset doesn't set evsel->priv to a 'struct perf_evsel_script'
object, will check which one does to continue review.

- Arnaldo

> ---
>  tools/perf/builtin-script.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4d1cee68cfd2..acee05562f5e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1822,6 +1822,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
>  	struct perf_evlist *evlist;
>  	struct perf_evsel *evsel, *pos;
>  	int err;
> +	static struct perf_evsel_script *es;
>  
>  	err = perf_event__process_attr(tool, event, pevlist);
>  	if (err)
> @@ -1830,6 +1831,19 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
>  	evlist = *pevlist;
>  	evsel = perf_evlist__last(*pevlist);
>  
> +	if (!evsel->priv) {
> +		if (scr->per_event_dump) {
> +			evsel->priv = perf_evsel_script__new(evsel,
> +						scr->session->data);
> +		} else {
> +			es = zalloc(sizeof(*es));
> +			if (!es)
> +				return -ENOMEM;
> +			es->fp = stdout;
> +			evsel->priv = es;
> +		}
> +	}
> +
>  	if (evsel->attr.type >= PERF_TYPE_MAX &&
>  	    evsel->attr.type != PERF_TYPE_SYNTH)
>  		return 0;
> -- 
> 2.14.4
