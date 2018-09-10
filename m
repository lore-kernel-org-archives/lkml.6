Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D20C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4327F2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4327F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeIJOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbeIJOw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36B7C4023ECC;
        Mon, 10 Sep 2018 09:59:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1CDC20229CA;
        Mon, 10 Sep 2018 09:59:09 +0000 (UTC)
Date:   Mon, 10 Sep 2018 11:59:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180910095909.GA15548@krava>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
 <20180910091841.GA4664@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910091841.GA4664@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 09:59:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 09:59:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:18:41AM +0200, Ingo Molnar wrote:
> 
> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
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
> 
> Yay! I saw this frequently on a 120-CPU box (hw is broken now).
> 
> > Data loss metrics is the ratio lost_time/elapsed_time where 
> > lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> > records and elapsed_time is the elapsed application run time 
> > under profiling.
> > 
> > Applying asynchronous trace streaming thru Posix AIO API
> > (http://man7.org/linux/man-pages/man7/aio.7.html) 
> > lowers data loss metrics value providing 2x improvement -
> > lowering 98% loss to almost 0%.
> 
> Hm, instead of AIO why don't we use explicit threads instead? I think Posix AIO will fall back 
> to threads anyway when there's no kernel AIO support (which there probably isn't for perf 
> events).

this patch adds the aoi for writing to the perf.data
file, reading of events is unchanged

> 
> Per-CPU threading the record session would have so many other advantages as well (scalability, 
> etc.).
> 
> Jiri did per-CPU recording patches a couple of months ago, not sure how usable they are at the 
> moment?

it's still usable, I can rebase it and post a branch pointer,
the problem is I haven't been able to find a case with a real
performance benefit yet.. ;-)

perhaps because I haven't tried on server with really big cpu
numbers

jirka
