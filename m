Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B78C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2662148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfA1L1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:27:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50801 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1L1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11BE9AC5FB;
        Mon, 28 Jan 2019 11:27:52 +0000 (UTC)
Received: from krava (unknown [10.40.205.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id F12DB1001943;
        Mon, 28 Jan 2019 11:27:49 +0000 (UTC)
Date:   Mon, 28 Jan 2019 12:27:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
Message-ID: <20190128112748.GC15461@krava>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 28 Jan 2019 11:27:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 08:45:12PM +0300, Alexey Budankov wrote:

SNIP

> The patch set has been validated on BT benchmark from NAS Parallel 
> Benchmarks [2] running on dual socket, 44 cores, 88 hw threads Broadwell 
> system with kernels v4.4-21-generic (Ubuntu 16.04) and v4.20.0-rc5 
> (tip perf/core). 
> 
> The patch set is for Arnaldo's perf/core repository.
> 
> OVERHEAD:
> 			       BENCH REPORT BASED   ELAPSED TIME BASED
> 	  v4.20.0-rc5 
>           (tip perf/core):
> 				
> (current) SERIAL-SYS  / BASE : 1.27x (14.37/11.31), 1.29x (15.19/11.69)
> 	  SERIAL-NODE / BASE : 1.15x (13.04/11.31), 1.17x (13.79/11.69)
> 	  SERIAL-CPU  / BASE : 1.00x (11.32/11.31), 1.01x (11.89/11.69)
> 	
> 	  AIO1-SYS    / BASE : 1.29x (14.58/11.31), 1.29x (15.26/11.69)
> 	  AIO1-NODE   / BASE : 1.08x (12.23/11.31), 1,11x (13.01/11.69)
> 	  AIO1-CPU    / BASE : 1.07x (12.14/11.31), 1.08x (12.83/11.69)
> 
> 	  v4.4.0-21-generic
>           (Ubuntu 16.04 LTS):
> 
> (current) SERIAL-SYS  / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
> 	  SERIAL-NODE / BASE : 1.19x (13.02/10.87), 1.23x (14.03/11.32)
> 	  SERIAL-CPU  / BASE : 1.03x (11.21/10.87), 1.07x (12.18/11.32)
> 	
> 	  AIO1-SYS    / BASE : 1.26x (13.73/10.87), 1.29x (14.69/11.32)
> 	  AIO1-NODE   / BASE : 1.10x (12.04/10.87), 1.15x (13.03/11.32)
> 	  AIO1-CPU    / BASE : 1.12x (12.20/10.87), 1.15x (13.09/11.32)
> 
> ---
> Alexey Budankov (4):
>   perf record: allocate affinity masks
>   perf record: bind the AIO user space buffers to nodes
>   perf record: apply affinity masks when reading mmap buffers
>   perf record: implement --affinity=node|cpu option
> 
>  tools/perf/Documentation/perf-record.txt |   5 ++
>  tools/perf/builtin-record.c              |  45 +++++++++-
>  tools/perf/perf.h                        |   8 ++
>  tools/perf/util/cpumap.c                 |  10 +++
>  tools/perf/util/cpumap.h                 |   1 +
>  tools/perf/util/evlist.c                 |   6 +-
>  tools/perf/util/evlist.h                 |   2 +-
>  tools/perf/util/mmap.c                   | 105 ++++++++++++++++++++++-
>  tools/perf/util/mmap.h                   |   3 +-
>  9 files changed, 175 insertions(+), 10 deletions(-)
> 
> ---
> Changes in v5:
> - avoided multiple allocations of online cpu maps by 
>   implementing it once in cpu_map__online()
> - reduced indentation at record__parse_affinity()

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
