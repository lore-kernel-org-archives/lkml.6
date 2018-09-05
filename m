Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCEFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8B20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC8B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIEP6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:58:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeIEP6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:58:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57AC326A5E;
        Wed,  5 Sep 2018 11:28:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id F303CD93D5;
        Wed,  5 Sep 2018 11:28:51 +0000 (UTC)
Date:   Wed, 5 Sep 2018 13:28:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180905112851.GA29759@krava>
References: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc1fc5b-a8cc-2b05-d43c-692e58855c81@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 05 Sep 2018 11:28:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 05 Sep 2018 11:28:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:16:42AM +0300, Alexey Budankov wrote:
> 
> Currently in record mode the tool implements trace writing serially. 
> The algorithm loops over mapped per-cpu data buffers and stores 
> ready data chunks into a trace file using write() system call.
> 
> At some circumstances the kernel may lack free space in a buffer 
> because the other buffer's half is not yet written to disk due to 
> some other buffer's data writing by the tool at the moment.
> 
> Thus serial trace writing implementation may cause the kernel 
> to loose profiling data and that is what observed when profiling 
> highly parallel CPU bound workloads on machines with big number 
> of cores.
> 
> Experiment with profiling matrix multiplication code executing 128 
> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
> demonstrates data loss metrics value of 98%:
> 
> /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
>     --call-graph dwarf,1024 --user-regs=IP,SP,BP \
>     --switch-events -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
>     matrix.gcc
> 
> Data loss metrics is the ratio lost_time/elapsed_time where 
> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> records and elapsed_time is the elapsed application run time 
> under profiling.
> 
> Applying asynchronous trace streaming thru Posix AIO API
> (http://man7.org/linux/man-pages/man7/aio.7.html) 
> lowers data loss metrics value providing 2x improvement -
> lowering 98% loss to almost 0%.
> 
> ---
>  Alexey Budankov (2):
>         perf util: map data buffer for preserving collected data
> 	perf record: enable asynchronous trace writing
>  
>  tools/perf/builtin-record.c | 197 +++++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/perf.h           |   1 +
>  tools/perf/util/evlist.c    |   7 +-
>  tools/perf/util/evlist.h    |   3 +-
>  tools/perf/util/mmap.c      | 110 +++++++++++++++++++++----
>  tools/perf/util/mmap.h      |  10 ++-
>  6 files changed, 302 insertions(+), 26 deletions(-)
> 
> ---
>  Changes in v7:
>  - implemented handling record.aio setting from perfconfig file

can't apply this version on Arnaldo's perf/core...

[jolsa@krava linux-perf]$ git am /tmp/ab/
Applying: perf util: map data buffer for preserving collected data
error: patch failed: tools/perf/util/mmap.c:166
error: tools/perf/util/mmap.c: patch does not apply

thanks,
jirka
