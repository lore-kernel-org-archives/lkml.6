Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74072C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AAD206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AAD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJBR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbeJBR7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA31A3083391;
        Tue,  2 Oct 2018 11:16:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7637756A5;
        Tue,  2 Oct 2018 11:16:22 +0000 (UTC)
Date:   Tue, 2 Oct 2018 13:16:21 +0200
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
Subject: Re: perf segmentation fault from NULL dereference
Message-ID: <20181002111621.GA6357@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 02 Oct 2018 11:16:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:

SNIP

> > 
> > 
> > ---
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 1ec1d9bc2d63..fb2a0dab3978 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -29,6 +29,7 @@
> >  #include "symbol.h"
> >  #include "debug.h"
> >  #include "cpumap.h"
> > +#include "thread_map.h"
> >  #include "pmu.h"
> >  #include "vdso.h"
> >  #include "strbuf.h"
> > @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> > 	if (!evsel->own_cpus)
> > 		return 0;
> > 
> > +	if (!evsel->id ||
> 
> for my test, evsel->id is NULL
> 
> > +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> > +				 thread_map__nr(evsel->threads)))
> 
> and then this function is not called as we return immediately. So did you
> really want this:
> 
> if (!evsel->id && perf_evsel__alloc_id(...))
> 	return -ENOMEM;

ugh.. yes ;-) thanks for the fix.. I'll double
check the logic and post the patch this week

jirka

> 
> This looks to work:
> 
> root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.001 MB perf.data (7 samples) ]
> root@localhost:~# ./perf_debug_ report
> # To display the perf.data header info, please use --header/--header-only
> option
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 7  of event 'armv8_pmuv3_0/br_mis_pred/'
> # Event count (approx.): 8260
> #
> # Overhead  Command  Shared Object      Symbol
> # ........  .......  .................  ......................
> #
>     78.28%  sleep    libc-2.23.so       [.] 0x00000000000faef0
>     20.53%  sleep    [kernel.kallsyms]  [k] vmacache_find
>      1.09%  sleep    [kernel.kallsyms]  [k] find_vma
>      0.10%  perf_de  [kernel.kallsyms]  [k] perf_event_exec
> 
> 
> #
> # (Cannot load tips.txt file, please install perf!)
> #
> root@localhost:~#
> 
> 
> > +		return -ENOMEM;
> > +
> > 	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
> > 	if (!ev)
> > 		return -ENOMEM;
> > 
> > .
> > 
> 
> 
> Thanks,
> John
> 
