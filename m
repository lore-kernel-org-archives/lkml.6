Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BF4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A0B2152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx1I5pli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A0B2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeHOWd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbeHOWd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:33:27 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59EA1214DC;
        Wed, 15 Aug 2018 19:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534361997;
        bh=z++x4Xy56bawcIUrd4+tgL56vaDdKUs3aLT+7IuBgdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jx1I5pliLsAEgJgSWisbwbNzzUNIaJFge4tMoJsgtdogJEN8KIliC/GkoIXzOZQ+C
         gQaFgaKMxrIzDtj881zVgFKH95waElHeaZ1WfC+kfUDoUY2AHd1685PN8MYJ0Ri1l+
         hZiUpaYdqZTSYn3Lq9xgFReyDOLq9RZZ2QxYLzd4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C9DBB140A1C; Wed, 15 Aug 2018 16:39:48 -0300 (-03)
Date:   Wed, 15 Aug 2018 16:39:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jack Henschel <jackdev@mailbox.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V2] perf parser: Improve error message for PMU address
 filters
Message-ID: <20180815193948.GB5976@kernel.org>
References: <20180704121345.19025-1-jackdev@mailbox.org>
 <20180704152536.GC19164@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704152536.GC19164@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 04, 2018 at 05:25:36PM +0200, Jiri Olsa escreveu:
> On Wed, Jul 04, 2018 at 02:13:45PM +0200, Jack Henschel wrote:
> > This is the second version of a patch that improves the error
> > message of the perf events parser when the PMU hardware does not support
> > address filters.
> > 
> > Previously, the perf returned the following error:
> > > $ perf record -e intel_pt// --filter 'filter sys_write'
> > > --filter option should follow a -e tracepoint or HW tracer option
> > This implies there is some syntax error present in the command line,
> > which is not true. Rather, notify the user that the CPU does not have
> > support for this feature.
> > 
> > For example, Intel chips based on the Broadwell micro-archticture have
> > the Intel PT PMU, but do not support address filtering.
> > 
> > Now, perf prints the following error message:
> > > $ perf record -e intel_pt// --filter 'filter sys_write'
> > > This CPU does not support address filtering
> > 
> > Signed-off-by: Jack Henschel <jackdev@mailbox.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, tested and applied,

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/parse-events.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 15eec49e71a1..f8cd3e7c9186 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
> >  	int nr_addr_filters = 0;
> >  	struct perf_pmu *pmu = NULL;
> >  
> > -	if (evsel == NULL)
> > -		goto err;
> > +	if (evsel == NULL) {
> > +		fprintf(stderr,
> > +			"--filter option should follow a -e tracepoint or HW tracer option\n");
> > +		return -1;
> > +	}
> >  
> >  	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> >  		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
> > @@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
> >  		perf_pmu__scan_file(pmu, "nr_addr_filters",
> >  				    "%d", &nr_addr_filters);
> >  
> > -	if (!nr_addr_filters)
> > -		goto err;
> > +	if (!nr_addr_filters) {
> > +		fprintf(stderr,
> > +			"This CPU does not support address filtering\n");
> > +		return -1;
> > +	}
> >  
> >  	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
> >  		fprintf(stderr,
> > @@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
> >  	}
> >  
> >  	return 0;
> > -
> > -err:
> > -	fprintf(stderr,
> > -		"--filter option should follow a -e tracepoint or HW tracer option\n");
> > -
> > -	return -1;
> >  }
> >  
> >  int parse_filter(const struct option *opt, const char *str,
> > -- 
> > 2.18.0
> > 
