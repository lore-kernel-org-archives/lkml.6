Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF4EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0394B2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfBUNxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:53:46 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:50207 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbfBUNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:53:46 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444wtH3CBDz8tcg;
        Thu, 21 Feb 2019 14:53:43 +0100 (CET)
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 91.250.241.241
Received: from uni-erlangen.de (unknown [91.250.241.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19m+PNzRBeUEMkUA87GAhq8q3giG1oWXBE=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444wtB5sjGz8tZK;
        Thu, 21 Feb 2019 14:53:38 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:53:20 +0100
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf hist: fix memory leak if histogram entry is reused
Message-ID: <20190221135320.io7egcwajehfrdd5@studium.uni-erlangen.de>
References: <20190221122306.1511-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190221123909.GG10990@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221123909.GG10990@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 01:39:09PM +0100, Jiri Olsa wrote:
> On Thu, Feb 21, 2019 at 01:23:06PM +0100, Jonas Rabenstein wrote:
> > In __hists__add_entry the srcline of the addr_location is duplicated
> > for the hist_entry. If hists__findnew_entry returns an already existing
> > hist_entry the srcline has to be freed again as no further reference to
> > that duplicated srcline would exists anymore.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > ---
> >  tools/perf/util/hist.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 8aad8330e392..25b8dbdbbe87 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -623,6 +623,9 @@ __hists__add_entry(struct hists *hists,
> >  		.ops = ops,
> >  	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
> >  
> > +	if (he && he->srcline != entry.srcline)
> > +		free(entry.srcline);
> > +
> >  	if (!hists->has_callchains && he && he->callchain_size != 0)
> >  		hists->has_callchains = true;
> >  	return he;
> 
> nice, do we have similar issue in here?
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 216388003dea..e65e6822c848 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -966,7 +966,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
>  			.map = al->map,
>  			.sym = al->sym,
>  		},
> -		.srcline = al->srcline ? strdup(al->srcline) : NULL,
> +		.srcline = al->srcline,
While this shouldn't leak the memory, we may end up with an al->srcline
to get free afterwards while still having a reference on it within the
hist_entry... Also I could not find where/how the hist_entry is freed up
so we may get an double free if both of al and he clean the srcline.
Of course, with your solution we could spare the useless strdup/free if
we find an hist_entry (which should be the typical case for hotspots..).
Taking a deeper look thus should be beneficial - but I do not have the
time for that right now because I'm still working on the inline-symbol
integration which is more important for me...
 - Jonas
>  		.parent = iter->parent,
>  		.raw_data = sample->raw_data,
>  		.raw_size = sample->raw_size,
