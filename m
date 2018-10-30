Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4EC20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOAFQ7tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4EC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJaAYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:24:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJaAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/OhDhr9UWTgAFTgOUNr7LC3ATcdCbgySIpZFR4NPIck=; b=kOAFQ7tuVhV6HTW8uK/1w1fgM
        M9hKtNp+urha1QeLfcS/6pkYvaW06au4Z7I84mCNlOGqhRIYfXQnSlmSRiCG6gg7Xu5nk7XVN/8j5
        A34s4SUdSS6p1b4+XB891h7efT3vclYN1wMXKRcKlPhZRclZmdq9vhA5ddyEKBivywx8BOLCnWkDX
        2MC2funK7VfUB+l2rgdpJznWUqWGzmsbQaed86nL7FvfnIhw9+G3GmfEMCzVVMH5A9zvb1hrSeLcs
        /EEviwPpPa6lNUXlKrHDomSgFOume4Fs7fgfOK5DHksg3F7MlyRVhdERvv7CUlWQxAa0fYOAD6gF8
        tW66y02ZQ==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHTL1-0002LK-GM; Tue, 30 Oct 2018 12:42:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFE9F2029FA14; Tue, 30 Oct 2018 13:41:04 +0100 (CET)
Date:   Tue, 30 Oct 2018 13:41:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, Dietmar.Eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: Re: [PATCH v2 1/2] sched/fair: Cleanup load_balance() condition
Message-ID: <20181030124104.GC8177@hirez.programming.kicks-ass.net>
References: <1537974727-30788-1-git-send-email-valentin.schneider@arm.com>
 <8e3c7f04-0d1e-cbe7-4762-b2b5cd42c79b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3c7f04-0d1e-cbe7-4762-b2b5cd42c79b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:27:59AM +0000, Valentin Schneider wrote:
> Hi,
> 
> On 26/09/2018 16:12, Valentin Schneider wrote:
> > The alignment of the condition is off, clean that up.
> > 
> > Also, logical operators have lower precedence than bitwise/relational
> > operators, so remove one layer of parentheses to make the condition a
> > bit simpler to follow.
> > 
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  kernel/sched/fair.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6bd142d..9cf93ba 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8783,9 +8783,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >  
> >  out_one_pinned:
> >  	/* tune up the balancing interval */
> > -	if (((env.flags & LBF_ALL_PINNED) &&
> > -			sd->balance_interval < MAX_PINNED_INTERVAL) ||
> > -			(sd->balance_interval < sd->max_interval))
> > +	if ((env.flags & LBF_ALL_PINNED &&
> > +	     sd->balance_interval < MAX_PINNED_INTERVAL) ||
> > +	    sd->balance_interval < sd->max_interval)
> >  		sd->balance_interval *= 2;
> >  
> >  	ld_moved = 0;
> > 
> 
> Is there anything else that should be done for these two patches?

Have them now, Thanks!
