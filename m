Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFC9204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFC9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeKISCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:02:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbeKISCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:02:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FCDE308429E;
        Fri,  9 Nov 2018 08:22:45 +0000 (UTC)
Received: from krava (unknown [10.40.205.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54457600D4;
        Fri,  9 Nov 2018 08:22:43 +0000 (UTC)
Date:   Fri, 9 Nov 2018 09:22:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v15 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20181109082242.GJ29732@krava>
References: <75e779bf-dc6b-ea24-67a5-f53a39bb7374@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e779bf-dc6b-ea24-67a5-f53a39bb7374@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 09 Nov 2018 08:22:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:53:02AM +0300, Alexey Budankov wrote:
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
>     --call-graph dwarf,1024 --user-regs=IP,SP,BP --switch-events \
>     -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
>     matrix.gcc
> 
> Data loss metrics is the ratio lost_time/elapsed_time where 
> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> records and elapsed_time is the elapsed application run time 
> under profiling.
> 
> Applying asynchronous trace streaming thru Posix AIO API [1] lowers 
> data loss metrics value providing 2x improvement (from 98% to ~1%)
> 
> Asynchronous trace streaming is currently limited to glibc linkage.
> musl libc [5] also provides Posix AIO API implementation, however 
> the patchkit is not tested with it. There may be other libc libraries 
> linked by Perf tool that currently lack Posix AIO API support [2], 
> [3], [4] so NO_AIO define may be used to limit Perf tool binary to 
> serial streaming only.
> 
> ---
>  Alexey Budankov (3):
> 	perf util: map data buffer for preserving collected data
> 	perf record: enable asynchronous trace writing
> 	perf record: extend trace writing to multi AIO

FYI I was rebasing my threads branch on top of this and
first 2 won't apply anymore on Arnaldo's perf/core

Arnaldo,
could we get this merged soon? the world around is moving
fast and we don't want 20th revision on this ;-)

thanks,
jirka
