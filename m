Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E375320880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBUJrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:47:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfBUJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:47:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3E0281DF4;
        Thu, 21 Feb 2019 09:47:51 +0000 (UTC)
Received: from krava (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 46C4960851;
        Thu, 21 Feb 2019 09:47:50 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:47:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
Message-ID: <20190221094749.GC10990@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
 <20190212130828.GD775@krava>
 <39a1cf8d-2496-72f6-c3a4-a4abb8008689@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a1cf8d-2496-72f6-c3a4-a4abb8008689@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 21 Feb 2019 09:47:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:15:13PM +0300, Alexey Budankov wrote:
> 
> On 12.02.2019 16:08, Jiri Olsa wrote:
> > On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >> -	if (rec->opts.nr_cblocks > nr_cblocks_max)
> >> -		rec->opts.nr_cblocks = nr_cblocks_max;
> >> -	if (verbose > 0)
> >> -		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> >> +	if (rec->opts.comp_level > 22)
> >> +		rec->opts.comp_level = 0;
> >> +	if (record__comp_enabled(rec) && !rec->opts.nr_cblocks) {
> >> +		 /*
> >> +		  * Allocate aio.data[0] buffer for compression.
> >> +		  */
> >> +		rec->opts.nr_cblocks = -1;
> >> +	}
> > 
> > I assume you're using aio.data[0] as a buffer for non-aio case
> > as compression buffer.. if that's the case, please dont do that
> > and use separate buffer for that
> 
> Do you want it to be one more field in the mmap struct or 
> aio related fields still could be reworked?

I dont like it to use aio buffers if it's generic feature,
so please add new pointer for the needed buffer

jirka
