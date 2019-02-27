Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4820C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfB0NKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:10:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfB0NKt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:10:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7062E2DC358;
        Wed, 27 Feb 2019 13:10:49 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6184E1001DED;
        Wed, 27 Feb 2019 13:10:47 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:10:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/3] perf diff: Support --time filter option
Message-ID: <20190227131045.GB18893@krava>
References: <1551183069-5931-1-git-send-email-yao.jin@linux.intel.com>
 <1551183069-5931-2-git-send-email-yao.jin@linux.intel.com>
 <20190227092812.GB22793@krava>
 <2eecb3cf-1dcc-f98f-1ca5-f9c29bd8fd8f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eecb3cf-1dcc-f98f-1ca5-f9c29bd8fd8f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 27 Feb 2019 13:10:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:51:44PM +0800, Jin, Yao wrote:
> 
> 
> On 2/27/2019 5:28 PM, Jiri Olsa wrote:
> > On Tue, Feb 26, 2019 at 08:11:07PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +		.ordered_events = true,
> > > +		.ordering_requires_timestamps = true,
> > > +	},
> > >   };
> > >   static struct perf_evsel *evsel_match(struct perf_evsel *evsel,
> > > @@ -771,19 +788,136 @@ static void data__free(struct data__file *d)
> > >   	}
> > >   }
> > > +static int parse_time_range(struct data__file *d,
> > > +			    struct perf_time_interval *ptime_range,
> > > +			    const char *time_str)
> > > +{
> > > +	if (perf_time__parse_str(ptime_range,
> > > +				 time_str) != 0) {
> > > +		if (d->session->evlist->first_sample_time == 0 &&
> > > +		    d->session->evlist->last_sample_time == 0) {
> > > +			pr_err("HINT: no first/last sample time found in perf data.\n"
> > > +			       "Please use latest perf binary to execute 'perf record'\n"
> > > +			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		pdiff.range_num = perf_time__percent_parse_str(
> > > +				ptime_range, pdiff.range_size, time_str,
> > > +				d->session->evlist->first_sample_time,
> > > +				d->session->evlist->last_sample_time);
> > > +
> > > +		if (pdiff.range_num < 0) {
> > > +			pr_err("Invalid time string\n");
> > > +			return -EINVAL;
> > > +		}
> > > +	} else {
> > > +		pdiff.range_num = 1;
> > 
> > I dont understand why we set range_num to 1 if there's
> > not time option set.. it should be 0 and we should take
> > no action in diff__process_sample_event, right?
> > 
> > then I checked the report code and we do the same,
> > could we fix that? I'm assuming we don't need any
> > time check if the time option is not set.. please
> > correct me if I miss something
> > 
> > jirka
> > 
> 
> We support multiple complicated time strings. :(
> 
> In parse_time_range(), perf_time__parse_str() returns 0 if the time string
> is a simple start/stop format. So next, we set the range_num to 1. If the
> time string contains multiple time percent ranges (e.g. "10%/1,10%/2,..."),
> perf_time__parse_str() will return with error (<0), then we will continue
> checking with perf_time__percent_parse_str().
> 
> So when range_num is set to 1, it just means it's the simple time string.

why do we need to have time range set if there's no --time
option set by user?

jirka
