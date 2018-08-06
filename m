Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003B521A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TgtJJo16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003B521A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbeHGAXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:23:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40190 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHGAXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=in9q7ioRCIVI65NFTp7CjJ6ZKqyEuNvqc6fGZlLiLH4=; b=TgtJJo16G16RKiD7kNUQ6xHtO
        ULJzINHxdIsn8wbiYW1qyPiAy/VGQdRQHqyXhDW2FzmB2isjeq3D1Bc64fHN1D9h847MEHN6+6uwi
        SUbDvjqgC4c2B4Sq+Y+ixuLq21s9PILn8cWMMhdYcb9Dr0ZCTsOajS15NtcdVVfT9sa93RiyOUIxE
        WdLGhkoFtDqIFcaR9xoopCF0CW0W+HMgYigl3JpcpQSczjIgvS9kquRUMbN2y2x1Am7rYw/QWlYJX
        wvBYklx8F4SeahmhKnCurcpWMyU0RnB5PoUlF8bPbjYpid/ADCxsUqJg0zH+fmsl0FkNl/boLKe4Q
        eqdv/5Eow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmnjn-0004N1-67; Mon, 06 Aug 2018 22:12:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC2C82058A22B; Tue,  7 Aug 2018 00:12:25 +0200 (CEST)
Date:   Tue, 7 Aug 2018 00:12:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180806221225.GO2458@hirez.programming.kicks-ass.net>
References: <653e874f-5e77-a9b5-996a-ed9daa3c6d43@intel.com>
 <20180802195410.GR2494@hirez.programming.kicks-ass.net>
 <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c011e1-113d-c38f-c318-defbad085843@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 12:50:50PM -0700, Reinette Chatre wrote:
> In my previous email I provided the details of the Cache Pseudo-Locking
> feature implemented on top of resctrl. Please let me know if you would
> like any more details about that. I can send you more materials.

I've no yet had time to read..

> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:748
> 
> I thus continued to use the API with interrupts enabled did the following:
> 
> Two new event attributes:
> static struct perf_event_attr l2_miss_attr = {
>         .type           = PERF_TYPE_RAW,
>         .config         = (0x10ULL << 8) | 0xd1,

Please use something like:

		X86_CONFIG(.event=0xd1, .umask=0x10),

that's ever so much more readable.

>         .size           = sizeof(struct perf_event_attr),
>         .pinned         = 1,
>         .disabled       = 1,
>         .exclude_user   = 1
> };
> 
> static struct perf_event_attr l2_hit_attr = {
>         .type           = PERF_TYPE_RAW,
>         .config         = (0x2ULL << 8) | 0xd1,
>         .size           = sizeof(struct perf_event_attr),
>         .pinned         = 1,
>         .disabled       = 1,
>         .exclude_user   = 1
> };
> 
> Create the two new events using these attributes:
> l2_miss_event = perf_event_create_kernel_counter(&l2_miss_attr, cpu,
> NULL, NULL, NULL);
> l2_hit_event = perf_event_create_kernel_counter(&l2_hit_attr, cpu, NULL,
> NULL, NULL);
> 
> Take measurements:
> perf_event_enable(l2_miss_event);
> perf_event_enable(l2_hit_event);
> local_irq_disable();
> /* Disable hardware prefetchers */
> /* Loop through pseudo-locked memory */
> /* Enable hardware prefetchers */
> local_irq_enable();
> perf_event_disable(l2_hit_event);
> perf_event_disable(l2_miss_event);
> 
> Read results:
> l2_hits = perf_event_read_value(l2_hit_event, &enabled, &running);
> l2_miss = perf_event_read_value(l2_miss_event, &enabled, &running);
> /* Make results available in tracepoints */

switch to .disabled=0 and try this for measurement:

	local_irq_disable();
	perf_event_read_local(l2_miss_event, &miss_val1, NULL, NULL);
	perf_event_read_local(l2_hit_event, &hit_val1, NULL, NULL);
	/* do your thing */
	perf_event_read_local(l2_miss_event, &miss_val2, NULL, NULL);
	perf_event_read_local(l2_hit_event, &hit_val2, NULL, NULL);
	local_irq_enable();

You're running this on the CPU you created the event for, right?

> With the above implementation and a 256KB pseudo-locked memory region I
> obtain the following results:
> pseudo_lock_mea-755   [002] ....   396.946953: pseudo_lock_l2: hits=4140

> The above results are not accurate since it does not reflect the success
> of the pseudo-locked region. Expected results are as we can currently
> obtain (copying results from previous email):
> pseudo_lock_mea-26090 [002] .... 61838.488027: pseudo_lock_l2: hits=4096

Still fairly close.. only like 44 extra hits or 1% error.
