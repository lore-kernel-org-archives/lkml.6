Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22974C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A702098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A702098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJCVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:05:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E2A630820CF;
        Wed,  3 Oct 2018 14:16:31 +0000 (UTC)
Received: from krava (ovpn-204-176.brq.redhat.com [10.40.204.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 76E58308BDA0;
        Wed,  3 Oct 2018 14:16:28 +0000 (UTC)
Date:   Wed, 3 Oct 2018 16:16:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf tools: Allocate id array in
 perf_event__synthesize_event_update_cpus
Message-ID: <20181003141627.GA6341@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava>
 <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 03 Oct 2018 14:16:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:08:10PM +0100, John Garry wrote:
> On 03/10/2018 12:36, Jiri Olsa wrote:
> > On Tue, Oct 02, 2018 at 01:16:21PM +0200, Jiri Olsa wrote:
> > > On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:
> > > 
> > > SNIP
> > > 
> > > > > 
> > > > > 
> > > > > ---
> > > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > > index 1ec1d9bc2d63..fb2a0dab3978 100644
> > > > > --- a/tools/perf/util/header.c
> > > > > +++ b/tools/perf/util/header.c
> > > > > @@ -29,6 +29,7 @@
> > > > >  #include "symbol.h"
> > > > >  #include "debug.h"
> > > > >  #include "cpumap.h"
> > > > > +#include "thread_map.h"
> > > > >  #include "pmu.h"
> > > > >  #include "vdso.h"
> > > > >  #include "strbuf.h"
> > > > > @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> > > > > 	if (!evsel->own_cpus)
> > > > > 		return 0;
> > > > > 
> > > > > +	if (!evsel->id ||
> > > > 
> > > > for my test, evsel->id is NULL
> > > > 
> > > > > +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> > > > > +				 thread_map__nr(evsel->threads)))
> > > > 
> > > > and then this function is not called as we return immediately. So did you
> > > > really want this:
> > > > 
> > > > if (!evsel->id && perf_evsel__alloc_id(...))
> > > > 	return -ENOMEM;
> > > 
> > > ugh.. yes ;-) thanks for the fix.. I'll double
> > > check the logic and post the patch this week
> > 
> > actualy, we also need to populate those ids ;-)
> > so calling perf_evsel__store_ids instead..
> > attaching the full patch
> > 
> > thanks,
> > jirka
> > 
> 
> Hi Jirka,
> 
> Can you please double-check your new patch, as I'm getting this now:
> root@localhost:~# ./perf_debug record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
> root@localhost:~# ./perf_debug report
> 0xe8 [0]: failed to process type: 461
> Error:
> failed to process sample
> # To display the perf.data header info, please use --header/--header-only
> option
> #
> root@localhost:~#

ok, I need to get a machine to test this.. but it looks like
any sample-able events with cpumask are in arm :-\ will try
to get some..

jirka
