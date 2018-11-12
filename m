Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F90FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C240216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C240216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeKLSYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50369 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbeKLSYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:24:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98CBB307CDDA;
        Mon, 12 Nov 2018 08:32:16 +0000 (UTC)
Received: from krava (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 309FD5D736;
        Mon, 12 Nov 2018 08:32:13 +0000 (UTC)
Date:   Mon, 12 Nov 2018 09:32:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: Init early callchain for bts event
Message-ID: <20181112083213.GD30042@krava>
References: <20181111181650.4839-1-jolsa@kernel.org>
 <20181112002637.GD3056@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112002637.GD3056@worktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 12 Nov 2018 08:32:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:26:37AM +0100, Peter Zijlstra wrote:
> On Sun, Nov 11, 2018 at 07:16:50PM +0100, Jiri Olsa wrote:
> > Vince reported crash in bts flush code when touching the
> > callchain data, which was supposed to be initialized
> > as an 'early' callchain data.
> > 
> >   BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> >   ...
> 
> > It was triggered by fuzzer by can be easilt reproduced by:
> >   # perf record -e cpu/branch-instructions/p -g -c 1
> > 
> > The problem is that bts drain code does not initialize sample's
> > early callchain data and calls perf_prepare_sample with NULL
> > sample->callchain, even if it's expected to exist via
> > __PERF_SAMPLE_CALLCHAIN_EARLY sample type bit.
> 
> Not sure that is the actual problem, nor that this:
> 
> > @@ -612,6 +614,9 @@ int intel_pmu_drain_bts_buffer(void)
> >  
> >  	perf_sample_data_init(&data, 0, event->hw.last_period);
> >  
> > +	if (event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY)
> > +		data.callchain = &__empty_callchain;
> > +
> >  	/*
> >  	 * BTS leaks kernel addresses in branches across the cpl boundary,
> >  	 * such as traps or system calls, so unless the user is asking for
> 
> is the right fix.
> 
> If you look at commit:
> 
>   6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
> 
> Then the right fix would be to do perf_callchain() from the BTS drain
> code -- if '/p'.
> 
> Because prior to that commit, we would do a perf_callchain() in
> intel_pmu_drain_bts_buffer()'s call to perf_prepare_sample(), which
> would do an actual stack unwind for a branch entry.
> 
> With your patch, we get an empty stack for every entry.
> 
> Which is a change in behaviour...

I thought there's no callchain anyway, because we use zero-ed regs

> 
> Now arguably, this is really stupid behaviour. Who in his right mind
> wants callchain output on BTS entries. And even if they do, BTS +
> precise_ip is nonsensical.
> 
> So in my mind disallowing precise_ip on BTS would be the simplest fix.
> 
> Hmm?

sounds ok, will post it

thanks,
jirka
