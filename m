Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2B120818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBUQ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:29:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBUQ3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:29:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6A8D30A56BB;
        Thu, 21 Feb 2019 16:29:01 +0000 (UTC)
Received: from krava (ovpn-204-108.brq.redhat.com [10.40.204.108])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69D6E1001DD3;
        Thu, 21 Feb 2019 16:28:59 +0000 (UTC)
Date:   Thu, 21 Feb 2019 17:28:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf hist: fix memory leak if histogram entry is reused
Message-ID: <20190221162858.GA3940@krava>
References: <20190221122306.1511-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190221123909.GG10990@krava>
 <20190221135320.io7egcwajehfrdd5@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221135320.io7egcwajehfrdd5@studium.uni-erlangen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Feb 2019 16:29:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:53:20PM +0100, Jonas Rabenstein wrote:
> On Thu, Feb 21, 2019 at 01:39:09PM +0100, Jiri Olsa wrote:
> > On Thu, Feb 21, 2019 at 01:23:06PM +0100, Jonas Rabenstein wrote:
> > > In __hists__add_entry the srcline of the addr_location is duplicated
> > > for the hist_entry. If hists__findnew_entry returns an already existing
> > > hist_entry the srcline has to be freed again as no further reference to
> > > that duplicated srcline would exists anymore.
> > > 
> > > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > > ---
> > >  tools/perf/util/hist.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index 8aad8330e392..25b8dbdbbe87 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -623,6 +623,9 @@ __hists__add_entry(struct hists *hists,
> > >  		.ops = ops,
> > >  	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
> > >  
> > > +	if (he && he->srcline != entry.srcline)
> > > +		free(entry.srcline);
> > > +
> > >  	if (!hists->has_callchains && he && he->callchain_size != 0)
> > >  		hists->has_callchains = true;
> > >  	return he;
> > 
> > nice, do we have similar issue in here?
> > 
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > index 216388003dea..e65e6822c848 100644
> > --- a/tools/perf/util/hist.c
> > +++ b/tools/perf/util/hist.c
> > @@ -966,7 +966,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
> >  			.map = al->map,
> >  			.sym = al->sym,
> >  		},
> > -		.srcline = al->srcline ? strdup(al->srcline) : NULL,
> > +		.srcline = al->srcline,
> While this shouldn't leak the memory, we may end up with an al->srcline
> to get free afterwards while still having a reference on it within the
> hist_entry... Also I could not find where/how the hist_entry is freed up
> so we may get an double free if both of al and he clean the srcline.
> Of course, with your solution we could spare the useless strdup/free if
> we find an hist_entry (which should be the typical case for hotspots..).
> Taking a deeper look thus should be beneficial - but I do not have the
> time for that right now because I'm still working on the inline-symbol
> integration which is more important for me...

ok, I'll check it 

jirka
