Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F67C65C26
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74DC2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74DC2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJHSCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJHSCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:02:12 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 366DD750D0;
        Mon,  8 Oct 2018 10:51:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8081B308BDA1;
        Mon,  8 Oct 2018 10:51:03 +0000 (UTC)
Date:   Mon, 8 Oct 2018 12:51:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
Message-ID: <20181008105102.GE17270@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 08 Oct 2018 10:51:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:

SNIP

>  static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index e603314dc792..1b63b6cc7cf9 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -6,6 +6,9 @@
>  #include <linux/types.h>
>  #include <asm/barrier.h>
>  #include <stdbool.h>
> +#ifdef HAVE_AIO_SUPPORT
> +#include <aio.h>
> +#endif
>  #include "auxtrace.h"
>  #include "event.h"
>  
> @@ -26,6 +29,11 @@ struct perf_mmap {
>  	bool		 overwrite;
>  	struct auxtrace_mmap auxtrace_mmap;
>  	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
> +#ifdef HAVE_AIO_SUPPORT
> +	void 		 *data;
> +	struct aiocb	 cblock;
> +	int		 nr_cblocks;
> +#endif

could you please separate those in struct, maybe anonymous like:

	...
	struct {
		void 		 *data;
		struct aiocb	 cblock;
		int		 nr_cblocks;
	} aio;
	...


>  };
>  
>  /*
> @@ -59,6 +67,9 @@ enum bkw_mmap_state {
>  struct mmap_params {
>  	int			    prot, mask;
>  	struct auxtrace_mmap_params auxtrace_mp;
> +#ifdef HAVE_AIO_SUPPORT
> +	int			    nr_cblocks;
> +#endif

I dont think we need the ifdef here.. IMO one extra int is not
worth of the ifdef endif confusion

jirka
