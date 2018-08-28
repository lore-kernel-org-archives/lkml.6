Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED182089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED182089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeH1MlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:41:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbeH1MlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:41:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D728A818F04B;
        Tue, 28 Aug 2018 08:50:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8AEDFA9EB1;
        Tue, 28 Aug 2018 08:50:23 +0000 (UTC)
Date:   Tue, 28 Aug 2018 10:50:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180828085022.GE23727@krava>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 08:50:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 08:50:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:
> 
> Trace file offset are linearly calculated by perf_mmap__push() code 
> for the next possible write operation, but file position is updated by 
> the kernel only in the second lseek() syscall after the loop. 
> The first lseek() syscall reads that file position for 
> the next loop iterations.
> 
> record__mmap_read_sync implements sort of a barrier between spilling 
> ready profiling data to disk.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v3:
> - written comments about nanosleep(0.5ms) call prior aio_suspend()
>   to cope with intrusiveness of its implementation in glibc;
> - written comments about rationale behind coping profiling data 
>   into mmap->data buffer;
> ---
>  tools/perf/builtin-record.c | 125 +++++++++++++++++++++++++++++++++++++++++---
>  tools/perf/util/mmap.c      |  36 ++++++++-----
>  tools/perf/util/mmap.h      |   2 +-
>  3 files changed, 143 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 22ebeb92ac51..4ac61399a09a 100644
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
> +	cblock->aio_fildes = trace_fd;
> +	cblock->aio_buf    = buf;
> +	cblock->aio_nbytes = size;
> +	cblock->aio_offset = off;
> +	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
> +
> +	if (aio_write(cblock) == -1) {
> +		pr_err("failed to queue perf data, error: %m\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int process_synthesized_event(struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample __maybe_unused,
> @@ -130,12 +148,14 @@ static int process_synthesized_event(struct perf_tool *tool,
>  	return record__write(rec, event, event->header.size);
>  }
>  
> -static int record__pushfn(void *to, void *bf, size_t size)
> +static int record__pushfn(void *to, void *bf, size_t size, off_t off)
>  {
>  	struct record *rec = to;
> +	struct perf_mmap *map = bf;

the argument needs to change for record__pushfn,
now with your changes, it's no longer 'void *bf',
but 'struct perf_mmap *map'

also I'm little confused why we have '*to' and cast
it back to 'struct record', but so be it ;-)

thanks,
jirka
