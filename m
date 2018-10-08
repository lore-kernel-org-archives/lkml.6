Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230EAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E952E2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E952E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJHSBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbeJHSBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43CB93084258;
        Mon,  8 Oct 2018 10:50:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 919B15DD6B;
        Mon,  8 Oct 2018 10:50:34 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:50:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/3]: perf record: enable asynchronous trace writing
Message-ID: <20181008105033.GB17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b0ae5f-e1b5-4255-11af-46c8ebe8e2be@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Oct 2018 10:50:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:17:11AM +0300, Alexey Budankov wrote:

SNIP

> -
> +#ifdef HAVE_AIO_SUPPORT
> +	lseek(trace_fd, off, SEEK_SET);
> +#endif
>  	/*
>  	 * Mark the round finished in case we wrote
>  	 * at least one event.
> @@ -650,6 +799,9 @@ record__switch_output(struct record *rec, bool at_exit)
>  	/* Same Size:      "2015122520103046"*/
>  	char timestamp[] = "InvalidTimestamp";
>  
> +#ifdef HAVE_AIO_SUPPORT
> +	record__mmap_read_sync(rec);
> +#endif

same, please define the record__mmap_read_sync dummy
so we can skip that #ifdef #endif

>  	record__synthesize(rec, true);
>  	if (target__none(&rec->opts.target))
>  		record__synthesize_workload(rec, true);
> @@ -1157,6 +1309,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +
> +#ifdef HAVE_AIO_SUPPORT
> +	record__mmap_read_sync(rec);
> +#endif

ditto

thanks,
jirka

SNIP
