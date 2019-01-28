Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77721C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAE020882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otleQ1A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1H60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:58:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1H60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7r9E0IwFmAxafMEm6jBlGBh+iwlxki8AIqdvHFejtxI=; b=otleQ1A7Z0l7t3MO1vi/B1S/i
        TemFMcSGHVguaimwoyp9iGYzczNbL9swGhCdBJaYVrEGvHXPGSW70ywg9jSdkdKPw3MComhD9xGYj
        7kSoTsTplfA9XdY1sCyhVMTTVZOp42tvR7OVmHuIyx8hDBcntjKSqFDu6ejxsmVeXpa5tdXr1yxPp
        iiG+m3Z77PCQOYHkqDaP9REvF7efd1O0RPSRfnSaIJ032P9amjgK+oCLOxhLNOstC4h1ZrBREFNLy
        dHUoNPeqMJfQkNUAOPK5tr5pNmPOdeJrUMIklRx45RySp4jQbbLx1fyC4Pn4Sb14cnv8dWSEbZ1LP
        NxLz/6/oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go1oB-0006pN-VD; Mon, 28 Jan 2019 07:58:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17F50200FC6C6; Mon, 28 Jan 2019 08:58:17 +0100 (CET)
Date:   Mon, 28 Jan 2019 08:58:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@kernel.org, kjlu@umn.edu, hpa@zytor.com,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Fix a potential double-fetch bug in
 sched_copy_attr()
Message-ID: <20190128075817.GE4500@hirez.programming.kicks-ass.net>
References: <20190109074524.10176-1-kjlu@umn.edu>
 <tip-120e4e76857ddbc9268e1aa3f9de61a498e84618@git.kernel.org>
 <alpine.DEB.2.21.1901271201170.1622@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901271201170.1622@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 12:04:44PM +0100, Thomas Gleixner wrote:
> On Mon, 21 Jan 2019, tip-bot for Kangjie Lu wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a674c7db2f29..d4d3514c4fe9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4499,6 +4499,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
> >  	if (ret)
> >  		return -EFAULT;
> >  
> > +	/* In case attr->size was changed by user-space: */
> > +	attr->size = size;
> > +
> 
> Just when pondering to send that to Linus, I tried to write up a concise
> summary for this which made me look at the patch.
> 
> If the size changed, then its clear that user space fiddled with the date
> between the size fetch and the full copy from user. So why restoring the
> size instead of doing the obvious:
> 
>    	 if (attr->size != size)
> 	 	return -ECRAP;
> 
> Hmm?

Sure; but if we do that we should also change perf_copy_attr() which has
the exact same thing.
