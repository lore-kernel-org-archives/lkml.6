Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C887DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2BF213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2BF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeJCSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeJCSYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C0C13082A26;
        Wed,  3 Oct 2018 11:36:47 +0000 (UTC)
Received: from krava (unknown [10.40.205.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 241CB63F85;
        Wed,  3 Oct 2018 11:36:43 +0000 (UTC)
Date:   Wed, 3 Oct 2018 13:36:43 +0200
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
Subject: [PATCH] perf tools: Allocate id array in
 perf_event__synthesize_event_update_cpus
Message-ID: <20181003113643.GA31725@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002111621.GA6357@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 03 Oct 2018 11:36:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 01:16:21PM +0200, Jiri Olsa wrote:
> On Tue, Oct 02, 2018 at 11:41:36AM +0100, John Garry wrote:
> 
> SNIP
> 
> > > 
> > > 
> > > ---
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index 1ec1d9bc2d63..fb2a0dab3978 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -29,6 +29,7 @@
> > >  #include "symbol.h"
> > >  #include "debug.h"
> > >  #include "cpumap.h"
> > > +#include "thread_map.h"
> > >  #include "pmu.h"
> > >  #include "vdso.h"
> > >  #include "strbuf.h"
> > > @@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
> > > 	if (!evsel->own_cpus)
> > > 		return 0;
> > > 
> > > +	if (!evsel->id ||
> > 
> > for my test, evsel->id is NULL
> > 
> > > +	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
> > > +				 thread_map__nr(evsel->threads)))
> > 
> > and then this function is not called as we return immediately. So did you
> > really want this:
> > 
> > if (!evsel->id && perf_evsel__alloc_id(...))
> > 	return -ENOMEM;
> 
> ugh.. yes ;-) thanks for the fix.. I'll double
> check the logic and post the patch this week

actualy, we also need to populate those ids ;-)
so calling perf_evsel__store_ids instead..
attaching the full patch

thanks,
jirka


---
John reported crash when recording on an event under
pmu with cpumask defined:

  root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
  perf: Segmentation fault
  Obtained 9 stack frames.
  ./perf_debug_() [0x4c5ef8]
  [0xffff82ba267c]
  ./perf_debug_() [0x4bc5a8]
  ./perf_debug_() [0x419550]
  ./perf_debug_() [0x41a928]
  ./perf_debug_() [0x472f58]
  ./perf_debug_() [0x473210]
  ./perf_debug_() [0x4070f4]
  /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
  Segmentation fault (core dumped)

We synthesize an update event that needs to touch the evsel
id array, which is not defined at that time. Fixing this
by allocating the array and getting IDs before it's used.

Reported-by: John Garry <john.garry@huawei.com>
Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1ec1d9bc2d63..14ca27f79d4a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -29,6 +29,7 @@
 #include "symbol.h"
 #include "debug.h"
 #include "cpumap.h"
+#include "thread_map.h"
 #include "pmu.h"
 #include "vdso.h"
 #include "strbuf.h"
@@ -3579,6 +3580,9 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	if (!evsel->own_cpus)
 		return 0;
 
+	if (!evsel->id && perf_evsel__store_ids(evsel, evsel->evlist))
+		return -ENOMEM;
+
 	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
 	if (!ev)
 		return -ENOMEM;
-- 
2.17.1

