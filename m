Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD85B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNlmEhn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD85B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeGRNAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:00:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeGRNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oIlfSxllIsnZgpPEiTP2UCq6MGTBd8nSx1RVDxGe7I0=; b=VNlmEhn3rX0MXygcQOY292LE3
        G0/fljkNKrZfyiuTniA9lqRLm0+D+g75T7VB583UBMeZOEOdtfGhxbnQfFtbkXvINcq7nvRDoQEYW
        yi9jpa6SVBPa70dR/v18sOr0wKpvQM7yGODTN6Yvbge7G4aCrLiiWh8ujVSzA7Xl/9Wtn1vKVzig2
        hUPe5cc1LbAgfc67z8LdsbY17gfowHwO4pA+M64KaypSyDzt3fRjeUv8VJn/UEcJvUrP9W98wofMG
        zToMwXNpDNDPMtqCM/m+tHPFSYTdEeOA0pfVP6F9yQBBPNQD420zNTsXWWuOQzJHomU/9EgB4nEoW
        uEExyTdOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fflT7-0004X1-D6; Wed, 18 Jul 2018 12:22:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDDED20275F37; Wed, 18 Jul 2018 14:22:07 +0200 (CEST)
Date:   Wed, 18 Jul 2018 14:22:07 +0200
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
Message-ID: <20180718122207.GX2512@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718120318.GC2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > +	for (to = 0; (bo = ffs(set)); to += bo, set >>= bo)
> > +		tasks[to + (bo - 1)]++;
> 
> You want to benchmark this, but since it's only 3 consecutive bits, it
> might actually be faster to not use ffs() and simply test all 3 bits:
> 
> 	for (to = set, bo = 0; to; to &= ~(1 << bo), bo++)

		if (to & (1 << bo))

> 		tasks[bo]++;


