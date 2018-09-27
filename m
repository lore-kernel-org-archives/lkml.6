Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E846C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D1A21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D1A21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeI0WVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:21:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbeI0WVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B848308AA13;
        Thu, 27 Sep 2018 16:02:16 +0000 (UTC)
Received: from krava (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with SMTP id A1B49600C7;
        Thu, 27 Sep 2018 16:02:11 +0000 (UTC)
Date:   Thu, 27 Sep 2018 18:02:10 +0200
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
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf segmentation fault from NULL dereference
Message-ID: <20180927160210.GF6916@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 27 Sep 2018 16:02:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:53:40PM +0100, John Garry wrote:
> Hi,
> 
> I am seeing this perf crash on my arm64-based system:
> 
> root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
> perf: Segmentation fault
> Obtained 9 stack frames.
> ./perf_debug_() [0x4c5ef8]
> [0xffff82ba267c]
> ./perf_debug_() [0x4bc5a8]
> ./perf_debug_() [0x419550]
> ./perf_debug_() [0x41a928]
> ./perf_debug_() [0x472f58]
> ./perf_debug_() [0x473210]
> ./perf_debug_() [0x4070f4]
> /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
> Segmentation fault (core dumped)
> 
> I find 'cycles' event is fine.
> 
> I bisected the issue to here:
> commit bfd8f72c2778f5bd63dc9eb6d23bd7a0d99cff6d (HEAD, refs/bisect/bad)
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Fri Nov 17 13:42:58 2017 -0800
> 
>     perf record: Synthesize unit/scale/... in event update
> 
>     Move the code to synthesize event updates for scale/unit/cpus to a
>     common utility file, and use it both from stat and record.
> 
>     This allows to access scale and other extra qualifiers from perf script.
> 
>     Signed-off-by: Andi Kleen <ak@linux.intel.com>
>     Acked-by: Jiri Olsa <jolsa@kernel.org>
>     Link:
> http://lkml.kernel.org/r/20171117214300.32746-2-andi@firstfloor.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> I am suspicious that this is a real issue, as this patch has been in
> mainline for some time...
> 
> This simple change fixes the issue me:
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 91e6d9c..f4fd826 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3576,7 +3576,7 @@ int perf_event__process_feature(struct perf_tool
> *tool,
>      int max, err;
>      u16 type;
> 
> -    if (!evsel->own_cpus)
> +    if (!evsel->own_cpus || !(evsel->attr.read_format & PERF_FORMAT_ID)) //
> roundabout check for !evsel->id
>          return 0;
> 
>      ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
> 
> It turns out that evsel->id is NULL on a call to
> perf_event__process_feature(), which upsets this code:
> 
>     ev->header.type = PERF_RECORD_EVENT_UPDATE;
>     ev->header.size = (u16)size;
>     ev->type = PERF_EVENT_UPDATE__CPUS;
>     ev->id   = evsel->id[0];
> 
> Please me let me know if a valid issue so we can get a fix in.

yea, I can see how we can get here with event having
its own CPUs, and we allocate the id array later at
the time we map the event

I wonder instead of skipping on this feature, we should
allocate the id array, like below

I did not test that.. need to find the server having event
with its own cpus.. also need to make sure evsel->cpus is
the way to go in here

thanks,
jirka


---
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1ec1d9bc2d63..fb2a0dab3978 100644
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
@@ -3579,6 +3580,11 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
	if (!evsel->own_cpus)
		return 0;
 
+	if (!evsel->id ||
+	    perf_evsel__alloc_id(evsel, cpu_map__nr(evsel->cpus),
+				 thread_map__nr(evsel->threads)))
+		return -ENOMEM;
+
	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
	if (!ev)
		return -ENOMEM;
