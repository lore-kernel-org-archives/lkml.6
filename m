Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D3EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D103020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqDhcoWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D103020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeIJSxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbeIJSxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:53:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79EF420855;
        Mon, 10 Sep 2018 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536587941;
        bh=3W/9bGsWy1MaVWKIQHLSrj8H4rbwJGww6AS+6QzyCZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqDhcoWaHrHLhtJSMBkAdg1SCPToj8goFzYPKvs2WPfJEcQr+JtM1cBEyOI0We5T8
         52aeHSIZ8q1izjLelMQHVKHjZ1y0r/yK5tkfzSiHo0z7DPyEG9ppxF96WTui7uISkv
         Rf9FNXFStuKr+1/6XbcuLJGrOqw4uIImUOwv2MjQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5CB7E141FFC; Mon, 10 Sep 2018 10:58:58 -0300 (-03)
Date:   Mon, 10 Sep 2018 10:58:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180910135858.GE5147@kernel.org>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
 <2c5d4b01-0eb8-f97e-6a70-44be7961d7f8@linux.intel.com>
 <20180910120643.GA4217@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910120643.GA4217@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 10, 2018 at 02:06:43PM +0200, Ingo Molnar escreveu:
> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> > On 10.09.2018 12:18, Ingo Molnar wrote:
> > > * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> > >> Currently in record mode the tool implements trace writing serially. 
> > >> The algorithm loops over mapped per-cpu data buffers and stores 
> > >> ready data chunks into a trace file using write() system call.
> > >>
> > >> At some circumstances the kernel may lack free space in a buffer 
> > >> because the other buffer's half is not yet written to disk due to 
> > >> some other buffer's data writing by the tool at the moment.
> > >>
> > >> Thus serial trace writing implementation may cause the kernel 
> > >> to loose profiling data and that is what observed when profiling 
> > >> highly parallel CPU bound workloads on machines with big number 
> > >> of cores.
> > > 
> > > Yay! I saw this frequently on a 120-CPU box (hw is broken now).
> > > 
> > >> Data loss metrics is the ratio lost_time/elapsed_time where 
> > >> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> > >> records and elapsed_time is the elapsed application run time 
> > >> under profiling.
> > >>
> > >> Applying asynchronous trace streaming thru Posix AIO API
> > >> (http://man7.org/linux/man-pages/man7/aio.7.html) 
> > >> lowers data loss metrics value providing 2x improvement -
> > >> lowering 98% loss to almost 0%.
> > > 
> > > Hm, instead of AIO why don't we use explicit threads instead? I think Posix AIO will fall back 
> > > to threads anyway when there's no kernel AIO support (which there probably isn't for perf 
> > > events).
> > 
> > Explicit threading is surely an option but having more threads 
> > in the tool that stream performance data is a considerable 
> > design complication.
> > 
> > Luckily, glibc AIO implementation is already based on pthreads, 
> > but having a writing thread for every distinct fd only.
> 
> My argument is, we don't want to rely on glibc's choices here. They might
> use a different threading design in the future, or it might differ between
> libc versions.
> 
> The basic flow of tracing/profiling data is something we should control explicitly,
> via explicit threading.
> 
> BTW., the usecase I was primarily concentrating on was a simpler one: 'perf record -a', not 
> inherited workflow tracing. For system-wide profiling the ideal tracing setup is clean per-CPU 
> separation, i.e. per CPU event fds, per CPU threads that read and then write into separate 
> per-CPU files.

My main request here is that we think about the 'perf top' and 'perf
trace' workflows as well when working on this, i.e. that we don't take
for granted that we'll have the perf.data files to work with.

I.e. N threads, that periodically use that FINISHED_ROUND event to order
events and go on consuming. All of the objects already have refcounts
and locking to allow for things like decaying of samples to take care of
trowing away no longer needed objects (struct map, thread, dso, symbol
tables, etc) to trim memory usage.

- Arnaldo
