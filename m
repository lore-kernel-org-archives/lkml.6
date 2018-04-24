Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeDXT3K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeDXT3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:29:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE4C21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 24 Apr 2018 16:29:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org
Subject: Re: [PATCH 5/5] perf stat: Fix duplicate PMU name for interval print
Message-ID: <20180424192904.GD4427@kernel.org>
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
 <1524594014-79243-5-git-send-email-kan.liang@linux.intel.com>
 <20180424185334.GA4427@kernel.org>
 <2965045c-a6b2-6ec7-26c4-9b1fdabee791@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2965045c-a6b2-6ec7-26c4-9b1fdabee791@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 24, 2018 at 03:18:34PM -0400, Liang, Kan escreveu:
> On 4/24/2018 2:53 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Apr 24, 2018 at 11:20:14AM -0700, kan.liang@linux.intel.com escreveu:
> > > +		if (strstr(counter->name, counter->pmu_name))
> > > +			return;
> > >   		if (asprintf(&new_name,
> > >   			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
> > >   			free(counter->name);

> > Humm, do you have any problem with the patch below instead?
 
> No. The patch as below looks good to me.

Thanks for checking,

- Arnaldo

> > +++ b/tools/perf/builtin-stat.c
> > @@ -1261,7 +1261,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
> > -	if (!counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> > +	if (counter->uniquified_name ||
> > +	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> >   					   strlen(counter->pmu_name)))
> > @@ -1279,6 +1280,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
> >   	}
> > +
> > +	counter->uniquified_name = true;
> > +++ b/tools/perf/util/evsel.h
> > @@ -115,6 +115,7 @@ struct perf_evsel {
> >   	unsigned int		sample_size;
> >   	int			id_pos;
> >   	int			is_pos;
> > +	bool			uniquified_name;
