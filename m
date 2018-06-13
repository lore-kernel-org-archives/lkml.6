Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 347F6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBC1208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljD5ycjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935704AbeFMUBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935291AbeFMUBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:01:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF22208C4;
        Wed, 13 Jun 2018 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528920082;
        bh=FPNv8l6uh6at53jDcciA1ZU7OH1YVLS/5OQmNmf93p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljD5ycjdZqxD6DNBryCy44pzLFLtDMghGrT1nzpuEkFURIvq4zmwKX673dG93syLf
         7Z22dI+8Jsg3uhFWRs34QH90RylwjXCxJpOVebjqqnQCkaPBc6RO02ewAQ17F2NWGb
         V8jweBW9hK11m7d14XmpZme37+qkjx/WqTRFzaIQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 202301450F4; Wed, 13 Jun 2018 17:01:20 -0300 (-03)
Date:   Wed, 13 Jun 2018 17:01:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Kim Phillips <kim.phillips@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/2] perf tests: Add valid callback for parse-events test
Message-ID: <20180613200120.GF2686@kernel.org>
References: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
 <20180611093422.1005-1-jolsa@kernel.org>
 <20180611093422.1005-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611093422.1005-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 11, 2018 at 11:34:22AM +0200, Jiri Olsa escreveu:
> Adding optional 'valid' callback for events tests in
> parse-events object, so we don't try to parse PMUs,
> which are not supported.
> 
> Following line is displayed for skipped test:
> 
>   running test 52 'intel_pt//u'... SKIP

Would be nice to test the _parsing_ of this even on machines where this
PMU is not present, as developers using these machines as workstations
may end up breaking this.

Anyway, intel_pt now is in tons of machines, so should be caught easily,
if not by anyone, by me ;-\

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-to9naisphr61z23b0br10xhh@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/parse-events.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 3b0bfdf5a594..347378ddaa8b 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1309,6 +1309,11 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
>  	return 0;
>  }
>  
> +static bool test__intel_pt_valid(void)
> +{
> +	return !!perf_pmu__find("intel_pt");
> +}
> +
>  static int test__intel_pt(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel = perf_evlist__first(evlist);
> @@ -1375,6 +1380,7 @@ struct evlist_test {
>  	const char *name;
>  	__u32 type;
>  	const int id;
> +	bool (*valid)(void);
>  	int (*check)(struct perf_evlist *evlist);
>  };
>  
> @@ -1648,6 +1654,7 @@ static struct evlist_test test__events[] = {
>  	},
>  	{
>  		.name  = "intel_pt//u",
> +		.valid = test__intel_pt_valid,
>  		.check = test__intel_pt,
>  		.id    = 52,
>  	},
> @@ -1690,6 +1697,11 @@ static int test_event(struct evlist_test *e)
>  	struct perf_evlist *evlist;
>  	int ret;
>  
> +	if (e->valid && !e->valid()) {
> +		pr_debug("... SKIP");
> +		return 0;
> +	}
> +
>  	evlist = perf_evlist__new();
>  	if (evlist == NULL)
>  		return -ENOMEM;
> @@ -1716,10 +1728,11 @@ static int test_events(struct evlist_test *events, unsigned cnt)
>  	for (i = 0; i < cnt; i++) {
>  		struct evlist_test *e = &events[i];
>  
> -		pr_debug("running test %d '%s'\n", e->id, e->name);
> +		pr_debug("running test %d '%s'", e->id, e->name);
>  		ret1 = test_event(e);
>  		if (ret1)
>  			ret2 = ret1;
> +		pr_debug("\n");
>  	}
>  
>  	return ret2;
> @@ -1801,7 +1814,7 @@ static int test_pmu_events(void)
>  	}
>  
>  	while (!ret && (ent = readdir(dir))) {
> -		struct evlist_test e;
> +		struct evlist_test e = { 0 };
>  		char name[2 * NAME_MAX + 1 + 12 + 3];
>  
>  		/* Names containing . are special and cannot be used directly */
> -- 
> 2.13.6
