Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9845720866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+2mLs3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9845720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeKLKRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:17:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKLKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=85EBLwIVeWcFyY6PGS8sB0fy0F8iSWH2HyhV9+Kkrsw=; b=j+2mLs3p2r/7aoQxrIY+A4XUn
        RfTSESJZus5+BQYmypASeWb6kZ2Z/s1OBXRmvnnI5BMvxTPyNQmVWLdRzCcmSCYPl0wsiwI1OpuNm
        4Lk07DZGs+OsOk5fJobsag9kB2zwn4gO0F36s4V+3Ih5NrJp4q9mJf/rApFJInqNA8Vk/soddvbZU
        I4SE4y7FpYnVkqeCkAlyIMq2eo/cD2HTfC5weO+x7xENO7VrKqPnDpwRRnZF4D1E9xjo92xn/n1yE
        wKhdc52S3vPMLlW0j30RtA32LsZUZeHTkbGiGkZ9toi4q4JX+F5ESCjUJ+sC0Uyo4ubmvZPJZhp1M
        hl2ecuZMQ==;
Received: from [64.114.255.97] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM03r-0003JQ-K5; Mon, 12 Nov 2018 00:26:39 +0000
Received: by worktop (Postfix, from userid 1000)
        id DD4F06E061A; Mon, 12 Nov 2018 01:26:37 +0100 (CET)
Date:   Mon, 12 Nov 2018 01:26:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: Init early callchain for bts event
Message-ID: <20181112002637.GD3056@worktop>
References: <20181111181650.4839-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111181650.4839-1-jolsa@kernel.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 07:16:50PM +0100, Jiri Olsa wrote:
> Vince reported crash in bts flush code when touching the
> callchain data, which was supposed to be initialized
> as an 'early' callchain data.
> 
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
>   ...

> It was triggered by fuzzer by can be easilt reproduced by:
>   # perf record -e cpu/branch-instructions/p -g -c 1
> 
> The problem is that bts drain code does not initialize sample's
> early callchain data and calls perf_prepare_sample with NULL
> sample->callchain, even if it's expected to exist via
> __PERF_SAMPLE_CALLCHAIN_EARLY sample type bit.

Not sure that is the actual problem, nor that this:

> @@ -612,6 +614,9 @@ int intel_pmu_drain_bts_buffer(void)
>  
>  	perf_sample_data_init(&data, 0, event->hw.last_period);
>  
> +	if (event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY)
> +		data.callchain = &__empty_callchain;
> +
>  	/*
>  	 * BTS leaks kernel addresses in branches across the cpl boundary,
>  	 * such as traps or system calls, so unless the user is asking for

is the right fix.

If you look at commit:

  6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")

Then the right fix would be to do perf_callchain() from the BTS drain
code -- if '/p'.

Because prior to that commit, we would do a perf_callchain() in
intel_pmu_drain_bts_buffer()'s call to perf_prepare_sample(), which
would do an actual stack unwind for a branch entry.

With your patch, we get an empty stack for every entry.

Which is a change in behaviour...

Now arguably, this is really stupid behaviour. Who in his right mind
wants callchain output on BTS entries. And even if they do, BTS +
precise_ip is nonsensical.

So in my mind disallowing precise_ip on BTS would be the simplest fix.

Hmm?
