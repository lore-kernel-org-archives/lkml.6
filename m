Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E359C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05570208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05570208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeH0MOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:14:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0MOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:14:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 500BE4023461;
        Mon, 27 Aug 2018 08:28:21 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DADCA2166B41;
        Mon, 27 Aug 2018 08:28:19 +0000 (UTC)
Date:   Mon, 27 Aug 2018 10:28:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2]: perf util: map data buffer for preserving
 collected data
Message-ID: <20180827082819.GC24695@krava>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5591d27-5386-1d41-b09b-421316f75d07@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 08:28:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 08:28:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 07:42:09PM +0300, Alexey Budankov wrote:
> 
> The data buffer and accompanying AIO control block are allocated at 
> perf_mmap object and the mapped data buffer size is equal to 
> the kernel one.
> 
> The buffer is then used to preserve profiling data ready for dumping 
> and queue it for asynchronous writing into perf trace thru implemented 
> record__aio_write() function.
> 
> mmap_aio control structure of the size equal to the number of per-cpu 
> kernel buffers is used to keep pointers to enqueued AIO control 
> blocks for monitoring of completed AIO operations.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - converted zalloc() to calloc() for allocation of mmap_aio array,
> - cleared typo and adjusted fallback branch code;
> ---
> tools/perf/builtin-record.c | 18 ++++++++++++++++++
>  tools/perf/util/evlist.c    |  7 +++++++
>  tools/perf/util/evlist.h    |  2 ++
>  tools/perf/util/mmap.c      | 12 ++++++++++++
>  tools/perf/util/mmap.h      |  3 +++
>  5 files changed, 42 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 22ebeb92ac51..a35675e9f3aa 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -53,6 +53,7 @@
>  #include <sys/mman.h>
>  #include <sys/wait.h>
>  #include <linux/time64.h>
> +#include <aio.h>
>  
>  struct switch_output {
>  	bool		 enabled;
> @@ -121,6 +122,23 @@ static int record__write(struct record *rec, void *bf, size_t size)
>  	return 0;
>  }
>  
> +static int record__aio_write(int trace_fd, struct aiocb *cblock,
> +		void *buf, size_t size, off_t off)
> +{

this breaks bisection:

builtin-record.c:125:12: error: ‘record__aio_write’ defined but not used [-Werror=unused-function]
 static int record__aio_write(int trace_fd, struct aiocb *cblock,

jirka
