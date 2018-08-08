Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E6FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189B7216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rugzuwPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189B7216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeHHJ7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:59:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeHHJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=np/8aWXAd73bWdcLxs5j43KSI44vz6tqP9Cu98hgRao=; b=rugzuwPPDFDcLN1G06CPkITvz
        NnFCy8vAqBnEWmQLEWhYNz6rzi6cRUksz7zisTbXGlNyu2g0pT2djVrd4APduXnvjWo/0VMM/pNM2
        6WxhcJy+cFjUlr9ywQ6WiSkbnWbvNkQ6N1fICu/Y5IObu+y/SBposmjl2Ie2Q5GGhTLf7cREMo5z5
        kTJEXDxF+765HROXImUee2LYfBXQZjAG3evD0/ZPWkfeE1pmd3yKydiwgctqZV3tsZDk7ZI/VYKgA
        Sic4ltdsf6QN2V5TBWeOXcY9nEID43StLvbTxbetpjyV5ITqyC+EhGFtdXFsTuPdWLEdYzFN2u2h6
        no0KbOcdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnJ5m-0004Zn-Jq; Wed, 08 Aug 2018 07:41:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FE8620163EC0; Wed,  8 Aug 2018 09:41:11 +0200 (CEST)
Date:   Wed, 8 Aug 2018 09:41:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "Hindman, Gavin" <gavin.hindman@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180808074111.GM2494@hirez.programming.kicks-ass.net>
References: <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7D3A10EF@ORSMSX110.amr.corp.intel.com>
 <413c3b6f-770d-9549-4249-c2407267b63c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413c3b6f-770d-9549-4249-c2407267b63c@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:44:44PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/7/2018 6:28 PM, Luck, Tony wrote:
> > Would it help to call routines to read the "before" values of the counter
> > twice. The first time to preload the cache with anything needed to execute
> > the perf code path.

Indeed, that is the 'common' pattern for this.


> First, reading data using perf_event_read_local() called twice.
> When testing as follows:
> /* create perf events */
> /* disable irq */
> /* disable hw prefetchers */
> /* init local vars */
> /* read before data twice as follows: */
> perf_event_read_local(l2_hit_event, &l2_hits_before, NULL, NULL);
> perf_event_read_local(l2_miss_event, &l2_miss_before, NULL, NULL);
> perf_event_read_local(l2_hit_event, &l2_hits_before, NULL, NULL);
> perf_event_read_local(l2_miss_event, &l2_miss_before, NULL, NULL);
> /* read through pseudo-locked memory */
> perf_event_read_local(l2_hit_event, &l2_hits_after, NULL, NULL);
> perf_event_read_local(l2_miss_event, &l2_miss_after, NULL, NULL);
> /* re enable hw prefetchers */
> /* enable irq */
> /* write data to tracepoint */
> 
> With the above I am not able to obtain accurate data:
> pseudo_lock_mea-354   [002] ....    63.045734: pseudo_lock_l2: hits=4103
> miss=6

So _why_ doesn't this work? As said by Tony, that first call should
prime the caches, so the second and third calls should not generate any
misses.

They might cause extra hits though, but that should be a constant
amount is is also measureable with a no-op loop and can easily be
subtracted.
