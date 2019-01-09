Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB53C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D51206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfAIPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:51:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731620AbfAIPvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:51:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 399F3C0641E2;
        Wed,  9 Jan 2019 15:51:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7D6A45C57C;
        Wed,  9 Jan 2019 15:51:40 +0000 (UTC)
Date:   Wed, 9 Jan 2019 16:51:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
Message-ID: <20190109155139.GC2515@krava>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
 <20190109144125.GA2515@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109144125.GA2515@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 15:51:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:41:25PM +0100, Jiri Olsa wrote:
> On Wed, Jan 09, 2019 at 12:19:20PM +0300, Alexey Budankov wrote:
> > 
> > It has been observed that trace reading thread runs on the same hw thread
> > most of the time during perf record sampling collection. This scheduling
> > layout leads up to 30% profiling overhead in case when some cpu intensive
> > workload fully utilizes a large server system with NUMA. Overhead usually
> > arises from remote (cross node) HW and memory references that have much
> > longer latencies than local ones [1].
> > 
> > This patch set implements --affinity option that lowers 30% overhead
> > completely for serial trace streaming (--affinity=cpu) and from 30% to
> > 10% for AIO1 (--aio=1) trace streaming (--affinity=node|cpu).
> > See OVERHEAD section below for more details.
> > 
> > Implemented extension provides users with capability to instruct Perf 
> > tool to bounce trace reading thread's affinity mask between NUMA nodes 
> > (--affinity=node) or assign the thread to the exact cpu (--affinity=cpu) 
> > that trace buffer being processed belongs to.
> > 
> > The extension brings improvement in case of full system utilization when 
> > Perf tool process contends with workload process on cpu cores. In case a 
> > system has free cores to execute Perf tool process during profiling the 
> > default system scheduling layout induces the lowest overhead.
> > 
> > The patch set has been validated on BT benchmark from NAS Parallel 
> > Benchmarks [2] running on dual socket, 44 cores, 88 hw threads Broadwell 
> > system with kernels v4.4-21-generic (Ubuntu 16.04) and v4.20.0-rc5 
> > (tip perf/core). 
> > 
> > OVERHEAD:
> > 			       BENCH REPORT BASED   ELAPSED TIME BASED
> > 	  v4.20.0-rc5 
> >           (tip perf/core):
> > 				
> > (current) SERIAL-SYS  / BASE : 1.27x (14.37/11.31), 1.29x (15.19/11.69)
> > 	  SERIAL-NODE / BASE : 1.15x (13.04/11.31), 1.17x (13.79/11.69)
> > 	  SERIAL-CPU  / BASE : 1.00x (11.32/11.31), 1.01x (11.89/11.69)
> > 	
> > 	  AIO1-SYS    / BASE : 1.29x (14.58/11.31), 1.29x (15.26/11.69)
> > 	  AIO1-NODE   / BASE : 1.08x (12.23/11.31), 1,11x (13.01/11.69)
> > 	  AIO1-CPU    / BASE : 1.07x (12.14/11.31), 1.08x (12.83/11.69)
> > 
> > 	  v4.4.0-21-generic
> >           (Ubuntu 16.04 LTS):
> > 
> > (current) SERIAL-SYS  / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
> > 	  SERIAL-NODE / BASE : 1.19x (13.02/10.87), 1.23x (14.03/11.32)
> > 	  SERIAL-CPU  / BASE : 1.03x (11.21/10.87), 1.07x (12.18/11.32)
> > 	
> > 	  AIO1-SYS    / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
> > 	  AIO1-NODE   / BASE : 1.10x (12.04/10.87), 1.15x (13.03/11.32)
> > 	  AIO1-CPU    / BASE : 1.12x (12.20/10.87), 1.15x (13.09/11.32)
> > 
> > The patch set is generated for acme perf/core repository.
> > 
> > ---
> > Alexey Budankov (4):
> >   perf record: allocate affinity masks
> >   perf record: bind the AIO user space buffers to nodes
> >   perf record: apply affinity masks when reading mmap buffers
> >   perf record: implement --affinity=node|cpu option
> 
> 
> hi,
> can't apply your code on latest Arnaldo's perf/core:
> 
> Applying: perf record: allocate affinity masks
> Applying: perf record: bind the AIO user space buffers to nodes
> Applying: perf record: apply affinity masks when reading mmap buffers
> Applying: perf record: implement --affinity=node|cpu option
> error: corrupt patch at line 62
> Patch failed at 0004 perf record: implement --affinity=node|cpu option
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

hum, when I separate the raw patch and apply it works with no fuzz:

[jolsa@krava perf]$ patch -p3 < /tmp/krava
patching file Documentation/perf-record.txt
patching file builtin-record.c

this email header caught my eye:

  User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.4.0
 
but no idea what's the issue in here ;-)

jirka
