Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4731CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0B208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F0B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeH0M3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:29:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeH0M3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:29:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7E004023461;
        Mon, 27 Aug 2018 08:43:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 46167A9E52;
        Mon, 27 Aug 2018 08:43:34 +0000 (UTC)
Date:   Mon, 27 Aug 2018 10:43:33 +0200
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
Subject: Re: [PATCH v2 2/2]: perf record: enable asynchronous trace writing
Message-ID: <20180827084333.GG24695@krava>
References: <e92805d0-3338-2ce5-5e88-369d406fe0a7@linux.intel.com>
 <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54cc11d7-3ef2-c856-052e-6e2c309ff743@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 08:43:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 27 Aug 2018 08:43:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 07:47:01PM +0300, Alexey Budankov wrote:

SNIP

>  
>  static volatile int done;
> @@ -528,13 +530,85 @@ static struct perf_event_header finished_round_event = {
>  	.type = PERF_RECORD_FINISHED_ROUND,
>  };
>  
> +static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
> +		int cblocks_size, struct record *rec)
> +{
> +	size_t rem;
> +	ssize_t size;
> +	off_t rem_off;
> +	int i, aio_ret, aio_errno, do_suspend;
> +	struct perf_mmap *md;
> +	struct timespec timeout0 = { 0, 0 };
> +	struct timespec timeoutS = { 0, 1000 * 1000  * 1 };
> +
> +	if (!cblocks_size)
> +		return 0;
> +
> +	do {
> +		do_suspend = 0;
> +		nanosleep(&timeoutS, NULL);
> +		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
> +			if (errno == EAGAIN || errno == EINTR) {
> +				do_suspend = 1;
> +				continue;
> +			} else {
> +				pr_err("failed to sync perf data, error: %m\n");
> +				break;
> +			}
> +		}
> +		for (i = 0; i < cblocks_size; i++) {

it looks like we could set up the async write to receive the signal
with the user pointer (sigev_value.sival_ptr), which would allow us
to get the finished descriptor right away and we wouldn't need
to iterate all of them and checking on them

jirka
> +			if (cblocks[i] == NULL) {
> +				continue;
> +			}
> +			aio_errno = aio_error(cblocks[i]);
> +			if (aio_errno == EINPROGRESS) {
> +				do_suspend = 1;
> +				continue;
> +			}

SNIP
