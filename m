Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A60C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8892243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8892243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeKMMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:43:18 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:41688 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbeKMMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:43:18 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 13 Nov 2018 11:47:16 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 13 Nov 2018 11:47:16 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 13 Nov 2018 11:47:16 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v15 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20181113024716.GA27910@sejong>
References: <75e779bf-dc6b-ea24-67a5-f53a39bb7374@linux.intel.com>
 <20181109082242.GJ29732@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109082242.GJ29732@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 09, 2018 at 09:22:42AM +0100, Jiri Olsa wrote:
> On Tue, Nov 06, 2018 at 11:53:02AM +0300, Alexey Budankov wrote:
> > 
> > Currently in record mode the tool implements trace writing serially. 
> > The algorithm loops over mapped per-cpu data buffers and stores 
> > ready data chunks into a trace file using write() system call.
> > 
> > At some circumstances the kernel may lack free space in a buffer 
> > because the other buffer's half is not yet written to disk due to 
> > some other buffer's data writing by the tool at the moment.
> > 
> > Thus serial trace writing implementation may cause the kernel 
> > to loose profiling data and that is what observed when profiling 
> > highly parallel CPU bound workloads on machines with big number 
> > of cores.
> > 
> > Experiment with profiling matrix multiplication code executing 128 
> > threads on Intel Xeon Phi (KNM) with 272 cores, like below,
> > demonstrates data loss metrics value of 98%:
> > 
> > /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
> >     --call-graph dwarf,1024 --user-regs=IP,SP,BP --switch-events \
> >     -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
> >     matrix.gcc
> > 
> > Data loss metrics is the ratio lost_time/elapsed_time where 
> > lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> > records and elapsed_time is the elapsed application run time 
> > under profiling.
> > 
> > Applying asynchronous trace streaming thru Posix AIO API [1] lowers 
> > data loss metrics value providing 2x improvement (from 98% to ~1%)
> > 
> > Asynchronous trace streaming is currently limited to glibc linkage.
> > musl libc [5] also provides Posix AIO API implementation, however 
> > the patchkit is not tested with it. There may be other libc libraries 
> > linked by Perf tool that currently lack Posix AIO API support [2], 
> > [3], [4] so NO_AIO define may be used to limit Perf tool binary to 
> > serial streaming only.
> > 
> > ---
> >  Alexey Budankov (3):
> > 	perf util: map data buffer for preserving collected data
> > 	perf record: enable asynchronous trace writing
> > 	perf record: extend trace writing to multi AIO
> 
> FYI I was rebasing my threads branch on top of this and
> first 2 won't apply anymore on Arnaldo's perf/core
> 
> Arnaldo,
> could we get this merged soon? the world around is moving
> fast and we don't want 20th revision on this ;-)

I think I gave my ack to this already too.

Thanks,
Namhyung
