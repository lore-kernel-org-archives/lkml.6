Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D862075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D862075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJLRUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:20:39 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:55397 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLRUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:20:39 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 12 Oct 2018 18:49:01 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 12 Oct 2018 18:49:01 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 12 Oct 2018 18:49:01 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v13 3/3]: perf record: extend trace writing to multi AIO
Message-ID: <20181012094901.GA22076@sejong>
References: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
 <6e4badbc-4c6d-b0f9-75fe-8f897d31b9f6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e4badbc-4c6d-b0f9-75fe-8f897d31b9f6@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 11, 2018 at 09:59:19PM +0300, Alexey Budankov wrote:
> 
> Multi AIO trace writing allows caching more kernel data into userspace 
> memory postponing trace writing for the sake of overall profiling data 
> thruput increase. It could be seen as kernel data buffer extension into
> userspace memory.
> 
> With aio option value different from 0, default value is 1, 
> tool has capability to cache more and more data into user space
> along with delegating spill to AIO.
> 
> That allows avoiding suspend at record__aio_sync() between calls of 
> record__mmap_read_evlist() and increase profiling data thruput for 
> the cost of userspace memory.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v13:
> - preserved --aio option name avoiding complication
> Changes in v12:
> - extended --aio option to --aio-cblocks=<n>
> Changes in v10:
> - added description of aio-cblocks option into perf-record.txt
> ---

[SNIP]
> @@ -1882,8 +1913,8 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>  		    "Parse options then exit"),
>  #ifdef HAVE_AIO_SUPPORT
> -	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
> -		     NULL, "Enable asynchronous trace writing mode",
> +	OPT_CALLBACK(0, "aio", &record.opts,
> +		     "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",

One question.  It seems you used a very large N in your test result.
Why did you limit it to 4 here?  Is it something different?  Maybe
you'd better making it a macro constant for future changes..

Otherwise looks good to me.  For the 3 patches

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung



>  		     record__aio_parse),
>  #endif
>  	OPT_END()
> @@ -2078,6 +2109,8 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	if (rec->opts.nr_cblocks > 4)
> +		rec->opts.nr_cblocks = 4;
>  	if (verbose > 0)
>  		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
