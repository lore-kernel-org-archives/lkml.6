Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C33C2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C33C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeH1Mw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeH1Mw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 964C78D751;
        Tue, 28 Aug 2018 09:01:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 52B6DA9EB9;
        Tue, 28 Aug 2018 09:01:46 +0000 (UTC)
Date:   Tue, 28 Aug 2018 11:01:45 +0200
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
Message-ID: <20180828090145.GI23727@krava>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
 <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f83f9cd-263e-b073-487f-4c7570105a7d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 28 Aug 2018 09:01:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 28 Aug 2018 09:01:47 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:16:55PM +0300, Alexey Budankov wrote:

SNIP

> +static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
> +		int cblocks_size, struct record *rec)
> +{
> +	size_t rem;
> +	ssize_t size;
> +	off_t rem_off;
> +	int i, aio_ret, aio_errno, do_suspend;
> +	struct perf_mmap *md;
> +	struct timespec timeout0 = { 0, 0 };
> +	struct timespec timeoutS = { 0, 1000 * 500  * 1 }; // 0.5ms
> +
> +	if (!cblocks_size)
> +		return 0;
> +
> +	do {
> +		do_suspend = 0;
> +		/* aio_suspend() implementation inside glibc (as of v2.27) is
> +		 * intrusive and not just blocks waiting io requests completion
> +		 * but polls requests queue inducing context switches in perf
> +		 * tool process. When profiling in system wide mode with tracing
> +		 * context switches the trace may be polluted by context switches
> +		 * from the perf process and the trace size becomes about 3-5
> +		 * times bigger than that of when writing the trace serially.
> +		 * To limit the volume of context switches from perf tool
> +		 * process nanosleep() call below is added prior aio_suspend()
> +		 * calling till every half of the kernel timer tick which is
> +		 * usually 1ms (depends on CONFIG_HZ value).

nice, any idea this is intentional for some reason?

was there some impact on the overall performance or
this is purely for the sanity of the trace size?

thanks,
jirka
