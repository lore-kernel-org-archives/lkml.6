Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B33ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E10220673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOd6CZZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E10220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGRRKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:10:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeGRRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hcOhW0AxgeVW8KlsPYSm+C8c2IhtRyda4fOPsxxcs8s=; b=gOd6CZZvAM+wz80XpZd9n8PUQ
        e52fnLMGVEXlYwPUJuYsTQpdOzYQQi6OfIay0CdCp7BBwdFOpSreNtnpPC+cnJTE5EybJ6GhJAfdq
        hFcBjLxBu3UWJgEZ6cEpfh+d6b8RnWdbaxxjiB89rkWBBs7tNuqEJD+8PNuAkTGKHyfj/U7zNhsWp
        SrkrpYnn3soo8hSZQy9djv6v9oHH5oWb5taSFdY81soZggrEwecgvDUN7/g3TlkedN3tZTKwGgaA2
        7J6YLrJV3eCc9EbotCiVC7eAUfNtGgJRZgKDYYSBHJWdqLHpYpOX6rx9kV9GBzewJ86+LQRysCHG+
        TLvY5HohA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffpMC-0000SS-Oz; Wed, 18 Jul 2018 16:31:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E48E20275F37; Wed, 18 Jul 2018 18:31:15 +0200 (CEST)
Date:   Wed, 18 Jul 2018 18:31:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180718163115.GV2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718124627.GD2476@hirez.programming.kicks-ass.net>
 <20180718135633.GA5161@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718135633.GA5161@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:56:33AM -0400, Johannes Weiner wrote:
> On Wed, Jul 18, 2018 at 02:46:27PM +0200, Peter Zijlstra wrote:

> > I'm confused by this whole MEMSTALL thing... I thought the idea was to
> > account the time we were _blocked_ because of memstall, but you seem to
> > count the time we're _running_ with PF_MEMSTALL.
> 
> Under heavy memory pressure, a lot of active CPU time is spent
> scanning and rotating through the LRU lists, which we do want to
> capture in the pressure metric. What we really want to know is the
> time in which CPU potential goes to waste due to a lack of
> resources. That's the CPU going idle due to a memstall, but it's also
> a CPU doing *work* which only occurs due to a lack of memory. We want
> to know about both to judge how productive system and workload are.

Then maybe memstall (esp. the 'stall' part of it) is a bit of a
misnomer.

> > And esp. the wait_on_page_bit_common caller seems performance sensitive,
> > and the above function is quite expensive.
> 
> Right, but we don't call it on every invocation, only when waiting for
> the IO to read back a page that was recently deactivated and evicted:
> 
> 	if (bit_nr == PG_locked &&
> 	    !PageUptodate(page) && PageWorkingset(page)) {
> 		if (!PageSwapBacked(page))
> 			delayacct_thrashing_start();
> 		psi_memstall_enter(&pflags);
> 		thrashing = true;
> 	}
> 
> That means the page cache workingset/file active list is thrashing, in
> which case the IO itself is our biggest concern, not necessarily a few
> additional cycles before going to sleep to wait on its completion.

Ah, right. PageWorkingset() is only true if we (recently) evicted that
page before, right?
