Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1329F2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZaZTd/KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfBMNIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:08:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42580 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbfBMNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kytjsrx2GRQuRPBMQ0pc+fJ9iwpgkzWDFUtjnIK+60U=; b=ZaZTd/KFBdQ0lgC17Tmq5H76H
        4DyOdzEFa607VkrUSbiMKa97vcta9BzV1+0P36PuDxJRaCqD+vUSRZq2hYS9jec/rO4ALDdgV2SGB
        Bx169q4MhNIsyOJfqhYgXeveYoxQl2CsHO+FMI0UvOqMfeD+gSK9qdaXBTNmwuBkkH2MnBJNUyH4y
        2EdCogpLifyfpBF3JyGLwks0uie1+77Epr0CttK9ClwiVjF3/epFo55Qs6NnWVrVhlVdS5Z8QYByW
        Lzf/hGz3osbtjjs7KJXiFeNHUyaZFSnm4rQZpbRWXyv9R1Ph+C1jy47/OdBcYWK5ECHE0cMVB8xMf
        vwkb7WVuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtuGc-0007nA-1c; Wed, 13 Feb 2019 13:07:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FB5F22BBEBE5; Wed, 13 Feb 2019 14:07:55 +0100 (CET)
Date:   Wed, 13 Feb 2019 14:07:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mgorman@techsingularity.net
Subject: Re: [PATCH v0 1/2] perf: Add an option to ask for high order
 allocations for AUX buffers
Message-ID: <20190213130755.GQ32494@hirez.programming.kicks-ass.net>
References: <20190213114716.63972-1-alexander.shishkin@linux.intel.com>
 <20190213114716.63972-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213114716.63972-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:47:15PM +0200, Alexander Shishkin wrote:
> Currently, the AUX buffer allocator will use high-order allocations
> for PMUs that don't support hardware scatter-gather chaining to ensure
> large contiguous blocks of pages, and always use an array of single
> pages otherwise.
> 
> There is, however, a tangible performance benefit in using larger chunks
> of contiguous memory even in the latter case, that comes from not having
> to fetch the next page's address at every page boundary. In particular,
> a task running under Intel PT on an Atom CPU shows 1.5%-2% less runtime
> penalty with a single multi-page output region in snapshot mode (no PMI)
> than with multiple single-page output regions, from ~6% down to ~4%. For
> the snapshot mode it does make a difference as it is intended to run over
> long periods of time.
> 
> Following the above justification, add an attribute bit to ask for a
> high-order AUX allocation. To prevent an unprivileged user from using up
> the higher orders of the page allocator, require CAP_SYS_ADMIN for this
> option.

Why do we need a knob for that? Last time I checked unpriv users could
fragment the page allocator just fine. What is there to protect?

Also, since we return all pages upon buffer free, the page allocator
should in fact re-construct the high order stuff.

So a buffer alloc + free, using high order pages, should be an effective
nop on high order availability.

Unlike spraying dentries or whatever works these days around the
machine.
