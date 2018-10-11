Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1228BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79B320841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79B320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeJKVnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:43:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99177A5D8C;
        Thu, 11 Oct 2018 14:15:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id E6D739408D;
        Thu, 11 Oct 2018 14:15:43 +0000 (UTC)
Date:   Thu, 11 Oct 2018 16:15:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181011141543.GF29634@krava>
References: <e045b4aa-bff1-4e40-4cdf-4504003ecff5@linux.intel.com>
 <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50fed9ff-adc4-d9d6-36bc-b6b27bf58c17@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 11 Oct 2018 14:15:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:58:53AM +0300, Alexey Budankov wrote:
> 
> Trace file offset is read once before mmaps iterating loop and written
> back after all performance data enqueued for aio writing. Trace file offset 
> is incremented linearly after every successful aio write operation. 
> 
> record__aio_sync() blocks till completion of started AIO operation 
> and then proceeds.
> 
> record__mmap_read_sync() implements a barrier for all incomplete
> aio write requests.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  Changes in v12:
>  - implemented record__aio_get/set_pos(), record__aio_enabled()
>  - implemented simple --aio option
>  Changes in v11:
>  - replacing the both lseek() syscalls in every loop iteration by the only 
>    two syscalls just before and after the loop at record__mmap_read_evlist() 
>    and advancing *in-flight* off file pos value at perf_mmap__aio_push()
>  Changes in v10:
>  - avoided lseek() setting file pos back in case of record__aio_write() failure
>  - compacted code selecting between serial and AIO streaming
>  - optimized call places of record__mmap_read_sync()
>  Changes in v9:
>  - enable AIO streaming only when --aio-cblocks option is specified explicitly
>  Changes in v8:
>  - split AIO completion check into separate record__aio_complete()
>  Changes in v6:
>  - handled errno == EAGAIN case from aio_write();
>  Changes in v5:
>  - data loss metrics decreased from 25% to 2x in trialed configuration;
>  - avoided nanosleep() prior calling aio_suspend();
>  - switched to per cpu multi record__aio_sync() aio
>  - record_mmap_read_sync() now does global barrier just before 
>    switching trace file or collection stop;
>  - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
>  Changes in v4:
>  - converted void *bf to struct perf_mmap *md in signatures
>  - written comment in perf_mmap__push() just before perf_mmap__get();
>  - written comment in record__mmap_read_sync() on possible restarting 
>    of aio_write() operation and releasing perf_mmap object after all;
>  - added perf_mmap__put() for the cases of failed aio_write();
>  Changes in v3:
>  - written comments about nanosleep(0.5ms) call prior aio_suspend()
>    to cope with intrusiveness of its implementation in glibc;
>  - written comments about rationale behind coping profiling data 
>    into mmap->data buffer;
> ---
>  tools/perf/Documentation/perf-record.txt |   5 +
>  tools/perf/builtin-record.c              | 220 ++++++++++++++++++++++++++++++-
>  tools/perf/perf.h                        |   1 +
>  tools/perf/util/evlist.c                 |   6 +-
>  tools/perf/util/evlist.h                 |   2 +-
>  tools/perf/util/mmap.c                   |  86 +++++++++++-
>  tools/perf/util/mmap.h                   |   5 +
>  7 files changed, 316 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 246dee081efd..5cedb3e75434 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -435,6 +435,11 @@ Specify vmlinux path which has debuginfo.
>  --buildid-all::
>  Record build-id of all DSOs regardless whether it's actually hit or not.
>  
> +--aio::
> +Enable asynchronous (Posix AIO) trace writing mode. 

nit, there's an extra whitespace at the end of above line,
making the 'git am' to not apply your patch

thanks,
jirka
