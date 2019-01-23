Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E40218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqA9MppD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfAWUks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:40:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e1OdoA01J6AO7IA0mqGfYg8tGIE5GhQmlisIo1s6rU4=; b=lqA9MppDhmqIZ0R5yVG8Pg7vU
        QGCMuKYQERnZq0Naimnj7JavtkmAi0+Wg8AnSKHECB3T8aRCcqnmvqXpW2rg5x9xC/buCMXT8Tk9i
        O7yRdnBUCh8uc77zoFRSzusM0sy4eIC24ZtbYTVOan0haNFxn08/uQn94HfkpPtoMsJJSZGlKgWU2
        XS76Zu7ni2g6waADw8mp6Ns5r34D7ZxUMz9AXjz1J5ouyh4ww3imH4jyRLQWINuB6z45QG36jt/rY
        wdp5UpcCOVnIBC2RpyDTVQPkZkjUgmE/dosXjZ6EyMZFdNGZccTpKBB2dnawmY0phxjboXPCrW7Sv
        6zZ5Y0EPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmPKB-0007cY-Mj; Wed, 23 Jan 2019 20:40:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E07A20F51B05; Wed, 23 Jan 2019 21:40:38 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:40:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>
Subject: Re: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting
 levels
Message-ID: <20190123204038.GL13777@hirez.programming.kicks-ass.net>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-2-git-send-email-longman@redhat.com>
 <20190123093424.GE15019@brain-police>
 <63131030-bd24-34bf-10dc-b5e7c7c177be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63131030-bd24-34bf-10dc-b5e7c7c177be@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 03:11:19PM -0500, Waiman Long wrote:
> On 01/23/2019 04:34 AM, Will Deacon wrote:
> > On Tue, Jan 22, 2019 at 10:49:08PM -0500, Waiman Long wrote:

> >> @@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >>  	idx = node->count++;
> >>  	tail = encode_tail(smp_processor_id(), idx);

> >> +	if (unlikely(idx >= MAX_NODES)) {
> >> +		while (!queued_spin_trylock(lock))
> >> +			cpu_relax();
> >> +		goto release;
> >> +	}

> So the additional code checks the idx value and branch to the end of the
> function when the condition is true. There isn't too much overhead here.

So something horrible we could do (and I'm not at all advocating we do
this), is invert node->count. That is, start at 3 and decrement and
detect sign flips.

That avoids the additional compare. It would require we change the
structure layout though, otherwise we keep hitting that second line by
default, which would suck.
