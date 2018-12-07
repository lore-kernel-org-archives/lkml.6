Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594EFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9962083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AadpxacW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9962083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGJwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:52:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8ukRcOVsbzvtLgosNvoeedWyAJk8/ZxXTDIRAcZAmWA=; b=AadpxacWpB+my2mUAAXWNJYbt
        h7J4YNSNAr/MbnOI+x9fvzY9/p47wVhN2/jTUFitRJ1jFYfSqxJ1/HUAvcBUvdnnvuOibLzFeGod9
        pDwMtGGrCLM+wQqlz6JP/pM+UacM6xzXrjauohVDHWFYoXubCanJelz9U1TogkC0EMoOkONuTvYTg
        +aOeWmbAQQtN4KqKOzgsb+FgpqRLRrFg+KpyJ4phvQLLMt2ajoNr6+6z+TUc7UGlUTa+g/xRBWUSa
        bkJ/tvU0CFlAePynZce0KJB2iXXd0eYf0Nsm7C/Tr08OJiFdzPUZbYiTMr8qf87isf+8NajcewOgk
        wlG1tV4WA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVCnz-00043D-6X; Fri, 07 Dec 2018 09:52:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F3D62072614D; Fri,  7 Dec 2018 10:52:17 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:52:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 08/17] locking/lockdep: Add support for nestable
 terminal locks
Message-ID: <20181207095217.GA5307@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-9-git-send-email-longman@redhat.com>
 <20181207092252.GF2237@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207092252.GF2237@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 10:22:52AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 19, 2018 at 01:55:17PM -0500, Waiman Long wrote:
> > There are use cases where we want to allow nesting of one terminal lock
> > underneath another terminal-like lock. That new lock type is called
> > nestable terminal lock which can optionally allow the acquisition of
> > no more than one regular (non-nestable) terminal lock underneath it.
> 
> I think I asked for a more coherent changelog on this. The above is
> still self contradictory and doesn't explain why you'd ever want such a
> 'misfeature' :-)

So maybe call the thing penterminal (contraction of penultimate and
terminal) locks and explain why this annotation is safe -- in great
detail.
